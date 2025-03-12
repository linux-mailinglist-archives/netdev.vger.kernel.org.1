Return-Path: <netdev+bounces-174145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD2A5D9A1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94463189F89F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4023BCE2;
	Wed, 12 Mar 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tG6i5Av6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B3236A62;
	Wed, 12 Mar 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772130; cv=none; b=VaTum8S+V45uuUpqSFYt09jk215bL4hT9V/FlIlJ0yY1MXHuNVlldRJdpZ4VockMxptEDl+eRG8bHvc7/fiqg2e2aWzGj5o/WGvvaQGr8pAwirMg0LS7/oqSmWx3iGvF6Sf3P6OTPy2eCQ6tw4VKWF2+shtD8GjWL+1r9IAIFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772130; c=relaxed/simple;
	bh=i0fOKUZt2iXY29qYc4JEJRO2Xt3bIWkrwG7HP7o5sNw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JQ2ev9vQXohbDV9x20Yov/J/9vad5hNgH4VMEiY+nophca4ayeAmsZNmCOnIoJkqLRWSQj3jcA1epjr3MNtR/+lXpJe00LdJE5HtbMSSuqbznF2efUWy6ZSpcNhTIEzAE+2RSDnvDSS+25ipmQPceU4d6GoRcdF81WBhkgwTmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tG6i5Av6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=66r/Df/WRe1wVFnyIOw0GOt/Z4fFGvLuV3Qb0yAd/5Y=; b=tG6i5Av6LflwHt6a2VdGms32kA
	Tq7GZ5d//QSr++0OPfvaJS5d14Y9OmDTYUUoluxyruiNXCudNteoiJ57l/BdT71/uufNJrzZREk1T
	ISrh1iSSfukOCYhBmA1EnAAcrtobqpYApUEDEGRptmLvtmeCoWKfn5NHa9XSdInSM6z6f/o7dJVvA
	GXT2TgOPhEduvQaqyXUl4mU3gykx7v2cYcGbKBhoYBzcUegwaqfTmOuys2sZ+Vmfft5Hado7ic9Jk
	z9sivj9nhlis33jmHlZK+18xqriYfm+De+m5fjnGv1/ux6pdhPt7tlXGnT1d9xWWXOX35au87pAjW
	EIHpU59A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42840 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tsIUb-0005IH-02;
	Wed, 12 Mar 2025 09:35:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tsIUF-005vGd-C5; Wed, 12 Mar 2025 09:34:51 +0000
In-Reply-To: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
References: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v2 6/7] dt-bindings: deprecate
 "snps,en-tx-lpi-clockgating" property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tsIUF-005vGd-C5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 12 Mar 2025 09:34:51 +0000

Whether the MII transmit clock can be stopped is primarily a property
of the PHY (there is a capability bit that should be checked first.)
Whether the MAC is capable of stopping the transmit clock is a separate
issue, but this is already handled by the core DesignWare MAC code.

Therefore, snps,en-tx-lpi-clockgating is technically incorrect, so this
commit deprecates the property in the binding.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 3f0aa46d798e..78b3030dc56d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -494,6 +494,7 @@ title: Synopsys DesignWare MAC
 
   snps,en-tx-lpi-clockgating:
     $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
     description:
       Enable gating of the MAC TX clock during TX low-power mode
 
-- 
2.30.2


