Return-Path: <netdev+bounces-33074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0872279CA61
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD023280EAB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3308F40;
	Tue, 12 Sep 2023 08:42:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833441843
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:42:40 +0000 (UTC)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487A1FE9;
	Tue, 12 Sep 2023 01:42:38 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id D5FF21024CF9;
	Tue, 12 Sep 2023 11:42:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru D5FF21024CF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1694508155; bh=o5pd38GBTQwRmYAzeYxDd/4rQzPh+H8gE2oOiTG2l9k=;
	h=From:To:CC:Subject:Date:From;
	b=Cx8QQNHtsV5ufknr8Tny5cX0espXouYTxrAA/U/jNubsYan+ZWF/zWiBe2WEVIM8P
	 j1tXgqFheYUZsP6p3dJuw3TWQKF6Pd8m20PFSm+r345Ccj8a7y3a20g7ZXL314Fytu
	 GW70IbIuOTaOhc7srW2JCLpoeuAztQSeZ5m7xk1o=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id D2EB53000095;
	Tue, 12 Sep 2023 11:42:34 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Topic: [PATCH net-next] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Thread-Index: AQHZ5VUTNq1uzE92eEGQ9QqcA3I0wA==
Date: Tue, 12 Sep 2023 08:42:34 +0000
Message-ID: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2023/09/12 07:28:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/09/12 03:38:00 #21880520
X-KLMS-AntiVirus-Status: Clean, skipped

The 'state->im' value will always be non-zero after
the 'while' statement, so the check can be removed.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
Repost according to https://lore.kernel.org/all/fea6db56-3a01-b7c8-b800-a6c=
885e99feb@kernel.org/
 net/ipv4/igmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 418e5fb58fd3..76c3ea75b8dd 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2944,8 +2944,6 @@ static struct ip_sf_list *igmp_mcf_get_next(struct se=
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

