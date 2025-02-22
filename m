Return-Path: <netdev+bounces-168705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9163A403E4
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF18422454
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522289476;
	Sat, 22 Feb 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSxEihoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3798BEE
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183003; cv=none; b=JleG+uVCf5+BmmxpynN49jwG2VtME9sn07T/9paqTG3p4/rznotl/r6nToZg5FK2wjgZ4wWYrsziB5ssSjbxoqwPrLHH7WBC63o+mnRffwdFS08g18ue+jjMuV+/LyyUhsCFOoCOwH4WmyQP0Lr0kO6KaumlSJz5AMogfffAc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183003; c=relaxed/simple;
	bh=A1HI52iCXplF03Qr0S9zTZnd7bIjPOjKrBBsE7ibHz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqQ4ZbD7e9kTSkCMeI6AhElC3/XuZAekzHxtTFl9aArGTMdByA+nsRKEBgFStVLVVEW0Iyg3v2F9P3NpE3LOzys+CtmdnSGRSvCvgdYT60ajVUn13a7GMwkXrgqvVdRIzwYI9tqPKXAaNv9Qjtud3UPa8xcG28ZnUTF8/8ytrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSxEihoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187EC4CED6;
	Sat, 22 Feb 2025 00:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740183003;
	bh=A1HI52iCXplF03Qr0S9zTZnd7bIjPOjKrBBsE7ibHz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VSxEihoWK+lkXsaM0f286muZKX+R2BMF9kzMRExB93h13i3hfT9iYcYKL7zfMXbSu
	 Co1alBJCbjJkOl5kyePZ7a6Mh+ouVVoE9Z1ixpdmXu0/fo5hzjukEofKAK19u1Q84W
	 B5EkP1z2nF+E33pObm2uTmC0h/AUlgKzbZdSkRcXTCHKyXpWETUIztaVlGeyBIaRX9
	 DWNz+kgJChXpcneWciC+Xer2Zy2vplkdbu4562Tha1CciJRfXGoV0h1FkAYmp3DB9K
	 nj3a8pGD9a1KT5hu1kb8SHzRD2y13XOHfvFqKoR58H7VgPIDLNOtRJU6o/9ywADJ88
	 mQwBYhnsdecow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3426A380CEEC;
	Sat, 22 Feb 2025 00:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] gve: Add RSS cache for non RSS device option
 scenario
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018303378.2244175.7514390888658578654.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:10:33 +0000
References: <20250219200451.3348166-1-jeroendb@google.com>
In-Reply-To: <20250219200451.3348166-1-jeroendb@google.com>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 willemb@google.com, horms@kernel.org, ziweixiao@google.com,
 hramamurthy@google.com, pkaligineedi@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 12:04:51 -0800 you wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> Not all the devices have the capability for the driver to query for the
> registered RSS configuration. The driver can discover this by checking
> the relevant device option during setup. If it cannot, the driver needs
> to store the RSS config cache and directly return such cache when
> queried by the ethtool. RSS config is inited when driver probes. Also the
> default RSS config will be adjusted when there is RX queue count change.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] gve: Add RSS cache for non RSS device option scenario
    https://git.kernel.org/netdev/net-next/c/4b9c7d8fa113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



