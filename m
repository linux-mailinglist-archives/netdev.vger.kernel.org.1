Return-Path: <netdev+bounces-306091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rR1/E0FhT2oyfgIAu9opvQ
	(envelope-from <netdev+bounces-306091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:52:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E672E7FA
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:52:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CPYldHE4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306091-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306091-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22CA630542F7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DEA3F6C57;
	Thu,  9 Jul 2026 08:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FB3F6C32;
	Thu,  9 Jul 2026 08:40:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586434; cv=none; b=aZCQIaMlnaDnYORTwU+qSxkPoTo8GioW6zzquWP41jNomumuHeHgsk29G2J/SJsWgAkfhtBII5dRITeBdk0N4pRTaQf6IFSzdsYFMMUs9he7gywEL9Hxmo+8Y6DqsQ7dAdQEZ6uZ3T5zE+/Up7nc0m6lqI44gp+qstJV5nO7TVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586434; c=relaxed/simple;
	bh=ETuA8VW3hTxL5w4NaDBV1bU9lPayE84dzg0mtfkMLK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n8+SSyi2T2t6hoMzcIHM8k3gtMa00XVdWkY1UEIUB5Z/ajPyubyj6wfo0tS2Odhg30z/sZQ86ooyM8bmZCYxxIj2XLggZxKiYNDlQrezLkJAxp7Qbi7aI6yVaB4cAzpZUo8sbjPPHyc9+yanAp/Ux9dVUrRHk2AoGGyBePIvS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPYldHE4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D69B1F000E9;
	Thu,  9 Jul 2026 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586431;
	bh=lH9L+vJg/gKOgKVB5afFmv5NL59t/JV2/rahj760Qz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CPYldHE4wVmWhpq5ofhvsRGZwvlRWlSWuwZifDjkRc5Vt9WhduA603gmd9ab3F/uA
	 AeNbfUgjcimT7YAnqHh15oKbH9orTJ/60kERIPczBRImS6q171vabaB21bYeyQDTZV
	 HU/5t+t++LnSI/hgISymAD8q7PNYwZCmBUV8Dbqj9AvWppWG134nlLagJTVtGqkUtX
	 iQQH5rYhfDtblr1qGEwKt+QOaFPJIQCTn1Zib8u7PNdLOWVTJwJwn6azqhoq/7HDzl
	 iq73nYVpEZh0T1toAWYwACJ2Wx2FRsRmna993ikz/4UQE+ppZ4Rz58pnRAqmrorxP8
	 ivUxhUEpKmPZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697B3939F13;
	Thu,  9 Jul 2026 08:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: fix EVP_MD_CTX leak in tcp_mmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358641014.3333608.13910365421023945649.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 08:40:10 +0000
References: <20260702025949.442523-1-wangyan01@kylinos.cn>
In-Reply-To: <20260702025949.442523-1-wangyan01@kylinos.cn>
To: Wang Yan <wangyan01@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, lixiaoyan@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306091-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:wangyan01@kylinos.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:lixiaoyan@google.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364E672E7FA

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 10:59:49 +0800 you wrote:
> In tcp_mmap.c, both child_thread() and main() allocate an EVP_MD_CTX
> via EVP_MD_CTX_new() when integrity checking is enabled, but neither
> function releases the context.  child_thread() misses the free in its
> common cleanup block, and main() returns without freeing the context.
> 
> This results in a SHA256 context leak on every run that uses the
> ‑i (integrity) option.  Add the missing EVP_MD_CTX_free() calls to
> the appropriate cleanup paths to fix the leak.
> 
> [...]

Here is the summary with links:
  - selftests/net: fix EVP_MD_CTX leak in tcp_mmap
    https://git.kernel.org/netdev/net/c/f4ef35efbb49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



