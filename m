Return-Path: <netdev+bounces-261253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO4IO6sNoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:08:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B91A327F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE263079C70
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959D396B8E;
	Thu, 26 Feb 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qo2Sd8xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11938E5F2
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096797; cv=none; b=bhiGm6RyMYK0a4CDYJDIVEELOmvVoo3jsQdBJOZjkrCBwUrfb5lPS9m4xJRCpB9LFvrZuQpuIhl5e22VjPGQu70TDuIn4bsold3j1NPrGopS4CIyGI1UReER9UldZsJN6w40wq/yR58rKMUbNP8j7bHMrXWtL1tOzg58WL9YhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096797; c=relaxed/simple;
	bh=f2kfGH116KzX79wZr+txjpVvF2HZyCV+Oj53yvAZHxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRFhvgDESt+GCj2U6y2FPdJZTBb4AGeBwyWNiSCFo8yxx0CunmArDynZvvD570L93Fv06ntpz+9t8/WTwr9MQ72fVl1UBITL7hXbFpxKmW5QN63qpIL9SELNxqWPBRLsUq6xxCpONYI6p5nU8rfKRIIgYdxh0tGiICwdzTpbUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qo2Sd8xj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C14FDA47AC;
	Thu, 26 Feb 2026 10:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772096793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MI/AUX7s9MIyRYPCeAlGjNBvlJqOiHqYeew4KPUYIWE=;
	b=qo2Sd8xjFR9pnm97B6Z++hVWkwer77961Mu0X+9j553i6nBDu1JsevvhxJCRZjpfoP4Y/B
	1IIS7olV3RRHQ1xvHvCT5Bs790IydMonmSJ/v3kFuALP2Sr84BEZMyy2PW1/YNsvEJT4V4
	68zjnzkFdKjXDaJTgJxFTyNC6CAozvkR+obKAZV2I/bGScVLx9WH6fLw46YoQ60UpUCagU
	D1dE0oofhIKllK4i/3eu7ZIaqB11MGOXyTtwl6l2KIAOo81sy79PDoPQDeZ810Cni8SaTu
	aWq/i7+Kj9LMG969BZQWyLCMTMfffd9aWS+6rJ9kpMDK3pEWvUAnbpoyVPmC9Q==
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
	theo.lebrun@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v4 1/4] net: cadence: macb: add EEE LPI statistics counters
Date: Thu, 26 Feb 2026 10:06:05 +0100
Message-Id: <20260226090608.54802-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260226090608.54802-1-nb@tipi-net.de>
References: <20260226090608.54802-1-nb@tipi-net.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261253-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 5C8B91A327F
X-Rspamd-Action: no action

The GEM MAC provides four read-only, clear-on-read LPI statistics
registers at offsets 0x270-0x27c:

  GEM_RXLPI     (0x270): RX LPI transition count (16-bit)
  GEM_RXLPITIME (0x274): cumulative RX LPI time (24-bit)
  GEM_TXLPI     (0x278): TX LPI transition count (16-bit)
  GEM_TXLPITIME (0x27c): cumulative TX LPI time (24-bit)

Add register offset definitions, extend struct gem_stats with
corresponding u64 software accumulators, and register the four
counters in gem_statistics[] so they appear in ethtool -S output.
Because the hardware counters clear on read, the existing
macb_update_stats() path accumulates them into the u64 fields on
every stats poll, preventing loss between userspace reads.

These registers are present on SAMA5D2, SAME70, PIC32CZ, and RP1
variants of the Cadence GEM IP and have been confirmed on RP1 via
devmem reads.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..19aa98d01c8c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -170,6 +170,10 @@
 #define GEM_PCSANNPTX		0x021c /* PCS AN Next Page TX */
 #define GEM_PCSANNPLP		0x0220 /* PCS AN Next Page LP */
 #define GEM_PCSANEXTSTS		0x023c /* PCS AN Extended Status */
+#define GEM_RXLPI		0x0270 /* RX LPI Transitions */
+#define GEM_RXLPITIME		0x0274 /* RX LPI Time */
+#define GEM_TXLPI		0x0278 /* TX LPI Transitions */
+#define GEM_TXLPITIME		0x027c /* TX LPI Time */
 #define GEM_DCFG1		0x0280 /* Design Config 1 */
 #define GEM_DCFG2		0x0284 /* Design Config 2 */
 #define GEM_DCFG3		0x0288 /* Design Config 3 */
@@ -1043,6 +1047,10 @@ struct gem_stats {
 	u64	rx_ip_header_checksum_errors;
 	u64	rx_tcp_checksum_errors;
 	u64	rx_udp_checksum_errors;
+	u64	rx_lpi_transitions;
+	u64	rx_lpi_time;
+	u64	tx_lpi_transitions;
+	u64	tx_lpi_time;
 };
 
 /* Describes the name and offset of an individual statistic register, as
@@ -1142,6 +1150,10 @@ static const struct gem_statistic gem_statistics[] = {
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


