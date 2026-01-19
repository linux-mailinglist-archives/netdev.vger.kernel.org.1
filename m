Return-Path: <netdev+bounces-251217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBAD3B53B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 209DC300C37A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136735E545;
	Mon, 19 Jan 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8LqKbG2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57135CBDA
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846212; cv=none; b=TeZE4km8ZZZk5Xt/V5qH8ZhlfNLKkZLcEiMTDy3qS9uxGhQFRAzguAYI5H3euXRtf0+Q4cx+h0Nmaz7tVsb7Wh5nwskEZfvO1fM5uXoJnrTAp18FoufzA3kXg+HEHzOEvrhdbGuhzqYj3/tJxAa9bBuPrTa7WEym26B9XqwRdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846212; c=relaxed/simple;
	bh=rFZz2pUfNHhGIapOXJLnbIofCUuSLJfZb0XamW263U8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etyfaX+OarfcBb0KfqGzZayZHkbtzPRDLOllZV4E0cn+QQEjolOKMgROCo/YVqQqGwtF6P9nElbz/meVhhSzOa6qsFtRVeEOdoW6+01ZJpZ4kODgn8au0pQMx+YtAx3OsPRUhlny261GKXkry+oNkerYbHkAxkHpdLZqD8SLigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8LqKbG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E34C116C6;
	Mon, 19 Jan 2026 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846212;
	bh=rFZz2pUfNHhGIapOXJLnbIofCUuSLJfZb0XamW263U8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8LqKbG2IJLuzATfomgomXcxnhX313Ywd4/NH4qjWohQ7kjmLJok3431mgJidp5We
	 gzIQDCUbelTjQI0lo0sFMCF34XKZ7K8+s+oxEoKW2ArbhxRYX/Sxut8yewOKecsBE1
	 K1cF6CRRA65J3NTyXLiQhWxHO43XkeF3woS+g+pVIC8sI3JwR7aAz9o33IYxhxkt8/
	 xxwy12CCtTQ3hP+QaSB9rv3PAt7CdpJ4WMq/KJX9Dh+DB2bjQzHLCiqWAXvPCvBtsn
	 WkR2sccAU/E7zLqULCxIHAovzlvtUL4zEsQx3xCMiG/v08A2Tc8pZuW2dM8TQNR0pD
	 cld5hyLmdjwbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3EF0F3806905;
	Mon, 19 Jan 2026 18:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/2] ipvlan: addrs_lock made per port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884621003.85277.11896348581654872736.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:10:10 +0000
References: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
In-Reply-To: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org, skorodumov.dmitry@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 17:24:05 +0300 you wrote:
> First patch fixes a rather minor issues that sometimes
> ipvlan-addrs are modified without lock (because
> for IPv6 addr can be sometimes added without RTNL)
> 
> diff from v4:
>   - Patch 2 (selftests): execution time of sub-script is limited with 1 minute.
> 
> [...]

Here is the summary with links:
  - [v5,net,1/2] ipvlan: Make the addrs_lock be per port
    https://git.kernel.org/netdev/net/c/d3ba32162488
  - [v5,net,2/2] selftests: net: simple selftest for ipvtap
    https://git.kernel.org/netdev/net/c/8becfe16e4a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



