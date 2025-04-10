Return-Path: <netdev+bounces-181425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97428A84F15
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B5462A90
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE35290BDB;
	Thu, 10 Apr 2025 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b71vFG8V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB697283699;
	Thu, 10 Apr 2025 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319575; cv=none; b=KGoNBhIEBUQyoe+CazbYgeopzU9ywk9FNn4dPW+BRjGRmqrHDoxaa0CI4NM6wDbnsjz3Cz5eoPAOhEbA7L1baThYaO/6IsdLbABn+5S3CDpsAe0OmMtZpNKAD1e2xJfReqVXNgC6fMfpMxwN+7ursjbEkBrUdWLTtI4gcxSWe5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319575; c=relaxed/simple;
	bh=T/P1P+E6uonJ66xjSWFrnWdtSTsghWdTneLNPuBwQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlowKPHlEOQGLL0Yr1xPrNtkh24OdWPgcFDgWZWBtFY/lycqKECqCMq8TbuqYio6BZ/lzTM0qWVqlNc8DkNXojeQWG54jMFJwKaSXcfb57Xyqy++kii4Nf9WM+qdO4lIpuiznmBcE7U0cPIpvPwvi6ftosPFxyuRh4VMSW/UG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b71vFG8V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rNczozpcMMZxD6eTya8/M09asYvM0i0dZVM4tXgpxfI=; b=b71vFG8VCjoEOC9kmtRiAM4CGT
	K6kl1UNoulWweks05cqAieZhnfkkcdnD4yFBbpbnd0MBb6iEmajn66P/0Gc78Kc+JwKqukGfJoOB9
	K32KsGy4iB5xvor3+A4L7xLVRk6UJKBAuuM9MaIHpz6gD5s0cUKqLBpfvfArGlTIbouI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2zCT-008jJx-3t; Thu, 10 Apr 2025 23:12:41 +0200
Date: Thu, 10 Apr 2025 23:12:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh.Satish@microchip.com, conor@kernel.org, krzk@kernel.org,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com, jiri@resnulli.us, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
	kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org,
	mschmidt@redhat.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Message-ID: <4e331736-36f2-4796-945f-613279329585@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
 <bd7d005b-c715-4fd9-9b0d-52956d28d272@lunn.ch>
 <7ab19530-d0d4-4df1-9f75-060c3055585b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab19530-d0d4-4df1-9f75-060c3055585b@redhat.com>

On Thu, Apr 10, 2025 at 08:33:31PM +0200, Ivan Vecera wrote:
> 
> 
> On 10. 04. 25 7:36 odp., Andrew Lunn wrote:
> > > Prathosh, could you please bring more light on this?
> > > 
> > > > Just to clarify, the original driver was written specifically with 2-channel
> > > > chips in mind (ZL30732) with 10 input and 20 outputs, which led to some confusion of using zl3073x as compatible.
> > > > However, the final version of the driver will support the entire ZL3073x family
> > > > ZL30731 to ZL30735 and some subset of ZL30732 like ZL80732 etc
> > > > ensuring compatibility across all variants.
> > 
> > Hi Prathosh
> > 
> > Your email quoting is very odd, i nearly missed this reply.
> > 
> > Does the device itself have an ID register? If you know you have
> > something in the range ZL30731 to ZL30735, you can ask the hardware
> > what it is, and the driver then does not need any additional
> > information from DT, it can hard code it all based on the ID in the
> > register?
> > 
> > 	Andrew
> > 
> Hi Andrew,
> yes there is ID register that identifies the ID. But what compatible should
> be used?
> 
> microchip,zl3073x was rejected as wildcard and we should use all
> compatibles.

You have two choices really:

1) You list each device with its own compatible, because they are in
fact not compatible. You need to handle each one different, they have
different DT properties, etc. If you do that, please validate the ID
register against the compatible and return -ENODEV if they don't
match.

2) You say the devices are compatible. So the DT compatible just
indicates the family, enough information for the driver to go find the
ID register. This does however require the binding is the same for all
devices. You cannot have one family member listing 10 inputs in its
binding, and another family member listing 20.

If you say your devices are incompatible, and list lots of
compatibles, you can then use constraints in the yaml, based on the
compatible, to limit each family member to what it supports.

My guess is, you are going to take the first route.

	Andrew

