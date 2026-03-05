Return-Path: <netdev+bounces-264475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOKYKESpqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:03:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B03321514C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8A83175512
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DEC3CCA17;
	Thu,  5 Mar 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6BRKuA2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A637E2F8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726426; cv=none; b=p2xu2rmsmuhPvQBexc7IyUDEe9m5kLlDABhM3OzyvP2CsOlkjvYhlMqSNXzFFiXbBG5RFoTpQgRqHijnDEsEaSTBJYDvrEHlOY03o21Kyd6ez4B+seNkBgTteHgcWQj7I+P4WtoCU8pT7aL2SHOgzPK9kDkC15qKVGk85QdcE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726426; c=relaxed/simple;
	bh=0tCiatoDHzkdotVdCGQiIr82zUEnmV4LXAy6ujO2FXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHiLI+BdFP5CS0veQG+vzrSBlRgJas5p1Hs9rk45Tuy88cx7vC3+KEUgLMOPiSdhZMOr0pg+uq2r4VyoQE7NWo/o3xf1+ekHUY84Rrle7xwhBf+9D5rLIrwBgygDEWX7fpttoP4BYukR5vtPIrxm4KauVUmXac9vo2Q1p32ldho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6BRKuA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F7C116C6;
	Thu,  5 Mar 2026 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772726425;
	bh=0tCiatoDHzkdotVdCGQiIr82zUEnmV4LXAy6ujO2FXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B6BRKuA23fLlzBh17Jv3WzG5iqThy4icBGAydRxLFx6BdqeVuan6+dt6VJ6L4XNwE
	 hHLI2pAb7kzY1mQeG/KwFsQY5dNQjCdOqO6pPN/AbrgXcrz5iX0qRfFmrS2raxkLdO
	 g4AsZsux7AoM2vGqlluiN/bkdZ6AgpjqdQYQDf9yBc52xQm6aBRSLOFXbG/DYhJnS8
	 l98DhODE/hmr7j21/yMbdohuVHeE7lOUqnRrrOC0KHcPBniFFQ5wEeY0OQVhn+Iqbs
	 4JJjbkt9IF1uYm4E1cb9/I4wytwTobmIOjNmJXXg7NhHMTiJpPszgpr2Lr07G61NMS
	 8HJFufsu9FKgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D2E3808200;
	Thu,  5 Mar 2026 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] MAINTAINERS: annual cleanup of inactive
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272642553.3184289.15375943294118853129.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:00:25 +0000
References: <20260303215339.2333548-1-kuba@kernel.org>
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
X-Rspamd-Queue-Id: 1B03321514C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264475-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 13:53:00 -0800 you wrote:
> Annual cleanup of inactive maintainers under networking.
> The goal is to make sure MAINTAINERS reflect reality for
> code which is relatively actively changed (at least 70 commits
> in the last 2 years or at least 120 commits in the last 5 years).
> 
> Those who either:
>  - were the initial author / "upstreamer" of the driver; or
>  - authored at least 1/3rd of the exiting code base (per git blame); or
>  - authored at least 25% of commits before becoming inactive
> are moved to CREDITS.
> 
> [...]

Here is the summary with links:
  - [net,01/11] MAINTAINERS: remove Johan Hedberg from Bluetooth subsystem
    https://git.kernel.org/netdev/net/c/f9b5bf12eb65
  - [net,02/11] MAINTAINERS: remove Manish Chopra from QLogic QL4xxx (now orphan)
    https://git.kernel.org/netdev/net/c/80f8a19fe7cf
  - [net,03/11] MAINTAINERS: remove Jerin Jacob from Marvell OcteonTX2
    https://git.kernel.org/netdev/net/c/e07f796a86b2
  - [net,04/11] MAINTAINERS: remove Salil Mehta from HiSilicon network drivers
    (no matching commit)
  - [net,05/11] MAINTAINERS: remove Sean Wang from MediaTek Ethernet and switch
    https://git.kernel.org/netdev/net/c/77f72ef58fb8
  - [net,06/11] MAINTAINERS: remove DENG Qingfang from MediaTek switch
    https://git.kernel.org/netdev/net/c/593cdf14523b
  - [net,07/11] MAINTAINERS: replace Clark Wang with Frank Li for Freescale FEC
    https://git.kernel.org/netdev/net/c/34f49454b25c
  - [net,08/11] MAINTAINERS: remove Jonathan Lemon from OpenCompute PTP
    https://git.kernel.org/netdev/net/c/60da2d2752ac
  - [net,09/11] MAINTAINERS: replace Taras Chornyi with Elad Nachman for Marvell Prestera
    https://git.kernel.org/netdev/net/c/9ede3e910f08
  - [net,10/11] MAINTAINERS: remove Claudiu Manoil and Alexandre Belloni from Ocelot switch
    https://git.kernel.org/netdev/net/c/4d37e68c46d1
  - [net,11/11] MAINTAINERS: remove Thomas Falcon from IBM ibmvnic
    https://git.kernel.org/netdev/net/c/ed6579002548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



