Return-Path: <netdev+bounces-34002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5A7A14A6
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AA81C20A3E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B972599;
	Fri, 15 Sep 2023 04:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9C2591
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 04:05:22 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E13268E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:05:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfb1167277so27241951fa.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694750718; x=1695355518; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWcFcCaJYAkquxx4cCMFv1RMQ/hDHYGRQbHjVnWTsUM=;
        b=Zhug7PLF1CKbPbDoRepZwinTdiDsDTpYemYGiufX7NU2JFmAlHj8MkneqDWI/oZ/f6
         myOtRSFSGIOPSxnK3vzUoPqyLRIUFSCd/nCCF+I1e6UG2neeVPl+8qvFLeCK1zxoM8dA
         qxP6npvdxTOg7tzU0YQc93EWm6IIA+BsnVgbQov01w+EvM24GdKyzT73zUhzuvp9SxIp
         vhJYTRKwbvop1GTrK829FGRh7hherqyl+pxMeZxJQEYG36jV6FtDYDkJ2IHA23d97kJy
         7RsfHdfz2V8lharMhyydJbHW6kiqg9RJMt9zcRHCooR7xuMHnx108kdd6PPZYDB+bNql
         B74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750718; x=1695355518;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWcFcCaJYAkquxx4cCMFv1RMQ/hDHYGRQbHjVnWTsUM=;
        b=BqcINY7n3dvtN7j8F80EQE02wFemdVhh5Z07IJKgVXLplX2loeT2csezczFY1GCmIz
         tWibQtBcG+4h8VvdnKECsqc0g3I0lMOpZhguRhpvcmuwK3zYxQP/OekiOaa+qvDNHp8m
         EpcU7yYzb/3zXW06e0ZxUir6DbLsiSdOCQwP57YSP7n1YQXNfHkrrX0gxDqHucOIrVyJ
         1eYxsUElHhqNkaL9JSseFCnfTn0EVdcjB5VK3UnDAnXcR/QGbUkNacFD0bNbxrSZSyOd
         yVOWUsD3PtAfZYK9K1FLAraE+fZ9pJ0IyNDkBLTU6LiJVsDfN75W4D0uV1xC+KtAtHYL
         Jz1g==
X-Gm-Message-State: AOJu0YxEl27cd8eKpnlpRqAhXrUEv0pTYM6TGh8s+TYMYgRbHqcdZzpA
	0BS1b6oD6p0ikUm+g11qHZPtKEcU3zw=
X-Google-Smtp-Source: AGHT+IEu2G9IYLF1eKV5qcmS3/2TlpG4N0ifikwu8WkL/swPKHA3si4uzsmvQ2rkpDHFU2NtYyImtA==
X-Received: by 2002:a2e:720a:0:b0:2bd:d34:f892 with SMTP id n10-20020a2e720a000000b002bd0d34f892mr546020ljc.3.1694750717832;
        Thu, 14 Sep 2023 21:05:17 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id vl3-20020a170907b60300b009adc77fe164sm732122ejc.66.2023.09.14.21.05.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 21:05:17 -0700 (PDT)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Urgent Bug Report Kernel crash 6.5.2 
Message-Id: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
Date: Fri, 15 Sep 2023 07:05:05 +0300
Cc: Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com
To: netdev <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All=20
This is report from kernel 6.5.2 after 4 day up system hang and reboot =
after this error :



