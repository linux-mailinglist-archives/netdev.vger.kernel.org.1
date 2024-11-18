Return-Path: <netdev+bounces-145799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1599D0F60
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E9BB2EE1A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F7199230;
	Mon, 18 Nov 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2QMRM1DI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EE198E9E;
	Mon, 18 Nov 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927055; cv=none; b=EyCp86qQBXkGRbrm+lji1C0hOHZLxiAV9vFG8VHoakiNptdW/Z84zdFaU8xxNTb+PKfjuy2ce5hST+biCdOnAhvf0SX1TZKTcfJDYiIgSOq8i7fOrC9Jpe1l8WpOnph/B56QRZClF/4tr6CMRVGfYRQg88o9KaCTEuRHyIinwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927055; c=relaxed/simple;
	bh=WHcuBnfq6kHAKbfDJXcBfPiEZxhyghgKgTGkb1xpg/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMg0KcyrUl2ATwvcONypVqCgecT5gSQVmj0cMetYcDct12DFctbppNIGZ+Mx0AV8ciPssSGy8+GUEVdqTAYa1f5VyA98REiy9aYHIbQ6j05db4f9iBHhGOZfVO2mnpjBA5NSJtJVKeBl2WxGycjQY7SsnFGk3KRdyXqhsfqoW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2QMRM1DI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731927053; x=1763463053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WHcuBnfq6kHAKbfDJXcBfPiEZxhyghgKgTGkb1xpg/A=;
  b=2QMRM1DIElhNIshC7/I3idPgfU1jdX2m2bo1ySDwSOdOGgXIKz0USFxA
   r8AqU3rvUqav7kUK4gr4Wy4A9lzOGoJXE1dvT88dzepPitXuLUHJ2RdJO
   UnV7YQdJgzF5Qayp2EnYfHSSkR1gdPNNee12zIziXOJ8R8hQzk/0PkPDt
   jeozMDdaO3zyK32t/TkvAcZQL6Tj1tq12USNGyepjJj9dj3w7GYnBvxTU
   PzOUgjdfzrcYWkPJosTKmjx/RxXjFuakQJz9qWcOGebmdKzPIvigR8MyP
   UtBNLxr7IRKhht4GCE7Eh6NtzyUvz2rdfy21aCHAs2gs4+R9dF2qH149A
   Q==;
X-CSE-ConnectionGUID: uRFJ4ooxRyO7bYFqsKsN5w==
X-CSE-MsgGUID: G0gMqKqvRCGGT/jdUE4tjA==
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="34949119"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 03:50:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 03:50:29 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 18 Nov 2024 03:50:25 -0700
Date: Mon, 18 Nov 2024 10:50:25 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <20241118105025.hjtji5cnl75rcrb4@DEN-DL-M70577>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
 <20241114-liquefy-chasing-a85e284f14b9@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241114-liquefy-chasing-a85e284f14b9@spud>

Hi Conor,

> > The lan969x switch device supports two RGMII port interfaces that can be
> > configured for MAC level rx and tx delays.
> > 
> > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > rgmii-rxid or rgmii-txid. Also specify accepted values.
> > 
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  .../bindings/net/microchip,sparx5-switch.yaml        | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > index dedfad526666..a3f2b70c5c77 100644
> > --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > @@ -129,6 +129,26 @@ properties:
> >              minimum: 0
> >              maximum: 383
> >  
> > +        allOf:
> > +          - if:
> > +              properties:
> > +                phy-mode:
> > +                  contains:
> > +                    enum:
> > +                      - rgmii
> > +                      - rgmii-rxid
> > +                      - rgmii-txid
> > +                      - rgmii-id
> > +            then:
> > +              properties:
> > +                rx-internal-delay-ps:
> > +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> > +                tx-internal-delay-ps:
> > +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> 
> Properties should be define at the top level and constrained in the
> if/then parts. Please move the property definitions out, and just leave
> the required: bit here.
> 
> > +              required:
> > +                - rx-internal-delay-ps
> > +                - tx-internal-delay-ps
> 
> You've got no else, so these properties are valid even for !rgmii?
> 
> > +
> >          required:
> >            - reg
> >            - phys
> 
> Additionally, please move the conditional bits below the required
> property list.
> 
> Cheers,
> Conor.

I will be getting rid of the 'required' constraints in v3. What I hear
you say, is that the two {rx,tx}-internal-delay-ps properties (incl.
their enum values) should be moved out of the if/else and to the
top-level - can you confirm this? Is specifying the values
a property can take not considered a constraint?

Thanks,
Daniel

