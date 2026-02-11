Return-Path: <netdev+bounces-258252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MpcCOFXjGm9lQAAu9opvQ
	(envelope-from <netdev+bounces-258252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A0123434
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8437630055D2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC367F37;
	Wed, 11 Feb 2026 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bekD7L3R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A933120D;
	Wed, 11 Feb 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805210; cv=none; b=NwJijr968B4IRerWGG2wK+uRborHrrsK92l772qj+B/hRr3LFcIBPKdcLuOBNavXdhaxNmPHsPYn9n76vPrdKlQRyR0A03ui4emWnIHlEE6LAA2pdsFBCz4oIIKZEU/hAypoTzapW7IjjgG1w1LVAKhjG/PVgWaZRMxeKFl6XJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805210; c=relaxed/simple;
	bh=tigK3WjfnGAezt46CWIc99ueCYXkiaw1F0UQOfpMvc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rlMfOS1pM9kAVB0NIgI0O02dM6SkW3ws7aIVM7CyKrszVEXCf0o8q6td6n2gZ+zX8WxGedoP/q43THGE3UIPL/XO0jnx7n2bqxY7Mte/lDn7woR4g+5WPfMqLUnZLQMX3RbvcOTtVQoJmLMLgYfrJ0nX86cClCLSWahYzVi5H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bekD7L3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6443DC4CEF7;
	Wed, 11 Feb 2026 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770805209;
	bh=tigK3WjfnGAezt46CWIc99ueCYXkiaw1F0UQOfpMvc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bekD7L3RMXMAgs5CHViWy6+fJB4zWh+qiU0XdBxO13tR9nMoO6Jkl0tTSsGV/JbS4
	 tdnpzWfEQr4mlupl/aUtq2laKrlCzEpj+oPY8jsgLjiwndiXCvD9mWsezBJPd5jtTU
	 ssqdfgdeRq8rXn+Drq1X5fAeNPqZi6TMuYCpdxFzhmqahVPzvZ3hyp75q0CB9X6Xbf
	 91NHvZeWG6SByuMeLgQEuHlss1PpCFtpyRUm5kKaQkvoNVYKWHuYs3E/DmoMI69OPH
	 +Po9uUkzBV6etERyr2hgePDLcbyj4KMPbbTGhXMCzytIIKrxjp6okkmlsoAgrd08r6
	 KTWAG81Hjd3wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8530439E9607;
	Wed, 11 Feb 2026 10:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drivers: net: hw: Modify toeplitz.c
 to
 poll for packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177080520433.111319.12570283784652241957.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 10:20:04 +0000
References: <20260207013018.551347-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260207013018.551347-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, andrew+netdev@lunn.ch,
 willemb@google.com, petrm@nvidia.com, gal@nvidia.com, noren@nvidia.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258252-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 275A0123434
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 17:30:18 -0800 you wrote:
> Prior to this the receiver would sleep for the configured timeout,
> then attempt to receive as many packets as possible. This would result
> in a large burst of packets, and we don't necessarily need that many samples.
> 
> The tests now run faster.
> 
> Before
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drivers: net: hw: Modify toeplitz.c to poll for packets
    https://git.kernel.org/netdev/net-next/c/ccb327266698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



