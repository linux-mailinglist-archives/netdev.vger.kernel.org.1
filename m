Return-Path: <netdev+bounces-33075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567379CA62
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462571C20D9C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1398F4E;
	Tue, 12 Sep 2023 08:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739378F40
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:42:52 +0000 (UTC)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B31713;
	Tue, 12 Sep 2023 01:42:51 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id EFABC1024BAE;
	Tue, 12 Sep 2023 11:42:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru EFABC1024BAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1694508170; bh=ULzrGpftkZgLqATIEQXgFNjR2HUnbe9KTr0sViGMoMQ=;
	h=From:To:CC:Subject:Date:From;
	b=gHYTFFAPLdMsPM5Pglhq5rJXFvWAzOtxC5EZCa8JZOq4x9Odxtu3xVLVLZqM4P0Lr
	 y4Z5sdtACPC9KR2lQQHFnL194uAKs3fmrgeati8dXyHH132EfcmaQfUw8i8P6MTPUR
	 NxaUXFZp/usuxvfFywNunXhEOexl6wmpzrQC2GSk=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id EDF8E30268F3;
	Tue, 12 Sep 2023 11:42:49 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] ipv6: mcast: Remove redundant comparison in
  igmp6_mcf_get_next()
Thread-Topic: [PATCH net-next] ipv6: mcast: Remove redundant comparison in
  igmp6_mcf_get_next()
Thread-Index: AQHZ5VUc01wdWD2zyUKZD0c8csOa5g==
Date: Tue, 12 Sep 2023 08:42:49 +0000
Message-ID: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
Repost according to https://lore.kernel.org/all/cdc2183a-c79a-b4bd-2726-bd3=
a2d6d5440@kernel.org/
 net/ipv6/mcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 5ce25bcb9974..421264a69e97 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -3011,8 +3011,6 @@ static struct ip6_sf_list *igmp6_mcf_get_next(struct =
seq_file *seq, struct ip6_s
 				continue;
 			state->im =3D rcu_dereference(state->idev->mc_list);
 		}
-		if (!state->im)
-			break;
 		psf =3D rcu_dereference(state->im->mca_sources);
 	}
 out:
--=20
2.39.2

