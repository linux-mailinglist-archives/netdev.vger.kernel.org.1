Return-Path: <netdev+bounces-201375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2847AE937C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AF93B467D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311511AC88B;
	Thu, 26 Jun 2025 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z56z2M2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A10F1AAA1E;
	Thu, 26 Jun 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898986; cv=none; b=cG02ImS/DHoJLZvdcmgrtlVC7A9HN2yqMDPjJ1A+H8xrRTBMvC9TMUhx8czEpqT5wqJ1UALJjuQpwAZFBDdTjiTYAzq9O921JNlXMwlyDk2bOs0dNTsUvlL06QKKMmPw3bDvsMMlWWhlk4S7nM8SGjGIlFv1d6Z/RYhdCzIo5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898986; c=relaxed/simple;
	bh=fOqDW+/kIWHep+Md0I/PmN3nJInIsYJHERCP36wIoww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LR9dpVJDjW9K2BrwHv1q83DfmZfHtCuNcJYOkFr4seeSKLusCStBl+APwg4Vhiw112cmWs85xWMOqp/CdgKOXXcyB+QaNeLUc6oA1tXcjlScriBtrymHVyvuFHp25ozIWAq9Tg0P5gkkohO9VjwL28vjomSdB40Jewcu9q/CAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z56z2M2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFAEC4CEEB;
	Thu, 26 Jun 2025 00:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750898984;
	bh=fOqDW+/kIWHep+Md0I/PmN3nJInIsYJHERCP36wIoww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z56z2M2GDbotaHT7aa/391J6m1aSd9UHUxuOxMCMjjKY8fs4z+AQ9GmHQ3pdxHF8K
	 gZedDx1CwHznh0/QhjCAbJt/8FCdFzUiKaK9CswODhOG3H6yLOGDKIafkClRoU66OC
	 axpjLxyIHc8ovo1sFp5ZR4DhAwiysABLE81Z7+oC56wzqLjx8G54uZwuZx24m8kZHD
	 C/He0oSP5sYaVn4oPmGDlQSxKDr5ocbqrPdE0dr/KtExd0nHetv7vXsdMTp/JDeI6p
	 we0FeW7AQSqTdNhw0eXvXE6D7XW9tLGQS2tsHjo3+AQsIMDLW7K8j0yV0tUyzxL2Z/
	 mKlGFZ3ulWpUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A2C3A40FCB;
	Thu, 26 Jun 2025 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove unnecessary NULL check for
 lwtunnel_fill_encap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089901074.676531.10695536669708681941.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 00:50:10 +0000
References: <20250624140015.3929241-1-yuehaibing@huawei.com>
In-Reply-To: <20250624140015.3929241-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 22:00:15 +0800 you wrote:
> lwtunnel_fill_encap() has NULL check and return 0, so no need
> to check before call it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv4/fib_semantics.c | 3 +--
>  net/ipv4/nexthop.c       | 3 +--
>  net/ipv4/route.c         | 3 +--
>  net/ipv6/route.c         | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove unnecessary NULL check for lwtunnel_fill_encap()
    https://git.kernel.org/netdev/net-next/c/3b3ccf9ed05e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



