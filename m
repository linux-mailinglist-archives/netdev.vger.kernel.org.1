Return-Path: <netdev+bounces-86815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A88A05D6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289671C22272
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF057FBC3;
	Thu, 11 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9HlPASZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E177FBB2
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802630; cv=none; b=JCl9+GaxRQgYAf35/x0D+slosLs35L7/hylaI5sHmrtunNZ9qn7lvyTVTNAnfKNz9zEaFqui9ehNKt7QPmv0nfb8gIoqlH1EEus3Unt3lvGOz8kdm8TufNWQBfCcEP1XNVh8hUK5uhxmh+uS0qxYsTBVdHDip5cPXw521tXG/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802630; c=relaxed/simple;
	bh=+i/byAH7SxwWRNr1aM4Uu/HwbCjfc+pYplc0arG3aK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j8SWdt8P38ufBRUnOm9WHBYe9eEQtEziVVflDaP3/BkPh5kT6PH+LGLQsJGuMALgO7VvQvFbC/zqJ8OPjBWIbcrkUv4fZLWArChZYlx/l1nkdm0ZEbKY1wl/ISDrp5g+cYoKZXbUsnks3O3KGGeiJj7re5vryNBBP3oIUxnb7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9HlPASZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14550C43390;
	Thu, 11 Apr 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712802630;
	bh=+i/byAH7SxwWRNr1aM4Uu/HwbCjfc+pYplc0arG3aK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9HlPASZ43710NpCAkMu7fAbAbpciGQlHFknzhDvnb9E1kF6yPb0pZ3Qvow0kfP9Q
	 zva0ff21L/xZrmvJgSGqzYhESPE5CnyooZCPDJM9H1haH0QqJaMOikWWAGtoWpB0l+
	 Yr8B+XQz4pLvTpEKHxh9xfMgNbqz9zb8X2oTMT3PGuHoKlKYdYalyukXVR7SFCfOaE
	 PQmHg54rablYKe1Anl1KWcXn7dd6smbRn1E7oDYQHS0sLX3qOHjrHPFfs5/sKKzYFO
	 XNuW+SW/sjkT0wulMWcvidQcZDOzSjb2EF9FbL1JLh2JXZUDsLOl2NS2jHpFL+clgD
	 vuj/CVxbRaCyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 065CCC395F6;
	Thu, 11 Apr 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] optimise local CPU skb_attempt_defer_free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280263002.16770.1029499068572566543.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:30:30 +0000
References: <cover.1712711977.git.asml.silence@gmail.com>
In-Reply-To: <cover.1712711977.git.asml.silence@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 02:28:08 +0100 you wrote:
> Optimise the case when an skb comes to skb_attempt_defer_free()
> on the same CPU it was allocated on. The patch 1 enables skb caches
> and gives frags a chance to hit the page pool's fast path.
> CPU bound benchmarking with perfect skb_attempt_defer_free()
> gives around 1% of extra throughput.
> 
> v4: SKB_DROP_REASON_NOT_SPECIFIED -> SKB_CONSUMED
> v3: rebased, no changes otherwise
> v2: pass @napi_safe=true by using __napi_kfree_skb()
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: cache for same cpu skb_attempt_defer_free
    https://git.kernel.org/netdev/net-next/c/7cb31c46b9cc
  - [net-next,v4,2/2] net: use SKB_CONSUMED in skb_attempt_defer_free()
    https://git.kernel.org/netdev/net-next/c/d8415a165c43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



