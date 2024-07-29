Return-Path: <netdev+bounces-113582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65993F231
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4228429C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC4143863;
	Mon, 29 Jul 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGB5Lry4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B214373E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247686; cv=none; b=WuHap6BY2BuWL506SulyrHdJfqj2R+M9FBanxTzsxiAcr9ZAQFdYlizzL9wvCgauHY6ff/srukWsnM5OVGeisNunZWWmjU6VCsrBKaXwJqn4WulUXSzLxHhhawowCA6nKuJdIvX2gqplNWLADw01v1X5ow7xa0b0kEiEfArkJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247686; c=relaxed/simple;
	bh=+gqGEuCq9nnoR1nUhYBaWx9iQzFgIyHsqyCrbEanieQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmAeSFGiUv9QzkV3ormYglHn0g8N0qgCJ1zt2nExubqC/K1RMooHldIeojq77MaLLKOJ4atoI2zIYePoq4ldF8Mk83w2PuU/bi+T6LecSzwCNZcyAiEFtY8yBj8+x8kv23nOssw3KavApdzPpCK8r3uTgVU/8ghLvpM7IlrQV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGB5Lry4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 835CEC4AF0C;
	Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722247686;
	bh=+gqGEuCq9nnoR1nUhYBaWx9iQzFgIyHsqyCrbEanieQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dGB5Lry4jQm8wZN0nTBVadwnHGUKUcreq/xI2Dq3VlrA3/fXV43Xp6QlGKMMysN5B
	 ftSowwqLKtsdmUljZ89tl2ftcUfK2xelQ66BicjapH2eX/CgZ0EVPJBYEvMf8efQ1D
	 SiCJoGvXNe1GlSFDSs6LmqZt73uca9eolqF3ivBBKHSRMOP05JnjfDKIjrWEUE0EFF
	 leoKKigU7KM0YPxb/bTQPhK8jNzf7itgH8uCt7PFW1eGwf8uBscXWHQu2e63PXJlLY
	 WoJ8cu0V8l1tdn4Y2kZeJGnzwV/h77a7wI4gFVlMv7t17psKxzjqXKvpEivZeMDnYt
	 U5uCtvUTQfl4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75834C43443;
	Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] ethtool: more RSS fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172224768647.24246.8753503956784144711.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 10:08:06 +0000
References: <20240725222353.2993687-1-kuba@kernel.org>
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
 andrew@lunn.ch, willemb@google.com, pavan.chebbi@broadcom.com,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jul 2024 15:23:48 -0700 you wrote:
> More fixes for RSS setting. First two patches fix my own bugs
> in bnxt conversion to the new API. The third patch fixes
> what seems to be a 10 year old issue (present since the Linux
> RSS API was created). Fourth patch fixes an issue with
> the XArray state being out of sync. And then a small test.
> 
> Jakub Kicinski (5):
>   eth: bnxt: reject unsupported hash functions
>   eth: bnxt: populate defaults in the RSS context struct
>   ethtool: fix setting key and resetting indir at once
>   ethtool: fix the state of additional contexts with old API
>   selftests: drv-net: rss_ctx: check for all-zero keys
> 
> [...]

Here is the summary with links:
  - [net,1/5] eth: bnxt: reject unsupported hash functions
    https://git.kernel.org/netdev/net/c/daefd348a593
  - [net,2/5] eth: bnxt: populate defaults in the RSS context struct
    https://git.kernel.org/netdev/net/c/9dbad38336a9
  - [net,3/5] ethtool: fix setting key and resetting indir at once
    https://git.kernel.org/netdev/net/c/7195f0ef7f5b
  - [net,4/5] ethtool: fix the state of additional contexts with old API
    https://git.kernel.org/netdev/net/c/dc9755370e1c
  - [net,5/5] selftests: drv-net: rss_ctx: check for all-zero keys
    https://git.kernel.org/netdev/net/c/0d6ccfe6b319

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



