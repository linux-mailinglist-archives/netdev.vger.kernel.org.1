Return-Path: <netdev+bounces-247811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65729CFF0FF
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079A6351AB96
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76333876A8;
	Wed,  7 Jan 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoKJjTDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3513876B7;
	Wed,  7 Jan 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801272; cv=none; b=ht8adfETGAIpWRCuZa0p57HF0l1ZWqQmlR0nO2yxyjbe1n8JXpZJ1ZYJkqbOjhg2TgENmO2sUZnHPAUp9cQxn8HSfQxH2R24FenDnZqyLh71T1gbMTIZme3IOKJa7ZPvGRSo09ANGbdXmwG5BllVIwDarPynEje6DUgWgtGf56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801272; c=relaxed/simple;
	bh=V6P3bS26yze5zMNM28stYUxE4Le+BxDGHcSAb1viy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqWRHyEQ90+dsTJXjSw86mDFTasTOvjZu2MLxQWZ80jWdfjmGW5+p4FyqcO27OXdN/ddUaidwcKlwleHG/rjN0P6on3EVNZjBHsMEOw40nTM+enWk/ffjinZxqsHKeNgbkWa38bfByh1ooC2b2ix6vg7TV9U78wHJxZH2neW5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoKJjTDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F4C4CEF1;
	Wed,  7 Jan 2026 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801271;
	bh=V6P3bS26yze5zMNM28stYUxE4Le+BxDGHcSAb1viy+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoKJjTDu6LO0cMglVQCHDIjABOw7Go4Mql5XK2sx8JQ2VWmI5mujktEf2N2CgS5X9
	 jEwESOpMc1JWPBsWr2hx0+NaBKpxRqaY5qNJl8zzPt7hHxW67RS+A1OMPi+Hdq2A5F
	 DGPATarT/I+2uOcxxD4IVISsLJ+rge2/eYtz2GmYDO1ZmZCp7j4wrYdVOABbOcodIo
	 D3oBObx50rJRPr251ReUlfO+XoknYdv7C0dEM72JKAhHK/LTNCebORgPr3gwcFzlau
	 83Prx/HnlMc1ihKPc6HB36QWWKwLCX48/LMEkFeFJV6cNG1w8i4BrYj+oNh7mQzThQ
	 HIgIpsbnvDw0A==
Date: Wed, 7 Jan 2026 15:54:27 +0000
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/15] net: ftgmac100: Various probe cleanups
Message-ID: <20260107155427.GB345651@kernel.org>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>

On Mon, Jan 05, 2026 at 03:08:46PM +0800, Jacky Chou wrote:
> The probe function of the ftgmac100 is rather complex, due to the way
> it has evolved over time, dealing with poor DT descriptions, and new
> variants of the MAC.
> 
> Make use of DT match data to identify the MAC variant, rather than
> looking at the compatible string all the time.
> 
> Make use of devm_ calls to simplify cleanup. This indirectly fixes
> inconsistent goto label names.
> 
> Always probe the MDIO bus, when it exists. This simplifies the logic a
> bit.
> 
> Move code into helpers to simply probe.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Hi,

I'm slightly unclear on the providence of this patchset.
But overall it looks good to me. And I particularly like
how it has been split up into bite-sized chunks.

I don't see anything that should block progress, but I do have a few
minor nits that I'll raise just in case there is a v2 for other reasons.

The first nit is that the patch-set should be targeted at net-next,
by including inet-next in the Subjects, like this:

  [PATCH net-net 00/15] ...

The other minor nits are patch-specifically, so I'll respond to those patches
accordingly.

Again, overall this looks good to me.
So for the series:

Reviewed-by: Simon Horman <horms@kernel.org>

