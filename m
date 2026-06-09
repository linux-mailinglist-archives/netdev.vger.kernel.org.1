Return-Path: <netdev+bounces-297010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yN7GC6nvJ2px5wIAu9opvQ
	(envelope-from <netdev+bounces-297010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F465F1D9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:49:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="cJD15e/8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297010-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D2730B877F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AF3F9278;
	Tue,  9 Jun 2026 10:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2713AFB0E;
	Tue,  9 Jun 2026 10:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001009; cv=none; b=SSauT5dOW/FzRljmYOjdPExz2WVeqISHPBFRQ1JW+k4Z831PbD4AC0Aqu66/DA7vy/PhGqoYvv2pQpJRUs0GhAE76vgnW7PvSJlDe2+W9z3aPsKpD7bDnoq8AD8n06MztmOkbi+bQNDhKrnZgGVNhlFWk3K9J/F/W12SI+dhicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001009; c=relaxed/simple;
	bh=5X90vzjoFVx/DHR4QVYw693XU0Df6dN04GF/l0d9KDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cTz2xkSPDNNackFg3QMwa119QzeZWeXqILpZed2gs3SwmR7SoUtxLawa8JD5cuMpD3e0JQQ5e8/OVa7km+7p3SjaUvu4FZdmhioZ/3zzpVdzOFhyhO/YAZKfmlt/8tSsvNFo9vq4yaGRtnBUCGKScj2bUhOLR2d86/irHcQDlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJD15e/8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613871F00893;
	Tue,  9 Jun 2026 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001008;
	bh=tlwk11Uh7KejjBX0N7t+TfseoQWN+UjBMZ2CUOeuEyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cJD15e/864MgO94DHr/MY9qwtTitY4KDiUZoj99SrSwKykmorrIVIitM7f5TJtFnL
	 hQUuc+ijB1Dr5zwyVDeKn+FI34vR4YoIvtfxKflA6RrNJE03y2kGYnm3JS4P96ZjrD
	 sfuxkWfHqOlMegffKtpC3nWXOjSGO5lOhru97pqUVVtKG+brV9zbhyGHnT+ZI7QfI4
	 VyhU932Z4VVqJEYfGXO+osRFGgnRWD7daWqUIwuuUUujBgh4IfoZyFaow0kq29/9rz
	 xtP9KhMT+B+uUpeG5rH7bg5HDU1ie6JyQpcheWybjb/VOpT1rj24EUMT7p3Pd38SyC
	 SypigNT7mW0gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197CE39307B5;
	Tue,  9 Jun 2026 10:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: gro: signal over-coalescing
 more
 reliably
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100100665.1941629.1409035118702282770.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:30:06 +0000
References: <20260607002401.212976-1-kuba@kernel.org>
In-Reply-To: <20260607002401.212976-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297010-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A4F465F1D9

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  6 Jun 2026 17:24:01 -0700 you wrote:
> GRO test is very timing-sensitive, packets may be delayed
> by the network or just sent slowly. Because of this we retry
> each test case up to 6 times.
> 
> This makes perfect sense for positive cases, in which we want
> to see coalescing. Negative test cases, which modify headers
> and expect no coalescing should have opposite treatment.
> We should really try 6 times and make sure that each time
> the test failed. This would, however, require that we annotate
> each test to indicate whether its positive or negative.
> Let's start with a simpler improvement. Do not allow
> retries if we detected over-coalescing. Previously the negative
> case would have to get lucky at least once in 6 tries to pass.
> Now the first failure breaks the retry loop.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: gro: signal over-coalescing more reliably
    https://git.kernel.org/netdev/net-next/c/69a4e74e4cc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



