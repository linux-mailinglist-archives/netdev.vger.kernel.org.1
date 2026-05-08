Return-Path: <netdev+bounces-285989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEdjLYJd/mkWpgAAu9opvQ
	(envelope-from <netdev+bounces-285989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 168654FC212
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41E7303131F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98933D6D2;
	Fri,  8 May 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJyeQKC/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109933AD85;
	Fri,  8 May 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277669; cv=none; b=b8ZFV2D1fkLRCEwTveJ2C2V14aawjTLq/ROoXlhtN8gABmZj1+Y0ZXk0q1nnAtPjdBcawst3fEqeogtemIQ6Fq+siv5gAwHf+KTeyA7qzn1jWkuFb0KRSomBXNswCZgEL/C55mWcvXV1tI5bGGcgAUevr0Yc2Dhd22dLp/ECqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277669; c=relaxed/simple;
	bh=iI7xYwy4wDDiP0k528lC9LIsusk5KOZ946D4cKkhQWE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fj7NHkQ6gjWpDnFejqFhYYETaFRQtHTXtIZ0dSvHET1YntRjYTdfybxmPuRgMWG86xcV7HODPXOY1NWNxdtL8+qBQAS5SxJNtt26YCAbtahiMiIgAegh7TJRemy9apKF95+qz4ScUfosE3dc7ZlVfpYeJExsOxu7yjPW8ocjVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJyeQKC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910EAC2BCB4;
	Fri,  8 May 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277668;
	bh=iI7xYwy4wDDiP0k528lC9LIsusk5KOZ946D4cKkhQWE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJyeQKC/G9lpm0G8W/f0fEOiSwTjFxi9FGyvvNn2VxEY/W5TQr3J3xMT4qZC8rcap
	 SZio3XJZSRThyBrVfHQzFtdwcerKlArfweGEC/aTvyvlRuikVErOC5hfz1lBYeJCaJ
	 DgYcc1R3G0ddl3dOVHU6YXrLdo+skeSewfxD6OhMzw2jc7nTIxgCVT7a/FA5AzHM+L
	 TT1wPpulfCPmUJprF9+6t8Pb/exgxINuC2mAj0rPjzgrfazkGbHVjLiowi5R1R0eWL
	 CAojyjGvaGmRevUyInOMq5ZhnmANx3VelhRrblWNHtmAq3KI4noPTdm9U6CHyEjyi6
	 Plt9JGEinm46w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA138119CC;
	Fri,  8 May 2026 22:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:00:17 +0000
References: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 168654FC212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285989-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 11:23:17 +0100 (BST) you wrote:
> It appears there's a need for a maintainer for the 3Com EtherLink III
> family of Ethernet network adapters.  There is documentation available
> and the driver is very mature so the task ought to be of little hassle,
> so I think I should be able to squeeze in any issues to be addressed.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add self for the 3c509 network driver
    https://git.kernel.org/netdev/net/c/e539acf9f9c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



