Return-Path: <netdev+bounces-117060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620394C8B8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4A0281B7C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CF618637;
	Fri,  9 Aug 2024 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQuSxrHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E81862F
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172439; cv=none; b=nLNApXjHcqhOt/JDcaCipwhTAgiyyUmtEAR4J+92rRzh1YyiKfWAd7Lmk563HS2ffR7rrTfo3VI52rV55PaGs/vR6aF+EnI/LJAYgSHSqq/qPxIq8KlSz4PYRwY1LWuctdFK4EoDE+XGfIA1HRC3xraA3Ypx6dQjn4obGMz1PLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172439; c=relaxed/simple;
	bh=klNUnO2PLaIY4J7g68b8VivCAZjmWZtr3TkrJ8JhWvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVZRVPdX/7S4q4gCREtSJhZbF5H+SFL5U5XmTX0SE63tuGciw485VnBnlAtF2mok7Rzcw61S1zr6qMoa4akpVGhNA8J+iQr4grTNtRZegtqdMzmaE2TodENykXICZ4TX/wG6rA4qSDeO4uw+5IX07xh9HrHf/6AF75L2a69DmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQuSxrHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17516C32782;
	Fri,  9 Aug 2024 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723172439;
	bh=klNUnO2PLaIY4J7g68b8VivCAZjmWZtr3TkrJ8JhWvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uQuSxrHblPIBMJo65MvKjmI9I4cWL+484bjb4YMCo4UjHyWOdXiq4oBPjiqVqQtU+
	 sryWmLC58jE4JRnFzENDCr+G9GZXbvf5+EkmxVLAOEZxMQkviD2bW+IYJE1+bhasqc
	 DND0NnOeMa/SxH89aiTe942NcjQSY2oavM+lw2ZciWEcvytPjEh2Zi/838QtDKkaO1
	 YdJJ7oQt/694cWqBwmUm787i5asf8yzdQ6WGhUY5jwkygNPrZUadPZR87euAnUBEbH
	 bDcolrjE8GlM4r35z0b6wDbNm7sxp8A3stmZZIGZT/HIY39q+gEyjFQb54PiHW39xZ
	 H/2z5BoENF8bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD33810938;
	Fri,  9 Aug 2024 03:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnx2x: Provide declaration of dmae_reg_go_c in
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172317243774.3366602.16742247026624672939.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 03:00:37 +0000
References: <20240806-bnx2x-dec-v1-1-ae844ec785e4@kernel.org>
In-Reply-To: <20240806-bnx2x-dec-v1-1-ae844ec785e4@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 06 Aug 2024 11:56:01 +0100 you wrote:
> Provide declaration of dmae_reg_go_c in header.
> This symbol is defined in bnx2x_main.c.
> And used in that file and bnx2x_stats.c.
> 
> However, Sparse complains that there is no declaration
> of the symbol in dmae_reg_go_c nor is the symbol static.
> 
> [...]

Here is the summary with links:
  - [net-next] bnx2x: Provide declaration of dmae_reg_go_c in header
    https://git.kernel.org/netdev/net-next/c/a39036847fa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



