Return-Path: <netdev+bounces-131818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F53598FA5C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C591C2278F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528811CC171;
	Thu,  3 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc58XIv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234141CB330;
	Thu,  3 Oct 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997629; cv=none; b=T+oanhfh9+T+Ry1fKNRfmgVxmPmQEhG33SmDw69RcgJjLwTMOBXc1IefIvNZSyR7Ornrc+sUv7jZJ23DcX7/SyHvHahOT6dEqh2r56n3kMYt4ETskawgG6GKsvEv3WdRY+RJ6VH49jiAry6xB1J3ANMpRLDYo4qSw8CL/GSeUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997629; c=relaxed/simple;
	bh=nhH+V4qb2eleQx28etoD2vL2+/qmd10wK/SY5oX4Tac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ASNOtkOsAgBLhYK5dkS+1d+s40PHR2dPr+55wPOC2VAvKAMq9WD4ztdYlhYNv1JYWNJOH8ImnKx8WWum9zFP4O0HrSOkt+mM06EYc0QVz2nlsmrwJ3VnLZdO57CfD0n2u/MxeeUePTLLPbjGXKpQu3tOiAK4Rs0zlovZ5x+QMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc58XIv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833CFC4CEC5;
	Thu,  3 Oct 2024 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727997628;
	bh=nhH+V4qb2eleQx28etoD2vL2+/qmd10wK/SY5oX4Tac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sc58XIv9NG3SOHfE//yjOgLnJtZJKTaLOifNX0LS+2I7ICJK4FMd1jM0sb3WxiChK
	 +mXpG347ghoSL8lyLC6IvInM6Vxn61DPET6wVOVYlEvmPQ7+j/LMJGhn1ZR2SDtKx9
	 c+69KniVHVroG/7MkKh4Gler6Eu+lsqPydRKlJySINiSAHNaDo+eY2XyIeeL3fw1KV
	 rUvcaHuYlwsk3yLc9deVj9v2fT+SR/rX19Kb0Nr3dpBSoSTZpS4kgpGLTnNMfeaQ92
	 uh5b5vaYu87NPGr1wpRRyq5dZYPBLOVGcD48IRfe5I2eXCx05oribCitSGXCdf/WQC
	 BpQyQLJEZuPGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF33803263;
	Thu,  3 Oct 2024 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/2] Fix AQR PMA capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799763201.2024724.18240584143482513480.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:20:32 +0000
References: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
In-Reply-To: <20241001224626.2400222-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ahalaney@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 bartosz.golaszewski@linaro.org, linux-tegra@vger.kernel.org,
 bgriffis@nvidia.com, vladimir.oltean@nxp.com, jonathanh@nvidia.com,
 maxime.chevallier@bootlin.com, przemyslaw.kitszel@intel.com,
 kernel@quicinc.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 15:46:24 -0700 you wrote:
> Patch 1:-
> AQR115c reports incorrect PMA capabilities which includes
> 10G/5G and also incorrectly disables capabilities like autoneg
> and 10Mbps support.
> 
> AQR115c as per the Marvell databook supports speeds up to 2.5Gbps
> with autonegotiation.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/2] net: phy: aquantia: AQR115c fix up PMA capabilities
    https://git.kernel.org/netdev/net/c/17cbfcdd85f6
  - [net,v6,2/2] net: phy: aquantia: remove usage of phy_set_max_speed
    https://git.kernel.org/netdev/net/c/8f61d73306c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



