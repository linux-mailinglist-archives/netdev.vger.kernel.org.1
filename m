Return-Path: <netdev+bounces-281612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAlwGuUi8GlhOwEAu9opvQ
	(envelope-from <netdev+bounces-281612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9EF47CF88
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50684301A911
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C427FB1F;
	Tue, 28 Apr 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9n1WVPl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CE22339;
	Tue, 28 Apr 2026 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345250; cv=none; b=touws5MM4zAxSqhsLVswd1SlX909GFgwyENhuPVD/Otrt/9a8HSglHCv/ZY8ugjAANBttot26MG0hWD4MEioIkOnAep31mdRI27VUM3uCnuZBks+6sO32mBQyOqr7o8Kfazdndcy9pEIvfs2Xdk9mor5l/qjA5zuYZ5uHrGwCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345250; c=relaxed/simple;
	bh=fvWSWkspN0r01dW11uRW9rrZaNt5MJrLnva14DTCIew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E82mzOs9zbfkkAlLLOwdeqcEJegVvKIagk523nPlRK0UFBkg/5DSeKNL2aZ7U0a+qFeq6/tnXiCF9jNN2zU72+7rtny/Bm+9QenZWZM3a0LZnh3MlWp58q8MuxxxFHtu9MOlzNclk1E3BQLCr0bYu6spZ0rMOZtxYAVrFMv5Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9n1WVPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2985C19425;
	Tue, 28 Apr 2026 03:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777345249;
	bh=fvWSWkspN0r01dW11uRW9rrZaNt5MJrLnva14DTCIew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e9n1WVPl9WXwovKzv97qJSxT5tU+mBnsStu0NqLqletbC/oKMY1NCS9FdtrimarVE
	 phrGyLFd9cjrZWEBk/vgkyR48y7hKu2XuGNT9b/onGhcsplDbVYMCbB7/CX71dCkfh
	 Rx+/xJ6IP2BCkbqOIHRrtV2tlxaITRKMZ8lytCX5vMeYm2BL2V3VoICZ6IPhPK0INr
	 4bcm5rtCw0CqUnSAXtm0FWRUd6KVav1dkhRS0B42KYIrZP4zhTtMqrkowdE/7XGv7i
	 71rmg1PCa5O4rR/JXTgs4TR7Q+Nt+53ftTkD7J95BIAjkDOTtxspqnzhl9QSO3Muj7
	 ftck5e6KT49GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD5392FFDD;
	Tue, 28 Apr 2026 03:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netpoll: fix IPv6 local-address corruption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734520679.218500.4239183044375838621.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 03:00:06 +0000
References: <20260424-netpoll_fix-v1-1-3a55348c625f@debian.org>
In-Reply-To: <20260424-netpoll_fix-v1-1-3a55348c625f@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, amwang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, clm@fb.com,
 gustavold@gmail.com, kernel-team@meta.com
X-Rspamd-Queue-Id: BB9EF47CF88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,fb.com,gmail.com,meta.com];
	TAGGED_FROM(0.00)[bounces-281612-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 08:31:16 -0700 you wrote:
> netpoll_setup() decides whether to auto-populate the local source
> address by testing np->local_ip.ip, which only inspects the first 4
> bytes of the union inet_addr storage.
> 
> For an IPv6 netpoll whose caller-supplied local address has a zero
> high-32 bits (::1, ::<suffix>, IPv4-mapped ::ffff:a.b.c.d, etc.), this
> misdetects the address as unset (which they are not, but the first
> 4 bytes are empty), calls netpoll_take_ipv6() and overwrites it with
> whatever matching link-local/global address the device happens to expose
> first.
> 
> [...]

Here is the summary with links:
  - netpoll: fix IPv6 local-address corruption
    https://git.kernel.org/netdev/net/c/3bc179bc7146

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



