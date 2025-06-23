Return-Path: <netdev+bounces-200338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916EAE4971
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5644D3AA1B5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93128DF2B;
	Mon, 23 Jun 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gJP4cXg9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF38277028;
	Mon, 23 Jun 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694364; cv=none; b=CCkRcFXjIAV2/s8x5MQaT8Tr0CMxz/lVMJRHObHrmh2FmkO4IeN3zkE6ej4I6PArtXX0PPuUNpTBE64l/R/Dc2NRU2YJj0tBwpeg49Fs/12qCIUcnnwFcMI22vXKv8QBsKc+XbDVOVdYPjWLkNPRxtEtkQoB9U7dBzOBvg3sSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694364; c=relaxed/simple;
	bh=/rfl7gOGpO0g14cYMRJ7KQfJPeeEo1fzAajmHgRfcP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkX45T3I0Mdbl+dEdhWot/ls/kwUIgTeHjdUGn4lj38bGeZeAa6pMOCL/jry5Icz3J7PsN+VElGS5Bkg9CTeCc8UhGphIiQuRpj2Tfc4jPGX1YJ+bX4bp/z13wETBMIwhZbSNP3pRGK023QU46VCmRWxUtC6A0Y9u0WkATd/rEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gJP4cXg9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ivJftfXIlijyNb6aPqxEHL2vbAZ+7Nan5sa8DA4Nd4s=; b=gJP4cXg900T3X2PP4GO2+aWAyS
	eo+T+0X1Oo3zr3UET8GybiWIdDBy/H5GwrGDRhyW7IOLilENX7aJCNnZ6QT4+XPSsgROObz6T5fai
	52pLJ6BJ6BRSsLSlU0OjdgPhvWa5rp2p9kZMZYF1WrbSmCO07z2WO0F1zFa/R39r8UZK+ARzysPnV
	c/afMbJWDuHuQDJ3nfuEAiBvqJZ80PrpOSk8gHIyfFHLcJ+K5qlCSFo9/MxLg726OBArGclzvOHdl
	aqnrLDjXWVVTzd3hV08OI/n6FsnG5wb7+6uP5OzDy7QN5DLn3NmDAS4aq6I/X+ewruGynu+DJgj0L
	5zhBr+Kw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uTjZi-0004O5-1x;
	Mon, 23 Jun 2025 16:59:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uTjZh-0003Zx-0L;
	Mon, 23 Jun 2025 16:59:13 +0100
Date: Mon, 23 Jun 2025 16:59:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH net-next v2 3/3] dt-bindings: ethernet-phy: add optional
 mii-lite-mode flag
Message-ID: <aFl50MeMElkRbyzj@shell.armlinux.org.uk>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623151048.2391730-4-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 23, 2025 at 05:10:48PM +0200, Kamil Horák - 2N wrote:
> From: Kamil Horák (2N) <kamilh@axis.com>
> 
> The Broadcom bcm54810 and bcm54811 PHYs support MII and MII-Lite
> interface modes. The MII-Lite mode does not use TXR, RXER, CRS and COL
> signals. However, the hardware strapping only selects MII mode,
> distinction between MII and MII-Lite must be done by software.
> 
> Add optional mii-lite-mode flag to switch the PHY to MII-Lite mode.
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 71e2cd32580f..edfd16044770 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -101,6 +101,14 @@ properties:
>        1BR-10 names. The PHY must be configured to operate in BroadR-Reach mode
>        by software.
>  
> +  mii-lite-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If set, indicates the use of MII-Lite variant of MII, without the
> +      functions of TXER, RXER, CRS and COL signals for Broadcom PHYs. These
> +      PHYs can be strapped to use MII mode but the MII or MII-Lite selection
> +      must be done by software.

I'll put the same question here as I did on patch 2. Do we want this to
be a separate property, or would it make more sense as a different
phy-mode value?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

