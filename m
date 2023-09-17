Return-Path: <netdev+bounces-34337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225A7A355C
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 13:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22602816A8
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309DF2594;
	Sun, 17 Sep 2023 11:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB81877
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 11:35:32 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D9113
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:35:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50317080342so109863e87.2
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694950527; x=1695555327; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfp5FTzbalVn97S6kK+aoO9oj6JX/14dKJTbxZ8JqII=;
        b=CFjAQN1ZoeWoQx05EqGVAuvpzC0SPTgGrkxaoZX6wLaXp2Rs4fXWWYxiobwdxHmHhm
         TxGH6aik8zwd47CJB6Jazo0+/UYXxB/q3h2KwJWNY8u6sH8LXo4JBf7AJPd6Lt00YEJJ
         rxh+PvL3o1rEVcPU00LEdzsvqSrM9maU40ZWPTvimJ5yOSpl8iStNiLRA89FCnr7yKCA
         MQMaf58Zt2RkcsRwkW2WQNFMWvicdOdcTp8qNwJUVZozB63sv5nzDML0nUNyfhLmaVUg
         MrOzxmkFQuNUkNxZc36xfMJEj0g4qdBbdQHI2ATtGVlkVPJoxA+UDHZApJTidJzODSNH
         N1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694950527; x=1695555327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfp5FTzbalVn97S6kK+aoO9oj6JX/14dKJTbxZ8JqII=;
        b=vT1zhdoSmuoZ9qYxHOy/RWKy+j2nopuVpsTiF5l4pgCKYutSMFuqE6BrlQa2Ak+3jv
         dvAs2HIKYSRqVwOVV71NMKNacKhbH1zDrQXbjPOII/8WHukd/WocvgX5sP3ebaBf4AtJ
         etxe+OsZz2SzWmiZxLSUefZtKS1JQXEWeVWBaJLHX1XV0hVOOIUvFMkF0OrlJsQtwUXu
         yrOFE0YV7n6E9I8xuRHKNPAiDuB79t8/N8YAfFWuwxlJMELNSQeEuEmUi6fxgW45d/c2
         HsTzjdyaKRW/X6Gf7bOEGxYjPq5Vk2eHa+ZXANbAke0BuEX/oT3p3OdRcCAD1EbhbZPP
         VuIw==
X-Gm-Message-State: AOJu0YwZ/U04UT6+KkxOdX8OVU9Mxq3lVw1PPx307+7GqSTJoCeZ5DlA
	lEOCDE92QWFBJl1/Z03Lg7g=
X-Google-Smtp-Source: AGHT+IEEG9KlPoqYLPVjYY9j7vHpCWDx3cfAVxGUDTVCMVJjEjt3c5FERGHtOKx3moYyKMQbXRsCIQ==
X-Received: by 2002:a05:6512:31cd:b0:503:1722:bf3a with SMTP id j13-20020a05651231cd00b005031722bf3amr236225lfe.1.1694950527069;
        Sun, 17 Sep 2023 04:35:27 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090668d400b009a5f7fb51d1sm4851710ejr.40.2023.09.17.04.35.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 04:35:26 -0700 (PDT)
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
In-Reply-To: <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
Date: Sun, 17 Sep 2023 14:35:15 +0300
Cc: netdev <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B07167DB-6AAF-48DF-8627-9E977FD9F635@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
 <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
 <CALidq=UR=3rOHZczCnb1bEhbt9So60UZ5y60Cdh4aP41FkB5Tw@mail.gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo and Eric

See this is latest crash from kernel 6.5.3 without external moduls=E2=80=A6=
.


first is crash report , second is with decode:=20


