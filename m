Return-Path: <netdev+bounces-107863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6491CA19
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DCF1C20B7F
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F247538A;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9eav4Io"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0554C8C
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625857; cv=none; b=IwRDntPw6M1aesTUehyfbLS3DeGqp2Gk54MaIpDrJFkk3sQIrZlGhXHbSd0m5//o9V009UDrXsfAmw2f71IWlY+yuafbH1sQpI20+kSCyChIR5xzayophFQl/QsSkSGZXpaCjIhNSe0Nl5hTw3r3JwKAVxF6hXSaL0p7ScNTFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625857; c=relaxed/simple;
	bh=cO8cXlRTAArbWMUzevM066x8NJyocsu1AiHsFix1o7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u002lZkmUUHRyVTmlcfP8co6Jg7c9plL7QDp3Jl84KkCwbu4mak4bQw4jnnmrUh4dbhZbbeTZ2Egd2xLG/p7RdlHSdS1wA8CfkiGEYogs381JnOlS5jaKoihIJmgchBU8CclmgUc4IDQjsW5muyxg9e6ZwweHFnq0c+FsiU1baA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9eav4Io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B1D2C32786;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719625857;
	bh=cO8cXlRTAArbWMUzevM066x8NJyocsu1AiHsFix1o7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H9eav4IoogLtJiOO29aSbmOqQn+2jxDVKjrJY7v3jiZjyHx050uY3cDgBlqPlNagX
	 wCr7/snaWZw1rvra+3ToT9LCb9lt5xbMKc6imag4ZQJk8caMXcCJFCVAZfZEDf7nJ0
	 l7oKlN9s3/lbc5Ewg0bWMmPf2j4dhq4QsnducngTJGJpZ9TO5z47V5S8bvEgkU2cpa
	 wuF7YPW8E7yw9GbO4bnbnu48iEEx1qk/bliGnB8rXIkraUgBOtlgSoJ6swYoQgZKqs
	 X19wqtyISfTg87IFMXHiOTwxkmJbK3B8K6cNer0bqbn47SWd3IxLvMkH2GvH5/AIPU
	 XPxbI81wHNS2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FC86C433E9;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] selftests: drv-net: add ability to schedule
 cleanup with defer()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171962585712.15618.4313372064257850043.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jun 2024 01:50:57 +0000
References: <20240627185502.3069139-1-kuba@kernel.org>
In-Reply-To: <20240627185502.3069139-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com, petrm@nvidia.com,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 11:54:59 -0700 you wrote:
> Introduce a defer / cleanup mechanism for driver selftests.
> More detailed info in the second patch.
> 
> Jakub Kicinski (3):
>   selftests: net: ksft: avoid continue when handling results
>   selftests: drv-net: add ability to schedule cleanup with defer()
>   selftests: drv-net: rss_ctx: convert to defer()
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] selftests: net: ksft: avoid continue when handling results
    https://git.kernel.org/netdev/net-next/c/147997afaad0
  - [net-next,v2,2/3] selftests: drv-net: add ability to schedule cleanup with defer()
    https://git.kernel.org/netdev/net-next/c/8510801a9dbd
  - [net-next,v2,3/3] selftests: drv-net: rss_ctx: convert to defer()
    https://git.kernel.org/netdev/net-next/c/0759356bf5fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



