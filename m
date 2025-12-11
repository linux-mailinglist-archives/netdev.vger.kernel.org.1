Return-Path: <netdev+bounces-244367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29164CB5881
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 11:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E08BF3000B46
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10C3043D7;
	Thu, 11 Dec 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gslcWPfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF31E7C23
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449414; cv=none; b=MxDUsnO+hXrrsx8mnKlybjw9LoOHej/FBy+vfjSbDNYV1SRVHL6LL4Z2kYLfeH2doMGl0u4D4+Aw/SkfI2C4JBx8zQrW+YjAq4J/nUyxm6WIRGwy9XUfqOtKCpRUqmwi2ZEjRHdlfPu5EJ3QP6mD0Us3JYMUGdHV321PPpXpyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449414; c=relaxed/simple;
	bh=XudMPAG7leE7f18uwfYrAwfF/nB2Q/CwbeWiIsx0rNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ3WT84FfQ0cdOtG6NTTlDonkT2jbBFs7F705buIl5JvR5RonJWuaozEHKsdnm6p+smQzpKvmaXSGoDcscsW27miELDdH3OEgiLoJyUNWTg38UjbBGGx4s588d3c5PrJlhHqF6t4jfFBrRrY/J/L5p1Oiq91Fl08rmbJNuzH8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gslcWPfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03290C4CEF7;
	Thu, 11 Dec 2025 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765449413;
	bh=XudMPAG7leE7f18uwfYrAwfF/nB2Q/CwbeWiIsx0rNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gslcWPfV9WpWYxWQMcmOypaiflbWZCOUPORbtQcdF0+e5YRpdqE2ZYLLlLVx97lQl
	 0A10ZZ3Rd0mTaVkqaT5vesKcmllRnWgTaxBzSCfVX4f1P/ozQUyGbogqQbG8PND6Ea
	 qlkIx9ejdndM33EKhCfUdUXHojulZMe0+gES1wanq7hGzwK2vftACH8qnReB4EG4s1
	 zXGth76wizn2WA54fWzJ2FkMnzkEpVllgbgqqEqpPGwePplt0f1DoHfrT8qmJs67Ic
	 223WP641EwazQiBmt6R8aCwQIm0Hsjy3Yy55t9lScFzWzaG/hUKkw6WDa33TL2GkVV
	 eZZIp6mgEG0fA==
Date: Thu, 11 Dec 2025 10:36:50 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] epic100: remove module version and switch to
 module_pci_driver
Message-ID: <aTqewtoOZ5s84vEV@horms.kernel.org>
References: <20251211074922.154268-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211074922.154268-1-enelsonmoore@gmail.com>

On Wed, Dec 10, 2025 at 11:49:22PM -0800, Ethan Nelson-Moore wrote:
> The module version is useless, and the only thing the epic_init routine
> did besides pci_register_driver was to print the version.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/ethernet/smsc/epic100.c | 35 +----------------------------

Hi Ethan,

Thanks for your patch.

I note that author information is remains present in a comment at the top
of this file.  And I agree that not having this kind of information is
current best practice (and has been for quite some time AFAIK).  So I think
this patch is a good way to go.

Reviewed-by: Simon Horman <horms@kernel.org>

However, I also think that this is net-next material.

It's best to make that clear by targeting the net-next tree like this.

Subject: [PATCH net-next] ...

It usually isn't necessary to repost a patch just to address this.
But as it happens net-next is currently closed. So I'd like to
ask you to repost this once it re-opens.

## Form letter - net-next-closed

The merge window for v6.19 has begun and therefore net-next has closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens.

Due to a combination of the merge-window, travel commitments of the
maintainers, and the holiday season, net-next will re-open after
2nd January.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

