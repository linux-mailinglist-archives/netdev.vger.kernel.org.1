Return-Path: <netdev+bounces-283090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JN7NHIq9GlA+wEAu9opvQ
	(envelope-from <netdev+bounces-283090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 06:22:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 401064AA489
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 06:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75332306B2F8
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 04:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC32EAB82;
	Fri,  1 May 2026 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk2aFRkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69A2E1EF4
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608670; cv=none; b=kGvETu7bc0EqcpfwSre2+hRN0IKiOwJ84ljNCqHhHV6olD2o4KLzLZIsUpXO2Xv9YGCdxnQNw0LkCffBlrAPlZ+xeVVbHVzOuN8gnZmA/W4Fx7LCimS/ZMMEfcQ3Q/z0iWoe64/81++ThFMp7C1kHspK0lmKXEcZAL2Ueq2BMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608670; c=relaxed/simple;
	bh=Esgb5YAbr01j/5twgCOPo1q8rha+5krwko0H5Lxmk7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocAAIW7yiInPLAWy4HZFp1ypKY2dSkmD1jOuj46MxQLcmkhn21q676Vn2TiPyJ56cWxqSLNE8Gv3caoSaF+mGjnjFxuSuy9y9LL7LFvcGoYqFBpDLGeyHcq9lth9vD0PFHJ4tpNERge6AtP8RVsL/igMr/HwVjNORDOiJ+HY7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk2aFRkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCEFC4AF0F;
	Fri,  1 May 2026 04:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608670;
	bh=Esgb5YAbr01j/5twgCOPo1q8rha+5krwko0H5Lxmk7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fk2aFRkW22XNuXoFS9OXTftLneU+UD7bppBNvYWCAqQQWuqiVHxhJqHu1RO/K/qkf
	 T6+PgSkqe94Ob9fXYFPWBF2TSz8rHuuKW7vlN0lni29vaLkDjjid1g8ir8Gmojy/eA
	 fJvaG4UYKw4e60Vi0NzM8LbJKXV4+NWmOK8yynH/pIsRkbYS/+8z9kH0kQMf+4qerG
	 XIkb4/xZLqQpo7iScza8gPVI8Uk2sT+mC0axT0l9HRMtpSvKnlSIDLV2GRG80EtL2c
	 gsl9XmicdC8lwuMG0M+s6PCybbD7BnpFpMn3jr61BaIl8A8MD+BgMxFod5/6Of2BeM
	 2HY3yXco9b6OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD80380AA66;
	Fri,  1 May 2026 04:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] selftests/net: packetdrill: add
 tcp_syncookies_ip[46]_9k
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177760862404.3319327.13328140666308697645.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 04:10:24 +0000
References: <20260430021444.2929534-1-edumazet@google.com>
In-Reply-To: <20260430021444.2929534-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 401064AA489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283090-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 02:14:44 +0000 you wrote:
> These tests check syncookie mode is able to reconstruct some
> client options when TCP TS are used:
> 
> - wscale option.
> - sackOK.
> - MSS (in a limited way, especially for IPv4).
> - ECN : not enabled.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] selftests/net: packetdrill: add tcp_syncookies_ip[46]_9k
    https://git.kernel.org/netdev/net-next/c/bc6a9b667f9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



