Return-Path: <netdev+bounces-178071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A368AA7456A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35447A7C70
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAA212FAA;
	Fri, 28 Mar 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Soa0HlYE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A5212FA3;
	Fri, 28 Mar 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150679; cv=none; b=IuxUV4j3cTpl6zj3qsk5O2yOxmBlt6Ww6lzJK0wtT4qPrpQbop84USmhIxAVCzWNI7zW5ujsb/8g6ivUm2Q3eLeuFVPXTKLvV/q+CcOBOLr5GlriBJEvbjQ3lxTdGYDqmQjMvpKywq9nV0PQ4669ckioQ6/DwpiI0hDwCIKr3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150679; c=relaxed/simple;
	bh=W1ijLkVD+r1Mbr+dTxFg4hpHIKg9HGyAzzfPZkdDY/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L03UsR/u14VX7LlZjK/8orDPagWCJaNOSo8i7+8anjgbHe9VTHCInmNRIGE6jbTktING7mcHNXNHrCwY8MduUmugPl8AVfkCQ5l2c1GI652ySWy9PvGTatDrQ2G9G7OXIxamFHwm0zjKnJQlryx8jE8EnsoHXRDQmpZHCNiu8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Soa0HlYE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eiyjJ7Xvynv7EYyBA/dubhzSD/lLyCEcXIjuNUtW1O4=; b=Soa0HlYEcxrc+s6yMNOCZUAPoh
	IaQhsnncS9m/K5dqQ/wpGchltuENVuLoC4q0Tm3fUnaW0br5TORezrjn+TlQgFThERhrTMrBzHkZZ
	je7pIepkekfhJnpioFHZnZc61VFAtKE1yrXZJyZfhaLAeV/9fO3UBrOvLqeHaw8cOq8C0xm1D10BT
	7J7SQpVz02FE3+2HN9Qt/hpA/mahDWemwIfkGYcbO2EnIZYjpA5PzBeQ0geEaswRaMMx7+8aqhIWp
	JK7vJbGGkRMa7p2HAstGN9I3HfXrKqg8o2nbCowpYZUn4FqrxB8Cu/qtY0uQMoysqVXM++h/5DKVl
	WZ1pFMdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ty57I-0008C7-1X;
	Fri, 28 Mar 2025 08:31:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ty57G-00072a-1O;
	Fri, 28 Mar 2025 08:31:02 +0000
Date: Fri, 28 Mar 2025 08:31:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v4 3/6] net: phy: nxp-c45-tja11xx: simplify
 .match_phy_device OP
Message-ID: <Z-ZeRhR73FS4iOzz@shell.armlinux.org.uk>
References: <20250327224529.814-1-ansuelsmth@gmail.com>
 <20250327224529.814-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327224529.814-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 11:45:14PM +0100, Christian Marangi wrote:
> Simplify .match_phy_device OP by using a generic function and using the
> new phy_id PHY driver info instead of hardcoding the matching PHY ID
> with new variant for macsec and no_macsec PHYs.
> 
> Also make use of PHY_ID_MATCH_MODEL macro and drop PHY_ID_MASK define to
> introduce phy_id and phy_id_mask again in phy_driver struct.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx.c | 39 +++++++++++--------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index bc2b7cc0cebe..fccfc1468698 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -19,7 +19,6 @@
>  
>  #include "nxp-c45-tja11xx.h"
>  
> -#define PHY_ID_MASK			GENMASK(31, 4)
>  /* Same id: TJA1103, TJA1104 */
>  #define PHY_ID_TJA_1103			0x001BB010
>  /* Same id: TJA1120, TJA1121 */
> @@ -1971,31 +1970,17 @@ static int nxp_c45_macsec_ability(struct phy_device *phydev)
>  	return macsec_ability;
>  }
>  
> -static int tja1103_match_phy_device(struct phy_device *phydev,
> -				    const struct phy_driver *phydrv)
> +static int tja11xx_no_macsec_match_phy_device(struct phy_device *phydev,
> +					      const struct phy_driver *phydrv)
>  {
> -	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
> +	return phy_id_compare(phydev->phy_id, phydrv->phy_id, phydrv->phy_id_mask) &&

We try to keep to less than 80 columns in networking, and this driver
does so, so please keep it that way.

(Note: the 80 column limit doesn't apply to printing messages, which
should not be line-wrapped to allow them to be searched for).

Other than that, thanks for addressing the other driver I pointed out
that benefits from this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

