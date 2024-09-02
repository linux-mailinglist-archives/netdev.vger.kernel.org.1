Return-Path: <netdev+bounces-124203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B879687EC
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE781F22EEA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76533200118;
	Mon,  2 Sep 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvGAMgLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6E20010C;
	Mon,  2 Sep 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281430; cv=none; b=gaSwyRQ3s7UA61Ub4LVR0dtDf+2syxcw0CwQyANjpRABkQENPUNMrBckjMFG0v7wqi3upzLNLE6xlEutuXNPNQcgNiUcjO/knYMkIcn4/3K6IISzwF89DyNJnOAbgxFqG+jvYWJXzop4dg+DsiCPINUFsFKUlcN8YJP9NEeOifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281430; c=relaxed/simple;
	bh=jUGbCvappkupnOCyTWEDiv39z61vi1zMHP+E6B0TIas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVkwWARmwr4SGPa3FQjaNK7PvfQEx2MzbxAo9jYPzyJ2NlLSGIV57O5f+kKpyBHXsW+NHKehE8IoP5Zn5RiiCzGQpS5/MBoqgJWZdNklyVRoRxS/U0MQQ1DeBAu6TgNkH7tNON9xDzqAuOvCdamayQRN/PI1Euk51YDpTzWe+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvGAMgLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA940C4CEC7;
	Mon,  2 Sep 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725281429;
	bh=jUGbCvappkupnOCyTWEDiv39z61vi1zMHP+E6B0TIas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nvGAMgLP3s8VI2YMGOKyxVIC8+pxlpcA9hoEhVhOygDvDypHdD6T365PX4HOYokqr
	 fR249ww16kvtWdcdkRX+BxVAOg3thn01r/nfIZY9Z6/I/93WtYKSmH7FmtrN+OLYJm
	 mobF67bxpBAPKmKA2SBzyUd0ETwR+4F/kr5H9kw9sl7obbEEZy+q6Oa5ZGjbR1pz/0
	 avJuxrAY/34/EXtXP9vAwJ5oEDRyE4O0KaFUJqtZa32LjJLQ7GRBST79i0RbfX/kqB
	 H1NLBTvNk/d8RwMTMMhyl84UMN7TFtljNfFQLP09rDeKkMHrlpvqzOqOwVffjKF5IC
	 +SzLyCAQ53jrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBE3805D82;
	Mon,  2 Sep 2024 12:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: drop the ethtool begin() callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172528143025.3879101.12070327930578718589.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 12:50:30 +0000
References: <20240829-stmmac-no-ethtool-begin-v2-1-a11b497a7074@redhat.com>
In-Reply-To: <20240829-stmmac-no-ethtool-begin-v2-1-a11b497a7074@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, quic_abchauha@quicinc.com,
 quic_scheluve@quicinc.com, d.dolenko@metrotek.ru, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 15:48:44 -0500 you wrote:
> This callback doesn't seem to serve much purpose, and prevents things
> like:
> 
>     - systemd.link files from disabling autonegotiation
>     - carrier detection in NetworkManager
>     - any ethtool setting
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: drop the ethtool begin() callback
    https://git.kernel.org/netdev/net-next/c/55ddb6c5a3ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



