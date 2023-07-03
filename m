Return-Path: <netdev+bounces-15170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD96746078
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1611280D9B
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D70100CF;
	Mon,  3 Jul 2023 16:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64006100C7
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 16:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC58DC433C9;
	Mon,  3 Jul 2023 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688400620;
	bh=Evokks8NHyD3FH6tCbWSHdGoBxbh3wJXccnE4fiK52s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kD1Ejpl7HxGJg+qxTztwjuwjaQAoW0eQR1lV21m1T/R7RRImqO+eiuLZQeClcYVeO
	 uK/WlqLbbeEh6u21XZTT/Sq14yBPOrL/vlCWHGMyCttHNCiEkJpxFpEckVmHNkbMz9
	 PbzWETPxOFHVV71ZvCN3eYIpFa6+FZM7PuYN5n6yX45J+rWe+XHHypXfIFbzuBH4UJ
	 PglmxlPPbUnEvQB7HvxwJYkgCJMsbZAJXq1xcHBUlAiAtUzxTSK+W/RUp0nbXb41Dh
	 MpBwnUmkguxeBt38F+Sbt9TIB6Tott2uyafXG9mQQ3JcWkg+A2QIDGXYd/b/XCYVMv
	 nRyoYYkQK2DPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B57BDC64458;
	Mon,  3 Jul 2023 16:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] f_flower: simplify cfm dump function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168840062073.14655.17510773342948225363.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 16:10:20 +0000
References: <20230629195736.675018-1-zahari.doychev@linux.com>
In-Reply-To: <20230629195736.675018-1-zahari.doychev@linux.com>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 hmehrtens@maxlinear.com, aleksander.lobakin@intel.com,
 simon.horman@corigine.com, idosch@idosch.org, zdoychev@maxlinear.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 29 Jun 2023 21:57:36 +0200 you wrote:
> From: Zahari Doychev <zdoychev@maxlinear.com>
> 
> The standard print function can be used to print the cfm attributes in
> both standard and json use cases. In this way no string buffer is needed
> which simplifies the code.
> 
> Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] f_flower: simplify cfm dump function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=19f44c06e5e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



