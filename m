Return-Path: <netdev+bounces-33033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A879C6B9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD182816FB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D75171B0;
	Tue, 12 Sep 2023 06:14:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA94171A9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:14:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83CAF
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 23:14:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50078eba7afso9023282e87.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694499272; x=1695104072; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqASKGUihfaPeVxKxNA5kVT9gZEeB1K+F58jdlvSr6k=;
        b=IaStina1oDkC50hkdrmDUNUXHV7V53En7PgtYTqKq1PLhFJt9lFzQKyAFjmQ1Zrizo
         QQ61IMA3cWuyaAQyMTfpT0KL+hapBOiK9sKKKJhiFLOfaDQDyt0ct2HuiclytBy2++pR
         B95cRO6OZCzXNsDWSBJo5Ze3mw0jHaN5qObWG6eo/Xvskr4lAtvn5McuvY5j+SMvzCTp
         Inp7e2gvoF9nNIKlx9eNaUHmxaoNHkkRwOefddxDl7SMPcQjPq8doA0cMytujGbePerY
         w/RiRqlvO4kFMfOCyWHeUv1dgei7gwP7IVr0mrzUd1UtRZ5AIgkuvkl21EN6LyjcvDYo
         RBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694499272; x=1695104072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqASKGUihfaPeVxKxNA5kVT9gZEeB1K+F58jdlvSr6k=;
        b=K/5BwQvsBSPIIyz0i0kEycxsks27m9Ro09S8+4t3BJte2TcZzXvfqKbt6yXDOgCyiw
         NCqsinEhhFALzStArtpiUwDuYHyFo/tLyP6Z4SILl6mHM4Z+I3g9uoBvetCvkpZQyuDi
         9FpQL6brnGgnjKe0gQzyIQc/2QK/9Tdk/J00NNk5d5wbCyy6+hItjLHSPuSVlFC10Ak4
         dvM8tfgcHIgBW0WJzz9dcY9lhbLWA3ESqfF0WO18duKUFF/94gUKjIvoJREhzlm4/qg4
         d5Yq019ImZi3uxRDKe/26fhvbPHIYYfV/xjtadx3/YlsUwDm/KMsednxNuZoW5nAiuN9
         EUkA==
X-Gm-Message-State: AOJu0YxUOrdkn32HCu9D3ufF/vbQQLfAP5x/eAiusV+wKnHDuvDFIcwM
	/WwEfKRFx41tqUwmWS4Ymzg=
X-Google-Smtp-Source: AGHT+IFsENuybcQ9FFg5eoYfqnBNXiJ+n9LSUYNEUfzIeGTuwYUhKN9uxXZ6N+kpoOyXMA1j1ntiuw==
X-Received: by 2002:a05:6512:1d1:b0:501:a5de:afed with SMTP id f17-20020a05651201d100b00501a5deafedmr8700972lfp.37.1694499271587;
        Mon, 11 Sep 2023 23:14:31 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709066d4b00b0099cb0a7098dsm6376479ejt.19.2023.09.11.23.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:14:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: BUG REPORT : [patch V2 0/4] net, refcount: Address dst_entry
 reference count scalability issues - rcuref_put_slowpath+0x5f
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <A70FD361-7147-4DD4-BFA4-1AD387C013E2@gmail.com>
Date: Tue, 12 Sep 2023 09:14:19 +0300
Cc: wangyang.guo@intel.com,
 arjan@linux.intel.com,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F71A8BD4-97CD-46AB-ACE9-B66BFDB30050@gmail.com>
References: <A70FD361-7147-4DD4-BFA4-1AD387C013E2@gmail.com>
To: glx@linutronix.de
X-Mailer: Apple Mail (2.3731.700.6)

Hi all
any update=20

this is same report from kernel 6.5.2:=20

[151563.298466] ------------[ cut here ]------------
[151563.298550] rcuref - imbalanced put()
[151563.298564] WARNING: CPU: 5 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath+0x5f/0x70
[151563.298724] Modules linked in: nft_limit nf_conntrack_netlink pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding i40e nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos=20
[151563.298894] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G           O     =
  6.5.2 #1
