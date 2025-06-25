Return-Path: <netdev+bounces-201346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C1AE914A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6131A1C25EAD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614126E15F;
	Wed, 25 Jun 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu/nIZng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5F139E
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891824; cv=none; b=r6ujM/i9f9UyYjGtaSiUOpUOcJy0KJmVJkKmncpy1rqJs4jTfZXv6+SmYisUilYvYkSwDKV0Zg1vRohBXsXEsfEgeN6KnHTobURJsBoX4Hgeif+QB3Yk5LWM9Nl93zhwlmVK3izeIZw/lphbmpmQC/T46Da5iL1lGgHvkZjw7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891824; c=relaxed/simple;
	bh=v/Lxq3dNwRNiUGnMtwwCModCL2TxuOXgyoiGMR3WdS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A+yIVwTiVzti+0AJaSAyV7dQpcn2/GeKqn1MZEe9FhvnDw5YWtPvSbwnZjeffgcj+ynkViad/yafglcH6HDljqz7E2giZ7eqHkO6vuvFTnfMll0L5cbF8A1wYFfpIBbee/AxkkCesJgok+C5GN1jPSJkPFMLzqiSuvozTCNq4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu/nIZng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B816C4CEEA;
	Wed, 25 Jun 2025 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891823;
	bh=v/Lxq3dNwRNiUGnMtwwCModCL2TxuOXgyoiGMR3WdS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lu/nIZngrCzmqj4T0UwNx5Zm1uRLUKiY3Vsg+yMeSRZ+40lDwELCCTpoeqliJ8YEQ
	 MidL6PIpHi/QwRUPDQJyk5MR6T+QC5Ypp45DgaVFm/x6Gz9a84aomyqqPfY//OUQK8
	 t0u68qStAZVLv2noB5ZHOTT46mFry1oksjJEKClH32ncdKK5K/aPvOuwHyajJhYMlL
	 ZB4W5t+wtUz9P87aEk/umtFfrmH3R/bp0yz/15zk4YGPTU+2xjitm9rgA4oNPYo5vz
	 4M8HGbfKm8ygwDglJl6ljM121St+6T6EoawcSZFsnP0rUJWlkisLTfMzn4lcFlLSXR
	 qwaMF+KWiBXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C313A40FCB;
	Wed, 25 Jun 2025 22:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: ethtool: rss: add notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089184986.646343.9945502833939900799.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:49 +0000
References: <20250623231720.3124717-1-kuba@kernel.org>
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, maxime.chevallier@bootlin.com, sdf@fomichev.me,
 jdamato@fastly.com, ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 16:17:12 -0700 you wrote:
> Next step on the path to moving RSS config to Netlink. With the
> refactoring of the driver-facing API for ETHTOOL_GRXFH/ETHTOOL_SRXFH
> out of the way we can move on to more interesting work.
> 
> Add Netlink notifications for changes in RSS configuration.
> 
> As a reminder (part) of rss-get was introduced in previous releases
> when input-xfrm (symmetric hashing) was added. rss-set isn't
> implemented, yet, but we can implement rss-ntf and hook it into
> the changes done via the IOCTL path (same as other ethtool-nl
> notifications do).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] netlink: specs: add the multicast group name to spec
    https://git.kernel.org/netdev/net-next/c/826334359eac
  - [net-next,v2,2/8] net: ethtool: dynamically allocate full req size req
    https://git.kernel.org/netdev/net-next/c/ceca0769e87f
  - [net-next,v2,3/8] net: ethtool: call .parse_request for SET handlers
    https://git.kernel.org/netdev/net-next/c/963781bdfe20
  - [net-next,v2,4/8] net: ethtool: remove the data argument from ethtool_notify()
    https://git.kernel.org/netdev/net-next/c/f9dc3e52d821
  - [net-next,v2,5/8] net: ethtool: copy req_info from SET to NTF
    https://git.kernel.org/netdev/net-next/c/3073947de382
  - [net-next,v2,6/8] net: ethtool: rss: add notifications
    https://git.kernel.org/netdev/net-next/c/46837be5afc6
  - [net-next,v2,7/8] doc: ethtool: mark ETHTOOL_GRXFHINDIR as reimplemented
    https://git.kernel.org/netdev/net-next/c/47c3ed01af43
  - [net-next,v2,8/8] selftests: drv-net: test RSS Netlink notifications
    https://git.kernel.org/netdev/net-next/c/4d13c6c449af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



