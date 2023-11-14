Return-Path: <netdev+bounces-47602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D87EA9E4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0931C209A3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91702BE58;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbfsXMxB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576EBE52
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 400C5C433CA;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938025;
	bh=8c49J/Hz0npPJend6pBAuCS3MAFdn1Aa9h+mSQMr4Lo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WbfsXMxBjfMqna2n+NpmuWhw13v64Ik48gmZJBGDE21hXsQETytFzyoDGlZhw8Ush
	 NKGXuM5y7bZ3KbaFIVH/UzqAzD58FwsBmtTakyg48nHhuRrs7ysdTYGxXeigNM3MSc
	 4PxUPPznHK2aTyNWDyPbuMb71PT9dAMsLujDcG4nCWqzlEohpjQ9OCu8+f1pUKNSLX
	 nJDpTFOtWhsBbcva+NZjPMy15aJ7ayZVftjmcgY/jk1sDjWyzN4fTod3O8qFT8OYqc
	 fCLEYks5oBSb62kbbss45uYLlZVPcgtf2Oq7VnuSK0Q8u/WL6uSE2ZBHvgxRJ1dtk5
	 IcfrZB3ZfqW7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24965E1F673;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169993802514.31854.14137380425875500865.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 05:00:25 +0000
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ulli.kroll@googlemail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 olteanv@gmail.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Nov 2023 10:03:11 +0100 you wrote:
> This is the result of a bug hunt for a problem with the
> RTL8366RB DSA switch leading me wrong all over the place.
> 
> I am indebted to Vladimir Oltean who as usual pointed
> out where the real problem was, many thanks!
> 
> Tryig to actually use big ("jumbo") frames on this
> hardware uncovered the real bugs. Then I tested it on
> the DSA switch and it indeed fixes the issue.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: ethernet: cortina: Fix max RX frame define
    https://git.kernel.org/netdev/net/c/510e35fb931f
  - [net,v4,2/3] net: ethernet: cortina: Handle large frames
    https://git.kernel.org/netdev/net/c/d4d0c5b4d279
  - [net,v4,3/3] net: ethernet: cortina: Fix MTU max setting
    https://git.kernel.org/netdev/net/c/dc6c0bfbaa94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



