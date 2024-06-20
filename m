Return-Path: <netdev+bounces-105090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C390FA42
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA342824F7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF5812;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OspcCQHe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC264B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843427; cv=none; b=PbK3eDkZFNBvgDJcNqVFwrSd5qAss855N1rAQmIb2Yw2ADxDPjWkdPUgvIyklVoTvsY6Lnn/lQqGXjNtDUXSb3uNWEIp2Um0xhH1jr6zi4UkYLPjQJEI+qTk16tf10fZQ7LYLJgNjYnTEbWIowcC2dqZUMq9eZuEa/dKv3WyMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843427; c=relaxed/simple;
	bh=RbnMyORlJDkxApcce7/DFBgODbmqVItgXLiKEPl0PAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fzGbz1XKRjqILzpftTJKJv77IHZEHgTrt8+KPEmBqwcAUNU3ozcnbgmXzDNC1fHzUH5/C7OS2YxP07d9pDsrLhU2974Y8uKcAbuJgmtbAw55xG3ZVxrHYE+A+VD+2SrKeoWowZOsMgwv+ckCYtvQRy3mcgLekyYUGOxrAI2eHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OspcCQHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21739C4AF07;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843427;
	bh=RbnMyORlJDkxApcce7/DFBgODbmqVItgXLiKEPl0PAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OspcCQHelR6pjKEDakAwsIpwKg5lDpo1quAStNupE5LwLVFG8RJuBvEEDYXKQc3oo
	 WAnwNWmvQpBwkdWfLgZfS92a4neUTozR1apz1hm2XXinFQRhZUcAkJirgfSl7IIUu1
	 TjaLy74IQCKnFl6fSC3WL3XkLioIu3uvJdH4vpgPYcujBvG6OxEI84kJsXEGaCa2/P
	 Kj2OKZlzSM+Ynhj5BGIhWo5TeU3MhEx8dBsvCiQB/8dagu/ftF44ixJi4btqdeWR5E
	 ma3QKF87X2hLjI3cmMSYzYGeUNQ6HxAgf1j9rIiwu/1JsxcPMrV2CorU+uRqhLHwzr
	 xf2vEG9serFWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04073E7C4C5;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: bring NLM_DONE out to a separate recv() again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342701.23279.7921455983431061153.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:27 +0000
References: <20240618193914.561782-1-kuba@kernel.org>
In-Reply-To: <20240618193914.561782-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, zenczykowski@gmail.com, sbrivio@redhat.com,
 i.maximets@ovn.org, dsahern@kernel.org, donald.hunter@gmail.com,
 maze@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 12:39:14 -0700 you wrote:
> Commit under Fixes optimized the number of recv() calls
> needed during RTM_GETROUTE dumps, but we got multiple
> reports of applications hanging on recv() calls.
> Applications expect that a route dump will be terminated
> with a recv() reading an individual NLM_DONE message.
> 
> Coalescing NLM_DONE is perfectly legal in netlink,
> but even tho reporters fixed the code in respective
> projects, chances are it will take time for those
> applications to get updated. So revert to old behavior
> (for now)?
> 
> [...]

Here is the summary with links:
  - [net] ipv6: bring NLM_DONE out to a separate recv() again
    https://git.kernel.org/netdev/net/c/02a176d42a88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



