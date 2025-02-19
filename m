Return-Path: <netdev+bounces-167735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB60A3BF4E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14ABC7A6E1A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AC1EB1BC;
	Wed, 19 Feb 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hgXUXLSL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A61EB197;
	Wed, 19 Feb 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970071; cv=none; b=dnCfFIe0+WFk4mFVjfWmy6h7oiBx073DSC11xbWUW2E7FYLn2a78JSNwbchENVLHwmHKemWLNwMetldBVPfnm9YBXInjgrCzTJV5HRr0neZgLKEVxVQ89ZqMgLiZ5s8UluYuU4mgjlZzq2s31Vsr9ovUQClxtb9nF+CE089SRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970071; c=relaxed/simple;
	bh=wV7WZZcCNP/LMaDYch87A8tYbhsLVIbdIQGHrqnWVlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ4IkJ1aVvPHz9YHTZ0AKUHUTOzJQKuuk+AFQfmvXKfWUUV28NxhDyDTX1/iCGK2LDHA9jNVxmx4/fz8Ovvyl4WbxTJiLohSxtyEgVW66DuPEzCyuaYbNMJHoRiG+2A10YUfYj32gyqxdxGg8KzD7FSmkSRS8Cvz/3kXRISBWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hgXUXLSL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=32sNvnUS5aFpqGf+nH8pDJkKfydmj7kKdZsj/+G1liw=; b=hgXUXLSLipy5kXkuTkVa+pdfwz
	cTP5n2fj1QFro3oTQSQQll46J9DjJGWBj31ATYuHVmjyk88Bkkc/zfzDo1mXXuvIVwsc+M/nNTyWD
	cLuPN82DEfSaIqVm6KTdzmNywDNSOohnLq91wJ89FmBZYqsEL5l6ip3rtL9bfcvYGlBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkjgt-00FdHC-0i; Wed, 19 Feb 2025 14:00:39 +0100
Date: Wed, 19 Feb 2025 14:00:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: charmitro@posteo.net, tmgross@umich.edu, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: qt2025: Fix hardware revision check comment
Message-ID: <c83a4d5f-3e98-4fec-a84a-669f04677774@lunn.ch>
References: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
 <20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219.100200.440798533601878204.fujita.tomonori@gmail.com>

On Wed, Feb 19, 2025 at 10:02:00AM +0900, FUJITA Tomonori wrote:
> On Mon, 17 Feb 2025 23:53:50 +0000
> Charalampos Mitrodimas <charmitro@posteo.net> wrote:
> 
> > Correct the hardware revision check comment in the QT2025 driver. The
> > revision value was documented as 0x3b instead of the correct 0xb3,
> > which matches the actual comparison logic in the code.
> > 
> > Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> > ---
> >  drivers/net/phy/qt2025.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> > index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
> > --- a/drivers/net/phy/qt2025.rs
> > +++ b/drivers/net/phy/qt2025.rs
> > @@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
> >  
> >      fn probe(dev: &mut phy::Device) -> Result<()> {
> >          // Check the hardware revision code.
> > -        // Only 0x3b works with this driver and firmware.
> > +        // Only 0xb3 works with this driver and firmware.
> >          let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
> >          if (hw_rev >> 8) != 0xb3 {
> >              return Err(code::ENODEV);
> 
> Oops,
> 
> Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Given that this patch is expected to be merged via netdev, you might
> need to resend with a proper subject:
> 
> https://elixir.bootlin.com/linux/v6.13/source/Documentation/process/maintainer-netdev.rst

Please also include a Fixes: tag.

	Andrew

