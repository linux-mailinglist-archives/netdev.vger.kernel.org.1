Return-Path: <netdev+bounces-295014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WxtHClrcIGpb8gAAu9opvQ
	(envelope-from <netdev+bounces-295014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B68363C550
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UA3Tes90;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E0730465DB
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F602DE6FF;
	Thu,  4 Jun 2026 02:00:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5322DB7B8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:00:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538415; cv=none; b=Z0oRdX+MZLe+wnTnmDw5NR7yDxCnGvxF6W/3uo1Pkz4SWUOQi9QMemRcbii4wzocG+xfFNpFWA31umYb2n1zJ+0FYjD++iD5/LDLQdl+LnYGA32atR2h+554rJzZDEnL+SjKoIlPpxLC64dXbrlrw1mInv6KGEojWYcxcUL86TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538415; c=relaxed/simple;
	bh=98ruJFnz+wyuTFJ406aniv8fxsculHb0zEAXx1rTrk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZImVWzqUSnFLjmjwa2FmiTrF/fF1qhMe1vjUnOW0Oyh2U4+kBswHmqchynceu8WWL9ZSXW0Z5p4Ld5dJ9bq9EwOBQVAWh9oDS+Ii3/zcYQZBZXGeHEsKeq2KRI0Nn2vARHdnnkKECIODtH1ZahaiAcUNIxFgoyOKHjMksi5sHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA3Tes90; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A41F00898;
	Thu,  4 Jun 2026 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538414;
	bh=FZl92fMRpwoogmOzcoi7thHJq7C5QvnwYlHsLaGc3go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UA3Tes90bB35Auhef6/O825mT24SpNYq6rxMCGzaAEopHlxedoPZz0eZpE0p7B6b6
	 6QjvAR15Inj3MXU5/SGKm1KjVlbZRc0qSW/p4leIcJ6a4x7gNcyrHZ342AU19hkmlu
	 aOj/0nE2EFvipND6ker5XVIQjSWBoTQFUwiqdNd2vkHwagxzGJHrgY6GZnFm1nbKM8
	 hWFyZGJ/bMdGMXd9Pvjlni9h8QsyrZWp2E/tKghJpNADWaS9l+LXgTteitBh1ejZkB
	 YqUsiY1A3mjpmk5iz8c92fO6U2s2esq7hd43lpkzZpuTm2ynMFxRSb3ZgFNpwwEF4E
	 mjdqTr6movN2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5685D39308E0;
	Thu,  4 Jun 2026 02:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841489.2201066.15034562668462590122.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:14 +0000
References: <20260602161547.2642155-1-edumazet@google.com>
In-Reply-To: <20260602161547.2642155-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, tamirthesis@gmail.com, aksecurity@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-295014-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B68363C550

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 16:15:47 +0000 you wrote:
> This patch restricts setting Loose Source and Record Route (LSRR)
> and Strict Source and Record Route (SSRR) IP options to users
> with CAP_NET_RAW capability.
> 
> This prevents unprivileged applications from forcing packets to route
> through attacker-controlled nodes to leak TCP ISN and possibly other
> protocol information.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
    https://git.kernel.org/netdev/net/c/d3915a1f5a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



