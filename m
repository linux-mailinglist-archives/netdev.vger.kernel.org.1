Return-Path: <netdev+bounces-303760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Re2tCtA9RWrV9AoAu9opvQ
	(envelope-from <netdev+bounces-303760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:18:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF916EFAC9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:18:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bAuoUR2K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303760-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303760-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F38B3019BA3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BEF3B960B;
	Wed,  1 Jul 2026 16:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F736215B;
	Wed,  1 Jul 2026 16:10:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922241; cv=none; b=hYohazlGRYzWr+TgiAbcvIcEbRrbaGTxI11WQHx9k7A3lcgSwpgs9dZbgP595HDd5pEgJLgGSnpNYHzAjYOuhvtseYzrK/841qsQdQDf5IURZuFUa/bBRHTmr6ivVXOM2hqB+OCZoWREQpqcpf4K0LDXTQSlcl5MPjTHSBETy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922241; c=relaxed/simple;
	bh=SBjt9eZbxOnTtkon7iv5IbyVNy7g8Gpz1rTEYRiDoV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S7gFMBesqfutDPImMkAii6/sFAlRa1Jf6gBWj5SiA8FR7qNWUeu9lBUI/uEvbYJ0uUE/S1eBi4JHmz17fggNpynb8D6ZoysfcUVsYxlGDcfQ/ERSqpPZF0v5sGoHRJ4lOwd3tAWBCR8FOiG+dtGI+D6N9p6B7TBYAht0179MECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAuoUR2K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF31F000E9;
	Wed,  1 Jul 2026 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922240;
	bh=SxD1GHI8IdTf1emdr9tRzCKDuiwuIaKpOs4/kj58RYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bAuoUR2KyeJHhCiOCM0NLXrtg4pcKGtOniRI8LulswTvei1UCwglQUE9Y/y8V1/01
	 p4OomVulzsvrwlZ7iCHBugy0CE9WX0QIMileWMqO2QEhAnw3Q+j7QsOi34c0F3qlui
	 6Y2Eb1un4W4UTB1KKvsILlE8BiNiPzI+Gl8+EBpz/ImLWnz0gI72ZguRqNKsiiI9ZX
	 du4VIK76rHEg+DlJU9ky7jNTTcsrRPxEWWzJhuV1jAR1kmMITskcmYTczh5DNLAwjD
	 +dUIiYE4suflYwzr7A2lZZuyaMCJrLFsoOGzzCRkozjOFmcda0/NKzgTLT9TF5nHw7
	 W7ZR2k0y5QpqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C4D392624E;
	Wed,  1 Jul 2026 16:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/13] dpaa2-switch: add support for LAG
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178292222314.1181542.3911601568569227695.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 16:10:23 +0000
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303760-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DF916EFAC9

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 14:22:56 +0300 you wrote:
> This patch set adds support in dpaa2-switch for offloading upper bond
> devices.
> 
> The first two patches remove the necessity to hold rtnl_lock during the
> event processing workqueue by ensuring that all event were processed
> before any changes in FDB layout happens.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] dpaa2-switch: remove unnecessary dev_mc_add/dev_mc_del calls
    https://git.kernel.org/netdev/net-next/c/97cb4ae7511b
  - [net-next,v4,02/13] dpaa2-switch: avoid holding rtnl_lock in dpaa2_switch_event_work()
    https://git.kernel.org/netdev/net-next/c/0cf0b8ac40ae
  - [net-next,v4,03/13] dpaa2-switch: extend the FDB management to cover bond scenarios
    https://git.kernel.org/netdev/net-next/c/900c915030f6
  - [net-next,v4,04/13] dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
    https://git.kernel.org/netdev/net-next/c/da7ec6b81b0b
  - [net-next,v4,05/13] dpaa2-switch: check early if an FDB entry should be added
    https://git.kernel.org/netdev/net-next/c/0199ff706da1
  - [net-next,v4,06/13] dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
    https://git.kernel.org/netdev/net-next/c/06840a236334
  - [net-next,v4,07/13] dpaa2-switch: consolidate unicast and multicast management
    https://git.kernel.org/netdev/net-next/c/28b79b55852a
  - [net-next,v4,08/13] dpaa2-switch: add LAG configuration API
    https://git.kernel.org/netdev/net-next/c/f27ad9b45b13
  - [net-next,v4,09/13] dpaa2-switch: add support for LAG offload
    https://git.kernel.org/netdev/net-next/c/9ca09640bfc8
  - [net-next,v4,10/13] dpaa2-switch: offload FDBs added on an upper bond device
    https://git.kernel.org/netdev/net-next/c/711c0beea13f
  - [net-next,v4,11/13] dpaa2-switch: offload port objects on an upper bond device
    https://git.kernel.org/netdev/net-next/c/f0a7468fdbeb
  - [net-next,v4,12/13] dpaa2-switch: trap all link local reserved addresses to the CPU
    https://git.kernel.org/netdev/net-next/c/a0a8970b516d
  - [net-next,v4,13/13] dpaa2-switch: add support for imprecise source port
    https://git.kernel.org/netdev/net-next/c/f985358f4ee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



