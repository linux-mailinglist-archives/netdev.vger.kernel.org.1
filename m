Return-Path: <netdev+bounces-299600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRMsGvpZMGoLSAUAu9opvQ
	(envelope-from <netdev+bounces-299600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC33689A42
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W2i6lVdF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299600-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE9AA307BA07
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016783793C2;
	Mon, 15 Jun 2026 20:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B329BDBB;
	Mon, 15 Jun 2026 20:00:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553621; cv=none; b=bUsn7rTZgn7mcn+Es3LPcKvAm8NWBvw7MbodTtrRWGdCgg9U4/2IL2O7oj8V3w9i2pMb/w90mgHUChnl1N3zpRN4Sg7pIDDYRYmuhJH1hbwZXv9tgS4WISLclKTfPKE8CHdsFx0wvfDpwZz6y6cdZrN1x+FBtHo9XMkQV3WaJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553621; c=relaxed/simple;
	bh=JUbRWvp9mCNkQmiuZPtvnZAI+5bA8g1SRzhoZtnhheY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4KoKi8FnmSYR1EaobkW8b95xchzlEQw05nDDaFOhn2Jx2MlEqTRZIl3HBEIjD4oubgeHRqLPNlQWGbcmUyDcJcf9mSyCvlzN1QjIn3kQZxpj0LoX5BL0oj3u7yk9yu89t9fEU8Yt2d1N71SjYrmY7AqrMah6svfAonQIMoBhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2i6lVdF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F6C1F000E9;
	Mon, 15 Jun 2026 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553620;
	bh=vsyX/OiGu7noUPnPlEtDjolBJddDnqDIcGdKM36DljU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2i6lVdFM8yjEsFy8C3V/rKUYvLjyno+v/z1WXbEPSAc20GTDNQkAttwf1Se6mSDy
	 L5ZppoZ+2+61HkaZrblkVwJTxDyeEbIFm8q31dDZx9n6y5HXBeo7qQabHF7xcRJgph
	 c2PeZvMPY8EPJsD8b9vt04clS1pFYRFbXTODT2A+R0EVp8Y+DtkuxPzhW1DzxF3tRp
	 18xVlEwqcgVpXMDQU1WcxCWnuHBfBSsSq7DUI7623RfmSHe7b63/D0VKk/T5rL0QmJ
	 dv8RJjnTDoS0ZMGOqh1Sjbdmpq38D/xibjqJ+oVpwqF3iii+AaLdqausUrLY6ujRx6
	 nePWLYFX1rtYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09853839A06;
	Mon, 15 Jun 2026 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests/vsock: improve vng version and
 quirk handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155361538.272818.12192938243650583106.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:15 +0000
References: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
In-Reply-To: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299600-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:sgarzare@redhat.com,m:shuah@kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bobbyeshleman@meta.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CC33689A42

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 12:08:40 -0700 you wrote:
> As vng has continued updating, there have been two things in our
> selftests that have been affected. One is that newer versions always
> emit the vng version warning, and two is that we have a workaround that
> is not needed in newer versions.
> 
> This series just updates the version handling to allow all newer
> versions without warning and version-gates the workaround to only those
> versions that don't have the commit that fixed the root cause.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests/vsock: accept vng 1.33 or >= 1.36
    https://git.kernel.org/netdev/net-next/c/197503d5ac82
  - [net-next,2/2] selftests/vsock: skip vng setsid workaround on >= 1.41
    https://git.kernel.org/netdev/net-next/c/9361bff6bdb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



