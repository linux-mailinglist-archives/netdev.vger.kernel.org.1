Return-Path: <netdev+bounces-234559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E0C22F2F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3A0234C5E8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8C26ED54;
	Fri, 31 Oct 2025 02:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFAC26ED3D;
	Fri, 31 Oct 2025 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876763; cv=none; b=JLmsfYvK9cMXMPgDwamzVrhMLrbJBxlWUqUZYk5MDCmW0iMzKo0F4VGAEOMvXB0QGVFc4M74U8QgXX17h1FJKS3GhyNoptk/qUpQ9GNyYCZjAQfnUQRjeS2CK1fRsc2LSobWMJ/owdRyEkUs3QRwriv/GIFSN7OsX4rnMB6VA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876763; c=relaxed/simple;
	bh=ZBwZjWI7wSXLqWL/Ncs2woEyY8gobs3k9L6OvTEd0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACdqb1n8EoGLkXnnjF+T7nj9V79rF6bssbF4IjE2ws/AoNj4p0fAG6WljxS8zwpozA9MRe2oFZTDl+d1SxCr1peN5uLxG2d9jSknjrQ5ujjXc7YtiQ9IDoL96L/S8jI5eQ19oEW9JrJe6yW8P+3/ytw1DXoFZc61wKySO28LAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEecx-000000000zr-3oCY;
	Fri, 31 Oct 2025 02:12:32 +0000
Date: Fri, 31 Oct 2025 02:12:26 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next v5 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <aQQbCs-zn4PfrS71@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <8025f8c5fcc31adf6c82f78e5cfaf75b0f89397c.1761823194.git.daniel@makrotopia.org>
 <20251031002924.GA516142-robh@kernel.org>
 <20251031003704.GA533574-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031003704.GA533574-robh@kernel.org>

On Thu, Oct 30, 2025 at 07:37:04PM -0500, Rob Herring wrote:
> On Thu, Oct 30, 2025 at 07:29:24PM -0500, Rob Herring wrote:
> > On Thu, Oct 30, 2025 at 11:28:35AM +0000, Daniel Golle wrote:
> > > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > > 
> > > The GSWIP switch hardware supports delay values in 500 picosecond
> > > increments from 0 to 3500 picoseconds, with a post-reset default of 2000
> > > picoseconds for both TX and RX delays. The driver currently sets the
> > > delay to 0 in case the PHY is setup to carry out the delay by the
> > > corresponding interface modes ("rgmii-id", "rgmii-rxid", "rgmii-txid").
> > > 
> > > This corresponds to the driver changes that allow adjusting MII delays
> > > using Device Tree properties instead of relying solely on the PHY
> > > interface mode.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > > v4:
> > >  * remove misleading defaults
> > > 
> > > v3:
> > >  * redefine ports node so properties are defined actually apply
> > >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > > 
> > >  .../bindings/net/dsa/lantiq,gswip.yaml        | 31 +++++++++++++++++--
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > index f3154b19af78..8ccbc8942eb3 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > @@ -6,8 +6,31 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  
> > >  title: Lantiq GSWIP Ethernet switches
> > >  
> > > -allOf:
> > > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> > 
> > I think you can keep this as you aren't adding custom properties.
> 
> Nevermind, I see the next patch now...

I suppose you mean [08/12] ("dt-bindings: net: dsa: lantiq,gswip: add
MaxLinear RMII refclk output property"), right?

The intention to divert from dsa.yaml#/$defs/ethernet-ports
already in this patch was to enforce the possible values of
{rx,tx}-internal-delay-ps.

Anyway, so you are saying I can keep the change in this patch? Or
should I just drop the constraints on the possible values of the
delays and only divert from dsa.yaml#/$defs/ethernet-ports once I'm
actually adding maxlinear,rmii-refclk-out?

