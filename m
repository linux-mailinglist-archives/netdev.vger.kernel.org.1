Return-Path: <netdev+bounces-68377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA1846C22
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3E41F29059
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9517CF02;
	Fri,  2 Feb 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="psvNyz0j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC377F26
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866451; cv=none; b=psIGXQaPwNsr2zxfnzDsANIzNSkoR3WcKVRimZUo9BLRizh179VOSXbGS3rfJ6AOFxfZ85Tp+wzkg5JPz3QUcI6XGb03vkbterQP1CH+2v+eWpp80Kvxk7FnMWtsGtUKli0EJo0q2g3VtsSugwB9NE2HW3ziII9wpycRs3HDJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866451; c=relaxed/simple;
	bh=yEiTvE6CoPzf+fNPWUVRuAPw0zNy4+UNMVJ11p6zFqI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cFS5d1hf8ihAfGsJ5n/gQJ5+ezYoySkHdYaqoYYPv9dhThIgNABGrXAqB0aOY+nJHztm084g0wi9WBCU2MfBUqXuaqInqI3oQXwhqh+vmIApe4TPlHaSYQVBnZLRk+7sz3K9SNcnVEz+JQHDO4qMFm89l6xO+igg7UVLm9KGGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=psvNyz0j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PbWLK+MOR3/lEMtgzx4zTiXixve0bEAN+thqPJbkNns=; b=psvNyz0jX+trhUoXpk/jKxZUXN
	imbp1fYgBStwdiAHW2MVT1mPkJWZlcogn0HDyd/HrZn6NEub+0o4Ybx4uge7zxFI8wDP4ygS9M1UJ
	efKbb/Cprz91d+k5PStWjUax2S74XiqCFfpDdffv4DE1PuV2APYaNsEGjeLZSEoKPWYfTr0SqszwR
	obNuTzoflDhthi++a3/fNHkHp04mJ1p68PPMWD9DM8+J9XEWb5f5rgJqVe6jqtVRIDw3iX2ipD0iJ
	zzI4hFYQVS+1t0Zl6HFM/Ev6DygpyS0sfKpTFOytQyeiJNW5+bEc9/VZmmM7i6+rvWZFw8J7OL0DZ
	OQapDZKQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45812 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVpvd-0005ib-3D;
	Fri, 02 Feb 2024 09:33:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVpvc-002Pdp-Jj; Fri, 02 Feb 2024 09:33:44 +0000
In-Reply-To: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH net-next 1/6] net: stmmac: remove eee_enabled/eee_active in
 stmmac_ethtool_op_get_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVpvc-002Pdp-Jj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Feb 2024 09:33:44 +0000

stmmac_ethtool_op_get_eee() sets both eee_enabled and eee_active, and
then goes on to call phylink_ethtool_get_eee().

phylink_ethtool_get_eee() will return -EOPNOTSUPP if there is no PHY
present, otherwise calling phy_ethtool_get_eee() which in turn will call
genphy_c45_ethtool_get_eee().

genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
with its own interpretation from the PHYs settings and negotiation
result.

Thus, when there is no PHY, stmmac_ethtool_op_get_eee() will fail with
-EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
userspace. When there is a PHY, eee_enabled and eee_active will be
overwritten by phylib, making the setting of these members in
stmmac_ethtool_op_get_eee() entirely unnecessary.

Remove this code, thus simplifying stmmac_ethtool_op_get_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index bbecb3b89535..411c3ac8cb17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -859,8 +859,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->eee_enabled = priv->eee_enabled;
-	edata->eee_active = priv->eee_active;
 	edata->tx_lpi_timer = priv->tx_lpi_timer;
 	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
 
-- 
2.30.2


