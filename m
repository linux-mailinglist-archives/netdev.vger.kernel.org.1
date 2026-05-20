Return-Path: <netdev+bounces-289673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJBxB2gFDWotsQUAu9opvQ
	(envelope-from <netdev+bounces-289673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E158662D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25B6303A538
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32625F7A9;
	Wed, 20 May 2026 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejD92kPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A16E573;
	Wed, 20 May 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238200; cv=none; b=qp1AZYntx6UvSQOmIIhms8SJbbntwQyOwCOMvUJU9/b9yfFIPtArbOCIlBt1JEb9FkHAsVtu0qWKV5V38AaMe6X6nwL62qpu0YdfSOvM34CikMXMl+c90IHZL1Xq0o3ItYzY94lt3I2txKQpZbzSM+CK9KSA0bDZvwqQtQigcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238200; c=relaxed/simple;
	bh=FzG5rMrwxhc1g3YILVGaByRQ7gWAqOUQ2U5Vw7l9FPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qaASf8xNZlIk4y7TJvFbuMYYKDgQAGkoJkO8Vyb8D6Nl7lzLrYvs0WVrjigpYGXp9CPfOdPOaVZGlQwjimBTpnOg3Uw9TFf8Q/FvcnCGOJn7hE5WyTedONEOX/WRoSanIQK8N7MyJqa2BUzgTEUVo66wujqrCZKenZKn/Q8CdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejD92kPB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069891F000E9;
	Wed, 20 May 2026 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238199;
	bh=MmoD3rFCdGNXuu4oCruzaEdZPOexdlnOf6QsyJLqtcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ejD92kPBW9/rvy650vCm0UZgdfVaNKvd1m+DSOGVjhdBXGBv6DjTwmK6Fasof9O4u
	 klrCdc6UsTwwW/Qkrc8rDdj1MyutkiHPCczj+W31lO+yYk5uzZAA/GTRnfoJkmdlxI
	 jWSVUJscNq4kbiBgbBcOZ4yeeJPxg2Yho1kGw1RpmK9WjK/yw5eKQwxOHf9wJ5mCdZ
	 8bd2odtDnbC8q/pITmPMSZnIUJowX+4cjYB7GZgiJrch7Vpn1BfU3hJoJyt7/sOfdn
	 QW5pGd8o/vv2+rikGicMkZUdcaY2JyYpAaPoFZraH065OSI5oFbRjBdzj4L2loq5AD
	 dd7QJ3bXBDWCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19827383BF53;
	Wed, 20 May 2026 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: micrel: use dev_err_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923820963.2936298.7454721965938463012.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 00:50:09 +0000
References: <20260515120608.706361-1-robert.marko@sartura.hr>
In-Reply-To: <20260515120608.706361-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sartura.hr];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289673-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sartura.hr:email]
X-Rspamd-Queue-Id: 708E158662D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 14:05:40 +0200 you wrote:
> Currently, during probe defferal the driver will print multiple times:
> mscc-miim e20101a8.mdio: Cannot register MDIO bus (-517)
> 
> So, lets silence that by using the dev_err_probe() for printing the probe
> error as it handles probe defferal.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: micrel: use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/65d6d1fa5093

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



