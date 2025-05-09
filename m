Return-Path: <netdev+bounces-189413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64535AB2060
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0064A7BD9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580326868A;
	Fri,  9 May 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWxCxTFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5A267F76;
	Fri,  9 May 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834610; cv=none; b=AuLTMAT88r1MWHQNhKAVMIYPD0ajGHO5lfLr1l1r/qnf0VwcVFHAZt3mjbPYAmq7plGeppvig7JHHxOSWQNe9DoaidQ2h62ae/leDYwkpuk5MSFixEPlLRsATGUSxEIoUV+Z8St4SVL3ZP8E+n3lqSGzY8jgExy5oQdGtSQq17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834610; c=relaxed/simple;
	bh=sg2VawoN7troOvWhpN7BV3yjhjpbGZkgSY0uF9uTijA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DLdCyrDFNzJv1R2yQrQ+zEis80GfojI07o2YNEZ1ciEtliYRauGRgVMb1Buz690yDnXiYMMUWgkK8QxojO8Igcw8FVq5UmjWjih2m99u56SYfAod+14Zq4820gbee2vgOmOb3y5z4+MOGhGqxxzi1RmR60YwuYoay5qBdaQKCDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWxCxTFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D989C4CEEF;
	Fri,  9 May 2025 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834610;
	bh=sg2VawoN7troOvWhpN7BV3yjhjpbGZkgSY0uF9uTijA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TWxCxTFRSjR/yFbPbV8CAZ1P8oYfp6aHdNeAolVQMRG+tGjLHlSFL0c8yhtBzvM/5
	 7j65Rx7ExmNhy+Q90IkvybGhWI8gfJApgvV7PcDu1PqULFvY1xhGHjXt4OUXf1Wnsy
	 8j3NRpwYHrhB6VFt5IG4b0ARiLwS//rEi7C9xYrdkf3S7uf8VQ/WB+kRzcQP55/KGp
	 E1W9ap1fef6+2Bf0BdRu42g90pcr+WW5gvuIttMoFVs+ajkaXd22xEKTVhHxRKO1+6
	 03kNCBJX3/Zq20B4bCXeBFYnbUQTrd2dx5wK6sENVsGgKQDDgsTPDCxk22YVZvv5EV
	 jBDi5NrIp9B6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABA4381091A;
	Fri,  9 May 2025 23:50:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464849.3845363.11079163709570196404.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:48 +0000
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508095236.887789-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, kurt@linutronix.de,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, horms@kernel.org,
 richardcochran@gmail.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 12:52:36 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert DSA to the new API, so that the ndo_eth_ioctl() path can
> be removed completely.
> 
> Move the ds->ops->port_hwtstamp_get() and ds->ops->port_hwtstamp_set()
> calls from dsa_user_ioctl() to dsa_user_hwtstamp_get() and
> dsa_user_hwtstamp_set().
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/6c14058edfd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



