Return-Path: <netdev+bounces-263350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKtFLwMjp2ldewAAu9opvQ
	(envelope-from <netdev+bounces-263350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E71F4EF9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A413077CD3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65B382299;
	Tue,  3 Mar 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pmvoDyjZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD0350D46;
	Tue,  3 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561087; cv=none; b=DaRRVLRjcBAYqpkUq5CRXW0RJQC6N7bxkKU3s3UuHkgSc/PqEXtIkHrqobwBIBqufFJYSYYBwpFUd3AobJQnXrglS3SOhBCeR7HeDsaopqe4q2zhHJXxUSRSOpYmnlrikqhJloLbTFJoowq1JPyH76ov9e6Y2Wxojryl/qe5G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561087; c=relaxed/simple;
	bh=GTKkgOixrxzmHD3zUijlM5vksm6oyDRMA71BnCEXes0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTInptnDKtNnOh6XvDMZ/xkoq7XeMSJQJ5sLUqektq7J6VgX9X8rqPi/9ldQIwvDbSMG8Yk2BibRsYcaqYD6qST0gXwVlTEMOBSpTKH2oi/Zd3vOalFRBFKAQxDGVZRvk15QZUu6vd+fHKpIePOLJPc825tTvJzEAYmNQouFznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pmvoDyjZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772561086; x=1804097086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTKkgOixrxzmHD3zUijlM5vksm6oyDRMA71BnCEXes0=;
  b=pmvoDyjZHd29uYp1y3LLMREylu+SgKgEhzOGgheDqVHDv9qf4Pv+fPDQ
   VCsxXrx1ai0BW3ImlwMQ8bEEqp9hKmLN+RG14gU5HJwAn19VS4C87er8D
   NP8WDM1sYhH3BVkeO+YDHRtw1Hl9y3CaLZ1aP9jcHMNJdOIv6q3iVZay/
   CyY9GyoRwE40+vSFAq1m355lZhCWiUa47d1D2hhDfhRRdFNKsAZrgOxBB
   xCNXdXr55AoiDPHhG4CpDcs20GwBLq5bMj16EfgUgXNnVXlqil8+b2ZMm
   ljayttnCeTUVfxNiLLgFEPaS6K7B6N8vXEVzQG9528TC462PU1J4PSHzJ
   g==;
X-CSE-ConnectionGUID: GMMSakTvRG+HtI9KzbPdDQ==
X-CSE-MsgGUID: 5wdVKI+wQIGsdOoHkk7eZA==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221432061"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 11:04:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 11:04:22 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Mar 2026 11:04:21 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/4] net: macb: add safeguards for jumbo frame larger than 10240
Date: Tue, 3 Mar 2026 10:03:17 -0800
Message-ID: <20260303180318.1814791-4-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260303180318.1814791-1-charles.perry@microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 3B2E71F4EF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263350-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

The RX buffers for GEM can have a maximum size of 16320 bytes
(0xff in the RXBS field of the DMACFG register means 255*64 =
16320 bytes).

The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
can take a value of up to 16383 (0x3FFF). This field is not used
when determining the max MTU, instead an hardcoded value
(jumbo_max_len) is used for each platform. Right now the maximum
value for jumbo_max_len is 10240 (0x2800).

GEM uses one buffer per packet which means that one buffer must
allow room for the max MTU plus L2 encapsulation and alignment.

This commit adds a limit to max_mtu and rx_buffer_size so that
the RXBS field can never overflow when a large MTU is used.

With this commit, it is now possible to add new platforms that
have their gem_jumbo_max_length set to 16383.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c39a5a1e5732..cc48fd494458 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -50,6 +50,7 @@ struct sifive_fu540_macb_mgmt {
 
 #define MACB_RX_BUFFER_SIZE	128
 #define RX_BUFFER_MULTIPLE	64  /* bytes */
+#define RX_BUFFER_MAX		(0xFF * RX_BUFFER_MULTIPLE) /* 16320 bytes */
 
 #define DEFAULT_RX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_RX_RING_SIZE	64
@@ -2387,7 +2388,7 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = size;
+		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->dev,
@@ -5582,7 +5583,8 @@ static int macb_probe(struct platform_device *pdev)
 	/* MTU range: 68 - 1518 or 10240 */
 	dev->min_mtu = GEM_MTU_MIN_SIZE;
 	if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len)
-		dev->max_mtu = bp->jumbo_max_len - ETH_HLEN - ETH_FCS_LEN;
+		dev->max_mtu = MIN(bp->jumbo_max_len, RX_BUFFER_MAX) -
+				ETH_HLEN - ETH_FCS_LEN;
 	else
 		dev->max_mtu = 1536 - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.47.3


