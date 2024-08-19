Return-Path: <netdev+bounces-119523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED19560C2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822DB28162C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2117BCE;
	Mon, 19 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr2ooQ+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CD1C695
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029829; cv=none; b=YBPuxYmwOC2Pf5qmGdlEqVk/Pj1m3RVKhTMeid1cQX0IBIMR3hdOPhguol4YHcXCH6g/oTB1eMLTPtKr/rkD7pVXODblHIeaah0qvFUs0aKlLe3kjpAEWysA2D7LwExvs3REG2yZkGdqJIDWBIm+1MvYlHWNsD06FsfbQ57pAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029829; c=relaxed/simple;
	bh=yfO7i+OAClrskLBoLTSMcfCFDNo75qdAmvtiMGHJGJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s5cibuUJK+2DDSiLtPW9tQhcEPbmWcIo3PHEKoyb/inXevPcJD0EBn2g0qAkex0um9Q1lwXCkCPBELUip73fFykNX54yHcjtNDrfpgbf6PHw78VnhlihfasJw4hBVbKvzB7c7NRo7VQA1xmftH2jSKPbE0bjzsSXldxr4tha9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr2ooQ+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE52C4AF10;
	Mon, 19 Aug 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724029829;
	bh=yfO7i+OAClrskLBoLTSMcfCFDNo75qdAmvtiMGHJGJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lr2ooQ+k3uat5NZIpllGts6skxXfwJzhCkPND+zObZ3OzX68kLc+nQ9UAemySnAYD
	 d2maz/ggBpZaTau3dmpyUGVyS/m+A0j5JS22+LYrFjLLfGY++5jj0Ujj8txkGHXbep
	 NULjublK2Q77Ujf3OIHqMcrYUCLQOSA+GNsf4ZS06PMqAQMQjPD3Lc1h6DKss84Sj3
	 P3Oual6hmsC2+eDjT/fO9CFSAt8NPqEqDwJ6UbC1Nsal2vAgaWIMql2bQp0w1gx9ik
	 kgE1AkALo2JwtlQJTDTiZkIDRF7roOknnBpFC53NzAmSMRPC84GH67ShL/4YTLi+mL
	 XfNKRikHJEbsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01B3823358;
	Mon, 19 Aug 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: nexthop: Support 16-bit nexthop weights
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172402982851.99263.11924345945715099452.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 01:10:28 +0000
References: <b5686bb1c47ef3af1d65937cb8f5e378a3abf790.1723829806.git.petrm@nvidia.com>
In-Reply-To: <b5686bb1c47ef3af1d65937cb8f5e378a3abf790.1723829806.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 mlxsw@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 16 Aug 2024 19:38:12 +0200 you wrote:
> Two interlinked changes related to the nexthop group management have been
> recently merged in kernel commit e96f6fd30eec ("Merge branch
> 'net-nexthop-increase-weight-to-u16'").
> 
> - One of the reserved bytes in struct nexthop_grp was redefined to carry
>   high-order bits of the nexthop weight, thus allowing 16-bit nexthop
>   weights.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip: nexthop: Support 16-bit nexthop weights
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1fa8811c5048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



