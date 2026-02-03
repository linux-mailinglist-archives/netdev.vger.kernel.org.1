Return-Path: <netdev+bounces-256091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ1pB2JbgWlnFwMAu9opvQ
	(envelope-from <netdev+bounces-256091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA5D3B42
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D25302C36A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A029ACDB;
	Tue,  3 Feb 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/cW8Cd9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD5DF59;
	Tue,  3 Feb 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085214; cv=none; b=cAlpGWzsqB3TBhztc2dfQeZzwZqVku3wjBMOMoJ0mMrEKZPDKSA0tlzHm/TVslVFDsKsZaE80CvMvw0q5MkgkIW9PCOw2woPZmSkvR4UCKn00IQxQuoRvfV/spjkp9k1gHvuE97gSM0NECd1fLQvTLqnmUp48t5XIfvdpQ9m474=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085214; c=relaxed/simple;
	bh=dyLD5CTe0D0uWf3n3Bqu7uYGDnqb5256m3nU0+c4CEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3EKdrzm3MkNQsg5m9mBVx8ySavTWgGrJrBzqQI/Cua2VrXnS8JFzV08r/1vaqEjwKYCal9myrpMysstz3y6sdqgtFbotT9v0gcE2vpJPGJn4zh9iAvPrWJDXuI6vld8UampxMsrV4joEprY5vPwHwHCLX/tRK2Qc7R8Lx/+fmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/cW8Cd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D655BC116C6;
	Tue,  3 Feb 2026 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085213;
	bh=dyLD5CTe0D0uWf3n3Bqu7uYGDnqb5256m3nU0+c4CEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p/cW8Cd9YezGfO9k+MnVX+VCyHYpRZzRGFL+DUtR+MpZaFqC+qvdzcE2oBnV3u5BI
	 PVPGpAclYv3+Zva71kFQ2SSurqTSpPGuKG+Jum2+JPWnSf39818XbVwnwtewK8UFqu
	 y7KU2BQ+lIMJ8qUV+oLfEkCCag+xoFqpCegjxqIBLtHOao/BN7uEeQ8fA8XXBJMyNY
	 wnKf8faUPna7qUFG0Vi5knzqDQOGK5uSgKu1ApJa2XjfkmJq9L8tgZLfNbgtnkLfXY
	 k0SrLrQnmMDZDLq4poxMHPHpnnU50Kp6zyP57Iglsg6q6NpDmZUQ5qm1fiIEFW3XTK
	 Vg+8RJ8cY2e4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE03E3808200;
	Tue,  3 Feb 2026 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] ENETC v4 hardware integration fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008521062.1279978.3424361690437875214.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:20:10 +0000
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
In-Reply-To: <20260130141035.272471-1-claudiu.manoil@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 Frank.Li@nxp.com, kuba@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 imx@lists.linux.dev, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256091-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CBA5D3B42
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 16:10:31 +0200 you wrote:
> ENETC v4 targeted fixes addressing SoC level integration issues
> regarding AXI settings and register access width.
> 
> Claudiu Manoil (4):
>   net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
>   net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
>   net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
>   net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: enetc: Remove SI/BDR cacheability AXI settings for ENETC v4
    https://git.kernel.org/netdev/net/c/a69c17230cab
  - [net,2/4] net: enetc: Remove CBDR cacheability AXI settings for ENETC v4
    https://git.kernel.org/netdev/net/c/9ae13b2e64fc
  - [net,3/4] net: enetc: Convert 16-bit register writes to 32-bit for ENETC v4
    https://git.kernel.org/netdev/net/c/21d0fc95b592
  - [net,4/4] net: enetc: Convert 16-bit register reads to 32-bit for ENETC v4
    https://git.kernel.org/netdev/net/c/c28d765ec5da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



