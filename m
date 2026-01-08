Return-Path: <netdev+bounces-248206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 089EFD05929
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8289323D501
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2842D593E;
	Thu,  8 Jan 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SE8fOoKC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CD1E572F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893789; cv=none; b=njQKDYs38vQiykt1gwURhk0BG7K8ApzjS1TLhsAQmU1pIPDhr/Myw+sQQ8MmDXZc/pjfRDZIWEa6rOg78uslplCDIZbuBQDMKafH3uF/TkzOMbggJD42lK0aS3w2eY1MNFlD+pLwRmDSwSia00p5Jg3ZwRAJZkW/UY0XdPM8pcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893789; c=relaxed/simple;
	bh=tbRrYyKLL7GAOykwbWcGoGLo2ahlCADd1Z9HcrxXY8E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Slyz76rw/1P/m7WFN0KKxya88bOnWE2NrAWUwml2wv+TvJlpJpgY2PxFTyiF9ozbRL6xTmemx5z3PPf+CXXHtIfUyilogQxspcRw+wRS/Xqhzw/DOoEh612r2hd26XkQhZa9zDGfV5XY4wZDIhNpG1+oK5yb5Q4L1/j3ZMDX1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SE8fOoKC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JAM3p217on0LQd5A1+LnCZgftY0kMT3Jv9qw4Y1bwoo=; b=SE8fOoKCwzDu0plXYHgAN806EU
	3knhUPs26HUWD9VUlfuLipjA0t4cSwIF8sCZUR17qi72z3Cuw8sTkhhx4DKp1Vf514RDi0+n+/1F4
	VWum07bQZG7A9wgb36uzQmnUU+Zn/E/u0gIRfStvHqrKX2amKTINQfi8OjCKxmeWCD6ZkTcBrfwo0
	Yp5SAgubMszZTWM7AQQu0PedMJT39xNTmBeapC/vB3aGM170doGiWAz0QLZlwN7qASrvpZd/DNm93
	Bd2/HHW8kchwf1nGgncUNw7F2oXEdxqxPmrOIhyciXtmVhzeeGgPiniHyESdIRhdVdL/VHU7Uy2ZE
	rwkLWTfw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42936 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdtvo-000000002z8-1ejj;
	Thu, 08 Jan 2026 17:36:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdtvn-00000002GtV-1wCS;
	Thu, 08 Jan 2026 17:36:19 +0000
In-Reply-To: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
References: <aV_q2Kneinrk3Z-W@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 3/9] net: stmmac: dwmac4: fix PTP message type
 field extraction
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdtvn-00000002GtV-1wCS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Jan 2026 17:36:19 +0000

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

As this change has no effect on the generated code, there is no need
to treat this as a bug fix.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


