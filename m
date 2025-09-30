Return-Path: <netdev+bounces-227325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C2BAC7BD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351701895868
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E272FAC1E;
	Tue, 30 Sep 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgobh+1L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB32FB0BA;
	Tue, 30 Sep 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228214; cv=none; b=PpCyZPlOv+KdAcApP1p/5SXz3SRmlu+w5TtQU3fF80MxrlaSLuHjgRtyK7xmXiLuVLqdIMs9pAQehtI4Ef7VPJsTy3J8m2Z0DfdhXZzsTO7yUWZ5ZoJ2BPp4lwfLB6khDSAPNThOT2bTj1A88Poekmqk6FEkWqFbRbRewSJPB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228214; c=relaxed/simple;
	bh=AsCJkDheuOSW53UPSObQrbQfEBY3mOxGOUX6VvHxZ1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n6h1k3qYrJIkSnOkUNsnbfRmjaQR4Qe0GihTcqA4rmWpGv7AxMdJQgGDhZMcHTo9onh8xQaAztTdEZ66PoSKv/yTZAf81jhIbRgitIjtrrO5/3iG0SLVLXVJYdPXNVIQorH8XRK1fpPyNbWpHMp7uHeKe1DB+dWwUlK500hW2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgobh+1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE93C116C6;
	Tue, 30 Sep 2025 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759228213;
	bh=AsCJkDheuOSW53UPSObQrbQfEBY3mOxGOUX6VvHxZ1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xgobh+1LMvaSknLKaq5CBEEK2XFN/hkY096AgxM8lAy5kQ2PEJnrMqprpeqwlRueP
	 9/LckfTdfjo/QD7uJ0Anp5UcrUo8P9GZOL2RWTWUyNOIZrZ85tf2Vl/Kpawcq8y9HM
	 BLt+0g4hKxfcUvRwhXqb2EheW3P42D167/g4tZc5JDTsZBOjeORb4/+bFBxvt76bvf
	 Y+Dp5qmf4qHa6zQImFamqHUiDODn1ak2gRNYrH1OZJvM9fGvdRUx4O2s6VfFCxu0HD
	 4VVM9VpAbG+VO9gJ5zfibjf07/3ErE3fmyoj2/QFkoXc65tFaJfZEbQHL6JCYj5M/n
	 cWtkcN1HkLlWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC339D0C1A;
	Tue, 30 Sep 2025 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] page_pool: Clamp pool size to max 16K pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175922820626.1932647.11640562683473449413.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 10:30:06 +0000
References: <20250926131605.2276734-2-dtatulea@nvidia.com>
In-Reply-To: <20250926131605.2276734-2-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: tariqt@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Sep 2025 16:16:05 +0300 you wrote:
> page_pool_init() returns E2BIG when the page_pool size goes above 32K
> pages. As some drivers are configuring the page_pool size according to
> the MTU and ring size, there are cases where this limit is exceeded and
> the queue creation fails.
> 
> The page_pool size doesn't have to cover a full queue, especially for
> larger ring size. So clamp the size instead of returning an error. Do
> this in the core to avoid having each driver do the clamping.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] page_pool: Clamp pool size to max 16K pages
    https://git.kernel.org/netdev/net-next/c/a1b501a8c6a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



