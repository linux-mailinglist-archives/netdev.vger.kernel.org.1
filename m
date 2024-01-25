Return-Path: <netdev+bounces-65952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50B83CA39
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C013D1F218DE
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7B131754;
	Thu, 25 Jan 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VMhqxUbA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471413174E;
	Thu, 25 Jan 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204530; cv=none; b=Ptt3uhT8D6R5sLoOAVEOABAReJvpx9CulPm3HO8hwL/yEjGqKEmk4CY6ZFmROSFw5NrXDp3MbsUnnOpOfSiXw1CncPohCRtA1CcjIrV/gNwdKXMZHsduYG7EeL6zCAW4j6zvYC3AX0DjkPgy95vEZK87Lz53JJ/IZFAgsFgaNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204530; c=relaxed/simple;
	bh=CF6+Hi4GeAzVx8LW4GbLCLydMins7gG/oRur2TOzDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpQDty+CEhuNdGpo/+Mu2vW/ZXpiZNilt3obB0OEHR92F7Q4z3TbLXukO+xdN6MP6wU/MvLEnUJIwGk+inbfJwmIrYXLAElNlwO+iEqXq32fBSa+jJklbsFiKgzP5HtAXNHNmZj/Z94GPd7d8xmgPXiDIzGXCWMQmD/WEPVqBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VMhqxUbA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MES6gX+8+nsyFlBsllvbTSH4KOA6qMyryRvdsV3V++0=; b=VMhqxUbASXJ0v04b3ZignKoixS
	cOQIm2Edg+dGILNGx7+XCILEu2nd3Z91Reo/SiiMfOoBlzAW3sKGo+BuHIfjSN1u68GV4Lspnszdy
	/gNOWmOpZwev7iXCWY04Y/090Q3Ej56a/5rs/RogJ3WrXLRyI4iIY9gfhdr3YpzXEsLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT3jp-0066ie-GY; Thu, 25 Jan 2024 18:42:05 +0100
Date: Thu, 25 Jan 2024 18:42:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH net-next] rust: phy: use VTABLE_DEFAULT_ERROR
Message-ID: <4573a237-dd18-4ea0-8de4-8b465eb856c7@lunn.ch>
References: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
 <20240125014502.3527275-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125014502.3527275-2-fujita.tomonori@gmail.com>

On Thu, Jan 25, 2024 at 10:45:02AM +0900, FUJITA Tomonori wrote:
> Since 6.8-rc1, using VTABLE_DEFAULT_ERROR for optional functions
> (never called) in #[vtable] is the recommended way.
> 
> Note that no functional changes in this patch.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 203918192a1f..96e09c6e8530 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -580,12 +580,12 @@ pub trait Driver {
>  
>      /// Issues a PHY software reset.
>      fn soft_reset(_dev: &mut Device) -> Result {
> -        Err(code::ENOTSUPP)
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
>      }

Dumb question, which i should probably duckduckgo myself.

Why is it called VTABLE_DEFAULT_ERROR and not
VTABLE_NOT_SUPPORTED_ERROR?

Looking through the C code my guess would be -EINVAL would be the
default, or maybe 0.

The semantics of ENOTSUPP can also vary. Its often not an actual
error, it just a means to indicate its not supported, and the caller
might decide to do something different as a result. One typical use in
the network stack is offloading functionality to hardware.
e.g. blinking the LEDs on the RJ45 connected. The driver could be
asked to blink to show activity of a received packet. Some hardware
can only indicate activity for both receive and transmit, so the
driver would return -EOPNOTSUPP. Software blinking would then be used
instead of hardware blinking.

	 Andrew

