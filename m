Return-Path: <netdev+bounces-149312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1789E5197
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902C828158C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2631D5CEE;
	Thu,  5 Dec 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HEcRky85"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23371D5AD3
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391761; cv=none; b=IIT6ipB0a8WGYcprv6ikV0JZr/WmH4zru4pAYOMbuzOlfgvEHHX1+e7GyUNAi/2T//2mCBClQNMgqq9vlgt+sCWilAful/biQlubae7XxAEbgG+CAX6AtWWXw3Gh/SZWVsl3TQ2X5N+83zZlo71wc6lQL3a1U+XqGGMVJaptxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391761; c=relaxed/simple;
	bh=YOAX/kDYS93CRTAyV9yok+iJG4ddKJPCQWoCW1sl50o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=aAwSRakrm3WNswnV5LEmaIpYPn4IcsHboWNiGt96T911ctB3y3i2Rsndxy0m6s+CO2mf99SFvqQ9XZSSHwQy3xxVx2GhY5J9Wj9nGpbihX9PY8WKe5LGtqKeBWamN7mBsKnaJCaXSb0bli2L+816X3QBE50bHkBOjlFi1pjti64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HEcRky85; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7vuVuSz1ikyfCg09UlbCqoDgZ9MeD4Xre3c4jOWt9Zo=; b=HEcRky85EwU1g0js4DcqNJdJeF
	Pful7qFqOyJByMWBEF8hwNdiMb8KgxMeQROWtoxp75zIDjuZfB/4jG7or1yJEBofi6vtvs6sMwjuB
	q4lprrbPOIXwj2tdIk0UBXKLAUq1fiMk1hRFg9hBVcaUPSlTWyi6tKC1g2hHAG9mGnxaKm+nkd37d
	QbJSm+xe2DPMb7mwg/pmbSDAKU1OAGWEet079h7Ti9SDqYbCp/mka/bjk57RCkJcotiU25zgskTew
	eOhQAxNCeceJC6SGFMSgy/54gV9k4u8pJY7QfW0gflEOQHQAM4qTToVUcD4MwbVDN6B0B0v3okBZu
	ygRujPkg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59736 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ8NS-0004U2-2B;
	Thu, 05 Dec 2024 09:42:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ8NR-006L5P-E3; Thu, 05 Dec 2024 09:42:29 +0000
In-Reply-To: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 09:42:29 +0000

Report the PCS in-band capabilities to phylink for the LynxI PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 4f63abe638c4..7de804535229 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
 	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
 }
 
+static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
+					      phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	default:
+		return 0;
+	}
+}
+
 static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 				    struct phylink_link_state *state)
 {
@@ -241,6 +256,7 @@ static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
 }
 
 static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
+	.pcs_inband_caps = mtk_pcs_lynxi_inband_caps,
 	.pcs_get_state = mtk_pcs_lynxi_get_state,
 	.pcs_config = mtk_pcs_lynxi_config,
 	.pcs_an_restart = mtk_pcs_lynxi_restart_an,
-- 
2.30.2


