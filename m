Return-Path: <netdev+bounces-218010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F4B3AD3C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC1246831E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C029AB03;
	Thu, 28 Aug 2025 22:02:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A43283FD0;
	Thu, 28 Aug 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418558; cv=none; b=lDwL+J5j0DU6pc71urYg+mGMvl/rn8xCtOZCYLPgiZnJ6eQuLP/4QKWZXTthFAYKyUmKXffJRZuqdBIxFWRsylkPI9jx78QfT4WcexC2LC3oL3TQnP+qSzeTHnfdZfaAj9DnOE7O07LOrFczhRhKMJOkxx10ZidHcQxS61vMEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418558; c=relaxed/simple;
	bh=U9cQc6NYxZR5TUCvYLwAzMyYrrUuWdvXx4OELHv4dUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf7Zq/6Wk/AVM9Y4U/o/UeFXCdDs6xJUDEMK7DUhjK+ShyXayOzKKr+STHIIwvGHEN7R6H3L8LJe9+hlIVZS13PuivKQ1CrEYYGQCFdX7UmBiX90iT5SIRUsdFBgCqlDRng0bs+HYNktrf8ORKL7nk37xKfFufSLGgy1PFBv478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1urkhE-000000006HZ-0TnL;
	Thu, 28 Aug 2025 22:02:16 +0000
Date: Thu, 28 Aug 2025 23:02:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 3/6] net: dsa: lantiq_gswip: ignore SerDes
 modes in phylink_mac_config()
Message-ID: <aLDR4pRjJkMsSGQ7@pidgin.makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <99d62fca9651f17ed1e94ab01245867bcd775cd8.1756228750.git.daniel@makrotopia.org>
 <20250828203935.c46twi4r7qktxaco@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828203935.c46twi4r7qktxaco@skbuf>

On Thu, Aug 28, 2025 at 11:39:35PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 27, 2025 at 12:06:03AM +0100, Daniel Golle wrote:
> > We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
> > SGMII in phylink_mac_config() as they are being taken care of by the
> > PCS.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2: no changes
> > 
> >  drivers/net/dsa/lantiq/lantiq_gswip.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> > index acb6996356e9..3e2a54569828 100644
> > --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> > +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> > @@ -1444,6 +1444,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
> >  	miicfg |= GSWIP_MII_CFG_LDCLKDIS;
> >  
> >  	switch (state->interface) {
> > +	case PHY_INTERFACE_MODE_SGMII:
> > +	case PHY_INTERFACE_MODE_1000BASEX:
> > +	case PHY_INTERFACE_MODE_2500BASEX:
> > +		return;
> >  	case PHY_INTERFACE_MODE_MII:
> >  	case PHY_INTERFACE_MODE_INTERNAL:
> >  		miicfg |= GSWIP_MII_CFG_MODE_MIIM;
> > -- 
> > 2.51.0
> 
> Is "miicfg" irrelevant in these 3 modes? Doesn't it have to be set to
> GSWIP_MII_CFG_MODE_GMII?

The function is basically already a no-op for SGMII ports for which
there isn't a GSWIP_MII_CFG register (ie. gswip_mii_mask_cfg() will
just return and do nothing). The same is true for gswip_mii_mask_pcdu(),
so what is left is just the printing of the error message
"Unsupported interface: ...", which is misleading (and could maybe be
removed completely now that I think about it as phylink_get_caps() should
already make sure that phylink_mac_config() only gets called with a
supported interface mode).


