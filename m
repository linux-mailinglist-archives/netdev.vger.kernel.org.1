Return-Path: <netdev+bounces-88325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11F8A6B3C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E5C1F21621
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1C5B682;
	Tue, 16 Apr 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A3EmeitC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0741C76;
	Tue, 16 Apr 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271096; cv=none; b=V9rdnjctWpPGDQNNxduJ444y7/72wobJ7f2twcSEMFA7HWEx4R6JUzn+nxCSbR8XkytQeVbErTUdBjKaTD0jatbYsVN23AQCh6vRDys1OHBO0m92GjhQIv46bwv24lny4fiflBV0glJWtowFnQu+ZntDRk2g9AVXJQFdqaWAaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271096; c=relaxed/simple;
	bh=WR+teDh3Y/vyQl9w9sj78EP+soKBCsqUlGifgTOzjrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6K8vITTdyHBbsaS5pakI2QzrCK889vV05V3a1j9yf5BsfDvhX88WFDsEkApZvcjwHclfHtMC1RxIxQRmtCMK6waJGwrErrt//dPRRKme5VnY66o3/yxXEWfNMSGIR8kg1sooal2CWRJeEI56TWI7jh/0PTgPec/BGLHnzzp4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A3EmeitC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y52FjE6AcbCrRQiPpnoR7jIgNDrTM9Q7iVrh+4x3zbU=; b=A3EmeitCc7OYaNK2JTkvtBqNsC
	b73PC+MYWTcJW7DCDECMChK4qzTU6EBaCzATBWQKOgrJaUlpO65d0r/vt8grPMuXka+z5K3tHx+o3
	zGKgARbMzK4ip8IlLux1q8xmvs1+mLTGMwLLHuHN+qqFLwsK1w27vvSes6WTyjJWSS0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwi4h-00D8PU-DA; Tue, 16 Apr 2024 14:38:11 +0200
Date: Tue, 16 Apr 2024 14:38:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-3-fujita.tomonori@gmail.com>
 <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
 <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>

> > In summary, the C API is a bit of a mess.
> > 
> > For the Rust API we have two sensible choices:
> > 
> > 1) It is the same mess as the C API, so hopefully one day we will fix
> >    both at the same time.
> > 
> > 2) We define a different API which correctly separate C45 bus access
> >    from C45 registers.
> > 
> > How you currently defined the Rust API is neither of these.
> 
> Which do your prefer?
> 
> If I correctly understand the original driver code, C45 bus protocol
> is used. Adding functions for C45 bus protocol read/write would be
> enough for this driver, I guess.

Now i've read more of the patches, i can see that the MDIO bus master
is C45 only. At least, that is all that is implemented in the
driver. So for this combination of MAC and PHY, forcing C45 register
access using C45 bus protocol will work.

However, can you combine this PHY with some other MDIO bus master,
which does not support C45? Then C45 over C22 would need to be used?
Looking at the data sheet i found online, there is no suggestion it
does support C22 bus protocol. All the diagrams/tables only show C45
bus protocol.

So this PHY is a special case. So you can use wrapper methods which
force C45 bus protocol, and ignore phylib support for performing C45
over C22 when needed. However, while doing this:

1: Clearly document that these helpers are not generic, they force C45
   register access using C45 bus protocol, and should only by used PHY
   drivers which know the PHY device does not support C45 over C22

2: Think about naming. At some point we are going to add the generic
   helpers for accessing C45 registers which leave the core to decide
   if to perform a C45 bus protocol access or C45 over C22. Those
   generic helpers need to have the natural name for accessing a C45
   register since 99% of drivers will be using them. The helpers you
   add now need to use a less common name.

	Andrew

