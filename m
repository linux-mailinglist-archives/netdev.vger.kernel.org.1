Return-Path: <netdev+bounces-34199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15E7A2A69
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 00:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6121C209A7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775341BDC2;
	Fri, 15 Sep 2023 22:24:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605915EAE
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 22:24:40 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601282736
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:23:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bf78950354so43080361fa.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694816614; x=1695421414; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUU0eWW6K/1GiQwgXluBWiQNvBOWuUpRcJMir0I0Ku8=;
        b=Qxf5gZDVm+ZUN0525Xv5UsMgj8249zqyqvdhA4PYRJUqPYZ7mueyg9LV9X1BaK3dNq
         cJd3GnqlrpOUt/3Ryu9uuCH/nSjR2KDoskSZaQ3A5SOoA5HxcZELkqEEKyu86EkYtkj3
         A3x034qVrzgAGRofq4rRUEglEqP21P/xmMaOLfg1N3rUXdmZavHwy6CwnYvpI+Ae2JzA
         cZVhOyJhs3yALwFqR0np1ROTEtKkyZ3aiJTTAk9FGmQmeVfaS30UtpqCFBjQat/s7osH
         RE3iTEp1P2xiUxiFjE6EVw8VS1cVieDPckDEE+kPNplL+whkNi+Ys1mp6JyIi81OsNvV
         cAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694816614; x=1695421414;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUU0eWW6K/1GiQwgXluBWiQNvBOWuUpRcJMir0I0Ku8=;
        b=TYjK7ZTu+m/Nr3bRFa12EnKU2cRT09qW2hbBUbfm+oHMJFCkBjfdLoBbHRWZ6sQZSp
         j07xYcRP/OQhr4Xtgn9HaqRvdunUyg1kBltt3axoEsG/WTSCQEsSTdedH+mFW31cDkQH
         7sTIdDlCzhRRsvriuvXSvAPp2DomjQSYqa9VOVI2Er+sczImEh4r91mwZ4hUQJOQQgY7
         rdhix9xEpwJDW+y0UVMYnKYg42/7876raI3tTho4p9AiecKMfpvGNlxMQwdrczeQaAUs
         doi2Foez1hHBNStO3CHIR/EiT58aCDv9ussMnvit8afZVoowsDmK6awDoBDPBOwJuPOL
         QvMA==
X-Gm-Message-State: AOJu0YwyO18spV6MJdw/N7btaQWfmSQkZ3f1PSmdDa6REl2AqpYfBNVG
	Bwn4WjcVJXoRotNFgzARG1k=
X-Google-Smtp-Source: AGHT+IEtS1G+7SG7ac56a5vfMo8T5Cq9Pv/PjmDJIcUN4Dfqus2FFAc7bYe8JxshKcoQfZNgEl23Xg==
X-Received: by 2002:a2e:7c19:0:b0:2b9:ef0a:7d4b with SMTP id x25-20020a2e7c19000000b002b9ef0a7d4bmr2538491ljc.31.1694816614119;
        Fri, 15 Sep 2023 15:23:34 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0099bd6026f45sm2924097ejf.198.2023.09.15.15.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Sep 2023 15:23:33 -0700 (PDT)
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
In-Reply-To: <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
Date: Sat, 16 Sep 2023 01:23:22 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E6AB656-0DE7-4837-A7AE-F8A0CCBC6F2D@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric

run decode script =E2=80=A6 but i think miss function name =E2=80=A6 =
check log :=20


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
[40915.532824] ? __warn (??:?)
[40915.532918] ? report_bug (??:?)
[40915.533011] ? handle_bug (traps.c:?)
[40915.533104] ? exc_invalid_op (??:?)
[40915.533198] ? asm_exc_invalid_op (??:?)
[40915.533294] ? rcuref_put_slowpath (??:?)
[40915.533389] ? rcuref_put_slowpath (??:?)
[40915.533482] dst_release (??:?)
[40915.533576] __dev_queue_xmit (??:?)
[40915.533671] ? eth_header (??:?)
[40915.533766] ip_finish_output2 (ip_output.c:?)
[40915.533863] process_backlog (dev.c:?)
[40915.533958] __napi_poll (dev.c:?)
[40915.534050] net_rx_action (dev.c:?)
[40915.534140] __do_softirq (??:?)
[40915.534233] do_softirq (??:?)
[40915.534326]  </IRQ>
[40915.534413]  <TASK>
[40915.534503] flush_smp_call_function_queue (??:?)
[40915.534597] do_idle (build_policy.c:?)
[40915.534687] cpu_startup_entry (??:?)
[40915.534778] start_secondary (smpboot.c:?)
[40915.534871] secondary_startup_64_no_verify (??:?)
[40915.534968]  </TASK>
[40915.535057] ---[ end trace 0000000000000000 ]=E2=80=94



For me may be problem is in this part :=20

[40915.533863] process_backlog (dev.c:?)
[40915.533958] __napi_poll (dev.c:?)
[40915.534050] net_rx_action (dev.c:?)

this start after upgrade to kernel 6.3.x
with 6.2.x i dont have this problem.

m.

> On 15 Sep 2023, at 9:45, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Fri, Sep 15, 2023 at 6:05=E2=80=AFAM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>=20
>> Hi All
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
>=20
> Your reports are not usable. Please make sure to include symbols next =
time.
>=20
> Please read these parts (and possibly complete files)
>=20
> Documentation/admin-guide/bug-hunting.rst:55:quality of the stack
> trace by using file:`scripts/decode_stacktrace.sh`.
>=20
> Documentation/admin-guide/reporting-issues.rst:978:
> [user@something ~]$ sudo dmesg |
> ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
> Documentation/admin-guide/reporting-issues.rst:985:
> [user@something ~]$ sudo dmesg |
> ./linux-5.10.5/scripts/decode_stacktrace.sh \
>=20
>=20
>=20
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
rtc_cmos
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



