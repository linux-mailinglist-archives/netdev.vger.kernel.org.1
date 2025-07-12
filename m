Return-Path: <netdev+bounces-206308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E78B028C9
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 03:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13183A6434B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA01A42C4;
	Sat, 12 Jul 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6bviAK/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C881A255C
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752282003; cv=none; b=OfPR25K86Lx3LHw+Xd9vXvZ2qc/J3jg0omMmPhI+w4CbU+XvAU1xrLe4PghHoJFCOngC5EA1PDl7dYeB6PA5nyuvspKbCPZH0aKzlKY2ilICjeW9bX6k4b+skWPILatlRWCiwYS37FLDJQzuR2py8pJqW/V0gkjDq1l0dg7Wel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752282003; c=relaxed/simple;
	bh=6LdEOpzm7IVRajkkuKb0kY8axZudpEMSiah9ep/cbQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BvkLzvZXnxSMeOGiKhDJGwXeFsUAlFBLdIyDHnAq8DFef2PSStVU1QTZkUzd0kcEmnV1d+fV8dZHNxvUWkMFinKGbe/KHKSZErpshx9zgLmwGeRnKEJ+CMh64i8AcSj7FfGETdwQqHmziGogoGWbLN71TchE8Iz5MJNw5fY4H6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6bviAK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87212C4CEF8;
	Sat, 12 Jul 2025 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752282002;
	bh=6LdEOpzm7IVRajkkuKb0kY8axZudpEMSiah9ep/cbQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S6bviAK/Y/Sdw4DJ5Ne4xEaylLjySOttkJJXwYGLjVZXttmB+rbUVKAgSa+wWzm99
	 sl/Tw8dlAfEyV6kDKsrnG/AXWQi884iHvlpFK4TTG/Pfjfr/TAoYIP4XbOwdm4gQ3y
	 6wwTvL5JGPZIMKMvJ73NPTouvoBBskL+SIpQAXQU8pTvMGz3Hvr/QSkoQZ/M27tjNH
	 GJJEswRzeuusY1hnB3hq9cYaNa9ApCRR0RG+vUELcPmf30N8w4MUKuh5nk6JzdxUm8
	 ySzCTTx1QArEPmEsZAc1fAMdMPSBFT1mx7KmQ/3CdYWBtMQGUfvlyfxF7dbxhD4UOV
	 dywlgmhTiyaAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD5383B275;
	Sat, 12 Jul 2025 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228202400.2451869.2203148362118898235.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 01:00:24 +0000
References: <20250710164501.153872-2-sw@simonwunderlich.de>
In-Reply-To: <20250710164501.153872-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu, 10 Jul 2025 18:45:00 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.17.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/2b05db6b8a10
  - [net-next,2/2] batman-adv: store hard_iface as iflink private data
    https://git.kernel.org/netdev/net-next/c/7dc284702bcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



