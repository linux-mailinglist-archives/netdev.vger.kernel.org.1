Return-Path: <netdev+bounces-178991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B54A79DE9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7713B3B3A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636924293D;
	Thu,  3 Apr 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="geHrIMk1"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC81EF092;
	Thu,  3 Apr 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668450; cv=none; b=NshUltrjcK7w/W4oQEnmcRB6GfYdJwwZevyKqrxrWWfMb+TlCv54pT4Cyv3jGxwVcV5CwG0VB04AweLTxKVziEifP/lF5gviE7q8MsMGINVWHhOVASVCLUAffidNs4+DCH898ip4knsVhJR9AGbH3N+oEaaK7QrLp33lx131xZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668450; c=relaxed/simple;
	bh=oOy9SaCetbLIxPQj/SNMUa2FKbe0MxO6KmEYLKcGSDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SijKz92KhGt9BpLVx97Eb6EaEFC7Ge9Q75JprWDbWU0UYrl8maGmffg7FjBApXGwXynPdBwEQIbTRP+TAM/9tr85oLBDiq65P1iebYe9FqfSs+/5UoQwe7yD3N1eZ4xEcSZlKh3EkEpuOEQi5wsWnXGjqR8MMZ4Xf70edZIocUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=geHrIMk1; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id CCCB8C0019;
	Thu,  3 Apr 2025 11:20:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru CCCB8C0019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1743668439; bh=YTS2HHkGl6vv90e1u0OfipkGJc4P/NO4h3v6E9uRqq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=geHrIMk1MGDCl+aVe19qoNl946keFH3Np8EziP6hHBi2NgIICG6cAUi/XpTRUCQ5U
	 G9frMkHkTw5Y7dDyeMeGfzeqMk2edT2K/2x2UGyyzgQ4M5xkt29Mwmlp2TL+nAb30q
	 1nHltz/X5y/oZXp/bMeSwvNKN0ACrksGmGQhjr7k0kYF6ymRIWrBdYs9fJu4abrLpp
	 28FduAw2yvOTnkcYON4HDy2PYxCzfBuW35+5XYwE6dbmLysiKbMGh+dLH6ZlyX0aJS
	 CkzPOMahqac3Yi1EISt0ZvTLlFrysqVuBBqsEOtkGcLzCP2+Rg8VNg53A0t4F02fyB
	 ZeH8BSGbFWG8Q==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu,  3 Apr 2025 11:20:39 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 11:20:39 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Ivan Abramov <i.abramov@mt-integration.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2 1/3] ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
Date: Thu, 3 Apr 2025 11:20:19 +0300
Message-ID: <20250403082021.990667-2-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403082021.990667-1-i.abramov@mt-integration.ru>
References: <20250403082021.990667-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;ksmg01.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192326 [Apr 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/03 03:59:00 #27851158
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

Currently, the return value of device_rename() is not acted upon.

To avoid an inconsistent state in case of failure, roll back the changes
made before the device_rename() call.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 66e5c2672cd1 ("ieee802154: add netns support")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
---
v2: Make sure to commit against latest netdev/net.

 net/ieee802154/core.c | 45 ++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 89b671b12600..84d514430e45 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -233,31 +233,36 @@ int cfg802154_switch_netns(struct cfg802154_registered_device *rdev,
 		wpan_dev->netdev->netns_immutable = true;
 	}
 
-	if (err) {
-		/* failed -- clean up to old netns */
-		net = wpan_phy_net(&rdev->wpan_phy);
-
-		list_for_each_entry_continue_reverse(wpan_dev,
-						     &rdev->wpan_dev_list,
-						     list) {
-			if (!wpan_dev->netdev)
-				continue;
-			wpan_dev->netdev->netns_immutable = false;
-			err = dev_change_net_namespace(wpan_dev->netdev, net,
-						       "wpan%d");
-			WARN_ON(err);
-			wpan_dev->netdev->netns_immutable = true;
-		}
-
-		return err;
-	}
-
-	wpan_phy_net_set(&rdev->wpan_phy, net);
+	if (err)
+		goto errout;
 
 	err = device_rename(&rdev->wpan_phy.dev, dev_name(&rdev->wpan_phy.dev));
 	WARN_ON(err);
 
+	if (err)
+		goto errout;
+
+	wpan_phy_net_set(&rdev->wpan_phy, net);
+
 	return 0;
+
+errout:
+	/* failed -- clean up to old netns */
+	net = wpan_phy_net(&rdev->wpan_phy);
+
+	list_for_each_entry_continue_reverse(wpan_dev,
+					     &rdev->wpan_dev_list,
+					     list) {
+		if (!wpan_dev->netdev)
+			continue;
+		wpan_dev->netdev->netns_immutable = false;
+		err = dev_change_net_namespace(wpan_dev->netdev, net,
+					       "wpan%d");
+		WARN_ON(err);
+		wpan_dev->netdev->netns_immutable = true;
+	}
+
+	return err;
 }
 
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
-- 
2.39.5


