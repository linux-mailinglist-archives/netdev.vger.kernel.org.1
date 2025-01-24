Return-Path: <netdev+bounces-160847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C4A1BCE2
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 20:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B1B16DD50
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448F188714;
	Fri, 24 Jan 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYcmC1lZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D835976
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747295; cv=none; b=Lb8QWIrJBJCpDzkn3UEK/dAWPRPBFwl9+nFARpjufQwURbSfmavbN4byTXK/lLjQ5qNDf8qyrou3nSZyuZ+sQtzwQxblOnH9DRUX8EH3/aCGPXFY8pwSXquE/d0gh6IGCnd9DqZl9RyiDohGun/THhHY1D5xtaHE9M5Jw7KYtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747295; c=relaxed/simple;
	bh=afaTpytvszIRc3Ff1yvTxfqmbXKTKzeJ7LSxwr4lKS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvJa7YU2taskxthw11OHAkTHboZM9+TW5q3W2FWgr3VYOwpaQ3Ft8Oo3MR8CU5R0Va1N0eC/1BgM8CXD7zBH7mmOlIOef8ucbuQsaVqyEDRD4lPInfmvauAUxjWdizOP/tCqwShXbAuFFAk7iQEPvy1JyAhnOfd/+6c0IpJ9dUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYcmC1lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4796BC4CED2;
	Fri, 24 Jan 2025 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737747295;
	bh=afaTpytvszIRc3Ff1yvTxfqmbXKTKzeJ7LSxwr4lKS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYcmC1lZkJMV9DunJ7XC0oGhToYcOB4s3tBaD7J7K2HTD30qsMzcluL0ul2UisIa0
	 U0ZlUmgxGIg3CMD4CDOiA34GhvVgCEavXwCs6QcAn3xttyKA/pwXM7CN2fiXqHpGnF
	 MZeXZR1b4Opab0KyP2TN9H4SFTNqH1lBUwLar2y6rOdJ9SdRaQ5D3f4dpUphyOHoQq
	 SrQr0NN9PoyvBUWOP5IZoUTJSbWG2FiRf6AsdSHkM4mZ9F1up+HBD9jreMDTqdLo82
	 x6RBtRSFbTe9RCOo2ENh//5oC602nBnkxe7BanALqW3rlOr5K9fm7qszKTyJhVFm6P
	 KxQEGqFvHm0jw==
Date: Fri, 24 Jan 2025 11:34:54 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next 10/11] net/mlx5e: Implement queue mgmt ops and single
 channel swap
Message-ID: <Z5PrXkL7taguM57W@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
 <20250116215530.158886-11-saeed@kernel.org>
 <20250116152136.53f16ecb@kernel.org>
 <Z4maY9r3tuHVoqAM@x130>
 <20250116155450.46ba772a@kernel.org>
 <Z5LhKdNMO5CvAvZf@mini-arch>
 <20250123165553.66f9f839@kernel.org>
 <Z5ME2-zHJq6arJC8@x130>
 <20250124072621.4ef8c763@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250124072621.4ef8c763@kernel.org>

On 24 Jan 07:26, Jakub Kicinski wrote:
>On Thu, 23 Jan 2025 19:11:23 -0800 Saeed Mahameed wrote:
>> On 23 Jan 16:55, Jakub Kicinski wrote:
>> >> IIUC, we want queue API to move away from rtnl and use only (new) netdev
>> >> lock. Otherwise, removing this dependency in the future might be
>> >> complicated.
>> >
>> >Correct. We only have one driver now which reportedly works (gve).
>> >Let's pull queues under optional netdev_lock protection.
>> >Then we can use queue mgmt op support as a carrot for drivers
>> >to convert / test the netdev_lock protection... "compliance".
>> >
>> >I added netdev_lock protection for NAPI before the merge window.
>> >Queues are configured in much more ad-hoc fashion, so I think
>> >the best way to make queue changes netdev_lock safe would be to
>> >wrap all driver ops which are currently under rtnl_lock with
>> >netdev_lock.
>>
>> Are you expecting drivers to hold netdev_lock internally?
>> I was thinking something more scalable, queue_mgmt API to take
>> netdev_lock,  and any other place in the stack that can access
>> "netdev queue config" e.g ethtool/netlink/netdev_ops should grab
>> netdev_lock as well, this is better for the future when we want to
>> reduce rtnl usage in the stack to protect single netdev ops where
>> netdev_lock will be sufficient, otherwise you will have to wait for ALL
>> drivers to properly use netdev_lock internally to even start thinking of
>> getting rid of rtnl from some parts of the core stack.
>
>Agreed, expecting drivers to get the locking right internally is easier
>short term but messy long term. I'm thinking opt-in for drivers to have
>netdev_lock taken by the core. Probably around all ops which today hold
>rtnl_lock, to keep the expectations simple.
>

Why opt-in? I don't see any overhead of taking netdev_lock by default in
rtnl_lock flows.

>net_shaper and queue_mgmt ops can require that drivers that support
>them opt-in and these ops can hold just the netdev_lock, no rtnl_lock.

