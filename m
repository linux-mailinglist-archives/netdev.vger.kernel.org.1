Return-Path: <netdev+bounces-242142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0AC8CBC1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 945AA4E490D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512A2C08C0;
	Thu, 27 Nov 2025 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiGtLaPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208202C0F95
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213431; cv=none; b=SQfiiSX2sFJu5BQ2bjtX4U10+AhxqqnDm9xH/SfH9z17NNofDSCeLRk7czi+Z+sJpFkz60qjNYsHrwB3j5DlM5D1Zoh6E/F4su6caqbSzZHJTCmk6TWtlZnbTKuDhrtTZ39bBk8XMhnuDNqwB+maqV7W/hcX9PwzhnUj+TrIC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213431; c=relaxed/simple;
	bh=5Oc/z34npDuN7Zgxp8nuH8YMiAsKcDfnWOAMzEdfjqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRpFa/LsIHSAey1kuXJMMwWw2xinYKAL42fKyPXTybiYSTqhGruoX7HA4ahFoayFnY71OkY5NmjFcBaHkY7cSjAJqSpavsBGU/QFGaipziECK1X1VeiFnFP9vPf5ouP0Ny0mJuPQ0CWo+TysXI4+guH5hfAm8KfoYQffJ7JJOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiGtLaPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E629C4CEF7;
	Thu, 27 Nov 2025 03:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213428;
	bh=5Oc/z34npDuN7Zgxp8nuH8YMiAsKcDfnWOAMzEdfjqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aiGtLaPX5BlwabgEiN05cAyhrJO8TQ+FzS/Yju2FcD7/BgAMeSXvrfwYmo6ouyTyS
	 JQF9Bkoyo+xMZLNEjBGVNkWkGPqjD5ChfeZnzc5jQOm+FKkbqBsuspR7vLsdrI6sVt
	 Sn6wtjTtxhGRQKjMrfLeJCehPpmVP1sNu8Fqtuqj5pocgtbuT5cqlpchX48dg5VUtM
	 S1mBiz08GM4hiALE8IONMkYTjOaEmi3UyMNZ+Xj9tdUKUXFAwYRx7fdRrQ4ONaxLZx
	 fwfBQgtQNe0oTQ7ugW/XT7T5H/QjdisjzxCaNbwODC3Zhy7cwHV3X3ESzy60eJdet2
	 5Bek/h3G7BuxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDE380CEF8;
	Thu, 27 Nov 2025 03:16:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: sja1105: fix SGMII linking at 10M or 100M
 but
 not passing traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421339024.1916399.12094902200397775698.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:30 +0000
References: <20251122111324.136761-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251122111324.136761-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:13:24 +0200 you wrote:
> When using the SGMII PCS as a fixed-link chip-to-chip connection, it is
> easy to miss the fact that traffic passes only at 1G, since that's what
> any normal such connection would use.
> 
> When using the SGMII PCS connected towards an on-board PHY or an SFP
> module, it is immediately noticeable that when the link resolves to a
> speed other than 1G, traffic from the MAC fails to pass: TX counters
> increase, but nothing gets decoded by the other end, and no local RX
> counters increase either.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic
    https://git.kernel.org/netdev/net/c/da62abaaa268

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



