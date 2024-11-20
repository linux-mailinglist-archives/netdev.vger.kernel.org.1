Return-Path: <netdev+bounces-146462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA59D38C4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7AF1F24D24
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDA19ABD1;
	Wed, 20 Nov 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KRUd8/pV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5333C5;
	Wed, 20 Nov 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100046; cv=none; b=QaA++U8yIe/MxbeY8sYK4kFCi1SS5SWmOjBdWEL5wy3+jHiKjk2ou4psA/POn8KClvcWUWEXia/1JFGROQwJ3HueQB3I62GBLcIsK1qyfL+oXso2Bw7tG9Jx9tl90jzYvTZ/AbjqPXp+5ra/M9BBtmGXe7G/g+pJAJOY6HSRkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100046; c=relaxed/simple;
	bh=YRTIDN51JL/cogJ/vUoE/+DQZzQcXO8SLlktLuDSSOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg4PRWvW4BIDVJy2h1eBTpjfIzGQGl35HhvsfA4Z8G9wzf7EFhnQv93vd0ze85vUXhyY4wheNQ2V3y9vnO9+HNFDLtRZ06cwirqF3bl1cH1ncemlsDiHckRzcHEIAAihwobgkQV/cXLuFUzeWs+fNC6I06FDbLELkKlIWDnU/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KRUd8/pV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732100045; x=1763636045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YRTIDN51JL/cogJ/vUoE/+DQZzQcXO8SLlktLuDSSOQ=;
  b=KRUd8/pVhxLJsMFfa48si6TSwTWfH0cu8R60A0ll2xG2dokCYUXBMC4J
   RHm+VBFJGeW/5TjnNw+xIoMX8wn0Vp2GeFtpfnq5gefIkvHYkjvA9SjWf
   pwgI5EK2tjFWKpQWLCsbEZZlO0A3Xl+CnC03jba055ynL0W2tP9PbQvsi
   2tkD6Se5AeShs5mMHoee0LnyXqHUcCWPNv3N0OegLQXx5IJb+cukOaYqn
   oGgbQOwcfwK/RGMIPgsOK9ymOl2Jx1DuRk0PcvMdF7yWcZ2XHtvSbsjNf
   jwq2NGGu3o69UxqhoWmzpNf4BLNCfHzgkdu942YcvE2qe5IM/LSwlBC7P
   g==;
X-CSE-ConnectionGUID: l6dfGwaoTuOG0Dm/0vQtQA==
X-CSE-MsgGUID: 3fEx3WBgQ26eSFJw4tYAgg==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="265717867"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 03:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 03:53:40 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Nov 2024 03:53:37 -0700
Date: Wed, 20 Nov 2024 10:53:36 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 8/8] dt-bindings: net: sparx5: document RGMII
 delays
Message-ID: <20241120105336.3wheaindiv5q3uvj@DEN-DL-M70577>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
 <20241118-sparx5-lan969x-switch-driver-4-v3-8-3cefee5e7e3a@microchip.com>
 <20241119182255.GA1967508-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119182255.GA1967508-robh@kernel.org>

Hi Rob,

> > The lan969x switch device supports two RGMII port interfaces that can be
> > configured for MAC level rx and tx delays.
> >
> > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > rgmii-rxid or rgmii-txid. Also specify accepted values.
> 
> Doesn't look like they are required to me.

Commit description needs updating. Thanks for catching this!

> 
> >
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > index dedfad526666..2e9ef0f7bb4b 100644
> > --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
> > @@ -129,6 +129,24 @@ properties:
> >              minimum: 0
> >              maximum: 383
> >
> > +          rx-internal-delay-ps:
> > +            description: |
> 
> Don't need '|' if there is not formatting to preserve.

Ack.

> 
> > +              RGMII Receive Clock Delay defined in pico seconds, used to select
> > +              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
> > +              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
> > +              any delay. The Default is no delay.
> > +            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> > +            default: 0
> > +
> > +          tx-internal-delay-ps:
> > +            description: |
> > +              RGMII Transmit Clock Delay defined in pico seconds, used to select
> > +              the DLL phase shift between 1000 ps (45 degree shift at 1Gbps) and
> > +              3300 ps (147 degree shift at 1Gbps). A value of 0 ps will disable
> > +              any delay. The Default is no delay.
> > +            enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> > +            default: 0
> > +
> >          required:
> >            - reg
> >            - phys
> >
> > --
> > 2.34.1
> >

/Daniel

