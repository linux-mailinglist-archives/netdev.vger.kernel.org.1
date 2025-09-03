Return-Path: <netdev+bounces-219595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8BB422E9
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6E7483987
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7130F552;
	Wed,  3 Sep 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oM9HZmfO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090951C5486
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908070; cv=none; b=savbmqO3RvPpxB48cEpldgVCudk4VbCaQs6JxlA78vNZ50wE5YPHOGKtG9iwNP/YmFPOeeIPNDw3OLNp89A680UU/oj0Ha60Rn4ap+M/S2RpIfbvnxVdR6o3icWHlfiFRaPKgHTo3O/GxIPFCfFqJNEXTtT/GMgg0ZTq9erPD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908070; c=relaxed/simple;
	bh=fpBqInErbj++Msscx8vsY2zzIzyRMlXEclpCDiA+EBo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uLcKanWGViL8X/ESlZSoIEKJ/ZOFjMAIap3s2ERbdeiXbYCwt3DXD8aIeG5GIS0IKqA835B3/U9hiWLn06mM9iA2e8hUF/2bSxWQ+BrwR47SwlG/zyLQVk2NaaP2CHB2SktXcGLpoKaDEmEanO1Pli9+IqdRBXVSa1GDM6H8xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oM9HZmfO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7fWc7bzaE61Z8/ywQrMGqQ4349t+JxTuForfkmFTiNA=; b=oM9HZmfOA3mMTO7LpPvPNh6Cwv
	2KEgKZsSbbdUJCXNXJUr0n//qU1si2xaKv9J6iMmU2OiPRa27fGEeHSHbENfDDiFB1z/MUd3OxbYB
	ssR+R5DcOO7TeasiCVP+Wl8eLzmoeTO5LWZacW6VCSpVPU9s2QE8kY/hCeAc++t19q6kMsmEf6axS
	tfKJ07+6SaHkxt31iSMwfeIChFYCl8bipyQvfii7P9FmKhtA//1ysV0eOJaMAFdJoKxlssVCqQlZT
	aOC5Yw0Ds7eQ83WQbldPEPsye0OYH3KZeotznJQUX/2LDAADVwT76MTytuoABGg7dZAHUecybTc11
	OytQxCvw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52700 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uto2i-000000000c8-3ssX;
	Wed, 03 Sep 2025 15:00:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uto2i-00000001seA-0lxv;
	Wed, 03 Sep 2025 15:00:56 +0100
In-Reply-To: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
References: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/2] net: stmmac: intel: only populate
 plat->crosststamp when supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uto2i-00000001seA-0lxv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 15:00:56 +0100

To allow the ptp_chardev code to correctly detect whether crosststamps
are supported, we need to conditionally populate the .getcrosststamp()
method. As the previous patch implements that functionality by
detecting whether the platform glue provides a crosststamp() method,
arrange for the dwmac-intel code to only populate this if the X86
ART feature is present, rather than testing for it at runtime in
intel_crosststamp().

This reflects what other x86 PTP clock drivers do, e.g.
ice_ptp_set_funcs_e830(), e1000e_ptp_init(), idpf_ptp_set_caps() etc.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index d900b93f46ce..e74d00984b88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -371,9 +371,6 @@ static int intel_crosststamp(ktime_t *device,
 	u32 acr_value;
 	int i;
 
-	if (!boot_cpu_has(X86_FEATURE_ART))
-		return -EOPNOTSUPP;
-
 	intel_priv = priv->plat->bsp_priv;
 
 	/* Both internal crosstimestamping and external triggered event
@@ -756,7 +753,9 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->int_snapshot_num = AUX_SNAPSHOT1;
 
-	plat->crosststamp = intel_crosststamp;
+	if (boot_cpu_has(X86_FEATURE_ART))
+		plat->crosststamp = intel_crosststamp;
+
 	plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
-- 
2.47.2


