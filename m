Return-Path: <netdev+bounces-102782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4790493E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 05:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533DD1C22FE2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676A107A8;
	Wed, 12 Jun 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJXRyO8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CCE566;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161234; cv=none; b=qPEIKCHpaCQc1Rr6Ew2eGyss6ShHXvUQKkr8Vab+GcH0HghpzKaIiOjLCodwEOHinHfqBngp//TOrkd1U3MvGAuChAvOZubyEcFXQF8V86W29wp1SkOp+CnCtgSAe188oqXFpMM+5VXgYA1TPzNkIXq9wF7AJ9zRErWdYMgg5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161234; c=relaxed/simple;
	bh=GiZ5FeQVXlCnlgnX5r2B7z2qC87zWrx2BoPI3z5NG68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFzpwD8X1FJcLlq2BOkETf6JNe36QWFmNBAwXsTPehr0pVeFdpeF185qBBx2MFQx6R9KRXd6lf1G7LXRrkgl6QI+i+xblDCBehXjJjUGawD5QfDcHn7d9BwabcNsOTveoJuQ3bgNsXjU4NP3PvRjp5SdIQ8mmVN1hIs+20qrhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJXRyO8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F50C4AF48;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161233;
	bh=GiZ5FeQVXlCnlgnX5r2B7z2qC87zWrx2BoPI3z5NG68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FJXRyO8h0nDWSeWN4Nc3VoN/OElpJCo+Uo5jPOYOHsYLGGhbwrriAATYRAL4WOiHg
	 WA4TmA0p1HAuHTlIXtwjZ2UXpWnKc98vm5eEQOxBl5ldSoNar4xTcir0KWZRNAE8jR
	 7rwWzCwUVF39qo/vYDEsgbHdt8SCPfMnfiAiuMgnw7XOGLPrEJDLvILO//pJMCVUu9
	 7HPSygsccvKxY8Xpar6/H1NUVBdPNx6J/7Ly2Flkxqtqx5lHeL/5LC/YOZm4sQJDV3
	 wYW3O2eSnGP8BoF/qrSLNLYxwEmIVgA4M3emZOoH2p4UuVWntWumpesIovzZlv46tV
	 8DR/id5xdrrGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61B8CCF21FA;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-06-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816123339.11889.9702953848909886720.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 03:00:33 +0000
References: <20240610135803.920662-1-luiz.dentz@gmail.com>
In-Reply-To: <20240610135803.920662-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jun 2024 09:58:03 -0400 you wrote:
> The following changes since commit 93792130a9387b26d825aa78947e4065deb95d15:
> 
>   Merge branch 'geneve-fixes' (2024-06-10 13:18:09 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-06-10
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-06-10
    https://git.kernel.org/netdev/net/c/f6b2f578df8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



