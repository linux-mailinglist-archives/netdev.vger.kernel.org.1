Return-Path: <netdev+bounces-263754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKSiHIsPqGk8ngAAu9opvQ
	(envelope-from <netdev+bounces-263754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F771FE98A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3F5B30367DF
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C0A3A874A;
	Wed,  4 Mar 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="l7XhXlJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAF3A5E85
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621702; cv=none; b=B8oxdaWwSRyPqfGrcLKl7FLIA9y1m3g/8a0GOULzEwb3w6h90eoh3Lzu9S3LW/VpM01ZGyfK0G3kAZYVOemeWDcxuP3B1IADz7iau2PMEiGcUg38iriOr57iUJP7BlOluCGm/Yg4e+7j6o7EiHZr349Pmr/fuGKbjS+RmWJwi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621702; c=relaxed/simple;
	bh=jle0//CPgaZZSpU7Sj81jHdi7KzC/zh1LRpp0CnlhxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVYlylMso1jzMOFCcOlc3gtjwLH099eWNVLFkuHV0rVFYzRdTpn+OnhsZpCDOp9vOcv/SsVHMFYLAwgZSn0JIwk9zAyExpEkTXTFmP+YToyBz/MTxpjLgBbMI/bDmblgoni9DlRA/OJddDMIUT3qN7yEOIzBcAkPbCGPJZcAnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=l7XhXlJH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99324A560C;
	Wed,  4 Mar 2026 11:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C+OSoJkkLylk67QnDQo/K1NBa87FYzkv0EdcOg13ar4=;
	b=l7XhXlJHLTmw+MzwBOjlUB8ppw59tSTetvSm3oE8oEqCfd7HO+I02UrRpPCFrPXKYzVxNc
	WnUXB7+Fr1pHzL6SMumqXlTTo+uLraMVOTAAauHa3eFUJ45si66Jns5LgUcljllXpUWlJl
	t/HmeIrYWvFSKd+W0o2zIXAeOTAymEH953Hl89ulE9wG6gbOzvVU1qxw7o3uoEcPbaC4zi
	kAwYof+BdgZxzqv0W3/SaXwbHYRutIP1gqBrs4vQwJmsMOY+gcQR57w1e2LQP+RtSo49hi
	yFhbo9w2vIjnnO2s8eJri86YGPTonfSQygB1v3lFtDeyxSXLWeU+Ivr76F6gmQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 3/5] net: cadence: macb: add ethtool EEE support
Date: Wed,  4 Mar 2026 11:54:30 +0100
Message-ID: <20260304105432.631186-4-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
References: <20260304105432.631186-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 58F771FE98A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263754-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tuxon.dev:email,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Action: no action

Implement get_eee and set_eee ethtool ops for GEM as simple passthroughs
to phylink_ethtool_get_eee() and phylink_ethtool_set_eee().

No MACB_CAPS_EEE guard is needed: phylink returns -EOPNOTSUPP from both
ops when mac_supports_eee is false, which is the case when
lpi_capabilities and lpi_interfaces are not populated. Those fields are
only set when MACB_CAPS_EEE is present (previous patch), so phylink
already handles the unsupported case correctly.

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4e776c67f408..f01366394cff 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4058,6 +4058,20 @@ static const struct ethtool_ops macb_ethtool_ops = {
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
@@ -4080,6 +4094,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
 	.nway_reset			= phy_ethtool_nway_reset,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.51.0


