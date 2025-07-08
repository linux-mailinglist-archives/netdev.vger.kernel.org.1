Return-Path: <netdev+bounces-204894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C77BAFC6BC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA378188DC93
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C71F2BE030;
	Tue,  8 Jul 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lozbyALr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44323BD09
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965788; cv=none; b=k4T1NPHahXOIDbY5bGnqFfCtmxBIv93SQaHC34HoN4KZzflz7vp/+CLGTrUJqi9LInzETiORjNckSZail4i7fxiQrJ8GlR6WwOmVt+OCnI+DwgBGbduogYLP+iwpszXuvSpYaKob+XMbR88Knb0DBXrlYimd6HL7BhMhHV1vIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965788; c=relaxed/simple;
	bh=CevJYaJxOACTk8IxAlfv8OCtMEynutmKsf/1WR77um0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GEdlLT3E1UdIzqetlDdwo8kIdDUp7EP7wYTTcx4FmnktEg9lG1X1pZuRywfpGqaDyfGT4fJ6s0SKYpBeUIXFGYwOtDzHS11l878MQuP/WIIaAsaNUeqkiY9hfxMgBVK/X5XQBslY0vLdMXHhboBMbCttBLy/8deo2seHCe0UZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lozbyALr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D22C4CEED;
	Tue,  8 Jul 2025 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751965788;
	bh=CevJYaJxOACTk8IxAlfv8OCtMEynutmKsf/1WR77um0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lozbyALryrnyMg42g+TBaFznC3SIysOl6TfmsoYCBfpQxk+DdtCCKGFz0eJ5fa2Bc
	 rWy7qD4Ba9QQo/nWKdjk7DMccxew0D0vStMpalm4Z8u/jYW4aMSFZAxKqkmoHxc3C6
	 uOeMtWfgHfaQ9zd0iEMzuWIDTgqY1MERpaE0TCmDVy93tG3f/Uib/saysOXXs6swh0
	 I+JU72pvBysrM+bovqhKpinhsLU8sAooTtUrdV/pXgEnkEa1AFEYMD4CRx/cNzutzK
	 Bqpe0Kiu5qq8maSxyprv96L83J8c05xNldq/YX3NUXDoH1tDZDfMLeCd9gXPiA8Hwj
	 tSuYerg0AY5aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA138111DD;
	Tue,  8 Jul 2025 09:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v8 0/3] add broadcast_neighbor for no-stacking
 networking
 arch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175196581126.3638001.8422687394372665698.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 09:10:11 +0000
References: <cover.1751031306.git.tonghao@bamaicloud.com>
In-Reply-To: <cover.1751031306.git.tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, andrew+netdev@lunn.ch, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, razor@blackwall.org,
 tuzengbing@didiglobal.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Jun 2025 21:49:27 +0800 you wrote:
> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> datacenter, the switch require arp/nd packets as session synchronization.
> More details please see patch.
> 
> v8 change log:
> - please see change log in every patch
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net: bonding: add broadcast_neighbor option for 802.3ad
    https://git.kernel.org/netdev/net-next/c/ce7a381697cb
  - [net-next,v8,2/3] net: bonding: add broadcast_neighbor netlink option
    https://git.kernel.org/netdev/net-next/c/3d98ee52659c
  - [net-next,v8,3/3] net: bonding: send peer notify when failure recovery
    https://git.kernel.org/netdev/net-next/c/2f9afffc399d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



