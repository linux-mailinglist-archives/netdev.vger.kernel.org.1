Return-Path: <netdev+bounces-85024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032EB898FFE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B290B288B77
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AF713B798;
	Thu,  4 Apr 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWaGOdAO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F513B587;
	Thu,  4 Apr 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265633; cv=none; b=PDsvkr7mch2FjpfZkYmNUKwN1Kc3J5U1ozlrwxuIuNJPYMljmMwaLyA9S/b/R5NroQZlzSOoVTJutxJc5ITFoPbYxdM5a97eCT5iRo+G+jVQzSyEbzc4mnuy4ACwndn/bfg6iSpCqs21g8yi3iZtPrMPD+MlsfOd3bGzMRCn1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265633; c=relaxed/simple;
	bh=bzP9wdG4Lo9CGuFeKbadFxBdG0phjSnacMiPX1MPcQM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ovJirehS2nDBgR2tzzGOTT+Hl3hPJEE/vnnjJCJ7NBa4Lx+utdQPKW+mCKkRNRFhNl3DTdtmn8Y7OZBHy0GUEXuXZIczsRY+PLO212J8WfWHEOvsCL/QJ7v+1HGIAojKATEo6WY75IWJEQYhdCOZbnpH1Bu7Zg0Q+/mWRQSzPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWaGOdAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA60C433C7;
	Thu,  4 Apr 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265633;
	bh=bzP9wdG4Lo9CGuFeKbadFxBdG0phjSnacMiPX1MPcQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XWaGOdAOCMUGll1igVOE3CzX1DL0Ys9lPqfUQGqFQhtU0vG1aW53oslemKjv++3iz
	 uAhCiDavTk4m+rbfCft6Gz8gOHYOrkyTRmWk+OX8imHZw/47YSY/kNoQ4dYaf4C/+Q
	 A1fsxLBmARBnjWrs+m1orPALXTmMjouMhPzy9v+FyzpU8y6PhOkhz/yQ7BObyIrmPa
	 1qFDVP5VFDKfBndKp/DBliZggX6Q5wjmeoiT8AU1coQVs9ZReX5l/A7tXJCRx8PwA7
	 P+wBh3SQIIOoKw8q+yL/KjqYTPbOnEq8t/VtFu+dUsKmxCe1zxT4fOX6KLNyqpPfd6
	 xNEt8empUirSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09BC2D9A150;
	Thu,  4 Apr 2024 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-04-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171226563303.5542.7090157406302786864.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 21:20:33 +0000
References: <20240404183258.4401-1-daniel@iogearbox.net>
In-Reply-To: <20240404183258.4401-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 20:32:58 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 7 non-merge commits during the last 5 day(s) which contain
> a total of 9 files changed, 75 insertions(+), 24 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-04-04
    https://git.kernel.org/netdev/net/c/1cfa2f10f4e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



