Return-Path: <netdev+bounces-119955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF936957AAB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29001C23B75
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34952134D1;
	Tue, 20 Aug 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qidlXgqm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51A1BF24;
	Tue, 20 Aug 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115638; cv=none; b=aItaQn8nqXq9Ml+JrDQdbeXtP7JpKfPqZXpLmm7vhfhTW2EJkypKm57Dc+WjUKRG9PS6jjTCgyOfjcrGDSSTvU7OSSlZEDWwAZ9iw2CZGrfSfYn57hPCEgEAwM1sKcbRh4O/M62qftyNT0nienE2WrGEzqnbAti1JXHqjpJO+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115638; c=relaxed/simple;
	bh=QLnL+YuboXnJw7rd/7tmTvpPo+EYNrmzAHUoUONsdn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=adfpbEh57L24+RTfH4+rKHALR0op3fURYqltI3NvK/dgI41hnFWxx6VCUP5otopPizh2A/nlzrEOKzWn/yzYSzkpsayyK3ODekgkG/NlujSzl2kXg0aCkio2pzYSmmF7PZKYDQc2xu26ieE6H0pS6B/TDRl0dBTXorYXNMKWjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qidlXgqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760E8C32782;
	Tue, 20 Aug 2024 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115637;
	bh=QLnL+YuboXnJw7rd/7tmTvpPo+EYNrmzAHUoUONsdn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qidlXgqmaB6t3hZtqgv5bN2ovpHWijWrHOvOBaE4yyZIr0YH0r4630QPhHR1ZTvL9
	 pgykB/EJ1fUT45yJjZqM/iIJSuNgBphabOFnaITLrX+aA12FkZPemfQxXRIDhxG0id
	 /bqkygYibbbeAOKSRhSR+IrlzWqZB4tNQD4+kWF2Tn/7KvFInsUUGkA+fXf4d1Jf0g
	 iugD2XV9z5xG5miLbu8E2OhIa1saJN67tZ2+ZYxmrKPgc0oLy8UxsRoLXcrSW4nYlx
	 666fg6UnxMDlBRPf6l62PH0Gcqwxn/8ysh3bprjwpkxzZdFBjNXe88w0mBb1r6Yu7g
	 MHNYzgvIf2z7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD83823271;
	Tue, 20 Aug 2024 01:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igbvf: Remove two unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563675.698489.16448666120117181368.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:36 +0000
References: <20240816101638.882072-1-yuehaibing@huawei.com>
In-Reply-To: <20240816101638.882072-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 olga.zaborska@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 18:16:38 +0800 you wrote:
> There is no caller and implementations in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/igbvf/igbvf.h | 1 -
>  drivers/net/ethernet/intel/igbvf/mbx.h   | 1 -
>  2 files changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] igbvf: Remove two unused declarations
    https://git.kernel.org/netdev/net-next/c/12906bab4414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



