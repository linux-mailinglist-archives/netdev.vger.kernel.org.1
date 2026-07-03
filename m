Return-Path: <netdev+bounces-304401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PSc9BFxmR2ruXgAAu9opvQ
	(envelope-from <netdev+bounces-304401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EC36FF9BC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=hDKMB1Tr;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304401-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304401-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C781830A1EDE
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5436A027;
	Fri,  3 Jul 2026 07:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB05369D60;
	Fri,  3 Jul 2026 07:30:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063857; cv=none; b=HIz8BlXi2OLyUGa92kP2l3xYd8hNc9YG3PmGmg7xDdBLxsZdJOcnfn5ac91aK8bdsMbAbtlFar8CS9MLa5Znt3bGBnAXldcptdFNK06sHwbp1UfwrQj2NiV381rNsNbbuDeVbyrPe9UNopv/kuCJVz9cV5Tz9AoQ2ofhWxmORDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063857; c=relaxed/simple;
	bh=ovyurjG5Af4dSGQqwANd/N2HAEQP8hL2zwreWbrkuCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lonDLgvjOT1wVvReZA+Pfv9mOp1qePNQOiqqGr7Hb5Q30tsIHq3HCvJPsg5lHsVQb39oEsrFp1F7i2xUWx7u5xsYACiigqBv9VNI3sZ1V4yG13JOhWethxGkq7aCqZfDJnLDNfYdTv9LCjFadxNtitj0L/0X8i9nKzZKPDyCChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=hDKMB1Tr; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 31F8460C04;
	Fri,  3 Jul 2026 03:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063848; bh=V1YGnPdzqVCc+/hn5n6vQES3Xulkk+/WuQATHNv8S6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hDKMB1TrvcIhDj9XXqAGAuql/+mCBiEqYdtYP8s8AJTO+s3k64GgQSC1bSMNeYDf5
	 N5g0WnAFha1k41b/7eL0rlv9MDo1CVQPh6Pn8SaX+LT4coroNn2XGifg/7jx8aMHT7
	 k8BLEmpiNH1Bc0TID0wexuN58TjllrDEmRyoBWsKggM2dSaFAQsbvooqDf/pAry5qd
	 vgoFdL0Rz1kbGEQdMkooWTMStzQoemxpFvawMKhRBtJSBEV1uQIEY2I72uWKSMrVe2
	 J2xNy51x+L/7U/sAKsBa9Ao6aYyPZJISQ5AWXqN0DPgcO1EqUq1vtFfOUDmgOI0rFh
	 FWrvuXduVhiBA==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:22 +1000
Subject: [PATCH net-next 03/12] net: dsa: qca8k: dsa_inband_request: More
 normal return values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-3-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
In-Reply-To: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=3441;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=4hJW/v9iy+jFTxTyrW/XW4pVWuQX19j05FKV+U29JRM=;
 b=HnIwMHiq1nrVk/590BSixkGddDRhNp3R9sJSfOWzffX6iZ1DQPWj7npGTgDRBrdnY6Zo1uiMo
 qu5YmQ3A0PJBMA7RVqo252s/Ujo3r6Wm85KQAdEU4wka6Fb06pX18iI
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304401-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:horms@kernel.org,m:f.fainelli@gmail.com,m:tobias@waldekranz.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch,waldekranz.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:from_mime,padl.com:dkim,padl.com:mid,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89EC36FF9BC

From: Andrew Lunn <andrew@lunn.ch>

wait_for_completion_timeout() has unusual return values. If it times
out, it returns 0, and on success it returns the number of remaining
jiffies for the timeout.

For the use case here, the remaining time is not needed. All that is
really interesting is, it succeeded and returns 0, or a timeout.
Massage the return value to fit this, and modify the callers to the
more usual pattern of ret < 0 is an error.

Sending the clear message is expected to fail, so don't check the
return value, and add a comment about this.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2
Remove check on the clear message.
wait_for_completion_timeout() does not return negative values
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 24 +++++++++++-------------
 net/dsa/dsa.c                    |  6 +++++-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4da6094552f1e..b0cbe72c15b4c 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -348,8 +348,8 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 
-	if (ret <= 0)
-		return -ETIMEDOUT;
+	if (ret)
+		return ret;
 
 	if (!ack)
 		return -EINVAL;
@@ -392,8 +392,8 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 
-	if (ret <= 0)
-		return -ETIMEDOUT;
+	if (ret)
+		return ret;
 
 	if (!ack)
 		return -EINVAL;
@@ -596,8 +596,8 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 
 	ack = mgmt_eth_data->ack;
 
-	if (ret <= 0)
-		return -ETIMEDOUT;
+	if (ret)
+		return ret;
 
 	if (!ack)
 		return -EINVAL;
@@ -694,8 +694,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 	ack = mgmt_eth_data->ack;
 
-	if (ret <= 0) {
-		ret = -ETIMEDOUT;
+	if (ret) {
 		kfree_skb(read_skb);
 		goto exit;
 	}
@@ -727,10 +726,8 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 
 		ack = mgmt_eth_data->ack;
 
-		if (ret <= 0) {
-			ret = -ETIMEDOUT;
+		if (ret)
 			goto exit;
-		}
 
 		if (!ack) {
 			ret = -EINVAL;
@@ -747,8 +744,9 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	qca8k_mdio_header_fill_seq_num(clear_skb, mgmt_eth_data->seq);
 	mgmt_eth_data->ack = false;
 
-	dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
-				       QCA8K_ETHERNET_TIMEOUT);
+	/* This is expected to fail sometimes, so don't check return value. */
+	dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
+			   QCA8K_ETHERNET_TIMEOUT);
 
 	mutex_unlock(&mgmt_eth_data->mutex);
 	mutex_unlock(&priv->bus->mdio_lock);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 534e391fac7b5..f6ae11b06b4ab 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1878,12 +1878,16 @@ int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
 		       int timeout_ms)
 {
 	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
+	int ret;
 
 	reinit_completion(&inband->completion);
 
 	dev_queue_xmit(skb);
 
-	return wait_for_completion_timeout(&inband->completion, jiffies);
+	ret = wait_for_completion_timeout(&inband->completion, jiffies);
+	if (ret == 0)
+		return -ETIMEDOUT;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dsa_inband_request);
 

-- 
2.43.0


