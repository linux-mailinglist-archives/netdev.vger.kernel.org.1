Return-Path: <netdev+bounces-211395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D982B1886B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB4FAA51B9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F4220C00E;
	Fri,  1 Aug 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkk1bJsj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42311DED57
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081991; cv=none; b=DcD9J+oqjwzFQgoki07nCkMkhiEGPc4AaXGv8CMRZwP68XVO2WfaEgGctHt1Z1pzB+3dluhmAejSl/rE/MT8OLaqZAjHz7RsUAXGTJvf+hrKz1v5WbFpqeR9ijWzL2V0H/fX3jTmkbpys7/8d75xptvvMODrvIiaFLWGXAKSbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081991; c=relaxed/simple;
	bh=fzXkWPXQ2Q9g+KshsI20kvh2VtHussmMl1lWHoIc59g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQjo61jx3vdL4NZrxlLVjYrhqrmu/XwXeoHdPoH5UXcGU9jM4lYjL6R5HXcUoZSgtnHsmfpR/ghdkKCtOLmOjkxk+tMYEW4PYxWLwLIWmlZOsNg0jEdIaIjBMgsPMjMqnmuMkDp2Sx63Aggf/pH1e8sBPaKghHT2mhpnpBj/47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkk1bJsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F4C4CEE7;
	Fri,  1 Aug 2025 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754081991;
	bh=fzXkWPXQ2Q9g+KshsI20kvh2VtHussmMl1lWHoIc59g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mkk1bJsjxyatqzjwZ7DNyxWdN2v8Wsg6Xta7SQ/18kn4iX7tqtSdCRIdd6H5XJ3tP
	 bmM47XpaY2O4HKXRQwivKtRxCNIXBlgPAOxiqpS21YGufBdS540CPX3tHbLxDxDb/u
	 nwohnSV8vLvgKeTkemUqNaZBB9CRqDD3vKs7tQObsnAnOBKd+ljpjUKN53eF90k7T5
	 ho339QdESIm3O8MA3wMRGC4wYfLzZT/w3rE2eO0OEWAmnMgW88LaqdGnpFLaHRZgSH
	 l0s8ORG1Fto7dAUhnUub48BIsUNd3mTBGFGMT3rN9tWDtBOP/FYCXQAKCki+kPtqj5
	 2UnLjYR1t3HwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6B383BF56;
	Fri,  1 Aug 2025 21:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: Fix flaky neighbor garbage collection
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175408200624.4074002.12065907126489219325.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 21:00:06 +0000
References: <20250731110914.506890-1-idosch@nvidia.com>
In-Reply-To: <20250731110914.506890-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Jul 2025 14:09:14 +0300 you wrote:
> The purpose of the "Periodic garbage collection" test case is to make
> sure that "extern_valid" neighbors are not flushed during periodic
> garbage collection, unlike regular neighbor entries.
> 
> The test case is currently doing the following:
> 
> 1. Changing the base reachable time to 10 seconds so that periodic
>    garbage collection will run every 5 seconds.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: Fix flaky neighbor garbage collection test
    https://git.kernel.org/netdev/net/c/f8fded7536a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



