Return-Path: <netdev+bounces-48366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835537EE290
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52DE1C20A29
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5331753;
	Thu, 16 Nov 2023 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBfp7nKY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870698
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:17:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9f27af23441so122172166b.2
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700144269; x=1700749069; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRCaV1gZrmP+/3CTX43FT7ldVw7K38kUlcOxcbp/9l8=;
        b=XBfp7nKY9Hrp3tchHkGoPpdrJWqvOakeYE212SpTrM+q4HtQa5Ttlw27onpdRivrda
         0UrdIPeOR//TKjzFdMcL+UAt8JycHDRsr1fXNoulqBhFbXeGqhREZiXXjYJtSYRLmgNX
         1hFfyhdw1X3efgxd4wzgxYQoH8cwBBQAv5HygpCFitfhVvHxRvUr24fN8Qt53kx+MU6F
         +9biFcqTwHU2W22bSnsT7FqmWXxqno4emfc2rwG3paWZflYRUfrDsE47PUzzdqtiAETU
         X0SwnHc6fSOXhUoFhekPZgFkh8TBf2wwik3taqpykABZy69e9zZ3kro+0eqL7mPuPJAh
         ViEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144269; x=1700749069;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRCaV1gZrmP+/3CTX43FT7ldVw7K38kUlcOxcbp/9l8=;
        b=tM97a7xqroNpucYRU5DLHgnsvL+EkEgg840Ya18m6FgGl6OEoXC3lgEzxl80HlzZkB
         jv545snhxw13SAcnBlYYAvS0gdBc4hrXtSBjTr0ceGHNJKiprL2ed14kSSpVk6WtcuBp
         S67veLEGFP9SJKEpxsonDdpNkcGAn3vzKvEAWTzSUyy8pNFXQ5nuiN1Egh7J7/GSv/uj
         0KKd/6HjuqDLCBAzGST3Ogb65a4yRZ1cSf/C4IxpHTAp4Sb5YRcx7VfYbwVC4Ej6sb06
         HXCTjxkL/s0eP6E3VuUr8GHWNtr0k9NwJBWANkqjyg7crVDaEph6YwjJqOVa5EL5yu3A
         BXVQ==
X-Gm-Message-State: AOJu0YzQVooXPGU8rlmwjCue2eMJf879TZmQc3w/dtBL5g+hNA7nONRv
	WmalJykO7y27Pm6SwWTIO+LayiB09HA=
X-Google-Smtp-Source: AGHT+IHQsbHwQWpG7l2hYRnIObjwYqCPGjH1FyTJkCX1NKtNBcLa6zMoPT/Bt+Z35n6h6E+yUIBeXw==
X-Received: by 2002:a17:906:1d0b:b0:9be:aebc:d480 with SMTP id n11-20020a1709061d0b00b009beaebcd480mr13647658ejh.24.1700144268774;
        Thu, 16 Nov 2023 06:17:48 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id ck20-20020a170906c45400b0099ce188be7fsm8448278ejb.3.2023.11.16.06.17.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:17:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
Date: Thu, 16 Nov 2023 16:17:36 +0200
Cc: netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi All

report same problem with kernel 6.6.1 - i think problem is in rcu but =
=E2=80=A6 if have options to add people from RCU here.

See report :=20



[141229.505339] ------------[ cut here ]------------
[141229.505492] rcuref - imbalanced put()
[141229.505504] WARNING: CPU: 8 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
[141229.505821] Modules linked in: xsk_diag unix_diag iptable_filter =
xt_TCPMSS iptable_mangle xt_addrtype xt_nat xt_MASQUERADE iptable_nat =
ip_tables netconsole coretemp e1000 ixgbe mdio pppoe pppox sha1_ssse3 =
sha1_generic ppp_mppe libarc4 ppp_generic slhc nf_nat_sip =
nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4
[141229.506349] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G           O     =
  6.6.1 #1
[141229.506527] Hardware name: Persy Super Server/X11DDW-L, BIOS 4.0 =
07/11/2023
[141229.506701] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
[141229.506843] Code: 31 c0 eb e2 80 3d ef 4e e6 00 00 74 0a c7 03 00 00 =
00 e0 31 c0 eb cf 48 c7 c7 07 99 e3 97 c6 05 d5 4e e6 00 01 e8 d1 1f c7 =
ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	31 c0                	xor    %eax,%eax
   2:	eb e2                	jmp    0xffffffffffffffe6
   4:	80 3d ef 4e e6 00 00 	cmpb   $0x0,0xe64eef(%rip)        # =
0xe64efa
   b:	74 0a                	je     0x17
   d:	c7 03 00 00 00 e0    	movl   $0xe0000000,(%rbx)
  13:	31 c0                	xor    %eax,%eax
  15:	eb cf                	jmp    0xffffffffffffffe6
  17:	48 c7 c7 07 99 e3 97 	mov    $0xffffffff97e39907,%rdi
  1e:	c6 05 d5 4e e6 00 01 	movb   $0x1,0xe64ed5(%rip)        # =
