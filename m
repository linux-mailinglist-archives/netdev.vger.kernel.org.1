Return-Path: <netdev+bounces-262161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFkvKWsTo2lk9gQAu9opvQ
	(envelope-from <netdev+bounces-262161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9C1C4378
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFD0305D4ED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3972DF3FD;
	Sat, 28 Feb 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnkVKMTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F12DF13A
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295007; cv=none; b=Gd+23jINsYpE3wluum+katZcdxdppOMFMJn4YDr6gwviRnwLMo4SP/tWWG140ACFlE/7LvKtRK5M1S2ZmZ2CVNA3ee4JZKZ4PaDLxBSnKvSuDyuZpXz0i8e5BFj/WgRk+O7FYVo+lWZjT805ZwFrlRwrNRlBqpH4m7pwxWqdiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295007; c=relaxed/simple;
	bh=3q6VnWEGpqeT1gD3SD4cpg14ng3Z83M02t3qbv3azbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FKq5BzrnE9dY4f+JEoUh1pqXGimEaSe2GTutJ6S9FkHWCI05YlpsNl9kVN7vf7NIqq5WQRSEa+O8pnIO7cv5pNLp7hquvxNUQ/GFmH6CFbeOLSswiz8g13hp/ERztBDij+7CHlIm5SQyNqGxritP8XPhzlrZENONP0VYbsEGRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnkVKMTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B06EC116D0;
	Sat, 28 Feb 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772295007;
	bh=3q6VnWEGpqeT1gD3SD4cpg14ng3Z83M02t3qbv3azbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnkVKMTkvwRApC0kdcTyLBzasY427ssupCCBAX1fIbuqSVp8exUy8ryXa+VMMHNTh
	 hqlGqxySaEMqJpyaO1qScg2dM+JHAUS47+tr8QDRep2P7fL2jtLRFTsmfeY/bIhabK
	 SEgJ/81tlj0G3Wlzastg75srVLSwBgAsPuhnLusutQ+oOqJ0CFebJX+5wuORELzAZ2
	 AWyntdVgrIbgk9ORU5dgjEnbDO+7wTv3PlByiE0IE3wydS2p0Nz8qvfJmdH8pXtEPq
	 hLHMF6vRCGC32UWmRSvUTqq3hC0PYqXG+2ToqkNLrGVsE1w3AvgOXmWYl2FqdV2ChV
	 xyTNkeKz80aFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C6A39F2021;
	Sat, 28 Feb 2026 16:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: give up on stronger sk_rcvbuf checks (for now)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229501054.3006106.4630039623073191994.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 16:10:10 +0000
References: <20260227003359.2391017-1-kuba@kernel.org>
In-Reply-To: <20260227003359.2391017-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262161-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40E9C1C4378
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 16:33:59 -0800 you wrote:
> We hit another corner case which leads to TcpExtTCPRcvQDrop
> 
> Connections which send RPCs in the 20-80kB range over loopback
> experience spurious drops. The exact conditions for most of
> the drops I investigated are that:
>  - socket exchanged >1MB of data so its not completely fresh
>  - rcvbuf is around 128kB (default, hasn't grown)
>  - there is ~60kB of data in rcvq
>  - skb > 64kB arrives
> 
> [...]

Here is the summary with links:
  - [net] tcp: give up on stronger sk_rcvbuf checks (for now)
    https://git.kernel.org/netdev/net/c/026dfef287c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



