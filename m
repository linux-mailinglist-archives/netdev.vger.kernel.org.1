Return-Path: <netdev+bounces-277474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKC5Mgoh2WkqmggAu9opvQ
	(envelope-from <netdev+bounces-277474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:10:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CB3DA248
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 228833065F2B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB843D9DA6;
	Fri, 10 Apr 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHDtyQ/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984023A75B9;
	Fri, 10 Apr 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837214; cv=none; b=EMTTvqR55zLsdzuvDDsLx1k73ZqhNco5oxzySBHxwa6c0U3vnvG7fstb5ah1N9PKC0Tvmbzzm3ZEQ9lSwiBQ0/KUWyIbQMsgCPk5A03A+9PmoevHhUyuY2hikarseYkCZCSBc0eIdX7Y7++/HkJB2NIqitodKio0mgtGOnyUGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837214; c=relaxed/simple;
	bh=stKy9slr3lkPEQ1A/Q6Rgj7jaZIOtw21hspJzW47mxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bljx9XjAvQiysmbktnQDkgZzDaTbJGOMdBOz8i3JWddN14rIzDSYqCyTJvAeZtjZcUsvIJR6s7CNlQI0HrFM5/veauZHMzhnFkicG23ssWoFlbg615qjyNsx9xRs9AVrMg1qZIznTJf9tXpXTv/9zZuAcon2mTyiz6+7vsDr6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHDtyQ/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F32C2BCAF;
	Fri, 10 Apr 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837214;
	bh=stKy9slr3lkPEQ1A/Q6Rgj7jaZIOtw21hspJzW47mxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lHDtyQ/L+xgRTtn+8aO/MCqaGDDcD5stgz8ms1s/y9aqtYHMjv4bGhZaON2T0Ftbv
	 6XZgQK1MmyhoaPkq4AXJv/j7iKYR8HLSXtPo5vPH4akQy9gAzfFf7RtGvZbsMBF2Qm
	 k+yNMXJx440EZyFKpdGjmCJwCAWuoZKXLg7FxGQy775N42a2L6uZkSGvgu462/99Px
	 RldY6HO0HxOg/ULp6kxqIuM5R+8TW0q+K+IPEZUaQ/oGO/vSCmu0AO7XDejPEtwDUS
	 b1SePi0QkEg6Zh05oaCQ+onyPCy0N43dX7yL03vV14lMPCuXSd4tBTMn9FKM0c3Qru
	 m2/JuFSMG6ytw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8B3809A87;
	Fri, 10 Apr 2026 16:06:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-19
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583718847.2534919.3143022997633844613.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:28 +0000
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
In-Reply-To: <20260319190455.135302-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277474-lists,netdev=lfdr.de,bluetooth];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: C88CB3DA248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 15:04:55 -0400 you wrote:
> The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:
> 
>   MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-19
    https://git.kernel.org/bluetooth/bluetooth-next/c/57ce3b2e9cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



