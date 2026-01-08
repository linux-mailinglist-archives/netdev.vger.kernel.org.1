Return-Path: <netdev+bounces-247945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B1D00B21
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D8C23008556
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22DE3D6F;
	Thu,  8 Jan 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxLvrBFk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBF1E1A33
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839950; cv=none; b=Gm8/IEZhZW2NlJpF3sK1+mJTQIwSvdYK0EmybgVDFzbGtjCAt9DBrx3JyI1FKRBWNufoYSBczUyC4BJ0REIf4XhgtVj8egxdtJ+xuMjTw2KBjrNJLULlqeY45TPSh4JKix1M3EqP1bezsCfjraM+DWIP0j+09UIA5qnWEoRvxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839950; c=relaxed/simple;
	bh=Gn//lbQF1sdra9ZqWvt3xSFSLPsihmtKNgD3YOrQplk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxK3loBv2mbNY62Lcjx7sogb0yccbwGDLvzMkBfMTt+X7w/9TYxot51t7zwbdWGaKjAO1U/tx8x6mm2PF2YjQbVy0ez0cmrpHRHlPnXgpepOND3M/d5EGvVsDrdFzwFAWWWzezU8rhHGndjLURk2HXc3Y1jQb6f21E+Jo3jTLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxLvrBFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A6C4CEF1;
	Thu,  8 Jan 2026 02:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767839950;
	bh=Gn//lbQF1sdra9ZqWvt3xSFSLPsihmtKNgD3YOrQplk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TxLvrBFkcDJieZ5Br5BDEhbonVNfemKde7hKtDSZDbYI/EUbL6GaeCe1ikQyFM2VQ
	 ZG+L1UARVevAvwgUx49hLtP6UYRS4stjFW2GHyTNBVxM1chpUg5poN8cgr9Wx10ic+
	 I7Mc1ytXUtTi0gmq9rBxObGDhvA1UkryjYuWwCv6kxN7LSua4OL9t3k+1UrFQXb7Qk
	 etEh37pXiRkxlLxhOb8l7cullCuf635kf3Kt6kcrq5CrF9Lad2HdPQf2jfkzqbYpkh
	 eX0WIZ+PLPKzRW0aIFJI8bhlUF/XGyqbgbIQ+iwsdQlPgk1+jmpjIm357g/iZJdPHh
	 KWxB37ZpTqOpg==
Date: Wed, 7 Jan 2026 18:39:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Clarify len/n_stats fields in/out
 semantics
Message-ID: <20260107183909.2611315d@kernel.org>
In-Reply-To: <8d5e3870-1918-4071-8442-1f7328b71a75@nvidia.com>
References: <20260105163923.49104-1-gal@nvidia.com>
	<20260106174816.0476e043@kernel.org>
	<8d5e3870-1918-4071-8442-1f7328b71a75@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 10:51:46 +0200 Gal Pressman wrote:
> On 07/01/2026 3:48, Jakub Kicinski wrote:
> > On Mon, 5 Jan 2026 18:39:23 +0200 Gal Pressman wrote:  
> >> - * @n_stats: On return, the number of statistics
> >> + * @n_stats: On entry, the number of stats requested.
> >> +	On return, the number of stats returned.
> >>   * @data: Array of statistics  
> > 
> > Missing a '*'  
> 
> Ah, missed it, thanks!
> 
> > But stepping back we should rephrase the comment to cover both
> > directions instead of mechanically adding the corresponding "On entry"  
> 
> What do you mean?
> How would you phrase it?

Maybe just "number of stats"? 

If you want you can (in the body of the doc) go into the detail that
setting the value on input is optional. And on output it will either 
be the number of stats reported or 0 if there's a mismatch?

> > FTR my recollection was that we never validated these field on entry and
> > if that's the case 7b07be1ff1cb6 is quite questionable, uAPI-breakage
> > wise.  
> 
> Can you describe the breakage please?
> 
> The kernel didn't look at this field on entry, but AFAICT, it was passed
> from userspace since the beginning of time.
> 
> As a precaution, the cited patch only looks at the input values if
> they're different than zero, so theoretical apps that didn't fill them
> shouldn't be affected.
> 
> Maybe if the app deliberately put a wrong length value on the input buffer?

Not deliberately, but there used to be nothing illegal about
malloc()'ing the area and only initializing cmd. n_stats was
clearly defined as output only, and zeroing out the buffer
was kinda pointless given that kernel was expected to override
the stats area immediately with data.

Don't think we need to revert the change now, let's see if anyone
complains (perhaps ethtool CLI is the main way people interact with
the stats?) But there have been LWN articles about this sort of "start
using an un-validate field" in the past. It's well understood to be
a no-no.

