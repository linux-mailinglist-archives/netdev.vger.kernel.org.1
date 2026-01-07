Return-Path: <netdev+bounces-247538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6ECFB8E9
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C54300FE15
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94A27FB32;
	Wed,  7 Jan 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TayHqIBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5352206AC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748410; cv=none; b=d2+g2F95hvdDAZ6S8IKiAJl7r+DOtE1qB8ANGG/RKXrmJySgQ/fJeHd5LUQ7b+GOTpm7dn9eulqgBjT8vUqj/3PuVK6Zgxy8udUtEqft8g1NCxIDgPMBeSIjCqqRPSCUn6Re9M+V7jQur7fwG1nUezQNIaRbClkFC/6RdCUa3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748410; c=relaxed/simple;
	bh=SUz+jHX49yTtGTMEK8l5vTUO8qkQavjw35ea/zmWOE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElTpdU3LfJBLeDBoidwWMIb1s9F6W0pfRUMK65O42Tw2hrd5s75At+PPfR9p0NFAjc2qeBqGXjV7UBu/9oazY7saYeg/q/pDx0C3jNVdVXYTNslt4ekv8rEoDHH+/wFKiHiOxKFIagNxoWmFV3v69WPdjKwFPHPJOAxL9ZjopXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TayHqIBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4298CC116C6;
	Wed,  7 Jan 2026 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748410;
	bh=SUz+jHX49yTtGTMEK8l5vTUO8qkQavjw35ea/zmWOE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TayHqIBFt8O5EI1UVbLPO5o5g9oeuneil9eSqrtjw7RN+s8+9UgYmMoExNfx3V5fA
	 +N/CWde3s9Bcxh5VFynE1QwSs56ZP18xPvtCFdrALbYFeFGbkFcDKM0GeQ5iXC7qEU
	 EUdQjwIU1lBV4Xl+DpLJL1aNaAcyWzu5chZ2kQ3tJL0FtaAl9oIN+GObR0Le9C305m
	 imwFPBO+hk+cuWQ4826Z6DMIU5H9s5wyzyS5CLnt0brclS/LicJtO5bL/on0QXwksz
	 tQ5uP3/q7agnHMiJaYp4pec2ezjkIzCyI+3Hvk+/uLIm3cS6p0wgCmY2pfW+FiKdUs
	 NXkKrX6JCT4nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2823380CEF5;
	Wed,  7 Jan 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx
 amplitude configurable"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774820778.2186142.10553727330446335686.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:10:07 +0000
References: <20260104093952.486606-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260104093952.486606-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kabel@kernel.org, holger.brunck@hitachienergy.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Jan 2026 11:39:52 +0200 you wrote:
> This reverts commit 926eae604403acfa27ba5b072af458e87e634a50, which
> never could have produced the intended effect:
> https://lore.kernel.org/netdev/AM0PR06MB10396BBF8B568D77556FC46F8F7DEA@AM0PR06MB10396.eurprd06.prod.outlook.com/
> 
> The reason why it is broken beyond repair in this form is that the
> mv88e6xxx driver outsources its "tx-p2p-microvolt" property to the OF
> node of an external Ethernet PHY. This:
> (a) does not work if there is no external PHY (chip-to-chip connection,
>     or SFP module)
> (b) pollutes the OF property namespace / bindings of said external PHY
>     ("tx-p2p-microvolt" could have meaning for the Ethernet PHY's SerDes
>     interface as well)
> 
> [...]

Here is the summary with links:
  - [net] Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable"
    https://git.kernel.org/netdev/net/c/7801edc9badd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



