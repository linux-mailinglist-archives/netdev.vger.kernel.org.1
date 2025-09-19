Return-Path: <netdev+bounces-224786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF512B89FBF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DBB1CC33B3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11621319606;
	Fri, 19 Sep 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7u8T5De"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B3319601
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292231; cv=none; b=XglhAJTZTVOM+7bCRCD+JoSQj7FAQ3docxAvMVJEFEYboecX49gfbtcwQ4KjLPBVQYHraNzNArppL0aKta8oRIKEXiNgn3ri9pmk9+bLdWyI0DSdDerJQga25YRz7u+gp2V1yf9NzhpB8+bY8CPStoDNSHyjZHp0Kvj3zoElpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292231; c=relaxed/simple;
	bh=pbRPXM5DusB0ORqQtWJJdohwYeUnAIRNzmGnyFHgCSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgp/qEbYiAvmo3Yffkm/qW7wYvXFii1KOXsgCIhjs+VqVWNfBj3aLDpu97o0VKEZkBsEQfmYIpOEbSO1EiX9dKgHIxvRoMakO5+Q5QDCBXPJQj3dSJ4wOpYRkseEQAM5/3Tw6km2vwKyzRsdSM8JfsEtZ+c+qgN/LZxhYKE/Aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7u8T5De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBDC4CEF5;
	Fri, 19 Sep 2025 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292230;
	bh=pbRPXM5DusB0ORqQtWJJdohwYeUnAIRNzmGnyFHgCSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W7u8T5DeLOrU0DYK85peSn42aNwIatglqNVWXAQyetaZS4xaohUU8GgSGGFXIZEgM
	 qA0O/YmHAn5WxLtkqtf9R45AFS5h72Ke7S5oZHzrD0F93hfryftLr/U7wTwmb6zxcw
	 MUMrUxF43ciWgvtQq1ME36FYSPus45L1qaEDdGEZcYgTKyZNyrhY6c4RtcK+Yl7Asg
	 YkjNH2lbtJm7vH4D8iRsAPX05OY0q+Eef6tiS/q0oTVvUw5YKLblCRDAN2c8yE4hP+
	 sp8Uk9bLECvsomov4qFbkSKbDOMgBY8zcNJESSeVLLzO4L0jq5EVdAkuG72pmxZQEz
	 nfhYtl+soKYvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFC39D0C20;
	Fri, 19 Sep 2025 14:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: dsa_loop: remove duplicated definition
 of
 NUM_FIXED_PHYS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829222999.3219626.11037493708323416411.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 14:30:29 +0000
References: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>
In-Reply-To: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 07:54:00 +0200 you wrote:
> Remove duplicated definition of NUM_FIXED_PHYS. This was a leftover from
> 41357bc7b94b ("net: dsa: dsa_loop: remove usage of mdio_board_info").
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/dsa/dsa_loop.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: dsa_loop: remove duplicated definition of NUM_FIXED_PHYS
    https://git.kernel.org/netdev/net-next/c/a346e48c1792

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