[151563.298975] Hardware name: Supermicro SYS-5038MR-H8TRF/X10SRD-F, =
BIOS 3.3 10/28/2020
[151563.299091] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
[151563.299185] Code: 31 c0 eb e2 80 3d c7 b8 e6 00 00 74 0a c7 03 00 00 =
00 e0 31 c0 eb cf 48 c7 c7 9b f5 e2 9f c6 05 ad b8 e6 00 01 e8 01 7b c7 =
ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
[151563.299344] RSP: 0018:ffffad0e0033cde8 EFLAGS: 00010296
[151563.299440] RAX: 0000000000000019 RBX: ffffa10ba37ce100 RCX: =
00000000fff7ffff
[151563.299558] RDX: 00000000fff7ffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[151563.299677] RBP: ffffa10b05c76000 R08: 0000000000000000 R09: =
00000000fff7ffff
[151563.299796] R10: ffffa1125ae00000 R11: 0000000000000003 R12: =
ffffa10b5f1a4ec0
[151563.299914] R13: 0000000000000000 R14: 0000000000000258 R15: =
ffffad0e0033cf60
[151563.300030] FS:  0000000000000000(0000) GS:ffffa1125f740000(0000) =
knlGS:0000000000000000
[151563.300152] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[151563.300248] CR2: 00007fade7f56d40 CR3: 000000010088e005 CR4: =
00000000003706e0
[151563.300363] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[151563.300478] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[151563.300593] Call Trace:
[151563.300683]  <IRQ>
[151563.300769]  ? __warn+0x6c/0x130
[151563.300861]  ? report_bug+0x1e4/0x260
[151563.300952]  ? handle_bug+0x36/0x70
[151563.301043]  ? exc_invalid_op+0x17/0x1a0
[151563.301134]  ? asm_exc_invalid_op+0x16/0x20
[151563.301225]  ? rcuref_put_slowpath+0x5f/0x70
[151563.301319]  ? rcuref_put_slowpath+0x5f/0x70
[151563.301412]  dst_release+0x2c/0x60
[151563.301502]  __dev_queue_xmit+0x56c/0xbd0
[151563.301595]  ? eth_header+0x25/0xc0
[151563.301686]  ip_finish_output2+0x13f/0x510
[151563.301778]  process_backlog+0x10c/0x230
[151563.301871]  __napi_poll+0x20/0x180
[151563.301964]  net_rx_action+0x2a4/0x390
[151563.302057]  __do_softirq+0xd0/0x202
[151563.302150]  do_softirq+0x3a/0x50
[151563.302240]  </IRQ>
[151563.302326]  <TASK>
[151563.302416]  flush_smp_call_function_queue+0x3f/0x50
[151563.302518]  do_idle+0x14d/0x210
[151563.302612]  cpu_startup_entry+0x14/0x20
[151563.302707]  start_secondary+0xe1/0xf0
[151563.302805]  secondary_startup_64_no_verify+0x167/0x16b
[151563.302900]  </TASK>
[151563.302986] ---[ end trace 0000000000000000 ]---

> On 19 Jul 2023, at 17:29, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi All
>=20
> One report when have time to check:=20
>=20
>=20
> [627332.393112] ------------[ cut here ]------------
> [627332.393201] rcuref - imbalanced put()
> [627332.393215] WARNING: CPU: 9 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath+0x5f/0x70
> [627332.393377] Modules linked in: nft_limit nf_conntrack_netlink  =
pppoe pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables =
netconsole coretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip =
nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [627332.393548] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G           O   =
    6.4.2 #1
> [627332.393666] Hardware name: Supermicro Super Server/X10SRD-F, BIOS =
3.3 10/28/2020
> [627332.393785] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
> [627332.393880] Code: 31 c0 eb e2 80 3d e2 de e6 00 00 74 0a c7 03 00 =
00 00 e0 31 c0 eb cf 48 c7 c7 7f 68 e5 b5 c6 05 c8 de e6 00 01 e8 81 bb =
c7 ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 =
e2
> [627332.394042] RSP: 0018:ffffa5ca00394d10 EFLAGS: 00010286
> [627332.394138] RAX: 0000000000000019 RBX: ffff9ec1596904c0 RCX: =
00000000fffbffff
> [627332.394256] RDX: 00000000fffbffff RSI: 0000000000000001 RDI: =
00000000ffffffea
> [627332.394375] RBP: ffff9ec10149e000 R08: 0000000000000000 R09: =
00000000fffbffff
> [627332.394490] R10: ffff9ec87d600000 R11: 0000000000000003 R12: =
ffff9ec149bc6ec0
> [627332.394604] R13: 0000000000000000 R14: ffff9ec1060d7200 R15: =
ffff9ec101132080
> [627332.394720] FS:  0000000000000000(0000) GS:ffff9ec87fc40000(0000) =
knlGS:0000000000000000
> [627332.394839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [627332.394935] CR2: 00007f78c2b82000 CR3: 0000000139573001 CR4: =
00000000003706e0
> [627332.395050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [627332.395165] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [627332.395283] Call Trace:
> [627332.395370]  <IRQ>
> [627332.395455]  ? __warn+0x6c/0x130
> [627332.395546]  ? report_bug+0x1e4/0x260
> [627332.395637]  ? handle_bug+0x36/0x70
> [627332.395728]  ? exc_invalid_op+0x17/0x1a0
> [627332.395821]  ? asm_exc_invalid_op+0x16/0x20
> [627332.395913]  ? rcuref_put_slowpath+0x5f/0x70
> [627332.396007]  dst_release+0x2c/0x60
> [627332.396098]  __dev_queue_xmit+0x56c/0xbd0
> [627332.396192]  vlan_dev_hard_start_xmit+0x85/0xc0
> [627332.396289]  dev_hard_start_xmit+0x95/0xe0
> [627332.396379]  __dev_queue_xmit+0x64d/0xbd0
> [627332.396468]  ? eth_header+0x25/0xc0
> [627332.396557]  ip_finish_output2+0x13f/0x510
> [627332.396648]  process_backlog+0x10c/0x230
> [627332.396740]  __napi_poll+0x20/0x180
> [627332.396831]  net_rx_action+0x2a4/0x390
> [627332.396922]  __do_softirq+0xd0/0x202
> [627332.397014]  do_softirq+0x58/0x80
> [627332.397103]  </IRQ>
> [627332.397189]  <TASK>
> [627332.397274]  flush_smp_call_function_queue+0x3f/0x60
> [627332.397370]  do_idle+0x14d/0x210
> [627332.397458]  cpu_startup_entry+0x14/0x20
> [627332.397551]  start_secondary+0xec/0xf0
> [627332.397642]  secondary_startup_64_no_verify+0xf9/0xfb
> [627332.397735]  </TASK>
> [627332.397822] ---[ end trace 0000000000000000 ]=E2=80=94
>=20
>=20
> Best regards,
> Martin



