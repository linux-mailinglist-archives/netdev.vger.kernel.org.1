Return-Path: <netdev+bounces-119021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC1953D90
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749E3B27520
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D025155326;
	Thu, 15 Aug 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p7nnizY2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47023149E15;
	Thu, 15 Aug 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762267; cv=none; b=YyhD/wW06mUl0UrL/RVFw30sJHUCY9gKpPwJVD0HpQvbLRaU/CbsUebiiZGl6hr7a23BVAh9iC9WZBG7WaC5D+TuxZquMFfORfE8tsKpQ1sZ9VJ5GPTjgBd8tFxIH2sxBrOAeQQ7C4L1N3kOGnNCgeQjFFLF/ct/FaT8IyBNtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762267; c=relaxed/simple;
	bh=PvmpBlv3hsYRJhuY2PxPYhLhmPgg0RasVeq2kLnVWKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv+HTcj8P82cLgAmDfKk8sH+wEbNPRJIeuJAQs+JYWQNPepTEKBJhxguCYQUXNjLztrAwR0zxca4/dEHJxk12UZCWBlUmoO3VcT+iWp/LA3bLXUjawN7O8s49k7jhQla27AEJplBsola+0jHOR+oYzwYUnHDhiuy4bgVePT6T/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p7nnizY2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6IxOg8krKUBgNw4iWtqziyP4NQjZk+rsZs4R2j0oOiA=; b=p7nnizY2V4S54Ig+y2NGdxGAYy
	gtcCSk6SyvuH19RW8d8Nz0ppXApzVpB7jBkkh0xIG8lW9UriCtGEEdHgUU2Xh391eY4ww6Jd/w6vb
	WmqIR/zmiMYb2r04v3/guQdqIRnCLTVStfsj1wSHuuxKJF+FebhC7s/6ep6AqBpM/icQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sejIk-004sR9-Kc; Fri, 16 Aug 2024 00:50:38 +0200
Date: Fri, 16 Aug 2024 00:50:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marex@denx.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Message-ID: <445f69fa-5d1f-40a8-b180-4924edb6acea@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
 <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
 <BYAPR11MB355823A969242508B05D7156EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <144ed2fd-f6e4-43a1-99bc-57e6045996da@lunn.ch>
 <BYAPR11MB35584725C73534BC26009F77EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
 <9b960383-6f6c-4a8c-85bb-5ccba96abb01@lunn.ch>
 <MN2PR11MB3566A463C897A7967F4FCB09EC872@MN2PR11MB3566.namprd11.prod.outlook.com>
 <4d4d06e9-c0b4-4b49-a892-11efd07faf9a@lunn.ch>
 <BYAPR11MB355843A853269A3EA5C50D47EC802@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB355843A853269A3EA5C50D47EC802@BYAPR11MB3558.namprd11.prod.outlook.com>

> My KSZ9477 board does not have that I2C connection, so I cannot
> implement the change as suggested.

I would say any board without the I2C bus connected is fatally
broken. Most SFPs are buggy, and don't follow the standard. You need
to read the vendor and product ID so you can enable various quirks to
make them work correctly.

> I am getting a new design board that needs verification of this
> connection.  After I make it work I will re-submit the patch.

O.K, that sounds good.

	Andrew

