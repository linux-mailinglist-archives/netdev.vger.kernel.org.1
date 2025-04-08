Return-Path: <netdev+bounces-180087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCCA7F7A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156041899A16
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED63254B1A;
	Tue,  8 Apr 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgKpIZ+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6682594
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100398; cv=none; b=W6kLOLmM+uFfhJJLbidyk/MmpocbcVDnPujae9Mn0h71GMX3I17OK2rVBs0J6OnEw4Ktqg8WeglWFHsLUV1q2V079wkfng8b4MLBJ9hIYPUPlCaH0CSDOD/q2orb0svMotrGXjp9w8bhxYEv49giJufnxqcqM/JAEsQJRlFT5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100398; c=relaxed/simple;
	bh=b5OAQmbLJ7VnJvfAaJBBQriQpTl5GUEPjznNGdJlXi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TALD5B8aMOPTJzEl1WubSBR+AqHVRrPePsORrLzouV6oOXpJI/LJHYuK3OtyJIAkuI6zIOIqr+WkJ9UQD/wxhV9WExU1JvA9ZxqXr4KP+oQIHtAN3uhKPBjiLEIhIe2zFLmT2ugnZe7S2pLzPqSjNpP6XhUGRmlA13960Rq+F28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgKpIZ+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E84C4CEE5;
	Tue,  8 Apr 2025 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744100397;
	bh=b5OAQmbLJ7VnJvfAaJBBQriQpTl5GUEPjznNGdJlXi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VgKpIZ+VBTl3pRt0iSNOcvBmaJS9fWAarXs+EC6BydvN+1jQOUFaPqFqMXYX35NWa
	 9ljeOIqYXnVBO2LsF2HfLIpJ9G6a//3qGE0FGPtouafyKNRLJbSkX5nKNkn8zwjI5+
	 eSbLYjfPL98QoMpvtn4aYCM5kcNHv8u79+0XOerY8GUzrqNBbv0XkpqWbLHVhuXUVF
	 ajo05PmP3sKpmxD4V9lt6yrkHz66PUYA/84lpB9OMxYjPzWg6uDu/PMN0cGzDbG7Q9
	 /SMaPesfGCSUzcB9mE7aq/2EiQAHsHi5PFjajq87aVl87H6+xcv0AosJYv4oX2Mc8Y
	 L4/tHaoF38D6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB10938111D4;
	Tue,  8 Apr 2025 08:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix memory leak in tipc_link_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174410043476.1814045.4887693638217026540.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 08:20:34 +0000
References: <20250403092431.514063-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20250403092431.514063-1-tung.quang.nguyen@est.tech>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  3 Apr 2025 09:24:31 +0000 you wrote:
> In case the backlog transmit queue for system-importance messages is overloaded,
> tipc_link_xmit() returns -ENOBUFS but the skb list is not purged. This leads to
> memory leak and failure when a skb is allocated.
> 
> This commit fixes this issue by purging the skb list before tipc_link_xmit()
> returns.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix memory leak in tipc_link_xmit
    https://git.kernel.org/netdev/net/c/69ae94725f4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



