Return-Path: <netdev+bounces-254786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH8qBKlXe2k0EAIAu9opvQ
	(envelope-from <netdev+bounces-254786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:50:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE3B026B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 037113006171
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDA387579;
	Thu, 29 Jan 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YBsbgzet"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7F3446D0;
	Thu, 29 Jan 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691044; cv=none; b=rYOXvpg9EWLfTc0o/Z451FjGyGiVXYuAV+feFjVit9vBoIrizIYE3bflgqrMb1RP+PeMkOiuDp06XEjzdsKo31V/W1haGvkOeSQUEEeQMbAgeGQo61Eu21ZlJC/afG51Cc42CxLZl2GXvyVp8mSRNn4DwscufA7pGr/qc4S0EKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691044; c=relaxed/simple;
	bh=dKEyniS8msElg9I2eUpjPbKKyQaDxmxe3UKN/HK+008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV3KAM44fsOdgATPnBMRmteI6ymE4JqXR5P96RZHD/BjIuo3iST/7NWhHVL8G4qqyQKLRLG26z4LFTBzMUBd4AW1GSz0xT5ooVz+oicOLb7zGS1czDMH17whv62UvTp3taFdrlBkqsSGqANXI0OuFJHg2pkkxzQsMJUxiB1k664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YBsbgzet; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ri8FmvbEKjZW/onf1C/Nwis8086NQS8jtNxaTm37K7I=; b=YBsbgzetUI+pZ0B+dhC0HTSbIH
	FCQ4UA5XTl4KDjqgho0iNjJCUMplsRJGlH3R7CKYGddxbYYC1WTtpxSybVDmJj8wMEaU2kCgW0ae1
	Voe7H//VPd/i5NGIiieHcglCf62kUTn4TFZReeuePCTcRLTct+JNRvXczYtDxl5UWCAS9tfUGy+C5
	HoxcmvjDG+nW69BvFtx7bZ7GfMFy1B4rhw7NuosQWlxMQ136BHCjoPCcCCvczxKxOvHfOz+SWkSzb
	pjMLUDodHA4RZBUQtnLdXs5iDrN1/zS9tJNC+O/ULTcu5XlPvTW8jX7cm2nsxrZ+nSbcVYwI4OUPY
	bExHcVqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlRTm-000000008Vz-1IP1;
	Thu, 29 Jan 2026 12:50:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlRTk-000000007z5-2C1q;
	Thu, 29 Jan 2026 12:50:32 +0000
Date: Thu, 29 Jan 2026 12:50:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com,
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com,
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com,
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Frank.li@nxp.com
Subject: Re: [PATCH 1/4] dt-bindings: serdes: s32g: Add NXP serdes subsystem
Message-ID: <aXtXmN1V8wg57yuE@shell.armlinux.org.uk>
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126092159.815968-2-vincent.guittot@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254786-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:url,nxp.com:email,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: B8DE3B026B
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:21:56AM +0100, Vincent Guittot wrote:
> Describe the serdes subsystem available on the S32G platforms.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  .../bindings/phy/nxp,s32g-serdes.yaml         | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> new file mode 100644
> index 000000000000..fad34bee2a4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,s32g-serdes.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx SerDes PHY subsystem
> +
> +maintainers:
> +  - Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> +
> +description: |
> +  The SerDes subsystem on S32G SoC Family includes two types of PHYs:
> +    - One PCIe PHY: Supports various PCIe operation modes
> +    - Two Ethernet Physical Coding Sublayer (XPCS) controllers
> +
> +  SerDes operation mode selects the enabled PHYs and speeds. Clock frequency
> +  must be adapted accordingly. Below table describes all possible operation
> +  modes.
> +
> +  Mode  PCIe	XPCS0		XPCS1		PHY clock	Description
> +                SGMII		SGMII		  (MHz)
> +  -------------------------------------------------------------------------
> +  0	Gen3	N/A		N/A		100		Single PCIe
> +  1	Gen2	1.25Gbps	N/A		100		PCIe/SGMII
> +  2	Gen2	N/A		1.25Gbps	100		PCIe/SGMII
> +  3	N/A	1.25Gbps	1.25Gbps	100,125		SGMII
> +  4	N/A	3.125/1.25Gbps	3.125/1.25Gbps 	125		SGMII
> +  5	Gen2	N/A	        3.125Gbps     	100		PCIe/SGMII

Shouldn't the mode be configured via phy_set_mode_ext()?

This identifies whether it is operating as PCIe or for networking and
in the case of networking, the PHY interface mode should be passed as
the submode.

Have a look at include/linux/phy/pcie.h to see the submodes that may
be appropriate to pass to phy_set_mode_ext() - but talk to the PHY
subsystem maintainers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

