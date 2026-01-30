Return-Path: <netdev+bounces-255176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFEcAZHVfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:00:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B71BC53C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D3A300578A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B368734679C;
	Fri, 30 Jan 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2J8lfSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90802345CD0
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788813; cv=none; b=i4iUwBDbjURMY6nhtUU7EbR1+mMO/4b6eDVjilGVVImNbmohoneZDD+ptALzLZJR/znvfYrw9O+/dl1Nn2DtS3HR/BqLMZM5gHskRNhTNEk0enpDq/k9SmNsOJI8qbhSwY7GkICDucH2KU9f6xPtwoxLWXmXc442ytzHdZ208jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788813; c=relaxed/simple;
	bh=WBEQR1eSHavyGM0Nunn/ZfeFu0Ld4Pmzftre0Xn+HIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kCxwJ4jjxWiw7f5OU59ry5qarMWymOiy0SHsSo66VSBZpdsJGymYHYNENCc+l/gvbsUH5UKhStNW0+2aPuLn4CVQT/p5evP6WRQMsqJkmwTJwSBmmz/WcSqumnupkGZr9gkAIJhJuFAY+0LIcTYFg03s+PB8SOYb0KU8rEJnOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2J8lfSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DFFC4CEF7;
	Fri, 30 Jan 2026 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769788813;
	bh=WBEQR1eSHavyGM0Nunn/ZfeFu0Ld4Pmzftre0Xn+HIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2J8lfSe++UEa0wj79Y6tnjvStV6A1en1kB4z5mTBClPMxEFEuEGW3IntRRfpGpyA
	 Wr27YiGuCyCn0mq3FYPnXpz53AvFZ1DrpMclbYnSMa9ipUgXdobMGWelWY5n505bca
	 hpDKHPu0rgzYhWt74wTnsITeRE/oAnDNyGg2X+a6dcWB6di1cKFRSnVHelOaddvwqe
	 iFCzdj+PvSlyVWE5Q5pwpYSYJVqP9zvbyuVwa49LOgJ7jEl67mEs44alie2ZkVlmGR
	 Uu93Ky7/hCU+q+IqId1+DQOymAIQA3knv9gFLvlD+LNbxnzV5+kHvy5VflDEikBVSH
	 EVFodswxKGaFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CC7380CFD5;
	Fri, 30 Jan 2026 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 net-next] dpll: add mode setting support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176978880561.3428203.11993515800119012427.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 16:00:05 +0000
References: <20260129112849.8796-1-poros@redhat.com>
In-Reply-To: <20260129112849.8796-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 jiri@resnulli.us
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255176-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 77B71BC53C
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 29 Jan 2026 12:28:49 +0100 you wrote:
> Add ability to set DPLL device operating mode (automatic/manual)
> through "dpll device set id ID mode MODE" command.
> 
> In automatic mode, the DPLL autonomously selects the best input
> source based on priority and quality. In manual mode, the input
> source must be explicitly configured.
> 
> [...]

Here is the summary with links:
  - [iproute2,net-next] dpll: add mode setting support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=f64542add03b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



