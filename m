Return-Path: <netdev+bounces-296789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fl/sAQNYJ2oDvAIAu9opvQ
	(envelope-from <netdev+bounces-296789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:02:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47265B419
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:02:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WbOGRXEW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296789-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1603045475
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BB5241C8C;
	Tue,  9 Jun 2026 00:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEC2BF3E2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963216; cv=none; b=jC80oDSQ26DHlN+qboELdNeffM9AKZN8kZbYlmM8Ea+HWZm2TYd68JjLDMRu9Fu+ZwgDu+ZCuVj+laVDdVwitnN2LUUq2skp0dnv52Y09t4C1gC/YxqKi9EeKIbc4Bmc7YYl3GJUeSV5mXKdDhrgHq2lfj81K3zZuVzSojSxtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963216; c=relaxed/simple;
	bh=qH9iVc+b+cldbRj9fFhitWkNvsyZnarglgc7tug9X6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tPTcSdF4Y7D6k2bPsw4t364mrP7IwBwLfpAreFQDmvZPlGibA52SCI/7JsQvOzroiElimOTdMSrir2B5YQaQLLU47M4V1Q4O2xmKqRyR+spE8cysyi2cbJRyGM13sj4RDiNx0Cs8CITZYd4w/BnGi2RKMho29/w3sgpUnlKgvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbOGRXEW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71BE1F00893;
	Tue,  9 Jun 2026 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963215;
	bh=DcvM373Xmk4VXBSSd3PH7Nqwuspi9gTK3vpxFzXt/ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WbOGRXEW1JEKuA3QKhqqqeX113ACUcYNq9CVU7xbo0iwGAE/sQ8ahrfge8MX3Seho
	 W1vl5eAHA1bFtARL0/CcgorQAEacWZYI4BTz3igBMiZ7J4DmlUg5G1FQPWXatuTtlq
	 fg+SEwy4+YsGPrEveJ8Q/Wlj2UuRHjm8wGp9sBYMoDbz5IGUutESQHIjCKnO94eyb+
	 tDfg2ehkrmGYW2/BfyJpKI5BXkcpcleaB0NSy2/vgW7+xo0aBvz4bfgmq68DWbuLTt
	 x7VNL6agCOTXR/jE1n/iApIjIyGG4eK3I7UPjlRRWI9eVe3JOfa8HDzxCnrGL1rBYx
	 R8geiTLz82bGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B2B3812FDA;
	Tue,  9 Jun 2026 00:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: remove obsolete EXPORT_SYMBOL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096321414.1718110.1074358995484772057.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:00:14 +0000
References: <20260605073426.2922242-1-edumazet@google.com>
In-Reply-To: <20260605073426.2922242-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296789-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E47265B419

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 07:34:26 +0000 you wrote:
> IPv6 can't be a module anymore, we no longer need to export:
> 
> - neigh_changeaddr
> - neigh_carrier_down
> - neigh_ifdown
> - neigh_connected_output
> - neigh_direct_output
> - neigh_table_init
> - neigh_table_clear
> 
> [...]

Here is the summary with links:
  - [net-next] neighbour: remove obsolete EXPORT_SYMBOL()
    https://git.kernel.org/netdev/net-next/c/1bf20cc62a54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



