Return-Path: <netdev+bounces-34202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67047A2ACD
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B455281C50
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB61B297;
	Fri, 15 Sep 2023 23:00:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C11B27C
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 23:00:38 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73634AF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:00:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so4390327e87.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694818834; x=1695423634; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2/e2CxMtNmP7zEPWjzWz0aoQT2qM96e0VgIi6xCPFc=;
        b=b6K/nX+uqIVFY9A0vfkSHlN6qaJolewcKTNUoMogYK7++VCrznvCG7MHwhV1OboSEm
         n9Pf6hc/qCanKz08LmAI+ynRzjMfk4qH+xZYJ9Xf/dZmAypddXAXPOemtNSHX6beJis/
         y2cvrEwpqI0fR23b7QGkwXOvvKYMb/E5XtrE5xiuH3Bg/QMDXWiY2oBHZM39JAOuggNk
         nOvulvwWj92ZFMd3VjptdQA3npGM4CGvUrf4Rl2+GQ5LdJR6Ch1sCFid4JIOKhWXV1zp
         pPcz6PX4qkhj2N9G6smIV0XP4/1kdwZdZE50PeZN4z0r7r9r0TZjtgIuq/Cdtjm9/0Po
         3GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818834; x=1695423634;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2/e2CxMtNmP7zEPWjzWz0aoQT2qM96e0VgIi6xCPFc=;
        b=j/43NvGKQnE+XtWtWc1jOO4tRo95QNPuo0kIK62NpWep2JN9kdaIY06Yhi/V4m0AFZ
         pVdO36Gq0ei7soCPMikR50qcTTYN7A4fDfU+Z9Nz03hj/8McqhEtw6X9zJ0dLgz16ZxY
         QtwJ/yUMClFdMw4XKAmIecersAsVj0ELI3Kw6tijVKKLSF9jtJmWtO//DN4IPDkbCSgM
         OHpS54jrIkcCqgnqjHF4ZPcvf0H39Oa0A3QTvMYtrGGBH+KHBQF0Yld44i/UMwVJln9R
         jtNU+lxzfie1ropGdraiPAHDduvtFBn2q97yQIZKjDdQ12JK7mrEserTZfC6drlU3vav
         oeqQ==
X-Gm-Message-State: AOJu0YyqWaRAcbowf+CEDuG1JfRhP7udi7OYg5bTpZBypkC2VC3e08sS
	JGvOeUhVrKk+1EQTdU0ENPFl4c1aQB8=
X-Google-Smtp-Source: AGHT+IG9r1nQNcBX/kxlwsSYoKmCBQJvfrpopuwi39XM7U+uZEhw8WPgnXE4UHVg5enOYJ4gSFZ/Pw==
X-Received: by 2002:a05:6512:2396:b0:4ff:a04c:8a5b with SMTP id c22-20020a056512239600b004ffa04c8a5bmr3126239lfv.47.1694818834113;
        Fri, 15 Sep 2023 16:00:34 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b0097404f4a124sm2977549ejb.2.2023.09.15.16.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Sep 2023 16:00:33 -0700 (PDT)
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
In-Reply-To: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
Date: Sat, 16 Sep 2023 02:00:22 +0300
Cc: Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
To: netdev <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ok fix=20
one note this is kernel 6.5.3 =E2=80=A6


see log now :=20


[40915.530445] ------------[ cut here ]------------
[40915.530529] rcuref - imbalanced put()
[40915.530540] WARNING: CPU: 7 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
[40915.530698] Modules linked in: nf_conntrack_netlink nft_limit pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
[40915.530899] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           O      =
 6.5.3 #1
[40915.531018] Hardware name: Supermicro SYS-5038MR-H8TRF/X10SRD-F, BIOS =
3.3 10/28/2020
[40915.531137] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
[40915.531230] Code: 31 c0 eb e2 80 3d c6 ae e6 00 00 74 0a c7 03 00 00 =
00 e0 31 c0 eb cf 48 c7 c7 68 f6 e2 8e c6 05 ac ae e6 00 01 e8 11 71 c7 =
ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	31 c0                	xor    %eax,%eax
   2:	eb e2                	jmp    0xffffffffffffffe6
   4:	80 3d c6 ae e6 00 00 	cmpb   $0x0,0xe6aec6(%rip)        # =
0xe6aed1
   b:	74 0a                	je     0x17
   d:	c7 03 00 00 00 e0    	movl   $0xe0000000,(%rbx)
  13:	31 c0                	xor    %eax,%eax
  15:	eb cf                	jmp    0xffffffffffffffe6
  17:	48 c7 c7 68 f6 e2 8e 	mov    $0xffffffff8ee2f668,%rdi
  1e:	c6 05 ac ae e6 00 01 	movb   $0x1,0xe6aeac(%rip)        # =
