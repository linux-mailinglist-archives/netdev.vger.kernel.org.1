Return-Path: <netdev+bounces-95646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E908C2EC7
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D69CB22FF6
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC911B27D;
	Sat, 11 May 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThtMdcYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390018EA8;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392831; cv=none; b=DvrVJc1ley8pONo9RW/MnWhCBabW/Yb63fUcs+ircUH4BEgCZGs3q/cQ9EzyKtZJWMB90ewMplEayk/encVC4wWQyVggK+KjAdy2lI++jGGFrQcmUz/2JHhsOqVX0A8YxqlUeihGlhdtNtS/OUNzRScO0YcmiJ9gp4ZZXGXh6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392831; c=relaxed/simple;
	bh=brU6Cup5+LDIKe6SXv2rj5svRPMOTvaIksSufYOLqsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZOgq0e6LNuJjQEyGQzdqetGvPK3eKc8dishgKbyD5URJCYRc2B3cPgN0H/ZsNYlt7UW3SuABE1xC7w2aIGDa/3p8Ae4uh3VHwgY4eVTzXAvfn8soRIFXihqGFO6UNfUfOi9P9ayfTKetthN+P5DqcIueJj1WUB0ys55DLiU9m5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThtMdcYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38312C113CC;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392830;
	bh=brU6Cup5+LDIKe6SXv2rj5svRPMOTvaIksSufYOLqsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ThtMdcYpsFWEAqhUB7s7FG3XxWozSBoxj7UNCnKmvm3Q1gQpA8kc41V7EtNrC06bn
	 twXakk/IJTYKxfzMR8p6WIAxT+LpO312ohHTM3bEMeU+TyLW6I2s2eb5HGkwWy9Ki6
	 ih4tk9d8Sq4pRi4YtWJXWaan8J8BRungoWAVWGsKIxxWFS0C+ovpiLmicyqqFRhJAw
	 GH6XI+bvDdYOE2xQWT0YsVWI1LtD9Nvr2ypH1EedkN4GM587/FyaqMxEwiOxpfW9rc
	 IAlpI4ZvM4ZEjBsZ0WG1kaUiFiOeX46hYWI8PQ2/x63pde0SL3X8Co7T4mZwBUr8oa
	 z4lR3QJXwkPuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 285BDE7C114;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue index
 of HTB class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539283016.14416.8665612758902938928.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:00:30 +0000
References: <20240508070935.11501-1-hkelam@marvell.com>
In-Reply-To: <20240508070935.11501-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 May 2024 12:39:35 +0530 you wrote:
> Real number of Transmit queues are incremented when user enables HTB
> class and vice versa. Depending on SKB priority driver returns transmit
> queue (Txq). Transmit queues and Send queues are one-to-one mapped.
> 
> In few scenarios, Driver is returning transmit queue value which is
> greater than real number of transmit queue and Stack detects this as
> error and overwrites transmit queue value.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Reuse Transmit queue/Send queue index of HTB class
    https://git.kernel.org/netdev/net-next/c/04fb71cc5f18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



