Return-Path: <netdev+bounces-235482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1243C31475
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18E834F5A72
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68ED329E63;
	Tue,  4 Nov 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y6KWc+d1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B6329C77;
	Tue,  4 Nov 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263658; cv=none; b=UNHhL5O7Pqvf12aYwpdYH7GnXtlB8LYQ2jm9NPl81c2P/KK5s63rwefEqnZIgO95aVvEdjYuQeDLZl8SDUmYpNq6D6CtBwGOXsYyS2qIoLgSar9pKTXMx/waSYF9xXnS9JIVvqOHEZVfWBan1Jo48rH6Hqt8+cPMUdNbAAFdHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263658; c=relaxed/simple;
	bh=Yea/HT+J2OHaca452b+DTIDzilJxwaBdIH+TZEG/lYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odfbS6LmPX1sUDNXVD6+oL7w8apBopaW5Ha2iY7Pb6V/Hm5gyer5d36oBWlRHgJxbuFhReLp+6tvPo4RR3FJ34u3K2QIv2aB4MZX39PK1aMTRRVlPPFcktay45Fq08NPljf1QU5uOPyDLVCEL2S+bVu3H0ko/Adt5yrPACXAFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y6KWc+d1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ITCLqcPKdtMfzHDn3f1hMx+q58ZaP4E+ZYDldEc3toE=; b=y6KWc+d1T0EMoGe0Uz8xFsN4wG
	Hlk1wADkucu+s+tHZWPnOVCGTF2eItOAjrhVLD3QdPb5iAThErckAfFf4rZJdIe3i26+IzHZy7IiV
	wGBMJUlRL0FiD9UZoZfhBArAmMCJDIV71TCE6UEZVmbXZMAVSw2X6IEm0YKhLRidusVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGHGu-00CtIS-V1; Tue, 04 Nov 2025 14:40:28 +0100
Date: Tue, 4 Nov 2025 14:40:28 +0100
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
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <d7b08607-73a3-4f6b-ab8b-3eb4ff8b8647@lunn.ch>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <2424e7e9-8eef-43f4-88aa-054413ca63fe@lunn.ch>
 <SEYPR06MB5134AB242733717317AAEDEA9DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134AB242733717317AAEDEA9DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Nov 04, 2025 at 05:14:41AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: aspeed,ast2600-mac01
> > > +    then:
> > > +      properties:
> > > +        rx-internal-delay-ps:
> > > +          minimum: 0
> > > +          maximum: 1395
> > > +          multipleOf: 45
> > 
> > I would add a default: 0
> > 
> 
> Agreed.
> I will add it in next version.
> 
> > > +        tx-internal-delay-ps:
> > > +          minimum: 0
> > > +          maximum: 1395
> > > +          multipleOf: 45
> > 
> > and also here.
> > 
> 
> Agreed.
> 
> > > +      required:
> > > +        - scu
> > > +        - rx-internal-delay-ps
> > > +        - tx-internal-delay-ps
> > 
> > and then these are not required, but optional.
> > 
> 
> Configure the tx/rx delay in the scu register.
> At least, the scu handle must be required.

Sorry, i was unclear. By says 'and then', i was trying to chain it to
the previous comment, that the delays should default to 0. With
defaults set, rx-internal-delay-ps and tx-internal-delay-ps become
optional. I agree scu is required.

> Here I have one question.
> In v3 patches series, if the ftgmac driver cannot find one of 
> tx-internal-delay-ps and rx-internal-delay-ps, it will return error in probe 
> stage.
> If here is optional, does it means that just add warning and not return error when
> lack one of them and use the default to configure? Or not configure tx/rx delay just
> return success in probe stage?

Once you add the default statement, it is clear what delay should be
added if they property is not listed, 0. No warning is needed.

What you should find in the end is that most boards just set the new
compatible and 'rgmii-id', and need nothing else. Only badly designed
boards tend to need tx-internal-delay-ps and rx-internal-delay-ps.

	Andrew

