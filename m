Return-Path: <netdev+bounces-119481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA02955D4B
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C762281A45
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE952148856;
	Sun, 18 Aug 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4wftUawp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342814883B;
	Sun, 18 Aug 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723995894; cv=none; b=fYNAgBIu2+Ud6R29sXxFT+QeLuIbuPeTGLZwWWE6jVM6etPF/H7fEssvIniKRvWbkhZM/b8IWOgUHmiESpWuj8w6ltvA+50SsG+0nvvJ4jA420B6H+hgagqDQCiRQUQZwOryh+NjLagKSN/Uw0IR3UwAnvN+ALHRUOKRsbw1C3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723995894; c=relaxed/simple;
	bh=PUyinxWjfUOPfACNm8w50oXOklVs0JiUI3Vo342p/bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW8MGnUGXLe8K4eXyCTbyeWRIf5sjhsZY7AmxVXwrRPm3E7vKZViIvTbrz8zaw+nM9d09Ivrd/7Xqf8KtDzQy5d/62eO4LqYVGvHtAj0hG4o1E1R56pTZp3ODOTcuYWI0dbjkwnjt5/86WgMAZMDRGG82zo7HKRfnx4m0OAr19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4wftUawp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SJVFrrWXKpqcQrELUI3D7UkflbTJVVx/NWFl5FdHBSw=; b=4wftUawpOmMjcqPOt4VN+C01zi
	JxcX4uke/jBwPzgamL5JXHN4Pg7+j8pF6plL+dV/YBH79xTlNWA5SyQBC0VeNvr9+wtbicDnE5mjN
	UYFK47o/S1FfyWVFDHTkuFeRlTYKIm3vN6+qltP4iS3FJbWgoHVLdSBGRo92AAhbowtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfi5E-0052b6-NG; Sun, 18 Aug 2024 17:44:44 +0200
Date: Sun, 18 Aug 2024 17:44:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <1a717f2d-8512-47bd-a5b3-c5ceb9b44f03@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-7-fujita.tomonori@gmail.com>
 <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
 <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me>

On Sat, Aug 17, 2024 at 09:34:13PM +0000, Benno Lossin wrote:
> On 17.08.24 20:51, Andrew Lunn wrote:
> >> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> >> +        dev.genphy_read_status::<C45>()
> >> +    }
> > 
> > Probably a dumb Rust question. Shouldn't this have a ? at the end? It
> > can return a negative error code.
> 
> `read_status` returns a `Result<u16>` and `Device::genphy_read_status`
> also returns a `Result<u16>`. In the function body we just delegate to
> the latter, so no `?` is needed. We just return the entire result.
> 
> Here is the equivalent pseudo-C code:
> 
>     int genphy_read_status(struct phy_device *dev);
>     
>     int read_status(struct phy_device *dev)
>     {
>         return genphy_read_status(dev);
>     }
> 
> There you also don't need an if for the negative error code, since it's
> just propagated.

O.K, it seems to work. But one of the things we try to think about in
the kernel is avoiding future bugs. Say sometime in the future i
extend it:

    fn read_status(dev: &mut phy::Device) -> Result<u16> {
        dev.genphy_read_status::<C45>()

        dev.genphy_read_foo()
    }

By forgetting to add the ? to dev.genphy_read_status, have i just
introduced a bug? Could i have avoided that by always having the ?
even when it is not needed?

	Andrew

