Return-Path: <netdev+bounces-235875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF3C36F3C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653ED680157
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491B342CBD;
	Wed,  5 Nov 2025 16:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499233FE03;
	Wed,  5 Nov 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359309; cv=none; b=OyFnMbIyZm32HAYcAnyfNj2AESOOWNvW9oqZCzg8bPJ5d3ulCsMmApUnFjnM6VjD4N1mnJ2UaQiGHe3vVJsJs090WozSZgpzlFwmR6m1VIq41AcYIoKkIjGypKT01Kq0fR5Uo/XNPtFACgcjpE32NSWlzLPNt1mlwDPsZC//Y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359309; c=relaxed/simple;
	bh=xRowRGn5uURAtDUAHpfM2G+qq4YuX3cwM/LW7HARYIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptJzXabEXs6veLkkEASy3TPUSd++qHImTVG3zEQU49x2px9/iY2QK68uqtY6ve6EyGIynXn9/HqCXYTDVQuU7RV/lc+26VfFTRppP/GXAI5+TuK4Hl0JJ1Z26SpZXmvp8vwP11YMBGeAbtc4MG0Ol7tIx4b0GxHShbYhuT0lmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1r4z6fRbzHnGk3;
	Thu,  6 Nov 2025 00:14:59 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 855AE1400DB;
	Thu,  6 Nov 2025 00:15:05 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:15:05 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 11/14] ipvlan: const-specifier for functions that use iaddr
Date: Wed, 5 Nov 2025 19:14:47 +0300
Message-ID: <20251105161450.1730216-12-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

Fix functions that accept "void *iaddr" as param to have
const-specifier.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan.h      | 6 +++---
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 drivers/net/ipvlan/ipvlan_main.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index faba1308c135..be2bc2d33ddb 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -194,11 +194,11 @@ void ipvlan_multicast_enqueue(struct ipvl_port *port,
 int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev);
 void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr);
 int ipvlan_add_addr(struct ipvl_dev *ipvlan,
-		    void *iaddr, bool is_v6, const u8 *hwaddr);
-void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6);
+		    const void *iaddr, bool is_v6, const u8 *hwaddr);
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6);
 struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 				   const void *iaddr, bool is_v6);
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6);
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6);
 void ipvlan_ht_addr_del(struct ipvl_addr *addr);
 struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 				     int addr_type, bool use_dest);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index cba1378cc920..b38ce991e832 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -121,7 +121,7 @@ struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
 	return ret;
 }
 
-bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
+bool ipvlan_addr_busy(struct ipvl_port *port, const void *iaddr, bool is_v6)
 {
 	struct ipvl_dev *ipvlan;
 	bool ret = false;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 18b49f74dc35..d20fc473b4e1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1073,7 +1073,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 }
 
 /* the caller must held the addrs lock */
-int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
+int ipvlan_add_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6,
 		    const u8 *hwaddr)
 {
 	struct ipvl_addr *addr;
@@ -1107,7 +1107,7 @@ int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6,
 	return 0;
 }
 
-void ipvlan_del_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
+void ipvlan_del_addr(struct ipvl_dev *ipvlan, const void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
-- 
2.25.1


