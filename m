Return-Path: <netdev+bounces-97750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DC8CD00A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C19B21DD7
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6C13DBA0;
	Thu, 23 May 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5nLTR5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829513D2AC;
	Thu, 23 May 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459031; cv=none; b=r7HiMaWh2YrKP9tvpLduRE/myMLlelmGssYFOENXWNsUqrOiT/cjlIltRSFf/rpnxg+dkKHLySUJiWTv9XeByEkhUWRjnJegkyvnMhHiSXZEO/vXW//XV9UWMbfnu5kPbtRvhhDc32xlLwgFkw3Xt2d6jFhHplwP+NWAnC4BVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459031; c=relaxed/simple;
	bh=AVlHMNqQ8YOMTj4Ev+PcFyPtq/qcdCJXmOz0WSynywA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqpiXPhEavVVW3WNY298KPHtQLl6JbLQV+SutGAJKyIh0qjVxGHY7AMzGC4oi+Df/pIblEcqS6d7rDj71h1wB49KNYxuAKfr1KLE0MCKUPrTNyXejK1hF8zFOH59uRy/rzYKTQxQCSO3V3wQObtZHdkwy6tMQkZlDLT8KqkF5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5nLTR5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD7B5C32782;
	Thu, 23 May 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716459030;
	bh=AVlHMNqQ8YOMTj4Ev+PcFyPtq/qcdCJXmOz0WSynywA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J5nLTR5Ar8+IpRTlHKFUXuCghdlH060a1QTqXCRgUq0XNxPd9Wbnmj0D5z4MIEwWY
	 5Nw2O8B9556+7dwkb9OXzQ/nTMGU4tbm0Nx2s0X3d7Ob+41A8BPFjT4+42BxuDmjnX
	 hYytcxY9XJ/R7ncwyMc9pH1xA4VP5VQWUjvA9P3RNej2Ke/pf4+EAEpoOd9fkhvWcV
	 r5sixFGZoAo5mnhCfk29/FuyVYSXFudZBmsP+KGM7wacyo7uQzO/54uF2tagBnZtH+
	 K3ltUauSwiZko8wc7UFFSbAptlgDst7F5GwSwqxGFTSrTluw1ZQeSQSpTw44b809pO
	 TRI1PwxwrRa+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6D1DC54BB2;
	Thu, 23 May 2024 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tls: fix missing memory barrier in tls_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171645903074.11345.3099583287583729636.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 10:10:30 +0000
References: <Zkx4vjSFp0mfpjQ2@libra05>
In-Reply-To: <Zkx4vjSFp0mfpjQ2@libra05>
To: Yewon Choi <woni9911@gmail.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jakub@cloudflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 threeearcat@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 19:34:38 +0900 you wrote:
> From: Dae R. Jeong <threeearcat@gmail.com>
> 
> In tls_init(), a write memory barrier is missing, and store-store
> reordering may cause NULL dereference in tls_{setsockopt,getsockopt}.
> 
> CPU0                               CPU1
> 
> [...]

Here is the summary with links:
  - [net,v2] tls: fix missing memory barrier in tls_init
    https://git.kernel.org/netdev/net/c/91e61dd7a0af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



