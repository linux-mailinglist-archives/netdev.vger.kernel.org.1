Return-Path: <netdev+bounces-292911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDACI8jiGGo0oggAu9opvQ
	(envelope-from <netdev+bounces-292911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA65FBC3C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71CE7301FB17
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFF1B4F0A;
	Fri, 29 May 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQS7G9qG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C7EC2EA;
	Fri, 29 May 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015808; cv=none; b=K8AvdPPzfFd3BRL5MZ8/UcGdWnJALHw2cNcOFhKLIaEfJqUfbRlsY/3M5oZN3loscd8ic0GKyFnXqNKX3QZyeym/wWB47nV5SPFAbDtEPQ3Fkghv45Lwm1eSEtTVUUcF9v+AdGgeHIlOVIbgEULmlOTR1e8X3wD2GrIT7dhoGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015808; c=relaxed/simple;
	bh=hIWLlnzV0lM+MVRFowSZ2kp+dkzlKkdfgrjXOerTqYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NsrRbKHlM8vTPZ/7i13PYA0WtYNsE2+O/YQpobPwxxKCFCz7ezPwnbEYZh3P2XouysRe9Lp+H32wGwHf04Ed8OosnrIhwU8BVpi5BO82QIF8UBHDQXpLlFvi32R3WambTnfNyVtk1/b1W0VvdPa64Xy/SxXrF2z6ENQP8HQEaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQS7G9qG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F71F000E9;
	Fri, 29 May 2026 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015807;
	bh=9c1Jg7Sy66lUkriJqX6233T9AcnGFds8CGU3Ig0aH/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eQS7G9qGUxFCVWWZ05cA6kxadrGe3bSyKQ5tUF9jbePbx4peSYEJ19Unpsb+3XhNt
	 J47i5O0BYlGU/6EdTLsFRLbcIU5urB9U1CY5ME9sEhbAt5WsYGc6WPHqagLbqfnERE
	 6lWcbMpuGk9YA/TnZkmR0moBzyYc5Ib9J0WoZTqFqyn9XVgYmolovkzqmjuqjT7ZY4
	 /PkyzG1ArCwzT3lxD04uL2lZ54ra1IjQNQ6FtBvsmbjjTxzgu3c3p05Y+K7vOrPqx/
	 2XD7CgXdEjijPhbBfxSj4PfKztlCGYMc/vyEo2/yG+p5907Z1/rxRHSJj1ah/64fNJ
	 cuOu0xfy6PEjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C3A381197C;
	Fri, 29 May 2026 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] Remove unused support for crypto tfm cloning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001581139.1574269.16262378108123076484.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 00:50:11 +0000
References: <20260522053028.91165-1-ebiggers@kernel.org>
In-Reply-To: <20260522053028.91165-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ardb@kernel.org, Jason@zx2c4.com,
 herbert@gondor.apana.org.au, 0x7f454c46@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	TAGGED_FROM(0.00)[bounces-292911-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87FA65FBC3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 00:30:22 -0500 you wrote:
> This series is targeting net-next because it depends on
> "net/tcp: Remove tcp_sigpool".  So far no commits in cryptodev conflict
> with this, so I suggest that this be taken through net-next for 7.2.
> 
> This series removes support for transformation cloning from the crypto
> API.  Now that the TCP-AO and TCP-MD5 code no longer uses it, it no
> longer has a user.  And it's unlikely that a new one will appear, as the
> library API solves the problem in a much simpler and more efficient way.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] crypto: hash - Remove support for cloning hash tfms
    https://git.kernel.org/netdev/net-next/c/f331c7be97ce
  - [net-next,2/6] crypto: cipher - Remove crypto_clone_cipher()
    https://git.kernel.org/netdev/net-next/c/cb2e6e86ceb5
  - [net-next,3/6] crypto: api - Remove crypto_clone_tfm()
    https://git.kernel.org/netdev/net-next/c/590a46c68a7b
  - [net-next,4/6] crypto: api - Remove per-tfm refcount
    https://git.kernel.org/netdev/net-next/c/3065170bfc7f
  - [net-next,5/6] crypto: api - Fold __crypto_alloc_tfmgfp() into __crypto_alloc_tfm()
    https://git.kernel.org/netdev/net-next/c/9d58d14e3a18
  - [net-next,6/6] crypto: api - Fold crypto_alloc_tfmmem() into crypto_create_tfm_node()
    https://git.kernel.org/netdev/net-next/c/0200de9d75b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



