Return-Path: <netdev+bounces-178115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2ABA74BDE
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82E8189D579
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883D21CC64;
	Fri, 28 Mar 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKIUIbj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0121CC4F;
	Fri, 28 Mar 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169803; cv=none; b=PnYa4A6N2knmxcDCnilSE+EgwSIbCqMfehoT8UHJrCwh0I4DLtK1Y8tIiEESmr54bUYIermP6z1K8HmwmSJACY2ChI3/sCjooMWjigmU39UiaV7rnpe2AS7UhUM8VfZzAHAfAfnDJB7wp8oKrbx3pJ5v6eNB4Fly31P+VNr74eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169803; c=relaxed/simple;
	bh=wFwkiYsj3KIa1H4hz6pbIeFBrx8Tu0VdbXzAYXRFplU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m18OGt0R4gz/Cn0QaTy4SRn0xXhB30ftrrw1ngRTbloumkqCI9pyc2OJf2tezr8UF7VzuxMepO4VkBzY9f/x5PsrdgPvWqKUxQ6A9qFVAUyo1Wa1L9ZyLdKVmBNnJyrRnpjpB4dml1vetYR37bIYSaCDzo5iWyr0TKL/HwjgyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKIUIbj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0D6C4CEE4;
	Fri, 28 Mar 2025 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169802;
	bh=wFwkiYsj3KIa1H4hz6pbIeFBrx8Tu0VdbXzAYXRFplU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YKIUIbj/oTR8CT56O1Z7dlcR7QDrR9Eta3xCL+y5pcguk83D+mIq3DLgHr+YaWHwi
	 QFgxLeD3/ZniRIFOdFTbND5Td96eaumThQ3Bf6bADCMaC3f7RvBdfTmqoFMvl/wrEH
	 zJ17QoxUM0tG4Xe8zf0M5RqaSuaeCe7v7NSDpFLrfWQoaKQ0Ht+MMh0dRngv6saXWN
	 Myy/4CzQBCfrgOZqZ8YeT+6/jZIoM6lkgi8C/kxUxhJwwYonC1jTYC2emJ5UOuWwHX
	 vdicrBb08bGrho9lkabRYFSSPMyxcJJizm5IcDihjJNp6gxLWc3kT86vm6lrhrEqvf
	 /Njq5IFCYVM7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340F9380AA66;
	Fri, 28 Mar 2025 13:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] MAINTAINERS: Add dedicated entries for
 phy_link_topology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174316983875.2839333.2957183393476679448.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 13:50:38 +0000
References: <20250327110013.106865-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250327110013.106865-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux@armlinux.org.uk, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Mar 2025 12:00:12 +0100 you wrote:
> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net] MAINTAINERS: Add dedicated entries for phy_link_topology
    https://git.kernel.org/netdev/net/c/52c19f901318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



