Return-Path: <netdev+bounces-297013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hzdpFOrvJ2rI5wIAu9opvQ
	(envelope-from <netdev+bounces-297013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED165F220
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mbRT70xW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297013-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297013-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517E83020AB9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF73F8235;
	Tue,  9 Jun 2026 10:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A6257452;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002215; cv=none; b=vDU9aZjP2s44KsTb2MyC/ZRAQQDQPzI+1Sgfpi3eqQpkfIQDqk2ompb3QipiAc2FpuEu0eiKd5Pxl88rQ0ayQYHSC7w+iNGIc/Y+A+SQ/OmDk43/D6ud+RP2CBdf+WlToVRrnvWc/dNE0YM/17bI2lSRmgwKRxt2lvYqBjHj9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002215; c=relaxed/simple;
	bh=ZJv5FsgToGlz7t+vSwpZ8JDnQK+8a8CnI0anK0wI3kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KoIRDI1m9xamaqDJgPntIThJto/9ZoNBKrK33WOIv1gwdu3F0E4oVEVit6h260GoBszhYSy6dtpI6dXJwY9Cxl3nKvmx602Zh5k1eWnMklDY6jbK8NbJAzGUMoOOxvQT18GHCoNk22soL1bK/0n/EHTlfp0BkUtHiA0OyfgnEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbRT70xW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04121F00893;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781002214;
	bh=7X1R5e8eKyVfWu36Pph9gEJfjpEZaY3IyZSHz3qCkm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mbRT70xW9s/BW9jucRvBzQewqb1skjSYx5sUoXx3lVKN/uMIY14BrVrSzz4JEFKYF
	 sx6HCx3j5zqZq+5ilaRJIW+C4fDWn8F3M6kmoIr9LFTfHGOPCmzXXITnc5hSHf/+id
	 p69j2W+iDSCXN+5t0JtESWTw5M3wuUsIyu6nG5qwcYQeLlc3u91dsH6oTg50pquo3F
	 w/sRzGFIxPOo3Zh6Jvte0I+F4wlI9hsuE2RPqJcwG+ige0wJIdwaHK5D7mxvQ3yr2K
	 SwxYIs77rH8IKnHUykYic3OvE1W/DJj+ZuXdCt62gsyruMVl5qsS08afk6ajssY8kw
	 nR04ex6y6nuQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680A3930886;
	Tue,  9 Jun 2026 10:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] netconsole: Fix reported problems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100221314.1952542.11586659643463276886.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:50:13 +0000
References: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
In-Reply-To: <20260604-netcons_fix_before_move-v3-0-ab055b3a6aa5@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297013-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93ED165F220

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 04 Jun 2026 09:10:09 -0700 you wrote:
> These are some of the issues that LLM reported to netconsole, and they
> are being addressed here before big refactors.
> 
> I was doing some big refactors, and got some "pre-existent-issues"
> during LLM review of the refactor, that make them hard to guarantee that
> refactor is not introducing any bug, so, let's clean these pre-existent
> bugs first, and then submit the refactor.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] netconsole: do not schedule skb pool refill from NMI
    https://git.kernel.org/netdev/net-next/c/212a922bd545
  - [net-next,v3,2/5] netconsole: do not dequeue pooled skbs that cannot satisfy len
    https://git.kernel.org/netdev/net-next/c/6c537b845c99
  - [net-next,v3,3/5] netconsole: take target_cleanup_list_lock in drop_netconsole_target()
    https://git.kernel.org/netdev/net-next/c/91aeb87f0523
  - [net-next,v3,4/5] netconsole: clean up deactivated targets dropped before the cleanup worker
    https://git.kernel.org/netdev/net-next/c/4cfcd6acc295
  - [net-next,v3,5/5] netconsole: close netdevice unregister window during target resume
    https://git.kernel.org/netdev/net-next/c/0360976d7ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



