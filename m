Return-Path: <netdev+bounces-260820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEsHAIG/nmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:23:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A0194DE6
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A843A3006504
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781E387351;
	Wed, 25 Feb 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="DoSJibHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF43859DC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011003; cv=none; b=fOcJFHyAzbcQXoUYZu4lC1RDdxu12+vMfNrqaxa9IeXUS92APpWnSkYHeEHeJoctJHnONVBEbYEZ0RlVh04/SCOdvRJzUV5zJb1zJEl673ehW4zJwgsZeQfcZKzSx/DqR/GtKXk9RPOZWupmCSTUaqJ8Jh61UoqUgY1FmosXpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011003; c=relaxed/simple;
	bh=ptKQ7QWcRgz5CwuOYOqzRGPycQ0CtGHVI9PF3GJruz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDD59WcbYx9XPPmafZLSddMncO6UBBmX8buN1XDncJq96bb4N9OkJn11HzPZDBfH4xF6Hj6bQ6ZvW+IqQdV2zSAVwZv85kr0N1eLvOkysX8dXzzWxQphfH9qGWUp7oVLgiJASyBzfo46Pya92OzODC8mE7Xwe/uTeAjd3tOEwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DoSJibHx; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33F18A3F83;
	Wed, 25 Feb 2026 10:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772010997; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1F3wQSgQUr+bRNh4foANZwEl+te/rijyMRWi5ttWK/s=;
	b=DoSJibHxLbE2QCN6QmJmNMkHcjfwf5WaPjgHhTuIe7mHlkNJNx9DVm27UMA/7gmUb6+hR7
	62EtL6BAV3yXqafZyug2DO4KLUPBnO+wBrpmctmxKbYwBrICwsAsVHNSLzh5PvJLsW9EGh
	/u1KojMjFDb3+QXxPZ9jtP4OY+SJv0hExiD9mvvBjKRniK44uzoJy+Scq/ZpoIeKBwNxZW
	qNFWCgZCsrHcpIOdN0XTAhU/WVMPzy9eOSxb5JCTlRuZrXJkSzRxPR1rXV6mz8wUCZX2gp
	+uk+djXHndo+K9TZz3ZOshO5AVv05j1JvR2GebGpepZV/OY8KOsULpjYbyh7GA==
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
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 2/5] net: cadence: macb: add EEE LPI statistics counters
Date: Wed, 25 Feb 2026 10:15:55 +0100
Message-Id: <20260225091558.51157-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225091558.51157-1-nb@tipi-net.de>
References: <20260225091558.51157-1-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-260820-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 6A5A0194DE6
X-Rspamd-Action: no action

Expose the GEM MAC's EEE Low Power Idle hardware counters through
ethtool -S:

- rx_lpi_transitions: number of RX LPI entry events
- rx_lpi_time: cumulative time spent in RX LPI
- tx_lpi_transitions: number of TX LPI entry events (TXLPIEN 0->1)
- tx_lpi_time: cumulative time in TX LPI

These are clear-on-read hardware registers at offsets 0x270-0x27c,
automatically collected by the existing gem_statistics read loop.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 729751d424c2..e3520e5aec67 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1050,6 +1050,10 @@ struct gem_stats {
 	u64	rx_ip_header_checksum_errors;
 	u64	rx_tcp_checksum_errors;
 	u64	rx_udp_checksum_errors;
+	u64	rx_lpi_transitions;
+	u64	rx_lpi_time;
+	u64	tx_lpi_transitions;
+	u64	tx_lpi_time;
 };
 
 /* Describes the name and offset of an individual statistic register, as
@@ -1149,6 +1153,10 @@ static const struct gem_statistic gem_statistics[] = {
 			    GEM_BIT(NDS_RXERR)),
 	GEM_STAT_TITLE_BITS(RXUDPCCNT, "rx_udp_checksum_errors",
 			    GEM_BIT(NDS_RXERR)),
+	GEM_STAT_TITLE(RXLPI, "rx_lpi_transitions"),
+	GEM_STAT_TITLE(RXLPITIME, "rx_lpi_time"),
+	GEM_STAT_TITLE(TXLPI, "tx_lpi_transitions"),
+	GEM_STAT_TITLE(TXLPITIME, "tx_lpi_time"),
 };
 
 #define GEM_STATS_LEN ARRAY_SIZE(gem_statistics)
-- 
2.51.0


