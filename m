Return-Path: <netdev+bounces-72328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30985790A
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BA7281917
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F01BDCE;
	Fri, 16 Feb 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVNDORaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723E1BDCD;
	Fri, 16 Feb 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076427; cv=none; b=oeZ7GOBQ/Q+u0h0A/gWKXqe+5Lqf01ILwwjDJ+sb9lo2GtUfTC40tNMJRBQp7qZmOIJXxEeFfa5atZXngMHu3B5wZ9rlHgwOVZF++z8bSJ6N67FCWRXLYWvrEwbMcduESn6t8KkUrghOK9A/vxODgSAkRIhS3SIa++HT2ir41Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076427; c=relaxed/simple;
	bh=3mKv0rm569lQywYbjrO7eyzJTxRDsj8Neq3IaI+xYQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DBc3Y0PjT6szoRdoJOo7u9zZzbfhTTD21Z4AvojJNs1UUI592W8R2dSCWxgP+5q10yu9ySs5DFd4NqQUoOuqyNk9ZcdM/fcxYpL29ygu85Bw/YxIT8+BmYGQjU4aS0SoDq67aKXhvzgQjKcsNy5MPTsiH1pBjA/CeIJb+MBMoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVNDORaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0A90C433F1;
	Fri, 16 Feb 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708076426;
	bh=3mKv0rm569lQywYbjrO7eyzJTxRDsj8Neq3IaI+xYQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kVNDORaa8OVBk0caIN9jN8x6HNI/Lzmrj2Pqr4oZ+T3THbudDX1K4wHP7Ecv4ouho
	 gTO+LE1fOkU6jt0SCCHK4Hlry9rbJiZ63iYJ6EsbW1Vt3ydKWKgfYkkl6hpIkilZpu
	 8VvF+KxAFFOcrlQJf6sanI/p8s9ToIXhBL6LU3/wYOFwler4j/6hgTk89O6iwoxXeb
	 cUVqO266yH4JmhUgYDUGmGlYaDl+mAR5afYUASajFHAE4W/+6xJZBNYDH73QdOaaOW
	 9hut1uEGZEZOFfSr3Pv3i5i2ysgpJWLsaw15VGKTudVEsI9qUaY/PINWIpnkbrtkxQ
	 snvn4l+0/v6MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A862ED8C966;
	Fri, 16 Feb 2024 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/2] net: bridge: switchdev: Ensure MDB events are
 delivered exactly once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807642668.24295.3565424545569620245.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 09:40:26 +0000
References: <20240214214005.4048469-1-tobias@waldekranz.com>
In-Reply-To: <20240214214005.4048469-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
 atenart@kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, jiri@resnulli.us,
 ivecera@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 22:40:02 +0100 you wrote:
> When a device is attached to a bridge, drivers will request a replay
> of objects that were created before the device joined the bridge, that
> are still of interest to the joining port. Typical examples include
> FDB entries and MDB memberships on other ports ("foreign interfaces")
> or on the bridge itself.
> 
> Conversely when a device is detached, the bridge will synthesize
> deletion events for all those objects that are still live, but no
> longer applicable to the device in question.
> 
> [...]

Here is the summary with links:
  - [v5,net,1/2] net: bridge: switchdev: Skip MDB replays of deferred events on offload
    https://git.kernel.org/netdev/net/c/dc489f86257c
  - [v5,net,2/2] net: bridge: switchdev: Ensure deferred event delivery on unoffload
    https://git.kernel.org/netdev/net/c/f7a70d650b0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



