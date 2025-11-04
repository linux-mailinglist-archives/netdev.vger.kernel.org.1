Return-Path: <netdev+bounces-235483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87AC314D5
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B842188C4C4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AEF329382;
	Tue,  4 Nov 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0fVMoEM2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0728320CC0;
	Tue,  4 Nov 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264275; cv=none; b=Pq9CYDeOI0IyuZnb9o0+EWJTnWq2/F3QtHhr/KskPx4GZjQEioAfM0e3w7LSQH6sBrzCpIPqUVsKbwhYzW+YSN96BYkWT3JWcc2Kmu4VpCqJqxnqpH3+g5Hnrm13AqtoDxv5yCEf/qZyy4NGK83FRsJGif5kyZiqF1mLA3AQwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264275; c=relaxed/simple;
	bh=UleVrmIf9d4LmG9t4pOtckRWR/ru/nPW86Ac3auMedk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTSbXb/wAPn6uQrMa1bjNQ31Opi4rA1POeP8JneQHEDOyouQ0mGMGnAb/II0GJP7F9jkbqRLfi4WuCGUjBy3C8Fl4spR4w4iplA1ZkjGMjSP3N2Z2tGyOwWhLDw7Wk57J2rXwmOI96W2DsAwnlzTXNujH/0D6KM5zk4qsgHUM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0fVMoEM2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1RoProTG9PzhyYdQtnEke6X8DcnYXk+jaxvxgzqlOOM=; b=0fVMoEM2YIUsV39yO4/4GFCh1C
	W4SVgioyHTwO+McaUh/604S2HDExj5aRUIq2NI6OU8B1J79LrMxGrh49mMr5DR6Nb+qT7RaGc6gLl
	iuzuYrhb0OSwO6VXHp76u6bRwdoKoiAnDZe9JjVQ/aok5ME/MUIPVXT/AZvq/+R8su7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGHQy-00CtNF-Ri; Tue, 04 Nov 2025 14:50:52 +0100
Date: Tue, 4 Nov 2025 14:50:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?=
 =?utf-8?Q?xt_v3_1=2F4=5D_dt-bindings?= =?utf-8?Q?=3A?= net: ftgmac100: Add
 delay properties for AST2600
Message-ID: <eaff1dbb-b836-42b1-a9f0-715698bd0a6f@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <cf5a3144-7b5e-479b-bfd8-3447f5f567ab@lunn.ch>
 <SEYPR06MB5134396D2CD9BD7EE47137F09DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134396D2CD9BD7EE47137F09DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 04, 2025 at 05:22:59AM +0000, Jacky Chou wrote:
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > index d14410018bcf..de646e7e3bca 100644
> > > --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > @@ -19,6 +19,12 @@ properties:
> > >                - aspeed,ast2500-mac
> > >                - aspeed,ast2600-mac
> > 
> > I don't know if it is possible, but it would be good to mark aspeed,ast2600-mac
> > as deprecated.
> > 
> > I also think some comments would be good, explaining how
> > aspeed,ast2600-mac01 and aspeed,ast2600-mac23 differ from
> > aspeed,ast2600-mac, and why you should use them.
> > 
> 
> Thanks for the suggestion.
> We keep "aspeed,ast2600-mac" in the compatible list mainly for backward compatibility.
> There are already many existing device trees and systems using this string.
> Removing or deprecating it right now might break those setups.

I'm not saying remove it. I'm just saying mark it as deprecated. For
properties you add an extra attribute, e.g.

https://elixir.bootlin.com/linux/v6.17.7/source/Documentation/devicetree/bindings/net/snps,dwmac.yaml#L433

but for a compatible, i've no idea if YAML supports it. However,
snps,dwmac.yam actually places st,spear600-gmac at the end of the list
after a comment. Maybe that is the best way to do this, and in the
comment you can explain what it gets wrong and why you should not use
it.

> In the future, if someone submits a new DTS for an AST2600-based platform,
> I think they should add the new compatible string and properly describe the TX/RX delay and 
> phy-mode properties in their DTS.

Yes, i agree. It would be good if you can keep on out of for such
patches, and make review comments. I assume you will also update the
vendor documentation with this recommendation.

	Andrew

