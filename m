Return-Path: <netdev+bounces-17008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0A74FC93
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422262818A1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187B37A;
	Wed, 12 Jul 2023 01:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1281362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:20:11 +0000 (UTC)
Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF501733
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689124799; bh=rcq0InmKcyULlriFUZLw+JGpoYoBhP/OlMqv9agJSYE=; h=From:Subject:Date:Cc:To:References:From:Subject:Reply-To; b=EurrKc0/YuSjcrT2f14LGELcoSTHPd6GhbiX7oUj0GgeRjZJU8OslgMuIZCRYuZFUpEYO0YZB7KKvT9L00hRxLC+K38+egliRcBDbaumLlCOipvStpWm+Qj7lzK8ftSWJh+Q/uC9shrAA1rNgsEqjN4MhsczAMbHN2TVDc7VdpBweqbRvZrgLI5lFPVj+FGrk0aleDoXpo4pD0hHGv1FQsIV7B5Qn3UJWSE2rbmCcBgcULIRNtwH0ciU+OR/mYvvGc9b8NITGOsOV/253H6UQeJHiTkyGqbwFI0B6G3PU8qnSWGZVz0nZ2CY9zo70MqMEuZBfQzL2tzxR4GXCP2c7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689124799; bh=QMSHDLB73BP952Z91XlUgbdkwDn/ei+SqGir6MyAHBP=; h=X-Sonic-MF:From:Subject:Date:To:From:Subject; b=PbndfQvuMsBK+CBiDJXmjcZZdI8sKOLdk3Gt6eJndRDadBqx8e9j9GcGO1m2NqQIoIvn2jkdkQhQAnufvcG08lzmD+aVTHCwC//COAN00kfFEvoEWGAgSuVGl671cDprYcVqoOBfGimGJTRsdyBlcuXCzp9VK+AorcmTZKSZHyhxe5AnorqnpaLteUju9qOPeKkN5WGWdQ5nrTAipHuC9bFx6ftqDT+I4fbUxU6kTc/3NfLpJU+ygxUsMqcl10rcAbtpQSNy5P3xLhMu529qFt9VTMFZbIwr2hk8EDKspKeW/mQzJQi9G9xijCOaCJbfDrUHHn3Q6uLVJrV+1CMWDw==
X-YMail-OSG: idEAjk4VM1k5cwYSq8KKMeesPXqfMlaD8cD8Yc2YU_p7_zTEtfZNPqE0XFts3qU
 Rc8Qgd7xZiMZStEuFq0q2VSqUS0QKZpmnXkAhITQI2C14xIbOxle1vjROO1L2qdOSBhCcqEbzZLn
 GT1bOpKUCnTwdxm6qN8hTSxDPdEmTuDIryiozN58IuHHWf0cVjC1IDqIEUpxxN3ix5BEeELNzly2
 UyM4FDLeS6EKWa1QVYwSL4YTKW80g0iO20C3W9o_GXH4q4Kwc4KA8X2f4yfPLtD1LZozJlU3_hr4
 qVEX5PvlZJPaRXN0fLZySZKehct9ws8gJSFAssQK6yGlkcbZqvnSR0cQygcSAL7m5RrEiZ7GNrb3
 _SYunE.sa17gcLtqZc.Dwh4QwSrjlm.POy.aHEXIQsk8yoSwrYzZLusuTu3KmE9vqA54eZyxPv7f
 sRIGbjETlKHObFHFjjD6q16bx_ThD1ulEDoHhNoBL2P.RBQr7zOWhTjWJaQmFDH7b9jtLBfLug0O
 uR8AG8Pcw6wSlBnOoz57pFlrbdzuusrzeZnvhlSltLt75VjpA55SnSwlm7_yDFycd8ZHER9VR2Fx
 egEWRpV7PSI.FUFeEIxp19r7gxHwzDeK.tH9d9p.952pSSwp.R1EVxJtXBROLY9l1_PQZK4064OV
 BJOxXpy6IyqVVmM.Gcioyb7X96bLf4pkPJNjdz4pS.YQW8Y6ILmos4soiJAxf1qw.Rhm8uphLjlB
 UsEUEE1jymN5wWN066b7YJpAf0kbvDkynh8.IG_7JnyRP8lDl5GG7YvATxaJrLV1Q7e6HpiQbtJu
 GuXNO7XDZja8V7y..KrZlhmKM.7CjjevPNNnwRHgJKUnnQJqyBipwP_PHGxeqFC1DK24SOSVcbQ2
 XsUF7wN0c2_Kq9F4ETQepiZJrqGFP6DTEHYjiU.xzI3z6UmY6DQgNGwhRFLJGoLvuSwcB.XDoGgL
 0rYxS.GzOIn5YgE3BjPyaGqB2h_jE4dQd6VCSJQNI.dG745Hut7YVV2fuZP4wXMetMYPdnQXTQYF
 1kRw5SbXq5b6z7hzSwGS1GvDK1ieWmRA2eQjQlExVdgpzLBSl6Y4Vf0MQulAAXwnkVW0AMXYSpFD
 r4niwUtAZpEgYOQuitiKq7OucszO_EcvCSceoYs_l4SJCn3J1dTyqk4Q3SiaCE4j6SwyH.S1PG2r
 5mmXw_zIV3XJh5PO6YL_aS4HzRuFb3DnFncwNfxBCy05bIbH7oVG8inglV1ZCg6nvQgpqcYgE3Tn
 g3JxPEDMiDAtxEywCs15rZ9DqsJ6OmgsQxNPfkRley9Pa58hPfxSoVtCKYLgnpSLTo6AJU8z_nKo
 Wxx1o1PLNU2GqPoVgiGLaVKh4MuCgz7f5o54PTvw_rndS6TA668CUlj3sxEl90DOsZKU__UDlxYD
 wv_Ldxl4NMKKdV0OJ.HOpPGWm3U7HOjg.fWhqXKcx0pYVWk9ebqIbEASYkuRJTyecoEOIrPEzdza
 rW2AGLr6c4AnBBhj9fBOtNGo1Ubwd0rL1tEsgttWILNMUQcqbyZ8AKsgyuYEV7yH2z9b_RM9EGjf
 _w9C7a9ydOG6Qmq9fung.ahEqooVgGx.ZpQ.0IMqRxpHg_XpmjTnfohmAlaq2Lb9OAUkpbeGrv3O
 7ddwTyYXrcVz31s2oLdlia3ZtFnSO7Rd967A_BsHIYYmxF1izKMA9fkzFYdu_JLnOPnQdtFK1pA9
 R493_BtQEaFv3oEZhyV3fp0.s2a1W33b8amoxY4FC0atOp0GqEGk67xklHrWnNTssuy1VC6gEZgu
 qZEXrqKDUURKo_QHEI2iwhyW671NAucdK4SXFlOXWuRYxzvffI.SCWiqqOntnDA8AziqKglRw5L4
 2f_vnA22Af17frVQgYBx0kkfMugxsDZs7j8MIkhCiXefmZYpPQaPb4EeTkRDgN5ZKDkm3lWIhL07
 dTOmcmENDjpWQV4G_Uc4ghwctQlc_YGzTkYxz_penS.zCw1fOWkhlh7zsF.HJNuruJRbNUwTLIUm
 sWTKQ27WUT1ul5OM_ftnjL9AFsmMM.eyRf.Ned5juJcGcm2Z1C8wqCTa4doxq10x98wxoMbhCNlL
 4Y8_AoNjfL.nwNAhxocEiDKB2HR5rTppFYMbflfKmR9YonJeOVoNkMq1t.iJPUmKFp7kkKqjwlvx
 aax0hTatBOZlQroJvHRh2QEAWZMzxg6.swt8b_CL88jGHkpVctKesGRIH4xuw.ZTVZDa2p9fUXlG
 YbN5jr6zFJq8Iz1aN364W5O0igQyq7QBW5gA-
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 77f2e939-62aa-4908-a742-2d312f6c22d0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 12 Jul 2023 01:19:59 +0000
Received: by hermes--production-ne1-6d679867d5-nhrqn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a4228b3efed96927a9d0578dfec56238;
          Wed, 12 Jul 2023 01:19:55 +0000 (UTC)
From: Astra Joan <astrajoan@yahoo.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_A7A721A2-6107-46CE-9A0C-0DBF80868EE4"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock
 to rwlock
Message-Id: <8A7EE4B2-4DCE-40FF-B971-F67F402872BB@yahoo.com>
Date: Thu, 6 Jul 2023 21:39:04 -0700
Cc: Astra Joan <astrajoan@yahoo.com>,
 davem@davemloft.net,
 edumazet@google.com,
 ivan.orlov0322@gmail.com,
 kernel@pengutronix.de,
 kuba@kernel.org,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux@rempel-privat.de,
 mkl@pengutronix.de,
 netdev@vger.kernel.org,
 o.rempel@pengutronix.de,
 pabeni@redhat.com,
 robin@protonic.nl,
 skhan@linuxfoundation.org,
 socketcan@hartkopp.net,
 syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com,
 syzkaller@googlegroups.com
To: dvyukov@google.com
X-Mailer: Apple Mail (2.3731.600.7)
References: <8A7EE4B2-4DCE-40FF-B971-F67F402872BB.ref@yahoo.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Apple-Mail=_A7A721A2-6107-46CE-9A0C-0DBF80868EE4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi Dmitry,

Yes, I initially wanted to test my patch against this bug, but only
later realized there should be a reproducer in order to use syz test.

Also, I believe my local testing should suffice to show the patch's
ability to mitigate the deadlock bug. In particular, the attached error
log could be avoided if my patch was applied to the upstream. Could 
anyone in the mailing list review the patch given this context?

Best regards,
Ziqi


--Apple-Mail=_A7A721A2-6107-46CE-9A0C-0DBF80868EE4
Content-Disposition: attachment;
	filename=decode_netdevice.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="decode_netdevice.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000][    T0] Linux version 6.4.0-rc6-00195-g40f71e7cd3c6 =
(astrajoan@Astras-Ubuntu) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0, =
GNU ld (GNU Binutils for Ubuntu) 2.38) #4 SMP PREEMPT_DYNAMIC Sun Jun 18 =
18:30:59 PDT 2023
[    0.000000][    T0] Command line: root=3D/dev/sda1 console=3DttyS0 =
earlyprintk=3Dserial
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 =
floating point registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE =
registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX =
registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x200: =
'Protection Keys User registers'
[    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: =
 256
[    0.000000][    T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]: =
   8
[    0.000000][    T0] x86/fpu: Enabled xstate features 0x207, context =
size is 840 bytes, using 'compacted' format.
[    0.000000][    T0] signal: max sigframe size: 3376
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem =
0x0000000000000000-0x000000000009fbff] usable
[    0.000000][    T0] BIOS-e820: [mem =
0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000][    T0] BIOS-e820: [mem =
0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000][    T0] BIOS-e820: [mem =
0x0000000000100000-0x00000000bffdcfff] usable
[    0.000000][    T0] BIOS-e820: [mem =
0x00000000bffdd000-0x00000000bfffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem =
0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem =
0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem =
0x0000000100000000-0x000000043fffffff] usable
[    0.000000][    T0] printk: bootconsole [earlyser0] enabled
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] =
**********************************************************
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE =
NOTICE   **
[    0.000000][    T0] **                                                =
      **
[    0.000000][    T0] ** This system shows unhashed kernel memory =
addresses   **
[    0.000000][    T0] ** via the console, logs, and other interfaces. =
This    **
[    0.000000][    T0] ** might reduce the security of your system.      =
      **
[    0.000000][    T0] **                                                =
      **
[    0.000000][    T0] ** If you see this message and you are not =
debugging    **
[    0.000000][    T0] ** the kernel, report this immediately to your =
system   **
[    0.000000][    T0] ** administrator!                                 =
      **
