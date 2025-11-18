Return-Path: <netdev+bounces-239305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A43C66C3E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11280355DE7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14F1C861A;
	Tue, 18 Nov 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5fOMss9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A0944F;
	Tue, 18 Nov 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427423; cv=none; b=eZK7FCTeyCqDiOviK0W4gCJfuZhHGFELI49DOfd6+fngASmjH0WLDIIelqK6Kp4t+OrO5gXi0bIjL2Vz3LnCOYwmU0q08pzFYv8zv8iLHFGrzlFqnFzNAcKtCqP6ltwNR08mctOvD6+WM3DJBVvXqoV/y9vr7aepHXgbUpAcJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427423; c=relaxed/simple;
	bh=Il89Mbvnt1csqkwQE2r+nkLyEwaXm5iNU4OXO4fn4Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2fW8GMMzxo7NPt/jF3vrcMly7MXlrit4hCb2LJl8J5QbtnDumDjDNnvGg4SoOUjIVLLV+aEF29r/D7X9VaNqD1qtdQYi9euR5Jm+InZiZRIerMRbdZTKwmzwGJm0X13sCFNCdJJQgjQFDj1o1JEjegW2+2ayZYJjJG/TNdZTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5fOMss9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD5CC4AF0D;
	Tue, 18 Nov 2025 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763427422;
	bh=Il89Mbvnt1csqkwQE2r+nkLyEwaXm5iNU4OXO4fn4Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5fOMss99Y9LXK4WJw/FKdUw944OfO8aHJDlcaV9p22ErvbZ20Zhf+iNxGRb8OjOY
	 H22PxwvwYo77HXlSNgO1D1CIJHAUukrXjnwC6/Ic2PRzOrEK+yM5RY2CzDtVe9INXy
	 h6g38JwySY4jKbR3eNWhrkJD2BlOVkJ4bZv7TaGlQPaIJ8H99SZ/zVnVf0CH7YuiO7
	 alWN2/mpVofoQ+Sva9LSsHkUWFX4m66glTgqni8X3mwnfczuQCADp/kxFmL4ctTrlF
	 fgoiIOIGt1yP8O3bkv+iLQoft2/004dzwaVk/gV0sbqbeE/sHUr7FfMPOy3XkIv3kl
	 MqukLPfKQ907A==
Date: Mon, 17 Nov 2025 16:56:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Message-ID: <20251117165659.2dfd369e@kernel.org>
In-Reply-To: <aRvBOWHU5Zow65HD@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251110180746.4074a9ca@kernel.org>
	<aRQGIhazVqTdS2R_@zx2c4.com>
	<20251117161439.1dedf4b6@kernel.org>
	<aRvBOWHU5Zow65HD@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 01:43:37 +0100 Jason A. Donenfeld wrote:
> On Mon, Nov 17, 2025 at 04:14:39PM -0800, Jakub Kicinski wrote:
> > On Wed, 12 Nov 2025 04:59:30 +0100 Jason A. Donenfeld wrote:  
> > > Reviewing it this week. Thanks for bumping this in my queue.  
> > 
> > Sadness. We wait a week and no review materializes. I think the patches
> > are fine so I'll apply them shortly. The expected patch review SLA for
> > netdev sub-maintainers is 24h (excluding weekends and holidays)
> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> 
> Sadness indeed. I've had some urgent matters come up, but this is now
> top of the stack, and I've given it a quick preliminary pass. I'd
> planned to take this through my wg tree.

Alright, I haven't pushed out yet, so let me drop these.
Looking forward to seeing them in a PR..

