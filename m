Return-Path: <netdev+bounces-208078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7EB099A8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF27A456C4
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920770825;
	Fri, 18 Jul 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTHNEssX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176922F01;
	Fri, 18 Jul 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804589; cv=none; b=uAsrKtBEzs7PPKVbQafKdzv35V91ba4W+Kw66GytOZg29FG7Qe9fnir0PEQxr7xkDtqH7FdxhGXtNlZo8LSqses9kHyqWwlEwMVyPh0bj+1yEJ26mpUeXSm5/cxzFJtmMoyMNaJ56qfA1jYb+YeOt4LKIILjyS2VtSTZLqWY13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804589; c=relaxed/simple;
	bh=Xc1ByBO1hYl0N4Nnci7ojFqk4jZwKBo3+kjlI3hy8kY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDlpol40/3WT1jXlS3p6fFELfP7a557hFF6l59YNPw41TsN3BpE3u4xOoD7J+ZggM8H6Rq4EyX2sU6JHhdDVDtAKxo6DEiH24NcKqPf5X51dJRb9u04JiSP4idtGj0vf0pTKHQjWF869mVj/+KVLZn6rPR5ychaq8LH3CMCeoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTHNEssX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D85C4CEE3;
	Fri, 18 Jul 2025 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804588;
	bh=Xc1ByBO1hYl0N4Nnci7ojFqk4jZwKBo3+kjlI3hy8kY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BTHNEssXvzLSiV5vncQV1LhmtrrQExxxiT1MfoKk1VE2GnkFwkLqcWD/+ZZocXeTT
	 xxbYw/BO88VcgsfHb8PWWC3tG1QWwGl3VxCrAHvvWF/zEhjg7MFvpRrOJ6+UYc7uZf
	 rqzsmOxiwSJC1qcjCgy6eNeCtBMrKinx9esqy80YF7g1+gs8yevpbhuBK1gQ/UKhfN
	 LLhjKUFh9NRBvLL9qlD3M41GsyqfhOQ1FbuJn78ksCzXRQd7FgezrhP7QLQwcT7ZZa
	 uzjGd6YQRv+L5d953ayWBOAlDWOseZk2wxBb7EAKJwb0u2zwzef2LgXWxh9YCI0Ckr
	 6i+xHLZsPLsVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A9E383BA3C;
	Fri, 18 Jul 2025 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ag71xx: Add missing check after DMA map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280460775.2144612.5081981043029394898.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:10:07 +0000
References: <20250716095733.37452-3-fourier.thomas@gmail.com>
In-Reply-To: <20250716095733.37452-3-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:57:25 +0200 you wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
> v1 -> v2:
>   - do not pass free function to ag71xx_fill_rx_buf()
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ag71xx: Add missing check after DMA map
    https://git.kernel.org/netdev/net-next/c/96a1e15e6021

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



