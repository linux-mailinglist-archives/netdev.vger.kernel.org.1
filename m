Return-Path: <netdev+bounces-257868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOJQL5oUiWko2QQAu9opvQ
	(envelope-from <netdev+bounces-257868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:56:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A110A894
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 23:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D10A30073F8
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB1381716;
	Sun,  8 Feb 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="qw7fmFGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B0381710
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770591371; cv=none; b=K6UNftFn8A23/946OLnHyuTYW4zH7bNU5/7+aWnh0/tWiBBTvQ03vA/n7DfR3aWK8VTxpx3pM9OvxwQbKYphx3EqxSrjNWZbvAcAlTMCWsyDVF9rVs2LJrAG4urcIq74uPhh+UdkCueZps1DoV0MXK6Axq5MChtdH6GDMWA6ZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770591371; c=relaxed/simple;
	bh=gxDkdnVAO6y54w+N+kQlH2pPvGHccqes7EFBl713Y8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hafv1IoTKCUYFKZp51QtKZVils7CIopdU5R9wlZb0L8IFL9xeuWJJ0K1JYjwx+yR0PwO2uWGJjN7GPs6rqZrh1t+cSsmhdkWntGdxp1jtgf1FjJPXLgbKG0gvXeKBNM89fLrU82jBqLODA5fO76EGLTVoK49iyAD6ipj0itJLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=qw7fmFGI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c70c6b2bcaso408683485a.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 14:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770591370; x=1771196170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnjPU7xCzjMHF4Wlfjb1OOwJlHU37KjHOMIV04vFqVA=;
        b=qw7fmFGI/B35gvy2qV0wtnRgJ+5BJQSRFlNG9Lov2nkQ7ammP5Jm2PUBWsfmD1xYCH
         MXQptgt07fHFtiRGfiT6Ay5NNVqu/G5ih/ex1GfaoyrG/93PJaXs+MQrPZ0luIAYq8tV
         BCvY8e9Hf6mySiD/1rQf33sXHUodyqGPWIS9Hr8dzOgTnAipqUO+83kXP3eduPgyEw1A
         iNUDFadniKTd9GMhWWHnYBdNPfa7PzpEuaSZ+g1Kr/SkkbAZdwz8A8M7kP9MVk29gPBg
         +5xNSwKz6yjpV40UjvlADycOHy6lbAPvG9tXcAP17OFY6RkDrFBn3EkIZE5JaxK2qWQG
         qr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770591370; x=1771196170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnjPU7xCzjMHF4Wlfjb1OOwJlHU37KjHOMIV04vFqVA=;
        b=w2yweB9EbAs/plMbtWyPQlaA3Ivgn/t5jwW62QseDgWxoi7kWf7QwFTlIpSJmC6ezM
         xJsZbIMW8N0LXX8UISvVTwrLSbCMq7SAqhrf7636sayY+rb+M1lOh6iVgqmEIWNEMNw4
         1AjA94VbwH3LN85BhjCUEkiOI1sjTMXcH9LaOQfyWwRF2PUvwA7SDQhpjnHHN6zeTTSN
         1i9aLLz0dc16mVzT9SKLWtyLzayih1wEO9FFC11KL4BNhDCB3rv7h3bKoKAIS1mDJfpn
         HKja9JqneI433f3x7KDXXNlbB6x+yUjFSL5iwwB0I16arkcKdgEz98dnZzH5aNXh1yro
         qTXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLWT2i+E15neDkyBKPR02vQo7KHfVpa8yDEUyy/LxA59+HJ9uFvVylS8Lv/qlWZYvuBCM5V/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0agAQ89P4kQOfsTX6kcLg1um1NlKKmB9Rgx81rFHwPC7sSk+E
	GMUXUpgS7gY35ty4ocmlpcj2suwj5GDTBKV83a6h4Vm6kia3oeVQz4Un9x/bqImKSXU=
X-Gm-Gg: AZuq6aIHG9IEjO3JNzkg6hc+qyNbIgJHXvMoeyWy0Kug6W2NQrvpbH9cQqnNXB7SfXC
	p/vbsiRPrUXtdK78oAHZhT+xIXOb3RcishcgxfVIoUfs0aPK8QOsuhFPs1bRHHbbuyKCeBY3pqL
	1x+kDIeZSuN9gUd+vPPyOTb2egtDAVjC59dWs6fT7q164L7/zxDsUihA6KNvMpfblgcjf0ROTFG
	/d0UM1M9OoLGAAAU0lItI+foXUfwb6a/dxtKBHRHLBpj7YQYjRxAmBF2vcLpXOuE/Tke7XAxBZU
	BdJxPFvjYUqSxZMC7OiONT2JGafAHKGEOstvZGpytGJ1uG2GfXgXCUzVl288R5Kn+Dygs18ApQt
	fc3vlyF4pR3kIOzHBQCpCEcUISkhPNaq3tI+SRHf/l8Zr68wuZNbX4ZWTj9Nb7jX+wj2QqDnHi2
	poHvW9qC3cgb4HmocwWfu9fn3Itpl83z886FJvvnr4heNl8uIJwV248n61GlKsPSM9MPNsOkEwH
	J3AFBNZbVbpa//Xe9i7E5Z6Qo7KSrE=
X-Received: by 2002:a05:620a:4142:b0:8c7:fdc:e853 with SMTP id af79cd13be357-8caeee3411cmr1221080485a.1.1770591370334;
        Sun, 08 Feb 2026 14:56:10 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9efasm679622485a.43.2026.02.08.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 14:56:10 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v3 2/3] net: mscc: ocelot: split xmit into FDMA and register injection paths
