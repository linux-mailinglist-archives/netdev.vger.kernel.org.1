Return-Path: <netdev+bounces-262069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPOGMk1komnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:43:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 251911C02ED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D85313CE1C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D128A2D97A6;
	Sat, 28 Feb 2026 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAAhR/xO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAEB2D8DB5;
	Sat, 28 Feb 2026 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250022; cv=none; b=MUdSMM/e7s/ck885L+knw4dOGlUfUQWsK3YTjtAWQt4qML5vng4F42AQn4v9w+QUSniRw53zmhphTAUTgEJCCGNDbhdHBN9X7dtuuxaz9D+W5G5SSAFhrT/f56nnjUzEf4GyhIgN0q9e0VcNST33S1IlYPXnhYa7IAyYIniV6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250022; c=relaxed/simple;
	bh=UlYjBzYPxnci5EeZU3a4pZls3HudJx28YTafHPBLmbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aP/OpuWGbkJQsqLeYdROe1e4q23pnelJnpn7Cgg5mykrJTo00yBXqYo4W1D77OtFx2WzQO+18v7Amai9NWkPwpWu8XqcW9hHW8xjywf41fRF2oOn1yXYBzvTV+UA4sfNSgox3nKauhsqMeKmyyd5FScW/5fF26qxOBUqS3Wr7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAAhR/xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511CBC19421;
	Sat, 28 Feb 2026 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250022;
	bh=UlYjBzYPxnci5EeZU3a4pZls3HudJx28YTafHPBLmbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rAAhR/xOBniRbii9EHvaqy8IUX4LMCwEuhFcw9yAKV1GEmyTJJJK5MA+Ro/0mP88w
	 Q8nP82vpS4Jo1d/gyaYZQh923setENrKTolyactsa9lnJ+flXMgD0V9JgsKCoyjBSv
	 sR41J+3Ka/zlGMFkNTPpGxNaYow05KT+Rs1FjRZy9+DqHjyfv5tFkNROMjM06FyVDK
	 sDRTrISHuyI09WneLrB3I1ka+lvUmbWoOIHfUD3QadV0vR0vAVqn2dVZZhZzBppiwi
	 S4NhOWreAy1PXqcIfIiNDDhmNuNdq1wPeWecDHo7Q9MRQpNyBfRSFqg37fkB5/R0Kd
	 lQxkTihVjHUwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E4E39EF96C;
	Sat, 28 Feb 2026 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: ethernet: litex: minor improvment
 for
 the codebase
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225002578.2855218.3920267376853849187.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:25 +0000
References: <20260227003351.752934-1-inochiama@gmail.com>
In-Reply-To: <20260227003351.752934-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kgugala@antmicro.com,
 mholenko@antmicro.com, gsomlo@gmail.com, joel@jms.id.au,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, looong.bin@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262069-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,antmicro.com,gmail.com,jms.id.au,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 251911C02ED
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 08:33:46 +0800 you wrote:
> Improve the litex code for using the device managed function to register
> netdev and replace all the "pdev->dev" with dev pointer instead.
> 
> Change from v2:
> - https://lore.kernel.org/netdev/20260119040446.741970-1-inochiama@gmail.com
> 1. Apply Andrew' tag
> 2. patch 2: wrap the line to match the characters limit
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: ethernet: litex: use devm_register_netdev() to register netdev
    (no matching commit)
  - [net-next,v3,2/2] net: ethernet: litex: use device pointer to simplify code.
    https://git.kernel.org/netdev/net-next/c/621e3634dfab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



