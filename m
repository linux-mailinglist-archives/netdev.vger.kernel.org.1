Return-Path: <netdev+bounces-304612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GgVeF3jnR2qLhQAAu9opvQ
	(envelope-from <netdev+bounces-304612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BD70465E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hv8LWde+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304612-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304612-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA6F3035827
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B130674D;
	Fri,  3 Jul 2026 16:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6263033DF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096827; cv=none; b=QPIcxzVhT2wFkHjVQdMr1YIcs2J59qQ1H+dXJeLmMjYIjydcap/+Y3S4kUMRg62netu7QeyqTBjufEgltmYgTBlMoSvFnhwUKvRiU9+PO52fxwBPUg1vtN4cnjYmCm3Z/yrRdJH/aQiDIcaoHP/A2dFB0UsUTxKhZKZPsiqI310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096827; c=relaxed/simple;
	bh=JRe/fXX3hHnmsPEa+Eh1u5NiKPt28j7YwFJJbjUZWGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SQHHUhb6qkoblWlYXl6I/b5iMPPYHNcoAtRGZAfcAM+kupmp7fNT9dRqgfnrhT2b7vnAqYsu3j4e8QNRoq5YeadSZ73SP3Ul5EeRGCuK53M6fpywIWhjKGgSXOFLOh5349Rkc+1bHD2DKS4puv0+dfGHtae/Vta7flRH++KOiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv8LWde+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2071F00AC4;
	Fri,  3 Jul 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096826;
	bh=NTTCEFx3mCgZ7kWN2D7+RmXDQbdyw8zW01Cw/ECRemg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hv8LWde+poIQ4eHAiAEeOEwtLpN3LCvtM2luR2gOwTsjZ4pf6re6WEZcnXm6yT8dV
	 TubvVHZQweMWgwjiix8M1W0d8O4ygefyrxhWehzG99EAEgBw5pn6QzFU24xfLy5zeV
	 Km+JPET/bGef99m4txo+SdBq5RJ6Ly5V7nCC0rf62DGrs28WAaIzkcCDGpa7qs4dbs
	 +H4e92KoO2qLWWTVgvchBl0JSewcpo4oMFql4ZxM23U++W/axAYDrfuwlbogdv0hHt
	 87b5kmZnOvF1z+7oI6de01KEXfK1sNfMgmlSG9pkdTmqHg4FH80PAJwCZdixY+n1B1
	 94vH6MALUsNXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A053939356;
	Fri,  3 Jul 2026 16:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] macvlan: RTNL-less macvlan_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178309680863.3234711.6167695440715149504.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 16:40:08 +0000
References: <20260701082214.2974946-1-edumazet@google.com>
In-Reply-To: <20260701082214.2974946-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-304612-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C47BD70465E

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 08:22:12 +0000 you wrote:
> This series removes the RTNL lock dependency from macvlan_fill_info(),
> allowing it to run under RCU read lock.
> 
> The first patch annotates data races on 'mode' and 'flags' fields which
> are accessed locklessly in the RX/TX paths.
> 
> The second patch transitions macvlan_fill_info() to RCU, adding necessary
> annotations for other fields and handling concurrent updates to the MAC
> address list by computing the count dynamically.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] macvlan: annotate data-races around vlan->mode and vlan->flags
    https://git.kernel.org/netdev/net-next/c/ed37710d6c67
  - [net-next,2/2] macvlan: no longer rely on RTNL in macvlan_fill_info()
    https://git.kernel.org/netdev/net-next/c/6d728e7e286b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



