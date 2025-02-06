Return-Path: <netdev+bounces-163331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177BAA29EF3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13F91888044
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0D2B9C6;
	Thu,  6 Feb 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn2nctxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780228F1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810204; cv=none; b=PwxvLohVqIFyfwrUnlGmlnt8RAT0CwEJz8GKWZzPDHZ7PhJ+ZbHUBVzHw6CeR/CXB6J1b8bY53oWBiGU4mJzgULjK0TIzsAaHdopmCDRYZfV4FCTGb74F1lJtR6k0R39w/Im8b6pQmDy9wqpZrGUcOLIU/9wpVhq7wcLO5xgm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810204; c=relaxed/simple;
	bh=S8ylfVKC+BZexxlrxE1IpAdJNGlomB+kOhMI7PoZWhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PSKJcC4/QQBeFiqngiQ3YXrMK+LhK/litA8d9aEtd2kVWH5CKBCXmqGSEBiHOoYMP4caxDN1e7txiY7S5jmJic9V4EYUYiDkEVgPqBxyYR7M8oHrc4Y45HZK2c3GJzeaQIO2pyquVNojqsG7Gio5sBM6RAHiZmL33NmrNRlIPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn2nctxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63821C4CED1;
	Thu,  6 Feb 2025 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810203;
	bh=S8ylfVKC+BZexxlrxE1IpAdJNGlomB+kOhMI7PoZWhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fn2nctxS7OoLG26ytt9dN4G0zbxKQMtKKQsetukpStaYXmmLGgmpEMmw8r5Cfvxk7
	 OD1x7gdKSQtKVDEWD9hEZpe4ukUibqBQ3XAKGI9VBc4uz0frlVbl0re9gulMSmF5Pf
	 XnhGfGry3LP5g0qwD9qL1JaLFa+r7eYHTWVsCGIHhRdSqS1T5ERi6zd7HYrOwRxrqE
	 03m16WqDzmx2kvZkqBFjpb0TQiexW6K4FT4Rl5TskkJgNF1oXGdMZ9b6aU5w45qvfs
	 c/nXxvrIUTdcjaXmJlLMS1ZlETzG+k/AFbbvep0WCY4VNX/kOk/V7HYJcbA25RyaBN
	 iF0zheNyZhZNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD7380AAD0;
	Thu,  6 Feb 2025 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sched: Fix truncation of offloaded action statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881023084.981335.713194550164586069.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:50:30 +0000
References: <20250204123839.1151804-1-idosch@nvidia.com>
In-Reply-To: <20250204123839.1151804-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 amirva@mellanox.com, petrm@nvidia.com, joe@atomic.ac

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 14:38:39 +0200 you wrote:
> In case of tc offload, when user space queries the kernel for tc action
> statistics, tc will query the offloaded statistics from device drivers.
> Among other statistics, drivers are expected to pass the number of
> packets that hit the action since the last query as a 64-bit number.
> 
> Unfortunately, tc treats the number of packets as a 32-bit number,
> leading to truncation and incorrect statistics when the number of
> packets since the last query exceeds 0xffffffff:
> 
> [...]

Here is the summary with links:
  - [net] net: sched: Fix truncation of offloaded action statistics
    https://git.kernel.org/netdev/net/c/811b8f534fd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



