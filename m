Return-Path: <netdev+bounces-264476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPgzDl6pqWlSBwEAu9opvQ
	(envelope-from <netdev+bounces-264476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:03:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A821516A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B903181A58
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6E93CB2D5;
	Thu,  5 Mar 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebPkEgOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D533CA4B5;
	Thu,  5 Mar 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726427; cv=none; b=WTkewScqCbyB8VHJe3IxvwBYMqhvBcT3vKr3SvfQFHgdJasEyTRxEbqzkcpnPefBfJjyBk2iKO5T9p6eczpEPaN1GzTUovcLORyOYk9Te3VXHo+g93rZOZogs5aE5F75JGBzuvaLLplN+h2LbVeTvDxgghpRGZs1Bk3ibympEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726427; c=relaxed/simple;
	bh=aBWdHnhDPChon7I8X1u8ZsJjI21vjLkkpTthPn73wcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cf7p58KUqu2Ql9zVbQk4dRo5/uTc+AZe+MJqDN8e6bJ6e3csW9GMEV1bW2oLtDbt1Qvz0kBa+bpcm07Sz0qklptC5/WIQRD1om+9JBM9A06OV6SjvQBA2CZuQNZE0aGSyIWGZ/w01iLzUkCpXBQZ8OVc8pAw3DQFS/70+liX0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebPkEgOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF1C116C6;
	Thu,  5 Mar 2026 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772726427;
	bh=aBWdHnhDPChon7I8X1u8ZsJjI21vjLkkpTthPn73wcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebPkEgOEaxLwhX8/1yRPhoD1tk+ECrZW+uQ8lyznY0KAAai9mzo8vDZXbu/u4HR5L
	 7XzD00pHI4M+UsyKxllyauEflE7E/NFhKrAIW6maqXPJ9amwgM7VsP1PbThr/pj6h0
	 H4alW/v9FMp8xEom5ZkHtf0OjDdi67SJfXbRsoD2EdzbcaOaBYS/KGx16k2X09TDq6
	 nXbwQh1gpJ3RiNyskaxx4/DF0BmMIVOpCrTrOOYE50d6HZK2r2e5TCVH8blG6TNHRN
	 OP53NAlRELPioZQt8ILNBVhRir3xsnTAMWn+ogFrnG1rnUG5YHwDLcDZk9Rpxrl4fT
	 3tb8KaCHawxAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE9E3808200;
	Thu,  5 Mar 2026 16:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 v3 1/2] selftests/harness: order TEST_F and XFAIL_ADD
 constructors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272642704.3184289.3763404212538394213.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 16:00:27 +0000
References: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: shuah@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
X-Rspamd-Queue-Id: CD1A821516A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264476-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 19:14:50 +0800 you wrote:
> TEST_F() allocates and registers its struct __test_metadata via mmap()
> inside its constructor, and only then assigns the
> _##fixture_##test##_object pointer.
> 
> XFAIL_ADD() runs in a constructor too and reads
> _##fixture_##test##_object to initialize xfail->test. If XFAIL_ADD runs
> first, xfail->test can be NULL and the expected failure will be reported
> as FAIL.
> 
> [...]

Here is the summary with links:
  - [v3,v3,1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
    https://git.kernel.org/netdev/net/c/6be268151426
  - [v3,v3,2/2] selftests: net: tun: don't abort XFAIL cases
    https://git.kernel.org/netdev/net/c/c952291593e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



