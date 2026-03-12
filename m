Return-Path: <netdev+bounces-266828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CsPOOiQXsmloIgAAu9opvQ
	(envelope-from <netdev+bounces-266828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:30:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5026BF2B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D299E3021E6B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246C356A0A;
	Thu, 12 Mar 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvbSWxXL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B1331A5B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773279010; cv=none; b=T9dHchYI989HcTN19tsd3BmLaMxP2L4ng8DkyfM/hROpqITR43fop26dMgkE42EmXxzo5IfPGyq1d+cTpErl0gIqg6V+CWgyP3BJYD1mW5RdUbxgjW9PwUktfL7sLyMPB5gPcKA0k8FxDAR1CenJO6HnYreraynsRu4Eh4VExiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773279010; c=relaxed/simple;
	bh=JGJgw2dIydju3pw1N11eSTHHFjUzsjLO8FAaKOjR1kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIs1/stmhQO6FCvzjL0HsyNUQF2ZR4eSRqulNtKrF4KBuTZ/bawQ+2a8NyH49CP0UqMBlhKmu/RKBkIvGnUL3pnDuGqktKGiUO7h6UWTLhQ5Wn4D6fQKezSleK+H8zLEEzTLHjYpkvQWnRwhPthTvVCfF5ERheY3U9JLF8i07cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvbSWxXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A5C4CEF7;
	Thu, 12 Mar 2026 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773279009;
	bh=JGJgw2dIydju3pw1N11eSTHHFjUzsjLO8FAaKOjR1kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WvbSWxXLP7+JctLD5RDOPPmi+Qo0TjUdEWLW9HgWawcnDZXN1Xz1YnWIFp8AP4PYq
	 uV28NiKPXsDI+sdFkp31F/B3EApT6n7dG04sKcFhyMmynAu4jUqSGHBUfAd3F2eIJA
	 f8U1ANV1GzYjz1JWJhJc6RyMBNDRA3GkD2Fr5FiH+zw/wXsBp14FkYERQft+gDYHt+
	 HLqEUmh5eCYDGNk+fE0Vod7x2xWjm/bTCVHzkY96G2F0BndKWygDxx9UuBFeWdOg/M
	 stA+wRP1OkcrfDk+lBDh/eDmD0nuPoZCJkuEQQh83H1k+BE44ujrQcotoRDmvYP4dO
	 TAwgRMeqsTl7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1F63808200;
	Thu, 12 Mar 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: af_unix: validate SO_PEEK_OFF
 advancement and reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177327900555.3897363.9493224320335469172.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 01:30:05 +0000
References: <20260310072832.127848-1-the.latticeheart@gmail.com>
In-Reply-To: <20260310072832.127848-1-the.latticeheart@gmail.com>
To: Soichiro Ueda <the.latticeheart@gmail.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, shankerwangmiao@gmail.com,
 willemb@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266828-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE5026BF2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 16:28:31 +0900 you wrote:
> Extend the so_peek_off selftest to ensure the socket peek offset is handled
> correctly after both MSG_PEEK and actual data consumption.
> 
> Verify that the peek offset advances by the same amount as the number of
> bytes read when performing a read with MSG_PEEK.
> 
> After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with a
> non-peek recv() and verify that it can receive all the content in the
> buffer and SO_PEEK_OFF returns back to 0.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: af_unix: validate SO_PEEK_OFF advancement and reset
    https://git.kernel.org/netdev/net-next/c/34c0378b156f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



