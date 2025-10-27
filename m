Return-Path: <netdev+bounces-233333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9642C121C9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E0562055
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3032D42D;
	Mon, 27 Oct 2025 23:48:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA32E7F29;
	Mon, 27 Oct 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608926; cv=none; b=Q75BdSbTsqtYw8EUCZatHQvwceF587DlLBHPKgNzGSBOXUOpGeGdE3ueAAAex+9rzuvXCjt/7Jfrr6Vbgk/UIpo7bfVw98+xek7tOS9B1RV2/7qvGuZojZcK9nirckmzf3aOx9R0w2JKw//Vy3a+ApnAQVqYHukNPBTDL0wwnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608926; c=relaxed/simple;
	bh=RyuheOr7KUHRCZ0DHpD522l5GBSjeCB0/rIpoJcMwbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M85OgCfYY8iK839J/HOR4iq6ZJVxBPbMWIDPSYgXgRBicWiA7Wq1T65CSRjwN7zttKYhFyKQzKC33s+VdITfNF/kdx2CVpFrFZltFYUHOfU5jEipb6rHaHraG/zcJCdPWYwvrfdY3HU8tolmpZVALjMD2fbNdkNpf5wabOGgYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDWwv-000000005i7-2paV;
	Mon, 27 Oct 2025 23:48:29 +0000
Date: Mon, 27 Oct 2025 23:48:26 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v3 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Message-ID: <aQAEyn08Q3DCedUU@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <869f4ea37de1c54b35eb92f1b8c55a022d125bd3.1761521845.git.daniel@makrotopia.org>
 <20251027233626.d6vzb45gwcfvvorh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027233626.d6vzb45gwcfvvorh@skbuf>

On Tue, Oct 28, 2025 at 01:36:26AM +0200, Vladimir Oltean wrote:
> On Sun, Oct 26, 2025 at 11:47:21PM +0000, Daniel Golle wrote:
> > Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
> > the RMII reference clock to be a clock output rather than an input if it
> > is set.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > index 60a83093cd10..bf38ecc13f76 100644
> > --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> > @@ -1442,6 +1442,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
> >  		return;
> >  	}
> >  
> > +	if (of_property_read_bool(dp->dn, "maxlinear,rmii-refclk-out") &&
> > +	    !(miicfg & GSWIP_MII_CFG_MODE_RGMII))
> > +		miicfg |= GSWIP_MII_CFG_RMII_CLK;
> > +
> 
> What did you mean with the !(miicfg & GSWIP_MII_CFG_MODE_RGMII) test?
> If the schema says "Only applicable for RMII mode.", what's the purpose
> of this extra condition? For example, GSWIP_MII_CFG_MODE_GMII also has
> the "GSWIP_MII_CFG_MODE_RGMII" bit (0x4) unset. Does this have any significance?

You are right, probably the best would be to test (if at all) that
(miicfg == GSWIP_MII_CFG_MODE_RMIIM || miicfg ==
GSWIP_MII_CFG_MODE_RMIIP) and only in this case allow setting the
GSWIP_MII_CFG_RMII_CLK bit.

I forgot that there is older hardware which supports "full" MII, and MII
MAC as well as MII PHY modes also shouldn't allow to set the
GSWIP_MII_CFG_RMII_CLK bit to not end up with undefined behavior.

