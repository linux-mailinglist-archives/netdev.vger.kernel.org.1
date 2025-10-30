Return-Path: <netdev+bounces-234241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8869EC1E0E6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420F33B90D9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F22DE6EE;
	Thu, 30 Oct 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDRnJ2DZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657222DCF50
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789055; cv=none; b=QrPe/pNS6IO06ha3gE74L/rxyDL/oGdkpP9xKabAMuu3wJEnd+qDLvuJXQ+WTHE6dzVa1QMYt/YqTFb21HdokqRPUYxmgu78e9ZfjXDo3IIrJndmaEjfFXYqbRVCZDB8T6PwOLus01LjvR7ueoUtyGc83TK3sB6ZxTZGIYSmFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789055; c=relaxed/simple;
	bh=dqxNDF9N2H5l96NamkWD3idoyirzLa9FgWVQCgbNFIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mCmPQd69pVBWKRYX85nrLsa/ClYJWd2CgFqpXZSOnczqHTHbkWIyK95agdBiGjuPvamPUI6JWuwIM+p1txWvbdStHMYqKX4oNvDfSifVobvSpCRVDtBnruja5czWzXhQRmNrlwY3qv/juhAPh5GRY+bbHwLFEnwl/xlEVul9rZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDRnJ2DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CE4C4CEF7;
	Thu, 30 Oct 2025 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789055;
	bh=dqxNDF9N2H5l96NamkWD3idoyirzLa9FgWVQCgbNFIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fDRnJ2DZJpusC3FX0T6cpr+xOt+PRdZryIhO2eE83qaz4LsbwEfvG5m9Vu36QDxOq
	 F+95WLi0OL24Qj0fvaEBj3q736/wCl3dULPyVjnOu1DV/Xa4QmdGzFg9Dpf3kvs6Ch
	 6L27hBHL+LMuX2CuHr2JMFXmwwsiObZLXzmyjTJ8c7KRGlepTVFvJJJtUBEWPJQzF7
	 tPRw5gtFNRiO9d5sFshwHWK3/Uj2qfIksQj+wCtn2uW1E6icSdXM0pekBBToRVjhAH
	 uvxZQKTv0qTnI15uDBn13YPJqGxRp22PrGQtVAdKn9aNAkvvEv1xL3E8b1eNHivFZk
	 uMHF9Ip+LYp2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE13A55ED9;
	Thu, 30 Oct 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178903224.3280604.4697424263785943423.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:50:32 +0000
References: <20251027082232.232571-1-idosch@nvidia.com>
In-Reply-To: <20251027082232.232571-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 10:22:29 +0200 you wrote:
> tl;dr
> =====
> 
> This patchset extends certain ICMP error messages (e.g., "Time
> Exceeded") with incoming interface information in accordance with RFC
> 5837 [1]. This is required for more meaningful traceroute results in
> unnumbered networks. Like other ICMP settings, the feature is controlled
> via a per-{netns, address family} sysctl. The interface and the
> implementation are designed to support more ICMP extensions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] ipv4: icmp: Add RFC 5837 support
    https://git.kernel.org/netdev/net-next/c/f0e7036fc9cb
  - [net-next,v2,2/3] ipv6: icmp: Add RFC 5837 support
    https://git.kernel.org/netdev/net-next/c/d12d04d221f8
  - [net-next,v2,3/3] selftests: traceroute: Add ICMP extensions tests
    https://git.kernel.org/netdev/net-next/c/02da59575183

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



