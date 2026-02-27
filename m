Return-Path: <netdev+bounces-261878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI/COWK0oWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:12:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0ED1B97FF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB7D30D6D33
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1812439001;
	Fri, 27 Feb 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="52PbBd3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1942EEC1;
	Fri, 27 Feb 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204930; cv=none; b=gKtzzmBxTCe8FaKGxKGDsLbTW0ACcqgI1ctkcvLG83aqiWLLt7eHviIUJSZjHYZ/Ya/gYMutHUyanaIKqNEnEqdhU90ItsStTAhA6MhyhBqqIHomP2utDkKk6t34PEFjz0U6nZ80ko0icJJ1Jp6fU+G/WQUT28VsSQbLMdFcEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204930; c=relaxed/simple;
	bh=QkwfhhWgXcsXTJC24lyZEtiFjpVR0EkyXcmT9TMSAI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+KeN4mSq+ovlU65uozP6GFnyuCRsHsuTOtBhvwZ395URzSV8wUM5rkMOULwAvTn6K4PJVSXtOQBkJSaxbf1QK37d1AlvJTAMSulU4Mg0/NCeHdu2Qa7EJimyFb15lYXoAY+w0jhM8qFqfq5mo6MXwov4IzZnJ3Wz+GDXNfAMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=52PbBd3N; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BA53A5005;
	Fri, 27 Feb 2026 16:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772204925; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lSCPFfeGozLmMJQnP50afD8kI4SZlBMY+0sjS3RHZFk=;
	b=52PbBd3NIZ0bvU3ci+T9Jsjr5VdLRkqGfFb8y2R6L6ZOCCdYzoJEuKohIoluTcnW0P1hcY
	8bNHbO/icYArOP9krOpRsmy1AGW2cTJx1Kzd26jNrvAOqn/CXNYjtzJkbKADbS8C1jYplP
	4QjsEFKjJQZ/l5z2bK00xTq2/9Nmpe7/37W4y1TdmODzEP1Gpgv6bqSmNqy8ADJMAjnNAE
	fQq5jEQcMqMFLqtXQ/Tu0JyY8BHvxBK+0yCzfMeihFvVqbFyrpU3Qx1+kFSG+AnjwYUzkm
	yBwv/YsyZ94HXk3PFwqeuvEOb3wT+BHHrZDsFsvu+naROOe8Ir6g/txuNhnQWQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	linux-kernel@vger.kernel.org,
	theo.lebrun@bootlin.com,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 3/5] net: cadence: macb: add ethtool EEE support
Date: Fri, 27 Feb 2026 16:06:08 +0100
Message-ID: <20260227150610.242215-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227150610.242215-1-nb@tipi-net.de>
References: <20260227150610.242215-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261878-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 4A0ED1B97FF
X-Rspamd-Action: no action

Implement get_eee and set_eee ethtool ops for GEM as simple passthroughs
to phylink_ethtool_get_eee() and phylink_ethtool_set_eee().

No MACB_CAPS_EEE guard is needed: phylink returns -EOPNOTSUPP from both
ops when mac_supports_eee is false, which is the case when
lpi_capabilities and lpi_interfaces are not populated. Those fields are
only set when MACB_CAPS_EEE is present (previous patch), so phylink
already handles the unsupported case correctly.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c23485f049d3..3e724417d444 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4050,6 +4050,20 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_ringparam		= macb_set_ringparam,
 };
 
+static int macb_get_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	return phylink_ethtool_get_eee(bp->phylink, eee);
+}
+
+static int macb_set_eee(struct net_device *dev, struct ethtool_keee *eee)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	return phylink_ethtool_set_eee(bp->phylink, eee);
+}
+
 static const struct ethtool_ops gem_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4072,6 +4086,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
 	.nway_reset			= phy_ethtool_nway_reset,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.51.0


