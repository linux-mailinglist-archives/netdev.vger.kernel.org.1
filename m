Return-Path: <netdev+bounces-276805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOejJ9wU12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C023C5C1F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D146306D1E2
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6F372663;
	Thu,  9 Apr 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH8RsK7I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53836BCF2
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703090; cv=none; b=UJe7Swcgi3NGjVb56xIySX5kFjBoK4ENogTW5A2E3vnDMfg7Quccwz5j9GFK6/oT2Oqw3O11kb6oiH+S2IGL277G3xehWNv0jZYRMMqB0lFquSzXtStuzP0Qi1/cUDMoLgg11vSpku1VUPP9spmud2LvtvDjRfCbuKf2w29kWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703090; c=relaxed/simple;
	bh=y5Q5moamRiyiYRoRPAdbCmCVlF7hPs54Xk9n4YzC4BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pb/apMx7g0ouhCpDD8yqbf0qSyqQdpIrsfNIAUdwp0HIJwvmxInsySUefZ6QqP2rityaC9hs9ccrHYVNgDvt0EuH7QJ/SWM6dVqLoTauze9wpJUPFRr0psz9r4564GrT8FWMzvcZkTBVplQPMRD4hbmMRPZXhFx2q/Wfffh2gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH8RsK7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1767BC19421;
	Thu,  9 Apr 2026 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703090;
	bh=y5Q5moamRiyiYRoRPAdbCmCVlF7hPs54Xk9n4YzC4BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UH8RsK7I62d+RJ9Tt7qMpzsWl2u0IapJn2jQL+0MVv+sA/aEx31ovaCeK6XqkAvh1
	 7OvFJF1k5Ozs3/0s0P2dOMBG3pV6FEIR2K3G4j5eu6D00KFOug8nXmUt+pJiNrqgLM
	 tGKeKVrF6C10AcTHrZBPQhiIwYdM6vhHbnq/Q2wMLUg2mW3XjCLWJIP+fUTerQ7Lo6
	 NzU7D+ubIiwYV/DFmmFiiltyaKvvMXBqEvp0TByG6af6nQceX6xUOEYTODS8v3D4rV
	 6i1NpKX9Sao9QNKTEIXXpIWForPWD/k4npPdU29Ez/n+ArY27d3EZmgY/Xn0p3hV3A
	 dAsxUD1OCUwOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE4B3930793;
	Thu,  9 Apr 2026 02:51:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] dsa_loop and platform_data cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570306603.968772.4113618329264344199.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:51:06 +0000
References: <20260406212158.721806-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260406212158.721806-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-276805-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54C023C5C1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 00:21:54 +0300 you wrote:
> While working to add some new features to dsa_loop, I gathered a number
> of cleanup patches. They mostly remove some data structures that became
> unused after the multi-switch platforms were migrated to the modern DT
> bindings.
> 
> Vladimir Oltean (4):
>   net: dsa: remove struct platform_data
>   net: dsa: clean up struct dsa_chip_data
>   net: dsa: remove unused platform_data definitions
>   net: dsa: eliminate <linux/dsa/loop.h>
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: dsa: remove struct platform_data
    https://git.kernel.org/netdev/net-next/c/b773b9935239
  - [net-next,2/4] net: dsa: clean up struct dsa_chip_data
    https://git.kernel.org/netdev/net-next/c/dc915f375e54
  - [net-next,3/4] net: dsa: remove unused platform_data definitions
    https://git.kernel.org/netdev/net-next/c/c3b09190e658
  - [net-next,4/4] net: dsa: eliminate <linux/dsa/loop.h>
    https://git.kernel.org/netdev/net-next/c/da9008674d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



