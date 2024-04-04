Return-Path: <netdev+bounces-84686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0603897DBF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82978288421
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8CE3838C;
	Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQCKDK5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684D29403
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197831; cv=none; b=i7uWjnAR0Lb/2pxl8X2jb+ZVt2hacd6f2sDNZs95bf6lMDpmEDNeu33LXmyQJk+768CoOOFyhE66vXGirKy8XrjIRgba4L32NfzN7ujaheJQFqZZoG7Q3LRt3yhhP0/9Iq7TmeYGGndpcAuRte16xWxEOOxtqOeFtj3EwWUxxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197831; c=relaxed/simple;
	bh=EQd+X+ecPiXrVYU6cojYOvch3t0FpvsIbLn7W7OAuCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5rXzVkA0e+81kCRtXmtqGGr0YND8gbKLj1elOv+mW9jVQob4oQe+gojUCYeUkfnmFavcr3x465bUhQwzp6wP3WImYvbu8eMw8v4NOZ7Pos/2QDBI8qEDBjFEnL4gace+6oChPDNcoFJBQyGo+2nUwWlr66D8/D0WYPFKFx+Wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQCKDK5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0492EC4166C;
	Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197831;
	bh=EQd+X+ecPiXrVYU6cojYOvch3t0FpvsIbLn7W7OAuCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQCKDK5+3p3orAe/JxTUu1xb6sP01r2qBjLQ+NWXcyff67M2wbZnVxiGAhuTssNQC
	 zRaM9mvV8jmiYguqBIxIrLtyFiFb0XuNRkVi0Zfc1cBrQKdp0AFFE/iFaIMCMeIO9K
	 NYd/1+zAfzbSDSDPxCxAIOlzyJ/W9THGq5h8OqL3Y7pZuMqjXZzgeeQVAHNSUO9y15
	 0QPeM+ikJdN5w8Tk7bq68Lxk1ytyEm5tLg0B04JgKdZ+BQwOgoFNGxShbkY3CuI2aj
	 XPP2oaavbrxhbW6EIOvoJF334V9y5XvrTkGKRWTEduOOdSt8pEIPuqGWRwfX6ZP1Yu
	 1ZDOlBHBVAGfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEB8AD8BD16;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next -v7] net: enable timestamp static key if CPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219783097.25056.18126922100126693626.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:30 +0000
References: <ZgrUiLLtbEUf9SFn@tpad>
In-Reply-To: <ZgrUiLLtbEUf9SFn@tpad>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, kuba@kernel.org,
 edumazet@google.com, frederic@kernel.org, vschneid@redhat.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Apr 2024 12:36:40 -0300 you wrote:
> For systems that use CPU isolation (via nohz_full), creating or destroying
> a socket with SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
> SOF_TIMESTAMPING_RX_SOFTWARE will cause a static key to be enabled/disabled.
> This in turn causes undesired IPIs to isolated CPUs.
> 
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
> 
> [...]

Here is the summary with links:
  - [net-next,-v7] net: enable timestamp static key if CPU
    https://git.kernel.org/netdev/net-next/c/2f3c7195a702

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



