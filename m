Return-Path: <netdev+bounces-133402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBD1995CFA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A41C21839
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275EB558B7;
	Wed,  9 Oct 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB8lrQ+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDAF55887;
	Wed,  9 Oct 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437430; cv=none; b=SSHUNOefcwDLbKpkroJIeZ7GsPnrMYz5Ve4nB7+keHUEGjWGp8CD2z9T3nSGVUkoZA4QbPE7IXIdAcrpQ24qsZhgcAJFbTzkRn2yxnORqsy0WlUItKxebM/FYjRJBPTCLX9HLyfgitUSvsHqlZUKviH4PLT1hmFoHwSW3gNvrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437430; c=relaxed/simple;
	bh=6tpM/S5DCcqxpBet4bwGuJOybdi55lGtrtupQzfLU+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V6y6/ZDqE9RWQtcZwbBnCfDUPntLeNQNRybby1vRep4x+1+UCWyvB/fRflyJKrvX4lILlvtPitQM7AnEEBu8shX1VwNMJTn5M4K35aZJeAeEBQFONzzn48cJttURGkwERom7j0/VEF91QTknwCLLDA+R6j9ZveANd+CZsd5kwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB8lrQ+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D5DC4CED0;
	Wed,  9 Oct 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728437429;
	bh=6tpM/S5DCcqxpBet4bwGuJOybdi55lGtrtupQzfLU+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hB8lrQ+WPKXYE3KVvIQ3iS3ZjY2bYsycRjAkQOUH6auHN00MDtLEngiXCnJuhYSlM
	 Fgg4ABdrnlr0oXEvxzpXvneyXAq/Nm6jTsrq2/Jhr4KQMdyETOIZbO7v0uUx0bqqzr
	 iFrOV0iNZnE074FhbwZouARQEUskQBclTOSr1LPeLzHrIaHHx0rWBqITn0sCvNFepx
	 +G2VP+vEjt+xFw2gfOqTyDpBTNiSGuJcC1KekGVJh2S8BXmoleW1FKEy+fkk9Gdfnz
	 O7YdoQByfgzH3DPhyoyIG04W4EDbYMrvPleDunRNqhD76JBY+6K0t7dohc5nn+DD4q
	 KC1raZC5EB7JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBAA83A8D14D;
	Wed,  9 Oct 2024 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] fsl/fman: Fix a typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172843743351.746583.9528277817732557260.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 01:30:33 +0000
References: <20241006130829.13967-1-algonell@gmail.com>
In-Reply-To: <20241006130829.13967-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, willy@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  6 Oct 2024 16:08:29 +0300 you wrote:
> Fix a typo in comments: bellow -> below.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v2:
>   - A repost, there is no range-diff.
>   - Elaborate on the change.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] fsl/fman: Fix a typo
    https://git.kernel.org/netdev/net-next/c/ed1f3b7f1572

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



