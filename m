Return-Path: <netdev+bounces-266345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMNuF/6MsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B7258445
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCBC330D4BEA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8D3EFD35;
	Tue, 10 Mar 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="chtY+wJW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E13D88EE;
	Tue, 10 Mar 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177809; cv=none; b=SG3XchEzodu4TDSg2W2XAptY7FM4mLlvcpsN/Q79+DpjMJGKP/mpDqT3HaH1v5sCm+UZL1lEpYCU4KOOUFJ/bR3X+SUcmCV0hpl0HJBx2am3GaqpWW1uo+Yz/N+TIaToI8A9qdXzhzEpHT21SsmUaXgfJ8SfRGBre5OEsw9mtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177809; c=relaxed/simple;
	bh=vVOBq2eof8ur3RVqKGazvNw6MhBj1bl2tFAJnyqgdiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmq5LqIkq0gVGfbJSZWO3oIJbh6TIANnR0H23K5IcNzjH58Nv9RgcETfQafMrKnui9GBKAx9zY2m3JTlY+KeD65xEndmgf1Das+7cWv8nTtpM3X/JQ9iFkDdvGnIBT9tySLabwjXGoJUuA+EZlWM3TznKqsiQkyZwZ3UCRH746o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=chtY+wJW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773177800; x=1804713800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vVOBq2eof8ur3RVqKGazvNw6MhBj1bl2tFAJnyqgdiw=;
  b=chtY+wJWutUj0RLrfo4jVT+GTyH431Nwbm8RUN2OqmQcZtQc6jSgVMUp
   xqc1DL5AsSdl+mbLMB5i1/+H6IsIgqiwnHmtUHMGKUlhCWptaybnXQPws
   NFSNY5fpw0lxYNYDOW2AOZTQhSSiMSxnsV2+1qMEi3l2zLDQ2daj0tZWM
   rE4A/Hcq52sxeuuRDFQRMAqtzTZ9F8DSBPRA/rCw3hagRP3hdtod+8ljX
   vBfVysPjBbXTfOLSG/by0Rmwi02YejXOGtJ54oZ0FbfSPBmA7UXUjqPx3
   Jr0/ncs5nrhb9Q4CJEKheXWnkceGKvp6wmcqD8gwRoAicaJ8UVulbl8vB
   A==;
X-CSE-ConnectionGUID: Fckl8p3GQOSmyEqqzS7I1g==
X-CSE-MsgGUID: AT4g6QgZRCWL7jJkxby+lQ==
X-IronPort-AV: E=Sophos;i="6.23,112,1770620400"; 
   d="scan'208";a="62045476"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:23:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Mar 2026 14:22:57 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 10 Mar 2026 14:22:56 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/3] net: macb: add safeguards for jumbo frame larger than 10240
Date: Tue, 10 Mar 2026 14:22:01 -0700
Message-ID: <20260310212202.3991199-3-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310212202.3991199-1-charles.perry@microchip.com>
References: <20260310212202.3991199-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: D11B7258445
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266345-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

The GEM IP has configurable maximum jumbo frame length that can go up to
16383. The actual value for this limit can be found in the
       "jumbo_max_length" field (bits 0..13) of the DCFG2 register.
Currently, the macb driver doesn't use the DCFG2 register when
determining the max MTU, instead an hardcoded value (jumbo_max_len in
struct macb_config) is used for each platform. Right now the maximum
value for jumbo_max_len is 10240 (0x2800).

GEM uses one buffer per packet which means that one buffer must allow
room for the max MTU plus L2 encapsulation and alignment. This is a
limitation of the driver.

This commit adds a limit to max_mtu and rx_buffer_size so that the RXBS
field can never overflow when a large MTU is used.

With this commit, it is now possible to add new platforms with a
jumbo_max_len of 16383 so that the hardware properties of each IP can be
properly captured in struct macb_config.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dc661e5a0769..96e15f58e173 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -50,6 +50,7 @@ struct sifive_fu540_macb_mgmt {
 
 #define MACB_RX_BUFFER_SIZE	128
 #define RX_BUFFER_MULTIPLE	64  /* bytes */
+#define RX_BUFFER_MAX		(0xFF * RX_BUFFER_MULTIPLE) /* 16320 bytes */
 
 #define DEFAULT_RX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_RX_RING_SIZE	64
@@ -2393,7 +2394,7 @@ static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = size;
+		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
 
 		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->dev,
@@ -5588,7 +5589,8 @@ static int macb_probe(struct platform_device *pdev)
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


