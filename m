Return-Path: <netdev+bounces-296015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WgLjHFt4I2oLuQEAu9opvQ
	(envelope-from <netdev+bounces-296015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:31:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D174264C1CE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VPJDRbo0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296015-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296015-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46A7A3053BB1
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700D2580CF;
	Sat,  6 Jun 2026 01:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C882512DE;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709417; cv=none; b=D2BUMwX2ZRs4Nk8mFf7UKwzM536Acd3vUqLBHEfrqd4KS4+4idn4fsdDa0BpYq1PxhIZEkRvvHYvTgLfKUB6p1NFDo1iLoEdzbkfYT5HtXV7hOWjjaH83NCQ5movW1Mk9dtU5HCNoraWQcw5zALoZcJCAyBCiaYPtiqntWpWsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709417; c=relaxed/simple;
	bh=AOpJt3/ScylghXXV+c6MMBc7qzCZkF7NfEl7CWFjgKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ULdfRUetjE/A6aFH7OTD8r4Fwlm4hw9i/RqGOJlxx7AzWY1wY9XAKQVtjHSknicl8XcFJ9DpbpfBw84usyVbjeYSPPG9IKacFVuoQO1JLqMVIr2AyD8rIV5Rjl/zGtjLpNNVItEOsjshGTqIIPmzgNqaLuBHbyhyAQAPxCqsN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPJDRbo0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740981F00893;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709416;
	bh=1pA8EYe0YDMvOlb0ipV6gDcp+OABRcE4wIuWa+Yf2rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VPJDRbo0RLzBD7u319t3gnBdP+eTBpMUnlFQO7M7JbgOoSaTtlBkCstHd9fnmPi5M
	 qhdD5m/VNgVn2vXsbdzsPp+6eF1Na2+Um8sfhHVKZr3QhjggOuLjScL4Ix/d13isEf
	 IRWRjeUxl7FRUGaouyDLqRJwqdMHvFjBG1QMEyWYQuypeTF6MvmfJ14GA2OhoYrtYU
	 j6KyNb7Yg3tq5RgjaSDa5xRSpgjFUc6iKRI9iDEVtVJBjgPDN7FfLnLGE4f80GEqKj
	 KGDhbw8ZfYqCyG1jZukLlsp0lTeUKC/F+Lu2X1LSN6w26V9eDzNouuHPj8LhjiY1FU
	 CtXSyS3ZJ+acw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A093930A9C;
	Sat,  6 Jun 2026 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] hsr: broadcast netlink notifications in the
 device's net namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070941639.3983833.443113643619993173.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:30:16 +0000
References: <20260604054949.2999304-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260604054949.2999304-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmancera@suse.de, jvaclav@redhat.com,
 andrew@lunn.ch, luka.gejak@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ap420073@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296015-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fmancera@suse.de,m:jvaclav@redhat.com,m:andrew@lunn.ch,m:luka.gejak@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ap420073@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.de,lunn.ch,linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D174264C1CE

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 13:49:49 +0800 you wrote:
> The HSR generic netlink family sets .netnsok = true. HSR devices can
> live in network namespaces other than init_net.
> 
> Two async notifiers broadcast events with genlmsg_multicast(). They
> are hsr_nl_ringerror() and hsr_nl_nodedown(). That helper delivers
> only on the default genl socket in init_net. So the events always land
> in init_net. The network namespace of the device does not matter.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] hsr: broadcast netlink notifications in the device's net namespace
    https://git.kernel.org/netdev/net-next/c/a762fabd7ef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



