Return-Path: <netdev+bounces-35116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AEF7A727E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4BD1C20621
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6A3D87;
	Wed, 20 Sep 2023 06:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0223C6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 06:05:29 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF6A1
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:05:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502934c88b7so10671479e87.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695189923; x=1695794723; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXzQOtiYhDSAEw6FcMmFy5OEfBfW4gt2wAFNQBJirxY=;
        b=dJ85rta+pM8IZo3uZVE6VA5jiowVTJZ1txfZJ4aYdD9PWZifHnyaJlHHxzHC0Mh0gF
         GNCAWkGu/SbpxBLfduJCDo5QCokiYTHmqVQJTTRHhQGYPq34ElwHo0oLUbBU1kd5UPWa
         4L6X9RcR6xHqqsGJz72jqkOR4ZuGgCwzRnNiSJczm6BnTTTh56grTUolRgo6rwnOqvZ3
         sxmiQgUDQMeb2qB1Ra4ubFxYscrb3OCu3VDfWz98ESI4oSE2IKDOmf4aq9UOhhMZpPFw
         kR6zECBHGFGkfnnSjGMmTETs6BWZ2iIZ3zA5LGt2rqK41w0q8aExoGeC9e7mu6cLdsbh
         3eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695189923; x=1695794723;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXzQOtiYhDSAEw6FcMmFy5OEfBfW4gt2wAFNQBJirxY=;
        b=e25L8euBgkLZai1nDd3wh5Lypw51NHwjC49LaQqS2juX5XJWf6i8smUKlkOscQqM+S
         g+dB09q22E5Dnhw5L6A1t9jCAnP1KeH/fb2ifCjHjv/NW4EG2d+Cmxj0taYgIGsk76RL
         4RaetUXwn4qOrqAdqobXe5rAuT63rrcCtvQAjVBnEsWxEqj3xh1aUqyHad7KUSN/VH3R
         RGWpSyJ7VNd+JaJzPSbB2n4ufmWzpR3VIcIoCX7nK+bhpnwvsZFLQTc8tjf2C3R7AvCE
         QNg4yDwo4f8l15phW23ULpJeVKLNEEfjjaJz2K/Dz2K/PYhua991ULdSb40h4PKIouqG
         DUXg==
X-Gm-Message-State: AOJu0Ywvf8tKk4CzwRbtbevdnklkDY1mFN3RVtKFCWXdHOTG+YFOlseS
	T953oRSYjQj1mrg9IMcIaNFYfWgx7FU=
X-Google-Smtp-Source: AGHT+IF7Jck8OHIHin8Akr7Opp4kOHJA7jAyPhudPv0yMKml4lEn1RxgN+lmTXvG3/CLTnOQ66Iqfg==
X-Received: by 2002:a2e:a40f:0:b0:2bc:f4ee:ca57 with SMTP id p15-20020a2ea40f000000b002bcf4eeca57mr1158591ljn.48.1695189922564;
        Tue, 19 Sep 2023 23:05:22 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id oq14-20020a170906cc8e00b0099e12a49c8fsm8932558ejb.173.2023.09.19.23.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2023 23:05:21 -0700 (PDT)
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
In-Reply-To: <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
Date: Wed, 20 Sep 2023 09:05:10 +0300
Cc: Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB129799-E196-428C-909D-721670DD5E21@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
 <43ED0333-18AB-4C38-A615-7755E5BE9C3E@gmail.com>
 <5A853CC5-F15C-4F30-B845-D9E5B43EC039@gmail.com>
 <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric

> On 20 Sep 2023, at 6:59, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Tue, Sep 19, 2023 at 10:09=E2=80=AFPM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>=20
>> Hi Eric
>>=20
>> Yes this patch is not come in 6.5 kernel and queue for 6.6 i test but =
not ok for now.
>=20
> "not ok for now" ? What does this mean?
> Pointing out patches that are not related to your issue is a waste of =
time.
> If this was to bring my attention, this is a bad strategy, because I
> will probably not read your future emails.
>=20

I'm sorry, I didn't speak correctly.
patch is very good but for kernel 6.6.
I enjoy your kernel improvements.=20
And thanks for that !!


