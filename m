Return-Path: <netdev+bounces-294521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nTMwAR2SH2pCnQAAu9opvQ
	(envelope-from <netdev+bounces-294521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D815633A76
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TYdKFYh8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294521-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A58F307F52C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C43DCD90;
	Wed,  3 Jun 2026 02:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC13DCD95;
	Wed,  3 Jun 2026 02:30:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453819; cv=none; b=JWg5gpRSDVn/BDe9Ik0D4R0sSBRIqLJ5sw6RVkHkOUZzCmkCGiW7rIaj99jdqjBxOMhllYBdlxgaqkz51X8wGBk9n1J+bIQhnlWnvO42fiMOSvaOJ/UOBbgkpFxPe52WCgUWkboMzToVHHL7K1IZaJQN8XTefbRy/lvaT7djQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453819; c=relaxed/simple;
	bh=IERr/H6vayOJdYc6Q7l6xYaPak0022lagJNE4DzJ+vY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lcy3E5UqEbhsCASZ7veg3EqVnu0/SMU+GRJ/WlFkECsc9QGbh3SHBUwEOI5HnK9RedMRSHTiPFm+6+JTdxcWSwVtwgxDJlVu0YBUBYvMD1UsUmKvoqN8Wuufbpfr0jP05040uxtjw+s76UNOqPpuP71U/enquuBuRHy1oPUl+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYdKFYh8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B2F1F00898;
	Wed,  3 Jun 2026 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453817;
	bh=XfP4SCRfg+uxtVWmxBcZJEnFLmUrsv6wj7GlKICgaK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYdKFYh8pRTBgHEjXEIRo6k33fyOBfcQqMojRmXh+ZLhxtMRw2+N8XPBMu0tXh2eS
	 33Mzbc9/W/ZjITTsQ34CBowegNyuYY5EdzzGYHLifdm58vOP621oQjslE7d3Va8Eam
	 yMfL3t9BoewRy4O+dnur/HdEgtykklVAIDDrty8FLLjs/RDC70iDo/t+vXiD0lcLUI
	 hrlPz24v4INpzaLbxhztG3QhV/CNNF+PqWgrv+/2LYW0sijx5zf07PF6LHLgdBFd93
	 jXRSndBC854FkU6cW/UROGKj73Ds6uTFVg0gK3+3VSjfzsuq7YdlGV0LFbUhrgd/sO
	 aC/E8pJ1ey4VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A24393003B;
	Wed,  3 Jun 2026 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: bind_bhash: fix memory leak in bind_socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178045381914.1178989.17932849399843632529.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 02:30:19 +0000
References: <20260601013927.1835-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260601013927.1835-1-yanlonglong@kylinos.cn>
To: longlong yan <yanlonglong@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, joannelkoong@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294521-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanlonglong@kylinos.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:joannelkoong@gmail.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D815633A76

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 09:39:27 +0800 you wrote:
> The getaddrinfo() call in bind_socket() dynamically allocates memory
> for the result linked list that must be freed with freeaddrinfo().
> However, none of the code paths after a successful getaddrinfo() call
> free this memory, causing a leak in every invocation of bind_socket().
> 
> Fixes: c35ecb95c448 ("selftests/net: Add test for timing a bind request to a port with a populated bhash entry")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - selftests/net: bind_bhash: fix memory leak in bind_socket
    https://git.kernel.org/netdev/net-next/c/dfcc2ff12925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



