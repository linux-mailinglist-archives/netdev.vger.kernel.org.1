Return-Path: <netdev+bounces-286055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJM4JvJ9/mnjrgAAu9opvQ
	(envelope-from <netdev+bounces-286055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 02:21:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B6B4FD010
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F0C530078AD
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E3175A68;
	Sat,  9 May 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQoUJpbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524C12CD8B
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286064; cv=none; b=SGT2Y1csoryVdfWZIhHgS6joku82Dp14XTuO856WdDAS3fQMbGXYMo9zQ53iTbiM7j6PArVB9Vmhbf1x4G0HTV2cCG2h+lePBM4jafk9EfN0iPXtB3tbnthJxae7fED6748oN7UIeDsW/iRGGaJ7xAMpC1o72mQioJx329XR3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286064; c=relaxed/simple;
	bh=wEWSKiLuHHs0S2cVsm9ifQjKGxZilqhSP1U+nuYLRFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s31S86w/f5OZaKVBq0TvBiM+Lh3e9RxC7EPqxcGZR//7WTEUBMmW34JlZj2nPfvhMJDoQUvZ69PzSfBKAR8ks9ozvM099mgI0fU9MuN8VhQQ3npymS19LwtWbyuAZcpp26S3HykBlP8fHcxuE2JS7uqrlKv1YVFeIWoY1/u+CX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQoUJpbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2BFC2BCB0;
	Sat,  9 May 2026 00:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778286063;
	bh=wEWSKiLuHHs0S2cVsm9ifQjKGxZilqhSP1U+nuYLRFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQoUJpbQ/aKPg7CAbgSWAuxDoxP9NckLTtoVabm/ot9FxGgzQFlixeUqXILIsmxQr
	 aLuUVNt3ar8Pq4IkU79Mc7vEO2oSXy/rIq+Pa+ZmoSRLwPC8Cv6dEtWZnJ3qeZ+GN/
	 2xKPAl3/6FTOSdTFMcZff93MesJBdA4leKb+w1iUrhhbLP5LpHjEyGAj4KqT+K6Ku1
	 XYlVMMm0CQHXRE+rAIaxMxjkHMwJ/+qifkn360Q3En076yXlW2f24er0NlbaiXcTji
	 pu8X05A7rEX1QRStmbPTfu6LSE7LTHXcoEq/icgG3uv9kuMmw0ms3+m8hFHBLkGaSE
	 41KmZlh6sr4Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4638119E3;
	Sat,  9 May 2026 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net: Fix protodown with macvlan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828601205.907663.7064779384620053797.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 00:20:12 +0000
References: <20260507105906.891817-1-idosch@nvidia.com>
In-Reply-To: <20260507105906.891817-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, petrm@nvidia.com
X-Rspamd-Queue-Id: 38B6B4FD010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-286055-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 13:59:02 +0300 you wrote:
> When protodown is enabled on a macvlan, two bugs cause the macvlan to
> incorrectly gain carrier:
> 
> 1. Toggling the lower device's carrier while protodown is enabled on the
> macvlan causes the macvlan to gain carrier, effectively bypassing the
> protodown mechanism.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: Set dev->proto_down before changing carrier state
    https://git.kernel.org/netdev/net-next/c/04bb6595b55a
  - [net-next,v3,2/4] net: Do not turn on carrier when protodown is on
    https://git.kernel.org/netdev/net-next/c/99f8efac7f99
  - [net-next,v3,3/4] net: Do not unconditionally turn on carrier when turning off protodown
    https://git.kernel.org/netdev/net-next/c/9a9c0f5c6823
  - [net-next,v3,4/4] selftests: net: Add protodown tests
    https://git.kernel.org/netdev/net-next/c/c0375944d997

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



