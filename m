Return-Path: <netdev+bounces-54282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A08066DD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC221C2113E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AE210A04;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af16gclA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B41097C
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39AB3C43391;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701842426;
	bh=V5hmVzSBPr6M4xu9MIYj20yq11HnUYPkhU/NI8oRWKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Af16gclAoe4xUxJaKuwYBYFLqMrsfp3jgrAGg+tw2wdynplgphKH2Mqqv+d4iYHNE
	 4eans8PQbK1LWL/Zwp1KuqhqkCgaOFqQUHde2PE7AiAO3Ktx9hkIWVkASHqka4Drng
	 eDe/r+7AzPdRdrKLZIL5/OOjmGJcoWTu8ow35wjEbMHyG9QeI02f9gkX50eKM3VH/H
	 kd/aYZYEuNzSDtn6YFFzEsiQpCGDhCVjURUM1HoWc9TPda8rYtgX8OYy5GNZr1hqhx
	 Ca98wEkrDZMr8FNZJ2M8xbTKL8ZZ5dieVnsOl4jcI5cEGfnx/CxLpbeYkjvHzLvCsU
	 pcvo/442gXgjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 247D7C00446;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ionic: more driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170184242614.7312.1176486162524144158.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 06:00:26 +0000
References: <20231204210936.16587-1-shannon.nelson@amd.com>
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, f.fainelli@gmail.com,
 brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 13:09:31 -0800 you wrote:
> These are a few code cleanup items that appeared first in a
> separate net patchset,
>     https://lore.kernel.org/netdev/20231201000519.13363-1-shannon.nelson@amd.com/
> but are now aimed for net-next.
> 
> Brett Creeley (4):
>   ionic: Use cached VF attributes
>   ionic: Don't check null when calling vfree()
>   ionic: Make the check for Tx HW timestamping more obvious
>   ionic: Re-arrange ionic_intr_info struct for cache perf
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ionic: Use cached VF attributes
    https://git.kernel.org/netdev/net-next/c/15e54faa5d5e
  - [net-next,2/5] ionic: set ionic ptr before setting up ethtool ops
    https://git.kernel.org/netdev/net-next/c/46ca79d28fd7
  - [net-next,3/5] ionic: Don't check null when calling vfree()
    https://git.kernel.org/netdev/net-next/c/2d0b80c3a550
  - [net-next,4/5] ionic: Make the check for Tx HW timestamping more obvious
    https://git.kernel.org/netdev/net-next/c/ab807e918342
  - [net-next,5/5] ionic: Re-arrange ionic_intr_info struct for cache perf
    https://git.kernel.org/netdev/net-next/c/5858036ca056

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



