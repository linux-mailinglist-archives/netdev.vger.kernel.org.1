Return-Path: <netdev+bounces-177054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5EA6D874
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEEC16BA5B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82B25EF82;
	Mon, 24 Mar 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ESoY48MP"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9425E469;
	Mon, 24 Mar 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812829; cv=none; b=j8ac1lO00EW++h+NcKL7qVFsYZkIU+QZcFn9GrADTAYtIFVpOuY9dlfyEvbyqZZTqG79/cLmxxOE4nnlbCdzjbCCUZXd+h5m1GeJE4X6EIwg2uvqVsh1eA4UQP0Nsp1jxGcDHCybU7nrNfAPZc3W5FQ3x11Usga3Uh8/IQgFOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812829; c=relaxed/simple;
	bh=EAiaSXYsn+2Apzo3q9IU5YhHBxY3tP3PX3LaGiX/d5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOBsPFpRvJu5ALVxySwhHrPjiSEwuR3WsAYZ4QAMGgRItKkI1nE7nStHBzzSyEZM9TnLp592Ftz0uYHuCqbqUO/SPfyW3JbBPGqPNlrHHZpZ9bBpAbKZIEks8Q2jOxQflkIwCGmb+upgpIyFqMGiElr7Jvu+HtwTK9Bx9L2QC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ESoY48MP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C128432F7;
	Mon, 24 Mar 2025 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyN/yr+VxFDRia4MxGLEfv2GDAM0+bfrn4ubPet1vcI=;
	b=ESoY48MPAwHmfg5RIBadmjiqRaM3b0n7moTN23eMagl01jlLpw7kOfiDn1GPqnta8Ignuu
	LbUWMrgMa7xySAY8LRVhL0bUNL356jrxlYkK5jGg1LPyQ8XqXwLAT2m4MzkbVjcj6H1X1s
	Lxd9CxVLJ6XgFIO/6sxvTcHjjg7gF7V7zOv7RB3d5PEpSwrnz5TrBkq6HR4gQrGfivhZRp
	akTSCUkg5Cr4nLuTR/vSoR1m3Aivv55Un9Y+4rN4Xu2ix9TAt/KJJctLmjF9MKI5QxZfU9
	M3pN3LsuVrzbc83L2RX0FMv8E1G+quj8Ui1Wv7zIY8yVBInB6kRk37SUsq0J4A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow per-netdevice DUMP operations
Date: Mon, 24 Mar 2025 11:40:04 +0100
Message-ID: <20250324104012.367366-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvu
 ghumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

We have a number of netlink commands in the ethnl family that may have
multiple objects to dump even for a single net_device, including :

 - PLCA, PSE-PD, phy: one message per PHY device
 - tsinfo: one message per timestamp source (netdev + phys)
 - rss: One per RSS context

To get this behaviour, these netlink commands need to roll a custom
->dumpit().

To prepare making per-netdev DUMP more generic in ethnl, introduce a
member in the ethnl ops to indicate if a given command may allow
pernetdev DUMPs (also referred to as filtered DUMPs).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: - Don't hold RCU in the filtered path
    - Move dump_all into a new separate helper

 net/ethtool/netlink.c | 37 ++++++++++++++++++++++++++++++-------
 net/ethtool/netlink.h |  2 ++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6b1725795435..31ab89ca0bcc 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -577,9 +577,7 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 	return ret;
 }
 
-/* Default ->dumpit() handler for GET requests. */
-static int ethnl_default_dumpit(struct sk_buff *skb,
-				struct netlink_callback *cb)
+static int ethnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
@@ -609,6 +607,31 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/* Default ->dumpit() handler for GET requests. */
+static int ethnl_default_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
+	int ret;
+
+	if (ctx->req_info->dev) {
+		/* Filtered DUMP request targeted to a single netdev. We already
+		 * hold a ref to the netdev from ->start()
+		 */
+		ret = ethnl_default_dump_one(skb, ctx->req_info->dev, ctx,
+					     genl_info_dump(cb));
+		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
+
+		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
+			ret = skb->len;
+
+	} else {
+		ret = ethnl_dump_all(skb, cb);
+	}
+
+	return ret;
+}
+
 /* generic ->start() handler for GET requests */
 static int ethnl_default_start(struct netlink_callback *cb)
 {
@@ -636,10 +659,10 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	}
 
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
-	if (req_info->dev) {
-		/* We ignore device specification in dump requests but as the
-		 * same parser as for non-dump (doit) requests is used, it
-		 * would take reference to the device if it finds one
+	if (req_info->dev && !ops->allow_pernetdev_dump) {
+		/* We ignore device specification in unfiltered dump requests
+		 * but as the same parser as for non-dump (doit) requests is
+		 * used, it would take reference to the device if it finds one
 		 */
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ec6ab5443a6f..4aaa73282d6a 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -331,6 +331,7 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  * @req_info_size:    size of request info
  * @reply_data_size:  size of reply data
  * @allow_nodev_do:   allow non-dump request with no device identification
+ * @allow_pernetdev_dump: allow filtering dump requests with ifname/ifindex
  * @set_ntf_cmd:      notification to generate on changes (SET)
  * @parse_request:
  *	Parse request except common header (struct ethnl_req_info). Common
@@ -388,6 +389,7 @@ struct ethnl_request_ops {
 	unsigned int		req_info_size;
 	unsigned int		reply_data_size;
 	bool			allow_nodev_do;
+	bool			allow_pernetdev_dump;
 	u8			set_ntf_cmd;
 
 	int (*parse_request)(struct ethnl_req_info *req_info,
-- 
2.48.1


