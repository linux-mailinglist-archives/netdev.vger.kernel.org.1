Return-Path: <netdev+bounces-261255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEx7AsUNoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7111A32B2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2D330DC9F4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18209396D0C;
	Thu, 26 Feb 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ILInncCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D1395D8D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096798; cv=none; b=WLv4DUgcKo3LQ0erb2Gm6xe53Lhy7B7PeE3C7Re0ZWqxXd6vlXVzEeoKuMWlPoF4v1Tylzd4FOjBPkXyRO3+hFQfh7+Dl+tmkwmGAeXZWs6L+MvqoCErItOOb0L3Z6TE15Y5K/+eHVp/0EEz6muVnDE4xoQJ2W53Rvq9ZajUaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096798; c=relaxed/simple;
	bh=VZ/udcN32nKOGXUyfcSRYxNKGraXI7mrstbkFt8Wlbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRKBQkFlsYKBZmHmXFe68uwhJJRfe7wkW2d08CUZTsxGNQ4EAIG48tvwonYM3rG4/He/4p0mrYV7mT5y0Mxax23tIr8EzIEZjlPtORtAIGPo3TkaKK5uv61QhMsmEIIMEBlsmd4V/O28sIfNK/XczeEXzIRqIVhqHI0CVDp0n1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ILInncCf; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8F60A47B0;
	Thu, 26 Feb 2026 10:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772096795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZNU1zSHC0xiYFf3VNtzVO/XMAZcXtkq5iEa2WuGbVWY=;
	b=ILInncCf9K5gj/ltjw6LMdCtDujL5t8OQrM61YOXI+tx7fvxgIM65wVrtcK1v0DA7IKKJb
	V5N5X2+JEOeNfY2ad6hR2LETnoOoylZR2WeJdI7wY8v4+loYRSQYHAQZQcUSgVcguYRfLK
	8LkId1vtMLBVuCVmZxu5icmxklWQOSz1GYPveeM9hO0B+b3VY1Z/JAAVC/5pgFDKCHabZD
	Q0Mryzov/GsFDHvkZImiZknPBTPHLC2PHYMBxTfuAtVeiH9UOtGPBdEXhxlD+uLQVxrAhY
	jYsJ9btDMUKkklcfFPc82NPtUa0Fqc5fEeBNllG6L6jDKx3hrynDaMT/8awfCw==
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
Subject: [PATCH net-next v4 4/4] net: cadence: macb: enable EEE for Raspberry Pi RP1
Date: Thu, 26 Feb 2026 10:06:08 +0100
Message-Id: <20260226090608.54802-5-nb@tipi-net.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-261255-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 6A7111A32B2
X-Rspamd-Action: no action

Set MACB_CAPS_EEE for the Raspberry Pi 5 RP1 southbridge
(Cadence GEM_GXL rev 0x00070109 paired with BCM54213PE PHY).

EEE has been verified on RP1 hardware: the LPI counter registers
at 0x270-0x27c return valid data, the TXLPIEN bit in NCR (bit 19)
controls LPI transmission correctly, and ethtool --show-eee reports
the negotiated state after link-up.

Other GEM variants that share the same LPI register layout (SAMA5D2,
SAME70, PIC32CZ) can be enabled by adding MACB_CAPS_EEE to their
respective config entries once tested.

Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a7e00b99e9a8..2c2c940ec3b6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5518,7 +5518,8 @@ static const struct macb_config eyeq5_config = {
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.51.0


