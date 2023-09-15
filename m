Return-Path: <netdev+bounces-34203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54F7A2AE3
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF201C20B4A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43B18E1B;
	Fri, 15 Sep 2023 23:12:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2D18E27
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 23:12:12 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAB3186
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:12:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f71b25a99so2524689f8f.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694819526; x=1695424326; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPbfqvYy13aoZ1ea+jFYAjstBU5hjGrzyMyws77GmUw=;
        b=KP0L+zrCboWwIdHdewwMahzo28B2GL2rNCss3UN3XtujR2jENtbPPDaov+xV5M/s0B
         sWvoRjVJWOE9j5VLxpglOcsPQV55V2ynvZc5gGtuqz7efwYKpbFNdvPr8EinuQbtzJgP
         VJSosOGIYVpQt0w/xI9t3cXhuTy7Mp7darJFyEtASC6fJsctKERDCFlUEqTlCxQ9R2zX
         tcUt9T8WBkPT2venqjNiRldRotQJa+oEjSqH0V4wiwTRfD6sVzxzXbx8wMaMG2P1v2gX
         ofaLumf2n+IwSgQ1jslEMUht94bSKuFbQOzSDEiXMF7ZptMlPjNbOcxq9oO1cfYFkbZ9
         p3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694819526; x=1695424326;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPbfqvYy13aoZ1ea+jFYAjstBU5hjGrzyMyws77GmUw=;
        b=Ppd/Zclq4Lz2mYfR5bYDXLAx9FfQ/yFFMn4BUhyLxpKRc6QZo8k7ljDxdXmzTNgt/5
         ofw2vFH3DWnR3a956vI/Owp/TKZ9oMfU7HXlOKk4fVEhLOxY46ssSNVNu0q1BoaylqS9
         sVusXwjxfsnkbP/00B+zRuOJmk9sgPDIi7qyW/RsUCAWUK2QDiZn1UPOm5oCRrCUv2Ma
         44G6y98o9B3Qh53E6kqOVgQmVLibYNPMMGX27Q2hKl8tEYV81nx7bsO/JPG8On+5Heki
         iZYvE0f50TVxd2/3qRFnuteuB+WFSUEEI42H245t08kqrD+OlVcQHE1r5giVZGRFhlFu
         eZbQ==
X-Gm-Message-State: AOJu0YzwOf7Ad0j8AttX5sHj5wo1e/0IGvB+DWp/gyMxPf7r/OwsxXeE
	9taF701RhVW31sRKYo1RN437hwYcc+c=
X-Google-Smtp-Source: AGHT+IF4xufSQ4qvanp00plZZMMOGgVlD/DP0l23p9+nnXgNPXhEggL3zz3cBqXE2g45G3ZwyynAmQ==
X-Received: by 2002:adf:ec89:0:b0:315:8f4f:81b2 with SMTP id z9-20020adfec89000000b003158f4f81b2mr2594535wrn.64.1694819525447;
        Fri, 15 Sep 2023 16:12:05 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b005255f5735adsm2818904edq.24.2023.09.15.16.12.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Sep 2023 16:12:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
Date: Sat, 16 Sep 2023 02:11:53 +0300
Cc: Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
To: netdev <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

one more log:

Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here =
]------------
Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at =
lib/rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: nft_limit =
nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_xnatlog(O) ipmi_si ipmi_devintf =
ipmi_msghandler rtc_cmos [last unloaded: BNGBOOT(O)]
Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: swapper/5 =
Tainted: G           O       6.5.2 #1
Sep 12 07:37:29  [151563.298975][    C5] Hardware name: Supermicro =
SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
Sep 12 07:37:29  [151563.299091][ C5] RIP: 0010:rcuref_put_slowpath =
(lib/rcuref.c:267 (discriminator 1))
Sep 12 07:37:29  [151563.299185][ C5] Code: 31 c0 eb e2 80 3d c7 b8 e6 =
00 00 74 0a c7 03 00 00 00 e0 31 c0 eb cf 48 c7 c7 9b f5 e2 9f c6 05 ad =
b8 e6 00 01 e8 01 7b c7 ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc =
cc cc cc 48 89 fa 83 e2
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	31 c0                	xor    %eax,%eax
   2:	eb e2                	jmp    0xffffffffffffffe6
   4:	80 3d c7 b8 e6 00 00 	cmpb   $0x0,0xe6b8c7(%rip)        # =
