Return-Path: <netdev+bounces-223308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F33B58B39
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC95E170080
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825623BF9E;
	Tue, 16 Sep 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgUU0mqd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5E2472B6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986245; cv=none; b=bUnV9YJRJHicvOfkNUHH8fs+pJBKrvg4rW+Lkpbkkt8PNd3yIywE8FQmlYU7JTsYnrEfvHVa/rmki3HCW7t+8n7QZTr9g6tRJ9DGBD1Y+skOhOH1cjzZsH4M7ah2Zy7QoIS10tFMqV/6USLf29x8rI6JeCK0J1/X6I0sH6BbDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986245; c=relaxed/simple;
	bh=xzjXOach0wb1+8QAlzm8TwUvmirNNXh6lYO7ItNoG2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsNYUqNgktF0GkyZL4caEGMznbLIMcPH14k0cIeytzWQUz+1+Ub+kayxQSPz52x+IwYgemegMxGGDvJSQLCIBTIT1D0nKP6pG9dWjMLHY3cY8kKcJnCOxuGVG+15B86XmpRAGYCG42mVnueZtRiqF0THJSo5vVMJkvczlWF6CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgUU0mqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF318C4CEFB;
	Tue, 16 Sep 2025 01:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986244;
	bh=xzjXOach0wb1+8QAlzm8TwUvmirNNXh6lYO7ItNoG2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EgUU0mqdQjDIjZOf45nQe3XolT/GgLuOZqiAqPr73dkHS6Acc0aFGO1U4cQAOQy+S
	 GEkDJ2oBPzzQimPFF9yG0Evkf0/u23JSdTvUmIW/uxFf0I98BUKFQ7ig1HU7KOAFoS
	 QOy6K+KhLdxkV/6Vte9POmbDu1ODDyUjerYD0ZoWy35llQRq3udng4MuL+hE0eb7Fu
	 30CWZALRppiQ0JJw2QKHdew0dMAWlwG9yskuiQDVTTTWfNv3Dpfzh8MXx1Ucn8h41o
	 i2XK0tvS8UBqGzFQAr0/KSshI1r4BdbOPMnv/B7irvKCe1UPK390zpt9vnGBhX9UqZ
	 BFeU+EnSWVOOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC039D0C17;
	Tue, 16 Sep 2025 01:30:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624599.559370.13549787819323691684.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:45 +0000
References: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
In-Reply-To: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 krzk@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 21:05:11 +0200 you wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> v2:
> - use dedicated printk specifiers
> v3:
> - add missing newline
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] of: mdio: warn if deprecated fixed-link binding is used
    https://git.kernel.org/netdev/net-next/c/a8ebee579e7e
  - [net-next,v3,2/2] net: phylink: warn if deprecated array-style fixed-link binding is used
    https://git.kernel.org/netdev/net-next/c/4689a4290429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



