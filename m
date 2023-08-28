Return-Path: <netdev+bounces-31010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73B78A88D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE91C2085F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9254C8D;
	Mon, 28 Aug 2023 09:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81063A48
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:11:27 +0000 (UTC)
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 02:11:24 PDT
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F15EC;
	Mon, 28 Aug 2023 02:11:24 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 844C71024B9B;
	Mon, 28 Aug 2023 12:01:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 844C71024B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1693213287; bh=e1LoLEWqLdQNVrpbhibyY/jWf0inRICe7rnSUvTENN0=;
	h=From:To:CC:Subject:Date:From;
	b=fLh36ZdSjclfmkdDwDaGK+bsxz1dmHZS7EhQ6zmCjcMP1qGPw3NPayV1J4A2daORZ
	 9gU6bLFP5UIPriKd0iJGTXA48/brPI/K2IX6jlmc7hGmpIBQgj3uVGusFnE0Z2YHrc
	 xP9qzkOCLwwczEKJiYKGEhxdH/M+P6GetX5nT950=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 8110F3032702;
	Mon, 28 Aug 2023 12:01:27 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Topic: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Index: AQHZ2Y46eeJuAyOxGUmxwt3NBxsAdw==
Date: Mon, 28 Aug 2023 09:01:27 +0000
Message-ID: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/08/28 08:24:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/08/28 04:26:00 #21751202
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 'state->im' value will always be non-zero after
the 'while' statement, so the check can be removed.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/ipv4/igmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 48ff5f13e797..6ebf06886527 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2943,8 +2943,6 @@ static struct ip_sf_list *igmp_mcf_get_next(struct se=
q_file *seq, struct ip_sf_l
 				continue;
 			state->im =3D rcu_dereference(state->idev->mc_list);
 		}
-		if (!state->im)
-			break;
 		spin_lock_bh(&state->im->lock);
 		psf =3D state->im->sources;
 	}
--=20
2.39.2

