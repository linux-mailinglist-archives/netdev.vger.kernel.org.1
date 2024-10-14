Return-Path: <netdev+bounces-135175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD199C9F3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DFAB235AA
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168B1A2C06;
	Mon, 14 Oct 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaMPWOXc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6961A0BCC
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908426; cv=none; b=Xyr/l7KZ52bujlOX+XfJ4da/ZmJV64yBPf39No82P+FR8gWT4VjAU1t2njLZBun9Q8VqSI6YjPFTeM2pDIKVErM8lywH0nZxLxYkr33Hv9rSaD/7rnIbTzFMUHGFMXfCd0w0zJcoQzVDWSJwv7yshVqcR1kTgeq0PkXajOzOcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908426; c=relaxed/simple;
	bh=cC9emBzwvt/IQGNdGK3GBHzYR6hNm89dgN2T/AahZgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4D4+sQOpJVZHePAXLKJnJ8OKREJgAv9+UI2bkYMT6QXrfpCJNcDmcmqTiSZo5FOGdjlDp7Za/r3UKDUH9USm6ge0yTdonFa+akJaU5zoN/PEHd1nXyPT3qh8UXIiK6VmyLuuKKQYsO17SMi7A0dBuwBxip5xUxCFFQHTSrUKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaMPWOXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3FEC4CEC3;
	Mon, 14 Oct 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728908426;
	bh=cC9emBzwvt/IQGNdGK3GBHzYR6hNm89dgN2T/AahZgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YaMPWOXcQIUmU76e5Uc5G4YZ8xoWjIOyyj+qMxWysjzQ7VC0cdKL0o8NNE+kr58fh
	 0dTTvMweVVB2gW18BiFeKJdmokphDaFH19APeuVP63SKWUJJhwlWhumqxoQ5Bh11el
	 Vu8i3PEVXwZvfHbm5+BjQM0e/2pPnpp4uKlhYK4abpEPHYWBtSxpXIg0Ue5wg6nnRl
	 dOzmHX6A9lUQXsehSm+lHbImKDGFE7hY4KhYQcBBK+/gxoDBoO2q9NuGBbR1TQBGun
	 4a4mKQcBSRdBV75vfEMvZHff/Z3z9AuZB1cpCJ8Kzi2iXcgahK+U9aflkDaN5ejzUt
	 gTeGDFt2ECE8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C913809A8A;
	Mon, 14 Oct 2024 12:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] net: hsr: convert to use new timer APIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172890843124.494844.5111739146277012300.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 12:20:31 +0000
References: <20241010092744.70348-1-liaoyu15@huawei.com>
In-Reply-To: <20241010092744.70348-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: kuba@kernel.org, xiexiuqi@huawei.com, horms@kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Oct 2024 17:27:44 +0800 you wrote:
> del_timer() and del_timer_sync() have been renamed to timer_delete()
> and timer_delete_sync().
> 
> Inconsistent API usage makes the code a bit confusing, so replace with
> the new APIs.
> 
> No functional changes intended.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] net: hsr: convert to use new timer APIs
    https://git.kernel.org/netdev/net-next/c/e4c416533f06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