Sep 15 04:32:29 205.254.184.12 [399661.971344][   C31] kernel tried to =
execute NX-protected page - exploit attempt? (uid: 0)
Sep 15 04:32:29 205.254.184.12 [399661.971470][   C31] BUG: unable to =
handle page fault for address: ffffa10c52d43058
Sep 15 04:32:29 205.254.184.12 [399661.971586][   C31] #PF: supervisor =
instruction fetch in kernel mode
Sep 15 04:32:29 205.254.184.12 [399661.971680][   C31] #PF: =
error_code(0x0011) - permissions violation
Sep 15 04:32:29 205.254.184.12 [399661.971775][   C31] PGD 12601067 P4D =
12601067 PUD 80000002400001e3
Sep 15 04:32:29 205.254.184.12 [399661.971871][   C31] Oops: 0011 [#1] =
PREEMPT SMP
Sep 15 04:32:29 205.254.184.12 [399661.971963][   C31] CPU: 31 PID: 0 =
Comm: swapper/31 Tainted: G        W  O       6.5.2 #1
Sep 15 04:32:29 205.254.184.12 [399661.972079][   C31] Hardware name: =
Supermicro SYS-5038MR-H8TRF/X10SRD-F, BIOS 3.3 10/28/2020
Sep 15 04:32:29 205.254.184.12 [399661.972197][   C31] RIP: =
0010:0xffffa10c52d43058
Sep 15 04:32:29 205.254.184.12 [399661.972289][   C31] Code: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 =
30 d4 52 0c a1 ff ff 00 00 00 00 00 00
Sep 15 04:32:29 205.254.184.12 [399661.972448][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
Sep 15 04:32:29 205.254.184.12 [399661.972543][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.972659][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
Sep 15 04:32:29 205.254.184.12 [399661.972774][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
Sep 15 04:32:29 205.254.184.12 [399661.972889][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
Sep 15 04:32:29 205.254.184.12 [399661.973005][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
Sep 15 04:32:29 205.254.184.12 [399661.973123][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.973244][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
Sep 15 04:32:29 205.254.184.12 [399661.973338][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
Sep 15 04:32:29 205.254.184.12 [399661.973454][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.973569][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Sep 15 04:32:29 205.254.184.12 [399661.973684][   C31] Call Trace:
Sep 15 04:32:29 205.254.184.12 [399661.973773][   C31]  <IRQ>
Sep 15 04:32:29 205.254.184.12 [399661.973859][   C31]  ? =
__die+0xe4/0xf0
Sep 15 04:32:29 205.254.184.12 [399661.973949][   C31]  ? =
page_fault_oops+0x144/0x3e0
Sep 15 04:32:29 205.254.184.12 [399661.974043][   C31]  ? =
exc_page_fault+0x92/0xa0
Sep 15 04:32:29 205.254.184.12 [399661.974136][   C31]  ? =
asm_exc_page_fault+0x22/0x30
Sep 15 04:32:29 205.254.184.12 [399661.974228][   C31]  ? =
kfree_skb_reason+0x33/0xf0
Sep 15 04:32:29 205.254.184.12 [399661.974321][   C31]  ? =
tcp_mtu_probe+0x3a6/0x7b0
Sep 15 04:32:29 205.254.184.12 [399661.974416][   C31]  ? =
tcp_write_xmit+0x7fa/0x1410
Sep 15 04:32:29 205.254.184.12 [399661.974509][   C31]  ? =
__tcp_push_pending_frames+0x2d/0xb0
Sep 15 04:32:29 205.254.184.12 [399661.974603][   C31]  ? =
tcp_rcv_established+0x381/0x610
Sep 15 04:32:29 205.254.184.12 [399661.974695][   C31]  ? =
sk_filter_trim_cap+0xc6/0x1c0
Sep 15 04:32:29 205.254.184.12 [399661.974787][   C31]  ? =
tcp_v4_do_rcv+0x11f/0x1f0
Sep 15 04:32:29 205.254.184.12 [399661.974877][   C31]  ? =
tcp_v4_rcv+0xfa1/0x1010
Sep 15 04:32:29 205.254.184.12 [399661.974968][   C31]  ? =
ip_protocol_deliver_rcu+0x1b/0x270
Sep 15 04:32:29 205.254.184.12 [399661.975062][   C31]  ? =
ip_local_deliver_finish+0x6d/0x90
Sep 15 04:32:29 205.254.184.12 [399661.976257][   C31]  ? =
process_backlog+0x10c/0x230
Sep 15 04:32:29 205.254.184.12 [399661.976352][   C31]  ? =
__napi_poll+0x20/0x180
Sep 15 04:32:29 205.254.184.12 [399661.976442][   C31]  ? =
net_rx_action+0x2a4/0x390
Sep 15 04:32:29 205.254.184.12 [399661.976534][   C31]  ? =
__do_softirq+0xd0/0x202
Sep 15 04:32:29 205.254.184.12 [399661.976626][   C31]  ? =
do_softirq+0x3a/0x50
Sep 15 04:32:29 205.254.184.12 [399661.976718][   C31]  </IRQ>
Sep 15 04:32:29 205.254.184.12 [399661.976805][   C31]  <TASK>
Sep 15 04:32:29 205.254.184.12 [399661.976890][   C31]  ? =
flush_smp_call_function_queue+0x3f/0x50
Sep 15 04:32:29 205.254.184.12 [399661.976988][   C31]  ? =
do_idle+0x14d/0x210
Sep 15 04:32:29 205.254.184.12 [399661.977078][   C31]  ? =
cpu_startup_entry+0x14/0x20
Sep 15 04:32:29 205.254.184.12 [399661.977168][   C31]  ? =
start_secondary+0xe1/0xf0
Sep 15 04:32:29 205.254.184.12 [399661.977262][   C31]  ? =
secondary_startup_64_no_verify+0x167/0x16b
Sep 15 04:32:29 205.254.184.12 [399661.977359][   C31]  </TASK>
Sep 15 04:32:29 205.254.184.12 [399661.977448][   C31] Modules linked =
in: nft_limit nf_conntrack_netlink  pppoe pppox ppp_generic slhc nft_ct =
nft_nat nft_chain_nat nf_tables netconsole coretemp bonding i40e =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos=20
Sep 15 04:32:29 205.254.184.12 [399661.977720][   C31] CR2: =
ffffa10c52d43058
Sep 15 04:32:29 205.254.184.12 [399661.977809][   C31] ---[ end trace =
0000000000000000 ]---
Sep 15 04:32:29 205.254.184.12 [399661.977901][   C31] RIP: =
0010:0xffffa10c52d43058
Sep 15 04:32:29 205.254.184.12 [399661.977992][   C31] Code: 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 58 =
30 d4 52 0c a1 ff ff 00 00 00 00 00 00
Sep 15 04:32:29 205.254.184.12 [399661.978150][   C31] RSP: =
0018:ffffad0e0097ccc8 EFLAGS: 00010282
Sep 15 04:32:29 205.254.184.12 [399661.978243][   C31] RAX: =
ffffa10c52d43058 RBX: ffffa10c52d43000 RCX: 0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.978358][   C31] RDX: =
0000000000002712 RSI: 0000000000000246 RDI: ffffa10c52d43000
Sep 15 04:32:29 205.254.184.12 [399661.978472][   C31] RBP: =
ffffa10c52d43000 R08: 0000000127a83c46 R09: 0000000000004d8c
Sep 15 04:32:29 205.254.184.12 [399661.978587][   C31] R10: =
ffffe840ca0f7c00 R11: 0000000000000000 R12: ffffa10c8e764d80
Sep 15 04:32:29 205.254.184.12 [399661.978702][   C31] R13: =
ffffa10c92b4c760 R14: 0000000000000058 R15: ffffa10c92b4c600
Sep 15 04:32:29 205.254.184.12 [399661.978818][   C31] FS:  =
0000000000000000(0000) GS:ffffa1125fdc0000(0000) knlGS:0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.978940][   C31] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
Sep 15 04:32:29 205.254.184.12 [399661.979036][   C31] CR2: =
ffffa10c52d43058 CR3: 00000001059b8001 CR4: 00000000003706e0
Sep 15 04:32:29 205.254.184.12 [399661.979150][   C31] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Sep 15 04:32:29 205.254.184.12 [399661.979265][   C31] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Sep 15 04:32:29 205.254.184.12 [399661.979381][   C31] Kernel panic - =
not syncing: Fatal exception in interrupt
Sep 15 04:32:29 205.254.184.12 [399662.084038][   C31] Kernel Offset: =
0x1e000000 from 0xffffffff81000000 (relocation range: =
0xffffffff80000000-0xffffffffbfffffff)
Sep 15 04:32:29 205.254.184.12 [399662.084162][   C31] Rebooting in 10 =
seconds..


Please if find fix update me .

m.=

