Return-Path: <netdev+bounces-295016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MC+EMIncIGpf8gAAu9opvQ
	(envelope-from <netdev+bounces-295016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73863C55F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:01:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MPLzWMyv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295016-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC5B30604A4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4A2EBBA9;
	Thu,  4 Jun 2026 02:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476242E542C;
	Thu,  4 Jun 2026 02:00:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538418; cv=none; b=j4PIbCp5Wp10LVb0BueWrMcsFdJ2Jl2z6TWevOjBP/b0V3E08qIoBjU0CemcI75m3pIrZUUBfcdeLo6aS/C7pQJKmz1/fLvRBLoO4QnxsxZ6bPhUIbPVup+SYuJYt8+3w6dfaGvC/4jIn6WGuUywbYEc8bXRav2bhmqp2E0rnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538418; c=relaxed/simple;
	bh=07cHC7lQjRkw4tvPHdFPVzurhrvEiaykgTwyUJZZfZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uhi3ON8h5sPp4JmSaukZatBi1H2ISgt6auLdcXZxHzcxaFp0aPn5iS0Fham8s9vKpIGUBojqWFdvaC3bj3hM7DD303rrFvBm1QUtluAu4pFZIPqvuB7yd9rvUUeiW6YpquS/g+jNgjApC11ijqShkJ/rKtVREejnzfVLroMtspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPLzWMyv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F8A1F00893;
	Thu,  4 Jun 2026 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538417;
	bh=TuyvhMv8QC4YNyxnxEWKYW5pw6iRWzzLMk363hihKQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MPLzWMyvUMsr4cIv4kwtEBg/zt463RNMopkie/43B4ojrQphAukj0qBQE52a5Q1Wl
	 tsH/GEZXLyCbNHZVjPdnwDZzjmjy0fBtrX4ewz7wzJCWRvafT2OXSrF6mzMLgOfG7n
	 RNb3oOHOA42hY/0wpsmPGYt8NHwyEwpqBx+bGD+JgvKjcHImpy2S2ql9SF0EZxMSGV
	 yoiy0awlz79QXx+9xBHDpekFBf5LmSBqgaLnHLPQW8Fvxh+yhUYaJnsJMKfee7LmOF
	 KwpbOOJ2J7rmvYncLMFMSzYcaqbarRGx2XKX93wpDN8jKQk9H2RWzt7MC7dJGI62VB
	 1rU+Skf/ByELg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CAD39308E0;
	Thu,  4 Jun 2026 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: Fix initialization of mcam's
 entry2target_pffunc field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053841789.2201066.2146025219526992766.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:00:17 +0000
References: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, gakula@marvell.com,
 bbhushan2@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sumang@marvell.com
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
	TAGGED_FROM(0.00)[bounces-295016-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sumang@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F73863C55F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 17:07:05 +0530 you wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> NPC mcam entry stores a mapping between mcam entry and target pcifunc.
> During initialization of this field, API kmalloc_array has been used which
> caused some junk values to array. Whereas, the array is expected to be
> initialized by 0. This patch fixes the same by using kcalloc instead of
> kmalloc_array.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix initialization of mcam's entry2target_pffunc field
    https://git.kernel.org/netdev/net/c/9a85ec3dc28b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



