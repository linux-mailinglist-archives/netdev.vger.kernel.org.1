Return-Path: <netdev+bounces-180631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A90A81F23
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40D94C2A7F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2E25B670;
	Wed,  9 Apr 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dQpPFdfh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813641DE2CE
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185784; cv=none; b=M0z4R0GJEXV+Uj4ZV7C5CnAppeH2V2EKo3DHsh00UYj0XXTysswQELBHh3814tE9G3VuPrT97XQyYu2MtiijttdUi7hBYAZAvXniY08qSbjMZcQn2O/WUIIYPXAVmg+9JXInGH3Bm0c+Dk/1OgY7QiBFQ1YxjvRlXfIhePFtzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185784; c=relaxed/simple;
	bh=xguabqRsduqHwmlMXbbrUsNrBk9VlNIZeV8bIjsx6+Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=FVOOYa/SjyVUf1So/5JJzMfTrDdwrksgxGBUueu6cTknh4LOX4Qm5mrpnguX8Uj7Y4+RwTBieByH0b4bbwyGRflLLlXWEQNezoiY6mHkW/kZ66S0z1H2ypdF+cOQkYc6a2lobfnaEFwPIUNAI3yX2Szip7AUQt694Qpq51E6BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dQpPFdfh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+6nvcOJ++NOB/Y9LYXH1TIQKqdDOujyb+N4hlkpNcJ4=; b=dQpPFdfhbTOOkVqVQwaKv8AQmf
	BXG7XsHG1p8sgePhIRkqhafUnFjSTbQWugzIxEREYTJ16OTWqZE8yA5PhCJLU7fKHUWfowkjACkbs
	vT2cWXTOjcbiniyqm6Dj2dNJRgSi2tpCrEtAgi8mvWDvGlKw7WhRVl56+TSZpePyOaGhDuF+lWASV
	YIiGEvEyeIcR8qcCmtSdv+ZIOiH/cKJ0hlDA0i1HPZfzfB7xFw6lHl0kD9HKVIETE5M735VS8RtvS
	YStAAqNHHYQl3c/bm76lA5UFL7q+kcUx3L99qj4Cnzev13TMdJgGggrWfVSoMD/JJ8qPvD7BJVHAK
	CagUnSjA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39190 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u2QOa-0000Cd-1j;
	Wed, 09 Apr 2025 09:02:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u2QO4-001Rp2-Dy; Wed, 09 Apr 2025 09:02:20 +0100
In-Reply-To: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
References: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 1/2] net: stmmac: provide stmmac_pltfr_find_clk()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u2QO4-001Rp2-Dy@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 09 Apr 2025 09:02:20 +0100

Provide a generic way to find a clock in the bulk data.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index c73eff6a56b8..43c869f64c39 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -709,6 +709,17 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 
+struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
+				  const char *name)
+{
+	for (int i = 0; i < plat_dat->num_clks; i++)
+		if (strcmp(plat_dat->clks[i].id, name) == 0)
+			return plat_dat->clks[i].clk;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 72dc1a32e46d..6e6561e29d6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -14,6 +14,9 @@
 struct plat_stmmacenet_data *
 devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 
+struct clk *stmmac_pltfr_find_clk(struct plat_stmmacenet_data *plat_dat,
+				  const char *name);
+
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
-- 
2.30.2


