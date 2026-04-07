Return-Path: <netdev+bounces-275816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ9eMs9g1GnltQcAu9opvQ
	(envelope-from <netdev+bounces-275816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:41:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907F3A8C2E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38498304C11A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E923B632;
	Tue,  7 Apr 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER2RAdtw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BD1F91E3;
	Tue,  7 Apr 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526047; cv=none; b=GxNJoHR5RRCD9JRtN+oFqLfGypYULIp1klzl+6HZLRBQcrZvWEVNukOUutw75aG9j4dfHaE7HP/aXtajec6Qnmq6RiScXFtgo8ElyuqdPAv8dGHTQYgfLkBNGaEXAZIBEygaCudereJ7lDdPQOPt3kEYLFEwNEIlRfrHzbThljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526047; c=relaxed/simple;
	bh=CrvNckWVDsiDnXOP0XHIevmZ4ZtfHWAyTDSyNAQ/iqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X29Dufd0WD741fbHg9GsYVx5R1Ud46enxkQ4Lx6bt+9I891sSg8U+wLJOQ44iOzsWavfPXgGscI9WoKn6gVavQx993qOq8Ajn30M6AIfGEgNhP0lzqokEeVKkvrRCRC2uUG02oxLL71Fb4+nwij1ab9GXhR/BojQgnMeRxv7ELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER2RAdtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBAC4AF09;
	Tue,  7 Apr 2026 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526046;
	bh=CrvNckWVDsiDnXOP0XHIevmZ4ZtfHWAyTDSyNAQ/iqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ER2RAdtw8T+wzjQMTw8I60jp1oyuQVGG4Kl6hrnaWYol2mA+5SXolp2zP37fx9EKo
	 MclHdqofvBIaCtQz/UDiUfxsTh5QFuoehf/DutZ0K5rJzf/fGg19rRsbj1d3KaYXH1
	 MC8wYS/scRSyUvTo9fUJQKhl2mQHqVeW9clJ9+jaWvHwbgru9On5eSBKUo9PaCqrox
	 /E589mk39UE+7aPJKuN9cmlBoUgwMyr69vNI5zkXp7kjkccsCWsqwxHQWNBcSSpOl9
	 NTfv4YPzBN9UdKvfNND5k6PVOUYo+cvQtOok9cwWCssON+9tsh6MLRGhNKZbtEKGDy
	 dVyhsto8/a+yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1DF3809A28;
	Tue,  7 Apr 2026 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock: avoid timeout for non-blocking
 accept()
 with empty backlog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552602504.3334922.14970338927374707582.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:40:25 +0000
References: <20260402204918.130395-1-laurencerowe@gmail.com>
In-Reply-To: <20260402204918.130395-1-laurencerowe@gmail.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 bobbyeshleman@meta.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275816-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3907F3A8C2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 13:49:18 -0700 you wrote:
> A common pattern in epoll network servers is to eagerly accept all
> pending connections from the non-blocking listening socket after
> epoll_wait indicates the socket is ready by calling accept in a loop
> until EAGAIN is returned indicating that the backlog is empty.
> 
> Scheduling a timeout for a non-blocking accept with an empty backlog
> meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> of microseconds of additional latency per accept loop compared to
> AF_INET or AF_UNIX sockets.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock: avoid timeout for non-blocking accept() with empty backlog
    https://git.kernel.org/netdev/net-next/c/98f28d8d6e5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



