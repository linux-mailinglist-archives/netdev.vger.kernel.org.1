Return-Path: <netdev+bounces-121953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89D95F5F8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D81C21D46
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC8195811;
	Mon, 26 Aug 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBdfOApq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89FF1946B8;
	Mon, 26 Aug 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688028; cv=none; b=N8+c0as2jPdQ72UxYVFK8Nu2aFg0lRdtbWoRlbDkFbo6SuhEJl4RSp3JraOWuZdBNc3N2oRV2TmO3jVLB90oHj14ytUkcdtPfhFVzk7wtap5dCupIxIeTUGpx/LJwXlcN/X1HpXmk18qXbg9xa7WUpxtv+RtMIH8wVUOBHVCdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688028; c=relaxed/simple;
	bh=i4VPrvL8MtEb6RByDzrZ9U7Fn5YAOXXC3WE7cvKBYRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXKX9CcrQ/+1G7/pfO6BLRQVuFn+GCsH673C250phOaApJpjur+qKqKwxY3vfvf2dhTrssTUKddHyNFzUJfL3IBP1h2KAgZ82QZeZ803EVg/Q2RiO5lhSQeyWV3NlwHn7Qq2MywpQKvv0M5LwhQxPrHZOfZYrU9btNnEMA476kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBdfOApq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D63C4E671;
	Mon, 26 Aug 2024 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688027;
	bh=i4VPrvL8MtEb6RByDzrZ9U7Fn5YAOXXC3WE7cvKBYRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBdfOApq8+yOutmFKxnHneFFIZHGMaAaY941hs4Wwk9k+UF+fBUcdsIVoPLaiR2Bg
	 Xaq/iPlO1yckhrU+Ci0L/wPvoCtUa8WCNtjK4ZkowQ2VXNjkPVn6Ye0QWV2pfdzh/4
	 xFTklPTexPPnTlVp0zixIeMCQORSkJPngNa5eM0bgudg53RhIT0W9v9O8z6qWSXbDR
	 Mp8ED9nR5JZsC1n1rThPq171FNmNGg9uLD54uqQyTy7y0DivCpw47oYvsxOz9EI3LN
	 l3grC4+rupoRgpHLcbgCYGutVpchK5Bw6DWgbuRuQAI5AY9M6EBJ79V+ei7odXCzPF
	 E1TiHmcDtAxCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8F3822D6D;
	Mon, 26 Aug 2024 16:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-08-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172468802751.52913.2477836895316729072.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:00:27 +0000
References: <20240823200008.65241-1-luiz.dentz@gmail.com>
In-Reply-To: <20240823200008.65241-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 16:00:08 -0400 you wrote:
> The following changes since commit 8af174ea863c72f25ce31cee3baad8a301c0cf0f:
> 
>   net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response (2024-08-23 14:24:24 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-23
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-08-23
    https://git.kernel.org/netdev/net/c/31a972959ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



