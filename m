Return-Path: <netdev+bounces-189410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A522AB205C
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405394A7AAA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E52676CD;
	Fri,  9 May 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXrMuhqR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA02673B0;
	Fri,  9 May 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834606; cv=none; b=Ta70h0EsU9qzYFa2OuYPffmxAmIzQNtEnTK0nG2RzcJPoRi076cHjdviWskBEaX55PjagHcNwJUiyfibu/e7IXrJ0FBKOZ6ufCXYXHEjXbyMYRHzy89KBg2JeJZY3wWjYQp7LZuSnmav0un0pzsVxLdNpkCjVVqgNIPC67JZKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834606; c=relaxed/simple;
	bh=u0k3VT0yVEFIQIxgeob4qULh2R/SyWb70GlNJh0Tv/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwIFypG4wWDisMB83Jav14jei4hzh8L7VzyOOlF7xxduImtftPGq6L6eJbXAcaL7aKKVSCcZnnTD8OLB9ZCtsp1IlOYvqlHRMRLsdb75Fjejvdud/1Juen15+3ReSYFe5tQinu4XUj548kvE7L+TvStB/cGw/Q6B29GKqldeF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXrMuhqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B21DC4CEE4;
	Fri,  9 May 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834606;
	bh=u0k3VT0yVEFIQIxgeob4qULh2R/SyWb70GlNJh0Tv/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KXrMuhqR1qrf1gMSocBDGS0bOdjdUxI9UijNInPUxrcVKgcmB7m2wNJ4ybTbOzsCl
	 E6DV1t4ze0gfGHT9gjLea2IBvsy5AtzKP9yFOXupeftoVYfow5mzBjz4AcUdtPZ4PP
	 5HKs77o6BiZwn7DjU83s2EpuA6kAdu80IGvgMsCI8pvJ280RYhBxR+tZF8nCLa0wLd
	 zQtXpg1124v/2ol7I4vGNgAwQvLAXQ4/92cvKpYaeG4T+G/fjo1RsmvWLnyfcdd5t8
	 06TZ/kOy8FhDZRPrXBIevRCxIGg65x2paA2oL8o/0qDsdjbWzsBO0Xoux3bdeKn1jl
	 239QEIUDLEAYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADAE1381091A;
	Fri,  9 May 2025 23:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dpaa2-eth: convert to ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464424.3845363.14669308209444032064.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:44 +0000
References: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, ioana.ciornei@nxp.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 16:41:01 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the DPAA2 Ethernet driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> This driver only responds to SIOCSHWTSTAMP (not SIOCGHWTSTAMP) so
> convert just that.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dpaa2-eth: convert to ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/b6e79c5da8c2
  - [net-next,2/2] net: dpaa2-eth: add ndo_hwtstamp_get() implementation
    https://git.kernel.org/netdev/net-next/c/d27c6e8975c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



