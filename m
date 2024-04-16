Return-Path: <netdev+bounces-88235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554A88A669A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1BC2841E0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEBB84D0F;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrtQ0K19"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50F84D06
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=RUvrg59m2aBHq1v1YqVQSmalJTP/D6BCOqv7CTdkf/g7HpflhVIGQLWRy9gvj1+SPVCA3m1MDYZ9GjVdD6rPcae+DH5KvqcHtCg+h1ESwaqZ9IvIeFWrJpcXn09agQ42tS9zb3IMNcWdBFsWDxBn44LVL9JKB9Q8LMcnZG+ADj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=Ngq8XxS6CulGMketFUGR8+wvFXxjSj2wfUu+RI9QHYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B/WuO67YGdCfBiF5VaJQUfzAGAG1KofGcKcd0yis1NJ9dYxfvOwh1Vk4jbSsSX99XWlMNFxd6goU+9D+eEeyMWqyAqTfxBcJR3kCfTAggg00m5Dky/VN5DCVaJSqrAk7+hCjXZCkHrnJd31muJLtL45GP6Pgr1fldICjd3/cQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrtQ0K19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28536C2BD10;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713258029;
	bh=Ngq8XxS6CulGMketFUGR8+wvFXxjSj2wfUu+RI9QHYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qrtQ0K19m3vvov8WC6cr8iqa4NB4e6xG+P/Q9tclnz0J55HmYB/jON0BdAxQmdyBs
	 JzI9n59BSBPpNk88K42xchgPjNqlJDoMVLfWQ+NYvkQ+xqFLNVgZ1sc+5HPwPkmN5A
	 dju8xhzr8l9/1IzW+gAz1vgc6SHuzWyUWOyxjIXmf2xLf8xY+Csr1jwG07s/CDc+tU
	 AA0CUdlHYz07o6ITNhVmnPL5/itO5Hq0ml5Rlk34xy85wpk7hFNo5oE+ls/r8MBLbY
	 hSy/+TKyLju7TV+o01gp/uaaRK1dlgG+abnprOdhIvCnNP5f6B66drjrp/QKwq+Kjd
	 8Fc+T/NT4O3pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16935C395EC;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: qca8k: provide own phylink MAC operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171325802908.5697.8358107695952444873.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 09:00:29 +0000
References: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 16:15:24 +0100 you wrote:
> Convert qca8k to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 49 +++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: qca8k: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/636d022cd586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



