Return-Path: <netdev+bounces-128271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCC978CF0
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B991F2570E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575B17BD6;
	Sat, 14 Sep 2024 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+a2lTdx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E51B978;
	Sat, 14 Sep 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282836; cv=none; b=UZjc4f+r6g2bpTPYamUZ82dt2fv6kA6YjVoI5F6D1Q7xlHEcw3vXuhLZ/19dqf5SFt6eqbGXPO2qL1U4kaixfPCQS88AETYErTvtFNGBoO/drpw8HnDpw5+xWZiBWidlTxF7eB/hz6dK4rCXZQFZIE2LnLxgZeMim6F+LkdlA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282836; c=relaxed/simple;
	bh=95WTj2xlbZFe2YzZu+W90jZJWS/V+G1wqG/2TCbK7AU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8/SC5Sh111K0LM9T0sK6oRdBFz+rHHPVS7IoWO26QkdVQz+QT5aaWrHuSOt0Le4P4yMbbVMR1sTv5a7V5s4KbQxDzaw2RzbLNp/ao2Fu9EEuS6nl6WXiJdf9/aO6aL0i8qitJeMh+OniCgsZVgWndyOPqA5O6aEeQHCoTio3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+a2lTdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8154C4CECE;
	Sat, 14 Sep 2024 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726282835;
	bh=95WTj2xlbZFe2YzZu+W90jZJWS/V+G1wqG/2TCbK7AU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z+a2lTdxgXMSE0ASbwsipLpHbn5g3/aC3tMWXBhvmLqe6CIRXAlFMuy6fAbjCUcsT
	 25GYe8RG50lKeE+CCsERP6qE5lWKeC1Kh0bcgwgHwglg99og73p7eCcvCUUNGmFmZ0
	 bD06egDhTYlRtavqOC6UG+eP6fr5awjlopX+dKPSuEwtzSEVr0u2ZOYtvjNag9qTV0
	 O8ijxLN0RFBeT+f3Q2LAGJvZiAMFqwBnPWQcTNuWYTDS3qAlWj15I05uwT1JVqpw/L
	 Pv/IBiZt4HA024pH2Jy919UX4i13JSoHuissjUY9salKAGTVCY0Zw0/UYWxyvOhKjC
	 4IjmPuTkceM/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF33806655;
	Sat, 14 Sep 2024 03:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ag71xx: remove dead code path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628283724.2435669.12894402416372191357.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:00:37 +0000
References: <20240913014731.149739-1-qianqiang.liu@163.com>
In-Reply-To: <20240913014731.149739-1-qianqiang.liu@163.com>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: kuba@kernel.org, edumazet@google.com, usama.anjum@collabora.com,
 andrew@lunn.ch, o.rempel@pengutronix.de, rosenp@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Sep 2024 09:47:32 +0800 you wrote:
> The "err" is always zero, so the following branch can never be executed:
> if (err) {
> 	ndev->stats.rx_dropped++;
> 	kfree_skb(skb);
> }
> Therefore, the "if" statement can be removed.
> 
> [...]

Here is the summary with links:
  - [v2] net: ag71xx: remove dead code path
    https://git.kernel.org/netdev/net-next/c/7fd551a87ba4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



