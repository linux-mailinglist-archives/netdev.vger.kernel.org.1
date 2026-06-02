Return-Path: <netdev+bounces-293954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAmbMYs7HmpriAkAu9opvQ
	(envelope-from <netdev+bounces-293954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9E62717A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93AAD3041B87
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C43349B15;
	Tue,  2 Jun 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5+Re0xg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AB34A3BF
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366213; cv=none; b=lxABDpyPUEvH69W/IMxHEcMbJorIZXMuJHEzTh/pDjy09nk2gFoDPLIPrQFLIwtgYx97rjIniwZcP6dnYgLG54EOHqX+LMMm+FwlC8w/3OgyrQY0RbvzbJp+Y9brWa8xp93vc8vtGSsrBLcgu7EAIbKttj41pY9iTd2Y7BXWy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366213; c=relaxed/simple;
	bh=ObqSEH8lw7wMuJuF8r8WcZkNBaOhhZQRGB9li3MGsPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L25KgD9hCUFwilbEhK97CT9wS7/67RdVGm4capWokVI5RBtXApPMuIqRMT2zGuYYfGUzrq6aw4/DJPbEOF3jfUJOntSPiA/XSBbe2ukxYpg6BEJK16bAHsFFuT9GaLmEMitr5Kt0PXDpadqpQEbFSpRxqI3uGqXFR3eSCPPXFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5+Re0xg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A161F00893;
	Tue,  2 Jun 2026 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366212;
	bh=ffXvVesnE1zNU/Ae4r+Yl9CGNCryk9M03316Oa1BAZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y5+Re0xgchLqfdZxV2dCoVec6hHa3/JCZOVx6znaX+R0sgjEflEzMPBm30RhpfBF/
	 SEutSdlgjJUSYGFnt3oA8bi6/bhtIbQgQ08gwLh0vRCLQ9+JWCXZDAL+zwWDGzCi/8
	 rCn1G2BRJ/obAQG7dQwelY36U8ByX13eTh9GHhu+GZ6tppwDL6qhOgr8k+u2Ny6Jwc
	 h1ZbqCqubAv1fU7d0X29FB9Naswkua9sTHFimzOazCweOlvHwVcSOHw8BGfS8Ynfea
	 zr4Yz1ggkHaGYfP0onCcU/2uYurqn9ujx9aa37vBj+fzhuyw4PFjg8vfPofVYjH4xI
	 8Lk2WBH+AFabA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0A38119F9;
	Tue,  2 Jun 2026 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: mdio: realtek-rtl9300: SoC
 independent
 command runner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036621438.206391.9411510358918445434.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:10:14 +0000
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-293954-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 40F9E62717A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 18:34:45 +0200 you wrote:
> The Realtek Otto switch platform consist of four different series
> 
> - RTL838x aka maple   : 28 port 1G Switches
> - RTL839x aka cypress : 52 port 1G Switches
> - RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
> - RTL931x aka mango   : 56 port 1G/2.5G/10G Switches
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: mdio: realtek-rtl9300: provide generic command runner
    https://git.kernel.org/netdev/net-next/c/9ccb438210c4
  - [net-next,v2,2/4] net: mdio: realtek-rtl9300: use command runner for write_c22()
    https://git.kernel.org/netdev/net-next/c/9cd59932f2d2
  - [net-next,v2,3/4] net: mdio: realtek-rtl9300: use command runner for read_c45()
    https://git.kernel.org/netdev/net-next/c/fcce51bfd4ed
  - [net-next,v2,4/4] net: mdio: realtek-rtl9300: use command runner for read_c22()
    https://git.kernel.org/netdev/net-next/c/2e3c28c715e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



