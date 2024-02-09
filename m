Return-Path: <netdev+bounces-70651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF1684FE10
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D5EB22390
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826614AAA;
	Fri,  9 Feb 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATHzJaLj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A012B86
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512431; cv=none; b=joAUqsGM3Jm3I7r5Jk0Bbl/7EBAYnWsEgAMCZ3wYPBofC3dj/Fyn1Y2M6oI9RirFls0lrUnc2ddGCnUm/ugWtiRPbaxSoOlOPJvvyzsUhL4QIO4HSf16tv+JC8CU3gqLfKzC9BbVRHbZhZni5B8F7rbtU+80im09HcUXmUI8gvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512431; c=relaxed/simple;
	bh=XlbWR+soKTaebjgdDneb2oCHh927YVXqlb3BW0xnMnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQ6w8ZaLXSVNUJbQK1brYGL8nFaS7FQfLnmwRu/7SLP+VmHDZ9OyBqHWO0+MdKP+BvKxEkHJMQcPDThMvGbh9NYKGithbVqLXsG+xgDcGIJKV+A0LhJEKMcjqOGMbvjFlEZj4qgp4pMh/GIDAU/TJt6trRsyc+L09LteYUdvGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATHzJaLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60563C433F1;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707512430;
	bh=XlbWR+soKTaebjgdDneb2oCHh927YVXqlb3BW0xnMnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ATHzJaLjaCTtUgsGU5feWX+JE18EpiWdXiF+rBLmNSYLk07Q1C9NcF1bCksx8aYtZ
	 j0oSEixCuQOMkxAJsUAd4NfbWlbhzOP9sSfNEcrT/Ink5uQI+5P0hQls30K158JdiV
	 8SVdcOb/U2RYhWGgutpgMOx3A29MOZdiS6FlT7a6CaQosedhfUDxlbF22UgyjBoDP5
	 tnxEXMSMDawVG3UGHjmMJVSfQc8KdO60D7WS4CeiIlqugZ6IDjCRY1eAZ9VSehItI9
	 pnnag68qPYXwkGTd1C7Q/ktEY4oDQEXQzG+jDk93AYqYCjpUEtAoqEbqcBHJGxnG2A
	 ngUnjtOElZ8Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 465EDE2F2FC;
	Fri,  9 Feb 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: act_mirred: Don't zero blockid when net
 device is being deleted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751243027.9207.4165229488561709705.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:00:30 +0000
References: <20240207222902.1469398-1-victor@mojatatu.com>
In-Reply-To: <20240207222902.1469398-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 19:29:02 -0300 you wrote:
> While testing tdc with parallel tests for mirred to block we caught an
> intermittent bug. The blockid was being zeroed out when a net device
> was deleted and, thus, giving us an incorrect blockid value whenever
> we tried to dump the mirred action. Since we don't increment the block
> refcount in the control path (and only use the ID), we don't need to
> zero the blockid field whenever a net device is going down.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: act_mirred: Don't zero blockid when net device is being deleted
    https://git.kernel.org/netdev/net/c/aae09a6c7783

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