>>=20
>> One more i find same error have in old kernel 6.4.8  , update to =
kernel 6.5.4 and same error is come .
>>=20
>> Like this is hard to catch bug
>>=20
>> see logs :
>>=20
>>=20
>> [1462610.861373] ------------[ cut here ]------------
>> [1462610.861480] rcuref - imbalanced put()
>> [1462610.861491] WARNING: CPU: 22 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath+0x5f/0x70
>> [1462610.861718] Modules linked in: nft_limit nf_conntrack_netlink  =
pppoe pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables =
netconsole coretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip =
nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
>> [1462610.862004] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G           =
O       6.4.8 #1
>> [1462610.863244] Hardware name: Supermicro Super Server/X10SRW-F, =
BIOS 3.4 06/05/2021
>> [1462610.863368] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
>> [1462610.863469] Code: 31 c0 eb e2 80 3d 02 cd e6 00 00 74 0a c7 03 =
00 00 00 e0 31 c0 eb cf 48 c7 c7 7f 68 e5 a4 c6 05 e8 cc e6 00 01 e8 e1 =
ab c7 ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa =
83 e2
>> [1462610.863637] RSP: 0018:ffffaee60070cc38 EFLAGS: 00010292
>> [1462610.863736] RAX: 0000000000000019 RBX: ffffa1cdc35e5780 RCX: =
00000000fff7ffff
>> [1462610.863857] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: =
00000000ffffffea
>> [1462610.864129] RBP: ffffa1cf6aeb8de8 R08: 0000000000000000 R09: =
00000000fff7ffff
>> [1462610.864250] R10: ffffa1d51b000000 R11: 0000000000000003 R12: =
ffffa1cdc35e5740
>> [1462610.864370] R13: ffffa1cdc35e57a8 R14: ffffa1d51fda9008 R15: =
00000000ade2eb6e
>> [1462610.864489] FS:  0000000000000000(0000) =
GS:ffffa1d51fd80000(0000) knlGS:0000000000000000
>> [1462610.864615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [1462610.864713] CR2: 00007f057b8ad000 CR3: 0000000141881003 CR4: =
00000000001706e0
>> [1462610.864833] Call Trace:
>> [1462610.864928]  <IRQ>
>> [1462610.865021]  ? __warn+0x6c/0x130
>> [1462610.865124]  ? report_bug+0x1e4/0x260
>> [1462610.865223]  ? handle_bug+0x36/0x70
>> [1462610.865318]  ? exc_invalid_op+0x17/0x1a0
>> [1462610.865414]  ? asm_exc_invalid_op+0x16/0x20
>> [1462610.865517]  ? rcuref_put_slowpath+0x5f/0x70
>> [1462610.865618]  ? rcuref_put_slowpath+0x5f/0x70
>> [1462610.865719]  dst_release+0x2c/0x60
>> [1462610.865817]  rt_cache_route+0xbd/0xf0
>> [1462610.865913]  rt_set_nexthop.isra.0+0x1b6/0x440
>> [1462610.866008]  ip_route_input_slow+0x90e/0xc60
>> [1462610.866116]  ? nf_conntrack_udp_packet+0x16c/0x230 =
[nf_conntrack]
>> [1462610.866229]  ip_route_input_noref+0xed/0x100
>> [1462610.866328]  ip_rcv_finish_core.isra.0+0xb1/0x410
>> [1462610.866425]  ip_rcv+0xed/0x130
>> [1462610.866522]  ? ip_rcv_core.constprop.0+0x350/0x350
>> [1462610.866621]  process_backlog+0x10c/0x230
>> [1462610.866719]  __napi_poll+0x20/0x180
>> [1462610.866818]  net_rx_action+0x2a4/0x390
>> [1462610.866921]  __do_softirq+0xd0/0x202
>> [1462610.867020]  do_softirq+0x58/0x80
>> [1462610.867116]  </IRQ>
>> [1462610.867206]  <TASK>
>> [1462610.867298]  flush_smp_call_function_queue+0x3f/0x60
>> [1462610.867403]  do_idle+0x14d/0x210
>> [1462610.867500]  cpu_startup_entry+0x14/0x20
>> [1462610.867602]  start_secondary+0xec/0xf0
>> [1462610.867701]  secondary_startup_64_no_verify+0xf9/0xfb
>> [1462610.867799]  </TASK>
>> [1462610.867891] ---[ end trace 0000000000000000 ]=E2=80=94
>>=20
>>=20
>> And this si 6.5.4 :
>>=20
>> [39651.441371] ------------[ cut here ]------------
>> [39651.441455] rcuref - imbalanced put()
>> [39651.441470] WARNING: CPU: 12 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath+0x5f/0x70
>> [39651.441633] Modules linked in: nft_limit pppoe pppox ppp_generic =
slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp igb =
i2c_algo_bit i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
>> [39651.441805] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G           O =
      6.5.3 #1
>> [39651.441911] Hardware name: To Be Filled By O.E.M. To Be Filled By =
O.E.M./EP2C612D8, BIOS P2.30 04/30/2018
>> [39651.442035] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
>> [39651.442131] Code: 31 c0 eb e2 80 3d 86 ae e6 00 00 74 0a c7 03 00 =
00 00 e0 31 c0 eb cf 48 c7 c7 68 f6 e2 9a c6 05 6c ae e6 00 01 e8 11 71 =
c7 ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 =
e2
>> [39651.442294] RSP: 0018:ffffbb9a404b4de8 EFLAGS: 00010296
>> [39651.442390] RAX: 0000000000000019 RBX: ffffa13ac9a32640 RCX: =
00000000fff7ffff
>> [39651.442513] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: =
00000000ffffffea
>> [39651.442630] RBP: ffffa13a44a04000 R08: 0000000000000000 R09: =
00000000fff7ffff
>> [39651.442748] R10: ffffa1419ae00000 R11: 0000000000000003 R12: =
ffffa13ab640bec0
>> [39651.442866] R13: 0000000000000000 R14: 0000000000000010 R15: =
ffffbb9a404b4f60
>> [39651.442985] FS:  0000000000000000(0000) GS:ffffa1419f900000(0000) =
knlGS:0000000000000000
>> [39651.443106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [39651.443201] CR2: 0000564f9e23f6e0 CR3: 000000010bcea002 CR4: =
00000000003706e0
>> [39651.443319] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> [39651.443438] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> [39651.443558] Call Trace:
>> [39651.443647]  <IRQ>
>> [39651.443736]  ? __warn+0x6c/0x130
>> [39651.443829]  ? report_bug+0x1e4/0x260
>> [39651.443924]  ? handle_bug+0x36/0x70
>> [39651.444016]  ? exc_invalid_op+0x17/0x1a0
>> [39651.444109]  ? asm_exc_invalid_op+0x16/0x20
>> [39651.444202]  ? rcuref_put_slowpath+0x5f/0x70
>> [39651.444297]  ? rcuref_put_slowpath+0x5f/0x70
>> [39651.444391]  dst_release+0x2c/0x60
>> [39651.444487]  __dev_queue_xmit+0x56c/0xbd0
>> [39651.444582]  ? nf_hook_slow+0x36/0xa0
>> [39651.444675]  ip_finish_output2+0x27b/0x520
>> [39651.444770]  process_backlog+0x10c/0x230
>> [39651.444866]  __napi_poll+0x20/0x180
>> [39651.444961]  net_rx_action+0x2a4/0x390
>> [39651.445055]  __do_softirq+0xd0/0x202
>> [39651.445148]  do_softirq+0x3a/0x50
>> [39651.445241]  </IRQ>
>> [39651.445329]  <TASK>
>> [39651.445416]  flush_smp_call_function_queue+0x3f/0x50
>> [39651.445516]  do_idle+0x14d/0x210
>> [39651.445609]  cpu_startup_entry+0x14/0x20
>> [39651.445702]  start_secondary+0xe1/0xf0
>> [39651.445797]  secondary_startup_64_no_verify+0x167/0x16b
>> [39651.445893]  </TASK>
>> [39651.445982] ---[ end trace 0000000000000000 ]=E2=80=94
>>=20
>>=20
>> best regards,
>> Martin
>=20
> You keep sending traces without symbols, nobody here will even look at =
them.
>=20


Here is trace with symbols :=20

[39651.441371] ------------[ cut here ]------------
[39651.441455] rcuref - imbalanced put()
[39651.441470] WARNING: CPU: 12 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
[39651.441633] Modules linked in: nft_limit pppoe pppox ppp_generic slhc =
nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp igb =
i2c_algo_bit i40e ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
[39651.441805] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G           O    =
   6.5.3 #1
[39651.441911] Hardware name: To Be Filled By O.E.M. To Be Filled By =
O.E.M./EP2C612D8, BIOS P2.30 04/30/2018
[39651.442035] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:267 =
(discriminator 1))
[39651.442131] Code: 31 c0 eb e2 80 3d 86 ae e6 00 00 74 0a c7 03 00 00 =
00 e0 31 c0 eb cf 48 c7 c7 68 f6 e2 9a c6 05 6c ae e6 00 01 e8 11 71 c7 =
ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	31 c0                	xor    %eax,%eax
   2:	eb e2                	jmp    0xffffffffffffffe6
   4:	80 3d 86 ae e6 00 00 	cmpb   $0x0,0xe6ae86(%rip)        # =
0xe6ae91
   b:	74 0a                	je     0x17
   d:	c7 03 00 00 00 e0    	movl   $0xe0000000,(%rbx)
  13:	31 c0                	xor    %eax,%eax
  15:	eb cf                	jmp    0xffffffffffffffe6
  17:	48 c7 c7 68 f6 e2 9a 	mov    $0xffffffff9ae2f668,%rdi
  1e:	c6 05 6c ae e6 00 01 	movb   $0x1,0xe6ae6c(%rip)        # =
0xe6ae91
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
[39651.442294] RSP: 0018:ffffbb9a404b4de8 EFLAGS: 00010296
[39651.442390] RAX: 0000000000000019 RBX: ffffa13ac9a32640 RCX: =
00000000fff7ffff
[39651.442513] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[39651.442630] RBP: ffffa13a44a04000 R08: 0000000000000000 R09: =
00000000fff7ffff
[39651.442748] R10: ffffa1419ae00000 R11: 0000000000000003 R12: =
ffffa13ab640bec0
[39651.442866] R13: 0000000000000000 R14: 0000000000000010 R15: =
ffffbb9a404b4f60
[39651.442985] FS:  0000000000000000(0000) GS:ffffa1419f900000(0000) =
knlGS:0000000000000000
[39651.443106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39651.443201] CR2: 0000564f9e23f6e0 CR3: 000000010bcea002 CR4: =
00000000003706e0
[39651.443319] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[39651.443438] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[39651.443558] Call Trace:
[39651.443647]  <IRQ>
[39651.443736] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
[39651.443829] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[39651.443924] ? handle_bug (arch/x86/kernel/traps.c:324)
[39651.444016] ? exc_invalid_op (arch/x86/kernel/traps.c:345 =
(discriminator 1))
[39651.444109] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[39651.444202] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[39651.444297] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
[39651.444391] dst_release (./arch/x86/include/asm/preempt.h:95 =
./include/linux/rcuref.h:151 net/core/dst.c:166)
[39651.444487] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4158)
[39651.444582] ? nf_hook_slow (./include/linux/netfilter.h:143 =
net/netfilter/core.c:626)
[39651.444675] ip_finish_output2 (./include/linux/netdevice.h:3088 =
./include/net/neighbour.h:528 ./include/net/neighbour.h:542 =
net/ipv4/ip_output.c:230)
[39651.444770] process_backlog (./include/linux/rcupdate.h:781 =
net/core/dev.c:5896)
[39651.444866] __napi_poll (net/core/dev.c:6461)
[39651.444961] net_rx_action (net/core/dev.c:6530 net/core/dev.c:6661)
[39651.445055] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
[39651.445148] do_softirq (kernel/softirq.c:463 (discriminator 32) =
kernel/softirq.c:450 (discriminator 32))
[39651.445241]  </IRQ>
[39651.445329]  <TASK>
[39651.445416] flush_smp_call_function_queue =
(./arch/x86/include/asm/irqflags.h:134 (discriminator 1) =
kernel/smp.c:570 (discriminator 1))
[39651.445516] do_idle (kernel/sched/idle.c:314)
[39651.445609] cpu_startup_entry (kernel/sched/idle.c:378)
[39651.445702] start_secondary (arch/x86/kernel/smpboot.c:326)
[39651.445797] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
[39651.445893]  </TASK>
[39651.445982] ---[ end trace 0000000000000000 ]---



> Again, your best route is a bisection.

For now its not possible to make bisection , its hard to change kernel =
on running machine =E2=80=A6

is there another way to catch from where is come this bug message.

Best regards,
Martin=20