0xe64efa
  25:	e8 d1 1f c7 ff       	call   0xffffffffffc71ffb
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
[141229.507086] RSP: 0018:ffffa444449e0978 EFLAGS: 00010296
[141229.507229] RAX: 0000000000000019 RBX: ffff9b54866a4100 RCX: =
00000000fff7ffff
[141229.507404] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[141229.507577] RBP: ffff9b53e57b1ec0 R08: 0000000000000000 R09: =
00000000fff7ffff
[141229.507751] R10: ffff9b62db200000 R11: 0000000000000003 R12: =
ffff9b5b0595c000
[141229.507929] R13: ffff9b5b09c32200 R14: ffff9b5b09e29a00 R15: =
ffff9b5b0557e080
[141229.508101] FS:  0000000000000000(0000) GS:ffff9b62dfa00000(0000) =
knlGS:0000000000000000
[141229.508279] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[141229.508425] CR2: 00007fbadced6a80 CR3: 000000096f014002 CR4: =
00000000003706e0
[141229.508599] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[141229.508773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[141229.508947] Call Trace:
[141229.509079]  <IRQ>
[141229.509206] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
[141229.509342] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[141229.509482] ? handle_bug (arch/x86/kernel/traps.c:237)
[141229.509617] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
[141229.509751] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[141229.509892] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[141229.510028] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[141229.510164] dst_release (./arch/x86/include/asm/preempt.h:95 =
./include/linux/rcuref.h:151 net/core/dst.c:166)
[141229.510302] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4324)
[141229.510441] vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:130)
[141229.510584] dev_hard_start_xmit (./include/linux/netdevice.h:4904 =
net/core/dev.c:3573 net/core/dev.c:3589)
[141229.510722] __dev_queue_xmit (./include/linux/netdevice.h:3278 =
(discriminator 25) net/core/dev.c:4370 (discriminator 25))
[141229.510862] ? eth_header (net/ethernet/eth.c:85)
[141229.510998] ip_finish_output2 (./include/net/neighbour.h:542 =
(discriminator 2) net/ipv4/ip_output.c:233 (discriminator 2))
[141229.511135] ip_sabotage_in (net/bridge/br_netfilter_hooks.c:881 =
net/bridge/br_netfilter_hooks.c:866)
[141229.511269] nf_hook_slow (./include/linux/netfilter.h:144 =
net/netfilter/core.c:626)
[141229.511406] ip_rcv (./include/linux/netfilter.h:259 =
./include/linux/netfilter.h:302 net/ipv4/ip_input.c:569)
[141229.511540] ? ip_rcv_core.constprop.0 (net/ipv4/ip_input.c:436)
[141229.511678] netif_receive_skb (net/core/dev.c:5552 =
net/core/dev.c:5666 net/core/dev.c:5752 net/core/dev.c:5811)
[141229.511814] br_handle_frame_finish (net/bridge/br_input.c:216)
[141229.511954] ? br_pass_frame_up (net/bridge/br_input.c:75)
[141229.512092] br_nf_hook_thresh (net/bridge/br_netfilter_hooks.c:1051)
[141229.512227] ? br_pass_frame_up (net/bridge/br_input.c:75)
[141229.512363] br_nf_pre_routing_finish =
(net/bridge/br_netfilter_hooks.c:427)
[141229.512501] ? br_pass_frame_up (net/bridge/br_input.c:75)
[141229.512644] ? nf_nat_ipv4_pre_routing =
(net/netfilter/nf_nat_proto.c:656) nf_nat
[141229.512792] br_nf_pre_routing (net/bridge/br_netfilter_hooks.c:538)
[141229.512928] ? br_nf_hook_thresh =
(net/bridge/br_netfilter_hooks.c:354)
[141229.513061] br_handle_frame (./include/linux/netfilter.h:144 =
net/bridge/br_input.c:272 net/bridge/br_input.c:417)
[141229.513196] ? br_pass_frame_up (net/bridge/br_input.c:75)
[141229.513333] __netif_receive_skb_core.constprop.0 =
(net/core/dev.c:5446 (discriminator 1))
[141229.513475] ? ip_finish_output2 (net/ipv4/ip_output.c:243)
[141229.513613] process_backlog (net/core/dev.c:5551 net/core/dev.c:5666 =
net/core/dev.c:5994)
[141229.513749] __napi_poll (net/core/dev.c:6556)
[141229.513887] net_rx_action (net/core/dev.c:6625 net/core/dev.c:6756)
[141229.514023] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
[141229.514158] do_softirq (kernel/softirq.c:463 (discriminator 32) =
kernel/softirq.c:450 (discriminator 32))
[141229.514292]  </IRQ>
[141229.514420]  <TASK>
[141229.514548] flush_smp_call_function_queue =
(./arch/x86/include/asm/irqflags.h:134 (discriminator 1) =
kernel/smp.c:579 (discriminator 1))
[141229.514688] do_idle (kernel/sched/idle.c:314)
[141229.514822] cpu_startup_entry (kernel/sched/idle.c:379)
[141229.516148] start_secondary (arch/x86/kernel/smpboot.c:326)
[141229.516291] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:433)
[141229.516435]  </TASK>
[141229.516562] ---[ end trace 0000000000000000 ]=E2=80=94


Best regards,
Martin



> On 15 Sep 2023, at 9:45, Eric Dumazet <edumazet@google.com> wrote:
>=20
> scripts/decode_stacktrace.sh