0xe6aed1
  25:	e8 11 71 c7 ff       	call   0xffffffffffc7713b
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
[40915.531389] RSP: 0018:ffffa62680318de8 EFLAGS: 00010296
[40915.531487] RAX: 0000000000000019 RBX: ffff982f02950c40 RCX: =
00000000fffbffff
[40915.531605] RDX: 00000000fffbffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[40915.531721] RBP: ffff982e467d2000 R08: 0000000000000000 R09: =
00000000fffbffff
[40915.531839] R10: ffff98359d600000 R11: 0000000000000003 R12: =
ffff982f044e16c0
[40915.531956] R13: 0000000000000000 R14: 0000000000000258 R15: =
ffffa62680318f60
[40915.532075] FS:  0000000000000000(0000) GS:ffff98359fbc0000(0000) =
knlGS:0000000000000000
[40915.532195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40915.532291] CR2: 00005593eb3ff078 CR3: 0000000179f6e001 CR4: =
00000000003706e0
[40915.532409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[40915.532526] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[40915.532645] Call Trace:
[40915.532736]  <IRQ>
[40915.532824] ? __warn (kernel/panic.c:668)
[40915.532918] ? report_bug (lib/bug.c:223)
[40915.533011] ? handle_bug (arch/x86/kernel/traps.c:324)
[40915.533104] ? exc_invalid_op (arch/x86/kernel/traps.c:345 =
(discriminator 1))
[40915.533198] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[40915.533294] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[40915.533389] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[40915.533482] dst_release (./include/linux/rcuref.h:151 =
net/core/dst.c:166)
[40915.533576] __dev_queue_xmit (net/core/dev.c:4138)
[40915.533671] ? eth_header (net/ethernet/eth.c:83)
[40915.533766] ip_finish_output2 (./include/net/neighbour.h:544 =
net/ipv4/ip_output.c:230)
[40915.533863] process_backlog (net/core/dev.c:5451 net/core/dev.c:5566 =
net/core/dev.c:5895)
[40915.533958] __napi_poll+0x20/0x180
[40915.534050] net_rx_action (net/core/dev.c:5839 net/core/dev.c:5860 =
net/core/dev.c:6684)
[40915.534140] __do_softirq (./arch/x86/include/asm/bitops.h:319 =
kernel/softirq.c:550)
[40915.534233] do_softirq (kernel/softirq.c:463 (discriminator 32))
[40915.534326]  </IRQ>
[40915.534413]  <TASK>
[40915.534503] flush_smp_call_function_queue (kernel/smp.c:563 =
(discriminator 1))
[40915.534597] do_idle (kernel/sched/idle.c:295)
[40915.534687] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator =
1))
[40915.534778] start_secondary (arch/x86/kernel/smpboot.c:326)
[40915.534871] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
[40915.534968]  </TASK>
[40915.535057] ---[ end trace 0000000000000000 ]---

