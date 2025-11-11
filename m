Return-Path: <netdev+bounces-237405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D239EC4AC91
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046AA1889232
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4A341AD8;
	Tue, 11 Nov 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KClteFWs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A1341AC8;
	Tue, 11 Nov 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824651; cv=none; b=o44be6JNAa0v/YQordHGOxyByeyHG9pBt9kqEJ6Q4FKYh4iegIAXTtkJovi243ZQMjC7ZskWy1kXZP/YXPvciinJWctbI09d+itWKhkKDDESCw1wtq/AhdJ6qBDufOeKONNts/s60MhYZ2f2WkTqax07LiyintdTW0wQi5LjdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824651; c=relaxed/simple;
	bh=1tX4uyd8Az7PpfFaw7bnLdYYdll9uXQAPbBlgw/+wDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i+4Xsqn4rQziNU7sUvLQ+v+UxXYVwWz36XxFf0NwF2nwrvr1Ge3lCdRaAX3GVdsQfrl5TclP6feS18NG4GmhCmi7gAsWvdX6aKi7CyzLl1TkG0ig5CzykHyJ9tsv8yjE6gxKA94er7+3O/sB5cODt43niBqKuduDKtqAlr2Ewzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KClteFWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64036C4CEF5;
	Tue, 11 Nov 2025 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824651;
	bh=1tX4uyd8Az7PpfFaw7bnLdYYdll9uXQAPbBlgw/+wDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KClteFWsRfPu+qAcNfN66HUrAfL96k/22R+bx0z++Sq813Kt2n46/7tRTmOteLf10
	 Hmpbj9Md09fn1/RW4k4lMe14erGVlkz8HBwzkvccnZpnVJgDT1gs5zaD/8erK7bcNX
	 5f7uA/sErcOLctzKjhLNkZqJb861nDfpTW4LsWpkEbHG3u0uk4hooTQhAp+vkG5WJq
	 gFkURP8WJFz0m0a/ZRCYp+Nti5U609vO1ceFLhOX1Gjlsbu9+VOXUAOGJk2WEY0PSW
	 polbWYfzKDjJIXlszFxj59NquUx2vIZrqOmi8FqLE8y5MipWYTa8wRKB/6sEsVZaqY
	 hHmS6h5P6Vlyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34116380CFD7;
	Tue, 11 Nov 2025 01:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: Fix num of RX queues being reported by
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282462174.2841507.7131384903411359754.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:30:21 +0000
References: <20251107-tg3_counts-v1-1-337fe5c8ccb7@debian.org>
In-Reply-To: <20251107-tg3_counts-v1-1-337fe5c8ccb7@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Nov 2025 02:36:59 -0800 you wrote:
> Using num_online_cpus() to report number of queues is actually not
> correct, as reported by Michael[1].
> 
> netif_get_num_default_rss_queues() was used to replace num_online_cpus()
> in the past, but tg3 ethtool callbacks didn't get converted. Doing it
> now.
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: Fix num of RX queues being reported by ethtool
    https://git.kernel.org/netdev/net-next/c/23c52b58cc38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



