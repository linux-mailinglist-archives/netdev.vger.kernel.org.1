Return-Path: <netdev+bounces-91679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABE8B3697
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FF51C21B31
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44183145323;
	Fri, 26 Apr 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZPu2kXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56213C9A7;
	Fri, 26 Apr 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131629; cv=none; b=BXf5+1KKvHfi94oY1a3jbvwDe6q52QeL1WwQkRORQO//TfhCCrhTm8ci4Y8gNPXYFAvI2VJjyK9ReySzHx+tzaKzP3OglBkvGwjG5h9Vu2hUXZKqzTkdsn6Da0pph2BzQDuBHs7IjJRyKfgPj7l/g9b6+Km7g8uJeD9XTEg3HTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131629; c=relaxed/simple;
	bh=agbwdhuU3YPBQwaDyikjiS2/LPICiWPVYBvKdl0MP6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=COHRsKSZnHcvoyBVy824aPZjPic/ltvrZJcAEAoSkVv5bc2EWpTirh2xcQmtXo1FJolM59d/zmfYI9HUnAs82T8z/12kFNm0ZGhJh7ElXooL2HGe1S9R2jBx+VwVYNk7slqnzLTHiLPIFS3F3vHfOuF7FT5z2lkYdn8rht+y1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZPu2kXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8205AC113CE;
	Fri, 26 Apr 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714131628;
	bh=agbwdhuU3YPBQwaDyikjiS2/LPICiWPVYBvKdl0MP6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZPu2kXatE3V2mVVNSwGLdZBftl3nUJGTAYnrM67YashyM7r0x/8O5H4NYYk0ud8P
	 aK+q/V4rZi/kOTGRvwoHElbtqaeMaDiQEt0B7gJEoW5Tv4tf54ZA2s/RtvgkaJIVZL
	 x8FceX0AI4QoUtfhslsOGTgHXKuH0Lll6mfEpo5Ew7CD+Nm8ZyWMWcZHxSR9qwT/ar
	 AOLBb/p5iQ3fgN5RirBWaxq0h2eMi7xOpEKflAAbkmS04kZ/UtYRo1wetByJRih3yw
	 qtLvK+i7Iy0G6CEtWf2hRMKCkViMvZ1/lbp5DFLajGVxFlUJTiOYGGdIbJBoZrO9sk
	 drzhWmCe1OdPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71D0DC54BA8;
	Fri, 26 Apr 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v6 0/5] selftests: virtio_net: introduce initial
 testing infrastructure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171413162846.3079.6495218393722854548.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 11:40:28 +0000
References: <20240424104049.3935572-1-jiri@resnulli.us>
In-Reply-To: <20240424104049.3935572-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, parav@nvidia.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
 petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
 bpoirier@nvidia.com, idosch@nvidia.com, virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Apr 2024 12:40:44 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset aims at introducing very basic initial infrastructure
> for virtio_net testing, namely it focuses on virtio feature testing.
> 
> The first patch adds support for debugfs for virtio devices, allowing
> user to filter features to pretend to be driver that is not capable
> of the filtered feature.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] virtio: add debugfs infrastructure to allow to debug virtio features
    https://git.kernel.org/netdev/net-next/c/96a8326d69ff
  - [net-next,v6,2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
    https://git.kernel.org/netdev/net-next/c/41ad836e393a
  - [net-next,v6,3/5] selftests: forwarding: add check_driver() helper
    https://git.kernel.org/netdev/net-next/c/617198cbc69d
  - [net-next,v6,4/5] selftests: forwarding: add wait_for_dev() helper
    https://git.kernel.org/netdev/net-next/c/dae9dd5fd9f3
  - [net-next,v6,5/5] selftests: virtio_net: add initial tests
    https://git.kernel.org/netdev/net-next/c/ccfaed04db5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



