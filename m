Return-Path: <netdev+bounces-19082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534E75985B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91901C20C27
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481E156E7;
	Wed, 19 Jul 2023 14:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C6156E6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:42 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA710B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:29:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95eac836eso7329631fa.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689776979; x=1692368979;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1yyT1jOhSZbFBWg89Bp+RpbP2H6TOxo2NfH1lSH9qs=;
        b=Yj3Ejlg/zgomJhw4T9BCcx2iwIBsMWKCy4fNrMD6o0lqMEFH7aXaHX/0XiI7ZTY54x
         Y0dvCIja0Y/bGrOQxscRtuedd6Zc0M4+VATLaMIS+D/qvcxrtWZgxQJU7SMJ8W0zd55O
         mx/JM/Y9FagTQLbPasyf4usz5S4aXKnD5Ix4Y6OO1XTNsPoLEQsf/IDPO/4Btm2xEYgE
         O3ieo3+d44jb/CUJIeR9gUK933H5HPxFIKqv+g8I0oonZ/cROQXYV0PdWkKBP4X+3sh1
         lHJ5NYaYN9FG8ycpybFhmLR0+eihkiyJPOmaC7+EII+3df0nB34jIjvBpiuzlc4y6JMu
         UC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776979; x=1692368979;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1yyT1jOhSZbFBWg89Bp+RpbP2H6TOxo2NfH1lSH9qs=;
        b=WZWfg2NHuKfZKrxyAVMbwMWocTpUAr/dUd/97FfFyWKISVEBrX3Wwm285ESV0Olo5e
         EA42C8waKYrvtj21EYQxx4dHUR7ijloWqE02h5XUiKPo0wFlCBf//go35S74/sgQo8WQ
         y2uTnaTSX8ZRUN5bVnuUE2lKjwVpVOdUsLgAKhA+AtjSHg/9KACo2od6+7XXOM/muWZR
         8Fk8oJa7h3EVBbetrFLscnOQY3P4QmncZ84tajfucejBiJc7dCHlKHfiGNYWmr9cXCtS
         mvxQMUJgFbVt+OjCLu4dZlqIcAHdFburjUHmMWVlo912etTC78KI3BZ7vWxE83QX1zsk
         j3zA==
X-Gm-Message-State: ABy/qLYOndlMPBIhf4f/qHUBbpeGXycN3tCxs4s38xQU4H1/RWe+UwWB
	rp3uPMY6XWve9KnfUsJexNVEEu28G/tbxQ==
X-Google-Smtp-Source: APBJJlEM0Rp9KAtQIkRYBaDejZNNoN9j0ph2GypTGnXc0CcJSA4/rlOQQxfnzXRdk9VxL6BLAQk5bg==
X-Received: by 2002:a2e:9c82:0:b0:2b6:d2c5:4d54 with SMTP id x2-20020a2e9c82000000b002b6d2c54d54mr54037lji.18.1689776978576;
        Wed, 19 Jul 2023 07:29:38 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id a25-20020a17090682d900b009829d2e892csm2452592ejy.15.2023.07.19.07.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 07:29:38 -0700 (PDT)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: BUG REPORT : [patch V2 0/4] net, refcount: Address dst_entry
 reference count scalability issues - rcuref_put_slowpath+0x5f
Message-Id: <A70FD361-7147-4DD4-BFA4-1AD387C013E2@gmail.com>
Date: Wed, 19 Jul 2023 17:29:26 +0300
Cc: wangyang.guo@intel.com,
 arjan@linux.intel.com,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
To: glx@linutronix.de
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All

One report when have time to check:=20


[627332.393112] ------------[ cut here ]------------
[627332.393201] rcuref - imbalanced put()
[627332.393215] WARNING: CPU: 9 PID: 0 at lib/rcuref.c:267 =
rcuref_put_slowpath+0x5f/0x70
[627332.393377] Modules linked in: nft_limit nf_conntrack_netlink  pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
[627332.393548] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G           O     =
  6.4.2 #1
[627332.393666] Hardware name: Supermicro Super Server/X10SRD-F, BIOS =
3.3 10/28/2020
[627332.393785] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
[627332.393880] Code: 31 c0 eb e2 80 3d e2 de e6 00 00 74 0a c7 03 00 00 =
00 e0 31 c0 eb cf 48 c7 c7 7f 68 e5 b5 c6 05 c8 de e6 00 01 e8 81 bb c7 =
ff <0f> 0b eb df cc cc cc cc cc cc cc cc cc cc cc cc cc 48 89 fa 83 e2
[627332.394042] RSP: 0018:ffffa5ca00394d10 EFLAGS: 00010286
[627332.394138] RAX: 0000000000000019 RBX: ffff9ec1596904c0 RCX: =
00000000fffbffff
[627332.394256] RDX: 00000000fffbffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[627332.394375] RBP: ffff9ec10149e000 R08: 0000000000000000 R09: =
00000000fffbffff
[627332.394490] R10: ffff9ec87d600000 R11: 0000000000000003 R12: =
ffff9ec149bc6ec0
[627332.394604] R13: 0000000000000000 R14: ffff9ec1060d7200 R15: =
ffff9ec101132080
[627332.394720] FS:  0000000000000000(0000) GS:ffff9ec87fc40000(0000) =
knlGS:0000000000000000
[627332.394839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[627332.394935] CR2: 00007f78c2b82000 CR3: 0000000139573001 CR4: =
00000000003706e0
[627332.395050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[627332.395165] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[627332.395283] Call Trace:
[627332.395370]  <IRQ>
[627332.395455]  ? __warn+0x6c/0x130
[627332.395546]  ? report_bug+0x1e4/0x260
[627332.395637]  ? handle_bug+0x36/0x70
[627332.395728]  ? exc_invalid_op+0x17/0x1a0
[627332.395821]  ? asm_exc_invalid_op+0x16/0x20
[627332.395913]  ? rcuref_put_slowpath+0x5f/0x70
[627332.396007]  dst_release+0x2c/0x60
[627332.396098]  __dev_queue_xmit+0x56c/0xbd0
[627332.396192]  vlan_dev_hard_start_xmit+0x85/0xc0
[627332.396289]  dev_hard_start_xmit+0x95/0xe0
[627332.396379]  __dev_queue_xmit+0x64d/0xbd0
[627332.396468]  ? eth_header+0x25/0xc0
[627332.396557]  ip_finish_output2+0x13f/0x510
[627332.396648]  process_backlog+0x10c/0x230
[627332.396740]  __napi_poll+0x20/0x180
[627332.396831]  net_rx_action+0x2a4/0x390
[627332.396922]  __do_softirq+0xd0/0x202
[627332.397014]  do_softirq+0x58/0x80
[627332.397103]  </IRQ>
[627332.397189]  <TASK>
[627332.397274]  flush_smp_call_function_queue+0x3f/0x60
[627332.397370]  do_idle+0x14d/0x210
[627332.397458]  cpu_startup_entry+0x14/0x20
[627332.397551]  start_secondary+0xec/0xf0
[627332.397642]  secondary_startup_64_no_verify+0xf9/0xfb
[627332.397735]  </TASK>
[627332.397822] ---[ end trace 0000000000000000 ]=E2=80=94


Best regards,
Martin=

