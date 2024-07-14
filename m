Return-Path: <netdev+bounces-111346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35730930A6E
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667F41C20A39
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734ED1C68D;
	Sun, 14 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOQ5mWFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5887F
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968632; cv=none; b=OaxewRZHFdaSw4ZuRS6zfiqDNwGySRoHs8hwFC1MZp+2o7T34Ep8QICXj34/+a3gyNgbgBSjxJLdIgUJ6dc2kByLbRCw9qGeoUlG3KzNPzyhqgkNb24PbUr8w5cu1AIrpm2SLguhKp0Csu61RWQsM9U7M0UWczfIagS0Drw2OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968632; c=relaxed/simple;
	bh=nE+uEky6BZWAIQhdnO7TqXN23dHBjhroBAWBLL1IPTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwviX0bO2ZuG7uKc+7u52/u18/BOeoxY3JwmIa2P9+vQ+7cpK/8XNA5wjLE6psGQUBjt/JugOubA3i0o8TVGEyX1/JVBk7Lqcm7RzileVsX324V/HW+EFqGa7hL0Ci0RGcyOEGy4sAV2ey7rcRxG7qBPkgwrgb5edmkDiqC/XLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOQ5mWFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5BAAC4AF09;
	Sun, 14 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720968631;
	bh=nE+uEky6BZWAIQhdnO7TqXN23dHBjhroBAWBLL1IPTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JOQ5mWFLkJI0Vf3ORPocG0aB5XLmyxKeI8lcoMwwRJZOMaTBwcalSNw5wOKcyGJfF
	 1d8oo9KydLz7PR0m7/y5PZkuW1/JU8mdc9F1XkJy2PUAQ0pa/+IqiZ177vhrKoLqgJ
	 48NyY62zvq09yAeNZwmg46ny/168m86aR3wnkG7NkV3dmRkZhp0wBhMfsvIea8zYHc
	 2OTLqlh7Nr6fKxJslF08p/+f9UeQI2uSnA+7O4yor8+kofFOjsK5/acKu37x8IXEXg
	 ESaGcElToCFbPzO2pcYtdJXnvqH83ScCmRCrgvM/OwR8BAD7pxYOhPaMAkYUEmcCai
	 oTHJU/4xMVgsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4105C43168;
	Sun, 14 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] ice: Switch API optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096863173.6543.16540997870486665772.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 14:50:31 +0000
References: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, marcin.szycik@linux.intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 11 Jul 2024 11:13:03 -0700 you wrote:
> Marcin Szycik says:
> 
> Optimize the process of creating a recipe in the switch block by removing
> duplicate switch ID words and changing how result indexes are fitted into
> recipes. In many cases this can decrease the number of recipes required to
> add a certain set of rules, potentially allowing a more varied set of rules
> to be created. Total rule count will also increase, since less words will
> be left unused/wasted. There are only 64 rules available in total, so every
> one counts.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: Remove unused struct ice_prot_lkup_ext members
    https://git.kernel.org/netdev/net-next/c/e247267bbeaf
  - [net-next,2/7] ice: Remove reading all recipes before adding a new one
    https://git.kernel.org/netdev/net-next/c/c563908494e9
  - [net-next,3/7] ice: Simplify bitmap setting in adding recipe
    https://git.kernel.org/netdev/net-next/c/3125eb559590
  - [net-next,4/7] ice: remove unused recipe bookkeeping data
    https://git.kernel.org/netdev/net-next/c/589dd7145a8e
  - [net-next,5/7] ice: Optimize switch recipe creation
    https://git.kernel.org/netdev/net-next/c/2ecdd4ba47fc
  - [net-next,6/7] ice: Remove unused members from switch API
    https://git.kernel.org/netdev/net-next/c/1d2ac128531e
  - [net-next,7/7] ice: Add tracepoint for adding and removing switch rules
    https://git.kernel.org/netdev/net-next/c/e10989e56f52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



