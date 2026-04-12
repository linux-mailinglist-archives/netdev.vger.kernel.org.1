Return-Path: <netdev+bounces-277859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJjrEyne22lMHgkAu9opvQ
	(envelope-from <netdev+bounces-277859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:02:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3B3E5509
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F35E3032992
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF136402E;
	Sun, 12 Apr 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONKT06Iw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC168364021
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016855; cv=none; b=MzBCw09qigN3asWW6r9R309Yo1G8qSOrf+pZ3FOwRJMoKTNMgb77yBfHUHIJcQPxPZylW2bjXmLY2dDKV3WPTYRbB3ALW5JKxzEekCzvPjNml/OfGhkzcIW02KBlz9Fy0R62EOpTTKegiOfduyign2bKnIWeyh8kCT03IQrLrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016855; c=relaxed/simple;
	bh=7rc7gLnz0dIQehWlqRex5/a196pfojFZwxX2PuUD+XU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z6RH7I5DLWrSFjeTgNacRMJrQavyXdo5rEMDCkjBcSFd/I3oNVJKljzVwLX1T33zp7WYMqkIJ0WrIbUS8tNhH4BAd3dg6sL1O8eoxuAY3KJ80bq8Sib2obp6Jnw937nFoMPLQxEYv8z/62/Uu52DWTdZqF2DV04baaAxJiDpsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONKT06Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A358C19425;
	Sun, 12 Apr 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016855;
	bh=7rc7gLnz0dIQehWlqRex5/a196pfojFZwxX2PuUD+XU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONKT06IwwyOH/rzGv5Lht36JvDqBGAVRUnK8rV4nOAAoIYZrMcwFLifYflNAsSmH1
	 1R/rundxaOOpTLWAFEf7+f0MKcQpD1koRc6UMNhm8NhBbW/DmepFi6i67c4Mc3UBoi
	 JbIJbzXJuJCorrrayjhjANZ+OR1UxXGqv5+mn9GfFLjwOO0v03TKL4VyfIxDtYQak2
	 jz0RDwcI3y93/TylTa6kikrN4oMb5uw1FAiY1G84UvhiEOQbK36YQ8oy9G0Ukbjrx1
	 B1CDUAYeoiOg146lCbBZnyME2PUDNv4rCH4m2gZrajwgLc1Jd+vfLEAL7hCldOQGfl
	 ouVj88TOlsqow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCA83809A8C;
	Sun, 12 Apr 2026 18:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netfilter: nft_tproxy.sh: adjust to socat
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682804.3359939.2071315981255786862.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:28 +0000
References: <20260409224506.27072-1-fw@strlen.de>
In-Reply-To: <20260409224506.27072-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, kuba@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277859-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B2B3B3E5509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 00:45:02 +0200 you wrote:
> Like e65d8b6f3092 ("selftests: drv-net: adjust to socat changes") we
> need to add shut-none for this test too.
> 
> The extra 0-packet can trigger a second (unexpected) reply from the server.
> 
> Fixes: 7e37e0eacd22 ("selftests: netfilter: nft_tproxy.sh: add tcp tests")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260408152432.24b8ad0d@kernel.org/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> [...]

Here is the summary with links:
  - [net] selftests: netfilter: nft_tproxy.sh: adjust to socat changes
    https://git.kernel.org/netdev/net-next/c/61119542663c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



