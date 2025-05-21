Return-Path: <netdev+bounces-192134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44464ABE9BF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C28173F58
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C1221573;
	Wed, 21 May 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc6Az6zH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBD1C6FFB
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793994; cv=none; b=Q3cHUEpoYfb+a4UBlP7E89IYpu4gawN+JqSTgqJhtdfbS456vOv/LyBv/vkc4oqE2grt38TN96ei3eUTWf7gFk8xumU8YszcLxbJkrkf8WW67MZZYIYIgCh2DdKvul6NS1C9cEIyD7bJs4ELzLqvn+/S4zimrh+kgnKDpszJlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793994; c=relaxed/simple;
	bh=EANUIfgDDx/hKNCkuuC22gdQ+KeR+WYArSYV5jFClpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rb5ogRPSfvT/tlBiQbAYj3/XEbL6pfoWGwIBahSCTnRGt5M1qMQqr2O5/1fZlPJDlTddcZ5F7lHjKc7TdPlpfyc4iTPhOC0y9AEaM1Ze5d+hjJbi7nn9NJgorWeIRW2jPGteXStzDYWYqAiApHzaXB6qlID2uWUmLsABq1K+GKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc6Az6zH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2BC4CEE9;
	Wed, 21 May 2025 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747793993;
	bh=EANUIfgDDx/hKNCkuuC22gdQ+KeR+WYArSYV5jFClpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oc6Az6zHDFWeV0rSia/efKXtyOygoixGAyYLM69qoRUa2+XkxlSL04VeTzlzDBdQ5
	 a3851amUq58k3b8jfniO2+46IXKcL+RLhe/xc4KMCjxAc0WU4bfTXVI81sm0LSrCL6
	 YHnASdACvW7LN8liHWBYgI5mr7sB3bv1E78qqr44LdhzkIweCYfTO2/c4RTPDCd6em
	 4zrWl8ke1Ncs5j7VpY5jtITyzTkrs3pFjbmVaDWJrs7t6pTF7gYueukx50pahYrIBh
	 7cY2yHp023OUSwqdzHB6qrEQ3kX4UugrnvBvK0oJhQzTczysL3webfGMlQq9PguXys
	 3jGK8jr0G+AHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E12380CEEF;
	Wed, 21 May 2025 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: 2 bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779402925.1541325.15423608919543266282.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 02:20:29 +0000
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
In-Reply-To: <20250519204130.3097027-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 May 2025 13:41:27 -0700 you wrote:
> The first patch is a bug fix for taking netdev_lock twice in the
> AER code path if the RoCE driver is loaded.  The second patch is a
> refactor patch needed by patch 3.  Patch 3 fixes a packet drop
> issue if queue restart is done on a ring belonging to a non-default
> RSS context.
> 
> Michael Chan (1):
>   bnxt_en: Fix netdev locking in ULP IRQ functions
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Fix netdev locking in ULP IRQ functions
    https://git.kernel.org/netdev/net/c/aed031da7e8c
  - [net,2/3] bnxt_en: Add a helper function to configure MRU and RSS
    (no matching commit)
  - [net,3/3] bnxt_en: Update MRU and RSS table of RSS contexts on queue reset
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



