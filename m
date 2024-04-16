Return-Path: <netdev+bounces-88501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5528A77C5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406FD1F23923
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48F1E876;
	Tue, 16 Apr 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WJ23m7Vy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3824A19;
	Tue, 16 Apr 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306636; cv=none; b=asdMzQTN90x/vx7MOnF3+C14Q9QEZ9ZzkgxKxZaw5OvH4pbR5ScrIXwV6hOxLyRbbzmA8WavJJzqBPdbBeudiOWOOY5SlZ5AjN8HDDEyqM+N+a4t4m9ljNnddG528s0rlTwf1gFG1dgesHOJgPPJlCU9yx0Tk4J0Ax6GsuM6+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306636; c=relaxed/simple;
	bh=hpJQ6R8bBFDB+O1UiDsrbhv6VEYs1CfHTch5joQEY+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOoPUYKSCS0Qu4lYCTZDOIGMAn2hZlvsEe8PsjmCDo8VMgGkMgfBqxS5bDDdgyRS4si6r/rBNHxtl204wt5x8aefv6pX7RYWg//G6yFJrdIigZbjAJz4JP/b33UPMLozkbOQeRHRk5L0z6/n7PziW0AeVAz1mphkPjq6wM2yOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WJ23m7Vy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S5LM35cm5eVP5fHY4leLEYIdw9MVspW2Puxa1YDTyuE=; b=WJ23m7VyzrK8MsZDczafClNY+A
	Ba+MGErkQ6hckNRE5KZa7mPdLx08t0u2FdnWVeKD3xsSnnyPmsYqztTCtTVF5AquHZJ8Pp5yevGvk
	dl4qC0HOu0gXIsEEqeSFKFRdQ+DpZnnuWDnUu1exSpVDyqyADBOY2s9AgYWLTmFOMLv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwrJt-00DBSE-RD; Wed, 17 Apr 2024 00:30:29 +0200
Date: Wed, 17 Apr 2024 00:30:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
 <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
 <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
 <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
 <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>

> I think we could also do a more rusty solution. For example we could
> have these generic functions for `phy::Device`:
> 
>      fn read_register<R: Register>(&mut self, which: R::Index) -> Result<R::Value>;
>      fn write_register<R: Register>(&mut self, which: R::Index, value: R::Value) -> Result;
> 
> That way we can support many different registers without polluting the
> namespace. We can then have a `C45` register and a `C22` register and a
> `C45OrC22` (maybe we should use `C45_OrC22` instead, since I can read
> that better, but let's bikeshed when we have the actual patch).
> 
> Calling those functions would look like this:
> 
>      let value = dev.read_register::<C45>(reg1)?;
>      dev.write_register::<C45>(reg2, value)?;

I don't know how well that will work out in practice. The addressing
schemes for C22 and C45 are different.

C22 simply has 32 registers, numbered 0-31.

C45 has 32 MDIO manageable devices (MMD) each with 65536 registers.

All of the 32 C22 registers have well defined names, which are listed
in mii.h. Ideally we want to keep the same names. The most of the MMD
also have defined names, listed in mdio.h. Many of the registers are
also named in mdio.h, although vendors do tend to add more vendor
proprietary registers.

Your R::Index would need to be a single value for C22 and a tuple of
two values for C45.

There is nothing like `C45OrC22`. A register is either in C22
namespace, or in the C45 namespace.

Where it gets interesting is that there are two methods to access the
C45 register namespace. The PHY driver should not care about this, it
is the MDIO bus driver and the PHYLIB core which handles the two
access mechanisms.

       Andrew