[    0.000000][    T0] **                                                =
      **
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE =
NOTICE   **
[    0.000000][    T0] =
**********************************************************
[    0.000000][    T0] Malformed early option 'vsyscall'
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.15.0-1 04/01/2014
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001][    T0] kvm-clock: using sched offset of 695362314 cycles
[    0.000340][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff =
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001346][    T0] tsc: Detected 3399.998 MHz processor
[    0.004987][    T0] e820: update [mem 0x00000000-0x00000fff] usable =
=3D=3D> reserved
[    0.005001][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.005013][    T0] last_pfn =3D 0x440000 max_arch_pfn =3D =
0x400000000
[    0.005402][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  =
WP  UC- WT
[    0.005859][    T0] last_pfn =3D 0xbffdd max_arch_pfn =3D 0x400000000
[    0.008224][    T0] found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
[    0.008611][    T0] Using GB pages for direct mapping
[    0.009506][    T0] ACPI: Early table checksum verification disabled
[    0.009878][    T0] ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
[    0.010263][    T0] ACPI: RSDT 0x00000000BFFE1E8C 000034 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.010784][    T0] ACPI: FACP 0x00000000BFFE1CC8 000074 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.011321][    T0] ACPI: DSDT 0x00000000BFFE0040 001C88 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.011850][    T0] ACPI: FACS 0x00000000BFFE0000 000040
[    0.012163][    T0] ACPI: APIC 0x00000000BFFE1D3C 0000F0 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.012698][    T0] ACPI: HPET 0x00000000BFFE1E2C 000038 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.013234][    T0] ACPI: WAET 0x00000000BFFE1E64 000028 (v01 BOCHS  =
BXPC     00000001 BXPC 00000001)
[    0.013760][    T0] ACPI: Reserving FACP table memory at [mem =
0xbffe1cc8-0xbffe1d3b]
[    0.014204][    T0] ACPI: Reserving DSDT table memory at [mem =
0xbffe0040-0xbffe1cc7]
[    0.014644][    T0] ACPI: Reserving FACS table memory at [mem =
0xbffe0000-0xbffe003f]
[    0.015078][    T0] ACPI: Reserving APIC table memory at [mem =
0xbffe1d3c-0xbffe1e2b]
[    0.015518][    T0] ACPI: Reserving HPET table memory at [mem =
0xbffe1e2c-0xbffe1e63]
[    0.015959][    T0] ACPI: Reserving WAET table memory at [mem =
0xbffe1e64-0xbffe1e8b]
[    0.016873][    T0] No NUMA configuration found
[    0.017138][    T0] Faking a node at [mem =
0x0000000000000000-0x000000043fffffff]
[    0.017557][    T0] Faking node 0 at [mem =
0x0000000000000000-0x000000023fffffff] (9216MB)
[    0.018026][    T0] Faking node 1 at [mem =
0x0000000240000000-0x000000043fffffff] (8192MB)
[    0.018723][    T0] NUMA: Initialized distance table, cnt=3D2
[    0.018731][    T0] NODE_DATA(0) allocated [mem =
0x23fffa000-0x23fffffff]
[    0.019232][    T0] NODE_DATA(1) allocated [mem =
0x43fff7000-0x43fffcfff]
[    0.038441][    T0] Zone ranges:
[    0.038651][    T0]   DMA      [mem =
0x0000000000001000-0x0000000000ffffff]
[    0.039049][    T0]   DMA32    [mem =
0x0000000001000000-0x00000000ffffffff]
[    0.039445][    T0]   Normal   [mem =
0x0000000100000000-0x000000043fffffff]
[    0.039833][    T0]   Device   empty
[    0.040042][    T0] Movable zone start for each node
[    0.040326][    T0] Early memory node ranges
[    0.040568][    T0]   node   0: [mem =
0x0000000000001000-0x000000000009efff]
[    0.040965][    T0]   node   0: [mem =
0x0000000000100000-0x00000000bffdcfff]
[    0.041370][    T0]   node   0: [mem =
0x0000000100000000-0x000000023fffffff]
[    0.041769][    T0]   node   1: [mem =
0x0000000240000000-0x000000043fffffff]
[    0.042178][    T0] Initmem setup node 0 [mem =
0x0000000000001000-0x000000023fffffff]
[    0.042626][    T0] Initmem setup node 1 [mem =
0x0000000240000000-0x000000043fffffff]
[    0.043065][    T0] On node 0, zone DMA: 1 pages in unavailable =
ranges
[    0.043174][    T0] On node 0, zone DMA: 97 pages in unavailable =
ranges
[    0.098558][    T0] On node 0, zone Normal: 35 pages in unavailable =
ranges
[    0.306063][    T0] kasan: KernelAddressSanitizer initialized
[    0.306904][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.307190][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 8/0x8 ignored.
[    0.307687][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 9/0x9 ignored.
[    0.308173][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 10/0xa ignored.
[    0.308678][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 11/0xb ignored.
[    0.309183][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 12/0xc ignored.
[    0.309671][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 13/0xd ignored.
[    0.310180][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 14/0xe ignored.
[    0.310674][    T0] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 15/0xf ignored.
[    0.311171][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.311575][    T0] IOAPIC[0]: apic_id 0, version 17, address =
0xfec00000, GSI 0-23
[    0.312020][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 =
dfl dfl)
[    0.312444][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 =
high level)
[    0.312871][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 =
high level)
[    0.313299][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 =
high level)
[    0.313731][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 =
high level)
[    0.314186][    T0] ACPI: Using ACPI (MADT) for SMP configuration =
information
[    0.314610][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.314968][    T0] TSC deadline timer available
[    0.315247][    T0] smpboot: 16 Processors exceeds NR_CPUS limit of 8
[    0.315619][    T0] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.315972][    T0] kvm-guest: KVM setup pv remote TLB flush
[    0.316314][    T0] kvm-guest: setup PV sched yield
[    0.316639][    T0] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.317129][    T0] PM: hibernation: Registered nosave memory: [mem =
0x0009f000-0x0009ffff]
[    0.317606][    T0] PM: hibernation: Registered nosave memory: [mem =
0x000a0000-0x000effff]
[    0.318102][    T0] PM: hibernation: Registered nosave memory: [mem =
0x000f0000-0x000fffff]
[    0.318582][    T0] PM: hibernation: Registered nosave memory: [mem =
0xbffdd000-0xbfffffff]
[    0.319065][    T0] PM: hibernation: Registered nosave memory: [mem =
0xc0000000-0xfeffbfff]
[    0.319551][    T0] PM: hibernation: Registered nosave memory: [mem =
0xfeffc000-0xfeffffff]
[    0.320036][    T0] PM: hibernation: Registered nosave memory: [mem =
0xff000000-0xfffbffff]
[    0.320515][    T0] PM: hibernation: Registered nosave memory: [mem =
0xfffc0000-0xffffffff]
[    0.320994][    T0] [mem 0xc0000000-0xfeffbfff] available for PCI =
devices
[    0.321391][    T0] Booting paravirtualized kernel on KVM
[    0.321719][    T0] clocksource: refined-jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.349733][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 =
nr_cpu_ids:8 nr_node_ids:2
[    0.350557][    T0] percpu: Embedded 72 pages/cpu s254856 r8192 =
d31864 u524288
[    0.350980][    T0] pcpu-alloc: s254856 r8192 d31864 u524288 =
alloc=3D1*2097152
[    0.350990][    T0] pcpu-alloc: [0] 0 2 4 6 [1] 1 3 5 7
[    0.351076][    T0] kvm-guest: PV spinlocks enabled
[    0.351371][    T0] PV qspinlock hash table entries: 256 (order: 0, =
4096 bytes, linear)
[    0.351848][    T0] Kernel command line: earlyprintk=3Dserial =
net.ifnames=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 =
ima_policy=3Dtcb nf-conntrack-ftp.ports=3D20000 =
nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 =
nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 =
binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 =
rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_pointers page_owner=3Don =
sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4 =
secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 =
msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sda =
console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 =
spec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D16 =
vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D16 =
rose.rose_ndevs=3D16 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 =
workqueue.watchdog_thresh=3D140 =
sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=3D8 =
panic_on_warn=3D1 root=3D/dev/sda1 console=3DttyS0 earlyprintk=3Dserial
[    0.359011][    T0] Unknown kernel command line parameters =
"spec_store_bypass_disable=3Dprctl", will be passed to user space.
[    0.359736][    T0] random: crng init done
[    0.360251][    T0] Fallback order for Node 0: 0 1
[    0.360258][    T0] Fallback order for Node 1: 1 0
[    0.360265][    T0] Built 2 zonelists, mobility grouping on.  Total =
pages: 4128477
[    0.361305][    T0] Policy zone: Normal
[    0.361685][    T0] mem auto-init: stack:off, heap alloc:on, heap =
free:off
[    0.362111][    T0] stackdepot: allocating hash table via =
alloc_large_system_hash
[    0.363130][    T0] stackdepot hash table entries: 1048576 (order: =
11, 8388608 bytes, linear)
[    0.363644][    T0] software IO TLB: area num 8.
[    0.897158][    T0] Memory: 14021472K/16776684K available (151552K =
kernel code, 36659K rwdata, 31504K rodata, 3296K init, 34532K bss, =
2754956K reserved, 0K cma-reserved)
[    0.898599][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, =
CPUs=3D8, Nodes=3D2
[    0.969878][    T0] allocated 301989888 bytes of page_ext
[    0.970211][    T0] Node 0, zone      DMA: page owner found early =
allocated 0 pages
[    0.972566][    T0] Node 0, zone    DMA32: page owner found early =
allocated 0 pages
[    0.993428][    T0] Node 0, zone   Normal: page owner found early =
allocated 36961 pages
[    1.002600][    T0] Node 1, zone   Normal: page owner found early =
allocated 36867 pages
[    1.003453][    T0] Dynamic Preempt: full
[    1.003996][    T0] Running RCU self tests
[    1.004243][    T0] Running RCU synchronous self tests
[    1.004573][    T0] rcu: Preemptible hierarchical RCU implementation.
[    1.004960][    T0] rcu: 	RCU lockdep checking is enabled.
[    1.005287][    T0] rcu: 	RCU callback double-/use-after-free =
debug is enabled.
[    1.005720][    T0] rcu: 	RCU debug extended QS entry/exit.
[    1.006050][    T0] 	All grace periods are expedited (rcu_expedited).
[    1.006427][    T0] 	Trampoline variant of Tasks RCU enabled.
[    1.006758][    T0] 	Tracing variant of Tasks RCU enabled.
[    1.007086][    T0] rcu: RCU calculated value of scheduler-enlistment =
delay is 10 jiffies.
[    1.007608][    T0] Running RCU synchronous self tests
[    1.030641][    T0] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: =
16
[    1.031327][    T0] rcu: srcu_init: Setting srcu_struct sizes based =
on contention.
[    1.031925][    T0] kfence: initialized - using 2097152 bytes for 255 =
objects at 0xffff888437a00000-0xffff888437c00000
[    1.035427][    T0] Console: colour VGA+ 80x25
[    1.035736][    T0] printk: console [ttyS0] enabled
[    1.036315][    T0] printk: bootconsole [earlyser0] disabled
[    1.037012][    T0] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
[    1.037510][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.037806][    T0] ... MAX_LOCK_DEPTH:          48
[    1.038108][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    1.038410][    T0] ... CLASSHASH_SIZE:          4096
[    1.038720][    T0] ... MAX_LOCKDEP_ENTRIES:     131072
[    1.039035][    T0] ... MAX_LOCKDEP_CHAINS:      262144
[    1.039349][    T0] ... CHAINHASH_SIZE:          131072
[    1.039659][    T0]  memory used by lock dependency info: 20657 kB
[    1.040031][    T0]  memory used for stack traces: 8320 kB
[    1.040362][    T0]  per task-struct memory footprint: 1920 bytes
[    1.040786][    T0] mempolicy: Enabling automatic NUMA balancing. =
Configure with numa_balancing=3D or the kernel.numa_balancing sysctl
[    1.041514][    T0] ACPI: Core revision 20230331
[    1.042035][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 19112604467 ns
[    1.042745][    T0] APIC: Switch to symmetric I/O mode setup
[    1.043201][    T0] x2apic enabled
[    1.043514][    T0] Switched APIC routing to physical x2apic.
[    1.043852][    T0] kvm-guest: setup PV IPIs
[    1.044886][    T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 =
apic2=3D-1 pin2=3D-1
[    1.045364][    T0] tsc: Marking TSC unstable due to TSCs =
unsynchronized
[    1.045812][    T0] Calibrating delay loop (skipped) preset value.. =
6799.99 BogoMIPS (lpj=3D33999980)
[    1.046435][    T0] pid_max: default: 32768 minimum: 301
[    1.046927][    T0] LSM: initializing =
lsm=3Dlockdown,capability,landlock,yama,safesetid,tomoyo,apparmor,bpf,inte=
grity
[    1.047673][    T0] landlock: Up and running.
[    1.047970][    T0] Yama: becoming mindful.
[    1.048293][    T0] TOMOYO Linux initialized
[    1.048676][    T0] AppArmor: AppArmor initialized
[    1.049005][    T0] LSM support for eBPF active
[    1.052077][    T0] Dentry cache hash table entries: 2097152 (order: =
12, 16777216 bytes, vmalloc hugepage)
[    1.057206][    T0] Inode-cache hash table entries: 1048576 (order: =
11, 8388608 bytes, vmalloc hugepage)
[    1.058031][    T0] Mount-cache hash table entries: 32768 (order: 6, =
262144 bytes, vmalloc)
[    1.058771][    T0] Mountpoint-cache hash table entries: 32768 =
(order: 6, 262144 bytes, vmalloc)
[    1.060698][    T0] x86/cpu: User Mode Instruction Prevention (UMIP) =
activated
[    1.061349][    T0] numa_add_cpu cpu 0 node 0: mask now 0
[    1.061359][    T0] numa_add_cpu cpu 0 node 1: mask now 0
[    1.061367][    T0] Last level iTLB entries: 4KB 512, 2MB 255, 4MB =
127
[    1.061809][    T0] Last level dTLB entries: 4KB 512, 2MB 255, 4MB =
127, 1GB 0
[    1.062289][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers =
and __user pointer sanitization
[    1.062919][    T0] Spectre V2 : Kernel not compiled with retpoline; =
no mitigation available!
[    1.062922][    T0] Spectre V2 : Vulnerable
[    1.063776][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: =
Filling RSB on context switch
[    1.064368][    T0] Spectre V2 : Enabling Restricted Speculation for =
firmware calls
[    1.064889][    T0] Spectre V2 : mitigation: Enabling conditional =
Indirect Branch Prediction Barrier
[    1.065522][    T0] Speculative Store Bypass: Mitigation: Speculative =
Store Bypass disabled via prctl
[    1.072294][    T0] Freeing SMP alternatives memory: 116K
[    1.072672][    T0] Running RCU synchronous self tests
[    1.073015][    T0] Running RCU synchronous self tests
[    1.073681][    T1] smpboot: CPU0: AMD Ryzen 9 5950X 16-Core =
Processor (family: 0x19, model: 0x21, stepping: 0x0)
[    1.075592][    T1] cblist_init_generic: Setting adjustable number of =
callback queues.
[    1.075807][    T1] cblist_init_generic: Setting shift to 3 and lim =
to 1.
[    1.075807][    T1] cblist_init_generic: Setting shift to 3 and lim =
to 1.
[    1.075807][    T1] Running RCU-tasks wait API self tests
[    1.205985][    T1] Performance Events: Fam17h+ core perfctr, AMD PMU =
driver.
[    1.207107][    T1] ... version:                0
[    1.207769][    T1] ... bit width:              48
[    1.208440][    T1] ... generic registers:      6
[    1.209097][    T1] ... value mask:             0000ffffffffffff
[    1.209950][    T1] ... max period:             00007fffffffffff
[    1.210795][    T1] ... fixed-purpose events:   0
[    1.211447][    T1] ... event mask:             000000000000003f
[    1.213113][    T1] rcu: Hierarchical SRCU implementation.
[    1.213897][    T1] rcu: 	Max phase no-delay instances is 1000.
[    1.220750][    T1] smp: Bringing up secondary CPUs ...
[    1.222972][    T1] x86: Booting SMP configuration:
[    1.223677][    T1] .... node  #1, CPUs:      #1
[    0.014015][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[    0.014015][    T0] numa_add_cpu cpu 1 node 1: mask now 0-1
[    1.227055][    T1]
[    1.227407][    T1] .... node  #0, CPUs:   #2
[    0.014015][    T0] numa_add_cpu cpu 2 node 0: mask now 0-2
[    0.014015][    T0] numa_add_cpu cpu 2 node 1: mask now 0-2
[    1.228597][    T1]
[    1.228597][    T1] .... node  #1, CPUs:   #3
[    0.014015][    T0] numa_add_cpu cpu 3 node 0: mask now 0-3
[    0.014015][    T0] numa_add_cpu cpu 3 node 1: mask now 0-3
[    1.236033][    T1]
[    1.236370][    T1] .... node  #0, CPUs:   #4
[    0.014015][    T0] numa_add_cpu cpu 4 node 0: mask now 0-4
[    0.014015][    T0] numa_add_cpu cpu 4 node 1: mask now 0-4
[    1.237335][    T1]
[    1.237335][    T1] .... node  #1, CPUs:   #5
[    0.014015][    T0] numa_add_cpu cpu 5 node 0: mask now 0-5
[    0.014015][    T0] numa_add_cpu cpu 5 node 1: mask now 0-5
[    1.238496][    T1]
[    1.238496][    T1] .... node  #0, CPUs:   #6
[    0.014015][    T0] numa_add_cpu cpu 6 node 0: mask now 0-6
[    0.014015][    T0] numa_add_cpu cpu 6 node 1: mask now 0-6
[    1.245929][   T15] Callback from call_rcu_tasks_trace() invoked.
[    1.247954][    T1]
[    1.248313][    T1] .... node  #1, CPUs:   #7
[    0.014015][    T0] numa_add_cpu cpu 7 node 0: mask now 0-7
[    0.014015][    T0] numa_add_cpu cpu 7 node 1: mask now 0-7
[    1.249256][    T1] smp: Brought up 2 nodes, 8 CPUs
[    1.249256][    T1] smpboot: Max logical packages: 2
[    1.249256][    T1] smpboot: Total of 8 processors activated =
(54399.96 BogoMIPS)
[    1.257182][    T1] devtmpfs: initialized
[    1.257182][    T1] x86/mm: Memory block size: 128MB
[    1.291357][    T1] Running RCU synchronous self tests
[    1.295822][    T1] Running RCU synchronous self tests
[    1.296239][    T1] clocksource: jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.297129][    T1] futex hash table entries: 2048 (order: 6, 262144 =
bytes, vmalloc)
[    1.298621][    T1] PM: RTC time: 04:59:44, date: 2023-06-19
[    1.306209][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol =
family
[    1.309127][    T1] audit: initializing netlink subsys (disabled)
[    1.309577][   T58] audit: type=3D2000 audit(1687150785.783:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
[    1.309577][    T1] thermal_sys: Registered thermal governor =
'step_wise'
[    1.309577][    T1] thermal_sys: Registered thermal governor =
'user_space'
[    1.309577][    T1] cpuidle: using governor menu
[    1.309577][    T1] NET: Registered PF_QIPCRTR protocol family
[    1.317238][    T1] dca service started, version 1.12.1
[    1.317661][    T1] PCI: Using configuration type 1 for base access
[    1.318087][    T1] PCI: Using configuration type 1 for extended =
access
[    1.321999][    T1] HugeTLB: registered 1.00 GiB page size, =
pre-allocated 0 pages
[    1.321999][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a =
1.00 GiB page
[    1.325820][    T1] HugeTLB: registered 2.00 MiB page size, =
pre-allocated 0 pages
[    1.326322][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 =
MiB page
[    1.328349][    T1] cryptd: max_cpu_qlen set to 1000
[    1.328349][    T1] raid6: skipped pq benchmark and selected avx2x4
[    1.328349][    T1] raid6: using avx2x2 recovery algorithm
[    1.328349][    T1] ACPI: Added _OSI(Module Device)
[    1.328349][    T1] ACPI: Added _OSI(Processor Device)
[    1.328349][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.328349][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    1.352358][    T1] ACPI: 1 ACPI AML tables successfully acquired and =
loaded
[    1.398614][    T1] ACPI: Interpreter enabled
[    1.399063][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    1.399423][    T1] ACPI: Using IOAPIC for interrupt routing
[    1.399885][    T1] PCI: Using host bridge windows from ACPI; if =
necessary, use "pci=3Dnocrs" and report a bug
[    1.400563][    T1] PCI: Using E820 reservations for host bridge =
windows
[    1.402038][    T1] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.426777][   T14] Callback from call_rcu_tasks() invoked.
[    1.443940][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus =
00-ff])
[    1.445835][    T1] acpi PNP0A03:00: _OSC: OS supports =
[ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.447465][    T1] PCI host bridge to bus 0000:00
[    1.447809][    T1] pci_bus 0000:00: Unknown NUMA node; performance =
will be reduced
[    1.448351][    T1] pci_bus 0000:00: root bus resource [io  =
0x0000-0x0cf7 window]
[    1.448875][    T1] pci_bus 0000:00: root bus resource [io  =
0x0d00-0xffff window]
[    1.449407][    T1] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000bffff window]
[    1.449974][    T1] pci_bus 0000:00: root bus resource [mem =
0xc0000000-0xfebfffff window]
[    1.450554][    T1] pci_bus 0000:00: root bus resource [mem =
0x440000000-0x4bfffffff window]
[    1.451143][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.451780][    T1] pci 0000:00:00.0: [8086:1237] type 00 class =
0x060000
[    1.460597][    T1] pci 0000:00:01.0: [8086:7000] type 00 class =
0x060100
[    1.461965][    T1] pci 0000:00:01.1: [8086:7010] type 00 class =
0x010180
[    1.463406][    T1] pci 0000:00:01.1: reg 0x20: [io  0xc080-0xc08f]
[    1.466217][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io =
 0x01f0-0x01f7]
[    1.466782][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io =
 0x03f6]
[    1.467297][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io =
 0x0170-0x0177]
[    1.467845][    T1] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io =
 0x0376]
[    1.468661][    T1] pci 0000:00:01.3: [8086:7113] type 00 class =
0x068000
[    1.469393][    T1] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] =
claimed by PIIX4 ACPI
[    1.469951][    T1] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] =
claimed by PIIX4 SMB
[    1.470817][    T1] pci 0000:00:02.0: [1234:1111] type 00 class =
0x030000
[    1.472010][    T1] pci 0000:00:02.0: reg 0x10: [mem =
0xfd000000-0xfdffffff pref]
[    1.473632][    T1] pci 0000:00:02.0: reg 0x18: [mem =
0xfebb0000-0xfebb0fff]
[    1.478559][    T1] pci 0000:00:02.0: reg 0x30: [mem =
0xfeba0000-0xfebaffff pref]
[    1.479171][    T1] pci 0000:00:02.0: Video device with shadowed ROM =
at [mem 0x000c0000-0x000dffff]
[    1.487710][    T1] pci 0000:00:03.0: [8086:100e] type 00 class =
0x020000
[    1.488694][    T1] pci 0000:00:03.0: reg 0x10: [mem =
0xfeb80000-0xfeb9ffff]
[    1.489628][    T1] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.491993][    T1] pci 0000:00:03.0: reg 0x30: [mem =
0xfeb00000-0xfeb7ffff pref]
[    1.500417][    T1] pci 0000:00:04.0: [1af4:1004] type 00 class =
0x010000
[    1.501574][    T1] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    1.503225][    T1] pci 0000:00:04.0: reg 0x14: [mem =
0xfebb1000-0xfebb1fff]
[    1.508527][    T1] pci 0000:00:04.0: reg 0x20: [mem =
0xfe000000-0xfe003fff 64bit pref]
[    1.521433][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ =
10
[    1.522743][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ =
10
[    1.524003][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ =
11
[    1.526594][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ =
11
[    1.527403][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ =
9
[    1.532902][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 16/0x8 ignored.
[    1.533527][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.536698][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 17/0x9 ignored.
[    1.536698][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.537770][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 18/0xa ignored.
[    1.538379][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.539695][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 19/0xb ignored.
[    1.540296][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.541609][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 20/0xc ignored.
[    1.542226][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.546262][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 21/0xd ignored.
[    1.546864][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.548202][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 22/0xe ignored.
[    1.548822][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.550134][    T1] APIC: NR_CPUS/possible_cpus limit of 8 reached. =
Processor 23/0xf ignored.
[    1.550744][    T1] ACPI: Unable to map lapic to logical cpu number
[    1.551856][    T1] iommu: Default domain type: Translated
[    1.551856][    T1] iommu: DMA domain TLB invalidation policy: lazy =
mode
[    1.551856][    T1] SCSI subsystem initialized
[    1.555927][    T1] libata version 3.00 loaded.
[    1.556196][    T1] ACPI: bus type USB registered
[    1.556634][    T1] usbcore: registered new interface driver usbfs
[    1.557129][    T1] usbcore: registered new interface driver hub
[    1.557640][    T1] usbcore: registered new device driver usb
[    1.558474][    T1] mc: Linux media interface: v0.10
[    1.558881][    T1] videodev: Linux video capture interface: v2.00
[    1.559476][    T1] pps_core: LinuxPPS API ver. 1 registered
[    1.559881][    T1] pps_core: Software ver. 5.3.6 - Copyright =
2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.560590][    T1] PTP clock support registered
[    1.561012][    T1] EDAC MC: Ver: 3.0.0
[    1.561012][    T1] Advanced Linux Sound Architecture Driver =
Initialized.
[    1.566225][    T1] Bluetooth: Core ver 2.22
[    1.566597][    T1] NET: Registered PF_BLUETOOTH protocol family
[    1.567030][    T1] Bluetooth: HCI device and connection manager =
initialized
[    1.567532][    T1] Bluetooth: HCI socket layer initialized
[    1.567943][    T1] Bluetooth: L2CAP socket layer initialized
[    1.568377][    T1] Bluetooth: SCO socket layer initialized
[    1.568799][    T1] NET: Registered PF_ATMPVC protocol family
[    1.569210][    T1] NET: Registered PF_ATMSVC protocol family
[    1.569688][    T1] NetLabel: Initializing
[    1.569987][    T1] NetLabel:  domain hash size =3D 128
[    1.570341][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 =
CALIPSO
[    1.570888][    T1] NetLabel:  unlabeled traffic allowed by default
[    1.571507][    T1] nfc: nfc_init: NFC Core ver 0.1
[    1.571507][    T1] NET: Registered PF_NFC protocol family
[    1.571507][    T1] PCI: Using ACPI for IRQ routing
[    1.571507][    T1] PCI: pci_cache_line_size set to 64 bytes
[    1.571507][    T1] e820: reserve RAM buffer [mem =
0x0009fc00-0x0009ffff]
[    1.571507][    T1] e820: reserve RAM buffer [mem =
0xbffdd000-0xbfffffff]
[    1.571507][    T1] pci 0000:00:02.0: vgaarb: setting as boot VGA =
device
[    1.571507][    T1] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.571507][    T1] pci 0000:00:02.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    1.575821][    T1] vgaarb: loaded
[    1.578245][    T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.578661][    T1] hpet0: 3 comparators, 64-bit 100.000000 MHz =
counter
[    1.583390][    T1] clocksource: Switched to clocksource kvm-clock
[    1.584053][    T1] VFS: Disk quotas dquot_6.6.0
[    1.584053][    T1] VFS: Dquot-cache hash table entries: 512 (order =
0, 4096 bytes)
[    1.584053][    T1] FS-Cache: Loaded
[    1.584053][    T1] CacheFiles: Loaded
[    1.584053][    T1] TOMOYO: 2.6.0
[    1.584053][    T1] Mandatory Access Control activated.
[    1.584053][    T1] AppArmor: AppArmor Filesystem Enabled
[    1.584053][    T1] pnp: PnP ACPI init
[    1.584053][    T1] pnp 00:02: [dma 2]
[    1.584839][    T1] pnp: PnP ACPI: found 6 devices
[    1.601646][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: =
0xffffff, max_idle_ns: 2085701024 ns
[    1.602531][    T1] NET: Registered PF_INET protocol family
[    1.604531][    T1] IP idents hash table entries: 262144 (order: 9, =
2097152 bytes, vmalloc)
[    1.609243][    T1] tcp_listen_portaddr_hash hash table entries: 8192 =
(order: 7, 589824 bytes, vmalloc)
[    1.610238][    T1] Table-perturb hash table entries: 65536 (order: =
6, 262144 bytes, vmalloc)
[    1.611566][    T1] TCP established hash table entries: 131072 =
(order: 8, 1048576 bytes, vmalloc)
[    1.614830][    T1] TCP bind hash table entries: 65536 (order: 11, =
9437184 bytes, vmalloc hugepage)
[    1.617542][    T1] TCP: Hash tables configured (established 131072 =
bind 65536)
[    1.619440][    T1] MPTCP token hash table entries: 16384 (order: 8, =
1441792 bytes, vmalloc)
[    1.621300][    T1] UDP hash table entries: 8192 (order: 8, 1310720 =
bytes, vmalloc)
[    1.623031][    T1] UDP-Lite hash table entries: 8192 (order: 8, =
1310720 bytes, vmalloc)
[    1.624183][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.625422][    T1] RPC: Registered named UNIX socket transport =
module.
[    1.625915][    T1] RPC: Registered udp transport module.
[    1.626302][    T1] RPC: Registered tcp transport module.
[    1.626681][    T1] RPC: Registered tcp NFSv4.1 backchannel transport =
module.
[    1.628198][    T1] NET: Registered PF_XDP protocol family
[    1.628605][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 =
window]
[    1.629105][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff =
window]
[    1.629593][    T1] pci_bus 0000:00: resource 6 [mem =
0x000a0000-0x000bffff window]
[    1.630129][    T1] pci_bus 0000:00: resource 7 [mem =
0xc0000000-0xfebfffff window]
[    1.630664][    T1] pci_bus 0000:00: resource 8 [mem =
0x440000000-0x4bfffffff window]
[    1.631456][    T1] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.631924][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI =
transfers
[    1.632472][    T1] PCI: CLS 0 bytes, default 64
[    1.632847][    T1] PCI-DMA: Using software bounce buffering for IO =
(SWIOTLB)
[    1.633348][    T1] software IO TLB: mapped [mem =
0x00000000bbfdd000-0x00000000bffdd000] (64MB)
[    1.633970][    T1] ACPI: bus type thunderbolt registered
[    1.636444][   T94] kworker/u17:1 (94) used greatest stack depth: =
27984 bytes left
[    1.636492][    T1] kvm_intel: VMX not supported by CPU 0
[    1.637848][    T1] kvm_amd: TSC scaling supported
[    1.638203][    T1] kvm_amd: Nested Virtualization enabled
[    1.638593][    T1] kvm_amd: Nested Paging enabled
[    1.638957][    T1] kvm_amd: Virtual VMLOAD VMSAVE supported
[    1.639359][    T1] kvm_amd: Virtual GIF supported
[    1.639702][    T1] kvm_amd: LBR virtualization supported
[    1.658763][  T118] kworker/u17:1 (118) used greatest stack depth: =
27736 bytes left
[    1.659299][  T119] kworker/u17:1 (119) used greatest stack depth: =
27424 bytes left
[    3.538161][    T1] Initialise system trusted keyrings
[    3.540149][    T1] workingset: timestamp_bits=3D40 max_order=3D22 =
bucket_order=3D0
[    3.542108][    T1] zbud: loaded
[    3.545926][    T1] DLM installed
[    3.548051][    T1] squashfs: version 4.0 (2009/01/31) Phillip =
Lougher
[    3.551907][    T1] NFS: Registering the id_resolver key type
[    3.552570][    T1] Key type id_resolver registered
[    3.553021][    T1] Key type id_legacy registered
[    3.553515][    T1] nfs4filelayout_init: NFSv4 File Layout Driver =
Registering...
[    3.554391][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout =
Driver Registering...
[    3.558643][    T1] Key type cifs.spnego registered
[    3.559284][    T1] Key type cifs.idmap registered
[    3.560036][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    3.560690][    T1] ntfs3: Max link count 4000
[    3.561206][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    3.561809][    T1] ntfs3: Read-only LZX/Xpress compression included
[    3.562538][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    3.563165][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 =
2001-2006 Red Hat, Inc.
[    3.564687][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    3.565334][    T1] QNX4 filesystem 0.2.3 registered.
[    3.565905][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    3.566848][    T1] fuse: init (API version 7.38)
[    3.568315][    T1] orangefs_debugfs_init: called with debug mask: =
:none: :0:
[    3.569190][    T1] orangefs_init: module version upstream loaded
[    3.569807][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[    3.581811][    T1] SGI XFS with ACLs, security attributes, realtime, =
quota, no debug enabled
[    3.584495][    T1] 9p: Installing v9fs 9p2000 file system support
[    3.585321][    T1] NILFS version 2 loaded
[    3.585772][    T1] befs: version: 0.9.3
[    3.586389][    T1] ocfs2: Registered cluster interface o2cb
[    3.587315][    T1] ocfs2: Registered cluster interface user
[    3.588250][    T1] OCFS2 User DLM kernel interface loaded
[    3.593706][    T1] gfs2: GFS2 installed
[    3.598792][    T1] ceph: loaded (mds proto 32)
[    3.609570][    T1] NET: Registered PF_ALG protocol family
[    3.610966][    T1] xor: automatically using best checksumming =
function   avx
[    3.612819][    T1] async_tx: api initialized (async)
[    3.614085][    T1] Key type asymmetric registered
[    3.615270][    T1] Asymmetric key parser 'x509' registered
[    3.616622][    T1] Asymmetric key parser 'pkcs8' registered
[    3.617970][    T1] Key type pkcs7_test registered
[    3.619249][    T1] Block layer SCSI generic (bsg) driver version 0.4 =
loaded (major 240)
[    3.621653][    T1] io scheduler mq-deadline registered
[    3.622899][    T1] io scheduler kyber registered
[    3.624212][    T1] io scheduler bfq registered
[    3.628632][    T1] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    3.634420][    T1] ACPI: button: Power Button [PWRF]
[    3.637023][  T212] kworker/u17:0 (212) used greatest stack depth: =
27120 bytes left
[    3.640280][    T1] ioatdma: Intel(R) QuickData Technology Driver =
5.00
[    4.264445][    T1] ACPI: _SB_.LNKD: Enabled at IRQ 11
[    4.324425][    T1] N_HDLC line discipline registered with =
maxframe=3D4096
[    4.325199][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing =
enabled
[    4.326255][    T1] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D=
 115200) is a 16550A
[    4.330677][    T1] Non-volatile memory driver v1.3
[    4.331275][    T1] Linux agpgart interface v0.103
[    4.332704][    T1] ACPI: bus type drm_connector registered
[    4.334540][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on =
minor 0
[    4.336925][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on =
minor 1
[    4.388817][    T1] Console: switching to colour frame buffer device =
128x48
[    4.407053][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer =
device
[    4.407885][    T1] usbcore: registered new interface driver udl
[    4.408738][    T1] bochs-drm 0000:00:02.0: vgaarb: deactivate vga =
console
[    4.411280][    T1] [drm] Found bochs VGA, ID 0xb0c5.
[    4.411818][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, =
mmio @ 0xfebb0000.
[    4.413815][    T1] [drm] Found EDID data blob.
[    4.415075][    T1] [drm] Initialized bochs-drm 1.0.0 20130925 for =
0000:00:02.0 on minor 2
[    4.419397][    T1] fbcon: bochs-drmdrmfb (fb1) is primary device
[    4.419404][    T1] fbcon: Remapping primary device, fb1, to tty 1-63
[    8.282098][    T1] bochs-drm 0000:00:02.0: [drm] fb1: bochs-drmdrmfb =
frame buffer device
[    8.288808][   T16] Floppy drive(s): fd0 is 2.88M AMI BIOS
[    8.300786][    T1] brd: module loaded
[    8.314449][   T16] FDC 0 is a S82078B
[    8.323320][    T1] loop: module loaded
[    8.354164][    T1] zram: Added device: zram0
[    8.357229][    T1] null_blk: disk nullb0 created
[    8.357745][    T1] null_blk: module loaded
[    8.358254][    T1] Guest personality initialized and is inactive
[    8.359140][    T1] VMCI host device registered (name=3Dvmci, =
major=3D10, minor=3D118)
[    8.359949][    T1] Initialized host personality
[    8.360517][    T1] usbcore: registered new interface driver rtsx_usb
[    8.361380][    T1] usbcore: registered new interface driver =
viperboard
[    8.362185][    T1] usbcore: registered new interface driver dln2
[    8.362967][    T1] usbcore: registered new interface driver =
pn533_usb
[    8.364778][    T1] nfcsim 0.2 initialized
[    8.365305][    T1] usbcore: registered new interface driver port100
[    8.366088][    T1] usbcore: registered new interface driver nfcmrvl
[    8.367641][    T1] Loading iSCSI transport class v2.0-870.
[    8.372066][    T1] scsi host0: Virtio SCSI HBA
[    8.377057][    T1] st: Version 20160209, fixed bufsize 32768, s/g =
segs 256
[    8.377817][   T97] scsi 0:0:0:0: Direct-Access     QEMU     QEMU =
HARDDISK    2.5+ PQ: 0 ANSI: 5
[    8.381272][    T1] ata_piix 0000:00:01.1: version 2.13
[    8.383706][    T1] scsi host1: ata_piix
[    8.385129][    T1] scsi host2: ata_piix
[    8.385839][    T1] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma =
0xc080 irq 14
[    8.386703][    T1] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma =
0xc088 irq 15
[    8.388729][    T1] Rounding down aligned max_sectors from 4294967295 =
to 4294967288
[    8.389866][    T1] db_root: cannot open: /etc/target
[    8.390714][    T1] slram: not enough parameters.
[    8.392829][    T1] ftl_cs: FTL header not found.
[    8.399540][    T1] wireguard: WireGuard 1.0.0 loaded. See =
www.wireguard.com for information.
[    8.400508][    T1] wireguard: Copyright (C) 2015-2019 Jason A. =
Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    8.401676][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) =
and David S. Miller (davem@redhat.com)
[    8.404382][    T1] MACsec IEEE 802.1AE
[    8.406624][    T1] tun: Universal TUN/TAP device driver, 1.6
[    8.407625][    T1] vcan: Virtual CAN interface driver
[    8.408220][    T1] vxcan: Virtual CAN Tunnel driver
[    8.408805][    T1] slcan: serial line CAN interface driver
[    8.409448][    T1] CAN device driver interface
[    8.410034][    T1] usbcore: registered new interface driver usb_8dev
[    8.410821][    T1] usbcore: registered new interface driver ems_usb
[    8.411570][    T1] usbcore: registered new interface driver gs_usb
[    8.412350][    T1] usbcore: registered new interface driver =
kvaser_usb
[    8.413125][    T1] usbcore: registered new interface driver mcba_usb
[    8.413866][    T1] usbcore: registered new interface driver peak_usb
[    8.414720][    T1] e100: Intel(R) PRO/100 Network Driver
[    8.415328][    T1] e100: Copyright(c) 1999-2006 Intel Corporation
[    8.416075][    T1] e1000: Intel(R) PRO/1000 Network Driver
[    8.416677][    T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    8.509400][   T97] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    8.509659][    C2] sd 0:0:0:0: Power-on or device reset occurred
[    8.510996][ T1068] sd 0:0:0:0: [sda] 2097458 512-byte logical =
blocks: (1.07 GB/1.00 GiB)
[    8.511984][ T1068] sd 0:0:0:0: [sda] Write Protect is off
[    8.512598][ T1068] sd 0:0:0:0: [sda] Mode Sense: 63 00 00 08
[    8.512765][ T1068] sd 0:0:0:0: [sda] Write cache: enabled, read =
cache: enabled, doesn't support DPO or FUA
[    8.519194][ T1068]  sda: sda1
[    8.520264][ T1068] sd 0:0:0:0: [sda] Attached SCSI disk
[    9.059201][    T1] ACPI: _SB_.LNKC: Enabled at IRQ 10
[    9.414468][    T1] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) =
52:54:00:12:34:56
[    9.415288][    T1] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 =
Network Connection
[    9.416166][    T1] e1000e: Intel(R) PRO/1000 Network Driver
[    9.416778][    T1] e1000e: Copyright(c) 1999 - 2015 Intel =
Corporation.
[    9.417909][    T1] mkiss: AX.25 Multikiss, Hans Albas PE1AYX
[    9.418524][    T1] AX.25: 6pack driver, Revision: 0.3.0
[    9.419105][    T1] AX.25: bpqether driver version 004
[    9.419674][    T1] PPP generic driver version 2.4.2
[    9.420490][    T1] PPP BSD Compression module registered
[    9.421073][    T1] PPP Deflate Compression module registered
[    9.421705][    T1] PPP MPPE Compression module registered
[    9.422290][    T1] NET: Registered PF_PPPOX protocol family
[    9.422921][    T1] PPTP driver version 0.8.5
[    9.423835][    T1] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic =
channels, max=3D256) (6 bit encapsulation enabled).
[    9.424965][    T1] CSLIP: code copyright 1989 Regents of the =
University of California.
[    9.425814][    T1] SLIP linefill/keepalive option.
[    9.426339][    T1] hdlc: HDLC support module revision 1.22
[    9.426942][    T1] LAPB Ethernet driver version 0.02
[    9.427663][    T1] usbcore: registered new interface driver =
ath9k_htc
[    9.428418][    T1] usbcore: registered new interface driver carl9170
[    9.429175][    T1] usbcore: registered new interface driver =
ath6kl_usb
[    9.429946][    T1] usbcore: registered new interface driver ar5523
[    9.430705][    T1] usbcore: registered new interface driver =
ath10k_usb
[    9.431480][    T1] usbcore: registered new interface driver =
rndis_wlan
[    9.432293][    T1] mac80211_hwsim: initializing netlink
[    9.433384][    T1] ieee80211 phy0: Selected rate control algorithm =
'minstrel_ht'
[    9.436328][    T1] ieee80211 phy1: Selected rate control algorithm =
'minstrel_ht'
[    9.439012][    T1] usbcore: registered new interface driver atusb
[    9.442328][    T1] mac802154_hwsim mac802154_hwsim: Added 2 =
mac802154 hwsim hardware radios
[    9.443406][    T1] VMware vmxnet3 virtual NIC driver - version =
1.7.0.0-k-NAPI
[    9.444373][    T1] usbcore: registered new interface driver catc
[    9.445094][    T1] usbcore: registered new interface driver kaweth
[    9.445776][    T1] pegasus: Pegasus/Pegasus II USB Ethernet driver
[    9.446527][    T1] usbcore: registered new interface driver pegasus
[    9.447279][    T1] usbcore: registered new interface driver rtl8150
[    9.448004][    T1] usbcore: registered new device driver =
r8152-cfgselector
[    9.448818][    T1] usbcore: registered new interface driver r8152
[    9.449468][    T1] hso: drivers/net/usb/hso.c: Option Wireless
[    9.450180][    T1] usbcore: registered new interface driver hso
[    9.450867][    T1] usbcore: registered new interface driver lan78xx
[    9.451603][    T1] usbcore: registered new interface driver asix
[    9.452305][    T1] usbcore: registered new interface driver =
ax88179_178a
[    9.453085][    T1] usbcore: registered new interface driver =
cdc_ether
[    9.453830][    T1] usbcore: registered new interface driver cdc_eem
[    9.454579][    T1] usbcore: registered new interface driver dm9601
[    9.455315][    T1] usbcore: registered new interface driver sr9700
[    9.456038][    T1] usbcore: registered new interface driver =
CoreChips
[    9.456820][    T1] usbcore: registered new interface driver smsc75xx
[    9.457560][    T1] usbcore: registered new interface driver smsc95xx
[    9.458312][    T1] usbcore: registered new interface driver gl620a
[    9.459022][    T1] usbcore: registered new interface driver net1080
[    9.459768][    T1] usbcore: registered new interface driver plusb
[    9.460492][    T1] usbcore: registered new interface driver =
rndis_host
[    9.461254][    T1] usbcore: registered new interface driver =
cdc_subset
[    9.462012][    T1] usbcore: registered new interface driver zaurus
[    9.462751][    T1] usbcore: registered new interface driver MOSCHIP =
usb-ethernet driver
[    9.463677][    T1] usbcore: registered new interface driver int51x1
[    9.464438][    T1] usbcore: registered new interface driver =
cdc_phonet
[    9.465146][    T1] usbcore: registered new interface driver kalmia
[    9.465740][    T1] usbcore: registered new interface driver ipheth
[    9.466329][    T1] usbcore: registered new interface driver =
sierra_net
[    9.467132][    T1] usbcore: registered new interface driver =
cx82310_eth
[    9.467928][    T1] usbcore: registered new interface driver cdc_ncm
[    9.468714][    T1] usbcore: registered new interface driver =
huawei_cdc_ncm
[    9.469500][    T1] usbcore: registered new interface driver lg-vl600
[    9.469979][    T1] usbcore: registered new interface driver qmi_wwan
[    9.470454][    T1] usbcore: registered new interface driver cdc_mbim
[    9.470946][    T1] usbcore: registered new interface driver ch9200
[    9.471408][    T1] usbcore: registered new interface driver =
r8153_ecm
[    9.472974][    T1] VFIO - User Level meta-driver version: 0.3
[    9.474907][    T1] aoe: AoE v85 initialised.
[    9.476548][    T1] SPI driver max3421-hcd has no spi_device_id for =
maxim,max3421
[    9.477201][    T1] usbcore: registered new interface driver cdc_acm
[    9.477647][    T1] cdc_acm: USB Abstract Control Model driver for =
USB modems and ISDN adapters
[    9.478283][    T1] usbcore: registered new interface driver usblp
[    9.478751][    T1] usbcore: registered new interface driver cdc_wdm
[    9.479232][    T1] usbcore: registered new interface driver usbtmc
[    9.479909][    T1] usbcore: registered new interface driver uas
[    9.480379][    T1] usbcore: registered new interface driver =
usb-storage
[    9.480898][    T1] usbcore: registered new interface driver =
ums-alauda
[    9.481396][    T1] usbcore: registered new interface driver =
ums-cypress
[    9.481897][    T1] usbcore: registered new interface driver =
ums-datafab
[    9.482394][    T1] usbcore: registered new interface driver =
ums_eneub6250
[    9.482904][    T1] usbcore: registered new interface driver =
ums-freecom
[    9.483392][    T1] usbcore: registered new interface driver =
ums-isd200
[    9.483891][    T1] usbcore: registered new interface driver =
ums-jumpshot
[    9.484420][    T1] usbcore: registered new interface driver =
ums-karma
[    9.484912][    T1] usbcore: registered new interface driver =
ums-onetouch
[    9.485419][    T1] usbcore: registered new interface driver =
ums-realtek
[    9.485915][    T1] usbcore: registered new interface driver =
ums-sddr09
[    9.486412][    T1] usbcore: registered new interface driver =
ums-sddr55
[    9.486904][    T1] usbcore: registered new interface driver =
ums-usbat
[    9.487407][    T1] usbcore: registered new interface driver mdc800
[    9.487837][    T1] mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek =
MDC800 Digital Camera
[    9.488452][    T1] usbcore: registered new interface driver =
microtekX6
[    9.489014][    T1] usbcore: registered new interface driver =
usbserial_generic
[    9.489670][    T1] usbserial: USB Serial support registered for =
generic
[    9.490188][    T1] usbcore: registered new interface driver aircable
[    9.490685][    T1] usbserial: USB Serial support registered for =
aircable
[    9.491200][    T1] usbcore: registered new interface driver ark3116
[    9.491672][    T1] usbserial: USB Serial support registered for =
ark3116
[    9.492186][    T1] usbcore: registered new interface driver =
belkin_sa
[    9.492681][    T1] usbserial: USB Serial support registered for =
Belkin / Peracom / GoHubs USB Serial Adapter
[    9.493402][    T1] usbcore: registered new interface driver ch341
[    9.493867][    T1] usbserial: USB Serial support registered for =
ch341-uart
[    9.494404][    T1] usbcore: registered new interface driver cp210x
[    9.494878][    T1] usbserial: USB Serial support registered for =
cp210x
[    9.495372][    T1] usbcore: registered new interface driver =
cyberjack
[    9.495850][    T1] usbserial: USB Serial support registered for =
Reiner SCT Cyberjack USB card reader
[    9.496517][    T1] usbcore: registered new interface driver =
cypress_m8
[    9.497040][    T1] usbserial: USB Serial support registered for =
DeLorme Earthmate USB
[    9.497614][    T1] usbserial: USB Serial support registered for =
HID->COM RS232 Adapter
[    9.498186][    T1] usbserial: USB Serial support registered for =
Nokia CA-42 V2 Adapter
[    9.498808][    T1] usbcore: registered new interface driver =
usb_debug
[    9.499302][    T1] usbserial: USB Serial support registered for =
debug
[    9.499784][    T1] usbserial: USB Serial support registered for =
xhci_dbc
[    9.500287][    T1] usbcore: registered new interface driver =
digi_acceleport
[    9.500801][    T1] usbserial: USB Serial support registered for Digi =
2 port USB adapter
[    9.501387][    T1] usbserial: USB Serial support registered for Digi =
4 port USB adapter
[    9.501976][    T1] usbcore: registered new interface driver =
io_edgeport
[    9.502477][    T1] usbserial: USB Serial support registered for =
Edgeport 2 port adapter
[    9.503064][    T1] usbserial: USB Serial support registered for =
Edgeport 4 port adapter
[    9.503665][    T1] usbserial: USB Serial support registered for =
Edgeport 8 port adapter
[    9.504321][    T1] usbserial: USB Serial support registered for EPiC =
device
[    9.504857][    T1] usbcore: registered new interface driver io_ti
[    9.505313][    T1] usbserial: USB Serial support registered for =
Edgeport TI 1 port adapter
[    9.505920][    T1] usbserial: USB Serial support registered for =
Edgeport TI 2 port adapter
[    9.506531][    T1] usbcore: registered new interface driver empeg
[    9.506988][    T1] usbserial: USB Serial support registered for =
empeg
[    9.507483][    T1] usbcore: registered new interface driver =
f81534a_ctrl
[    9.508004][    T1] usbcore: registered new interface driver f81232
[    9.508488][    T1] usbserial: USB Serial support registered for =
f81232
[    9.508986][    T1] usbserial: USB Serial support registered for =
f81534a
[    9.509489][    T1] usbcore: registered new interface driver f81534
[    9.509957][    T1] usbserial: USB Serial support registered for =
Fintek F81532/F81534
[    9.510525][    T1] usbcore: registered new interface driver ftdi_sio
[    9.511022][    T1] usbserial: USB Serial support registered for FTDI =
USB Serial Device
[    9.511601][    T1] usbcore: registered new interface driver =
garmin_gps
[    9.512102][    T1] usbserial: USB Serial support registered for =
Garmin GPS usb/tty
[    9.512669][    T1] usbcore: registered new interface driver ipaq
[    9.513123][    T1] usbserial: USB Serial support registered for =
PocketPC PDA
[    9.513661][    T1] usbcore: registered new interface driver ipw
[    9.514149][    T1] usbserial: USB Serial support registered for =
IPWireless converter
[    9.514730][    T1] usbcore: registered new interface driver ir_usb
[    9.515193][    T1] usbserial: USB Serial support registered for IR =
Dongle
[    9.515707][    T1] usbcore: registered new interface driver =
iuu_phoenix
[    9.516212][    T1] usbserial: USB Serial support registered for =
iuu_phoenix
[    9.516731][    T1] usbcore: registered new interface driver keyspan
[    9.517201][    T1] usbserial: USB Serial support registered for =
Keyspan - (without firmware)
[    9.517812][    T1] usbserial: USB Serial support registered for =
Keyspan 1 port adapter
[    9.518398][    T1] usbserial: USB Serial support registered for =
Keyspan 2 port adapter
[    9.518976][    T1] usbserial: USB Serial support registered for =
Keyspan 4 port adapter
[    9.519569][    T1] usbcore: registered new interface driver =
keyspan_pda
[    9.520074][    T1] usbserial: USB Serial support registered for =
Keyspan PDA
[    9.520603][    T1] usbserial: USB Serial support registered for =
Keyspan PDA - (prerenumeration)
[    9.521240][    T1] usbcore: registered new interface driver =
kl5kusb105
[    9.521725][    T1] usbserial: USB Serial support registered for =
KL5KUSB105D / PalmConnect
[    9.522329][    T1] usbcore: registered new interface driver =
kobil_sct
[    9.522812][    T1] usbserial: USB Serial support registered for =
KOBIL USB smart card terminal
[    9.523447][    T1] usbcore: registered new interface driver mct_u232
[    9.523934][    T1] usbserial: USB Serial support registered for MCT =
U232
[    9.524458][    T1] usbcore: registered new interface driver =
metro_usb
[    9.524955][    T1] usbserial: USB Serial support registered for =
Metrologic USB to Serial
[    9.525563][    T1] usbcore: registered new interface driver mos7720
[    9.526036][    T1] usbserial: USB Serial support registered for =
Moschip 2 port adapter
[    9.526619][    T1] usbcore: registered new interface driver mos7840
[    9.527101][    T1] usbserial: USB Serial support registered for =
Moschip 7840/7820 USB Serial Driver
[    9.527765][    T1] usbcore: registered new interface driver mxuport
[    9.528243][    T1] usbserial: USB Serial support registered for MOXA =
UPort
[    9.528775][    T1] usbcore: registered new interface driver navman
[    9.529250][    T1] usbserial: USB Serial support registered for =
navman
[    9.529745][    T1] usbcore: registered new interface driver omninet
[    9.530222][    T1] usbserial: USB Serial support registered for =
ZyXEL - omni.net usb
[    9.530809][    T1] usbcore: registered new interface driver opticon
[    9.531298][    T1] usbserial: USB Serial support registered for =
opticon
[    9.531807][    T1] usbcore: registered new interface driver option
[    9.532280][    T1] usbserial: USB Serial support registered for GSM =
modem (1-port)
[    9.532857][    T1] usbcore: registered new interface driver oti6858
[    9.533340][    T1] usbserial: USB Serial support registered for =
oti6858
[    9.533853][    T1] usbcore: registered new interface driver pl2303
[    9.534382][    T1] usbserial: USB Serial support registered for =
pl2303
[    9.534896][    T1] usbcore: registered new interface driver qcaux
[    9.535374][    T1] usbserial: USB Serial support registered for =
qcaux
[    9.535880][    T1] usbcore: registered new interface driver qcserial
[    9.536363][    T1] usbserial: USB Serial support registered for =
Qualcomm USB modem
[    9.536943][    T1] usbcore: registered new interface driver quatech2
[    9.537433][    T1] usbserial: USB Serial support registered for =
Quatech 2nd gen USB to Serial Driver
[    9.538116][    T1] usbcore: registered new interface driver =
safe_serial
[    9.538620][    T1] usbserial: USB Serial support registered for =
safe_serial
[    9.539150][    T1] usbcore: registered new interface driver sierra
[    9.539629][    T1] usbserial: USB Serial support registered for =
Sierra USB modem
[    9.540190][    T1] usbcore: registered new interface driver =
usb_serial_simple
[    9.540725][    T1] usbserial: USB Serial support registered for =
carelink
[    9.541242][    T1] usbserial: USB Serial support registered for zio
[    9.541730][    T1] usbserial: USB Serial support registered for =
funsoft
[    9.542234][    T1] usbserial: USB Serial support registered for =
flashloader
[    9.542763][    T1] usbserial: USB Serial support registered for =
google
[    9.543259][    T1] usbserial: USB Serial support registered for =
libtransistor
[    9.543799][    T1] usbserial: USB Serial support registered for =
vivopay
[    9.544314][    T1] usbserial: USB Serial support registered for =
moto_modem
[    9.544835][    T1] usbserial: USB Serial support registered for =
motorola_tetra
[    9.545371][    T1] usbserial: USB Serial support registered for =
nokia
[    9.545867][    T1] usbserial: USB Serial support registered for =
novatel_gps
[    9.546390][    T1] usbserial: USB Serial support registered for hp4x
[    9.546875][    T1] usbserial: USB Serial support registered for =
suunto
[    9.547372][    T1] usbserial: USB Serial support registered for =
siemens_mpi
[    9.547906][    T1] usbcore: registered new interface driver spcp8x5
[    9.548388][    T1] usbserial: USB Serial support registered for =
SPCP8x5
[    9.548899][    T1] usbcore: registered new interface driver ssu100
[    9.549366][    T1] usbserial: USB Serial support registered for =
Quatech SSU-100 USB to Serial Driver
[    9.550041][    T1] usbcore: registered new interface driver =
symbolserial
[    9.550548][    T1] usbserial: USB Serial support registered for =
symbol
[    9.551044][    T1] usbcore: registered new interface driver =
ti_usb_3410_5052
[    9.551574][    T1] usbserial: USB Serial support registered for TI =
USB 3410 1 port adapter
[    9.552189][    T1] usbserial: USB Serial support registered for TI =
USB 5052 2 port adapter
[    9.552818][    T1] usbcore: registered new interface driver =
upd78f0730
[    9.553309][    T1] usbserial: USB Serial support registered for =
upd78f0730
[    9.553831][    T1] usbcore: registered new interface driver visor
[    9.554321][    T1] usbserial: USB Serial support registered for =
Handspring Visor / Palm OS
[    9.554928][    T1] usbserial: USB Serial support registered for Sony =
Clie 5.0
[    9.555462][    T1] usbserial: USB Serial support registered for Sony =
Clie 3.5
[    9.556021][    T1] usbcore: registered new interface driver =
wishbone_serial
[    9.556574][    T1] usbserial: USB Serial support registered for =
wishbone_serial
[    9.557131][    T1] usbcore: registered new interface driver =
whiteheat
[    9.557627][    T1] usbserial: USB Serial support registered for =
Connect Tech - WhiteHEAT - (prerenumeration)
[    9.558349][    T1] usbserial: USB Serial support registered for =
Connect Tech - WhiteHEAT
[    9.558954][    T1] usbcore: registered new interface driver =
xr_serial
[    9.559447][    T1] usbserial: USB Serial support registered for =
xr_serial
[    9.559965][    T1] usbcore: registered new interface driver xsens_mt
[    9.560448][    T1] usbserial: USB Serial support registered for =
xsens_mt
[    9.560969][    T1] usbcore: registered new interface driver adutux
[    9.561452][    T1] usbcore: registered new interface driver =
appledisplay
[    9.561967][    T1] usbcore: registered new interface driver =
cypress_cy7c63
[    9.562499][    T1] usbcore: registered new interface driver cytherm
[    9.562989][    T1] usbcore: registered new interface driver emi26 - =
firmware loader
[    9.563568][    T1] usbcore: registered new interface driver emi62 - =
firmware loader
[    9.564171][    T1] usbcore: registered new interface driver idmouse
[    9.564656][    T1] usbcore: registered new interface driver =
iowarrior
[    9.565178][    T1] usbcore: registered new interface driver =
isight_firmware
[    9.565731][    T1] usbcore: registered new interface driver usblcd
[    9.566208][    T1] usbcore: registered new interface driver ldusb
[    9.566683][    T1] usbcore: registered new interface driver =
legousbtower
[    9.567206][    T1] usbcore: registered new interface driver usbtest
[    9.567694][    T1] usbcore: registered new interface driver =
usb_ehset_test
[    9.568230][    T1] usbcore: registered new interface driver =
trancevibrator
[    9.568778][    T1] usbcore: registered new interface driver uss720
[    9.569217][    T1] uss720: USB Parport Cable driver for Cables using =
the Lucent Technologies USS720 Chip
[    9.569872][    T1] uss720: NOTE: this is a special purpose driver to =
allow nonstandard
[    9.570424][    T1] uss720: protocols (eg. bitbang) over USS720 usb =
to parallel cables
[    9.570969][    T1] uss720: If you just want to connect to a printer, =
use usblp instead
[    9.571573][    T1] usbcore: registered new interface driver =
usbsevseg
[    9.572070][    T1] usbcore: registered new interface driver yurex
[    9.572705][    T1] usbcore: registered new interface driver chaoskey
[    9.573204][    T1] usbcore: registered new interface driver sisusb
[    9.573686][    T1] usbcore: registered new interface driver lvs
[    9.574194][    T1] usbcore: registered new interface driver cxacru
[    9.574677][    T1] usbcore: registered new interface driver speedtch
[    9.575176][    T1] usbcore: registered new interface driver =
ueagle-atm
[    9.575639][    T1] xusbatm: malformed module parameters
[    9.576484][    T1] dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.577064][    T1] dummy_hcd dummy_hcd.0: Dummy host controller
[    9.577944][    T1] dummy_hcd dummy_hcd.0: new USB bus registered, =
assigned bus number 1
[    9.578941][    T1] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.579594][    T1] usb usb1: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.580149][    T1] usb usb1: Product: Dummy host controller
[    9.580551][    T1] usb usb1: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.581122][    T1] usb usb1: SerialNumber: dummy_hcd.0
[    9.582647][    T1] hub 1-0:1.0: USB hub found
[    9.583075][    T1] hub 1-0:1.0: 1 port detected
[    9.584963][    T1] dummy_hcd dummy_hcd.1: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.585538][    T1] dummy_hcd dummy_hcd.1: Dummy host controller
[    9.586177][    T1] dummy_hcd dummy_hcd.1: new USB bus registered, =
assigned bus number 2
[    9.586954][    T1] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.587580][    T1] usb usb2: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.588132][    T1] usb usb2: Product: Dummy host controller
[    9.588531][    T1] usb usb2: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.589095][    T1] usb usb2: SerialNumber: dummy_hcd.1
[    9.590159][    T1] hub 2-0:1.0: USB hub found
[    9.590527][    T1] hub 2-0:1.0: 1 port detected
[    9.591556][    T1] dummy_hcd dummy_hcd.2: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.592122][    T1] dummy_hcd dummy_hcd.2: Dummy host controller
[    9.592782][    T1] dummy_hcd dummy_hcd.2: new USB bus registered, =
assigned bus number 3
[    9.593567][    T1] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.594223][    T1] usb usb3: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.594782][    T1] usb usb3: Product: Dummy host controller
[    9.595180][    T1] usb usb3: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.595751][    T1] usb usb3: SerialNumber: dummy_hcd.2
[    9.596781][    T1] hub 3-0:1.0: USB hub found
[    9.597146][    T1] hub 3-0:1.0: 1 port detected
[    9.598147][    T1] dummy_hcd dummy_hcd.3: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.598719][    T1] dummy_hcd dummy_hcd.3: Dummy host controller
[    9.599374][    T1] dummy_hcd dummy_hcd.3: new USB bus registered, =
assigned bus number 4
[    9.600150][    T1] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.600783][    T1] usb usb4: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.601331][    T1] usb usb4: Product: Dummy host controller
[    9.601728][    T1] usb usb4: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.602299][    T1] usb usb4: SerialNumber: dummy_hcd.3
[    9.603338][    T1] hub 4-0:1.0: USB hub found
[    9.603732][    T1] hub 4-0:1.0: 1 port detected
[    9.604770][    T1] dummy_hcd dummy_hcd.4: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.605346][    T1] dummy_hcd dummy_hcd.4: Dummy host controller
[    9.606012][    T1] dummy_hcd dummy_hcd.4: new USB bus registered, =
assigned bus number 5
[    9.606791][    T1] usb usb5: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.607415][    T1] usb usb5: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.607971][    T1] usb usb5: Product: Dummy host controller
[    9.608367][    T1] usb usb5: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.608946][    T1] usb usb5: SerialNumber: dummy_hcd.4
[    9.610032][    T1] hub 5-0:1.0: USB hub found
[    9.610399][    T1] hub 5-0:1.0: 1 port detected
[    9.611386][    T1] dummy_hcd dummy_hcd.5: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.611969][    T1] dummy_hcd dummy_hcd.5: Dummy host controller
[    9.612644][    T1] dummy_hcd dummy_hcd.5: new USB bus registered, =
assigned bus number 6
[    9.613430][    T1] usb usb6: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.614083][    T1] usb usb6: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.614644][    T1] usb usb6: Product: Dummy host controller
[    9.615047][    T1] usb usb6: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.615613][    T1] usb usb6: SerialNumber: dummy_hcd.5
[    9.616647][    T1] hub 6-0:1.0: USB hub found
[    9.617023][    T1] hub 6-0:1.0: 1 port detected
[    9.618047][    T1] dummy_hcd dummy_hcd.6: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.618621][    T1] dummy_hcd dummy_hcd.6: Dummy host controller
[    9.619289][    T1] dummy_hcd dummy_hcd.6: new USB bus registered, =
assigned bus number 7
[    9.620066][    T1] usb usb7: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.620696][    T1] usb usb7: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.621251][    T1] usb usb7: Product: Dummy host controller
[    9.621648][    T1] usb usb7: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.622216][    T1] usb usb7: SerialNumber: dummy_hcd.6
[    9.623254][    T1] hub 7-0:1.0: USB hub found
[    9.623618][    T1] hub 7-0:1.0: 1 port detected
[    9.624656][    T1] dummy_hcd dummy_hcd.7: USB Host+Gadget Emulator, =
driver 02 May 2005
[    9.625236][    T1] dummy_hcd dummy_hcd.7: Dummy host controller
[    9.625897][    T1] dummy_hcd dummy_hcd.7: new USB bus registered, =
assigned bus number 8
[    9.626677][    T1] usb usb8: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.627307][    T1] usb usb8: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.627856][    T1] usb usb8: Product: Dummy host controller
[    9.628256][    T1] usb usb8: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 dummy_hcd
[    9.628841][    T1] usb usb8: SerialNumber: dummy_hcd.7
[    9.629876][    T1] hub 8-0:1.0: USB hub found
[    9.630245][    T1] hub 8-0:1.0: 1 port detected
[    9.634801][    T1] gadgetfs: USB Gadget filesystem, version 24 Aug =
2004
[    9.635875][    T1] vhci_hcd vhci_hcd.0: USB/IP Virtual Host =
Controller
[    9.636602][    T1] vhci_hcd vhci_hcd.0: new USB bus registered, =
assigned bus number 9
[    9.637292][    T1] vhci_hcd: created sysfs vhci_hcd.0
[    9.637882][    T1] usb usb9: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.638515][    T1] usb usb9: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.639066][    T1] usb usb9: Product: USB/IP Virtual Host Controller
[    9.639510][    T1] usb usb9: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.640070][    T1] usb usb9: SerialNumber: vhci_hcd.0
[    9.641138][    T1] hub 9-0:1.0: USB hub found
[    9.641532][    T1] hub 9-0:1.0: 8 ports detected
[    9.643654][    T1] vhci_hcd vhci_hcd.0: USB/IP Virtual Host =
Controller
[    9.644416][    T1] vhci_hcd vhci_hcd.0: new USB bus registered, =
assigned bus number 10
[    9.645095][    T1] usb usb10: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.645897][    T1] usb usb10: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.646533][    T1] usb usb10: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.647090][    T1] usb usb10: Product: USB/IP Virtual Host =
Controller
[    9.647544][    T1] usb usb10: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.648107][    T1] usb usb10: SerialNumber: vhci_hcd.0
[    9.649170][    T1] hub 10-0:1.0: USB hub found
[    9.649540][    T1] hub 10-0:1.0: 8 ports detected
[    9.652077][    T1] vhci_hcd vhci_hcd.1: USB/IP Virtual Host =
Controller
[    9.652779][    T1] vhci_hcd vhci_hcd.1: new USB bus registered, =
assigned bus number 11
[    9.653540][    T1] usb usb11: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.654201][    T1] usb usb11: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.654761][    T1] usb usb11: Product: USB/IP Virtual Host =
Controller
[    9.655221][    T1] usb usb11: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.655780][    T1] usb usb11: SerialNumber: vhci_hcd.1
[    9.656813][    T1] hub 11-0:1.0: USB hub found
[    9.657185][    T1] hub 11-0:1.0: 8 ports detected
[    9.659258][    T1] vhci_hcd vhci_hcd.1: USB/IP Virtual Host =
Controller
[    9.659957][    T1] vhci_hcd vhci_hcd.1: new USB bus registered, =
assigned bus number 12
[    9.660611][    T1] usb usb12: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.661392][    T1] usb usb12: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.662028][    T1] usb usb12: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.662590][    T1] usb usb12: Product: USB/IP Virtual Host =
Controller
[    9.663046][    T1] usb usb12: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.663613][    T1] usb usb12: SerialNumber: vhci_hcd.1
[    9.664668][    T1] hub 12-0:1.0: USB hub found
[    9.665042][    T1] hub 12-0:1.0: 8 ports detected
[    9.667537][    T1] vhci_hcd vhci_hcd.2: USB/IP Virtual Host =
Controller
[    9.668223][    T1] vhci_hcd vhci_hcd.2: new USB bus registered, =
assigned bus number 13
[    9.668993][    T1] usb usb13: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.669632][    T1] usb usb13: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.670192][    T1] usb usb13: Product: USB/IP Virtual Host =
Controller
[    9.670647][    T1] usb usb13: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.671212][    T1] usb usb13: SerialNumber: vhci_hcd.2
[    9.672249][    T1] hub 13-0:1.0: USB hub found
[    9.672626][    T1] hub 13-0:1.0: 8 ports detected
[    9.674697][    T1] vhci_hcd vhci_hcd.2: USB/IP Virtual Host =
Controller
[    9.675393][    T1] vhci_hcd vhci_hcd.2: new USB bus registered, =
assigned bus number 14
[    9.676040][    T1] usb usb14: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.676818][    T1] usb usb14: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.677454][    T1] usb usb14: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.678011][    T1] usb usb14: Product: USB/IP Virtual Host =
Controller
[    9.678461][    T1] usb usb14: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.679034][    T1] usb usb14: SerialNumber: vhci_hcd.2
[    9.680067][    T1] hub 14-0:1.0: USB hub found
[    9.680441][    T1] hub 14-0:1.0: 8 ports detected
[    9.682964][    T1] vhci_hcd vhci_hcd.3: USB/IP Virtual Host =
Controller
[    9.683708][    T1] vhci_hcd vhci_hcd.3: new USB bus registered, =
assigned bus number 15
[    9.684498][    T1] usb usb15: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.685136][    T1] usb usb15: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.685689][    T1] usb usb15: Product: USB/IP Virtual Host =
Controller
[    9.686151][    T1] usb usb15: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.686727][    T1] usb usb15: SerialNumber: vhci_hcd.3
[    9.687749][    T1] hub 15-0:1.0: USB hub found
[    9.688120][    T1] hub 15-0:1.0: 8 ports detected
[    9.690192][    T1] vhci_hcd vhci_hcd.3: USB/IP Virtual Host =
Controller
[    9.690891][    T1] vhci_hcd vhci_hcd.3: new USB bus registered, =
assigned bus number 16
[    9.691530][    T1] usb usb16: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.692308][    T1] usb usb16: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.692949][    T1] usb usb16: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.693506][    T1] usb usb16: Product: USB/IP Virtual Host =
Controller
[    9.693965][    T1] usb usb16: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.694555][    T1] usb usb16: SerialNumber: vhci_hcd.3
[    9.695583][    T1] hub 16-0:1.0: USB hub found
[    9.695963][    T1] hub 16-0:1.0: 8 ports detected
[    9.698480][    T1] vhci_hcd vhci_hcd.4: USB/IP Virtual Host =
Controller
[    9.699177][    T1] vhci_hcd vhci_hcd.4: new USB bus registered, =
assigned bus number 17
[    9.699937][    T1] usb usb17: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.700579][    T1] usb usb17: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.701138][    T1] usb usb17: Product: USB/IP Virtual Host =
Controller
[    9.701593][    T1] usb usb17: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.702156][    T1] usb usb17: SerialNumber: vhci_hcd.4
[    9.703178][    T1] hub 17-0:1.0: USB hub found
[    9.703549][    T1] hub 17-0:1.0: 8 ports detected
[    9.705652][    T1] vhci_hcd vhci_hcd.4: USB/IP Virtual Host =
Controller
[    9.706353][    T1] vhci_hcd vhci_hcd.4: new USB bus registered, =
assigned bus number 18
[    9.707000][    T1] usb usb18: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.707795][    T1] usb usb18: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.708423][    T1] usb usb18: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.708984][    T1] usb usb18: Product: USB/IP Virtual Host =
Controller
[    9.709441][    T1] usb usb18: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.710011][    T1] usb usb18: SerialNumber: vhci_hcd.4
[    9.711164][    T1] hub 18-0:1.0: USB hub found
[    9.711535][    T1] hub 18-0:1.0: 8 ports detected
[    9.714015][    T1] vhci_hcd vhci_hcd.5: USB/IP Virtual Host =
Controller
[    9.714764][    T1] vhci_hcd vhci_hcd.5: new USB bus registered, =
assigned bus number 19
[    9.715528][    T1] usb usb19: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.716163][    T1] usb usb19: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.716732][    T1] usb usb19: Product: USB/IP Virtual Host =
Controller
[    9.717185][    T1] usb usb19: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.717752][    T1] usb usb19: SerialNumber: vhci_hcd.5
[    9.718784][    T1] hub 19-0:1.0: USB hub found
[    9.719159][    T1] hub 19-0:1.0: 8 ports detected
[    9.721244][    T1] vhci_hcd vhci_hcd.5: USB/IP Virtual Host =
Controller
[    9.721936][    T1] vhci_hcd vhci_hcd.5: new USB bus registered, =
assigned bus number 20
[    9.722604][    T1] usb usb20: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.723386][    T1] usb usb20: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.724039][    T1] usb usb20: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.724598][    T1] usb usb20: Product: USB/IP Virtual Host =
Controller
[    9.725057][    T1] usb usb20: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.725624][    T1] usb usb20: SerialNumber: vhci_hcd.5
[    9.726665][    T1] hub 20-0:1.0: USB hub found
[    9.727041][    T1] hub 20-0:1.0: 8 ports detected
[    9.729537][    T1] vhci_hcd vhci_hcd.6: USB/IP Virtual Host =
Controller
[    9.730230][    T1] vhci_hcd vhci_hcd.6: new USB bus registered, =
assigned bus number 21
[    9.731005][    T1] usb usb21: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.731639][    T1] usb usb21: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.732198][    T1] usb usb21: Product: USB/IP Virtual Host =
Controller
[    9.732656][    T1] usb usb21: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.733227][    T1] usb usb21: SerialNumber: vhci_hcd.6
[    9.734275][    T1] hub 21-0:1.0: USB hub found
[    9.734649][    T1] hub 21-0:1.0: 8 ports detected
[    9.736698][    T1] vhci_hcd vhci_hcd.6: USB/IP Virtual Host =
Controller
[    9.737393][    T1] vhci_hcd vhci_hcd.6: new USB bus registered, =
assigned bus number 22
[    9.738040][    T1] usb usb22: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.738836][    T1] usb usb22: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.739463][    T1] usb usb22: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.740021][    T1] usb usb22: Product: USB/IP Virtual Host =
Controller
[    9.740475][    T1] usb usb22: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.741049][    T1] usb usb22: SerialNumber: vhci_hcd.6
[    9.742072][    T1] hub 22-0:1.0: USB hub found
[    9.742441][    T1] hub 22-0:1.0: 8 ports detected
[    9.744990][    T1] vhci_hcd vhci_hcd.7: USB/IP Virtual Host =
Controller
[    9.745700][    T1] vhci_hcd vhci_hcd.7: new USB bus registered, =
assigned bus number 23
[    9.746455][    T1] usb usb23: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.747096][    T1] usb usb23: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.747650][    T1] usb usb23: Product: USB/IP Virtual Host =
Controller
[    9.748109][    T1] usb usb23: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.748676][    T1] usb usb23: SerialNumber: vhci_hcd.7
[    9.749701][    T1] hub 23-0:1.0: USB hub found
[    9.750073][    T1] hub 23-0:1.0: 8 ports detected
[    9.752118][    T1] vhci_hcd vhci_hcd.7: USB/IP Virtual Host =
Controller
[    9.752807][    T1] vhci_hcd vhci_hcd.7: new USB bus registered, =
assigned bus number 24
[    9.753456][    T1] usb usb24: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.754287][    T1] usb usb24: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.754927][    T1] usb usb24: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.755492][    T1] usb usb24: Product: USB/IP Virtual Host =
Controller
[    9.755960][    T1] usb usb24: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.756532][    T1] usb usb24: SerialNumber: vhci_hcd.7
[    9.757568][    T1] hub 24-0:1.0: USB hub found
[    9.757950][    T1] hub 24-0:1.0: 8 ports detected
[    9.760443][    T1] vhci_hcd vhci_hcd.8: USB/IP Virtual Host =
Controller
[    9.761149][    T1] vhci_hcd vhci_hcd.8: new USB bus registered, =
assigned bus number 25
[    9.761911][    T1] usb usb25: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.762549][    T1] usb usb25: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.763099][    T1] usb usb25: Product: USB/IP Virtual Host =
Controller
[    9.763553][    T1] usb usb25: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.764140][    T1] usb usb25: SerialNumber: vhci_hcd.8
[    9.765193][    T1] hub 25-0:1.0: USB hub found
[    9.765564][    T1] hub 25-0:1.0: 8 ports detected
[    9.767611][    T1] vhci_hcd vhci_hcd.8: USB/IP Virtual Host =
Controller
[    9.768307][    T1] vhci_hcd vhci_hcd.8: new USB bus registered, =
assigned bus number 26
[    9.768962][    T1] usb usb26: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.769735][    T1] usb usb26: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.770372][    T1] usb usb26: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.770931][    T1] usb usb26: Product: USB/IP Virtual Host =
Controller
[    9.771385][    T1] usb usb26: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.771952][    T1] usb usb26: SerialNumber: vhci_hcd.8
[    9.772985][    T1] hub 26-0:1.0: USB hub found
[    9.773361][    T1] hub 26-0:1.0: 8 ports detected
[    9.775866][    T1] vhci_hcd vhci_hcd.9: USB/IP Virtual Host =
Controller
[    9.776565][    T1] vhci_hcd vhci_hcd.9: new USB bus registered, =
assigned bus number 27
[    9.777344][    T1] usb usb27: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.777980][    T1] usb usb27: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.778541][    T1] usb usb27: Product: USB/IP Virtual Host =
Controller
[    9.778997][    T1] usb usb27: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.779567][    T1] usb usb27: SerialNumber: vhci_hcd.9
[    9.780734][    T1] hub 27-0:1.0: USB hub found
[    9.781107][    T1] hub 27-0:1.0: 8 ports detected
[    9.783149][    T1] vhci_hcd vhci_hcd.9: USB/IP Virtual Host =
Controller
[    9.783843][    T1] vhci_hcd vhci_hcd.9: new USB bus registered, =
assigned bus number 28
[    9.784533][    T1] usb usb28: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.785310][    T1] usb usb28: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.785946][    T1] usb usb28: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.786511][    T1] usb usb28: Product: USB/IP Virtual Host =
Controller
[    9.786968][    T1] usb usb28: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.787537][    T1] usb usb28: SerialNumber: vhci_hcd.9
[    9.788579][    T1] hub 28-0:1.0: USB hub found
[    9.788953][    T1] hub 28-0:1.0: 8 ports detected
[    9.791479][    T1] vhci_hcd vhci_hcd.10: USB/IP Virtual Host =
Controller
[    9.792194][    T1] vhci_hcd vhci_hcd.10: new USB bus registered, =
assigned bus number 29
[    9.792969][    T1] usb usb29: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.793611][    T1] usb usb29: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.794191][    T1] usb usb29: Product: USB/IP Virtual Host =
Controller
[    9.794653][    T1] usb usb29: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.795221][    T1] usb usb29: SerialNumber: vhci_hcd.10
[    9.796256][    T1] hub 29-0:1.0: USB hub found
[    9.796625][    T1] hub 29-0:1.0: 8 ports detected
[    9.798675][    T1] vhci_hcd vhci_hcd.10: USB/IP Virtual Host =
Controller
[    9.799421][    T1] vhci_hcd vhci_hcd.10: new USB bus registered, =
assigned bus number 30
[    9.800068][    T1] usb usb30: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.800864][    T1] usb usb30: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.801494][    T1] usb usb30: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.802053][    T1] usb usb30: Product: USB/IP Virtual Host =
Controller
[    9.802507][    T1] usb usb30: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.803065][    T1] usb usb30: SerialNumber: vhci_hcd.10
[    9.804122][    T1] hub 30-0:1.0: USB hub found
[    9.804507][    T1] hub 30-0:1.0: 8 ports detected
[    9.807006][    T1] vhci_hcd vhci_hcd.11: USB/IP Virtual Host =
Controller
[    9.807712][    T1] vhci_hcd vhci_hcd.11: new USB bus registered, =
assigned bus number 31
[    9.808485][    T1] usb usb31: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.809128][    T1] usb usb31: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.809687][    T1] usb usb31: Product: USB/IP Virtual Host =
Controller
[    9.810140][    T1] usb usb31: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.810705][    T1] usb usb31: SerialNumber: vhci_hcd.11
[    9.811742][    T1] hub 31-0:1.0: USB hub found
[    9.812112][    T1] hub 31-0:1.0: 8 ports detected
[    9.814198][    T1] vhci_hcd vhci_hcd.11: USB/IP Virtual Host =
Controller
[    9.814923][    T1] vhci_hcd vhci_hcd.11: new USB bus registered, =
assigned bus number 32
[    9.815577][    T1] usb usb32: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.816354][    T1] usb usb32: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.816984][    T1] usb usb32: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.817540][    T1] usb usb32: Product: USB/IP Virtual Host =
Controller
[    9.817998][    T1] usb usb32: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.818568][    T1] usb usb32: SerialNumber: vhci_hcd.11
[    9.819603][    T1] hub 32-0:1.0: USB hub found
[    9.819973][    T1] hub 32-0:1.0: 8 ports detected
[    9.822500][    T1] vhci_hcd vhci_hcd.12: USB/IP Virtual Host =
Controller
[    9.823201][    T1] vhci_hcd vhci_hcd.12: new USB bus registered, =
assigned bus number 33
[    9.823980][    T1] usb usb33: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.824641][    T1] usb usb33: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.825203][    T1] usb usb33: Product: USB/IP Virtual Host =
Controller
[    9.825655][    T1] usb usb33: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.826227][    T1] usb usb33: SerialNumber: vhci_hcd.12
[    9.827260][    T1] hub 33-0:1.0: USB hub found
[    9.827633][    T1] hub 33-0:1.0: 8 ports detected
[    9.829686][    T1] vhci_hcd vhci_hcd.12: USB/IP Virtual Host =
Controller
[    9.830392][    T1] vhci_hcd vhci_hcd.12: new USB bus registered, =
assigned bus number 34
[    9.831046][    T1] usb usb34: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.831828][    T1] usb usb34: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.832467][    T1] usb usb34: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.833037][    T1] usb usb34: Product: USB/IP Virtual Host =
Controller
[    9.833494][    T1] usb usb34: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.834085][    T1] usb usb34: SerialNumber: vhci_hcd.12
[    9.835140][    T1] hub 34-0:1.0: USB hub found
[    9.835512][    T1] hub 34-0:1.0: 8 ports detected
[    9.838002][    T1] vhci_hcd vhci_hcd.13: USB/IP Virtual Host =
Controller
[    9.838700][    T1] vhci_hcd vhci_hcd.13: new USB bus registered, =
assigned bus number 35
[    9.839469][    T1] usb usb35: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.840106][    T1] usb usb35: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.840671][    T1] usb usb35: Product: USB/IP Virtual Host =
Controller
[    9.841131][    T1] usb usb35: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.841703][    T1] usb usb35: SerialNumber: vhci_hcd.13
[    9.842759][    T1] hub 35-0:1.0: USB hub found
[    9.843132][    T1] hub 35-0:1.0: 8 ports detected
[    9.845206][    T1] vhci_hcd vhci_hcd.13: USB/IP Virtual Host =
Controller
[    9.845902][    T1] vhci_hcd vhci_hcd.13: new USB bus registered, =
assigned bus number 36
[    9.846560][    T1] usb usb36: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.847333][    T1] usb usb36: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.847967][    T1] usb usb36: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.848525][    T1] usb usb36: Product: USB/IP Virtual Host =
Controller
[    9.848987][    T1] usb usb36: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.849553][    T1] usb usb36: SerialNumber: vhci_hcd.13
[    9.850581][    T1] hub 36-0:1.0: USB hub found
[    9.850951][    T1] hub 36-0:1.0: 8 ports detected
[    9.853468][    T1] vhci_hcd vhci_hcd.14: USB/IP Virtual Host =
Controller
[    9.854177][    T1] vhci_hcd vhci_hcd.14: new USB bus registered, =
assigned bus number 37
[    9.854936][    T1] usb usb37: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.855576][    T1] usb usb37: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.856135][    T1] usb usb37: Product: USB/IP Virtual Host =
Controller
[    9.856595][    T1] usb usb37: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.857166][    T1] usb usb37: SerialNumber: vhci_hcd.14
[    9.858198][    T1] hub 37-0:1.0: USB hub found
[    9.858573][    T1] hub 37-0:1.0: 8 ports detected
[    9.860619][    T1] vhci_hcd vhci_hcd.14: USB/IP Virtual Host =
Controller
[    9.861312][    T1] vhci_hcd vhci_hcd.14: new USB bus registered, =
assigned bus number 38
[    9.861962][    T1] usb usb38: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.862754][    T1] usb usb38: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.863392][    T1] usb usb38: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.863948][    T1] usb usb38: Product: USB/IP Virtual Host =
Controller
[    9.864423][    T1] usb usb38: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.865001][    T1] usb usb38: SerialNumber: vhci_hcd.14
[    9.866069][    T1] hub 38-0:1.0: USB hub found
[    9.866441][    T1] hub 38-0:1.0: 8 ports detected
[    9.868935][    T1] vhci_hcd vhci_hcd.15: USB/IP Virtual Host =
Controller
[    9.869641][    T1] vhci_hcd vhci_hcd.15: new USB bus registered, =
assigned bus number 39
[    9.870420][    T1] usb usb39: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.04
[    9.871061][    T1] usb usb39: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.871615][    T1] usb usb39: Product: USB/IP Virtual Host =
Controller
[    9.872067][    T1] usb usb39: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.872638][    T1] usb usb39: SerialNumber: vhci_hcd.15
[    9.873682][    T1] hub 39-0:1.0: USB hub found
[    9.874081][    T1] hub 39-0:1.0: 8 ports detected
[    9.876154][    T1] vhci_hcd vhci_hcd.15: USB/IP Virtual Host =
Controller
[    9.876842][    T1] vhci_hcd vhci_hcd.15: new USB bus registered, =
assigned bus number 40
[    9.877489][    T1] usb usb40: We don't know the algorithms for LPM =
for this host, disabling LPM.
[    9.878268][    T1] usb usb40: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.04
[    9.878904][    T1] usb usb40: New USB device strings: Mfr=3D3, =
Product=3D2, SerialNumber=3D1
[    9.879460][    T1] usb usb40: Product: USB/IP Virtual Host =
Controller
[    9.879918][    T1] usb usb40: Manufacturer: Linux =
6.4.0-rc6-00195-g40f71e7cd3c6 vhci_hcd
[    9.880482][    T1] usb usb40: SerialNumber: vhci_hcd.15
[    9.881518][    T1] hub 40-0:1.0: USB hub found
[    9.881894][    T1] hub 40-0:1.0: 8 ports detected
[    9.884427][    T1] usbcore: registered new device driver usbip-host
[    9.885709][    T1] i8042: PNP: PS/2 Controller =
[PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    9.887028][    T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    9.887862][    T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    9.889023][    T1] mousedev: PS/2 mouse device common for all mice
[    9.890496][   T24] input: AT Translated Set 2 keyboard as =
/devices/platform/i8042/serio0/input/input1
[    9.890847][    T1] usbcore: registered new interface driver =
appletouch
[    9.891876][    T1] usbcore: registered new interface driver bcm5974
[    9.893363][    T1] usbcore: registered new interface driver =
synaptics_usb
[    9.894744][    T1] usbcore: registered new interface driver iforce
[    9.895569][    T1] usbcore: registered new interface driver xpad
[    9.896184][    T1] usbcore: registered new interface driver =
usb_acecad
[    9.896857][    T1] usbcore: registered new interface driver aiptek
[    9.897494][    T1] usbcore: registered new interface driver hanwang
[    9.898125][    T1] usbcore: registered new interface driver kbtab
[    9.898751][    T1] usbcore: registered new interface driver =
pegasus_notetaker
[    9.899498][    T1] usbcore: registered new interface driver =
usbtouchscreen
[    9.900191][    T1] usbcore: registered new interface driver sur40
[    9.900818][    T1] usbcore: registered new interface driver =
ati_remote2
[    9.901395][    T1] cm109: Keymap for Komunikate KIP1000 phone loaded
[    9.902035][    T1] usbcore: registered new interface driver cm109
[    9.902569][    T1] cm109: CM109 phone driver: 20080805 (C) Alfred E. =
Heggestad
[    9.903274][    T1] usbcore: registered new interface driver ims_pcu
[    9.903915][    T1] usbcore: registered new interface driver =
keyspan_remote
[    9.904625][    T1] usbcore: registered new interface driver =
powermate
[    9.905468][    T1] usbcore: registered new interface driver yealink
[    9.906709][    T1] rtc_cmos 00:05: RTC can wake from S4
[    9.908842][    T1] rtc_cmos 00:05: registered as rtc0
[    9.909326][    T1] rtc_cmos 00:05: alarms up to one day, y3k, 242 =
bytes nvram, hpet irqs
[    9.910591][    T1] i2c_dev: i2c /dev entries driver
[    9.911255][    T1] usbcore: registered new interface driver =
i2c-diolan-u2c
[    9.912005][    T1] usbcore: registered new interface driver =
RobotFuzz Open Source InterFace, OSIF
[    9.912880][    T1] usbcore: registered new interface driver =
i2c-tiny-usb
[    9.915003][    T1] usbcore: registered new interface driver =
igorplugusb
[    9.915806][    T1] usbcore: registered new interface driver iguanair
[    9.916663][    T1] usbcore: registered new interface driver imon
[    9.917349][    T1] usbcore: registered new interface driver mceusb
[    9.917980][    T1] usbcore: registered new interface driver redrat3
[    9.918605][    T1] usbcore: registered new interface driver =
streamzap
[    9.919264][    T1] usbcore: registered new interface driver ttusbir
[    9.919905][    T1] usbcore: registered new interface driver =
ati_remote
[    9.920655][    T1] b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV =
receiver chip loaded successfully
[    9.921596][    T1] usbcore: registered new interface driver =
b2c2_flexcop_usb
[    9.922180][    T1] usbcore: registered new interface driver =
dvb_usb_vp7045
[    9.922743][    T1] usbcore: registered new interface driver =
dvb_usb_vp702x
[    9.923349][    T1] usbcore: registered new interface driver =
dvb_usb_gp8psk
[    9.923940][    T1] usbcore: registered new interface driver =
dvb_usb_dtt200u
[    9.924553][    T1] usbcore: registered new interface driver =
dvb_usb_a800
[    9.925146][    T1] usbcore: registered new interface driver =
dvb_usb_dibusb_mb
[    9.925737][    T1] usbcore: registered new interface driver =
dvb_usb_dibusb_mc
[    9.926327][    T1] usbcore: registered new interface driver =
dvb_usb_nova_t_usb2
[    9.926929][    T1] usbcore: registered new interface driver =
dvb_usb_umt_010
[    9.927507][    T1] usbcore: registered new interface driver =
dvb_usb_m920x
[    9.928066][    T1] usbcore: registered new interface driver =
dvb_usb_digitv
[    9.928651][    T1] usbcore: registered new interface driver =
dvb_usb_cxusb
[    9.929211][    T1] usbcore: registered new interface driver =
dvb_usb_ttusb2
[    9.929843][    T1] usbcore: registered new interface driver =
dvb_usb_dib0700
[    9.930412][    T1] usbcore: registered new interface driver opera1
[    9.930944][    T1] usbcore: registered new interface driver =
dvb_usb_af9005
[    9.931515][    T1] usbcore: registered new interface driver pctv452e
[    9.932070][    T1] usbcore: registered new interface driver dw2102
[    9.932587][    T1] usbcore: registered new interface driver =
dvb_usb_dtv5100
[    9.933165][    T1] usbcore: registered new interface driver =
cinergyT2
[    9.933711][    T1] usbcore: registered new interface driver =
dvb_usb_az6027
[    9.934316][    T1] usbcore: registered new interface driver =
dvb_usb_technisat_usb2
[    9.934965][    T1] usbcore: registered new interface driver =
dvb_usb_af9015
[    9.935558][    T1] usbcore: registered new interface driver =
dvb_usb_af9035
[    9.936115][    T1] usbcore: registered new interface driver =
dvb_usb_anysee
[    9.936670][    T1] usbcore: registered new interface driver =
dvb_usb_au6610
[    9.937236][    T1] usbcore: registered new interface driver =
dvb_usb_az6007
[    9.937796][    T1] usbcore: registered new interface driver =
dvb_usb_ce6230
[    9.938358][    T1] usbcore: registered new interface driver =
dvb_usb_ec168
[    9.938926][    T1] usbcore: registered new interface driver =
dvb_usb_lmedm04
[    9.939492][    T1] usbcore: registered new interface driver =
dvb_usb_gl861
[    9.940078][    T1] usbcore: registered new interface driver =
dvb_usb_mxl111sf
[    9.940685][    T1] usbcore: registered new interface driver =
dvb_usb_rtl28xxu
[    9.941273][    T1] usbcore: registered new interface driver =
dvb_usb_dvbsky
[    9.941835][    T1] usbcore: registered new interface driver zd1301
[    9.942368][    T1] usbcore: registered new interface driver s2255
[    9.942923][    T1] usbcore: registered new interface driver smsusb
[    9.943451][    T1] usbcore: registered new interface driver ttusb
[    9.943965][    T1] usbcore: registered new interface driver =
ttusb-dec
[    9.944533][    T1] usbcore: registered new interface driver Abilis =
Systems as10x usb driver
[    9.945217][    T1] usbcore: registered new interface driver airspy
[    9.945667][    T1] gspca_main: v2.14.0 registered
[    9.946073][    T1] usbcore: registered new interface driver benq
[    9.946601][    T1] usbcore: registered new interface driver conex
[    9.947117][    T1] usbcore: registered new interface driver cpia1
[    9.947632][    T1] usbcore: registered new interface driver dtcs033
[    9.948162][    T1] usbcore: registered new interface driver etoms
[    9.948698][    T1] usbcore: registered new interface driver finepix
[    9.949225][    T1] usbcore: registered new interface driver jeilinj
[    9.949754][    T1] usbcore: registered new interface driver =
jl2005bcd
[    9.950290][    T1] usbcore: registered new interface driver kinect
[    9.950806][    T1] usbcore: registered new interface driver konica
[    9.951327][    T1] usbcore: registered new interface driver mars
[    9.951835][    T1] usbcore: registered new interface driver mr97310a
[    9.952374][    T1] usbcore: registered new interface driver nw80x
[    9.952912][    T1] usbcore: registered new interface driver ov519
[    9.953444][    T1] usbcore: registered new interface driver ov534
[    9.953961][    T1] usbcore: registered new interface driver ov534_9
[    9.954676][    T1] usbcore: registered new interface driver pac207
[    9.955209][    T1] usbcore: registered new interface driver =
gspca_pac7302
[    9.955776][    T1] usbcore: registered new interface driver pac7311
[    9.956307][    T1] usbcore: registered new interface driver se401
[    9.956833][    T1] usbcore: registered new interface driver sn9c2028
[    9.957392][    T1] usbcore: registered new interface driver =
gspca_sn9c20x
[    9.957977][    T1] usbcore: registered new interface driver sonixb
[    9.958525][    T1] usbcore: registered new interface driver sonixj
[    9.959057][    T1] usbcore: registered new interface driver spca500
[    9.959586][    T1] usbcore: registered new interface driver spca501
[    9.960122][    T1] usbcore: registered new interface driver spca505
[    9.960643][    T1] usbcore: registered new interface driver spca506
[    9.961177][    T1] usbcore: registered new interface driver spca508
[    9.961709][    T1] usbcore: registered new interface driver spca561
[    9.962241][    T1] usbcore: registered new interface driver spca1528
[    9.962767][    T1] usbcore: registered new interface driver sq905
[    9.963283][    T1] usbcore: registered new interface driver sq905c
[    9.963800][    T1] usbcore: registered new interface driver sq930x
[    9.964386][    T1] usbcore: registered new interface driver sunplus
[    9.964914][    T1] usbcore: registered new interface driver stk014
[    9.965435][    T1] usbcore: registered new interface driver stk1135
[    9.965960][    T1] usbcore: registered new interface driver stv0680
[    9.966494][    T1] usbcore: registered new interface driver t613
[    9.967003][    T1] usbcore: registered new interface driver =
gspca_topro
[    9.967552][    T1] usbcore: registered new interface driver touptek
[    9.968078][    T1] usbcore: registered new interface driver tv8532
[    9.968617][    T1] usbcore: registered new interface driver vc032x
[    9.969146][    T1] usbcore: registered new interface driver vicam
[    9.969654][    T1] usbcore: registered new interface driver =
xirlink-cit
[    9.970243][    T1] usbcore: registered new interface driver =
gspca_zc3xx
[    9.970802][    T1] usbcore: registered new interface driver ALi =
m5602
[    9.971340][    T1] usbcore: registered new interface driver STV06xx
[    9.971874][    T1] usbcore: registered new interface driver =
gspca_gl860
[    9.972438][    T1] usbcore: registered new interface driver hackrf
[    9.972966][    T1] usbcore: registered new interface driver msi2500
[    9.973515][    T1] usbcore: registered new interface driver Philips =
webcam
[    9.974210][    T1] usbcore: registered new interface driver uvcvideo
[    9.974684][    T1] au0828: au0828 driver loaded
[    9.975104][    T1] usbcore: registered new interface driver au0828
[    9.975666][    T1] usbcore: registered new interface driver cx231xx
[    9.976294][    T1] usbcore: registered new interface driver em28xx
[    9.976757][    T1] em28xx: Registered (Em28xx v4l2 Extension) =
extension
[    9.977230][    T1] em28xx: Registered (Em28xx Audio Extension) =
extension
[    9.977706][    T1] em28xx: Registered (Em28xx dvb Extension) =
extension
[    9.978175][    T1] em28xx: Registered (Em28xx Input Extension) =
extension
[    9.978736][    T1] usbcore: registered new interface driver go7007
[    9.979279][    T1] usbcore: registered new interface driver =
go7007-loader
[    9.979907][    T1] usbcore: registered new interface driver hdpvr
[    9.980641][    T1] usbcore: registered new interface driver pvrusb2
[    9.981111][    T1] pvrusb2: V4L in-tree version:Hauppauge =
WinTV-PVR-USB2 MPEG2 Encoder/Tuner
[    9.981718][    T1] pvrusb2: Debug mask is 31 (0x1f)
[    9.982154][    T1] usbcore: registered new interface driver stk1160
[    9.982685][    T1] usbcore: registered new interface driver usbtv
[    9.983919][    T1] dvbdev: DVB: registering new adapter =
(dvb_vidtv_bridge)
[    9.985555][    T1] i2c i2c-0: DVB: registering adapter 0 frontend 0 =
(Dummy demod for DVB-T/T2/C/S/S2)...
[    9.986384][    T1] dvbdev: dvb_create_media_entity: media entity =
'Dummy demod for DVB-T/T2/C/S/S2' registered.
[    9.989927][    T1] dvbdev: dvb_create_media_entity: media entity =
'dvb-demux' registered.
[    9.992280][    T1] vidtv vidtv.0: Successfully initialized vidtv!
[    9.993194][    T1] vicodec vicodec.0: Device 'stateful-encoder' =
registered as /dev/video0
[    9.993989][    T1] vicodec vicodec.0: Device 'stateful-decoder' =
registered as /dev/video1
[    9.995100][    T1] vicodec vicodec.0: Device 'stateless-decoder' =
registered as /dev/video2
[    9.997269][    T1] vim2m vim2m.0: Device registered as /dev/video0
[   10.009688][    T1] vivid-000: using single planar format API
[   10.019338][    T1] vivid-000: CEC adapter cec0 registered for HDMI =
input 0
[   10.020540][    T1] vivid-000: V4L2 capture device registered as =
video7
[   10.021306][    T1] vivid-000: CEC adapter cec1 registered for HDMI =
output 0
[   10.022350][    T1] vivid-000: V4L2 output device registered as =
video8
[   10.023322][    T1] vivid-000: V4L2 capture device registered as =
vbi0, supports raw and sliced VBI
[   10.024618][    T1] vivid-000: V4L2 output device registered as vbi1, =
supports raw and sliced VBI
[   10.026088][    T1] vivid-000: V4L2 capture device registered as =
swradio0
[   10.027296][    T1] vivid-000: V4L2 receiver device registered as =
radio0
[   10.028496][    T1] vivid-000: V4L2 transmitter device registered as =
radio1
[   10.029533][    T1] vivid-000: V4L2 metadata capture device =
registered as video9
[   10.030823][    T1] vivid-000: V4L2 metadata output device registered =
as video10
[   10.032126][    T1] vivid-000: V4L2 touch capture device registered =
as v4l-touch0
[   10.033434][    T1] vivid-001: using multiplanar format API
[   10.042284][    T1] vivid-001: CEC adapter cec2 registered for HDMI =
input 0
[   10.043084][    T1] vivid-001: V4L2 capture device registered as =
video11
[   10.043720][    T1] vivid-001: CEC adapter cec3 registered for HDMI =
output 0
[   10.044601][    T1] vivid-001: V4L2 output device registered as =
video12
[   10.045382][    T1] vivid-001: V4L2 capture device registered as =
vbi2, supports raw and sliced VBI
[   10.046172][    T1] vivid-001: V4L2 output device registered as vbi3, =
supports raw and sliced VBI
[   10.046950][    T1] vivid-001: V4L2 capture device registered as =
swradio1
[   10.047609][    T1] vivid-001: V4L2 receiver device registered as =
radio2
[   10.048230][    T1] vivid-001: V4L2 transmitter device registered as =
radio3
[   10.048897][    T1] vivid-001: V4L2 metadata capture device =
registered as video13
[   10.049582][    T1] vivid-001: V4L2 metadata output device registered =
as video14
[   10.050291][    T1] vivid-001: V4L2 touch capture device registered =
as v4l-touch1
[   10.050972][    T1] vivid-002: using single planar format API
[   10.056717][    T1] vivid-002: CEC adapter cec4 registered for HDMI =
input 0
[   10.057393][    T1] vivid-002: V4L2 capture device registered as =
video15
[   10.058030][    T1] vivid-002: CEC adapter cec5 registered for HDMI =
output 0
[   10.058872][    T1] vivid-002: V4L2 output device registered as =
video16
[   10.059643][    T1] vivid-002: V4L2 capture device registered as =
vbi4, supports raw and sliced VBI
[   10.060578][    T1] vivid-002: V4L2 output device registered as vbi5, =
supports raw and sliced VBI
[   10.061521][    T1] vivid-002: V4L2 capture device registered as =
swradio2
[   10.062326][    T1] vivid-002: V4L2 receiver device registered as =
radio4
[   10.063103][    T1] vivid-002: V4L2 transmitter device registered as =
radio5
[   10.063902][    T1] vivid-002: V4L2 metadata capture device =
registered as video17
[   10.064974][    T1] vivid-002: V4L2 metadata output device registered =
as video18
[   10.065863][    T1] vivid-002: V4L2 touch capture device registered =
as v4l-touch2
[   10.066710][    T1] vivid-003: using multiplanar format API
[   10.072517][    T1] vivid-003: CEC adapter cec6 registered for HDMI =
input 0
[   10.073370][    T1] vivid-003: V4L2 capture device registered as =
video19
[   10.074204][    T1] vivid-003: CEC adapter cec7 registered for HDMI =
output 0
[   10.075027][    T1] vivid-003: V4L2 output device registered as =
video20
[   10.075658][    T1] vivid-003: V4L2 capture device registered as =
vbi6, supports raw and sliced VBI
[   10.076448][    T1] vivid-003: V4L2 output device registered as vbi7, =
supports raw and sliced VBI
[   10.077376][    T1] vivid-003: V4L2 capture device registered as =
swradio3
[   10.078165][    T1] vivid-003: V4L2 receiver device registered as =
radio6
[   10.078963][    T1] vivid-003: V4L2 transmitter device registered as =
radio7
[   10.079759][    T1] vivid-003: V4L2 metadata capture device =
registered as video21
[   10.080609][    T1] vivid-003: V4L2 metadata output device registered =
as video22
[   10.081467][    T1] vivid-003: V4L2 touch capture device registered =
as v4l-touch3
[   10.082302][    T1] vivid-004: using single planar format API
[   10.088274][    T1] vivid-004: CEC adapter cec8 registered for HDMI =
input 0
[   10.088963][    T1] vivid-004: V4L2 capture device registered as =
video23
[   10.089620][    T1] vivid-004: CEC adapter cec9 registered for HDMI =
output 0
[   10.090298][    T1] vivid-004: V4L2 output device registered as =
video24
[   10.090945][    T1] vivid-004: V4L2 capture device registered as =
vbi8, supports raw and sliced VBI
[   10.091735][    T1] vivid-004: V4L2 output device registered as vbi9, =
supports raw and sliced VBI
[   10.092514][    T1] vivid-004: V4L2 capture device registered as =
swradio4
[   10.093160][    T1] vivid-004: V4L2 receiver device registered as =
radio8
[   10.093823][    T1] vivid-004: V4L2 transmitter device registered as =
radio9
[   10.094524][    T1] vivid-004: V4L2 metadata capture device =
registered as video25
[   10.095203][    T1] vivid-004: V4L2 metadata output device registered =
as video26
[   10.095902][    T1] vivid-004: V4L2 touch capture device registered =
as v4l-touch4
[   10.096571][    T1] vivid-005: using multiplanar format API
[   10.102244][    T1] vivid-005: CEC adapter cec10 registered for HDMI =
input 0
[   10.102913][    T1] vivid-005: V4L2 capture device registered as =
video27
[   10.103708][    T1] vivid-005: CEC adapter cec11 registered for HDMI =
output 0
[   10.104544][    T1] vivid-005: V4L2 output device registered as =
video28
[   10.105324][    T1] vivid-005: V4L2 capture device registered as =
vbi10, supports raw and sliced VBI
[   10.106244][    T1] vivid-005: V4L2 output device registered as =
vbi11, supports raw and sliced VBI
[   10.107060][    T1] vivid-005: V4L2 capture device registered as =
swradio5
[   10.107702][    T1] vivid-005: V4L2 receiver device registered as =
radio10
[   10.108338][    T1] vivid-005: V4L2 transmitter device registered as =
radio11
[   10.109013][    T1] vivid-005: V4L2 metadata capture device =
registered as video29
[   10.109716][    T1] vivid-005: V4L2 metadata output device registered =
as video30
[   10.110414][    T1] vivid-005: V4L2 touch capture device registered =
as v4l-touch5
[   10.111226][    T1] vivid-006: using single planar format API
[   10.117046][    T1] vivid-006: CEC adapter cec12 registered for HDMI =
input 0
[   10.117727][    T1] vivid-006: V4L2 capture device registered as =
video31
[   10.118552][    T1] vivid-006: CEC adapter cec13 registered for HDMI =
output 0
[   10.119253][    T1] vivid-006: V4L2 output device registered as =
video32
[   10.119882][    T1] vivid-006: V4L2 capture device registered as =
vbi12, supports raw and sliced VBI
[   10.120675][    T1] vivid-006: V4L2 output device registered as =
vbi13, supports raw and sliced VBI
[   10.121459][    T1] vivid-006: V4L2 capture device registered as =
swradio6
[   10.122102][    T1] vivid-006: V4L2 receiver device registered as =
radio12
[   10.122739][    T1] vivid-006: V4L2 transmitter device registered as =
radio13
[   10.123400][    T1] vivid-006: V4L2 metadata capture device =
registered as video33
[   10.124115][    T1] vivid-006: V4L2 metadata output device registered =
as video34
[   10.124820][    T1] vivid-006: V4L2 touch capture device registered =
as v4l-touch6
[   10.125515][    T1] vivid-007: using multiplanar format API
[   10.131321][    T1] vivid-007: CEC adapter cec14 registered for HDMI =
input 0
[   10.131997][    T1] vivid-007: V4L2 capture device registered as =
video35
[   10.132639][    T1] vivid-007: CEC adapter cec15 registered for HDMI =
output 0
[   10.133322][    T1] vivid-007: V4L2 output device registered as =
video36
[   10.133969][    T1] vivid-007: V4L2 capture device registered as =
vbi14, supports raw and sliced VBI
[   10.134974][    T1] vivid-007: V4L2 output device registered as =
vbi15, supports raw and sliced VBI
[   10.135767][    T1] vivid-007: V4L2 capture device registered as =
swradio7
[   10.136417][    T1] vivid-007: V4L2 receiver device registered as =
radio14
[   10.137069][    T1] vivid-007: V4L2 transmitter device registered as =
radio15
[   10.137747][    T1] vivid-007: V4L2 metadata capture device =
registered as video37
[   10.138452][    T1] vivid-007: V4L2 metadata output device registered =
as video38
[   10.139156][    T1] vivid-007: V4L2 touch capture device registered =
as v4l-touch7
[   10.139845][    T1] vivid-008: using single planar format API
[   10.145577][    T1] vivid-008: CEC adapter cec16 registered for HDMI =
input 0
[   10.146274][    T1] vivid-008: V4L2 capture device registered as =
video39
[   10.146947][    T1] vivid-008: CEC adapter cec17 registered for HDMI =
output 0
[   10.147802][    T1] vivid-008: V4L2 output device registered as =
video40
[   10.148613][    T1] vivid-008: V4L2 capture device registered as =
vbi16, supports raw and sliced VBI
[   10.149622][    T1] vivid-008: V4L2 output device registered as =
vbi17, supports raw and sliced VBI
[   10.150601][    T1] vivid-008: V4L2 capture device registered as =
swradio8
[   10.151411][    T1] vivid-008: V4L2 receiver device registered as =
radio16
[   10.152226][    T1] vivid-008: V4L2 transmitter device registered as =
radio17
[   10.153075][    T1] vivid-008: V4L2 metadata capture device =
registered as video41
[   10.153948][    T1] vivid-008: V4L2 metadata output device registered =
as video42
[   10.155025][    T1] vivid-008: V4L2 touch capture device registered =
as v4l-touch8
[   10.155893][    T1] vivid-009: using multiplanar format API
[   10.161733][    T1] vivid-009: CEC adapter cec18 registered for HDMI =
input 0
[   10.162419][    T1] vivid-009: V4L2 capture device registered as =
video43
[   10.163104][    T1] vivid-009: CEC adapter cec19 registered for HDMI =
output 0
[   10.163842][    T1] vivid-009: V4L2 output device registered as =
video44
[   10.164536][    T1] vivid-009: V4L2 capture device registered as =
vbi18, supports raw and sliced VBI
[   10.165445][    T1] vivid-009: V4L2 output device registered as =
vbi19, supports raw and sliced VBI
[   10.166290][    T1] vivid-009: V4L2 capture device registered as =
swradio9
[   10.166978][    T1] vivid-009: V4L2 receiver device registered as =
radio18
[   10.167650][    T1] vivid-009: V4L2 transmitter device registered as =
radio19
[   10.168363][    T1] vivid-009: V4L2 metadata capture device =
registered as video45
[   10.169088][    T1] vivid-009: V4L2 metadata output device registered =
as video46
[   10.169821][    T1] vivid-009: V4L2 touch capture device registered =
as v4l-touch9
[   10.170545][    T1] vivid-010: using single planar format API
[   10.176338][    T1] vivid-010: CEC adapter cec20 registered for HDMI =
input 0
[   10.177204][    T1] vivid-010: V4L2 capture device registered as =
video47
[   10.177899][    T1] vivid-010: CEC adapter cec21 registered for HDMI =
output 0
[   10.178635][    T1] vivid-010: V4L2 output device registered as =
video48
[   10.179455][    T1] vivid-010: V4L2 capture device registered as =
vbi20, supports raw and sliced VBI
[   10.180419][    T1] vivid-010: V4L2 output device registered as =
vbi21, supports raw and sliced VBI
[   10.181400][    T1] vivid-010: V4L2 capture device registered as =
swradio10
[   10.182253][    T1] vivid-010: V4L2 receiver device registered as =
radio20
[   10.183073][    T1] vivid-010: V4L2 transmitter device registered as =
radio21
[   10.183922][    T1] vivid-010: V4L2 metadata capture device =
registered as video49
[   10.185056][    T1] vivid-010: V4L2 metadata output device registered =
as video50
[   10.186133][    T1] vivid-010: V4L2 touch capture device registered =
as v4l-touch10
[   10.186891][    T1] vivid-011: using multiplanar format API
[   10.192763][    T1] vivid-011: CEC adapter cec22 registered for HDMI =
input 0
[   10.193608][    T1] vivid-011: V4L2 capture device registered as =
video51
[   10.194455][    T1] vivid-011: CEC adapter cec23 registered for HDMI =
output 0
[   10.195293][    T1] vivid-011: V4L2 output device registered as =
video52
[   10.196122][    T1] vivid-011: V4L2 capture device registered as =
vbi22, supports raw and sliced VBI
[   10.197139][    T1] vivid-011: V4L2 output device registered as =
vbi23, supports raw and sliced VBI
[   10.198132][    T1] vivid-011: V4L2 capture device registered as =
swradio11
[   10.198962][    T1] vivid-011: V4L2 receiver device registered as =
radio22
[   10.199813][    T1] vivid-011: V4L2 transmitter device registered as =
radio23
[   10.200673][    T1] vivid-011: V4L2 metadata capture device =
registered as video53
[   10.201565][    T1] vivid-011: V4L2 metadata output device registered =
as video54
[   10.202505][    T1] vivid-011: V4L2 touch capture device registered =
as v4l-touch11
[   10.203392][    T1] vivid-012: using single planar format API
[   10.209317][    T1] vivid-012: CEC adapter cec24 registered for HDMI =
input 0
[   10.210049][    T1] vivid-012: V4L2 capture device registered as =
video55
[   10.210918][    T1] vivid-012: CEC adapter cec25 registered for HDMI =
output 0
[   10.211667][    T1] vivid-012: V4L2 output device registered as =
video56
[   10.212382][    T1] vivid-012: V4L2 capture device registered as =
vbi24, supports raw and sliced VBI
[   10.213252][    T1] vivid-012: V4L2 output device registered as =
vbi25, supports raw and sliced VBI
[   10.214160][    T1] vivid-012: V4L2 capture device registered as =
swradio12
[   10.215218][    T1] vivid-012: V4L2 receiver device registered as =
radio24
[   10.215909][    T1] vivid-012: V4L2 transmitter device registered as =
radio25
[   10.216652][    T1] vivid-012: V4L2 metadata capture device =
registered as video57
[   10.217559][    T1] vivid-012: V4L2 metadata output device registered =
as video58
[   10.218319][    T1] vivid-012: V4L2 touch capture device registered =
as v4l-touch12
[   10.219186][    T1] vivid-013: using multiplanar format API
[   10.224988][    T1] vivid-013: CEC adapter cec26 registered for HDMI =
input 0
[   10.225855][    T1] vivid-013: V4L2 capture device registered as =
video59
[   10.226552][    T1] vivid-013: CEC adapter cec27 registered for HDMI =
output 0
[   10.227306][    T1] vivid-013: V4L2 output device registered as =
video60
[   10.227990][    T1] vivid-013: V4L2 capture device registered as =
vbi26, supports raw and sliced VBI
[   10.228859][    T1] vivid-013: V4L2 output device registered as =
vbi27, supports raw and sliced VBI
[   10.229713][    T1] vivid-013: V4L2 capture device registered as =
swradio13
[   10.230435][    T1] vivid-013: V4L2 receiver device registered as =
radio26
[   10.231128][    T1] vivid-013: V4L2 transmitter device registered as =
radio27
[   10.231836][    T1] vivid-013: V4L2 metadata capture device =
registered as video61
[   10.232588][    T1] vivid-013: V4L2 metadata output device registered =
as video62
[   10.233356][    T1] vivid-013: V4L2 touch capture device registered =
as v4l-touch13
[   10.234150][    T1] vivid-014: using single planar format API
[   10.240056][    T1] vivid-014: CEC adapter cec28 registered for HDMI =
input 0
[   10.240799][    T1] vivid-014: V4L2 capture device registered as =
video63
[   10.241499][    T1] vivid-014: CEC adapter cec29 registered for HDMI =
output 0
[   10.242232][    T1] vivid-014: V4L2 output device registered as =
video64
[   10.242948][    T1] vivid-014: V4L2 capture device registered as =
vbi28, supports raw and sliced VBI
[   10.243814][    T1] vivid-014: V4L2 output device registered as =
vbi29, supports raw and sliced VBI
[   10.244721][    T1] vivid-014: V4L2 capture device registered as =
swradio14
[   10.245565][    T1] vivid-014: V4L2 receiver device registered as =
radio28
[   10.246266][    T1] vivid-014: V4L2 transmitter device registered as =
radio29
[   10.246975][    T1] vivid-014: V4L2 metadata capture device =
registered as video65
[   10.247717][    T1] vivid-014: V4L2 metadata output device registered =
as video66
[   10.248481][    T1] vivid-014: V4L2 touch capture device registered =
as v4l-touch14
[   10.249239][    T1] vivid-015: using multiplanar format API
[   10.255370][    T1] vivid-015: CEC adapter cec30 registered for HDMI =
input 0
[   10.256106][    T1] vivid-015: V4L2 capture device registered as =
video67
[   10.256833][    T1] vivid-015: CEC adapter cec31 registered for HDMI =
output 0
[   10.257570][    T1] vivid-015: V4L2 output device registered as =
video68
[   10.258251][    T1] vivid-015: V4L2 capture device registered as =
vbi30, supports raw and sliced VBI
[   10.259137][    T1] vivid-015: V4L2 output device registered as =
vbi31, supports raw and sliced VBI
[   10.259982][    T1] vivid-015: V4L2 capture device registered as =
swradio15
[   10.260706][    T1] vivid-015: V4L2 receiver device registered as =
radio30
[   10.261400][    T1] vivid-015: V4L2 transmitter device registered as =
radio31
[   10.262123][    T1] vivid-015: V4L2 metadata capture device =
registered as video69
[   10.262868][    T1] vivid-015: V4L2 metadata output device registered =
as video70
[   10.263615][    T1] vivid-015: V4L2 touch capture device registered =
as v4l-touch15
[   10.264679][    T1] usbcore: registered new interface driver =
radioshark2
[   10.265438][    T1] usbcore: registered new interface driver =
radioshark
[   10.266040][    T1] usbcore: registered new interface driver =
radio-si470x
[   10.266772][    T1] usbcore: registered new interface driver =
radio-usb-si4713
[   10.267423][    T1] usbcore: registered new interface driver dsbr100
[   10.268022][    T1] usbcore: registered new interface driver =
radio-keene
[   10.268638][    T1] usbcore: registered new interface driver =
radio-ma901
[   10.269267][    T1] usbcore: registered new interface driver =
radio-mr800
[   10.269890][    T1] usbcore: registered new interface driver =
radio-raremono
[   10.271028][    T1] usbcore: registered new interface driver pcwd_usb
[   10.272694][    T1] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is =
disabled. Duplicate IMA measurements will not be recorded in the IMA =
log.
[   10.273636][    T1] device-mapper: uevent: version 1.0.3
[   10.274550][    T1] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) =
initialised: dm-devel@redhat.com
[   10.276171][    T1] device-mapper: multipath round-robin: version =
1.2.0 loaded
[   10.276709][    T1] device-mapper: multipath queue-length: version =
0.2.0 loaded
[   10.277245][    T1] device-mapper: multipath service-time: version =
0.3.0 loaded
[   10.278067][    T1] Bluetooth: HCI UART driver ver 2.3
[   10.278583][    T1] Bluetooth: HCI UART protocol H4 registered
[   10.279003][    T1] Bluetooth: HCI UART protocol BCSP registered
[   10.279472][    T1] Bluetooth: HCI UART protocol LL registered
[   10.279944][    T1] Bluetooth: HCI UART protocol Three-wire (H5) =
registered
[   10.280472][    T1] Bluetooth: HCI UART protocol QCA registered
[   10.280911][    T1] Bluetooth: HCI UART protocol AG6XX registered
[   10.281396][    T1] Bluetooth: HCI UART protocol Marvell registered
[   10.281927][    T1] usbcore: registered new interface driver bcm203x
[   10.282466][    T1] usbcore: registered new interface driver bpa10x
[   10.282980][    T1] usbcore: registered new interface driver bfusb
[   10.283524][    T1] usbcore: registered new interface driver btusb
[   10.284124][    T1] usbcore: registered new interface driver ath3k
[   10.284893][    T1] CAPI 2.0 started up with major 68 (middleware)
[   10.285349][    T1] Modular ISDN core version 1.1.29
[   10.285953][    T1] NET: Registered PF_ISDN protocol family
[   10.286365][    T1] DSP module 2.0
[   10.286616][    T1] mISDN_dsp: DSP clocks every 80 samples. This =
equals 1 jiffies.
[   10.292452][    T1] mISDN: Layer-1-over-IP driver Rev. 2.00
[   10.293210][    T1] 0 virtual devices registered
[   10.293646][    T1] usbcore: registered new interface driver =
HFC-S_USB
[   10.294156][    T1] VUB300 Driver rom wait states =3D 1C irqpoll =
timeout =3D 0400
[   10.294800][    T1] usbcore: registered new interface driver vub300
[   10.295837][    T1] usbcore: registered new interface driver ushc
[   10.298463][    T1] iscsi: registered transport (iser)
[   10.300398][    T1] SoftiWARP attached
[   10.307814][    T1] hid: raw HID events driver (C) Jiri Kosina
[   10.318014][    T1] usbcore: registered new interface driver usbhid
[   10.318728][    T1] usbhid: USB HID core driver
[   10.320360][    T1] usbcore: registered new interface driver =
es2_ap_driver
[   10.321162][    T1] comedi: version 0.7.76 - http://www.comedi.org
[   10.322030][    T1] usbcore: registered new interface driver dt9812
[   10.322715][    T1] usbcore: registered new interface driver ni6501
[   10.323253][    T1] usbcore: registered new interface driver usbdux
[   10.323790][    T1] usbcore: registered new interface driver =
usbduxfast
[   10.324386][    T1] usbcore: registered new interface driver =
usbduxsigma
[   10.324981][    T1] usbcore: registered new interface driver vmk80xx
[   10.325689][    T1] usbcore: registered new interface driver =
prism2_usb
[   10.326313][    T1] usbcore: registered new interface driver r8712u
[   10.326811][    T1] greybus: registered new driver hid
[   10.327272][    T1] greybus: registered new driver gbphy
[   10.327851][    T1] gb_gbphy: registered new driver usb
[   10.328401][    T1] asus_wmi: ASUS WMI generic driver loaded
[   10.351727][    T1] usbcore: registered new interface driver =
snd-usb-audio
[   10.352441][    T1] usbcore: registered new interface driver =
snd-ua101
[   10.353011][    T1] usbcore: registered new interface driver =
snd-usb-usx2y
[   10.353722][    T1] usbcore: registered new interface driver =
snd-usb-us122l
[   10.354536][    T1] usbcore: registered new interface driver =
snd-usb-caiaq
[   10.355152][    T1] usbcore: registered new interface driver =
snd-usb-6fire
[   10.355735][    T1] usbcore: registered new interface driver =
snd-usb-hiface
[   10.356304][    T1] usbcore: registered new interface driver =
snd-bcd2000
[   10.356868][    T1] usbcore: registered new interface driver =
snd_usb_pod
[   10.357613][    T1] usbcore: registered new interface driver =
snd_usb_podhd
[   10.358208][    T1] usbcore: registered new interface driver =
snd_usb_toneport
[   10.358778][    T1] usbcore: registered new interface driver =
snd_usb_variax
[   10.359376][    T1] drop_monitor: Initializing network drop monitor =
service
[   10.360007][    T1] NET: Registered PF_LLC protocol family
[   10.360451][    T1] GACT probability on
[   10.360780][    T1] Mirror/redirect action on
[   10.361156][    T1] Simple TC action Loaded
[   10.362349][    T1] netem: version 1.3
[   10.362952][    T1] u32 classifier
[   10.363206][    T1]     Performance counters on
[   10.363532][    T1]     input device check on
[   10.363830][    T1]     Actions configured
[   10.365697][    T1] nf_conntrack_irc: failed to register helpers
[   10.366130][    T1] nf_conntrack_sane: failed to register helpers
[   10.486219][    T1] nf_conntrack_sip: failed to register helpers
[   10.487965][    T1] xt_time: kernel timezone is -0000
[   10.488384][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, =
ESP)
[   10.488885][    T1] IPVS: Connection hash table configured =
(size=3D4096, memory=3D32Kbytes)
[   10.489652][    T1] IPVS: ipvs loaded.
[   10.489926][    T1] IPVS: [rr] scheduler registered.
[   10.490276][    T1] IPVS: [wrr] scheduler registered.
[   10.490638][    T1] IPVS: [lc] scheduler registered.
[   10.490987][    T1] IPVS: [wlc] scheduler registered.
[   10.491341][    T1] IPVS: [fo] scheduler registered.
[   10.491674][    T1] IPVS: [ovf] scheduler registered.
[   10.492028][    T1] IPVS: [lblc] scheduler registered.
[   10.492390][    T1] IPVS: [lblcr] scheduler registered.
[   10.492750][    T1] IPVS: [dh] scheduler registered.
[   10.493090][    T1] IPVS: [sh] scheduler registered.
[   10.493432][    T1] IPVS: [mh] scheduler registered.
[   10.493764][    T1] IPVS: [sed] scheduler registered.
[   10.494130][    T1] IPVS: [nq] scheduler registered.
[   10.494480][    T1] IPVS: [twos] scheduler registered.
[   10.494896][    T1] IPVS: [sip] pe registered.
[   10.495265][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.496542][    T1] gre: GRE over IPv4 demultiplexor driver
[   10.496928][    T1] ip_gre: GRE over IPv4 tunneling driver
[   10.499704][    T1] IPv4 over IPsec tunneling driver
[   10.501212][    T1] Initializing XFRM netlink socket
[   10.501617][    T1] IPsec XFRM device driver
[   10.502074][    T1] NET: Registered PF_INET6 protocol family
[   10.507805][    T1] Segment Routing with IPv6
[   10.508123][    T1] RPL Segment Routing with IPv6
[   10.508486][    T1] In-situ OAM (IOAM) with IPv6
[   10.508890][    T1] mip6: Mobile IPv6
[   10.510190][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling =
driver
[   10.512511][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   10.513782][    T1] NET: Registered PF_PACKET protocol family
[   10.514266][    T1] NET: Registered PF_KEY protocol family
[   10.514747][    T1] Bridge firewalling registered
[   10.515332][    T1] NET: Registered PF_X25 protocol family
[   10.515746][    T1] X25: Linux Version 0.2
[   10.526514][  T131] input: ImExPS/2 Generic Explorer Mouse as =
/devices/platform/i8042/serio1/input/input3
[   10.527007][    T1] NET: Registered PF_NETROM protocol family
[   10.539347][    T1] NET: Registered PF_ROSE protocol family
[   10.539797][    T1] NET: Registered PF_AX25 protocol family
[   10.540205][    T1] can: controller area network core
[   10.540613][    T1] NET: Registered PF_CAN protocol family
[   10.541007][    T1] can: raw protocol
[   10.541281][    T1] can: broadcast manager protocol
[   10.541622][    T1] can: netlink gateway - max_hops=3D1
[   10.541988][    T1] can: SAE J1939
[   10.542240][    T1] can: isotp protocol (max_pdu_size 8300)
[   10.542841][    T1] Bluetooth: RFCOMM TTY layer initialized
[   10.543242][    T1] Bluetooth: RFCOMM socket layer initialized
[   10.543666][    T1] Bluetooth: RFCOMM ver 1.11
[   10.543987][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.544446][    T1] Bluetooth: BNEP filters: protocol multicast
[   10.544884][    T1] Bluetooth: BNEP socket layer initialized
[   10.545278][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   10.545685][    T1] Bluetooth: CMTP socket layer initialized
[   10.546077][    T1] Bluetooth: HIDP (Human Interface Emulation) ver =
1.2
[   10.546539][    T1] Bluetooth: HIDP socket layer initialized
[   10.548688][    T1] NET: Registered PF_RXRPC protocol family
[   10.549086][    T1] Key type rxrpc registered
[   10.549386][    T1] Key type rxrpc_s registered
[   10.549932][    T1] NET: Registered PF_KCM protocol family
[   10.550549][    T1] lec:lane_module_init: lec.c: initialized
[   10.550945][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   10.551377][    T1] l2tp_core: L2TP core driver, V2.0
[   10.551749][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   10.552117][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   10.552561][    T1] l2tp_netlink: L2TP netlink interface
[   10.552965][    T1] l2tp_eth: L2TP ethernet pseudowire support =
(L2TPv3)
[   10.553436][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 =
(L2TPv3)
[   10.553998][    T1] NET: Registered PF_PHONET protocol family
[   10.554490][    T1] 8021q: 802.1Q VLAN Support v1.8
[   10.560560][    T1] DCCP: Activated CCID 2 (TCP-like)
[   10.560945][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate =
Control)
[   10.561481][    T1] DCCP is deprecated and scheduled to be removed in =
2025, please contact the netdev mailing list
[   10.562337][    T1] sctp: Hash tables configured (bind 32/56)
[   10.563310][    T1] NET: Registered PF_RDS protocol family
[   10.563953][    T1] Registered RDS/infiniband transport
[   10.564719][    T1] Registered RDS/tcp transport
[   10.565044][    T1] tipc: Activated (version 2.0.0)
[   10.565576][    T1] NET: Registered PF_TIPC protocol family
[   10.566230][    T1] tipc: Started in single node mode
[   10.566853][    T1] NET: Registered PF_SMC protocol family
[   10.567383][    T1] 9pnet: Installing 9P2000 support
[   10.567918][    T1] NET: Registered PF_CAIF protocol family
[   10.571454][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.571955][    T1] Key type dns_resolver registered
[   10.572308][    T1] Key type ceph registered
[   10.572808][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.573556][    T1] batman_adv: B.A.T.M.A.N. advanced 2023.1 =
(compatibility version 15) loaded
[   10.574366][    T1] openvswitch: Open vSwitch switching datapath
[   10.576268][    T1] NET: Registered PF_VSOCK protocol family
[   10.576805][    T1] mpls_gso: MPLS GSO support
[   10.578616][    T1] start plist test
[   10.581415][    T1] end plist test
[   10.586190][    T1] IPI shorthand broadcast: enabled
[   10.586585][    T1] AVX2 version of gcm_enc/dec engaged.
[   10.587125][    T1] AES CTR mode by8 optimization enabled
[   10.600860][ T2883] kworker/u17:1 (2883) used greatest stack depth: =
26824 bytes left
[   10.711074][    T1] sched_clock: Marking stable (10700004466, =
4015295)->(10629140344, 74879417)
[   10.712208][    T1] registered taskstats version 1
[   10.715463][    T1] Loading compiled-in X.509 certificates
[   10.718211][    T1] Loaded X.509 cert 'Build time autogenerated =
kernel key: 70362406141ebc4a7eb396b230e5abda92294c78'
[   10.721274][    T1] zswap: loaded using pool lzo/zbud
[   10.779096][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: =
Validating architecture page table helpers
[   11.381105][    T1] Key type .fscrypt registered
[   11.381459][    T1] Key type fscrypt-provisioning registered
[   11.383783][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   11.389407][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, =
zoned=3Dyes, fsverity=3Dyes
[   11.390120][    T1] Key type big_key registered
[   11.392180][    T1] Key type encrypted registered
[   11.392587][    T1] AppArmor: AppArmor sha1 policy hashing enabled
[   11.393180][    T1] ima: No TPM chip found, activating TPM-bypass!
[   11.393678][    T1] Loading compiled-in module X.509 certificates
[   11.395852][    T1] Loaded X.509 cert 'Build time autogenerated =
kernel key: 70362406141ebc4a7eb396b230e5abda92294c78'
[   11.396613][    T1] ima: Allocated hash algorithm: sha256
[   11.397085][    T1] ima: No architecture policies found
[   11.397521][    T1] evm: Initialising EVM extended attributes:
[   11.397932][    T1] evm: security.selinux (disabled)
[   11.398273][    T1] evm: security.SMACK64 (disabled)
[   11.398614][    T1] evm: security.SMACK64EXEC (disabled)
[   11.398989][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   11.399386][    T1] evm: security.SMACK64MMAP (disabled)
[   11.399762][    T1] evm: security.apparmor
[   11.400049][    T1] evm: security.ima
[   11.400311][    T1] evm: security.capability
[   11.400607][    T1] evm: HMAC attrs: 0x1
[   11.401554][    T1] PM:   Magic number: 11:292:970
[   11.402051][    T1] bdi 2:0: hash matches
[   11.402958][    T1] printk: console [netcon0] enabled
[   11.403328][    T1] netconsole: network logging started
[   11.403853][    T1] gtp: GTP module loaded (pdp ctx size 104 bytes)
[   11.404588][    T1] rdma_rxe: loaded
[   11.405075][    T1] cfg80211: Loading compiled-in X.509 certificates =
for regulatory database
[   11.406575][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   11.407522][ T2589] platform regulatory.0: Direct firmware load for =
regulatory.db failed with error -2
[   11.408216][ T2589] platform regulatory.0: Falling back to sysfs =
fallback for: regulatory.db
[   11.410010][    T1] clk: Disabling unused clocks
[   11.410395][    T1] ALSA device list:
[   11.410664][    T1]   #0: Dummy 1
[   11.410891][    T1]   #1: Loopback 1
[   11.411135][    T1]   #2: Virtual MIDI Card 1
[   11.412404][    T1] md: Waiting for all devices to be available =
before autodetect
[   11.412814][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   11.413161][    T1] md: Autodetecting RAID arrays.
[   11.413433][    T1] md: autorun ...
[   11.413630][    T1] md: ... autorun DONE.
[   11.437984][    T1] EXT4-fs (sda1): INFO: recovery required on =
readonly filesystem
[   11.438426][    T1] EXT4-fs (sda1): write access will be enabled =
during recovery
[   11.464527][    T1] EXT4-fs (sda1): recovery complete
[   11.466788][    T1] EXT4-fs (sda1): mounted filesystem =
5941fea2-f5fa-4b4e-b5ef-9af118b27b95 ro with ordered data mode. Quota =
mode: none.
[   11.468073][    T1] VFS: Mounted root (ext4 filesystem) readonly on =
device 8:1.
[   11.469617][    T1] devtmpfs: mounted
[   11.518640][    T1] Freeing unused kernel image (initmem) memory: =
3296K
[   11.644092][    T1] Write protecting the kernel read-only data: =
184320k
[   11.647180][    T1] Freeing unused kernel image (rodata/data gap) =
memory: 1264K
[   11.723640][    T1] x86/mm: Checked W+X mappings: passed, no W+X =
pages found.
[   11.725820][    T1] Failed to set sysctl parameter =
'max_rcu_stall_to_panic=3D1': parameter not found
[   11.726697][    T1] Run /sbin/init as init process
[   11.727069][    T1]   with arguments:
[   11.727075][    T1]     /sbin/init
[   11.727083][    T1]   with environment:
[   11.727091][    T1]     HOME=3D/
[   11.727096][    T1]     TERM=3Dlinux
[   11.727101][    T1]     spec_store_bypass_disable=3Dprctl
[   11.811714][ T4530] mount (4530) used greatest stack depth: 24496 =
bytes left
[   11.832654][ T4531] EXT4-fs (sda1): re-mounted =
5941fea2-f5fa-4b4e-b5ef-9af118b27b95 r/w. Quota mode: none.
[   11.852842][ T4534] mkdir (4534) used greatest stack depth: 24400 =
bytes left
[   11.898037][ T4535] mount (4535) used greatest stack depth: 23264 =
bytes left
[   12.329942][ T4565] udevd[4565]: starting version 3.2.11
[   12.369891][ T4565] udevd (4565) used greatest stack depth: 23216 =
bytes left
[   12.370515][ T4566] udevd[4566]: starting eudev-3.2.11
[   15.250397][ T4795] 8021q: adding VLAN 0 to HW filter on device bond0
[   15.252536][ T4795] eql: remember to turn off Van-Jacobson =
compression on your slave devices
[   15.266469][ T4795] 8021q: adding VLAN 0 to HW filter on device eth0
[   15.275064][   T24] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, =
Flow Control: RX
[   15.276836][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes =
ready
[   75.765145][ T2589] cfg80211: failed to load regulatory.db
[ 1570.027166][ T5236] chnl_net:caif_netlink_parms(): no params data =
found
[ 1570.053944][ T5236] bridge0: port 1(bridge_slave_0) entered blocking =
state
[ 1570.054442][ T5236] bridge0: port 1(bridge_slave_0) entered disabled =
state
[ 1570.054941][ T5236] bridge_slave_0: entered allmulticast mode
[ 1570.055479][ T5236] bridge_slave_0: entered promiscuous mode
[ 1570.056707][ T5236] bridge0: port 2(bridge_slave_1) entered blocking =
state
[ 1570.057083][ T5236] bridge0: port 2(bridge_slave_1) entered disabled =
state
[ 1570.057466][ T5236] bridge_slave_1: entered allmulticast mode
[ 1570.057974][ T5236] bridge_slave_1: entered promiscuous mode
[ 1570.071908][ T5236] bond0: (slave bond_slave_0): Enslaving as an =
active interface with an up link
[ 1570.073411][ T5236] bond0: (slave bond_slave_1): Enslaving as an =
active interface with an up link
[ 1570.089529][ T5236] team0: Port device team_slave_0 added
[ 1570.091237][ T5236] team0: Port device team_slave_1 added
[ 1570.104521][ T5236] batman_adv: batadv0: Adding interface: =
batadv_slave_0
[ 1570.104890][ T5236] batman_adv: batadv0: The MTU of interface =
batadv_slave_0 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.
[ 1570.106176][ T5236] batman_adv: batadv0: Not using interface =
batadv_slave_0 (retrying later): interface not active
[ 1570.107468][ T5236] batman_adv: batadv0: Adding interface: =
batadv_slave_1
[ 1570.107844][ T5236] batman_adv: batadv0: The MTU of interface =
batadv_slave_1 is too small (1500) to handle the transport of batman-adv =
packets. Packets going over this interface will be fragmented on layer2 =
which could impact the performance. Setting the MTU to 1560 would solve =
the problem.
[ 1570.109122][ T5236] batman_adv: batadv0: Not using interface =
batadv_slave_1 (retrying later): interface not active
[ 1570.121355][ T5236] hsr_slave_0: entered promiscuous mode
[ 1570.121856][ T5236] hsr_slave_1: entered promiscuous mode
[ 1570.157716][ T5236] netdevsim netdevsim0 netdevsim0: renamed from =
eth0
[ 1570.159401][ T5236] netdevsim netdevsim0 netdevsim1: renamed from =
eth1
[ 1570.160465][ T5236] netdevsim netdevsim0 netdevsim2: renamed from =
eth2
[ 1570.161558][ T5236] netdevsim netdevsim0 netdevsim3: renamed from =
eth3
[ 1570.167115][ T5236] bridge0: port 2(bridge_slave_1) entered blocking =
state
[ 1570.167541][ T5236] bridge0: port 2(bridge_slave_1) entered =
forwarding state
[ 1570.168056][ T5236] bridge0: port 1(bridge_slave_0) entered blocking =
state
[ 1570.168445][ T5236] bridge0: port 1(bridge_slave_0) entered =
forwarding state
[ 1570.180359][ T5236] 8021q: adding VLAN 0 to HW filter on device bond0
[ 1570.182526][ T5246] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link =
becomes ready
[ 1570.183700][ T5246] bridge0: port 1(bridge_slave_0) entered disabled =
state
[ 1570.184662][ T5246] bridge0: port 2(bridge_slave_1) entered disabled =
state
[ 1570.185390][ T5246] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link =
becomes ready
[ 1570.187900][ T5236] 8021q: adding VLAN 0 to HW filter on device team0
[ 1570.200494][ T5236] hsr0: Slave A (hsr_slave_0) is not up; please =
bring it up to get a fully working HSR network
[ 1570.201597][ T5236] hsr0: Slave B (hsr_slave_1) is not up; please =
bring it up to get a fully working HSR network
[ 1570.206557][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: =
link becomes ready
[ 1570.207644][   T24] bridge0: port 1(bridge_slave_0) entered blocking =
state
[ 1570.208430][   T24] bridge0: port 1(bridge_slave_0) entered =
forwarding state
[ 1570.209421][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: =
link becomes ready
[ 1570.210570][   T24] bridge0: port 2(bridge_slave_1) entered blocking =
state
[ 1570.211395][   T24] bridge0: port 2(bridge_slave_1) entered =
forwarding state
[ 1570.212818][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link =
becomes ready
[ 1570.214122][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link =
becomes ready
[ 1570.215308][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link =
becomes ready
[ 1570.216338][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link =
becomes ready
[ 1570.217985][ T5249] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes =
ready
[ 1570.219049][ T5249] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link =
becomes ready
[ 1570.222327][  T133] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link =
becomes ready
[ 1570.223011][  T133] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link =
becomes ready
[ 1570.227121][ T5236] 8021q: adding VLAN 0 to HW filter on device =
batadv0
[ 1570.233359][  T133] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: =
link becomes ready
[ 1570.241443][ T5236] veth0_vlan: entered promiscuous mode
[ 1570.244824][ T5236] veth1_vlan: entered promiscuous mode
[ 1570.253615][ T5236] veth0_macvtap: entered promiscuous mode
[ 1570.255067][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link =
becomes ready
[ 1570.255930][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link =
becomes ready
[ 1570.256554][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link =
becomes ready
[ 1570.257252][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link =
becomes ready
[ 1570.258364][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link =
becomes ready
[ 1570.259952][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: =
link becomes ready
[ 1570.261135][ T5251] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link =
becomes ready
[ 1570.263892][ T5236] veth1_macvtap: entered promiscuous mode
[ 1570.271006][ T5236] batman_adv: batadv0: Interface activated: =
batadv_slave_0
[ 1570.271924][  T131] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: =
link becomes ready
[ 1570.275588][ T5236] batman_adv: batadv0: Interface activated: =
batadv_slave_1
[ 1570.276368][  T134] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: =
link becomes ready
[ 1570.278586][ T5236] netdevsim netdevsim0 netdevsim0: set [1, 0] type =
2 family 0 port 6081 - 0
[ 1570.279627][ T5236] netdevsim netdevsim0 netdevsim1: set [1, 0] type =
2 family 0 port 6081 - 0
[ 1570.280567][ T5236] netdevsim netdevsim0 netdevsim2: set [1, 0] type =
2 family 0 port 6081 - 0
[ 1570.281507][ T5236] netdevsim netdevsim0 netdevsim3: set [1, 0] type =
2 family 0 port 6081 - 0
[ 1571.764832][ T5256]
[ 1571.764989][ T5256] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[ 1571.765347][ T5256] WARNING: possible circular locking dependency =
detected
[ 1571.765711][ T5256] 6.4.0-rc6-00195-g40f71e7cd3c6 #4 Not tainted
[ 1571.766031][ T5256] =
------------------------------------------------------
[ 1571.766396][ T5256] repro/5256 is trying to acquire lock:
[ 1571.766688][ T5256] ffff888122d0f5c8 =
(&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: j1939_sk_queue_drop_all =
(net/can/j1939/socket.c:140)=20
[ 1571.767294][ T5256]
[ 1571.767294][ T5256] but task is already holding lock:
[ 1571.767699][ T5256] ffff88816bc010d0 =
(&priv->j1939_socks_lock){+.-.}-{2:2}, at: j1939_sk_netdev_event_netdown =
(net/can/j1939/socket.c:1275)=20
[ 1571.768294][ T5256]
[ 1571.768294][ T5256] which lock already depends on the new lock.
[ 1571.768294][ T5256]
[ 1571.768839][ T5256]
[ 1571.768839][ T5256] the existing dependency chain (in reverse order) =
is:
[ 1571.769305][ T5256]
[ 1571.769305][ T5256] -> #2 (&priv->j1939_socks_lock){+.-.}-{2:2}:
[ 1571.769750][ T5256] _raw_spin_lock_bh =
(./include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178)=20=

[ 1571.770042][ T5256] j1939_sk_errqueue (net/can/j1939/socket.c:1082)=20=

[ 1571.770334][ T5256] j1939_session_destroy =
(net/can/j1939/transport.c:271)=20
[ 1571.770648][ T5256] j1939_session_deactivate_locked =
(net/can/j1939/transport.c:295 ./include/linux/kref.h:65 =
net/can/j1939/transport.c:299 net/can/j1939/transport.c:1086 =
net/can/j1939/transport.c:1074)=20
[ 1571.771016][ T5256] j1939_cancel_active_session =
(net/can/j1939/transport.c:2194)=20
[ 1571.771357][ T5256] j1939_netdev_notify (net/can/j1939/main.c:381)=20
[ 1571.771661][ T5256] notifier_call_chain (kernel/notifier.c:95)=20
[ 1571.771961][ T5256] call_netdevice_notifiers_info =
(net/core/dev.c:1935)=20
[ 1571.772308][ T5256] dev_close_many (net/core/dev.c:1529)=20
[ 1571.772595][ T5256] unregister_netdevice_many_notify =
(net/core/dev.c:10859)=20
[ 1571.772976][ T5256] rtnl_dellink (net/core/rtnetlink.c:3212 =
net/core/rtnetlink.c:3262)=20
[ 1571.773264][ T5256] rtnetlink_rcv_msg (net/core/rtnetlink.c:6417)=20
[ 1571.773571][ T5256] netlink_rcv_skb (net/netlink/af_netlink.c:2547)=20=

[ 1571.773880][ T5256] netlink_unicast (net/netlink/af_netlink.c:1340 =
net/netlink/af_netlink.c:1365)=20
[ 1571.774196][ T5256] netlink_sendmsg (net/netlink/af_netlink.c:1913)=20=

[ 1571.774497][ T5256] sock_sendmsg (net/socket.c:727 net/socket.c:747)=20=

[ 1571.774775][ T5256] ____sys_sendmsg (net/socket.c:2503)=20
[ 1571.775075][ T5256] ___sys_sendmsg (net/socket.c:2559)=20
[ 1571.775372][ T5256] __sys_sendmsg (net/socket.c:2588)=20
[ 1571.775658][ T5256] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 1571.775936][ T5256] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[ 1571.776295][ T5256]
[ 1571.776295][ T5256] -> #1 =
(&priv->active_session_list_lock){+.-.}-{2:2}:
[ 1571.776796][ T5256] _raw_spin_lock_bh =
(./include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178)=20=

[ 1571.777096][ T5256] j1939_session_activate =
(net/can/j1939/transport.c:1565)=20
[ 1571.777426][ T5256] j1939_sk_queue_activate_next =
(net/can/j1939/socket.c:181 net/can/j1939/socket.c:208)=20
[ 1571.777788][ T5256] j1939_session_completed =
(net/can/j1939/transport.c:1223)=20
[ 1571.778119][ T5256] j1939_xtp_rx_eoma (./include/linux/kref.h:64 =
net/can/j1939/transport.c:299 net/can/j1939/transport.c:1411)=20
[ 1571.778421][ T5256] j1939_tp_recv (net/can/j1939/transport.c:2149)=20
[ 1571.778711][ T5256] j1939_can_recv (net/can/j1939/main.c:112 =
net/can/j1939/main.c:38)=20
[ 1571.779007][ T5256] can_rcv_filter (net/can/af_can.c:573 =
net/can/af_can.c:606)=20
[ 1571.779293][ T5256] can_receive (net/can/af_can.c:663)=20
[ 1571.779575][ T5256] can_rcv (net/can/af_can.c:688)=20
[ 1571.779838][ T5256] __netif_receive_skb_one_core =
(net/core/dev.c:5493)=20
[ 1571.780198][ T5256] __netif_receive_skb (net/core/dev.c:5607)=20
[ 1571.780520][ T5256] process_backlog (./include/linux/rcupdate.h:802 =
net/core/dev.c:5936)=20
[ 1571.780821][ T5256] __napi_poll.constprop.0 (net/core/dev.c:6499)=20
[ 1571.781147][ T5256] net_rx_action (net/core/dev.c:6567 =
net/core/dev.c:6698)=20
[ 1571.781438][ T5256] __do_softirq =
(./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 =
./include/trace/events/irq.h:142 kernel/softirq.c:572)=20
[ 1571.781719][ T5256] run_ksoftirqd (kernel/softirq.c:425 =
kernel/softirq.c:940 kernel/softirq.c:931)=20
[ 1571.781997][ T5256] smpboot_thread_fn (kernel/smpboot.c:164 =
(discriminator 3))=20
[ 1571.782296][ T5256] kthread (kernel/kthread.c:379)=20
[ 1571.782563][ T5256] ret_from_fork (arch/x86/entry/entry_64.S:314)=20
[ 1571.782844][ T5256]
[ 1571.782844][ T5256] -> #0 (&jsk->sk_session_queue_lock){+.-.}-{2:2}:
[ 1571.783330][ T5256] __lock_acquire (kernel/locking/lockdep.c:3114 =
kernel/locking/lockdep.c:3232 kernel/locking/lockdep.c:3847 =
kernel/locking/lockdep.c:5088)=20
[ 1571.783640][ T5256] lock_acquire (kernel/locking/lockdep.c:467 =
kernel/locking/lockdep.c:5707 kernel/locking/lockdep.c:5670)=20
[ 1571.783922][ T5256] _raw_spin_lock_bh =
(./include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178)=20=

[ 1571.784223][ T5256] j1939_sk_queue_drop_all =
(net/can/j1939/socket.c:140)=20
[ 1571.784552][ T5256] j1939_sk_netdev_event_netdown =
(net/can/j1939/socket.c:1275 (discriminator 2))=20
[ 1571.784910][ T5256] j1939_netdev_notify (net/can/j1939/main.c:382)=20
[ 1571.785228][ T5256] notifier_call_chain (kernel/notifier.c:95)=20
[ 1571.785552][ T5256] call_netdevice_notifiers_info =
(net/core/dev.c:1935)=20
[ 1571.785912][ T5256] dev_close_many (net/core/dev.c:1529)=20
[ 1571.786206][ T5256] unregister_netdevice_many_notify =
(net/core/dev.c:10859)=20
[ 1571.786592][ T5256] rtnl_dellink (net/core/rtnetlink.c:3212 =
net/core/rtnetlink.c:3262)=20
[ 1571.786872][ T5256] rtnetlink_rcv_msg (net/core/rtnetlink.c:6417)=20
[ 1571.787190][ T5256] netlink_rcv_skb (net/netlink/af_netlink.c:2547)=20=

[ 1571.787487][ T5256] netlink_unicast (net/netlink/af_netlink.c:1340 =
net/netlink/af_netlink.c:1365)=20
[ 1571.787782][ T5256] netlink_sendmsg (net/netlink/af_netlink.c:1913)=20=

[ 1571.788084][ T5256] sock_sendmsg (net/socket.c:727 net/socket.c:747)=20=

[ 1571.788369][ T5256] ____sys_sendmsg (net/socket.c:2503)=20
[ 1571.788669][ T5256] ___sys_sendmsg (net/socket.c:2559)=20
[ 1571.788969][ T5256] __sys_sendmsg (net/socket.c:2588)=20
[ 1571.789247][ T5256] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 1571.789529][ T5256] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[ 1571.789888][ T5256]
[ 1571.789888][ T5256] other info that might help us debug this:
[ 1571.789888][ T5256]
[ 1571.790455][ T5256] Chain exists of:
[ 1571.790455][ T5256]   &jsk->sk_session_queue_lock --> =
&priv->active_session_list_lock --> &priv->j1939_socks_lock
[ 1571.790455][ T5256]
[ 1571.791339][ T5256]  Possible unsafe locking scenario:
[ 1571.791339][ T5256]
[ 1571.791761][ T5256]        CPU0                    CPU1
[ 1571.792065][ T5256]        ----                    ----
[ 1571.792358][ T5256]   lock(&priv->j1939_socks_lock);
[ 1571.792650][ T5256]                                =
lock(&priv->active_session_list_lock);
[ 1571.793115][ T5256]                                =
lock(&priv->j1939_socks_lock);
[ 1571.793542][ T5256]   lock(&jsk->sk_session_queue_lock);
[ 1571.793848][ T5256]
[ 1571.793848][ T5256]  *** DEADLOCK ***
[ 1571.793848][ T5256]
[ 1571.794304][ T5256] 2 locks held by repro/5256:
[ 1571.794564][ T5256] #0: ffffffff8e118ce8 (rtnl_mutex){+.+.}-{3:3}, =
at: rtnetlink_rcv_msg (net/core/rtnetlink.c:6415)=20
[ 1571.795105][ T5256] #1: ffff88816bc010d0 =
(&priv->j1939_socks_lock){+.-.}-{2:2}, at: j1939_sk_netdev_event_netdown =
(net/can/j1939/socket.c:1275)=20
[ 1571.795749][ T5256]
[ 1571.795749][ T5256] stack backtrace:
[ 1571.796069][ T5256] CPU: 7 PID: 5256 Comm: repro Not tainted =
6.4.0-rc6-00195-g40f71e7cd3c6 #4
[ 1571.796539][ T5256] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.15.0-1 04/01/2014
[ 1571.797050][ T5256] Call Trace:
[ 1571.797233][ T5256]  <TASK>
[ 1571.797400][ T5256] dump_stack_lvl (lib/dump_stack.c:107)=20
[ 1571.797666][ T5256] check_noncircular (kernel/locking/lockdep.c:2188)=20=

[ 1571.797952][ T5256] ? print_circular_bug =
(kernel/locking/lockdep.c:2167)=20
[ 1571.798253][ T5256] ? stack_trace_save (kernel/stacktrace.c:123)=20
[ 1571.798525][ T5256] ? kasan_save_free_info (mm/kasan/generic.c:523)=20=

[ 1571.798818][ T5256] ? j1939_session_deactivate_locked =
(net/can/j1939/transport.c:295 ./include/linux/kref.h:65 =
net/can/j1939/transport.c:299 net/can/j1939/transport.c:1086 =
net/can/j1939/transport.c:1074)=20
[ 1571.799180][ T5256] ? j1939_cancel_active_session =
(net/can/j1939/transport.c:2194)=20
[ 1571.799514][ T5256] ? j1939_netdev_notify (net/can/j1939/main.c:381)=20=

[ 1571.799816][ T5256] __lock_acquire (kernel/locking/lockdep.c:3114 =
kernel/locking/lockdep.c:3232 kernel/locking/lockdep.c:3847 =
kernel/locking/lockdep.c:5088)=20
[ 1571.800096][ T5256] ? lockdep_hardirqs_on_prepare =
(kernel/locking/lockdep.c:4944)=20
[ 1571.800434][ T5256] ? lockdep_hardirqs_on_prepare =
(kernel/locking/lockdep.c:4944)=20
[ 1571.800771][ T5256] lock_acquire (kernel/locking/lockdep.c:467 =
kernel/locking/lockdep.c:5707 kernel/locking/lockdep.c:5670)=20
[ 1571.801028][ T5256] ? j1939_sk_queue_drop_all =
(net/can/j1939/socket.c:140)=20
[ 1571.801338][ T5256] ? lock_sync (kernel/locking/lockdep.c:5673)=20
[ 1571.801591][ T5256] ? find_held_lock (kernel/locking/lockdep.c:5195)=20=

[ 1571.801865][ T5256] ? sock_def_error_report =
(./include/linux/rcupdate.h:805 net/core/sock.c:3276)=20
[ 1571.802169][ T5256] ? lock_downgrade (kernel/locking/lockdep.c:5713)=20=

[ 1571.802444][ T5256] _raw_spin_lock_bh =
(./include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178)=20=

[ 1571.802706][ T5256] ? j1939_sk_queue_drop_all =
(net/can/j1939/socket.c:140)=20
[ 1571.803021][ T5256] j1939_sk_queue_drop_all =
(net/can/j1939/socket.c:140)=20
[ 1571.803322][ T5256] j1939_sk_netdev_event_netdown =
(net/can/j1939/socket.c:1275 (discriminator 2))=20
[ 1571.803659][ T5256] j1939_netdev_notify (net/can/j1939/main.c:382)=20
[ 1571.803951][ T5256] notifier_call_chain (kernel/notifier.c:95)=20
[ 1571.804238][ T5256] ? j1939_priv_get_by_ndev_locked =
(net/can/j1939/main.c:366)=20
[ 1571.804582][ T5256] call_netdevice_notifiers_info =
(net/core/dev.c:1935)=20
[ 1571.804921][ T5256] dev_close_many (net/core/dev.c:1529)=20
[ 1571.805183][ T5256] ? lockdep_hardirqs_on_prepare =
(kernel/locking/lockdep.c:4944)=20
[ 1571.805514][ T5256] ? lock_downgrade (kernel/locking/lockdep.c:5713)=20=

[ 1571.805792][ T5256] ? __dev_close_many (net/core/dev.c:1516)=20
[ 1571.806074][ T5256] ? __nla_validate_parse (lib/nlattr.c:577)=20
[ 1571.806385][ T5256] unregister_netdevice_many_notify =
(net/core/dev.c:10859)=20
[ 1571.806737][ T5256] ? mutex_is_locked =
(./arch/x86/include/asm/atomic64_64.h:22 =
./include/linux/atomic/atomic-long.h:29 =
./include/linux/atomic/atomic-instrumented.h:1310 =
kernel/locking/mutex.c:81 kernel/locking/mutex.c:91)=20
[ 1571.807006][ T5256] ? unregister_netdevice_queue =
(net/core/dev.c:10811)=20
[ 1571.807331][ T5256] ? netdev_freemem (net/core/dev.c:10827)=20
[ 1571.807594][ T5256] ? vxcan_get_link_net =
(drivers/net/can/vxcan.c:270)=20
[ 1571.807891][ T5256] rtnl_dellink (net/core/rtnetlink.c:3212 =
net/core/rtnetlink.c:3262)=20
[ 1571.808149][ T5256] ? __lock_acquire =
(./arch/x86/include/asm/bitops.h:228 ./arch/x86/include/asm/bitops.h:240 =
./include/asm-generic/bitops/instrumented-non-atomic.h:142 =
kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:3759 =
kernel/locking/lockdep.c:3815 kernel/locking/lockdep.c:5088)=20
[ 1571.808425][ T5256] ? rtnl_dellinkprop (net/core/rtnetlink.c:3218)=20
[ 1571.808706][ T5256] ? rtnetlink_rcv_msg (net/core/rtnetlink.c:6415)=20=

[ 1571.808990][ T5256] ? mutex_lock_io_nested =
(kernel/locking/mutex.c:746)=20
[ 1571.809301][ T5256] ? rtnetlink_rcv_msg =
(./include/linux/rcupdate.h:805 net/core/rtnetlink.c:6412)=20
[ 1571.809592][ T5256] ? lock_downgrade (kernel/locking/lockdep.c:5713)=20=

[ 1571.809863][ T5256] ? rtnl_dellinkprop (net/core/rtnetlink.c:3218)=20
[ 1571.810134][ T5256] rtnetlink_rcv_msg (net/core/rtnetlink.c:6417)=20
[ 1571.810411][ T5256] ? rtnl_getlink (net/core/rtnetlink.c:6313)=20
[ 1571.810671][ T5256] ? __sys_sendmsg (net/socket.c:2588)=20
[ 1571.810934][ T5256] ? do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 1571.811190][ T5256] ? netdev_core_pick_tx (net/core/dev.c:4151)=20
[ 1571.811494][ T5256] netlink_rcv_skb (net/netlink/af_netlink.c:2547)=20=

[ 1571.811772][ T5256] ? rtnl_getlink (net/core/rtnetlink.c:6313)=20
[ 1571.812038][ T5256] ? netlink_ack (net/netlink/af_netlink.c:2523)=20
[ 1571.812313][ T5256] ? netlink_deliver_tap =
(./include/linux/rcupdate.h:332 ./include/linux/rcupdate.h:806 =
net/netlink/af_netlink.c:340)=20
[ 1571.812610][ T5256] netlink_unicast (net/netlink/af_netlink.c:1340 =
net/netlink/af_netlink.c:1365)=20
[ 1571.812883][ T5256] ? netlink_attachskb =
(net/netlink/af_netlink.c:1350)=20
[ 1571.813168][ T5256] ? __virt_addr_valid (arch/x86/mm/physaddr.c:66)=20=

[ 1571.813454][ T5256] ? __phys_addr_symbol (arch/x86/mm/physaddr.c:42 =
(discriminator 2))=20
[ 1571.813735][ T5256] ? __check_object_size (mm/usercopy.c:113 =
mm/usercopy.c:145 mm/usercopy.c:254 mm/usercopy.c:213)=20
[ 1571.814029][ T5256] netlink_sendmsg (net/netlink/af_netlink.c:1913)=20=

[ 1571.814302][ T5256] ? netlink_unicast (net/netlink/af_netlink.c:1832)=20=

[ 1571.814580][ T5256] ? import_ubuf (lib/iov_iter.c:1992)=20
[ 1571.814836][ T5256] ? bpf_lsm_socket_sendmsg =
(./include/linux/lsm_hook_defs.h:301)=20
[ 1571.815131][ T5256] ? netlink_unicast (net/netlink/af_netlink.c:1832)=20=

[ 1571.815410][ T5256] sock_sendmsg (net/socket.c:727 net/socket.c:747)=20=

[ 1571.815657][ T5256] ____sys_sendmsg (net/socket.c:2503)=20
[ 1571.815927][ T5256] ? kernel_sendmsg (net/socket.c:2450)=20
[ 1571.816188][ T5256] ? __copy_msghdr (net/socket.c:2430)=20
[ 1571.816455][ T5256] ___sys_sendmsg (net/socket.c:2559)=20
[ 1571.816715][ T5256] ? do_recvmmsg (net/socket.c:2546)=20
[ 1571.816967][ T5256] ? find_held_lock (kernel/locking/lockdep.c:5195)=20=

[ 1571.817236][ T5256] ? __might_fault (mm/memory.c:5732 =
mm/memory.c:5725)=20
[ 1571.817502][ T5256] ? lock_downgrade (kernel/locking/lockdep.c:5713)=20=

[ 1571.817782][ T5256] ? __fget_light (fs/file.c:1027)=20
[ 1571.818045][ T5256] __sys_sendmsg (net/socket.c:2588)=20
[ 1571.818292][ T5256] ? __sys_sendmsg_sock (net/socket.c:2574)=20
[ 1571.818570][ T5256] ? fd_install (./include/linux/rcupdate.h:888 =
fs/file.c:623)=20
[ 1571.818824][ T5256] ? syscall_enter_from_user_mode =
(./arch/x86/include/asm/irqflags.h:42 =
./arch/x86/include/asm/irqflags.h:77 kernel/entry/common.c:111)=20
[ 1571.819154][ T5256] do_syscall_64 (arch/x86/entry/common.c:50 =
arch/x86/entry/common.c:80)=20
[ 1571.819402][ T5256] entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:120)=20
[ 1571.819725][ T5256] RIP: 0033:0x7f97bf1be6a9
[ 1571.819965][ T5256] Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 =
89 01 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	5c                   	pop    %rsp
   1:	c3                   	ret   =20
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00=20
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall=20
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		=
<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret   =20
  33:	48 8b 0d 4f 37 0d 00 	mov    0xd374f(%rip),%rcx        # =
0xd3789
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret   =20
   9:	48 8b 0d 4f 37 0d 00 	mov    0xd374f(%rip),%rcx        # =
0xd375f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[ 1571.821018][ T5256] RSP: 002b:00007ffc5e6c7c68 EFLAGS: 00000246 =
ORIG_RAX: 000000000000002e
[ 1571.821480][ T5256] RAX: ffffffffffffffda RBX: 00005624aff57bf8 RCX: =
00007f97bf1be6a9
[ 1571.821918][ T5256] RDX: 0000000000000000 RSI: 00000000200002c0 RDI: =
0000000000000008
[ 1571.822351][ T5256] RBP: 00007ffc5e6c7d30 R08: 00000000aff55129 R09: =
00000000aff55129
[ 1571.822789][ T5256] R10: 00000000aff55129 R11: 0000000000000246 R12: =
00007ffc5e6c7ea8
[ 1571.823221][ T5256] R13: 00007ffc5e6c7eb8 R14: 00005624aff54e41 R15: =
00007f97bf2d1a80
[ 1571.823651][ T5256]  </TASK>
[ 1714.684396][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 1854.874228][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 1995.104385][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 2135.334473][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 2275.584115][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 2415.814417][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 2555.834429][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2
[ 2695.974422][ T5256] unregister_netdevice: waiting for vxcan0 to =
become free. Usage count =3D 2

--Apple-Mail=_A7A721A2-6107-46CE-9A0C-0DBF80868EE4--

