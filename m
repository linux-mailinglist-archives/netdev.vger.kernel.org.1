Return-Path: <netdev+bounces-175692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2FA672BC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405B417C832
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484020B1E3;
	Tue, 18 Mar 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq48iJkb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057A204F9B
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297404; cv=none; b=Pd19q/yMTVGRz4BfS2oWbIR/7SrY3XvoeZdtJro8H/IlzWUFYVbcpEIEwQu/5/5CUoK4TyiizkDSY2qA8+hUthi8mu3IHa4NqLbZIqlsb8jClcGdjMejRXzP9L6Sv89+7qAfoVoXg21QJCVgqFLUMbOM/0JcRE+hv55szQl0JEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297404; c=relaxed/simple;
	bh=r69d5xBhzd1oSteBxc/VbEo1hdNp79uDB5aVghpztaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MIxH5z+GVDe2RkjYwtDV2d22Sc4xmkuzL1xQpasCICUiFcX/PU/pJC27SPAn3WqkcJEG7FX2DvHcrTLZFtlmSvgfIPQs9iILXYGRfbGuSnBeIK/zUsX1mXwy/yVvu8Q+2I/s50DCBGkIFMA3BmteHi5go6qYkg5l54EFbjSzsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq48iJkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06CEC4CEE3;
	Tue, 18 Mar 2025 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297403;
	bh=r69d5xBhzd1oSteBxc/VbEo1hdNp79uDB5aVghpztaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tq48iJkbASb1aHOoBxNL5OirnAc/ZAXyLmWNVOJUyEerYnbT3RKLOwQwNTvU3wu0A
	 xXyx4dN2d7skqwW/+Q2IDUvy/acx9JI/RrGOGx8CEGhhAvkDnCsW8IsAWJ7aJV9ZSd
	 9sc/IY5mPGN8nlJ1laO6KNvJKS+/8J0lr/NHoXLOarFSMkTMyEPTigG0E14jswBvGa
	 geG+19Og1xndvUvMrOZr0Mhq51cFeXpTV85Zl2mFHeJkZBc1VVgRF/g4qhlqw9uPas
	 BXbgvn7tCkjTs5bL5HoDKHhmdiA35B2qsXvUpvv0mFIHMqsYPoS76X8rsxzV99X6Eo
	 Wb1YqyUfmIw6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75030380DBE8;
	Tue, 18 Mar 2025 11:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229743927.4143607.16972269079132014230.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 11:30:39 +0000
References: <20250313164519.72808-2-sw@simonwunderlich.de>
In-Reply-To: <20250313164519.72808-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu, 13 Mar 2025 17:45:10 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.15.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [01/10] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/b195d60408d4
  - [02/10] batman-adv: Drop batadv_priv_debug_log struct
    https://git.kernel.org/netdev/net-next/c/9a006e72d30c
  - [03/10] batman-adv: adopt netdev_hold() / netdev_put()
    https://git.kernel.org/netdev/net-next/c/00b35530811f
  - [04/10] batman-adv: Add support for jumbo frames
    https://git.kernel.org/netdev/net-next/c/1666951c4424
  - [05/10] batman-adv: Use consistent name for mesh interface
    https://git.kernel.org/netdev/net-next/c/94433355027d
  - [06/10] batman-adv: Limit number of aggregated packets directly
    https://git.kernel.org/netdev/net-next/c/434becf57bdc
  - [07/10] batman-adv: Switch to bitmap helper for aggregation handling
    https://git.kernel.org/netdev/net-next/c/77405977f187
  - [08/10] batman-adv: Use actual packet count for aggregated packets
    https://git.kernel.org/netdev/net-next/c/0db110059e79
  - [09/10] batman-adv: Limit aggregation size to outgoing MTU
    https://git.kernel.org/netdev/net-next/c/e4aa3412f632
  - [10/10] batman-adv: add missing newlines for log macros
    https://git.kernel.org/netdev/net-next/c/7cfb32456ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



