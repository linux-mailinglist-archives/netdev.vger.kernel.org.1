Return-Path: <netdev+bounces-205956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC80B00EA8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15D31CA5BF7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D62951B5;
	Thu, 10 Jul 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfZRYWXU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6F23ED6F
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186263; cv=none; b=S67OnAFMFEfOb3fpDdNW9xbUDwKb0njMIn5ucn3k5/xpXrNJyUw0hM/N12NipIuiulyCDljJDESKs3Fl2OQS0KPo74aV0kB7pFYRZTMiKJJP7cWDv7WN0vh4XgytkgeiyTpOFse8x+zYFZGWwvCgkm0LNcO3kMOxh29ncYzFDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186263; c=relaxed/simple;
	bh=CZW7KVfdDW4COSUzXuo9ISdH4qwC3LYRWLie/s6o4Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZErWQV1neNqET5wEQXVFPrCLDJGyBzNq2nw7d6c8lc6jHkTjZHM6t1uAu09XuGNQLKhbOWFp+2bNfNuKybDPfdWumeZAGQhlzzZxlVMYZ2D9TMohpGC/LcNklRj8xYxFA5FohPblxIPqDXeyOaIebEyR+zY4VH9TJe2RFIA26I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfZRYWXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB45DC4CEE3;
	Thu, 10 Jul 2025 22:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752186263;
	bh=CZW7KVfdDW4COSUzXuo9ISdH4qwC3LYRWLie/s6o4Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YfZRYWXU5wABQmoA51M+TDsyt6dXLtrmSlNXbtJ6BFGkk99EWCs9bBH1sV2InjCRe
	 3KqFn+0L0uUZm9tYriBrt4LinuePRbcCDmn0Q4t8zXvd3dEUh2DTazLhTP4szstbIu
	 5b44Pij6MZ9n0ds1Az7Q9ILqaPIOmFtcZTrNqz7/47Bc+E9S2TBhpYZR20XyqcF+hE
	 +KmdOYV28VPS9+kEHwtQRtk9cgrMJyQu5YjBq/WZY2j/5uVaiTnF0VJxuSKP0S3bqK
	 Ngj8i5D+g4iV9yATBYUFsbdsICzCOHLKRyrjkkf3p9MewITqvNcEAQ7fPTo39eseDl
	 i6UyPVqGisZZg==
Date: Thu, 10 Jul 2025 15:24:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <20250710152421.31901790@kernel.org>
In-Reply-To: <aG9X13Hrg1_1eBQq@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-10-saeed@kernel.org>
	<20250709195801.60b3f4f2@kernel.org>
	<aG9X13Hrg1_1eBQq@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 23:04:07 -0700 Saeed Mahameed wrote:
> On 09 Jul 19:58, Jakub Kicinski wrote:
> >On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:  
> >> Devices that support this in permanent mode will be requested to keep the
> >> port link up even when driver is not loaded, netdev carrier state won't
> >> affect the physical port link state.
> >>
> >> This is useful for when the link is needed to access onboard management
> >> such as BMC, even if the host driver isn't loaded.  
> >
> >Dunno. This deserves a fuller API, and it's squarely and netdev thing.
> >Let's not add it to devlink.  
> 
> I don't see anything missing in the definition of this parameter
> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
> netdev controls the underlying physical link state. But this is not
> true anymore for complex setups (multi-host, DPU, etc..).

The policy can be more complex than "keep_link_up"
Look around the tree and search the ML archives please.

> This is not different as BMC is sort of multi-host, and physical link
> control here is delegated to the firmware.
> 
> Also do we really want netdev to expose API for permanent nic tunables ?
> I thought this is why we invented devlink to offload raw NIC underlying
> tunables.

Are you going to add devlink params for link config?
Its one of the things that's written into the NVMe, usually..

