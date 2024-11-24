Return-Path: <netdev+bounces-147075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F32E9D754F
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 16:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0538B168A07
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4418991E;
	Sun, 24 Nov 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toz7iTH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47195187553
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732460418; cv=none; b=R3xYB0y6JL9JKrE3FUi266w4ShxNNcvXNG8DZRnlfVUqtFkz6HjZzQFia7cGWaQhedD/T6FcMeEVbwP7Y4MK6Mb82NqWVizopQ3UMCXyBerRykBs+thcL8N3q1ZDeJU8TZNyJSGKgcDTUCTLTXDkJfsa5xyMfrCV6M1rt5ecylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732460418; c=relaxed/simple;
	bh=VWf+ug2eFn87cfg7gAxArVEC7TPM409NJRx0u2nzkF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Az/xsLlL8TvVxb7FJ7DXO6xdOLe4IL6VX5bnPm6K0ON48ui+OaWAXqjGBCdBBegukKYRdpJR0k2zTYIPb7Na64q6GC0u3mMbzXRJh3el361mCpwXY+NJRFlgbgSgnzcLP5bMuDyPhHQylpt2dMH8b9OTisnW6GV8gY9yYde1x4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toz7iTH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFFCC4CECC;
	Sun, 24 Nov 2024 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732460417;
	bh=VWf+ug2eFn87cfg7gAxArVEC7TPM409NJRx0u2nzkF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Toz7iTH5I1KuGTpxnDItpftaHyJGbdKSwSCJuMaX3wQWzwGHSY/qR1Ss7n6xm0Zve
	 kctak9QjssZ/9juUfbrGeWRWbGv/zZdusmgL0TiWblrmY1dfgXl5DMyp3vhItkETB6
	 Q4Si2rvlhNrMDYJQjjhmzsT7YjN4BiSkfio6cCg8rWhnGQF/kr5iqlJSNshl9Ci2G3
	 ir/SOV05LYgoFeHp4Vw9pkvUKKorkjVYHvbzp3W+B2HlXXTNpebustlUdnNidFXdte
	 ritgB1pSOrcCNl5dXvoAKF/u3WVVwSV+UY92TU3YagKM7E148F48JkK2VyEwEr8k1j
	 eJLbNLgG7q3hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713AF3809A00;
	Sun, 24 Nov 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: phy: ensure that genphy_c45_an_config_eee_aneg()
 sees new value of phydev->eee_cfg.eee_enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173246043026.3277616.8812166825455562327.git-patchwork-notify@kernel.org>
Date: Sun, 24 Nov 2024 15:00:30 +0000
References: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
In-Reply-To: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 kuba@kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
 andrew+netdev@lunn.ch, o.rempel@pengutronix.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 16 Nov 2024 21:52:15 +0100 you wrote:
> This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
> eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
> (called from genphy_c45_ethtool_set_eee) not seeing the new value of
> phydev->eee_cfg.eee_enabled.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: phy: ensure that genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled
    https://git.kernel.org/netdev/net/c/f26a29a038ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



