Return-Path: <netdev+bounces-215671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C127FB2FD85
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613971CE41F7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA92E7F36;
	Thu, 21 Aug 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PxCL5sV1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71B2E4240;
	Thu, 21 Aug 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787770; cv=none; b=geXQ6ox/AnAq131FhMU9QN8bbZuiIpWF/YK5A49HENjUc4juUyX70jObIeL5UrgY/UmAmFpJRgnbkS8EK3S98vaReMoVnOcUsPuV5r2A0xjOBy62H+/W4Mu82WlEDbOb+sTeC2f2n4DRcl2a7LBxEkCzuCT6UtbYPb9jpV7ph0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787770; c=relaxed/simple;
	bh=36oI+NZxr7PqQl/gshzRwTcbeorMq8tYmsy4WUJfGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiFLgNPN4dO/xqJipEiXdMseAG9bPQrNfPEyp0pv9k8QITpGiaZ/k0p/zEG8wEB5OiT0oqTQvqlXGShC1OQKN11IFIJOBo4xaLQTw5dGeTGaGpZ22v9TE8+iiOMOPN4+s8pZCRQto+rmJWiHE6EZkGGdjubh2QPqHaTnuuOGVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PxCL5sV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73342C4CEED;
	Thu, 21 Aug 2025 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755787770;
	bh=36oI+NZxr7PqQl/gshzRwTcbeorMq8tYmsy4WUJfGh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxCL5sV1+TCD724Om3HwdhaXToQH4iw8upnVCbT3vJa30uWdRVdzaHu+7QoLNENnK
	 rMGU1h356UmgNcKzgPDUtTOdhbaO8PJXrj6mqspZ5O0mOr5iG3UJLYQ+vyd/6t8Kfp
	 b65BvGPv/OXoxvZEu5NxyRDCJydcZH7WBlU8jQVo=
Date: Thu, 21 Aug 2025 16:49:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>,
	Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH] netlink: specs: binder: replace underscores with dashes
 in names
Message-ID: <2025082139-bullion-canopy-e705@gregkh>
References: <20250821135522.2878772-1-cmllamas@google.com>
 <20250821073743.7bf0e0db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821073743.7bf0e0db@kernel.org>

On Thu, Aug 21, 2025 at 07:37:43AM -0700, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 13:55:21 +0000 Carlos Llamas wrote:
> > The usage of underscores is no longer allowed for the 'name' format in
> > the yaml spec. Instead, dashes should be used. This fixes the build
> > issue reported by Thorsten that showed up on linux-next.
> > 
> > Note this change has no impact on C code.
> 
> I guess the tree where the patches landed doesn't have last merge window
> material? I thought the extra consistency checks went in for 6.17
> already.. In any case, change makes sense:

They don't seem to be in 6.17-rc3, what commit are you thinking this
was?  Ugh, my fault, nevermind, I was testing the wrong branch in the
wrong git tree!

I see this in my tree now, sorry everyone for the noise in not figuring
this out, too many trees/branches...

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks, I'll take this in the char-misc-next branch now.

greg k-h

