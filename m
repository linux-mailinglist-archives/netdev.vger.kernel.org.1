Return-Path: <netdev+bounces-218582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6AEB3D599
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 00:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED481898A2F
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C124635E;
	Sun, 31 Aug 2025 22:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A2635
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679331; cv=none; b=d0Diq1zJZyXjkYpFOSD+SHMoOaOjOmQGfIEde+/YW4Eq+Z01UigpU7KZ0zdtuzfZvEnMQeWn/0/b4G1h8ryjHJ0CNnynYBnbz5YvB5Qn7gAjS0mXCnVfV8RwBOMNAbXG/BIRlWkCYMw4AvbgXxpCuEAGG6NRIRrIuQ+gjWEQGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679331; c=relaxed/simple;
	bh=qhe/iIMuVAD1Jhb5k9Hv4ZC0qexXWN81b9RlumNB4wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBvvme60lV3xZbJWiUV1J5zZNFM1W0zQUA8TYP5mGZS2SaYdSFz56d0xPbsPYDDfnyMm8SlFrFTlpvOS6QaMiLz2tYBJ8RDsxKRjfgWaMGXcfHz9kItnXzzd9WszQJRkYMcvPbgXqR0qZ3Z7NzzkeZL0vrkJUto2F1Eh0AVu2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usqXS-000000004Co-44ii;
	Sun, 31 Aug 2025 22:28:43 +0000
Date: Sun, 31 Aug 2025 23:28:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: mvpp2: add xlg pcs inband capabilities
Message-ID: <aLTMmMCq5FqjQW6g@pidgin.makrotopia.org>
References: <E1uslR9-00000001OxL-44CD@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uslR9-00000001OxL-44CD@rmk-PC.armlinux.org.uk>

On Sun, Aug 31, 2025 at 06:01:51PM +0100, Russell King (Oracle) wrote:
> Add PCS inband capabilities for XLG in the Marvell PP2 driver, so
> phylink knows that 5G and 10G speeds have no inband capabilities.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> The lack of this patch meant that I didn't see the problems with 10G
> SFP modules, as phylink becomes permissive without these capabilities,
> thereby causing a weakness in my run-time testing.
> 
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 8ebb985d2573..35d1184458fd 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -6222,6 +6222,12 @@ static struct mvpp2_port *mvpp2_pcs_gmac_to_port(struct phylink_pcs *pcs)
>  	return container_of(pcs, struct mvpp2_port, pcs_gmac);
>  }
>  
> +static unsigned int mvpp2_xjg_pcs_inband_caps(struct phylink_pcs *pcs,
> +					      phy_interface_t interface)
> +{
> +	return LINK_INBAND_DISABLE;
> +}
> +
>  static void mvpp2_xlg_pcs_get_state(struct phylink_pcs *pcs,
>  				    unsigned int neg_mode,
>  				    struct phylink_link_state *state)
> @@ -6256,6 +6262,7 @@ static int mvpp2_xlg_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  }
>  
>  static const struct phylink_pcs_ops mvpp2_phylink_xlg_pcs_ops = {
> +	.pcs_inband_caps = mvpp2_xjg_pcs_inband_caps,
>  	.pcs_get_state = mvpp2_xlg_pcs_get_state,
>  	.pcs_config = mvpp2_xlg_pcs_config,
>  };
> -- 
> 2.47.2
> 
> 

