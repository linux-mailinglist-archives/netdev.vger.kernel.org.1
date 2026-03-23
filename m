Return-Path: <netdev+bounces-270450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HN1GpUQwWk7QQQAu9opvQ
	(envelope-from <netdev+bounces-270450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:06:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBB2EFA68
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B03303A852
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74344389453;
	Mon, 23 Mar 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z+HgCY/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B1389444
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259933; cv=none; b=jqEZ/sfNXtoDQa8jNKCKjJKLNI4UMafi4tkr//95qflFlJitwQkMSInd9Q5Z+vSnKSKkb07GEVobaJDnIRW/bcFOLJwEqfkE/+qr5vlOy4lrBSjDcaL2q3LIgIEH35pwqQ+iqp7M96rqe5Iao/RMmY00IxbhSX+/5QW104jUiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259933; c=relaxed/simple;
	bh=RcBDe4X39L27LMdLK/1RQp2syIDdU/IaLMDzcDTolYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBgnwmghiKNBaaEJ1URC4bVzq90xRcPCuFkEdPYUKGNi57gl7/s4+mBe2KXKoZAhO7780SqpxmqBkzrAeDs3/po91XzVUUyysixWkTQD4RT6NZdjhZIW3JD0WLNjdW3B0Ns87NhZ99LPDSzd+2gzidJN9F8WopNDvZzAVHagDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z+HgCY/j; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 773C24E427AE;
	Mon, 23 Mar 2026 09:58:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4025B5FEF6;
	Mon, 23 Mar 2026 09:58:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 745FC10371CDA;
	Mon, 23 Mar 2026 10:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774259923; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=f/kj83r9LqHm3ID7NwjHYV+005UAiBkSix1F0FNgnYo=;
	b=Z+HgCY/j34FRb1XRTwj1vJCXh51sK9VLmENXEfga0Svv31n8vkAO2x4BZQWTd8nF11rs03
	WvniIHfbMgzZS3LGyKSl8Tw0B0AR2wxhtYQaa7XMG5pAjrz7rn2/PAHdDl+VLdJ0R2RhBt
	V65ww5oDqB1hydxWThzlcPLcESDzPCMfA4ewlffqD8aZ6GYWKxp4VNo1OMuf2FXXm/Vdzc
	H6DdOpLb8XfKN9AideccF5on4FkC87+tklJr9SsPUiimMxseLDq730ZabVgazYRk4zkftv
	LjdH3y/4O/vpCS0QYjmfG4j7C3zOOd344T8bQYTNp2h/jp9ox5WEoTkPBemtkA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethtool: pass genl_info to the ethnl parse_request operation
Date: Mon, 23 Mar 2026 10:58:32 +0100
Message-ID: <20260323095833.136266-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270450-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: BEFBB2EFA68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The .parse_request() ethnl operation extracts the relevant attributes
from the netlink request to populate the private req_info.

By passing genl_info as a parameter to this callback, we can use
the GENL_REQ_ATTR_CHECK() macro to check for missing mandatory
parameters.

This macro has the advantage of returning a better error explanation
through the netlink_ext_ack struct.

Convert the eeprom ethnl code to this macro, as it's the only command
yet that has mandatory request parameters.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/eeprom.c  | 12 +++++++-----
 net/ethtool/netlink.c |  3 ++-
 net/ethtool/netlink.h |  1 +
 net/ethtool/pause.c   |  1 +
 net/ethtool/rss.c     |  4 +++-
 net/ethtool/stats.c   |  1 +
 net/ethtool/strset.c  |  1 +
 net/ethtool/tsinfo.c  |  4 +++-
 8 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index caf1e41e676b..a557e3996c85 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -150,15 +150,17 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	return ret;
 }
 
-static int eeprom_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
+static int eeprom_parse_request(struct ethnl_req_info *req_info,
+				const struct genl_info *info,
+				struct nlattr **tb,
 				struct netlink_ext_ack *extack)
 {
 	struct eeprom_req_info *request = MODULE_EEPROM_REQINFO(req_info);
 
-	if (!tb[ETHTOOL_A_MODULE_EEPROM_OFFSET] ||
-	    !tb[ETHTOOL_A_MODULE_EEPROM_LENGTH] ||
-	    !tb[ETHTOOL_A_MODULE_EEPROM_PAGE] ||
-	    !tb[ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS])
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_EEPROM_OFFSET) ||
+	    GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_EEPROM_LENGTH) ||
+	    GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_EEPROM_PAGE) ||
+	    GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS))
 		return -EINVAL;
 
 	request->i2c_address = nla_get_u8(tb[ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS]);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 14cb06ec5171..5046023a30b1 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -462,7 +462,8 @@ static int ethnl_default_parse(struct ethnl_req_info *req_info,
 		return ret;
 
 	if (request_ops->parse_request) {
-		ret = request_ops->parse_request(req_info, tb, info->extack);
+		ret = request_ops->parse_request(req_info, info, tb,
+						 info->extack);
 		if (ret < 0)
 			goto err_dev;
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..aaf6f2468768 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -396,6 +396,7 @@ struct ethnl_request_ops {
 	u8			set_ntf_cmd;
 
 	int (*parse_request)(struct ethnl_req_info *req_info,
+			     const struct genl_info *info,
 			     struct nlattr **tb,
 			     struct netlink_ext_ack *extack);
 	int (*prepare_data)(const struct ethnl_req_info *req_info,
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 29f812e935b6..ccaec8e878b2 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -28,6 +28,7 @@ const struct nla_policy ethnl_pause_get_policy[] = {
 };
 
 static int pause_parse_request(struct ethnl_req_info *req_base,
+			       const struct genl_info *info,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 0f4e5cd2ac71..b6c9b89ff6fb 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -66,7 +66,9 @@ const struct nla_policy ethnl_rss_get_policy[] = {
 };
 
 static int
-rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
+rss_parse_request(struct ethnl_req_info *req_info,
+		  const struct genl_info *info,
+		  struct nlattr **tb,
 		  struct netlink_ext_ack *extack)
 {
 	struct rss_req_info *request = RSS_REQINFO(req_info);
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 38136f19b2ec..9b0d8cb07675 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -99,6 +99,7 @@ const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1] = {
 };
 
 static int stats_parse_request(struct ethnl_req_info *req_base,
+			       const struct genl_info *info,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index aa1e50c98f34..9271aba8255e 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -190,6 +190,7 @@ static const struct nla_policy strset_stringsets_policy[] = {
 };
 
 static int strset_parse_request(struct ethnl_req_info *req_base,
+				const struct genl_info *info,
 				struct nlattr **tb,
 				struct netlink_ext_ack *extack)
 {
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 9aad62695dfb..a865f0fdd26b 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -70,7 +70,9 @@ int ts_parse_hwtst_provider(const struct nlattr *nest,
 }
 
 static int
-tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
+tsinfo_parse_request(struct ethnl_req_info *req_base,
+		     const struct genl_info *info,
+		     struct nlattr **tb,
 		     struct netlink_ext_ack *extack)
 {
 	struct tsinfo_req_info *req = TSINFO_REQINFO(req_base);
-- 
2.49.0


