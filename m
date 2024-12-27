Return-Path: <netdev+bounces-154387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007FD9FD785
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 20:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6221883490
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ADC13C3D5;
	Fri, 27 Dec 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJSwEEnM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB71F8AF3;
	Fri, 27 Dec 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735327813; cv=none; b=loiLxqJZWuD2YTp5b5n9Kkh/+iKmq7mIdtjdTtUoxw4FxmpYGNgp6aUXs7B/Iut28BZ9rL9ag7CkIDVfdAYmjwlJ+RMw30uLcrGA6uph7llyFitj1MD+OZ3yZMx3iWt353jiIxt35sDWUeP3zRgaNOVVyHeXscMz4/zX9OOEyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735327813; c=relaxed/simple;
	bh=QAQcu0WRZ3ePW3JDQly6Lnvr7DD08UKWzYy47eQyZJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZJnwiWTTE2qiBh6YOBzd8AnTAtXAetnmqWbA/agrqIGJbj0a3RvVHY2atbmndUcEF/hNRBAFmshaw+xI5c7bna9/2fdCUWhzC61/1YQRWfRY4HwLKxYCfucrJlWxn87R7DHsLcW0FdPTIgeh64k+dWEoJ3yDNBPVvRpk/pQ7H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJSwEEnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED82C4CED0;
	Fri, 27 Dec 2024 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735327812;
	bh=QAQcu0WRZ3ePW3JDQly6Lnvr7DD08UKWzYy47eQyZJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vJSwEEnM994JBQWan5e+RdD2q8JTWT4r0vo9ZO1N9WK/Ma/zlZdrAR5p3FDaXLSWX
	 yLtqV42w0wxfyrjdVEYjA+EluPbH5pg2SeONFoElj38jmod9PSwNtlnNPKYM1LoToe
	 j1OsMEy/3zN7r+TOTpWnRmKHNUpX2dOt28J6qrk1oGT4nJvBq0KwH9mVHjaNqhUw8Y
	 7nGV+zK8iRyafTZ7HTdlyimBfOSYyFzRtFkHYrt4YqRO4kiaAliWdcwQZtLlBU2Skw
	 NBcDZ/324fqliT+uGAEaOzbjgMlKPKcbDpMw/B7JeQiHbTMoPG+tpWenGulWOU9P5o
	 9zbWbZ3cmlwlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34064380A955;
	Fri, 27 Dec 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] netlink: specs: mptcp: fixes for some
 descriptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173532783201.575952.5509666590486709337.git-patchwork-notify@kernel.org>
Date: Fri, 27 Dec 2024 19:30:32 +0000
References: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-0-e54f2db3f844@kernel.org>
In-Reply-To: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-0-e54f2db3f844@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dcaratti@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Dec 2024 12:09:13 +0100 you wrote:
> When looking at the MPTCP PM Netlink specs rendered version [1], a few
> small issues have been found with the descriptions, and fixed here:
> 
> - Patch 1: add a missing attribute for two events. For >= v5.19.
> 
> - Patch 2: clearly mention the attributes. For >= v6.7.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] netlink: specs: mptcp: add missing 'server-side' attr
    https://git.kernel.org/netdev/net/c/6b830c6a023f
  - [net,v2,2/3] netlink: specs: mptcp: clearly mention attributes
    https://git.kernel.org/netdev/net/c/bea87657b5ee
  - [net,v2,3/3] netlink: specs: mptcp: fix missing doc
    https://git.kernel.org/netdev/net/c/4f363fe9f6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



