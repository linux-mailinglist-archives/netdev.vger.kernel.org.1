Return-Path: <netdev+bounces-292490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELZ5FX2PF2oUJQgAu9opvQ
	(envelope-from <netdev+bounces-292490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:42:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE1B5EB4E0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62FD3006B71
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21218FDDE;
	Thu, 28 May 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNIFFaWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1E146A66
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928807; cv=none; b=bE858WzpCgMNkNru35W+RiaFerKqQApVEiYuGll9aLrPNS+S5A3cA6HaIaRYHZCpWr6ZiPeUAvhuiuJX9lfd76Ddu7vAsX+Jr9cae8OQ/vsGKCHqhaVBzDKMIIqU5KQL3ZL8arS9vZA9lm30lAh3b5cvroATPV9rvcJfCLNAmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928807; c=relaxed/simple;
	bh=bIc9h8aspznzmYTb1VN1fiPB+0N3FfA7JK7q0T/K1Xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I+Ligklf29VYmzcIk7RtcLe9p98PTAmb0fpeLXKYFhtpLEr1cy0dHwpbCME71vryVaNhzDPQMMArsVDNEX1h79YmqBPNFTFruqz7nKe+bpZprTYfFzB6H0yRFY29dZcimiKhSj1yebYzyLouqWa5bYPRSnuIp3v88X4zTQx1cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNIFFaWn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37CA1F000E9;
	Thu, 28 May 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928805;
	bh=0mwPEJuJNQMZtllJrp5SXfy8BuqHU3bQ8dnLB7KcsR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DNIFFaWnPPFWMPbmDioknJ5JYI6BcSpSfJMepS/qQVGhwL5Q9A3tchLbiRm5PU/FX
	 eXw5aL+KyEmgQhzLlddewEhzY7jbChLB35KKaFZvDCEbS/eJz73Zn77qTMzU338WmG
	 JXQ7ZvzTG9+IP1adi3Mxug518sEFNf+4OAK+p9BDisTGgXZHwfRKu/MQ7Jjq4bO//z
	 xJKFfycaEMfXyczgHr7wIlEsNIt0P2ALEpCqf+fZCQwyLuW4jDkOqXKTxfM2aX8en1
	 3p7an6Uz7tFAO4IjalDoCj/5A62QDU5we7tEPngWpsRPOnHf2MKwA7duK0ecJsRgg8
	 pl5oOymAyACaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D6B380CFDE;
	Thu, 28 May 2026 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] ipv6: frags: adopt __in6_dev_stats_get()
 a
 bit more
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992881039.696403.17924574926990763654.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:40:10 +0000
References: <20260526145529.3587126-1-edumazet@google.com>
In-Reply-To: <20260526145529.3587126-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292490-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CDE1B5EB4E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 14:55:27 +0000 you wrote:
> First patch addresses Sashiko's feedback about a potential
> NULL dereference in __in6_dev_stats_get().
> 
> Second patch adopts __in6_dev_stats_get() in net/ipv6/reassembly.c.
> 
> Eric Dumazet (2):
>   ipv6: guard against possible NULL deref in __in6_dev_stats_get()
>   ipv6: frags: cleanup __IP6_INC_STATS() confusion
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] ipv6: guard against possible NULL deref in __in6_dev_stats_get()
    https://git.kernel.org/netdev/net-next/c/507541c2a8ee
  - [v2,net-next,2/2] ipv6: frags: cleanup __IP6_INC_STATS() confusion
    https://git.kernel.org/netdev/net-next/c/331d846a7172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



