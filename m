Return-Path: <netdev+bounces-175741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB11A67594
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7306817CADE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056720D4EF;
	Tue, 18 Mar 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fQLghR0h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6F1527B4;
	Tue, 18 Mar 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305930; cv=none; b=sa/DX7zaXmgOcUJVIGOb4QAyv3BZvupmkJeXo+QUKXfmmB7nPu/s8Yq8eQH9KYk+NwI8wZtACvB3t2NTwN3tvH3qFQPp75QLTaOrGva9NAS2WA/HCjcmONXWMTyFixBYoTqWI+b5Y94bAN7dvcuRwkESVdJ1vXM1nYVjJd408Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305930; c=relaxed/simple;
	bh=BdZuqcKVZUWKBqTjrSQa8DWCiLva61FCfkCCASNQebo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7X093zncU0Hb/eBWtDTO4nEn13a31+4rng+z059GTVbapxlvOArkznCiLwH3HRDukXFrBwTlR4Pnqf7vsOyzLG6rBg23hGZR4GmUClTRwDKQ6n/W85w9rS4OGrB4Z5QOnItH1vxoLTqGvNUzIWGAUhMbf403bPxQ3Xv9FwbJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fQLghR0h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n26jTGw7a6IhILTyNcvgMrK+JzqQ4j06C8HKLqJCV74=; b=fQLghR0hnNj09MYO1OaK/dfY6v
	ylVyfUE/zF0CnFLmbUo9xYGBNcXicjT40z9zwR4JF9C4nynTcfi8NPoCw57QcHCRhbV2S4grPzd01
	FVZmMGl3btj03Ymp0Wrg1ggotEGAwBnCJDHro067VRhx9kd2Mgx2Cmg4NDzXbi9/QDr8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuXMG-006GWG-39; Tue, 18 Mar 2025 14:51:52 +0100
Date: Tue, 18 Mar 2025 14:51:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY=?= =?utf-8?Q?=3A?= [net-next 4/4]
 net: ftgmac100: add RGMII delay for AST2600
Message-ID: <5b448c6b-a37d-4028-a56d-2953fc0e743a@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
 <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134C8128FCF57D37F38CEFF9DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Mar 18, 2025 at 05:34:08AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for your reply.
> 
> > > The RGMII delay of AST2600 has a lot of steps can be configured.
> > 
> > Are they uniformly space? Then it should be a simple formula to calculate? Or
> > a lookup table?
> 
> There are fixed delay values by step. I list below.
> AST2600 MAC0/1 one step delay = 45 ps
> AST2600 MAC2/3 one step delay = 250 ps

That is messy.

> I calculate all step and emulate them.
> The dt-binding will be like below.
> rx-internal-delay-ps:
>     description:
>       Setting this property to a non-zero number sets the RX internal delay
>       for the MAC. ... skip ...
>     enum:
>       [45, 90, 135, 180, 225, 250, 270, 315, 360, 405, 450, 495, 500, 540, 585, 630, 675, 
>        720, 750, 765, 810, 855, 900, 945, 990, 1000, 1035, 1080, 1125, 1170, 1215, 1250, 
>        1260, 1305, 1350, 1395, 1440, 1500, 1750, 2000, 2250, 2500, 2750, 3000, 3250, 3500, 
>        3750, 4000, 4250, 4500, 4750, 5000, 5250, 5500, 5750, 6000, 6250, 6500, 6750, 7000, 
>        7250, 7500, 7750, 8000]

Can the hardware do 0 ps?

So this list is a superset of both 45ps and 250ps steps?

Lets see what the DT Maintainers say, but it could be you need two
different compatibles for mac0/1 to mac2/3 because they are not
actually compatible! You can then have a list per compatible.

	Andrew

