Return-Path: <netdev+bounces-119305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A649551F3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E4E1C2089D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60781C230D;
	Fri, 16 Aug 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MPdK48xC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632E10E4;
	Fri, 16 Aug 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840906; cv=none; b=GhtPfU8KqCObDzhd4Uzm0u2PyWdw71XlUz6FVsijtwVu56rp2q+H75CYSclxNtcCRRvGQ/cnqk2qZNIORzSFm2hg8g8RqQzCYZcG39VSD4LQbgVd0l8t0mbgXOd/M53IV45hDBkj5+n+BNaNFPKVrEpm0jXJGL88y3HJt8JeAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840906; c=relaxed/simple;
	bh=FJqFOAQHLZgrVIsKHKsM350ktpzcfGfOeC3fVJwlIF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pABGWR4sTb/MdKgzCg/qWRveV7T9lkExe3cjtTpSQbcsKi7Bn2fnWLrcNHVybTHsxvs8dwWEO9CiaHnfGj4UGcFWzmoa0iXgQT0kOUJihuBtfwSTcthuVah2na0NhW84TvD/9E9g6MmOgZbQbRgQv1QaMTWRyjN73Too2+ELsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MPdK48xC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6mHwF5eJNyqAoQxsmASoimJoKtlAU6uWjPM1E5/4Nfo=; b=MPdK48xCSuCxC23JVg5WUjj8AB
	d9SPxSWvKAbl01M5HR0mFfvAoIhXRYSS1DTH+gX1hNWk3vwTATrrpqvSd4F6b4truDdG5d1/nhWje
	j1NxtMUHTAlKXotM1ph+aKjjOYRE0rCY0cnJsHEWPEQjXfP2Qqw32kXuTAvoqyEJK86w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sf3lS-004xk2-VQ; Fri, 16 Aug 2024 22:41:38 +0200
Date: Fri, 16 Aug 2024 22:41:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 5/6] rust: net::phy unified
 genphy_read_status function for C22 and C45 registers
Message-ID: <7dbf30ef-4908-4600-8898-cb812024392b@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-6-fujita.tomonori@gmail.com>
 <b61b5eb4-ee73-405c-aeae-0c26c66445fc@lunn.ch>
 <20240816.053009.1420518753499945384.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816.053009.1420518753499945384.fujita.tomonori@gmail.com>

On Fri, Aug 16, 2024 at 05:30:09AM +0000, FUJITA Tomonori wrote:
> On Fri, 16 Aug 2024 03:19:51 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> +///
> >> +///     // Checks the link status and updates current link state via C22.
> >> +///     dev.genphy_read_status::<phy::C22>();
> >> +///     // Checks the link status and updates current link state via C45.
> >> +///     dev.genphy_read_status::<phy::C45>();
> > 
> > Again, the word `via` is wrong here. You are looking at the link state
> > as reported by registers in the C22 namespace, or the C45 namespace.
> 
> Yeah, how about the followings?
> 
> ///     // Checks the link status as reported by registers in the C22 namespace
> ///     // and updates current link state.
> ///     dev.genphy_read_status::<phy::C22>();
> ///     // Checks the link status as reported by registers in the C45 namespace
> ///     // and updates current link state.
> ///     dev.genphy_read_status::<phy::C45>();

Yes, that is good.

     Andrew

