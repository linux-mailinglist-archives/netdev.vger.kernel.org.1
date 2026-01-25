Return-Path: <netdev+bounces-253248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMRwLc2bdmmqSwEAu9opvQ
	(envelope-from <netdev+bounces-253248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CD82B8C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D1430022A1
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754630E831;
	Sun, 25 Jan 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAZRChpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3130DEC7
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380810; cv=none; b=hDu/zdCsbEyptFhyJzeU70Ybqs8bgUz09XEAhFS7ksTZ5fnBHr39SRybwyfLXq5dH8hLa3QdFhb6/K/LyHgleCYzGL2diNAM7DbwX+WjMAOe1wZ5Hr0Iib0NjzeX4LvXWnAj0pIJjcZgYLlqMOHzs5JnBFQj4wNo1YVJcdSuwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380810; c=relaxed/simple;
	bh=qpcbx1LEOxoIV99DAi1Sa+osNRlsNkgHOONuve4phMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9UMDAKWd0uG0H25a3g42KWKTi1zKDZiOIjtfKt+mNqwENtNLALa4OLvzXCYNDqmptf8L9ywaOzrkancDCM6sC6j9s0bx5OvKXJnyLwwhFnwj/t1rjNjp9v2i/FyKlssA0ZUkzmj3qQ3Ub7rrNPYwgvRyjqgGxkBkwMsrlmC1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAZRChpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43429C4CEF1;
	Sun, 25 Jan 2026 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769380810;
	bh=qpcbx1LEOxoIV99DAi1Sa+osNRlsNkgHOONuve4phMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MAZRChpIdQFZxT2aVT2pNahnPb1PGSOxrPEDQ7fEErgXpCqxmsjO+0yTi1SwRz0y6
	 bFf0lZTTOMdfLpQVJTraKpqtnWuV9Pb3e31zzS9OlP5RLFgDV4lhyJY17GEN+TBR+N
	 qcBU0kINKRfsw1qNHvzaPqEUYGG8VIhGVeGquXTgGWnxCGiUkR6voYQ7yY2Bs9oi2m
	 wgi2UbD2b36HI+CCp00w5EKt5LT3H7P6LFsnUSTIUs76SK1wI7o8brNaB+Sa6xziTY
	 pdBVUpcIROfD9aSHVDjdasrgRJ0GYkQOm3PcZKNTYR8QJiUEYZlvWi4Oqqm5gfNeFc
	 AZ9Uv8+0j8mfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA613809A15;
	Sun, 25 Jan 2026 22:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipvlan: remove ipvlan_ht_addr_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938080485.3999180.2057022678876343066.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:40:04 +0000
References: <20260122165049.2366985-1-edumazet@google.com>
In-Reply-To: <20260122165049.2366985-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, maheshb@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253248-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F34CD82B8C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 16:50:49 +0000 you wrote:
> ipvlan_ht_addr_lookup() is called four times and not inlined.
> 
> Split it to ipvlan_ht_addr_lookup6() and ipvlan_ht_addr_lookup4()
> and rework ipvlan_addr_lookup() to call these helpers once,
> so that they are (auto)inlined.
> 
> After this change, ipvlan_addr_lookup() is faster, and we save
> 350 bytes of text on x86_64.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipvlan: remove ipvlan_ht_addr_lookup()
    https://git.kernel.org/netdev/net-next/c/054130222781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



