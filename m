Return-Path: <netdev+bounces-109887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878592A2FF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424921F21F6A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA37EEFD;
	Mon,  8 Jul 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyqU0Lmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1580BF0;
	Mon,  8 Jul 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442429; cv=none; b=bZlRswQGcu0z2K6OTSrv4VewEnFQ2FcY8f9rtRJnMjsZI1yaz6Hi24mW8ygRP3ZYFy75jAFVyxirv5704aBsX0QP0LaG9a21PIzSCcrl2Xwv2VOKxM5tFSJFpc47oP07NgB21wY95s10nbfzoXV0sRdT++ioZqY6Urt2YhZ6VKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442429; c=relaxed/simple;
	bh=M6GdEiJvMaQ5wA9ATUZ44nI1fVv2s09xahVt2Rse/qE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UoILIHUzLlvF0PWs4vp57ukPU0xAYI8IDNKEe0TE239pz1yQc1KHIkj56WApqL3jfm2gCbCskpXPbKD27kdeVAi7V2ry+CWYq7unarFNlSez1KcTjx/N5caYOEHQHIckgOpd2vQ64tSplyY0J/n4t+UNAL97UHjBwL+SqfU/o1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyqU0Lmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AAF9C32786;
	Mon,  8 Jul 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442429;
	bh=M6GdEiJvMaQ5wA9ATUZ44nI1fVv2s09xahVt2Rse/qE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tyqU0LmbileXOduAvk7TKS2OnTfvCRBEab2ugOy1EWUnLTe9PzTTiLywUBbSDExUe
	 L2x7asMdOUXJ44Ok5cxytE4FdtgVGFz0U64Xwi/QBbyhA0HZZLwEr96sL+DTytkDDA
	 X5hTDKqS5Xth23hMcCDxXa3VYPH3w7dAxmUbzNcuCnxc1oXlAO8x5G0eNAa6C5puLZ
	 NN4QVtYnCzAIuEawITzIzimBvongkANJA5RE9WodITLo7Yeza6gbjx4IEaAvs5S2iM
	 sAPaUzwPhT54jb+SNAF6WiA7/XShuoJthXB2arDMbxuHEVc1vR1G2Pe3Oiy2qf+5Is
	 IA2Xc2EfnHWoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EF00DF3714;
	Mon,  8 Jul 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: networking: devlink: capitalise length value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172044242905.20368.89798651861767030.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 12:40:29 +0000
References: <20240705041935.2874003-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240705041935.2874003-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jul 2024 16:19:35 +1200 you wrote:
> Correct the example to match the help text from the devlink utility.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/networking/devlink/devlink-region.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - docs: networking: devlink: capitalise length value
    https://git.kernel.org/netdev/net/c/83c36e7cfd74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



