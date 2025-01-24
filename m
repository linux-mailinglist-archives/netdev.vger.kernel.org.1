Return-Path: <netdev+bounces-160714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0FA1AEE9
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355001695F4
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE181EA65;
	Fri, 24 Jan 2025 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYUjmqBd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58C184F
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688285; cv=none; b=CPx6cEjxvYMiaAafiOvE28bvfUHSKHuwX2aJODOby5rPWTza4MuXe8s7oqAfoTa+EuNkJa+4mWUlc+0tFPhGcraDvgGMFobalJoqrqoqXIP238ELe9E/BQUei4HQJqLDI/3RmQvbwd/r7VMrD7Xhqg52St5rujT/nO8+mKWgdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688285; c=relaxed/simple;
	bh=L9kS1pajGgwQJeFG44q1mXJPnOjPjkd500B9kqgQ7M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKQwLOXKllb24yIGGANaNHPA1wx38m5+zd3c2v1kmQKDP33uLpiPUtZSIg63DhaSOswvF9GyB5EZ9rLHM280CMRaVLUut+cKSGQUEkrnDEdxsnMWtnbYBIgqGqfag4ngzb2+Dq9PuTqMBFh0FzozvQj7n79hracBahMKhK9314Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYUjmqBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D2C4CED3;
	Fri, 24 Jan 2025 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688285;
	bh=L9kS1pajGgwQJeFG44q1mXJPnOjPjkd500B9kqgQ7M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYUjmqBdRt233+2bTK9varupHqIR+Yaq2NtiiOahAbqPKU65QDg1lTcZ9r5kAsozl
	 E4ouBoLvz8zPwndvPkzNAC+WE96pIZZF653BKBm1EXXiFh+QmRwNwHiYuo4xgR3rzR
	 NMwqWZtBLbbOUWCLOIOiGCVCeoK0tIR5wZzPyqgxzb01QPW3B9Dg1WXv/1qt7AJixO
	 gnwJDCUR7+JUVpCwAT3kFC5p+nt+oRpmeRfGnRjkNHpuXZQL48+oYudLjhCKv8Lu2b
	 OFcpUgNhVOJcW7nkq17pw/53WeYVRH6+colX63XDAxlsG6lMzzkm7mgYp+kJnYX1Z8
	 H6wEdjmcUibEg==
Date: Thu, 23 Jan 2025 19:11:23 -0800
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
Message-ID: <Z5ME2-zHJq6arJC8@x130>
References: <20250116215530.158886-1-saeed@kernel.org>
 <20250116215530.158886-11-saeed@kernel.org>
 <20250116152136.53f16ecb@kernel.org>
 <Z4maY9r3tuHVoqAM@x130>
 <20250116155450.46ba772a@kernel.org>
 <Z5LhKdNMO5CvAvZf@mini-arch>
 <20250123165553.66f9f839@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250123165553.66f9f839@kernel.org>

On 23 Jan 16:55, Jakub Kicinski wrote:
>On Thu, 23 Jan 2025 16:39:05 -0800 Stanislav Fomichev wrote:
>> > > What technical debt accrued ? I haven't seen any changes in queue API since
>> > > bnxt and gve got merged, what changed since then ?
>> > >
>> > > mlx5 doesn't require rtnl if this is because of the assert, I can remove
>> > > it. I don't understand what this series is being deferred for, please
>> > > elaborate, what do I need to do to get it accepted ?
>> >
>> > Remove the dependency on rtnl_lock _in the core kernel_.
>>
>> IIUC, we want queue API to move away from rtnl and use only (new) netdev
>> lock. Otherwise, removing this dependency in the future might be
>> complicated.
>
>Correct. We only have one driver now which reportedly works (gve).
>Let's pull queues under optional netdev_lock protection.
>Then we can use queue mgmt op support as a carrot for drivers
>to convert / test the netdev_lock protection... "compliance".
>
>I added netdev_lock protection for NAPI before the merge window.
>Queues are configured in much more ad-hoc fashion, so I think
>the best way to make queue changes netdev_lock safe would be to
>wrap all driver ops which are currently under rtnl_lock with
>netdev_lock.

Are you expecting drivers to hold netdev_lock internally? 
I was thinking something more scalable, queue_mgmt API to take
netdev_lock,  and any other place in the stack that can access 
"netdev queue config" e.g ethtool/netlink/netdev_ops should grab 
netdev_lock as well, this is better for the future when we want to 
reduce rtnl usage in the stack to protect single netdev ops where
netdev_lock will be sufficient, otherwise you will have to wait for ALL
drivers to properly use netdev_lock internally to even start thinking of
getting rid of rtnl from some parts of the core stack.

  



