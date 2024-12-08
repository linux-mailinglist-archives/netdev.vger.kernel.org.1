Return-Path: <netdev+bounces-149959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343E9E8330
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA96281ACD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39B17C77;
	Sun,  8 Dec 2024 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBts3ut7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56154728;
	Sun,  8 Dec 2024 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626214; cv=none; b=FU9zLsS69bnpEBJuvI8lSQSTQNGQh6eMlv+qADHxSvsxW59DKAonuAKFERG2GE48o5coPioeC7Y2OApTfFGauNA/Gojmg2+KPpYefnmieGQaH4EzVmDTN92Dn2EpdWhl/xcLk22CDZ6Vh+VIlok4g57AXCnd6nO1JUXmV4V+4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626214; c=relaxed/simple;
	bh=MySWfTYS/uH0Ue/1Ic0M//3SDlEiMfhIVgio1AebwVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KRTaWOHEUdx/EonjSoEJ89i7iW6ZhqIBjO2hn3WbNHo5y7Q2ORcKdcHilPFw+L4xb8SeclXB/5OnDYcJqSMb6wL/5YOOc/hwsE67yRl0NNKPM4gh5hg5oPoHO6za/6kSSznSxS5qbXk82tktvEnVZK9zqreKRDbZ5yZiOfNI2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBts3ut7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4001CC4CECD;
	Sun,  8 Dec 2024 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733626214;
	bh=MySWfTYS/uH0Ue/1Ic0M//3SDlEiMfhIVgio1AebwVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oBts3ut7QOnnM7m56NHMaWOp4IS9a6E+DcbmplXi9jlKGO14kRL8Q43eKtn9o76OV
	 R4AIBYxrU5cfoJHUc2bcLzgmG+0YezaMu5kNl+78+M0JU9pzScABd7KshmyjgH69eW
	 c6AFJJr+jS+Z26Vdz6UJYz6+GgN5Z7g/Dyr7Dqataucf61kTichsv/fvlg2Rwd+0wl
	 zd93LHdsuZ/M2pD3KvE0jwegCGN0pQ1qF87sxaT9c3nC97yp5+g6vmBPvP3Qxqzkf7
	 hSrwfvV5eArWETUBwkELjq8NZ/I28Cf3Wzh7i4MZZMBazt0Vbul85H4+bKcRutnKdn
	 ArZg4JJXYY19Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE37C380A95D;
	Sun,  8 Dec 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rtase: Refine the if statement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362622953.3141063.1221958910878945135.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 02:50:29 +0000
References: <20241206084851.760475-1-justinlai0215@realtek.com>
In-Reply-To: <20241206084851.760475-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, michal.kubiak@intel.com,
 pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Dec 2024 16:48:51 +0800 you wrote:
> Refine the if statement to improve readability.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] rtase: Refine the if statement
    https://git.kernel.org/netdev/net-next/c/7ea2745766d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



