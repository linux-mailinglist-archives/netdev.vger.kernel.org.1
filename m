Return-Path: <netdev+bounces-210921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F06B15798
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 04:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B90118A00C6
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D71BD035;
	Wed, 30 Jul 2025 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AgwMK+2x"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8E288A2;
	Wed, 30 Jul 2025 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843051; cv=none; b=Lh8rjaNhE/q7TWmxS4kzi9yXc4yfC4hU2V1bJlHHCgEqgIE+fk6MRvqgQ5kcgp+cjYFzOU48fvfI97ruxkePK/xKqEMGmy2psAhYfe6aWzJGAtH949h9lIeGEWWx5+8Vck6mzTXCs1iwREc4ismegAAj9/cMa6O7Fdaj9J4DEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843051; c=relaxed/simple;
	bh=r6EJUgnKNkBU/gY2vKM1Kph1PWJOeN4y03H/SRXg+vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkbXCn1wiWPp+stLbtOkhrxtpp4Itsvi0Aoe6n/GAAvJ4rjS1QRTONcBfh/nqMnGAINbqUNddm69yisBQqVWnu0ukJKlzAVHeG1/uIw/5BwP2stDLPoEViRdvpYkTr+L48OO/J71wPxgpQQTcBtiAGkk1CvPdTk8dvLhgA6pJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AgwMK+2x; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 079EC20F9E;
	Wed, 30 Jul 2025 04:37:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jRGBdc8Sp0M; Wed, 30 Jul 2025 04:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753843045; bh=r6EJUgnKNkBU/gY2vKM1Kph1PWJOeN4y03H/SRXg+vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AgwMK+2xLh/uRypIC/UB7RAXvQhhzpfFuUw3sFrlic/janHA/4c574mpUHzuP2h+r
	 GNL2CupOEq6B5gdiZV45oHIDI15qtrPbsHYqpwM+J7ZmXSRWqNxJGO71PZTccZ32gv
	 f9t8yDb2AjhhPWT1+2Edh/9S4pP4zsJ9FmYGq/WgRPGHSR/Cr4mlHMxgoOGaM65pSL
	 4SJ7xThP+4fULiS0c/geMdiST2UWrUW5oJXk/kIwZL3f7tZtQApxwNbspRarsfTCT3
	 Sbgzjq328tWP01hPwQEwMF4PU96Rc4IqwCcCbOt9qEoBmyfu/21MlpHaCTnDYEwpF4
	 EfrzKAF4mIMiw==
Date: Wed, 30 Jul 2025 02:37:09 +0000
From: Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <aImFVW1Pl_QHijWx@pie>
References: <20250729093734.40132-1-ziyao@disroot.org>
 <20250729093734.40132-2-ziyao@disroot.org>
 <20250729-canal-stimuli-492b4550108c@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-canal-stimuli-492b4550108c@spud>

On Tue, Jul 29, 2025 at 06:43:42PM +0100, Conor Dooley wrote:
> On Tue, Jul 29, 2025 at 09:37:32AM +0000, Yao Zi wrote:
> > Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> > requires one more clock for configuring APB glue registers. Describe
> > it in the binding.
> > 
> > Though the clock is essential for operation, it's not marked as required
> > for now to avoid introducing new dt-binding warnings to existing dts.
> 
> Nah, introduce the warnings. If the clock is required for operation, it
> should be marked as such. You've made it optional in the driver, which
> is the important part (backwards compatible) and you've got the dts
> patch in the series.

Thanks for the confirmation, will remove minItems in v2.

Regards,
Yao Zi

> > 
> > Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  .../devicetree/bindings/net/thead,th1520-gmac.yaml        | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> > index 6d9de3303762..fea9fbc1d006 100644
> > --- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> > @@ -59,14 +59,18 @@ properties:
> >        - const: apb
> >  
> >    clocks:
> > +    minItems: 2
> >      items:
> >        - description: GMAC main clock
> >        - description: Peripheral registers interface clock
> > +      - description: APB glue registers interface clock
> >  
> >    clock-names:
> > +    minItems: 2
> >      items:
> >        - const: stmmaceth
> >        - const: pclk
> > +      - const: apb
> >  
> >    interrupts:
> >      items:
> > @@ -88,8 +92,8 @@ examples:
> >          compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> >          reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
> >          reg-names = "dwmac", "apb";
> > -        clocks = <&clk 1>, <&clk 2>;
> > -        clock-names = "stmmaceth", "pclk";
> > +        clocks = <&clk 1>, <&clk 2>, <&clk 3>;
> > +        clock-names = "stmmaceth", "pclk", "apb";
> >          interrupts = <66>;
> >          interrupt-names = "macirq";
> >          phy-mode = "rgmii-id";
> > -- 
> > 2.50.1
> > 