0xe6b8d2
   b:	74 0a                	je     0x17
   d:	c7 03 00 00 00 e0    	movl   $0xe0000000,(%rbx)
  13:	31 c0                	xor    %eax,%eax
  15:	eb cf                	jmp    0xffffffffffffffe6
  17:	48 c7 c7 9b f5 e2 9f 	mov    $0xffffffff9fe2f59b,%rdi
  1e:	c6 05 ad b8 e6 00 01 	movb   $0x1,0xe6b8ad(%rip)        # =
0xe6b8d2
  25:	e8 01 7b c7 ff       	call   0xffffffffffc77b2b
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb df                	jmp    0xd
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	48 89 fa             	mov    %rdi,%rdx
  3e:	83                   	.byte 0x83
  3f:	e2                   	.byte 0xe2

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	eb df                	jmp    0xffffffffffffffe3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	48 89 fa             	mov    %rdi,%rdx
  14:	83                   	.byte 0x83
  15:	e2                   	.byte 0xe2
Sep 12 07:37:29  [151563.299344][    C5] RSP: 0018:ffffad0e0033cde8 =
EFLAGS: 00010296
Sep 12 07:37:29  [151563.299440][    C5] RAX: 0000000000000019 RBX: =
ffffa10ba37ce100 RCX: 00000000fff7ffff
Sep 12 07:37:29  [151563.299558][    C5] RDX: 00000000fff7ffff RSI: =
0000000000000001 RDI: 00000000ffffffea
Sep 12 07:37:29  [151563.299677][    C5] RBP: ffffa10b05c76000 R08: =
0000000000000000 R09: 00000000fff7ffff
Sep 12 07:37:29  [151563.299796][    C5] R10: ffffa1125ae00000 R11: =
0000000000000003 R12: ffffa10b5f1a4ec0
Sep 12 07:37:29  [151563.299914][    C5] R13: 0000000000000000 R14: =
0000000000000258 R15: ffffad0e0033cf60
Sep 12 07:37:29  [151563.300030][    C5] FS:  0000000000000000(0000) =
GS:ffffa1125f740000(0000) knlGS:0000000000000000
Sep 12 07:37:29  [151563.300152][    C5] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 12 07:37:29  [151563.300248][    C5] CR2: 00007fade7f56d40 CR3: =
000000010088e005 CR4: 00000000003706e0
Sep 12 07:37:29  [151563.300363][    C5] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 12 07:37:29  [151563.300478][    C5] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 12 07:37:29  [151563.300593][    C5] Call Trace:
Sep 12 07:37:29  [151563.300683][    C5]  <IRQ>
Sep 12 07:37:29  [151563.300769][ C5] ? __warn (kernel/panic.c:668)
Sep 12 07:37:29  [151563.300861][ C5] ? report_bug (lib/bug.c:223)
Sep 12 07:37:29  [151563.300952][ C5] ? handle_bug =
(arch/x86/kernel/traps.c:324)
Sep 12 07:37:29  [151563.301043][ C5] ? exc_invalid_op =
(arch/x86/kernel/traps.c:345 (discriminator 1))
Sep 12 07:37:29  [151563.301134][ C5] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
Sep 12 07:37:29  [151563.301225][ C5] ? rcuref_put_slowpath =
(lib/rcuref.c:267 (discriminator 1))
Sep 12 07:37:29  [151563.301319][ C5] ? rcuref_put_slowpath =
(lib/rcuref.c:267 (discriminator 1))
Sep 12 07:37:29  [151563.301412][ C5] dst_release =
(./include/linux/rcuref.h:151 net/core/dst.c:166)
Sep 12 07:37:29  [151563.301502][ C5] __dev_queue_xmit =
(net/core/dev.c:4138)
Sep 12 07:37:29  [151563.301595][ C5] ? eth_header =
(net/ethernet/eth.c:83)
Sep 12 07:37:29  [151563.301686][ C5] ip_finish_output2 =
(./include/net/neighbour.h:327 ./include/net/sock.h:2251 =
net/ipv4/ip_output.c:228)
Sep 12 07:37:29  [151563.301778][ C5] process_backlog =
(net/core/dev.c:5451 net/core/dev.c:5566 net/core/dev.c:5895)
Sep 12 07:37:29  [151563.301871][ C5] __napi_poll+0x20/0x180
Sep 12 07:37:29  [151563.301964][ C5] net_rx_action (net/core/dev.c:5839 =
net/core/dev.c:5860 net/core/dev.c:6684)
Sep 12 07:37:29  [151563.302057][ C5] __do_softirq =
(./arch/x86/include/asm/bitops.h:319 kernel/softirq.c:550)
Sep 12 07:37:29  [151563.302150][ C5] do_softirq (kernel/softirq.c:463 =
(discriminator 32))
Sep 12 07:37:29  [151563.302240][    C5]  </IRQ>
Sep 12 07:37:29  [151563.302326][    C5]  <TASK>
Sep 12 07:37:29  [151563.302416][ C5] flush_smp_call_function_queue =
(kernel/smp.c:563 (discriminator 1))
Sep 12 07:37:29  [151563.302518][ C5] do_idle (kernel/sched/idle.c:295)
Sep 12 07:37:29  [151563.302612][ C5] cpu_startup_entry =
(kernel/sched/idle.c:379 (discriminator 1))
Sep 12 07:37:29  [151563.302707][ C5] start_secondary =
(arch/x86/kernel/smpboot.c:326)
Sep 12 07:37:29  [151563.302805][ C5] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
Sep 12 07:37:29  [151563.302900][    C5]  </TASK>
Sep 12 07:37:29  [151563.302986][    C5] ---[ end trace 0000000000000000 =
]---
Sep 15 04:32:29  [399661.971344][   C31] kernel tried to execute =
NX-protected page - exploit attempt? (uid: 0)
Sep 15 04:32:29  [399661.971470][   C31] BUG: unable to handle page =
fault for address: ffffa10c52d43058
Sep 15 04:32:29  [399661.971586][   C31] #PF: supervisor instruction =
fetch in kernel mode
Sep 15 04:32:29  [399661.971680][   C31] #PF: error_code(0x0011) - =
permissions violation
Sep 15 04:32:29  [399661.971775][   C31] PGD 12601067 P4D 12601067 PUD =
80000002400001e3
Sep 15 04:32:29  [399661.971871][   C31] Oops: 0011 [#1] PREEMPT SMP
Sep 15 04:32:29  [399661.971963][   C31] CPU: 31 PID: 0 Comm: swapper/31 =
Tainted: G        W  O       6.5.2 #1
Sep 15 04:32:29  [399661.972079][   C31] Hardware name: Supermicro =
SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
Sep 15 04:32:29  [399661.972197][   C31] RIP: 0010:0xffffa10c52d43058
Sep 15 04:32:29  [399661.972289][ C31] Code: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 30 d4 52 0c a1 =
ff ff 00 00 00 00 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
	...
  30:	00 00                	add    %al,(%rax)
  32:	58                   	pop    %rax
  33:	30 d4                	xor    %dl,%ah
  35:*	52                   	push   %rdx		<-- trapping =
instruction
  36:	0c a1                	or     $0xa1,%al
  38:	ff                   	(bad)
  39:	ff 00                	incl   (%rax)
  3b:	00 00                	add    %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	...
   8:	58                   	pop    %rax
   9:	30 d4                	xor    %dl,%ah
   b:	52                   	push   %rdx
   c:	0c a1                	or     $0xa1,%al
   e:	ff                   	(bad)
   f:	ff 00                	incl   (%rax)
  11:	00 00                	add    %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
Sep 15 04:32:29  [399661.972448][   C31] RSP: 0018:ffffad0e0097ccc8 =
EFLAGS: 00010282
Sep 15 04:32:29  [399661.972543][   C31] RAX: ffffa10c52d43058 RBX: =
ffffa10c52d43000 RCX: 0000000000000000
Sep 15 04:32:29  [399661.972659][   C31] RDX: 0000000000002712 RSI: =
0000000000000246 RDI: ffffa10c52d43000
Sep 15 04:32:29  [399661.972774][   C31] RBP: ffffa10c52d43000 R08: =
0000000127a83c46 R09: 0000000000004d8c
Sep 15 04:32:29  [399661.972889][   C31] R10: ffffe840ca0f7c00 R11: =
0000000000000000 R12: ffffa10c8e764d80
Sep 15 04:32:29  [399661.973005][   C31] R13: ffffa10c92b4c760 R14: =
0000000000000058 R15: ffffa10c92b4c600
Sep 15 04:32:29  [399661.973123][   C31] FS:  0000000000000000(0000) =
GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
Sep 15 04:32:29  [399661.973244][   C31] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 15 04:32:29  [399661.973338][   C31] CR2: ffffa10c52d43058 CR3: =
00000001059b8001 CR4: 00000000003706e0
Sep 15 04:32:29  [399661.973454][   C31] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 15 04:32:29  [399661.973569][   C31] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 15 04:32:29  [399661.973684][   C31] Call Trace:
Sep 15 04:32:29  [399661.973773][   C31]  <IRQ>
Sep 15 04:32:29  [399661.973859][ C31] ? __die =
(arch/x86/kernel/dumpstack.c:478 (discriminator 1) =
arch/x86/kernel/dumpstack.c:465 (discriminator 1) =
arch/x86/kernel/dumpstack.c:420 (discriminator 1) =
arch/x86/kernel/dumpstack.c:434 (discriminator 1))
Sep 15 04:32:29  [399661.973949][ C31] ? page_fault_oops =
(arch/x86/mm/fault.c:703)
Sep 15 04:32:29  [399661.974043][ C31] ? exc_page_fault =
(arch/x86/mm/fault.c:48 (discriminator 2) arch/x86/mm/fault.c:1479 =
(discriminator 2) arch/x86/mm/fault.c:1542 (discriminator 2))
Sep 15 04:32:29  [399661.974136][ C31] ? asm_exc_page_fault =
(./arch/x86/include/asm/idtentry.h:570)
Sep 15 04:32:29  [399661.974228][ C31] ? kfree_skb_reason =
(net/core/skbuff.c:1006 net/core/skbuff.c:1022 net/core/skbuff.c:1058)
Sep 15 04:32:29  [399661.974321][ C31] ? tcp_mtu_probe =
(./include/net/sock.h:1627 (discriminator 1) net/ipv4/tcp_output.c:2338 =
(discriminator 1) net/ipv4/tcp_output.c:2463 (discriminator 1))
Sep 15 04:32:29  [399661.974416][ C31] ? tcp_write_xmit =
(net/ipv4/tcp_output.c:2678)
Sep 15 04:32:29  [399661.974509][ C31] ? __tcp_push_pending_frames =
(net/ipv4/tcp_output.c:2940 (discriminator 1))
Sep 15 04:32:29  [399661.974603][ C31] ? tcp_rcv_established =
(net/ipv4/tcp_input.c:5626 net/ipv4/tcp_input.c:5620 =
net/ipv4/tcp_input.c:6066)
Sep 15 04:32:29  [399661.974695][ C31] ? sk_filter_trim_cap =
(./include/linux/rcupdate.h:781 net/core/filter.c:157)
Sep 15 04:32:29  [399661.974787][ C31] ? tcp_v4_do_rcv =
(net/ipv4/tcp_ipv4.c:1728)
Sep 15 04:32:29  [399661.974877][ C31] ? tcp_v4_rcv =
(./include/net/tcp.h:2342 (discriminator 1) net/ipv4/tcp_ipv4.c:2147 =
(discriminator 1))
Sep 15 04:32:29  [399661.974968][ C31] ? ip_protocol_deliver_rcu =
(net/ipv4/ip_input.c:205)
Sep 15 04:32:29  [399661.975062][ C31] ? ip_local_deliver_finish =
(net/ipv4/ip_input.c:233 (discriminator 1))
Sep 15 04:32:29  [399661.976257][ C31] ? process_backlog =
(net/core/dev.c:5451 net/core/dev.c:5566 net/core/dev.c:5895)
Sep 15 04:32:29  [399661.976352][ C31] ? __napi_poll+0x20/0x180
Sep 15 04:32:29  [399661.976442][ C31] ? net_rx_action =
(net/core/dev.c:5839 net/core/dev.c:5860 net/core/dev.c:6684)
Sep 15 04:32:29  [399661.976534][ C31] ? __do_softirq =
(./arch/x86/include/asm/bitops.h:319 kernel/softirq.c:550)
Sep 15 04:32:29  [399661.976626][ C31] ? do_softirq =
(kernel/softirq.c:463 (discriminator 32))
Sep 15 04:32:29  [399661.976718][   C31]  </IRQ>
Sep 15 04:32:29  [399661.976805][   C31]  <TASK>
Sep 15 04:32:29  [399661.976890][ C31] ? flush_smp_call_function_queue =
(kernel/smp.c:563 (discriminator 1))
Sep 15 04:32:29  [399661.976988][ C31] ? do_idle =
(kernel/sched/idle.c:295)
Sep 15 04:32:29  [399661.977078][ C31] ? cpu_startup_entry =
(kernel/sched/idle.c:379 (discriminator 1))
Sep 15 04:32:29  [399661.977168][ C31] ? start_secondary =
(arch/x86/kernel/smpboot.c:326)
Sep 15 04:32:29  [399661.977262][ C31] ? secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
Sep 15 04:32:29  [399661.977359][   C31]  </TASK>
Sep 15 04:32:29  [399661.977448][   C31] Modules linked in: nft_limit =
nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_xnatlog(O) ipmi_si ipmi_devintf =
ipmi_msghandler rtc_cmos [last unloaded: BNGBOOT(O)]
Sep 15 04:32:29  [399661.977720][   C31] CR2: ffffa10c52d43058
Sep 15 04:32:29  [399661.977809][   C31] ---[ end trace 0000000000000000 =
]---
Sep 15 04:32:29  [399661.977901][   C31] RIP: 0010:0xffffa10c52d43058
Sep 15 04:32:29  [399661.977992][ C31] Code: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 30 d4 52 0c a1 =
ff ff 00 00 00 00 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
	...
  30:	00 00                	add    %al,(%rax)
  32:	58                   	pop    %rax
  33:	30 d4                	xor    %dl,%ah
  35:*	52                   	push   %rdx		<-- trapping =
instruction
  36:	0c a1                	or     $0xa1,%al
  38:	ff                   	(bad)
  39:	ff 00                	incl   (%rax)
  3b:	00 00                	add    %al,(%rax)
  3d:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	...
   8:	58                   	pop    %rax
   9:	30 d4                	xor    %dl,%ah
   b:	52                   	push   %rdx
   c:	0c a1                	or     $0xa1,%al
   e:	ff                   	(bad)
   f:	ff 00                	incl   (%rax)
  11:	00 00                	add    %al,(%rax)
  13:	00 00                	add    %al,(%rax)
	...
Sep 15 04:32:29  [399661.978150][   C31] RSP: 0018:ffffad0e0097ccc8 =
EFLAGS: 00010282
Sep 15 04:32:29  [399661.978243][   C31] RAX: ffffa10c52d43058 RBX: =
ffffa10c52d43000 RCX: 0000000000000000
Sep 15 04:32:29  [399661.978358][   C31] RDX: 0000000000002712 RSI: =
0000000000000246 RDI: ffffa10c52d43000
Sep 15 04:32:29  [399661.978472][   C31] RBP: ffffa10c52d43000 R08: =
0000000127a83c46 R09: 0000000000004d8c
Sep 15 04:32:29  [399661.978587][   C31] R10: ffffe840ca0f7c00 R11: =
0000000000000000 R12: ffffa10c8e764d80
Sep 15 04:32:29  [399661.978702][   C31] R13: ffffa10c92b4c760 R14: =
0000000000000058 R15: ffffa10c92b4c600
Sep 15 04:32:29  [399661.978818][   C31] FS:  0000000000000000(0000) =
GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
Sep 15 04:32:29  [399661.978940][   C31] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 15 04:32:29  [399661.979036][   C31] CR2: ffffa10c52d43058 CR3: =
00000001059b8001 CR4: 00000000003706e0
Sep 15 04:32:29  [399661.979150][   C31] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 15 04:32:29  [399661.979265][   C31] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 15 04:32:29  [399661.979381][   C31] Kernel panic - not syncing: =
Fatal exception in interrupt
Sep 15 04:32:29  [399662.084038][   C31] Kernel Offset: 0x1e000000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
Sep 15 04:32:29  [399662.084162][   C31] Rebooting in 10 seconds..

> On 16 Sep 2023, at 2:00, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Ok fix=20
> one note this is kernel 6.5.3 =E2=80=A6
>=20
>=20
> see log now :=20
>=20
>=20
> [40915.530445] ------------[ cut here ]------------
> [40915.530529] rcuref - imbalanced put()
> [40915.530540] WARNING: CPU: 7 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> [40915.530698] Modules linked in: nf_conntrack_netlink nft_limit pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [40915.530899] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           O    =
   6.5.3 #1
> [40915.531018] Hardware name: Supermicro SYS-5038MR-H8TRF/X10SRD-F, =
BIOS 3.3 10/28/2020
> [40915.531137] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
> [40915.531230] Code: 31 c0 eb e2 80 3d c6 ae e6 00 00 74 0a c7 03 00 =
00 00 e0 31 c0 eb cf 48 c7 c7 68 f6 e2 8e c6 05 ac ae e6 00 01 e8 11 71 =
c7 ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 =
e2
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 31 c0                 xor    %eax,%eax
>   2: eb e2                 jmp    0xffffffffffffffe6
>   4: 80 3d c6 ae e6 00 00 cmpb   $0x0,0xe6aec6(%rip)        # 0xe6aed1
>   b: 74 0a                 je     0x17
>   d: c7 03 00 00 00 e0     movl   $0xe0000000,(%rbx)
>  13: 31 c0                 xor    %eax,%eax
>  15: eb cf                 jmp    0xffffffffffffffe6
>  17: 48 c7 c7 68 f6 e2 8e mov    $0xffffffff8ee2f668,%rdi
>  1e: c6 05 ac ae e6 00 01 movb   $0x1,0xe6aeac(%rip)        # 0xe6aed1
>  25: e8 11 71 c7 ff        call   0xffffffffffc7713b
>  2a:* 0f 0b                 ud2     <-- trapping instruction
>  2c: eb df                 jmp    0xd
>  2e: cc                    int3
>  2f: cc                    int3
>  30: cc                    int3
>  31: cc                    int3
>  32: cc                    int3
>  33: cc                    int3
>  34: cc                    int3
>  35: cc                    int3
>  36: cc                    int3
>  37: cc                    int3
>  38: cc                    int3
>  39: cc                    int3
>  3a: cc                    int3
>  3b: 48 89 fa              mov    %rdi,%rdx
>  3e: 83                    .byte 0x83
>  3f: e2                    .byte 0xe2
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 0f 0b                 ud2
>   2: eb df                 jmp    0xffffffffffffffe3
>   4: cc                    int3
>   5: cc                    int3
>   6: cc                    int3
>   7: cc                    int3
>   8: cc                    int3
>   9: cc                    int3
>   a: cc                    int3
>   b: cc                    int3
>   c: cc                    int3
>   d: cc                    int3
>   e: cc                    int3
>   f: cc                    int3
>  10: cc                    int3
>  11: 48 89 fa              mov    %rdi,%rdx
>  14: 83                    .byte 0x83
>  15: e2                    .byte 0xe2
> [40915.531389] RSP: 0018:ffffa62680318de8 EFLAGS: 00010296
> [40915.531487] RAX: 0000000000000019 RBX: ffff982f02950c40 RCX: =
00000000fffbffff
> [40915.531605] RDX: 00000000fffbffff RSI: 0000000000000001 RDI: =
00000000ffffffea
> [40915.531721] RBP: ffff982e467d2000 R08: 0000000000000000 R09: =
00000000fffbffff
> [40915.531839] R10: ffff98359d600000 R11: 0000000000000003 R12: =
ffff982f044e16c0
> [40915.531956] R13: 0000000000000000 R14: 0000000000000258 R15: =
ffffa62680318f60
> [40915.532075] FS:  0000000000000000(0000) GS:ffff98359fbc0000(0000) =
knlGS:0000000000000000
> [40915.532195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [40915.532291] CR2: 00005593eb3ff078 CR3: 0000000179f6e001 CR4: =
00000000003706e0
> [40915.532409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [40915.532526] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [40915.532645] Call Trace:
> [40915.532736]  <IRQ>
> [40915.532824] ? __warn (kernel/panic.c:668)
> [40915.532918] ? report_bug (lib/bug.c:223)
> [40915.533011] ? handle_bug (arch/x86/kernel/traps.c:324)
> [40915.533104] ? exc_invalid_op (arch/x86/kernel/traps.c:345 =
(discriminator 1))
> [40915.533198] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
> [40915.533294] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
> [40915.533389] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
> [40915.533482] dst_release (./include/linux/rcuref.h:151 =
net/core/dst.c:166)
> [40915.533576] __dev_queue_xmit (net/core/dev.c:4138)
> [40915.533671] ? eth_header (net/ethernet/eth.c:83)
> [40915.533766] ip_finish_output2 (./include/net/neighbour.h:544 =
net/ipv4/ip_output.c:230)
> [40915.533863] process_backlog (net/core/dev.c:5451 =
net/core/dev.c:5566 net/core/dev.c:5895)
> [40915.533958] __napi_poll+0x20/0x180
> [40915.534050] net_rx_action (net/core/dev.c:5839 net/core/dev.c:5860 =
net/core/dev.c:6684)
> [40915.534140] __do_softirq (./arch/x86/include/asm/bitops.h:319 =
kernel/softirq.c:550)
> [40915.534233] do_softirq (kernel/softirq.c:463 (discriminator 32))
> [40915.534326]  </IRQ>
> [40915.534413]  <TASK>
> [40915.534503] flush_smp_call_function_queue (kernel/smp.c:563 =
(discriminator 1))
> [40915.534597] do_idle (kernel/sched/idle.c:295)
> [40915.534687] cpu_startup_entry (kernel/sched/idle.c:379 =
(discriminator 1))
> [40915.534778] start_secondary (arch/x86/kernel/smpboot.c:326)
> [40915.534871] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
> [40915.534968]  </TASK>
> [40915.535057] ---[ end trace 0000000000000000 ]---
>=20
>> On 15 Sep 2023, at 7:05, Martin Zaharinov <micron10@gmail.com> wrote:
>>=20
>> Hi All=20
>> This is report from kernel 6.5.2 after 4 day up system hang and =
reboot after this error :
>>=20
>>=20
>>=20
>> Sep 15 04:32:29 205.254.184.12 [399661.971344][   C31] kernel tried =
to execute NX-protected page - exploit attempt? (uid: 0)
>> Sep 15 04:32:29 205.254.184.12 [399661.971470][   C31] BUG: unable to =
handle page fault for address: ffffa10c52d43058
>> Sep 15 04:32:29 205.254.184.12 [399661.971586][   C31] #PF: =
supervisor instruction fetch in kernel mode
>> Sep 15 04:32:29 205.254.184.12 [399661.971680][   C31] #PF: =
error_code(0x0011) - permissions violation
>> Sep 15 04:32:29 205.254.184.12 [399661.971775][   C31] PGD 12601067 =
P4D 12601067 PUD 80000002400001e3
>> Sep 15 04:32:29 205.254.184.12 [399661.971871][   C31] Oops: 0011 =
[#1] PREEMPT SMP
>> Sep 15 04:32:29 205.254.184.12 [399661.971963][   C31] CPU: 31 PID: 0 =
Comm: swapper/31 Tainted: G        W  O       6.5.2 #1
>> Sep 15 04:32:29 205.254.184.12 [399661.972079][   C31] Hardware name: =
Supermicro SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
>> Sep 15 04:32:29 205.254.184.12 [399661.972197][   C31] RIP: =
0010:0xffffa10c52d43058
>> Sep 15 04:32:29 205.254.184.12 [399661.972289][   C31] Code: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 =
58 30 d4 52 0c a1 ff ff 00 00 00 00 00 00
>> Sep 15 04:32:29 205.254.184.12 [399661.972448][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
>> Sep 15 04:32:29 205.254.184.12 [399661.972543][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.972659][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
>> Sep 15 04:32:29 205.254.184.12 [399661.972774][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
>> Sep 15 04:32:29 205.254.184.12 [399661.972889][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
>> Sep 15 04:32:29 205.254.184.12 [399661.973005][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
>> Sep 15 04:32:29 205.254.184.12 [399661.973123][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.973244][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
>> Sep 15 04:32:29 205.254.184.12 [399661.973338][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
>> Sep 15 04:32:29 205.254.184.12 [399661.973454][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.973569][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Sep 15 04:32:29 205.254.184.12 [399661.973684][   C31] Call Trace:
>> Sep 15 04:32:29 205.254.184.12 [399661.973773][   C31]  <IRQ>
>> Sep 15 04:32:29 205.254.184.12 [399661.973859][   C31]  ? =
__die+0xe4/0xf0
>> Sep 15 04:32:29 205.254.184.12 [399661.973949][   C31]  ? =
page_fault_oops+0x144/0x3e0
>> Sep 15 04:32:29 205.254.184.12 [399661.974043][   C31]  ? =
exc_page_fault+0x92/0xa0
>> Sep 15 04:32:29 205.254.184.12 [399661.974136][   C31]  ? =
asm_exc_page_fault+0x22/0x30
>> Sep 15 04:32:29 205.254.184.12 [399661.974228][   C31]  ? =
kfree_skb_reason+0x33/0xf0
>> Sep 15 04:32:29 205.254.184.12 [399661.974321][   C31]  ? =
tcp_mtu_probe+0x3a6/0x7b0
>> Sep 15 04:32:29 205.254.184.12 [399661.974416][   C31]  ? =
tcp_write_xmit+0x7fa/0x1410
>> Sep 15 04:32:29 205.254.184.12 [399661.974509][   C31]  ? =
__tcp_push_pending_frames+0x2d/0xb0
>> Sep 15 04:32:29 205.254.184.12 [399661.974603][   C31]  ? =
tcp_rcv_established+0x381/0x610
>> Sep 15 04:32:29 205.254.184.12 [399661.974695][   C31]  ? =
sk_filter_trim_cap+0xc6/0x1c0
>> Sep 15 04:32:29 205.254.184.12 [399661.974787][   C31]  ? =
tcp_v4_do_rcv+0x11f/0x1f0
>> Sep 15 04:32:29 205.254.184.12 [399661.974877][   C31]  ? =
tcp_v4_rcv+0xfa1/0x1010
>> Sep 15 04:32:29 205.254.184.12 [399661.974968][   C31]  ? =
ip_protocol_deliver_rcu+0x1b/0x270
>> Sep 15 04:32:29 205.254.184.12 [399661.975062][   C31]  ? =
ip_local_deliver_finish+0x6d/0x90
>> Sep 15 04:32:29 205.254.184.12 [399661.976257][   C31]  ? =
process_backlog+0x10c/0x230
>> Sep 15 04:32:29 205.254.184.12 [399661.976352][   C31]  ? =
__napi_poll+0x20/0x180
>> Sep 15 04:32:29 205.254.184.12 [399661.976442][   C31]  ? =
net_rx_action+0x2a4/0x390
>> Sep 15 04:32:29 205.254.184.12 [399661.976534][   C31]  ? =
__do_softirq+0xd0/0x202
>> Sep 15 04:32:29 205.254.184.12 [399661.976626][   C31]  ? =
do_softirq+0x3a/0x50
>> Sep 15 04:32:29 205.254.184.12 [399661.976718][   C31]  </IRQ>
>> Sep 15 04:32:29 205.254.184.12 [399661.976805][   C31]  <TASK>
>> Sep 15 04:32:29 205.254.184.12 [399661.976890][   C31]  ? =
flush_smp_call_function_queue+0x3f/0x50
>> Sep 15 04:32:29 205.254.184.12 [399661.976988][   C31]  ? =
do_idle+0x14d/0x210
>> Sep 15 04:32:29 205.254.184.12 [399661.977078][   C31]  ? =
cpu_startup_entry+0x14/0x20
>> Sep 15 04:32:29 205.254.184.12 [399661.977168][   C31]  ? =
start_secondary+0xe1/0xf0
>> Sep 15 04:32:29 205.254.184.12 [399661.977262][   C31]  ? =
secondary_startup_64_no_verify+0x167/0x16b
>> Sep 15 04:32:29 205.254.184.12 [399661.977359][   C31]  </TASK>
>> Sep 15 04:32:29 205.254.184.12 [399661.977448][   C31] Modules linked =
in: nft_limit nf_conntrack_netlink  pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos=20
>> Sep 15 04:32:29 205.254.184.12 [399661.977720][   C31] CR2: =
ffffa10c52d43058
>> Sep 15 04:32:29 205.254.184.12 [399661.977809][   C31] ---[ end trace =
0000000000000000 ]---
>> Sep 15 04:32:29 205.254.184.12 [399661.977901][   C31] RIP: =
0010:0xffffa10c52d43058
>> Sep 15 04:32:29 205.254.184.12 [399661.977992][   C31] Code: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 =
58 30 d4 52 0c a1 ff ff 00 00 00 00 00 00
>> Sep 15 04:32:29 205.254.184.12 [399661.978150][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
>> Sep 15 04:32:29 205.254.184.12 [399661.978243][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.978358][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
>> Sep 15 04:32:29 205.254.184.12 [399661.978472][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
>> Sep 15 04:32:29 205.254.184.12 [399661.978587][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
>> Sep 15 04:32:29 205.254.184.12 [399661.978702][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
>> Sep 15 04:32:29 205.254.184.12 [399661.978818][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.978940][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
>> Sep 15 04:32:29 205.254.184.12 [399661.979036][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
>> Sep 15 04:32:29 205.254.184.12 [399661.979150][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> Sep 15 04:32:29 205.254.184.12 [399661.979265][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Sep 15 04:32:29 205.254.184.12 [399661.979381][   C31] Kernel panic - =
not syncing: Fatal exception in interrupt
>> Sep 15 04:32:29 205.254.184.12 [399662.084038][   C31] Kernel Offset: =
0x1e000000 from 0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
>> Sep 15 04:32:29 205.254.184.12 [399662.084162][   C31] Rebooting in =
10 seconds..
>>=20
>>=20
>> Please if find fix update me .
>>=20
>> m.
>=20
>=20


