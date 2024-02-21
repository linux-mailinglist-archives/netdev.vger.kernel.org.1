Return-Path: <netdev+bounces-73636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991585D6B8
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FEB23CBD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CC3FE46;
	Wed, 21 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ1Dodlp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097C3FE2B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514427; cv=none; b=V9iX2a1W6Oh+SpRjmXmrSt5mBDu9QIPe+F46onvQc9bC5D7uViaDA1gNxKhLi3Y/0kRvDeCDh0pfdG9On7gO9D4797Zj9MoRRBPiUm8hiHvbht65NYgo/LxSZTj5qPOjF28YqyMJ3fyDcIAt/c2qFfv4iuxSJMi0w9rbBnmF2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514427; c=relaxed/simple;
	bh=1qqCSB+opoMr208oH2KsSYGNHZ5TdvPBR71NtHGBNRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HJ19sBNDzdxSY/+2cgO6cWVNyHdr+pxOgCUyiDI6dxBZoB0GVOmHplxexkyzebhbNzm6uTn7brW8wiyRpRe02QsOOl7XDxQsqpsOzPzs6RT01C7kuQ2fNHeB1uuyqQ/cTPm8qaYtLJ5bfCmNulp22bZKf2QKoNKCY+I/GS2Uw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ1Dodlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED8A3C43330;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708514427;
	bh=1qqCSB+opoMr208oH2KsSYGNHZ5TdvPBR71NtHGBNRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HQ1Dodlpuas8Bq4RiVsmqd/3eGg9VFg5Jt3d/0rw31OTYSUkXgJocqBHB/7LlL8ru
	 DgMyV31XpSZMnEpcsad92lqC1l52dT1CFme7qE5acLxJatuHh4pqUyZYYZOS1VWO3v
	 5lEJczSyfzwitiGZschTRY3F28l3PJxw3tq5nJWs7GxadMXg54LHXlrR1+AxrIsvhC
	 hZXKkz9NqT4FkE1RlcCvAuMFy+sXVupf61KumPBznevlLimg8nkglBsS3psHmkTSWz
	 J7rmQlGSdSdg+O2mPkiKlQpGyulhapHuvL8B62T+3dr6heUy2JrTA+r/IMBrSTsBxn
	 3nBw15H+z4nKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8FB9C00446;
	Wed, 21 Feb 2024 11:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: simplify tg3_phy_autoneg_cfg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851442688.9417.3437899430933653376.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:20:26 +0000
References: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
In-Reply-To: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net, andrew@lunn.ch,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 18 Feb 2024 19:04:42 +0100 you wrote:
> Make use of ethtool_adv_to_mmd_eee_adv_t() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] tg3: simplify tg3_phy_autoneg_cfg
    https://git.kernel.org/netdev/net-next/c/ebb0346a117f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



