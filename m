Return-Path: <netdev+bounces-267037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGeaIBiusmlGOwAAu9opvQ
	(envelope-from <netdev+bounces-267037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:14:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF327184B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F0BC300D1CE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8B3BE638;
	Thu, 12 Mar 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fD00DkIs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70D19EED3
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317642; cv=none; b=in8/lP3L3Z5lXVFtzmTvipcp1eixuCZQjakSJFMvkhYl34oajie9CBkoqbqryCsvIZtuvh4U57uhbd4sId6hLPubPnRCIZepPHi5AHU360NWXHNjtMpw9G+JfYzOfvffXfmFiVqG47HORDgswHE5QBvdAHTvrPwuFvFEYcli6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317642; c=relaxed/simple;
	bh=+X1bl6tOHWNqF4DOkDxn4gXCttBI8uyIcBhd7kTLmwY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=hu0zkKuLTnCwo9zZht8oLUvHkpdSZeQ24eLNlqpNFQzcnYVPqQKFaz4QjOeT0ynIvvh11JF2z+nTKvU2hoQ+PGGySw4LvciV1K8z0h3bBjdYYvWoaQCGLWbNSTx8CflDu0mnIdawXFbm1QDsIb1Aj8Ns/DcGJ4bvr0L1j0+3pDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fD00DkIs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1je3WPymH0THXPKtudz8hsGg9eMg3RuF4V2JvpxjpKU=; b=fD00DkIsZRZnMotPVW6c92fsr8
	qYlqS2A4/6uEUr9kh2vU2a0OzRx6R7jgxPO9aZkhswtaTlpQ1Zndn0QkyOoPjjhPWdop70aQnKyac
	ubClQMMut0InmZP6QVpzhrU0W1d433gI+O2ofGGh4LuVum7W4CBCD8bhgpMhSIrHfk1Rtd5hRbZA4
	8tKakuzAva+ngMLHTHMJ16s5o53Ecvb4CWn0idCnIs2kQNksCraTv5jBDYAnCQdAEQUBmB/iWhu+H
	dif3SQvc27decXL224n42EupBc9dHJv31yY9YL6/Dr4b9wquiJOBNoR1qxzOanlpOx4FrWDGEBKS1
	zw9Wnbpw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53376 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0evJ-000000007kl-0l9a;
	Thu, 12 Mar 2026 12:13:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0evI-0000000CzY7-1fyo;
	Thu, 12 Mar 2026 12:13:52 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: avoid passing pci_dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Mar 2026 12:13:52 +0000
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267037-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 62DF327184B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pci_dev is only used to provide the ethtool bus_info using
pci_name(priv->plat->pdev). This is the same as dev_name(priv->device).
Thus, rather than passing the pci_dev, make use of what we already
have.

To avoid unexpectedly exposing the device name through ethtool where
it wasn't provided before, add a flag priv->plat->provide_bus_info
to enable this, which only dwmac-intel needs to set.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 5 ++---
 include/linux/stmmac.h                               | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 421c6c81ca5e..f621077c30a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -589,7 +589,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	int ret;
 	int i;
 
-	plat->pdev = pdev;
+	plat->provide_bus_info = true;
 	plat->phy_addr = -1;
 	plat->clk_csr = STMMAC_CSR_250_300M;
 	plat->core_type = DWMAC_CORE_GMAC4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index c1e26965d9b5..92585d27ab88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -312,10 +312,9 @@ static void stmmac_ethtool_getdrvinfo(struct net_device *dev,
 		strscpy(info->driver, MAC100_ETHTOOL_NAME,
 			sizeof(info->driver));
 
-	if (priv->plat->pdev) {
-		strscpy(info->bus_info, pci_name(priv->plat->pdev),
+	if (priv->plat->provide_bus_info)
+		strscpy(info->bus_info, dev_name(priv->device),
 			sizeof(info->bus_info));
-	}
 }
 
 static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 937985276e6b..72febd246bdb 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -348,7 +348,7 @@ struct plat_stmmacenet_data {
 	int rss_en;
 	int mac_port_sel_speed;
 	u8 vlan_fail_q;
-	struct pci_dev *pdev;
+	bool provide_bus_info;
 	int int_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
-- 
2.47.3


