Return-Path: <netdev+bounces-205070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A98AFD046
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15617B238C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA172E6D22;
	Tue,  8 Jul 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkct76HD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BE2E6D18;
	Tue,  8 Jul 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991000; cv=none; b=Skw1xRwJx4/1JQWUkYwUCVbrTqZwMVxp5YqCoYa6EbW/YmywxSFnpzbnYlStSxnqju+rHJptl2gz93NW2cj7A5LFAWeU63q/bHcbJceErj6A5aU0oIuxKlqq5tEsTABax8SlC9x8w/p08hBfI+Yul3ih4pPKTNKeYrbtoq4yGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991000; c=relaxed/simple;
	bh=/U+djxtxcz7xaxB58UB3neZfXsGfujNvwf55x7mZFZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JXxnA0ul8DevT79meWstH69HwE+cnvTEoeexzw6hx1P+8+cnKhSCbIF6olL0rY4k1P3oSOQ2JJCsFJQHndCuYegAOApQEJouC/Fwj/rgOfAJzqtxdbua5pOW8dfiqsGLNxP+9Kyg8jKNaJiPtzNkzyKYwZUltg2cKOgTbuAW+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkct76HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63AFC4CEED;
	Tue,  8 Jul 2025 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990999;
	bh=/U+djxtxcz7xaxB58UB3neZfXsGfujNvwf55x7mZFZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkct76HD3RT/Ml6jkskFkwHrCdJMWhREZsR3XSJfNgJEHp3cpeB/Lqt1Gp13RhqHi
	 YPnpTgKgHAmXSKjdCERJ1qBdeP7MCHnyCYn98OiV8MNd1AAz+/sjBKBf7CCZ1qtkY8
	 k6PPj0H7W2Ze1Rlt4w74xvY5Z4IYMAwZic522v+R0JSU3rbylw+dvnd6n+Go0i4A5Z
	 keTDT3jYDBRNGNb5pGOAo3HFuUDgs00gYlrzCeXDFS5LaBLYfIgCUgN4T+ftJS4HMC
	 Q0nmk4w/i6+uEcAUk5LkhfCdDVJG8mVDB8MTJYsKOWTIjLCrE+lxjy0d9qCu/hv+lt
	 wM8iH2DSOjPtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE21380DBEE;
	Tue,  8 Jul 2025 16:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V5 net-next 0/3] Support some features for the HIBMCGE
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199102257.4122127.13073135460123563655.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:10:22 +0000
References: <20250702125716.2875169-1-shaojijie@huawei.com>
In-Reply-To: <20250702125716.2875169-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Jul 2025 20:57:13 +0800 you wrote:
> Support some features for the HIBMCGE driver
> 
> ---
> v4 -> v5:
>   - Use PTR_ERR() instead of IS_ERR(), suggested by Andrew Lunn.
>   v4: https://lore.kernel.org/all/20250701125446.720176-1-shaojijie@huawei.com/
> ChangeLog:
> v3 -> v4:
>   - Fix git log syntax issues, suggested by Larysa Zaremba
>   v3: https://lore.kernel.org/all/20250626020613.637949-1-shaojijie@huawei.com/
> v2 -> v3:
>   - Use fixed_phy to re-implement the no-phy scenario, suggested by Andrew Lunn
>   v2: https://lore.kernel.org/all/20250623034129.838246-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Fix code formatting errors, reported by Jakub Kicinski
>   v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V5,net-next,1/3] net: hibmcge: support scenario without PHY
    https://git.kernel.org/netdev/net-next/c/1d7cd7a9c69c
  - [V5,net-next,2/3] net: hibmcge: adjust the burst len configuration of the MAC controller to improve TX performance.
    https://git.kernel.org/netdev/net-next/c/1051404babef
  - [V5,net-next,3/3] net: hibmcge: configure FIFO thresholds according to the MAC controller documentation
    https://git.kernel.org/netdev/net-next/c/401581f2863e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



