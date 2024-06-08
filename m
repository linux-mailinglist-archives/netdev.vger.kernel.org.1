Return-Path: <netdev+bounces-102030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7623190124E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFC41C212A8
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628A17966C;
	Sat,  8 Jun 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VOUvEh4w"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0431FBB;
	Sat,  8 Jun 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717860118; cv=none; b=jnlWlWtaHGQfh0S0SjcKzNzoQTlx0Fnx9LujP0fT9yJdyuuxhBKY9t2YhwV5Ny18jSQZofkrFazUXU6qrI/pa8oW8khBGcJSvXtsUSKvaAw5cBKyvpuN9/dF6CoFen5Eg9KhCQ/f9Ehz8DMgjwdrxcR+iAyccvGQcbioT3rUVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717860118; c=relaxed/simple;
	bh=xKq0uZv7KiOKLRYrpZChOTMRtF6MphQYosnp2/2huOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQTa0ozrC49X6fAc3rHyHCX8QhBymMue1uIIUymgC2FexLdft4pbKUP6Ry+suItpVAUT2ptv3znFOvaH7R7v2+ZkJUombzcLsy/k0hHjq+2DXjx+K2qoxxDEjbjQWWkfFgRyvRYOrFTMsvI860PUTdzqvbApsf0jKYCe6OiWuRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VOUvEh4w; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF2AF471;
	Sat,  8 Jun 2024 17:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717860105;
	bh=xKq0uZv7KiOKLRYrpZChOTMRtF6MphQYosnp2/2huOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOUvEh4w+1llZFo92MhZtYmHtpH+Sogq83lkDskbmHy+EskQn7rYFYiGqYDVyrcnw
	 IjyfCYZdM7dXxP1x0cCK7WisiTYPE6a70mmYP2S6752o8ospb771GTSZKWSQkrcy1M
	 PSTrgv2jNUZcCVv/6D7JP6yXMhxm0vK0Hgc0tuh4=
Date: Sat, 8 Jun 2024 18:21:36 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: snps,dwmac: add
 phy-supply support
Message-ID: <20240608152136.GA14446@pendragon.ideasonboard.com>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
 <20230721142433.GA1012219-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721142433.GA1012219-robh@kernel.org>

Hi Rob,

On Fri, Jul 21, 2023 at 08:24:33AM -0600, Rob Herring wrote:
> On Fri, Jul 21, 2023 at 01:03:43PM +0200, Marco Felsch wrote:
> > Document the common phy-supply property to be able to specify a phy
> > regulator.
> 
> What common property? I don't see any such property in 
> ethernet-controller.yaml.
> 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changelog:
> > v4:
> > - no changes
> > v3:
> > - no changes
> > v2
> > - add ack-by
> > 
> >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index ddf9522a5dc23..847ecb82b37ee 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -160,6 +160,9 @@ properties:
> >        can be passive (no SW requirement), and requires that the MAC operate
> >        in a different mode than the PHY in order to function.
> >  
> > +  phy-supply:
> > +    description: PHY regulator
> 
> Is this for an serdes, sgmii, etc. type phy or ethernet phy? Either way, 
> this property belongs in the PHY's node because it is the PHY that has 
> supply connection. I'm guessing you put this here for the latter case 
> because ethernet PHYs on MDIO are "discoverable" except for the small 
> problem that powering them on is not discoverable. 

Any idea on how to solve that problem generically ?

-- 
Regards,

Laurent Pinchart

