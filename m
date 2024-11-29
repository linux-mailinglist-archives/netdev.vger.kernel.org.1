Return-Path: <netdev+bounces-147858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B869DE6DC
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E31655D0
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB019D88D;
	Fri, 29 Nov 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LudS6QWc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646E1990A7;
	Fri, 29 Nov 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885221; cv=none; b=dlsgO8h5zxERvkd8cWK1v+9EgKZGX9tnxrmNokvbbmtVnxz4caH6ll14WiqRpxVQdyfT0Fh+cYKBEqXJCs/hF9Hq9PvIPBK5Uy58gXaiBdEiFCF7XxqkMiobejtPX70Aq4ApcbCMzIyeW8qdtV5fo/iR4qaG9i9Fez73PdyKH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885221; c=relaxed/simple;
	bh=EZSlC6SXS1TbSr/OBJYAXY6J74OQV9rZ4pWyg3gi63g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBdDWDOQN5vbBzcEpWx01VWHQFRJwGO42+g/YJVNbVM+bvIijCOJH/GdLWwzZqSQExPeOSjbQqX/6nOKoffLuIfH06J/YS0yGG3JEkQGYH5/UqGlZ/SKoLjHIKzjrcPrPJhcUyUG9ouhTCyTsZb6yONwHg2QQ4ohZHtY0YZdJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LudS6QWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE529C4CECF;
	Fri, 29 Nov 2024 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885217;
	bh=EZSlC6SXS1TbSr/OBJYAXY6J74OQV9rZ4pWyg3gi63g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LudS6QWcXCFSF2hXyWV/zBotpegWXYwcq+ncX8UeMJOW375lvl2LrwFpqzbnAJEga
	 fp/TLmfqZx1/1y/JL/E0Ed4WRaAA7c3djDQyyeRF/1a9qI2i27VvKiD2iM6qj+WDXD
	 5gBl1Hc76JAb26Xzi+GnbxKutwZk9Pn8X7nsg8oeHci3jdviBLWTeCgDQ1d6xW7lc0
	 vHJzysdkqv766VEZzgYyznM+dV235k3uZgdClKTuDVDkQKaZFL5zKpbEUWsyfieteU
	 mJbA/RontM5hcb+Fx0uVP9fgvV62aHmNeT1J9Ns6C1E++ebBtu6y5wNwA7iJtlFhks
	 z6MjgZdRJRZWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6B380A944;
	Fri, 29 Nov 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/2] fix crash issue when setting MQPRIO for VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173288523126.2057860.13508861605315833852.git-patchwork-notify@kernel.org>
Date: Fri, 29 Nov 2024 13:00:31 +0000
References: <20241125090719.2159124-1-wei.fang@nxp.com>
In-Reply-To: <20241125090719.2159124-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 25 Nov 2024 17:07:17 +0800 you wrote:
> There is a crash issue when setting MQPRIO for ENETC VFs, the root casue
> is that ENETC VFs don't like ENETC PFs, they don't have port registers,
> so hw->port of VFs is NULL. However, this NULL pointer will be accessed
> without any checks in enetc_mm_commit_preemptible_tcs() when configuring
> MQPRIO for VFs. Therefore, two patches are added to fix this issue. The
> first patch sets ENETC_SI_F_QBU flag only for SIs that support 802.1Qbu.
> The second patch adds a check in enetc_change_preemptible_tcs() to ensure
> that SIs that do not support 802.1Qbu do not configure preemptible TCs.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] net: enetc: read TSN capabilities from port register, not SI
    https://git.kernel.org/netdev/net/c/8e00072c31e2
  - [v3,net,2/2] net: enetc: Do not configure preemptible TCs if SIs do not support
    https://git.kernel.org/netdev/net/c/b2420b8c81ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



