Return-Path: <netdev+bounces-152025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F59F2647
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CC6163F17
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723401C303A;
	Sun, 15 Dec 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOthLR5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1A1B4150
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298217; cv=none; b=XKKnziG57yBm8VPCeiGI2XTV2rgyxZmS8zvgZsivOaNu2G2cDVKC/Wy+Pce7K54wiDtHiWP4UHgHS+k3msewrml4q+lzwWkWlzzErY9pPfOMZY8RvtP1zGT/UPg0YDkcmLvGbPgcmwppLB9FGuEpE7E5CJ8XTwafHZc3Jqv+mKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298217; c=relaxed/simple;
	bh=sgRorZfPTYxmcyEkeB6VeB0CJoyalVpZps2xvM5iHxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkyN6arHNDDbC0WCHT3HjziR/S42JFHk/OhcgL85k1nJxVNpbqs0x1hlyuUPEHMq2J8sXCPk5+y45gTK09Wgnsd+D17Vn/noVYAiKm7hwQfuq3gEM1xwbsrGFCtt5VshF7VBmaX7l26b7y0pHL2qLYVg54/bPItPMLVQ89uA9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOthLR5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA274C4CECE;
	Sun, 15 Dec 2024 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734298216;
	bh=sgRorZfPTYxmcyEkeB6VeB0CJoyalVpZps2xvM5iHxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pOthLR5wj17AP+n3odNy87KLU3GOA6RXfnKleW5OeOf1XKDnqR0DnWwWt+KdDh9PL
	 WowEiSdk8DHt8KZeagp3r/jFCUQK1kGXL0k+MWgP4k3afHaD2/uA/A/Ios4SGyIlPI
	 i8XUit0MDja1bqtLyElcNzB23C3FBHC+gyKoE89KaMu2p7k2RoffGobSkoU2J10Ye6
	 Qmq9/4F4RNgr0K8pzHZN5aPIjsScTCEUn8ziKoXpfZSAFi0T/qObw1SUYP4fi+V/3E
	 X0QPMPEtczWH9JEhBsbZrAjJouiyun9gWuRk4/dYveAGJu6nUBj7xrf28AiQ/fDdbG
	 4K7bh8N7bhR1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB73806656;
	Sun, 15 Dec 2024 21:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv4: output metric as unsigned int
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429823374.3585316.16468721817235282285.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:30:33 +0000
References: <20241212161911.51598-1-code@mguentner.de>
In-Reply-To: <20241212161911.51598-1-code@mguentner.de>
To: =?utf-8?q?Maximilian_G=C3=BCntner_=3Ccode=40mguentner=2Ede=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 17:19:11 +0100 you wrote:
> adding a route metric greater than 0x7fff_ffff leads to an
> unintended wrap when printing the underlying u32 as an
> unsigned int (`%d`) thus incorrectly rendering the metric
> as negative.  Formatting using `%u` corrects the issue.
> 
> Signed-off-by: Maximilian Güntner <code@mguentner.de>
> 
> [...]

Here is the summary with links:
  - ipv4: output metric as unsigned int
    https://git.kernel.org/netdev/net-next/c/329365dc46b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



