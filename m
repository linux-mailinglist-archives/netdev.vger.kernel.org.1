Return-Path: <netdev+bounces-259947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Hh+LBUZnGmq/gMAu9opvQ
	(envelope-from <netdev+bounces-259947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E64173871
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE51304CEAA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F813D891;
	Mon, 23 Feb 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="k8cXSE/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40F34DB71
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837526; cv=none; b=CtpmY9ZEyCC036C6or/FSP2lGHGz8SdSTEVtYOsh6l+RDyYuPX4ut+mJ9019veE9QkNm/+xR+21USvvEinIjbHiEPk2Gx5GpfeK1lgl9Wai1iURWZwAtW9wws2LHXto49lxsErCqHIsqn/E4xZjouYkNU8d3r8qJ2fpTI/jubRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837526; c=relaxed/simple;
	bh=Y//Gbk83hYHfBqWIyS6c9XDG2URXVE0h2xFjnmf77fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4zUglvghPEcmOhu2VgNs8WZ6EWyxBfbd4vr3RheuPYgDm1csit3XERhAlPLTtzTxJUpLKxqW9w8jqeZmzDmAKCqUG1NVDDI28wWMj7UuVSUEw6bk/BubJpR1OGLJPNfIlfKH+30gjJtXaGv/rTi4aZFEleENl8cjShoAqX92hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=k8cXSE/D; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1DD61A3EE1;
	Mon, 23 Feb 2026 10:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1771837523; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kLJWQKtj2sfcfAyIvb3ydfYVfh9PdakFauuufm3BoCE=;
	b=k8cXSE/Ddp01k1HWD4CRrQIZuIs3UkGlziC+uwaeEZSC8ZhCVPgEbyZ0g2GgHtd+LgNuif
	QgxRyJptv49i3+ORyeWOyZ8tnsUe24iGfxauTdBByvx/MhMfbADL/3IG152vDQBPLDiROw
	JhaLhv+mDP7VDWWVkomoD3oL2BGdQhNursPGfrLbdUXG2/P8SaD/NsUC0Diz7es06g3iR8
	VZpwnI7qEwo94moO1VQE6mluTEaZnKxa+YFYzDWxIHMCr5ejt6CMHo3jVc4zZvNNwPl+w6
	JFZzr8ir+56k1VdCIcqsNck9+lWUHHhs2wYaD5u642oJv8qsWidoDESHVQaUGg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 4/5] net: cadence: macb: add ethtool EEE support
Date: Mon, 23 Feb 2026 10:04:11 +0100
Message-Id: <20260223090412.44070-5-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260223090412.44070-1-nb@tipi-net.de>
References: <20260223090412.44070-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-259947-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16E64173871
X-Rspamd-Action: no action

Implement ethtool get_eee and set_eee operations for the Cadence GEM
MAC, delegating to phylink for PHY-level EEE negotiation state.

The MAC-level LPI control (TXLPIEN) is not manipulated directly in the
ethtool ops. Instead, phylink_ethtool_set_eee() updates the PHY's EEE
advertisement, which triggers link renegotiation. The mac_link_up
callback then checks the negotiated EEE state and enables LPI
accordingly.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d4a81f3a7b9a..178c0ddc78cd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3634,6 +3634,41 @@ static int macb_set_ringparam(struct net_device *netdev,
 	return 0;
 }
 
+static int macb_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
+{
+	struct macb *bp = netdev_priv(ndev);
+	int ret;
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	ret = phylink_ethtool_get_eee(bp->phylink, edata);
+	if (ret)
+		return ret;
+
+	edata->tx_lpi_timer = bp->tx_lpi_timer_ms * 1000;
+
+	return 0;
+}
+
+static int macb_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
+{
+	struct macb *bp = netdev_priv(ndev);
+
+	if (!(bp->caps & MACB_CAPS_EEE))
+		return -EOPNOTSUPP;
+
+	if (edata->tx_lpi_timer)
+		bp->tx_lpi_timer_ms = edata->tx_lpi_timer / 1000;
+
+	/* Don't directly control TXLPIEN here. phylink_ethtool_set_eee()
+	 * updates the PHY, which will bounce the link if tx_lpi_enabled
+	 * changes. That triggers mac_link_down/mac_link_up where we
+	 * enable/disable TXLPIEN based on the negotiated state.
+	 */
+	return phylink_ethtool_set_eee(bp->phylink, edata);
+}
+
 #ifdef CONFIG_MACB_USE_HWSTAMP
 static unsigned int gem_get_tsu_rate(struct macb *bp)
 {
@@ -4058,6 +4093,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_rxnfc			= gem_get_rxnfc,
 	.set_rxnfc			= gem_set_rxnfc,
 	.get_rx_ring_count		= gem_get_rx_ring_count,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 };
 
 static int macb_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.39.5


