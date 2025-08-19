Return-Path: <netdev+bounces-214806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55761B2B581
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D2169A2E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020361F7910;
	Tue, 19 Aug 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAkaONrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1751F4CAF;
	Tue, 19 Aug 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564011; cv=none; b=PIV+bDlOuWtnDXopiUYoj/mh89dF2pLpzBLseFTgiNdbHaJ8UXxaSBs72jZvD0HFzo0VKSCP394KFN96aHggmqjpQfAZNp8CC05yJBxALaR9TfkllHB7fme6kKfWS878Klb0hxNZi4e8sHcd0hyoBw2bcsysvVVYIA6YldoVViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564011; c=relaxed/simple;
	bh=mW4UuHT142ip+0YATzAOXTRoTC+S5oseRzIQBeh1W2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nngHys4rOtqkep6QUrhrd7U2Z/8Y6rK+vDqqhYz81ZyTpAvPRAuVetLBfceYFwv79iJzZ5y2KH9KyJrWBvy8doxbYKPgUXOBzZ6A8eMds7oPs7/GsRuSImYB9jqzjuhVR+ztILnz+TXs4532cFLUGhLBwdWjnvT2d1x/LJgz6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAkaONrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB018C116C6;
	Tue, 19 Aug 2025 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755564011;
	bh=mW4UuHT142ip+0YATzAOXTRoTC+S5oseRzIQBeh1W2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OAkaONrVpJvcxa/74J+KuthFE8xQeMXBoBgYavPw4n5cKGFUo7e0bF0FKfMb0hdLz
	 UrP9obwGSKLLE9jmdvFyv6pTexMKIZ6OPsue1kbQZMqulw9hx+qZpqudcHwjg7bD9x
	 T38b9INdvwyXQPZjq9zk6RCtMRSZbzrYHHlIT/mE3p+CWoh74/4KWDCAoYDzepJQnV
	 T2G0UzWZCrIq1xnLBixnw2WN+FVDFGPfZWMdepBQopKaBkC8rH5M1/17WQ0QoFasro
	 l+tqM3xeFeENJPC4A7RvQxWYeHel5pU2O0Tp9hGHDKL6Z8/if3HkOnEVr2yIUI5e1h
	 vpT03tpwl1ysA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4D383BF4E;
	Tue, 19 Aug 2025 00:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][net-next] eth: nfp: Remove u64_stats_update_begin()/end()
 for
 stats fetch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556402149.2961995.17714255668672894742.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:40:21 +0000
References: <20250815015619.2713-1-lirongqing@baidu.com>
In-Reply-To: <20250815015619.2713-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, florian.fainelli@broadcom.com,
 julian@outer-limits.org, csander@purestorage.com, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 09:56:19 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> This place is fetching the stats, u64_stats_update_begin()/end()
> should not be used, and the fetcher of stats is in the same
> context as the updater of the stats, so don't need any protection
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: nfp: Remove u64_stats_update_begin()/end() for stats fetch
    https://git.kernel.org/netdev/net-next/c/1fb39d4c23b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



