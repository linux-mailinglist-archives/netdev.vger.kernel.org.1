Return-Path: <netdev+bounces-37483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6127B58B1
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 79142282C02
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CBD1DDFB;
	Mon,  2 Oct 2023 17:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06061A73C;
	Mon,  2 Oct 2023 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21855C433C7;
	Mon,  2 Oct 2023 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696267211;
	bh=SLgvctAoGEpa0Dcyn2+NQ5w/1PZ3Zu/4iXSrOVqEPCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnDzPwntJSzRxoK+QbW0s2Oo3Mrul/EyxvpchFeubFgW8ihyytBxTiqRDMhntzNGX
	 fvGN1EcFvonBwEORXT6RpZR3RoczTVwYmHEdLdmy0MNerqDxXZPHfseB/vjCAPmHJI
	 Asg3y5/ftypnvJ80OB3drCP4pZe2XMkCz3017NuSCBxXUoXINvhhkJEDFfszc38qf0
	 4xLja3cdx84i9zdaznQZsDBY5x+rnKmHokyEDfIrSydyzUPmx84oaLdBFjWNgxDJDB
	 qJof9G0qAE/VJeegTs61SLsbQm5qUn2ZmgaYgzD3/5zxdWWAuJA+hyxYZxvAIaEo0H
	 Es52BPm5mH/mQ==
Date: Mon, 2 Oct 2023 19:20:05 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 03/15] phy: ethernet: add configuration
 interface for copper backplane Ethernet PHYs
Message-ID: <20231002172005.GC92317@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-4-vladimir.oltean@nxp.com>
 <20230928190536.GO24230@kernel.org>
 <20231002131110.4kjkinc2xyxtdwbv@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002131110.4kjkinc2xyxtdwbv@skbuf>

On Mon, Oct 02, 2023 at 04:11:10PM +0300, Vladimir Oltean wrote:
> Hi Simon,
> 
> On Thu, Sep 28, 2023 at 09:05:36PM +0200, Simon Horman wrote:
> > On Sat, Sep 23, 2023 at 04:48:52PM +0300, Vladimir Oltean wrote:
> > 
> > ...
> > 
> > > +/**
> > > + * coef_update_opposite - return the opposite of one C72 coefficient update
> > > + *			  request
> > > + *
> > > + * @update:	original coefficient update
> > > + *
> > > + * Helper to transform the update request of one equalization tap into a
> > > + * request of the same tap in the opposite direction. May be used by C72
> > > + * phy remote TX link training algorithms.
> > > + */
> > > +static inline enum coef_update coef_update_opposite(enum coef_update update)
> > 
> > Hi Vladimir,
> > 
> > another nit from me.
> > 
> > Please put the inline keyword first.
> > Likewise elsewhere in this patch.
> > 
> > Tooling, including gcc-13 with W=1, complains about this.
> 
> Thanks for pointing this out. I guess you are talking about the c72_coef_update_print()
> function, whose prototype is mistakenly "static void inline" instead of
> "static inline void". I cannot find the problem with the quoted coef_update_opposite().

Yes, you are right.
Sorry for my error.