Date: Sun,  8 Feb 2026 22:56:01 +0000
Message-Id: <20260208225602.1339325-3-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
References: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,northwestern.edu:email,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4C7A110A894
X-Rspamd-Action: no action

Split ocelot_port_xmit() into two separate functions:
- ocelot_port_xmit_fdma(): handles the FDMA injection path
- ocelot_port_xmit_inj(): handles the register-based injection path

The top-level ocelot_port_xmit() now dispatches to the appropriate
function based on the ocelot_fdma_enabled static key.

This is a pure refactor with no behavioral change. Separating the two
code paths makes each one simpler and prepares for adding proper locking
to the register injection path without affecting the FDMA path.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 39 ++++++++++++++++++++------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index ef4a6c768de9..d6b0936beca2 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -571,7 +571,25 @@ static bool ocelot_xmit_timestamp(struct ocelot *ocelot, int port,
 	return true;
 }
 
-static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ocelot_port_xmit_fdma(struct sk_buff *skb,
+					 struct net_device *dev)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int port = priv->port.index;
+	u32 rew_op = 0;
+
+	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
+		return NETDEV_TX_OK;
+
+	ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
+
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t ocelot_port_xmit_inj(struct sk_buff *skb,
+					struct net_device *dev)
 {
 	struct ocelot_port_private *priv = netdev_priv(dev);
 	struct ocelot_port *ocelot_port = &priv->port;
@@ -579,24 +597,27 @@ static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
 	int port = priv->port.index;
 	u32 rew_op = 0;
 
-	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
-	    !ocelot_can_inject(ocelot, 0))
+	if (!ocelot_can_inject(ocelot, 0))
 		return NETDEV_TX_BUSY;
 
 	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
 		return NETDEV_TX_OK;
 
-	if (static_branch_unlikely(&ocelot_fdma_enabled)) {
-		ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
-	} else {
-		ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
+	ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
 
-		consume_skb(skb);
-	}
+	consume_skb(skb);
 
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	if (static_branch_unlikely(&ocelot_fdma_enabled))
+		return ocelot_port_xmit_fdma(skb, dev);
+
+	return ocelot_port_xmit_inj(skb, dev);
+}
+
 enum ocelot_action_type {
 	OCELOT_MACT_LEARN,
 	OCELOT_MACT_FORGET,
-- 
2.34.1


