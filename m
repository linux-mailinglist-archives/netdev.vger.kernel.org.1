Return-Path: <netdev+bounces-293979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE5bBelEHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C6627651
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00554303895A
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CB366052;
	Tue,  2 Jun 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9UgPZW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009C35E1D5;
	Tue,  2 Jun 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368611; cv=none; b=k8yGef/ghhrLikW0HcDU2LDo7MvbUt9XUdEdejj/f3MiDfI+gLSBVn8MBhpHjia292cwB9aXlY6Ci3uMQ6xyBh+KOZGSEM2kYDpg5nAr5vL/IN8EpwgS4ndRpa267KaYLvticV55fEo1MrFQhVtJ4NgwCtzZJaiEWLNCJ0ar1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368611; c=relaxed/simple;
	bh=SwsrFzqZLOp8SkAXdMJYimquNeJndoo3uYyRhSNO3pA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s4jfVDU54IGFlBfmmdux4NHTqUEPQ5665ChHBcGwld6fdmTo+dQykw1wDJwAPIDjW2Sd4c7Aypr9hDwde1yxYHR/Fh84Kd0MGvoJ/TgmO76irhsmOlAS+f5DyBNp9uqn50Ytbxp6u135bWyyNtJwiz3MkKDyO8wDtQSf7LNL+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9UgPZW+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B511F00893;
	Tue,  2 Jun 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368610;
	bh=7d+C/1l5yiCLviaXUXmvpBAHA/kDPfFADcITacE0XOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W9UgPZW+DJDuCdj0jCDfa1M4RTNDWKaKTU2IU8BfdoxkBczWJbtUXp6OAoxayYB88
	 SXP9yjJRip/DygQF+3Gmgs+UXbtFvxR+ZZiZRMNUUama0twWoTRsxmpIdUXQcxe/E8
	 QhouIzQ9SH1yllAw8dxaQag9P0DBD88vfyPKO8yvgCFecI4RFmsAbPYLa5s+6de0rN
	 I9xl+Yr2mDiGS1ibwETk04z3T4SNd66ak8UUzm/XSl+1opyj+LWQLG32etH68bEA88
	 WjQ3k0SWnRS6rxMZozG1+bzcRNZp0Z0WqUfAmK2xk1Q3Ro+NosvLmsPJ69ryFFFesg
	 MX3H7YbpFN/iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A8538119F9;
	Tue,  2 Jun 2026 02:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] l2tp: pppol2tp: hold reference to session in
 pppol2tp_ioctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036861290.217677.5272140952130981669.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:50:12 +0000
References: <20260527133630.2120612-1-lee@kernel.org>
In-Reply-To: <20260527133630.2120612-1-lee@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-293979-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F3C6627651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 13:36:29 +0000 you wrote:
> pppol2tp_ioctl() read sock->sk->sk_user_data directly without any
> locks or reference counting.  If a controllable sleep was induced during
> copy_from_user() (e.g. via a userfaultfd page fault sleep), a concurrent
> socket close could trigger pppol2tp_session_close() asynchronously.  This
> frees the l2tp_session structure via the l2tp_session_del_work workqueue.
> Upon resuming, the ioctl thread dereferences the stale session pointer,
> resulting in a Use-After-Free (UAF).
> 
> [...]

Here is the summary with links:
  - [v2,1/1] l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()
    https://git.kernel.org/netdev/net/c/a213a8950414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



