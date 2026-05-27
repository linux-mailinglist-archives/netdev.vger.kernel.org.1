Return-Path: <netdev+bounces-292159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JVjI+qkFmoOoAcAu9opvQ
	(envelope-from <netdev+bounces-292159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E565E0C77
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0095D30A0E97
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA433CF67F;
	Wed, 27 May 2026 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Rk3fEEus"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED083CB91C;
	Wed, 27 May 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868587; cv=none; b=Hs2ZOj3zHvIWX20duvSqzjV959hu1e3zPbdwLTguyFKOTJpSDe41uYP80C+USgGfxoP33KEtYZc0MH1hXDb8CyyURZAGYGBfKXoH6GbiLos/1rdKYy05ViV5GsHEkkAXuTkWVyRYHPxeGnZF4X4hkHtM7vt5JZnYxOOjBpZKErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868587; c=relaxed/simple;
	bh=j8Y/RHvFugFKr7+C6SQCV5DA0JRMAfdlJd+q7tLC7jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHxlsuIYIykb5b9u6PwNXboViVTrzgyYhwvl/3nSGRmreI4gbGjw0fKdENULDi1iTbk1Nc7kfXPfY8QIv+LgGq3vHAy2Ei5gj0Jxoi49qMmCqzmV9aW1fPcXPHLJHLhRu6OcG9oV8sTYweMOOMDWRLzEUwlN4DVAc7r7AA07mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Rk3fEEus; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=maIzxNHhoQiIGIaEBTdcS4NTamHWr9I26NeUj1/t7a4=;
	b=Rk3fEEus9NKKn/EKykpUsHSTkkWEEzounLIEdRc4M2fnZk/dHWpN0GGsC0e0ZnRjdrrFxYhpP
	zlkyg4tCSjXmNvIQ2hB9cYzLJ4nrwzaaDaPYjXkZwNzmEESRAbSTQmImEoS9g9mvT7zZnKVsKZy
	+CXwrl30cWCvrJgsOaBfeCc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gQMDw71LKzLlT6;
	Wed, 27 May 2026 15:48:32 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 384214056C;
	Wed, 27 May 2026 15:56:18 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 15:56:17 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
	<mohsin.bashr@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v06 5/6] hinic3: Configure netdev->watchdog_timeo to set nic tx timeout
Date: Wed, 27 May 2026 15:56:00 +0800
Message-ID: <eab3e549ae9863ff6fb80861c5ef1dfc1ad3a9b0.1779867397.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1779867397.git.zhuyikai1@h-partners.com>
References: <cover.1779867397.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-292159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,h-partners.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,huawei.com:dkim,h-partners.com:mid,h-partners.com:email]
X-Rspamd-Queue-Id: D8E565E0C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Configure netdev watchdog timeout to improve transmission reliability.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 8cf605a0a5d2..b872fbd6e23a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -33,6 +33,8 @@
 #define HINIC3_RX_PENDING_LIMIT_LOW   2
 #define HINIC3_RX_PENDING_LIMIT_HIGH  8
 
+#define HINIC3_WATCHDOG_TIMEOUT       5
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -244,6 +246,8 @@ static void hinic3_assign_netdev_ops(struct net_device *netdev)
 {
 	hinic3_set_netdev_ops(netdev);
 	hinic3_set_ethtool_ops(netdev);
+
+	netdev->watchdog_timeo = HINIC3_WATCHDOG_TIMEOUT * HZ;
 }
 
 static void netdev_feature_init(struct net_device *netdev)
-- 
2.43.0