Sep 17 11:43:11  [127675.391688][    C2] kernel tried to execute =
NX-protected page - exploit attempt? (uid: 0)
Sep 17 11:43:11  [127675.391780][    C2] BUG: unable to handle page =
fault for address: ffff9bd9ff20f858
Sep 17 11:43:11  [127675.391859][    C2] #PF: supervisor instruction =
fetch in kernel mode
Sep 17 11:43:11  [127675.391937][    C2] #PF: error_code(0x0011) - =
permissions violation
Sep 17 11:43:11  [127675.392014][    C2] PGD 1a601067 P4D 1a601067 PUD =
147b05063 PMD 800000023f2001e3
Sep 17 11:43:11  [127675.392099][    C2] Oops: 0011 [#1] PREEMPT SMP
Sep 17 11:43:11  [127675.392173][    C2] CPU: 2 PID: 0 Comm: swapper/2 =
Tainted: G           O       6.5.3 #1
Sep 17 11:43:11  [127675.392257][    C2] Hardware name: Supermicro =
SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
Sep 17 11:43:11  [127675.392338][    C2] RIP: 0010:0xffff9bd9ff20f858
Sep 17 11:43:11  [127675.392413][    C2] Code: 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 f8 20 ff d9 =
9b ff ff 00 00 00 00 00 00
Sep 17 11:43:11  [127675.392540][    C2] RSP: 0018:ffffadfe0007ccc8 =
EFLAGS: 00010282
Sep 17 11:43:11  [127675.392635][    C2] RAX: ffff9bd9ff20f858 RBX: =
ffff9bd9ff20f800 RCX: 0000000000000000
Sep 17 11:43:11  [127675.392753][    C2] RDX: 0000000000002711 RSI: =
0000000000000246 RDI: ffff9bd9ff20f800
Sep 17 11:43:11  [127675.392871][    C2] RBP: ffff9bd9ff20f800 R08: =
000000010ca6060f R09: 00000000000079f2
Sep 17 11:43:11  [127675.392988][    C2] R10: ffffd88b47077c00 R11: =
0000000000000000 R12: ffff9bd9bb6ca1c0
Sep 17 11:43:11  [127675.393107][    C2] R13: ffff9bd9b9013760 R14: =
0000000000000053 R15: ffff9bd9b9013600
Sep 17 11:43:11  [127675.393226][    C2] FS:  0000000000000000(0000) =
GS:ffff9be01f680000(0000) knlGS:0000000000000000
Sep 17 11:43:11  [127675.393347][    C2] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 17 11:43:11  [127675.393445][    C2] CR2: ffff9bd9ff20f858 CR3: =
0000000234668001 CR4: 00000000003706e0
Sep 17 11:43:11  [127675.393562][    C2] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 17 11:43:11  [127675.393677][    C2] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 17 11:43:11  [127675.393794][    C2] Call Trace:
Sep 17 11:43:11  [127675.393886][    C2]  <IRQ>
Sep 17 11:43:11  [127675.393973][    C2]  ? __die+0xe4/0xf0
Sep 17 11:43:11  [127675.394065][    C2]  ? page_fault_oops+0x144/0x3e0
Sep 17 11:43:11  [127675.394157][    C2]  ? exc_page_fault+0x92/0xa0
Sep 17 11:43:11  [127675.394251][    C2]  ? asm_exc_page_fault+0x22/0x30
Sep 17 11:43:11  [127675.394347][    C2]  ? kfree_skb_reason+0x33/0xf0
Sep 17 11:43:11  [127675.394443][    C2]  ? tcp_mtu_probe+0x3a6/0x7b0
Sep 17 11:43:11  [127675.394539][    C2]  ? tcp_write_xmit+0x7fa/0x1410
Sep 17 11:43:11  [127675.394634][    C2]  ? =
__tcp_push_pending_frames+0x2d/0xb0
Sep 17 11:43:11  [127675.394727][    C2]  ? =
tcp_rcv_established+0x205/0x610
Sep 17 11:43:11  [127675.394822][    C2]  ? =
sk_filter_trim_cap+0xc6/0x1c0
Sep 17 11:43:11  [127675.394914][    C2]  ? tcp_v4_do_rcv+0x11f/0x1f0
Sep 17 11:43:11  [127675.395007][    C2]  ? tcp_v4_rcv+0xfa1/0x1010
Sep 17 11:43:11  [127675.395100][    C2]  ? =
ip_protocol_deliver_rcu+0x1b/0x270
Sep 17 11:43:11  [127675.395196][    C2]  ? =
ip_local_deliver_finish+0x6d/0x90
Sep 17 11:43:11  [127675.395289][    C2]  ? process_backlog+0x10c/0x230
Sep 17 11:43:11  [127675.395386][    C2]  ? __napi_poll+0x20/0x180
Sep 17 11:43:11  [127675.395478][    C2]  ? net_rx_action+0x2a4/0x390
Sep 17 11:43:11  [127675.395572][    C2]  ? __do_softirq+0xd0/0x202
Sep 17 11:43:11  [127675.395666][    C2]  ? do_softirq+0x3a/0x50
Sep 17 11:43:11  [127675.395760][    C2]  </IRQ>
Sep 17 11:43:11  [127675.395849][    C2]  <TASK>
Sep 17 11:43:11  [127675.395939][    C2]  ? =
flush_smp_call_function_queue+0x3f/0x50
Sep 17 11:43:11  [127675.396039][    C2]  ? do_idle+0x14d/0x210
Sep 17 11:43:11  [127675.396132][    C2]  ? cpu_startup_entry+0x14/0x20
Sep 17 11:43:11  [127675.396224][    C2]  ? start_secondary+0xe1/0xf0
Sep 17 11:43:11  [127675.396318][    C2]  ? =
secondary_startup_64_no_verify+0x167/0x16b
Sep 17 11:43:11  [127675.396417][    C2]  </TASK>
Sep 17 11:43:11  [127675.396504][    C2] Modules linked in: =
nf_conntrack_netlink nft_limit pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos
Sep 17 11:43:11  [127675.396775][    C2] CR2: ffff9bd9ff20f858
Sep 17 11:43:11  [127675.396868][    C2] ---[ end trace 0000000000000000 =
]---
Sep 17 11:43:11  [127675.396961][    C2] RIP: 0010:0xffff9bd9ff20f858
Sep 17 11:43:11  [127675.397052][    C2] Code: 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 f8 20 ff d9 =
9b ff ff 00 00 00 00 00 00
Sep 17 11:43:11  [127675.397211][    C2] RSP: 0018:ffffadfe0007ccc8 =
EFLAGS: 00010282
Sep 17 11:43:11  [127675.397305][    C2] RAX: ffff9bd9ff20f858 RBX: =
ffff9bd9ff20f800 RCX: 0000000000000000
Sep 17 11:43:11  [127675.397419][    C2] RDX: 0000000000002711 RSI: =
0000000000000246 RDI: ffff9bd9ff20f800
Sep 17 11:43:11  [127675.397535][    C2] RBP: ffff9bd9ff20f800 R08: =
000000010ca6060f R09: 00000000000079f2
Sep 17 11:43:11  [127675.397651][    C2] R10: ffffd88b47077c00 R11: =
0000000000000000 R12: ffff9bd9bb6ca1c0
Sep 17 11:43:11  [127675.397767][    C2] R13: ffff9bd9b9013760 R14: =
0000000000000053 R15: ffff9bd9b9013600
Sep 17 11:43:11  [127675.397886][    C2] FS:  0000000000000000(0000) =
GS:ffff9be01f680000(0000) knlGS:0000000000000000
Sep 17 11:43:11  [127675.398006][    C2] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 17 11:43:11  [127675.398101][    C2] CR2: ffff9bd9ff20f858 CR3: =
0000000234668001 CR4: 00000000003706e0
Sep 17 11:43:11  [127675.398217][    C2] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 17 11:43:11  [127675.398334][    C2] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 17 11:43:11  [127675.398451][    C2] Kernel panic - not syncing: =
Fatal exception in interrupt
Sep 17 11:43:11  [127675.503611][    C2] Kernel Offset: 0x20000000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
Sep 17 11:43:11  [127675.503734][    C2] Rebooting in 10 seconds..





Second with decode:=20



Sep 17 11:43:11  [127675.391688][    C2] kernel tried to execute =
NX-protected page - exploit attempt? (uid: 0)
Sep 17 11:43:11  [127675.391780][    C2] BUG: unable to handle page =
fault for address: ffff9bd9ff20f858
Sep 17 11:43:11  [127675.391859][    C2] #PF: supervisor instruction =
fetch in kernel mode
Sep 17 11:43:11  [127675.391937][    C2] #PF: error_code(0x0011) - =
permissions violation
Sep 17 11:43:11  [127675.392014][    C2] PGD 1a601067 P4D 1a601067 PUD =
147b05063 PMD 800000023f2001e3
Sep 17 11:43:11  [127675.392099][    C2] Oops: 0011 [#1] PREEMPT SMP
Sep 17 11:43:11  [127675.392173][    C2] CPU: 2 PID: 0 Comm: swapper/2 =
Tainted: G           O       6.5.3 #1
Sep 17 11:43:11  [127675.392257][    C2] Hardware name: Supermicro =
SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
Sep 17 11:43:11  [127675.392338][    C2] RIP: 0010:0xffff9bd9ff20f858
Sep 17 11:43:11 [127675.392413][ C2] Code: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 f8 20 ff d9 9b ff =
ff 00 00 00 00 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
	...
  30:	00 00                	add    %al,(%rax)
  32:	58                   	pop    %rax
  33:*	f8                   	clc    		<-- trapping instruction
  34:	20 ff                	and    %bh,%bh
  36:	d9 9b ff ff 00 00    	fstps  0xffff(%rbx)
  3c:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	...
   8:	58                   	pop    %rax
   9:	f8                   	clc
   a:	20 ff                	and    %bh,%bh
   c:	d9 9b ff ff 00 00    	fstps  0xffff(%rbx)
  12:	00 00                	add    %al,(%rax)
	...
Sep 17 11:43:11  [127675.392540][    C2] RSP: 0018:ffffadfe0007ccc8 =
EFLAGS: 00010282
Sep 17 11:43:11  [127675.392635][    C2] RAX: ffff9bd9ff20f858 RBX: =
ffff9bd9ff20f800 RCX: 0000000000000000
Sep 17 11:43:11  [127675.392753][    C2] RDX: 0000000000002711 RSI: =
0000000000000246 RDI: ffff9bd9ff20f800
Sep 17 11:43:11  [127675.392871][    C2] RBP: ffff9bd9ff20f800 R08: =
000000010ca6060f R09: 00000000000079f2
Sep 17 11:43:11  [127675.392988][    C2] R10: ffffd88b47077c00 R11: =
0000000000000000 R12: ffff9bd9bb6ca1c0
Sep 17 11:43:11  [127675.393107][    C2] R13: ffff9bd9b9013760 R14: =
0000000000000053 R15: ffff9bd9b9013600
Sep 17 11:43:11  [127675.393226][    C2] FS:  0000000000000000(0000) =
GS:ffff9be01f680000(0000) knlGS:0000000000000000
Sep 17 11:43:11  [127675.393347][    C2] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 17 11:43:11  [127675.393445][    C2] CR2: ffff9bd9ff20f858 CR3: =
0000000234668001 CR4: 00000000003706e0
Sep 17 11:43:11  [127675.393562][    C2] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 17 11:43:11  [127675.393677][    C2] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 17 11:43:11  [127675.393794][    C2] Call Trace:
Sep 17 11:43:11  [127675.393886][    C2]  <IRQ>
Sep 17 11:43:11 [127675.393973][ C2] ? __die =
(arch/x86/kernel/dumpstack.c:478 (discriminator 1) =
arch/x86/kernel/dumpstack.c:465 (discriminator 1) =
arch/x86/kernel/dumpstack.c:420 (discriminator 1) =
arch/x86/kernel/dumpstack.c:434 (discriminator 1))
Sep 17 11:43:11 [127675.394065][ C2] ? page_fault_oops =
(arch/x86/mm/fault.c:703)
Sep 17 11:43:11 [127675.394157][ C2] ? exc_page_fault =
(arch/x86/mm/fault.c:48 (discriminator 2) arch/x86/mm/fault.c:1479 =
(discriminator 2) arch/x86/mm/fault.c:1542 (discriminator 2))
Sep 17 11:43:11 [127675.394251][ C2] ? asm_exc_page_fault =
(./arch/x86/include/asm/idtentry.h:570)
Sep 17 11:43:11 [127675.394347][ C2] ? kfree_skb_reason =
(net/core/skbuff.c:1006 net/core/skbuff.c:1022 net/core/skbuff.c:1058)
Sep 17 11:43:11 [127675.394443][ C2] ? tcp_mtu_probe =
(./include/net/sock.h:1627 (discriminator 1) net/ipv4/tcp_output.c:2338 =
(discriminator 1) net/ipv4/tcp_output.c:2463 (discriminator 1))
Sep 17 11:43:11 [127675.394539][ C2] ? tcp_write_xmit =
(net/ipv4/tcp_output.c:2678)
Sep 17 11:43:11 [127675.394634][ C2] ? __tcp_push_pending_frames =
(net/ipv4/tcp_output.c:2940 (discriminator 1))
Sep 17 11:43:11 [127675.394727][ C2] ? tcp_rcv_established =
(./include/net/tcp.h:2033 net/ipv4/tcp_input.c:5545 =
net/ipv4/tcp_input.c:6065)
Sep 17 11:43:11 [127675.394822][ C2] ? sk_filter_trim_cap =
(./include/linux/rcupdate.h:781 net/core/filter.c:157)
Sep 17 11:43:11 [127675.394914][ C2] ? tcp_v4_do_rcv =
(net/ipv4/tcp_ipv4.c:1728)
Sep 17 11:43:11 [127675.395007][ C2] ? tcp_v4_rcv =
(./include/net/tcp.h:2342 (discriminator 1) net/ipv4/tcp_ipv4.c:2147 =
(discriminator 1))
Sep 17 11:43:11 [127675.395100][ C2] ? ip_protocol_deliver_rcu =
(net/ipv4/ip_input.c:205)
Sep 17 11:43:11 [127675.395196][ C2] ? ip_local_deliver_finish =
(net/ipv4/ip_input.c:233 (discriminator 1))
Sep 17 11:43:11 [127675.395289][ C2] ? process_backlog =
(net/core/dev.c:5451 net/core/dev.c:5566 net/core/dev.c:5895)
Sep 17 11:43:11 [127675.395386][ C2] ? __napi_poll+0x20/0x180
Sep 17 11:43:11 [127675.395478][ C2] ? net_rx_action =
(net/core/dev.c:5839 net/core/dev.c:5860 net/core/dev.c:6684)
Sep 17 11:43:11 [127675.395572][ C2] ? __do_softirq =
(./arch/x86/include/asm/bitops.h:319 kernel/softirq.c:550)
Sep 17 11:43:11 [127675.395666][ C2] ? do_softirq (kernel/softirq.c:463 =
(discriminator 32))
Sep 17 11:43:11  [127675.395760][    C2]  </IRQ>
Sep 17 11:43:11  [127675.395849][    C2]  <TASK>
Sep 17 11:43:11 [127675.395939][ C2] ? flush_smp_call_function_queue =
(kernel/smp.c:563 (discriminator 1))
Sep 17 11:43:11 [127675.396039][ C2] ? do_idle (kernel/sched/idle.c:295)
Sep 17 11:43:11 [127675.396132][ C2] ? cpu_startup_entry =
(kernel/sched/idle.c:379 (discriminator 1))
Sep 17 11:43:11 [127675.396224][ C2] ? start_secondary =
(arch/x86/kernel/smpboot.c:326)
Sep 17 11:43:11 [127675.396318][ C2] ? secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:441)
Sep 17 11:43:11  [127675.396417][    C2]  </TASK>
Sep 17 11:43:11  [127675.396504][    C2] Modules linked in: =
nf_conntrack_netlink nft_limit pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos
Sep 17 11:43:11  [127675.396775][    C2] CR2: ffff9bd9ff20f858
Sep 17 11:43:11  [127675.396868][    C2] ---[ end trace 0000000000000000 =
]---
Sep 17 11:43:11  [127675.396961][    C2] RIP: 0010:0xffff9bd9ff20f858
Sep 17 11:43:11 [127675.397052][ C2] Code: 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 f8 20 ff d9 9b ff =
ff 00 00 00 00 00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
	...
  30:	00 00                	add    %al,(%rax)
  32:	58                   	pop    %rax
  33:*	f8                   	clc    		<-- trapping instruction
  34:	20 ff                	and    %bh,%bh
  36:	d9 9b ff ff 00 00    	fstps  0xffff(%rbx)
  3c:	00 00                	add    %al,(%rax)
	...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	...
   8:	58                   	pop    %rax
   9:	f8                   	clc
   a:	20 ff                	and    %bh,%bh
   c:	d9 9b ff ff 00 00    	fstps  0xffff(%rbx)
  12:	00 00                	add    %al,(%rax)
	...
Sep 17 11:43:11  [127675.397211][    C2] RSP: 0018:ffffadfe0007ccc8 =
EFLAGS: 00010282
Sep 17 11:43:11  [127675.397305][    C2] RAX: ffff9bd9ff20f858 RBX: =
ffff9bd9ff20f800 RCX: 0000000000000000
Sep 17 11:43:11  [127675.397419][    C2] RDX: 0000000000002711 RSI: =
0000000000000246 RDI: ffff9bd9ff20f800
Sep 17 11:43:11  [127675.397535][    C2] RBP: ffff9bd9ff20f800 R08: =
000000010ca6060f R09: 00000000000079f2
Sep 17 11:43:11  [127675.397651][    C2] R10: ffffd88b47077c00 R11: =
0000000000000000 R12: ffff9bd9bb6ca1c0
Sep 17 11:43:11  [127675.397767][    C2] R13: ffff9bd9b9013760 R14: =
0000000000000053 R15: ffff9bd9b9013600
Sep 17 11:43:11  [127675.397886][    C2] FS:  0000000000000000(0000) =
GS:ffff9be01f680000(0000) knlGS:0000000000000000
Sep 17 11:43:11  [127675.398006][    C2] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Sep 17 11:43:11  [127675.398101][    C2] CR2: ffff9bd9ff20f858 CR3: =
0000000234668001 CR4: 00000000003706e0
Sep 17 11:43:11  [127675.398217][    C2] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Sep 17 11:43:11  [127675.398334][    C2] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Sep 17 11:43:11  [127675.398451][    C2] Kernel panic - not syncing: =
Fatal exception in interrupt
Sep 17 11:43:11  [127675.503611][    C2] Kernel Offset: 0x20000000 from =
0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
Sep 17 11:43:11  [127675.503734][    C2] Rebooting in 10 seconds..



P.S.

upload kernel on 5 machine with diff hw and make same on every one .


Best regrads,
m.

> On 16 Sep 2023, at 12:04, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi Paolo
>=20
> in first report machine dont have out of tree module
>=20
> this bug is come after move from kernel 6.2 to 6.3
>=20
> m.
>=20
> On Sat, Sep 16, 2023, 11:27 Paolo Abeni <pabeni@redhat.com> wrote:
> On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
> > one more log:
> >=20
> > Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here =
]------------
> > Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
> > Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at =
lib/rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator =
1))
> > Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: =
nft_limit nf_conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc =
nft_ct nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nf_xnatlog(O) ipmi_si ipmi_devintf =
ipmi_msghandler rtc_cmos [last unloaded: BNGBOOT(O)]
> > Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: =
swapper/5 Tainted: G           O       6.5.2 #1
>=20
>=20
> You have out-of-tree modules taint in all the report you shared. =
Please
> try to reproduce the issue with such taint, thanks!
>=20
> Paolo
>=20


