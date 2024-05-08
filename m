Return-Path: <netdev+bounces-94479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1B8BF9A7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC691F23BA6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B887D096;
	Wed,  8 May 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHyybW0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E37C0B7;
	Wed,  8 May 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161232; cv=none; b=qJyy/+UYKcEdqGQz/wDZBgsWn1XL/uzEGsB1HWmsOSMm2jiUEmkeSQUOAlmgl2j2zr/VhcK06VRr/sYat1SCl5hIV/LyCa51MwXJup/s4X6fb9djMzTvmGCCZu+DJqWZVBlANQnjIcqRs604Ehm7aPnn9wPmJoEjCqa7SWvgUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161232; c=relaxed/simple;
	bh=oKJsKvym8vodu81AUhtMguwCfrKtZBaq8/lv95giHhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PMZyJtuA/ZmVYwLfWuaZACAmiy1pmcbtBQoyMzx9fzva/aZA4I/kXb2ir5xcUAdCI/XpHAMKrIUyjthryBCBe9vzYfTRN6p3EBfshhEyzGOn2tn4LZm5fHf7FdhqMSbh4GEZv0/PbMhHbn8VMRQcjFxz27+H0Nd31RbfiPQk/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHyybW0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D0DC4AF18;
	Wed,  8 May 2024 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161232;
	bh=oKJsKvym8vodu81AUhtMguwCfrKtZBaq8/lv95giHhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sHyybW0R9zju/NhJBVwPfqJVPx+MEi7gHica3KwagunhQfBMKKsIi3GIpcV6kZ2Dv
	 idFemVfjMyb6C61JCGUBCQGFzNSQ0oo6G1YHdteCRDMZKF4TPcL+GiYS+WDNDa+37C
	 qURQR7yrg7PAP4QDfgoUuCz42ERZTRVJXqvV4ToE1A8cKa4/ghJ0MATZ8esy1NDoN5
	 TRWB1C1Nsa5Rkub11pdGDc27u0vzYg4cg/IHg3mIkTfB7NufseOxwRMZXDAhGm4ewI
	 AGK/EtasiqqR0qwCq3xnP3ONQz/r4rBHXUpIR1FJNkOOaoN51ug4UM/E5xZDqFSHbs
	 uZmU6n0XNgFCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06DC6C32750;
	Wed,  8 May 2024 09:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/12] add DCB and DSCP support for KSZ switches 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516123201.8124.6701974455512349009.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 09:40:32 +0000
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
In-Reply-To: <20240503131351.1969097-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com, san@skov.dk

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  3 May 2024 15:13:39 +0200 you wrote:
> This patch series is aimed at improving support for DCB (Data Center
> Bridging) and DSCP (Differentiated Services Code Point) on KSZ switches.
> 
> The main goal is to introduce global DSCP and PCP (Priority Code Point)
> mapping support, addressing the limitation of KSZ switches not having
> per-port DSCP priority mapping. This involves extending the DSA
> framework with new callbacks for managing trust settings for global DSCP
> and PCP maps. Additionally, we introduce IEEE 802.1q helpers for default
> configurations, benefiting other drivers too.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/12] net: dsa: add support for DCB get/set apptrust configuration
    https://git.kernel.org/netdev/net-next/c/96c6f337951a
  - [net-next,v7,02/12] net: dsa: microchip: add IPV information support
    https://git.kernel.org/netdev/net-next/c/97278f8f109a
  - [net-next,v7,03/12] net: add IEEE 802.1q specific helpers
    https://git.kernel.org/netdev/net-next/c/768cf8413883
  - [net-next,v7,04/12] net: dsa: microchip: add multi queue support for KSZ88X3 variants
    https://git.kernel.org/netdev/net-next/c/328de4671dd6
  - [net-next,v7,05/12] net: dsa: microchip: add support for different DCB app configurations
    https://git.kernel.org/netdev/net-next/c/a16efc61d289
  - [net-next,v7,06/12] net: dsa: microchip: dcb: add special handling for KSZ88X3 family
    https://git.kernel.org/netdev/net-next/c/a1ea57710c9d
  - [net-next,v7,07/12] net: dsa: microchip: enable ETS support for KSZ989X variants
    https://git.kernel.org/netdev/net-next/c/c631250a24f5
  - [net-next,v7,08/12] net: dsa: microchip: init predictable IPV to queue mapping for all non KSZ8xxx variants
    https://git.kernel.org/netdev/net-next/c/3bcb8968654d
  - [net-next,v7,09/12] net: dsa: microchip: let DCB code do PCP and DSCP policy configuration
    https://git.kernel.org/netdev/net-next/c/ea1078d94ce0
  - [net-next,v7,10/12] net: dsa: add support switches global DSCP priority mapping
    https://git.kernel.org/netdev/net-next/c/5f5109af4753
  - [net-next,v7,11/12] net: dsa: microchip: add support DSCP priority mapping
    https://git.kernel.org/netdev/net-next/c/c2e722657f18
  - [net-next,v7,12/12] selftests: microchip: add test for QoS support on KSZ9477 switch family
    https://git.kernel.org/netdev/net-next/c/cbc7afffc5ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



