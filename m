Return-Path: <netdev+bounces-297414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JO0MAbLOKGrvJwMAu9opvQ
	(envelope-from <netdev+bounces-297414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:40:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD66657AE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 04:40:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F2QEVxPm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297414-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297414-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29EE63086164
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260A307AE3;
	Wed, 10 Jun 2026 02:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDE2E7F20;
	Wed, 10 Jun 2026 02:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781059224; cv=none; b=kxePye7NY23cVuAAYKmCrzP+8UecLaJk5fdzPO2pXLjOkys2CDfnd/hMcz0NnpJ3F3bSo9QAdvoN2e5lD5Arpkg+zVSHbzSd1A3W/XYEh3lTHktG8ePgOEvCjiUHiGu9Ni6K1dXREdrX1eddLmDTKHx6okkmXSjCWQSVZd9cOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781059224; c=relaxed/simple;
	bh=IzmuYkB9LC6LjeXQCdfl4xSPsoXi21F3mqcaffnWVjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwCOGptNbDjdNNBKn6YNb1F/zlU7RkJqlMguTUSyzCV/pQeqjmhT+V4aMAQiwIblHwsNe3p/k2DuYpmjh7hTBaSRH7lD0OBqWrbrUyX9mbFEYFMug5RPBD7xW/RORHHKQ7J6d2LBD/XBomzdmnRlgvPwIpcx1KFZJ1Lg4Tbt/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2QEVxPm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B251F00893;
	Wed, 10 Jun 2026 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781059222;
	bh=vtTDuo0qKrSJp5n/OLHUXioCZxDc/kkSbEL8uF+ZTvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F2QEVxPmcaA13n1VsDG/Uh2elXLR6Enw0BwoT7z7d/vx+VpV4+dDZCwyFBYkNPGUw
	 QYgTtzue+x48FugnxxiRbt+4iLk7synEoBTCtpchNMY4huJggy4zIO33EwpPYaaofj
	 3DvnsnyP+KpYSXFKFff/t44keeZyuBHWyVEtwW1sreAUi5pEed91I8vb0OBJKWZndH
	 9kYRWoqyOnjD4tPkQ+GSBWXElVNNiPq4fteFAYiqH9yCz9IH8R+nLShBCriADUNaNJ
	 WYBWXMAqTehbYyideQm2PXvPWwASdsmJ9M7a3bKJW0nxiOYlRJurLMPuAbsluISetk
	 OkSHzJl8OWArA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E93930A20;
	Wed, 10 Jun 2026 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: lan966x: restore RX state on reload failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105922063.2803230.10155796854496927089.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 02:40:20 +0000
References: <20260607145747.1494514-1-lgs201920130244@gmail.com>
In-Reply-To: <20260607145747.1494514-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 devnexen@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297414-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63FD66657AE

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Jun 2026 22:57:47 +0800 you wrote:
> lan966x_fdma_reload() backs up rx->page_pool and rx->fdma before
> reallocating the RX resources for the new MTU. If the allocation fails,
> the restore path puts these fields back before restarting RX.
> 
> However, the reload path also updates rx->page_order and rx->max_mtu
> before calling lan966x_fdma_rx_alloc(). These fields are not restored on
> failure, so RX can be restarted with the old pages, old FDMA state and
> old page pool, but with the page geometry from the failed new MTU.
> 
> [...]

Here is the summary with links:
  - [v2] net: lan966x: restore RX state on reload failure
    https://git.kernel.org/netdev/net-next/c/aa97f11a76e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



