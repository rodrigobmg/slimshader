//
// Generated by Microsoft (R) HLSL Shader Compiler 9.30.9200.16384
//
//
///
// Buffer Definitions: 
//
// cbuffer cbSimulationConstants
// {
//
//   uint g_iNumParticles;              // Offset:    0 Size:     4
//   float g_fTimeStep;                 // Offset:    4 Size:     4 [unused]
//   float g_fSmoothlen;                // Offset:    8 Size:     4
//   float g_fPressureStiffness;        // Offset:   12 Size:     4 [unused]
//   float g_fRestDensity;              // Offset:   16 Size:     4 [unused]
//   float g_fDensityCoef;              // Offset:   20 Size:     4
//   float g_fGradPressureCoef;         // Offset:   24 Size:     4 [unused]
//   float g_fLapViscosityCoef;         // Offset:   28 Size:     4 [unused]
//   float g_fWallStiffness;            // Offset:   32 Size:     4 [unused]
//   float4 g_vGravity;                 // Offset:   48 Size:    16 [unused]
//   float4 g_vGridDim;                 // Offset:   64 Size:    16 [unused]
//   float3 g_vPlanes[4];               // Offset:   80 Size:    60 [unused]
//
// }
//
// Resource bind info for ParticlesRO
// {
//
//   struct Particle
//   {
//       
//       float2 position;               // Offset:    0
//       float2 velocity;               // Offset:    8
//
//   } $Element;                        // Offset:    0 Size:    16
//
// }
//
// Resource bind info for ParticlesDensityRW
// {
//
//   struct ParticleDensity
//   {
//       
//       float density;                 // Offset:    0
//
//   } $Element;                        // Offset:    0 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim Slot Elements
// ------------------------------ ---------- ------- ----------- ---- --------
// ParticlesRO                       texture  struct         r/o    0        1
// ParticlesDensityRW                    UAV  struct         r/w    0        1
// cbSimulationConstants             cbuffer      NA          NA    0        1
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Input
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Output
cs_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer cb0[2], immediateIndexed
dcl_resource_structured t0, 16 
dcl_uav_structured u0, 4
dcl_input vThreadIDInGroupFlattened
dcl_input vThreadID.x
dcl_temps 3
dcl_tgsm_structured g0, 8, 256
dcl_thread_group 256, 1, 1
mul r0.x, cb0[0].z, cb0[0].z
ld_structured_indexable(structured_buffer, stride=16)(mixed,mixed,mixed,mixed) r0.yz, vThreadID.x, l(0), t0.xxyx
mov r0.w, l(0)
mov r1.x, l(0)
loop 
  uge r1.y, r1.x, cb0[0].x
  breakc_nz r1.y
  iadd r1.y, r1.x, vThreadIDInGroupFlattened.x
  ld_structured_indexable(structured_buffer, stride=16)(mixed,mixed,mixed,mixed) r1.yz, r1.y, l(0), t0.xxyx
  store_structured g0.xy, vThreadIDInGroupFlattened.x, l(0), r1.yzyy
  sync_g_t
  mov r1.y, r0.w
  mov r1.z, l(0)
  loop 
    uge r1.w, r1.z, l(256)
    breakc_nz r1.w
    ld_structured r2.xy, r1.z, l(0), g0.xyxx
    add r2.xy, -r0.yzyy, r2.xyxx
    dp2 r1.w, r2.xyxx, r2.xyxx
    lt r2.x, r1.w, r0.x
    mad r1.w, cb0[0].z, cb0[0].z, -r1.w
    mul r2.y, r1.w, r1.w
    mul r2.y, r2.y, cb0[1].y
    mad r1.w, r2.y, r1.w, r1.y
    movc r1.y, r2.x, r1.w, r1.y
    iadd r1.z, r1.z, l(1)
  endloop 
  mov r0.w, r1.y
  sync_g_t
  iadd r1.x, r1.x, l(256)
endloop 
store_structured u0.x, vThreadID.x, l(0), r0.w
ret 
// Approximately 33 instruction slots used