Return-Path: <netdev+bounces-57890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E08146B3
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18ECB22589
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE14200AD;
	Fri, 15 Dec 2023 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sqi3fu6w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1D24A03;
	Fri, 15 Dec 2023 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cSkkv/gDOzV7976l7oijQUoiqmu9XDA82nTBbDGDXy8=; b=Sqi3fu6wE10NBK76axcid39OKo
	us+D3GH0/3EVjqrT5V/4E3SL+V38gwbPC8qFagYyy6g1ZheyXYfpOfmhUseIbxSqAWZhzaCY+Ahep
	mbWJnuWAkze4kr3QKRn+GXtsuG0sYttYjQtFhaQ2BOU4tjW2DHT0Lra2FWxPG3kBIYnQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE6EZ-0030vp-7b; Fri, 15 Dec 2023 12:19:59 +0100
Date: Fri, 15 Dec 2023 12:19:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
Message-ID: <74cb1d1c-64b8-4fb0-9e6d-c2fad8417232@lunn.ch>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-5-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-5-tobias@waldekranz.com>

> +        properties:
> +          marvell,polarity:
> +            description: |
> +              Electrical polarity and drive type for this LED. In the
> +              active state, hardware may drive the pin either low or
> +              high. In the inactive state, the pin can either be
> +              driven to the opposite logic level, or be tristated.
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum:
> +              - active-low
> +              - active-high
> +              - active-low-tristate
> +              - active-high-tristate

Christian is working on adding a generic active-low property, which
any PHY LED could use. The assumption being if the bool property is
not present, it defaults to active-high.

So we should consider, how popular are these two tristate values? Is
this a Marvell only thing, or do other PHYs also have them? Do we want
to make them part of the generic PHY led binding? Also, is an enum the
correct representation? Maybe tristate should be another bool
property? Hi/Low and tristate seem to be orthogonal, so maybe two
properties would make it cleaner with respect to generic properties?

Please work with Christian on this.

Thanks
	Andrew

