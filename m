Return-Path: <netdev+bounces-159611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EBEA15FF2
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C1F18862E1
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C97179BC;
	Sun, 19 Jan 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm1mK/XM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1215E90
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252608; cv=none; b=GldL7Pe45FmPZwJwfamSILEUnZNx0oEtnPjaBfKlzoo2r7W2UEkbpLA+lYeu76B8R3LGkRu4N6uNpA09U/RXPfRHdw0ceuiE5eUtUx5EJIDn0a47bTtgyvmMz2fSlmD7fFXCFdLlSz5q4cIyVzxpqTZH70wHHYYbVFlDMQ/L3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252608; c=relaxed/simple;
	bh=6sm0M78ese8lxeNTgxiyh3oVucEfww6ppQI9MaBhTrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PuLBN1uNJHgdg+uC80s+64/vhz4CTZe7zOl47WAPETtUWxxuCa5V/AYL/Ro8qBT6JPRQmTvKpVAqJPWWhTKhtm8BinNTJ/hOxJKTf3AnhWqsh9bXZnIHimEoBeovBLxyN80iJ56m4mTN8+Lx7eyWrJ4eZRg3vJYz7ZyS28NN7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm1mK/XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A31C4CED1;
	Sun, 19 Jan 2025 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252607;
	bh=6sm0M78ese8lxeNTgxiyh3oVucEfww6ppQI9MaBhTrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hm1mK/XMoP4Eimcsnceuf4TiJC6DBarElQU4Z0JuWud5ZNhoO7gDJ1NIrt9x/ydKl
	 ifSPobXHKv2lCxpcpYWk22D90YkPlaFVJBjXU2G8GJjihbClVY7gU949S5J1E0Wz6o
	 6OoTFsD/Kdhe+cQauRBS+XnhNZHKUSKrUjfpd7xm4POZYg1ETTrJ9jlnS4pRVaVGQ0
	 cSzGFRTWoTZ2FDlnWdHe+auxwdQTSUQwi/RTNwXvidRT7pgfCGlQ8Lzxjt+61/TAMI
	 gWINKgRVuZFlp942TaliI1BllaLrhYmOy3E5XFKYPWznTq5frJwcXoMZxLA8NxsMtz
	 Bv9XrKdTejpgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFE380AA62;
	Sun, 19 Jan 2025 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/10] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725263101.2537111.8912233175272298509.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:10:31 +0000
References: <20250117123910.219278-2-sw@simonwunderlich.de>
In-Reply-To: <20250117123910.219278-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 17 Jan 2025 13:39:01 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.14.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [01/10] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/77a214317a6a
  - [02/10] batman-adv: Reorder includes for distributed-arp-table.c
    https://git.kernel.org/netdev/net-next/c/a7d5100ed009
  - [03/10] batman-adv: Remove atomic usage for tt.local_changes
    https://git.kernel.org/netdev/net-next/c/8587e0e3f562
  - [04/10] batman-adv: Don't keep redundant TT change events
    https://git.kernel.org/netdev/net-next/c/fca81aa3e653
  - [05/10] batman-adv: Map VID 0 to untagged TT VLAN
    https://git.kernel.org/netdev/net-next/c/bf2a5a622a50
  - [06/10] MAINTAINERS: update email address of Marek Linder
    https://git.kernel.org/netdev/net-next/c/7bce3f75189c
  - [07/10] mailmap: add entries for Simon Wunderlich
    https://git.kernel.org/netdev/net-next/c/1f5f7ff46435
  - [08/10] mailmap: add entries for Sven Eckelmann
    https://git.kernel.org/netdev/net-next/c/285c72be9440
  - [09/10] MAINTAINERS: mailmap: add entries for Antonio Quartulli
    https://git.kernel.org/netdev/net-next/c/425970f94b3c
  - [10/10] batman-adv: netlink: reduce duplicate code by returning interfaces
    https://git.kernel.org/netdev/net-next/c/6ecc4fd6c2f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



