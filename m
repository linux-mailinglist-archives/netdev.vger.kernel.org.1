Return-Path: <netdev+bounces-299713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ulJKYmwMGotWQUAu9opvQ
	(envelope-from <netdev+bounces-299713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAB68B68F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=N8CNRlWB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299713-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299713-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B700300603E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A73A9D8C;
	Tue, 16 Jun 2026 02:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B310391E49;
	Tue, 16 Jun 2026 02:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575811; cv=none; b=becoZwR51twE0bHjbfam1/6VAY91XkKn9hR7zRalM1bTzNNPLv5XNZK1Os8lvIG96SYxlDGm4xRo/Yc2vmyzRTHxHGELTGOQLtH0vmcpk/LsArM3bt6D/BIeJALZQGfE0jpWTOO9lYNI44dEMNcqn2tZu+6NbZd9yfZJUKxdf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575811; c=relaxed/simple;
	bh=of34fRKBYUZvDxAyR6UMEDMCu20pX0y5iC5TZScvzL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/1As3xGgRLu1VcZlMfGRE6vPW+ThwAuWgIFdnF+nNJYRZ6AjgD27CrbhXF5GhGpGeb0oTJ3vZPHSqRdMU7COe/p0gvAjelPI4o+/91HlnLQ+dSuoisjKvNlAnT6biU8fKEP0sNMWv0/QgDTl+cdW289cxneuqs5Wo85YgHFv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8CNRlWB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BF1F000E9;
	Tue, 16 Jun 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575810;
	bh=NYfWWcl8Vaz5dyQoFNOwiQBYjsJN4KQ+mYA8kF+EyLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N8CNRlWBeEBYVaVEUrbi4TznVZaamfaX1lYr4WeCV/HNvfbLBm8ChXYkeF+KjfWSy
	 TIWtRVYXPM1HaIcQ0HomTQ5A2Ri+5lYa5SjBRaYY/TVXJLEtUtmlZYk/xRrYktHve3
	 RTccuSC1t5I9gE6evXyKKkVJrQo57b4G75AuWCxLIkQ8B0PuQS6xN4C+Rj3Ikak/2K
	 AjIz+lHq/eLhwVopF4avT2AtuLgDsm2wK5Q5ln9HasOvw2Dw6u+bRtEtWxkDvD7mE8
	 9sbDqNibM9Ofs0WjHMCTX4STjlMN0fKTKVA1QQNoiE3dzL9VHmLcdKWjqqVhG+2xms
	 ZSDNb9OE65n3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AA93839A26;
	Tue, 16 Jun 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: sja1105: fix lastused timestamp in
 flower
 stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178157580564.388586.11606897833464458044.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:10:05 +0000
References: <20260614141320.1133321-1-mmyangfl@gmail.com>
In-Reply-To: <20260614141320.1133321-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-299713-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BFAB68B68F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 22:13:16 +0800 you wrote:
> flow_stats_update() takes an absolute timestamp for lastused, not delta.
> Fix that.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_vl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: sja1105: fix lastused timestamp in flower stats
    https://git.kernel.org/netdev/net-next/c/72dfa4700f78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



