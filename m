Return-Path: <netdev+bounces-173152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A945A5782B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 05:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D1D7A6A71
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD12915E5DC;
	Sat,  8 Mar 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/GztMjN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BC148857;
	Sat,  8 Mar 2025 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406408; cv=none; b=u+u1XUJponCCXDW7EQncmTPy/CTU2MHVf9GxodMkaisstXYD2+yOWKy4vfKK8WUBeBd2aDSr4zJh4UnL0UnFFInjtr2rvF7583t5EavxjlcOd+mpMENXHGNDpteFBUbQwKKo7U7wu0JZ9Ubev5FIuEEXUSDjSzkC0T7cr3AfRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406408; c=relaxed/simple;
	bh=l90PT/23TcBuQ8NyWBxWVeCbtj0856DbC1B/xjemcEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JULHZmydPFDvZqnrvkoMPRWSn9WFYigvPmpRgzk4/IQTgsbqnaa3+QIZptED3KTnIu9O1cKkdCKqtOuesbNKS4hGNpZ+4amSn0jL7soCKZFUMlnCcm2Pb4XEkuhYgh/H7i14EN9dqvoZ81bTFRGz8uL9NKb1QToVeyb7h11m7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/GztMjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3053C4CEE0;
	Sat,  8 Mar 2025 04:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741406408;
	bh=l90PT/23TcBuQ8NyWBxWVeCbtj0856DbC1B/xjemcEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z/GztMjNsEM+nilrL+yRWfRJWXWyAMp9JgfduH5cVj10Memcj5S+dt/s1cJuFAsjr
	 38otziIWorCx/pWXbtqIgJKSeK79Hi/rfUvg2BWYnn5arkEnsErElIVrocF5+fAG9w
	 8zcZuRLkbFDUHwgG7pXwhq+MKL61h6LEzRziwDyZhVoNwMcTj4rFjkGIGdMDGvwwSS
	 Wd9wMa0vCxOFOkkngQSwlEpLNMIQAMNpD9rAIVq2gpb9hyYqhjHW0/wz75OxuY8M1j
	 DpqMbc6pAK/L5tXCyxQBJssxxR31IcBxU/0Km7lS10+8dh83zkvq49TytljpeMMWCx
	 OlFXUiEYd5W8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2F2380CFFB;
	Sat,  8 Mar 2025 04:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: phy: nxp-c45-tja11xx: add errata for
 TJA112XA/B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140644151.2570715.57630167993884355.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 04:00:41 +0000
References: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
In-Reply-To: <20250304160619.181046-1-andrei.botila@oss.nxp.com>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 clizzi@redhat.com, aruizrui@redhat.com, eballetb@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 18:06:12 +0200 you wrote:
> This patch series implements two errata for TJA1120 and TJA1121.
> 
> The first errata applicable to both RGMII and SGMII version
> of TJA1120 and TJA1121 deals with achieving full silicon performance.
> The workaround in this case is putting the PHY in managed mode and
> applying a series of PHY writes before the link gest established.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
    https://git.kernel.org/netdev/net/c/a07364b39469
  - [net,v2,2/2] net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata
    https://git.kernel.org/netdev/net/c/48939523843e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



