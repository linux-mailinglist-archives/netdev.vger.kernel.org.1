Return-Path: <netdev+bounces-265870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCqyFkWJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:00:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FACA244891
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AB583015ED4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D7346AF0;
	Tue, 10 Mar 2026 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arel5jJt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ADF2E2286;
	Tue, 10 Mar 2026 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111616; cv=none; b=Z79ARAZFQChmgp7IEeh8q+tdfhT6Z92xxppYOXV3+n5I9CJJrJt8ghqLgB6c2MMWdQ+0ew8NF0Y7IV/qkcAqh08qyvfXpe0UCasXMr6qxN13/HXxDJd4JxMltcSXCaixFT+QOFdwe1b+KnWBB7wsIoj6Ca2fUfwQdKLkERaXhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111616; c=relaxed/simple;
	bh=GQKellaCP2xSQpjXnu/7/RmNqtkHfIFv+jYcqY1KHOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=so36hTrHVTcahdpUuYKMj+1QS0CpQMo8+reZAiA3jUzoT7aY/OijnMLGDpOl1eZBmrak8mzL4mvN1N8F4ykgZO7etfrMpA98pkLa+xD6ZlNqRncMV+o9/SbKhyF9l+4UZTZNeRgZFyOp6SkLtWWOYBE1QyOKS5nAUn1oDxsOU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arel5jJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE11C4CEF7;
	Tue, 10 Mar 2026 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111615;
	bh=GQKellaCP2xSQpjXnu/7/RmNqtkHfIFv+jYcqY1KHOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=arel5jJt4RX//ZHQLCscCZtITHUr5B04Opo0KFJTqqa3qKZhWVcUYdvGm4B7FevuR
	 tWPDthxm/WHlcCfEfn4FhJMzcssIfhkojZjaCTnkclpVWhfv/D4eeffvGv2woTCWCA
	 nzOA7bc2kccbJkKDgN6spCHZMj4eFZrwtXkG6XvVFHsi08QvRAg9ZuHjkptLx60Qed
	 ddukfaQBpXtCu2CphAm1oOIwijQfopd311IiOCNEkbi4arAqbx/UuOIBBST6Cp/DYA
	 7H1T5ubth6i3ENMeDD7jXButYcH0h0bGZGycTAwi4F46N+QiAJeiToZKynurC52YgC
	 lmwoP6l5p+4Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF13808200;
	Tue, 10 Mar 2026 03:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 0/4] net: usb: lan78xx: accumulated bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311161279.2039470.10457228707033865923.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:12 +0000
References: <20260305143429.530909-1-o.rempel@pengutronix.de>
In-Reply-To: <20260305143429.530909-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
X-Rspamd-Queue-Id: 4FACA244891
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265870-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 15:34:25 +0100 you wrote:
> This series contains a collection of standalone bug fixes for the
> Microchip LAN78xx driver, addressing packet handling, TX statistics,
> invalid register accesses, and a kernel warning during disconnect.
> 
> Oleksij Rempel (4):
>   net: usb: lan78xx: fix silent drop of packets with checksum errors
>   net: usb: lan78xx: fix TX byte statistics for small packets
>   net: usb: lan78xx: skip LTM configuration for LAN7850
>   net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
> 
> [...]

Here is the summary with links:
  - [net,v1,1/4] net: usb: lan78xx: fix silent drop of packets with checksum errors
    https://git.kernel.org/netdev/net/c/e4f774a0cc95
  - [net,v1,2/4] net: usb: lan78xx: fix TX byte statistics for small packets
    https://git.kernel.org/netdev/net/c/50988747c30d
  - [net,v1,3/4] net: usb: lan78xx: skip LTM configuration for LAN7850
    https://git.kernel.org/netdev/net/c/d9cc0e440f06
  - [net,v1,4/4] net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
    https://git.kernel.org/netdev/net/c/312c816c6bc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



