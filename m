Return-Path: <netdev+bounces-247460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D10CFAF51
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054BD30DF056
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA71D47B4;
	Tue,  6 Jan 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="M1fFK2Q6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988172621
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731496; cv=none; b=GwUWHiuD9qFOfJrp0xeDb9qT9+B5F4bPOi0efdAH8Ils8/g/PaFAmD/zuvp39ySagoAQwY+FnZQYKJQnQgHQb0CMpFhL9N12bYeSGTsPiAV7L3KsGVPCjGZrgdoV6JZ+AQBxECRoTVXJXpaQYz3X6CJewxLYp+D7sMfGImljD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731496; c=relaxed/simple;
	bh=yIwqQ1cXtaBT6+2CFD/4l/yQFSz8y9uk21eVEwc7KdE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WfpUlRFCaC1BNPHbnnIFIkKTz45QUFB3MEO68q1BENyVXsgRF+yu0Aq8Gqbh2ZThFNJyvvrXxJTFuHN/oFP9Ok26JX7iA6xc8O1tpahHZqW15tb/R5bGURaj/0jLwtxAXYE2+uK+e6FAkLFdDvOUBW9RqWoJxvgFkgrY2DnweT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=M1fFK2Q6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ow5Q2oTlOwpy0d3Ggl1dyllFWj7dmZKHddfFehUm0pg=; b=M1fFK2Q6InDyrObeQZFE36jNAa
	9K9cm2S3n/9KCCGPT1VcGzK+Nd0ueI5kB79WiwO/0/bvOs3GBQQ8GetQZl3nPFYIktVjyVhG06mG+
	82LDz+Ip2sDFrSXins7vZ08+LKV/U38zDMgDlIZfmdRks9XNw0PHqmiTTN6PPESu/ghV+Pyy3KhaH
	ZwCdNrLVllm6rFBytaDO3m2UEMXGvU6ILPt83isZVBGjoyyR75ChqWnO/mcmp7G7tRh2B+kc2Npds
	sXZRcbTabaht3NHHvTpC/n4vrx4A0M0kmfxGbzLd3sFMahgHHRGMttL9Ut0C3pRK7Lj3mfDrecF5U
	n1B1SP4Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46294 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDiB-00000000113-2ukq;
	Tue, 06 Jan 2026 20:31:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDiA-00000002E1W-2X6U;
	Tue, 06 Jan 2026 20:31:26 +0000
In-Reply-To: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/9] net: stmmac: dwmac4: fix PTP message type field
 extraction
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDiA-00000002E1W-2X6U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:26 +0000

In dwmac4_wrback_get_rx_status(), the code extracts the PTP message
type from receive descriptor 1 using the dwmac enhanced descriptor
definitions:

	message_type = (rdes1 & ERDES4_MSG_TYPE_MASK) >> 8;

This is defined as:

 #define ERDES4_MSG_TYPE_MASK            GENMASK(11, 8)

The correct definition is RDES1_PTP_MSG_TYPE_MASK, which is also
defined as:

 #define RDES1_PTP_MSG_TYPE_MASK         GENMASK(11, 8)

Use the correct definition, converting to use FIELD_GET() to extract
it without needing an open-coded shift right that is dependent on the
mask definition.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index aac68dc28dc1..c84b26d51760 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -108,7 +108,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
 		ret = discard_frame;
 	}
 
-	message_type = (rdes1 & ERDES4_MSG_TYPE_MASK) >> 8;
+	message_type = FIELD_GET(RDES1_PTP_MSG_TYPE_MASK, rdes1);
 
 	if (rdes1 & RDES1_IP_HDR_ERROR) {
 		x->ip_hdr_err++;
-- 
2.47.3


