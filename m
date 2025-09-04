Return-Path: <netdev+bounces-219993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA9B4420F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCA57B8069
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E42FD1D4;
	Thu,  4 Sep 2025 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTdhbmri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0D260586;
	Thu,  4 Sep 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001603; cv=none; b=VBXbvCvk4sFvlwn6kIyIV7Vk0v27wqkkKc1rJS7qCVHVu8ZbrAnYl8T3t1SYnRsnSxx3E+yvDBhGmPPOBkh3sGnVG+XlxLrvS/gK+5u7DDi2etHk6pOqwDiav0qfNzsHUiAIOh2TvVwwVsvJDSwQeskv7s41W7t/GPBkc+hzEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001603; c=relaxed/simple;
	bh=KjoMGLGjgWoFh8AlJ891PLNMSjlkafNtrJairpB2s0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvOGc2fIHjnTuopqoKUe+g1TH0GetFsOMhI2hUDuxtqYBbQ6R5iZaeUBKAUXhYRQ/GNMwyB+xpziT0glVg4peZMShdKHy0bNLsupzxXUiJZiIlga3v9ragI3YUau/mBbWDmenC3jYBNfaJoDvOOQHPXMsq375/KNL7m0hHBtiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTdhbmri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E854C4CEF0;
	Thu,  4 Sep 2025 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001603;
	bh=KjoMGLGjgWoFh8AlJ891PLNMSjlkafNtrJairpB2s0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gTdhbmriEfVR+e7GdGu+mJtn7DTJqp1gDkcmkVbJrw0dfd76i6XntDvOQAdsYm4/l
	 cfcXqCAUPxdNdiRjjFOi0UppfdfNkRkcMUtjn95+SajANhcJWk7cxbGGcVZJ/Ync8o
	 X37oiD8ooGI8ELM6D73qIfQhcQeAFlmmzypavnhu/yfh08mQkoKOhAv5pgs/EjpeGm
	 AgIXnMghloSB8YZpcXThvSJbSq3eqEzMvKl6XpfTCDENSFab0xs7IXdU8W6XYTQdPU
	 cFrTlemkj6zojSlhFMG6BvjrVxxxZJdEbpQVQXUYxjjzT0efIbe56c0m0n/mIujmMj
	 mGLBVssVUj1hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF4383BF6C;
	Thu,  4 Sep 2025 16:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: dsa_loop: use int type to store negative error
 codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175700160776.1861500.1788148261936427607.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:00:07 +0000
References: <20250903123404.395946-1-rongqianfeng@vivo.com>
In-Reply-To: <20250903123404.395946-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 20:34:03 +0800 you wrote:
> Change the 'ret' variable in dsa_loop_init() from unsigned int to int, as
> it needs to store either negative error codes or zero returned by
> mdio_driver_register().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing.  Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> [...]

Here is the summary with links:
  - net: dsa: dsa_loop: use int type to store negative error codes
    https://git.kernel.org/netdev/net-next/c/a50e7864ca44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



