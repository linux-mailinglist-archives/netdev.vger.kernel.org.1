Return-Path: <netdev+bounces-48500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D07EEA07
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366641C208BC
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11148381AF;
	Thu, 16 Nov 2023 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVhbLyFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481B358AE;
	Thu, 16 Nov 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43619C433C9;
	Thu, 16 Nov 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700178024;
	bh=BvmQLMXsGArU5M2UtuTY33bLv3cja0Aq9r4C+OKwys4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVhbLyFYr1fjkhRH9TJZFMn11/cywGOt4FeeW7uo0ye/dlfN96AzTW+2qSEXtx6Xh
	 WttQSNlFtsV6ubf08+9wyjs8pYI8kXmolhRV8Ef4AHZohxdHLA3CgPkXrZFzFWXArb
	 q7ed5yWHyPZejjSn0sBqvp9rZEbL2cFlz/ce4ommyZ9B03OBxKiICHHmqXTnq7duOm
	 16pDmddiW8ZA5dpwrMgwkYjDwcXUajZRYBhNfdzxyCoHKXDrGwAAVb39FkITEc3XWa
	 qcE72BQdURovM+TMfsgjQx/atG+OHat+NjP5K1Dh0WROtKpeSvVjaa+kqeAitsT6G1
	 BSguXYK+QUjdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EF27E00090;
	Thu, 16 Nov 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: aqc111: check packet for fixup for true limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017802412.19305.8178422263067998995.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 23:40:24 +0000
References: <20231115100857.24659-1-oneukum@suse.com>
In-Reply-To: <20231115100857.24659-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: dmitry.bezrukov@aquantia.com, marcinguy@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 11:08:57 +0100 you wrote:
> If a device sends a packet that is inbetween 0
> and sizeof(u64) the value passed to skb_trim()
> as length will wrap around ending up as some very
> large value.
> 
> The driver will then proceed to parse the header
> located at that position, which will either oops or
> process some random value.
> 
> [...]

Here is the summary with links:
  - usb: aqc111: check packet for fixup for true limit
    https://git.kernel.org/netdev/net/c/ccab434e674c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



