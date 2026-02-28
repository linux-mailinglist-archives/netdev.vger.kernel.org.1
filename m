Return-Path: <netdev+bounces-262160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD6jFmQTo2lk9gQAu9opvQ
	(envelope-from <netdev+bounces-262160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B41C4371
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6832A3053CF2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39902DEA93;
	Sat, 28 Feb 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F74WRMKM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECE2D46A9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295006; cv=none; b=ZB7ZmTXkEkf6mIxapBm4r2sFtf8I5WZGWLJPtaZoevzAh5kyEL5+tmzCf3HY4UQ0cbU7906e2zq9XUN9Qi62Isq4gw2nzxAOvxrCGN5ccy225zWqYO1IWeCdnpNP394+m22puwa4VUZn9fbVNAWQSemL9q85oDKTCiwDnApxjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295006; c=relaxed/simple;
	bh=GxayiK8hIyx6s55AdLITYfWA30aGbWBjClO5n3IxeTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOzZoXrYz8v4lF/i/jJTcdXuwWoY7kUO6E+JUETXtPigSWlAN/SNwAmBGfXMWSyswvTFlwXXvmNn4oChmqAP5n6tIReF1/8wjn4CK+CSqHf2VkGAWKqtFxUrmgrl1OwCtjwOgNdH7adUl1OG4d1BlEWOI+DNON0XqaiiUdwz61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F74WRMKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25005C116D0;
	Sat, 28 Feb 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772295006;
	bh=GxayiK8hIyx6s55AdLITYfWA30aGbWBjClO5n3IxeTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F74WRMKMXaxFFzjqs3IZRZ7EbrURzs0j9mXKCFaxftSRkcwH/yDoa5PZEv8DDjECm
	 KT3nmuekye8LsooHntoQUrbZT4Z1XfXY0GF4sV7TNS97hQCrPUX0B9qIPVzc+tdFfP
	 t3SaQsuX782lgRKUDCFYnMPbNhvCUohLIWkvqMqvPrxOYf5+084KFOtCCdTdCzAhUS
	 ilteQl4elNLix2j1JuCNHruU9sONiB5kTbyrDFG5mn6zIlBFtw1Nn8p1IFBkD6qARU
	 PLEgurknDE0bPOz3CAMzIn75ziYJI19PoH261+HOaGcGcQEbs4F9ZCILxVOvpF+y6q
	 j3tsXoPLDw+Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD3639F2021;
	Sat, 28 Feb 2026 16:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: packetdrill: remove tests for
 tcp_rcv_*big
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229500904.3006106.16909523915470798807.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 16:10:09 +0000
References: <20260227033446.2596457-1-kuba@kernel.org>
In-Reply-To: <20260227033446.2596457-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
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
	TAGGED_FROM(0.00)[bounces-262160-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC7B41C4371
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 19:34:46 -0800 you wrote:
> Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> has been reverted we need to remove the corresponding tests.
> 
> Link: https://lore.kernel.org/20260227003359.2391017-1-kuba@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/packetdrill/tcp_rcv_big_endseq.pkt    | 44 -------------------
>  .../net/packetdrill/tcp_rcv_toobig.pkt        | 33 --------------
>  2 files changed, 77 deletions(-)
>  delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
>  delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt

Here is the summary with links:
  - [net] selftests/net: packetdrill: remove tests for tcp_rcv_*big
    https://git.kernel.org/netdev/net/c/1cc93c48b5d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