> On 15 Sep 2023, at 7:05, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi All=20
> This is report from kernel 6.5.2 after 4 day up system hang and reboot =
after this error :
>=20
>=20
>=20
> Sep 15 04:32:29 205.254.184.12 [399661.971344][   C31] kernel tried to =
execute NX-protected page - exploit attempt? (uid: 0)
> Sep 15 04:32:29 205.254.184.12 [399661.971470][   C31] BUG: unable to =
handle page fault for address: ffffa10c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.971586][   C31] #PF: supervisor =
instruction fetch in kernel mode
> Sep 15 04:32:29 205.254.184.12 [399661.971680][   C31] #PF: =
error_code(0x0011) - permissions violation
> Sep 15 04:32:29 205.254.184.12 [399661.971775][   C31] PGD 12601067 =
P4D 12601067 PUD 80000002400001e3
> Sep 15 04:32:29 205.254.184.12 [399661.971871][   C31] Oops: 0011 [#1] =
PREEMPT SMP
> Sep 15 04:32:29 205.254.184.12 [399661.971963][   C31] CPU: 31 PID: 0 =
Comm: swapper/31 Tainted: G        W  O       6.5.2 #1
> Sep 15 04:32:29 205.254.184.12 [399661.972079][   C31] Hardware name: =
Supermicro SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
> Sep 15 04:32:29 205.254.184.12 [399661.972197][   C31] RIP: =
0010:0xffffa10c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.972289][   C31] Code: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 =
58 30 d4 52 0c a1 ff ff 00 00 00 00 00 00
> Sep 15 04:32:29 205.254.184.12 [399661.972448][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
> Sep 15 04:32:29 205.254.184.12 [399661.972543][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.972659][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
> Sep 15 04:32:29 205.254.184.12 [399661.972774][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
> Sep 15 04:32:29 205.254.184.12 [399661.972889][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
> Sep 15 04:32:29 205.254.184.12 [399661.973005][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
> Sep 15 04:32:29 205.254.184.12 [399661.973123][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.973244][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
> Sep 15 04:32:29 205.254.184.12 [399661.973338][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
> Sep 15 04:32:29 205.254.184.12 [399661.973454][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.973569][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 15 04:32:29 205.254.184.12 [399661.973684][   C31] Call Trace:
> Sep 15 04:32:29 205.254.184.12 [399661.973773][   C31]  <IRQ>
> Sep 15 04:32:29 205.254.184.12 [399661.973859][   C31]  ? =
__die+0xe4/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.973949][   C31]  ? =
page_fault_oops+0x144/0x3e0
> Sep 15 04:32:29 205.254.184.12 [399661.974043][   C31]  ? =
exc_page_fault+0x92/0xa0
> Sep 15 04:32:29 205.254.184.12 [399661.974136][   C31]  ? =
asm_exc_page_fault+0x22/0x30
> Sep 15 04:32:29 205.254.184.12 [399661.974228][   C31]  ? =
kfree_skb_reason+0x33/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.974321][   C31]  ? =
tcp_mtu_probe+0x3a6/0x7b0
> Sep 15 04:32:29 205.254.184.12 [399661.974416][   C31]  ? =
tcp_write_xmit+0x7fa/0x1410
> Sep 15 04:32:29 205.254.184.12 [399661.974509][   C31]  ? =
__tcp_push_pending_frames+0x2d/0xb0
> Sep 15 04:32:29 205.254.184.12 [399661.974603][   C31]  ? =
tcp_rcv_established+0x381/0x610
> Sep 15 04:32:29 205.254.184.12 [399661.974695][   C31]  ? =
sk_filter_trim_cap+0xc6/0x1c0
> Sep 15 04:32:29 205.254.184.12 [399661.974787][   C31]  ? =
tcp_v4_do_rcv+0x11f/0x1f0
> Sep 15 04:32:29 205.254.184.12 [399661.974877][   C31]  ? =
tcp_v4_rcv+0xfa1/0x1010
> Sep 15 04:32:29 205.254.184.12 [399661.974968][   C31]  ? =
ip_protocol_deliver_rcu+0x1b/0x270
> Sep 15 04:32:29 205.254.184.12 [399661.975062][   C31]  ? =
ip_local_deliver_finish+0x6d/0x90
> Sep 15 04:32:29 205.254.184.12 [399661.976257][   C31]  ? =
process_backlog+0x10c/0x230
> Sep 15 04:32:29 205.254.184.12 [399661.976352][   C31]  ? =
__napi_poll+0x20/0x180
> Sep 15 04:32:29 205.254.184.12 [399661.976442][   C31]  ? =
net_rx_action+0x2a4/0x390
> Sep 15 04:32:29 205.254.184.12 [399661.976534][   C31]  ? =
__do_softirq+0xd0/0x202
> Sep 15 04:32:29 205.254.184.12 [399661.976626][   C31]  ? =
do_softirq+0x3a/0x50
> Sep 15 04:32:29 205.254.184.12 [399661.976718][   C31]  </IRQ>
> Sep 15 04:32:29 205.254.184.12 [399661.976805][   C31]  <TASK>
> Sep 15 04:32:29 205.254.184.12 [399661.976890][   C31]  ? =
flush_smp_call_function_queue+0x3f/0x50
> Sep 15 04:32:29 205.254.184.12 [399661.976988][   C31]  ? =
do_idle+0x14d/0x210
> Sep 15 04:32:29 205.254.184.12 [399661.977078][   C31]  ? =
cpu_startup_entry+0x14/0x20
> Sep 15 04:32:29 205.254.184.12 [399661.977168][   C31]  ? =
start_secondary+0xe1/0xf0
> Sep 15 04:32:29 205.254.184.12 [399661.977262][   C31]  ? =
secondary_startup_64_no_verify+0x167/0x16b
> Sep 15 04:32:29 205.254.184.12 [399661.977359][   C31]  </TASK>
> Sep 15 04:32:29 205.254.184.12 [399661.977448][   C31] Modules linked =
in: nft_limit nf_conntrack_netlink  pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos=20
> Sep 15 04:32:29 205.254.184.12 [399661.977720][   C31] CR2: =
ffffa10c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.977809][   C31] ---[ end trace =
0000000000000000 ]---
> Sep 15 04:32:29 205.254.184.12 [399661.977901][   C31] RIP: =
0010:0xffffa10c52d43058
> Sep 15 04:32:29 205.254.184.12 [399661.977992][   C31] Code: 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 =
58 30 d4 52 0c a1 ff ff 00 00 00 00 00 00
> Sep 15 04:32:29 205.254.184.12 [399661.978150][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
> Sep 15 04:32:29 205.254.184.12 [399661.978243][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.978358][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
> Sep 15 04:32:29 205.254.184.12 [399661.978472][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
> Sep 15 04:32:29 205.254.184.12 [399661.978587][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
> Sep 15 04:32:29 205.254.184.12 [399661.978702][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
> Sep 15 04:32:29 205.254.184.12 [399661.978818][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.978940][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
> Sep 15 04:32:29 205.254.184.12 [399661.979036][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
> Sep 15 04:32:29 205.254.184.12 [399661.979150][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Sep 15 04:32:29 205.254.184.12 [399661.979265][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Sep 15 04:32:29 205.254.184.12 [399661.979381][   C31] Kernel panic - =
not syncing: Fatal exception in interrupt
> Sep 15 04:32:29 205.254.184.12 [399662.084038][   C31] Kernel Offset: =
0x1e000000 from 0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
> Sep 15 04:32:29 205.254.184.12 [399662.084162][   C31] Rebooting in 10 =
seconds..
>=20
>=20
> Please if find fix update me .
>=20
> m.



