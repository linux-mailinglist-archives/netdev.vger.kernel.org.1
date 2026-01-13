Return-Path: <netdev+bounces-249531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73667D1A831
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E77F300EF57
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24934EEF8;
	Tue, 13 Jan 2026 16:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CE2D47E1;
	Tue, 13 Jan 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323575; cv=none; b=YdVM/SHyoPZybiAMplQuYf6+jJ9lQZWeM62FWpSRqTZ3FY6Onysgv6TA00ZlMrms5woBGtq3O8BRqmQ8ZbLmaSlzxyHpSMIuEO2dnfJTfRIFtfDAD0RzjX50UMtsZP/1C1xFjhTIJaVVHqONHFmdlFeQB0vCqcXKKujFJgjCB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323575; c=relaxed/simple;
	bh=bZTOOZGcxrsTtzmbLUUcF2m1Kd5vKqsNeN4gY8o6OA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOciXsiRbsBs6wdlGo1Vb3nh2A1JJ752HTUrGFcfOoQ6+NrlaoBYXctq8rNsNkwiIaqcQtPdVQ5v95q3SNLVFTXL5I/BOJhpelRap+qnfxMdzwhjSV94/DFmxbFAWddyhSW94CdJdqgXvnXD//+mykcOpUjlaZyIg5ejFGZqRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfhjt-000000005MK-0bbL;
	Tue, 13 Jan 2026 16:59:29 +0000
Date: Tue, 13 Jan 2026 16:59:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <aWZ57fz3EiwuXh6Y@makrotopia.org>
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
 <20260107090019.2257867-2-alexander.sverdlin@siemens.com>
 <20260113164128.GA3919887-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164128.GA3919887-robh@kernel.org>

On Tue, Jan 13, 2026 at 10:41:28AM -0600, Rob Herring wrote:
> On Wed, Jan 07, 2026 at 10:00:16AM +0100, A. Sverdlin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > 
> > Add new maxlinear,slew-rate-txc and maxlinear,slew-rate-txd uint32
> > properties. The properties are only applicable for ports in R(G)MII mode
> > and allow for slew rate reduction in comparison to "normal" default
> > configuration with the purpose to reduce radiated emissions.
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > ---
> > Changelog:
> > v4:
> > - separate properties for TXD and TXC pads ("maxlinear," prefix re-appears)
> > v3:
> > - use [pinctrl] standard "slew-rate" property as suggested by Rob
> >   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
> > v2:
> > - unchanged
> > 
> >  .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > index 205b683849a53..747106810cc17 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > @@ -106,6 +106,20 @@ patternProperties:
> >          unevaluatedProperties: false
> >  
> >          properties:
> > +          maxlinear,slew-rate-txc:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1]
> 
> default: 0

Not really. The default is not to touch the register value which may
have already been setup by the bootloader.

> 
> > +            description: |
> > +              RMII/RGMII TX Clock Slew Rate:
> 
> blank line
> > +              0: "Normal"
> > +              1: "Slow"
> 
> Indent lists by 2 more spaces. Drop the quotes.
> 
> > +          maxlinear,slew-rate-txd:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1]
> > +            description: |
> > +              RMII/RGMII TX Non-Clock PAD Slew Rate:
> > +              0: "Normal"
> > +              1: "Slow"
> >            maxlinear,rmii-refclk-out:
> >              type: boolean
> >              description:
> > -- 
> > 2.52.0
> > 

