Return-Path: <netdev+bounces-251550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAJqLN2/b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:48:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CB48D35
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1A93840EBC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14919335564;
	Tue, 20 Jan 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIZqh4AO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073C31AF2D;
	Tue, 20 Jan 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926608; cv=none; b=lXJJrldp1Rexl5MaARTaGFmrFdJEYOGWyN2/T4vizVgCyroFQL1s8bzp16YSGGSUNAuBIB5QOniS5llUFVAQ0/ueGHNMA7JlBOuHUs4hwniXwk/qWd7jzgJ71KclXO1qNdDnKI66WM1RKqINGoCEWl95sSC+CoVqZHRFDBWCcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926608; c=relaxed/simple;
	bh=pBpKOZhNvenUVHqUyiVbuZTAOpSxq9FVRJcMRVLUnHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=buOaJDkg7STRmR7IcTrKVWQQUCrbzHabDRFdl6z30TAUlEylkr9cy01LYzWAhbVHhCAWmTK/uVU2RwPv6Sz1MmPnSAmESMFeh/4nzLycF1iMqafu2SrlgRNp5hXezDQaDs5wvII42ntZVDETm08EE3MTzWpZL+9LOf1JiQajznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIZqh4AO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC676C16AAE;
	Tue, 20 Jan 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926607;
	bh=pBpKOZhNvenUVHqUyiVbuZTAOpSxq9FVRJcMRVLUnHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIZqh4AOftcTdgpt6qm4QafQiTQ1cfqvoyoJG8jjO74YwWJ/zd0tm+M3/n/oBcRdj
	 IQI6SCTWKc4/z30yA9ybVUsfHaGrJptewG/371Oyv70k5Po4i5a9V7OaQDWd0RFfcU
	 Qs2DClCQKYhE8ROfCj2jjj3su4+kz3akNpcx338kpJhYgNW0sI/NJrakBiJzfTKOCN
	 YMPSvfMqcgNLz83TmhFj4TjkGeNFRL1k4wbUhp5WPJCZlHjJkUOkPMmyYeS0Abcmey
	 xlt9pOVasH1v0DP7Eb4lJPYesuVkyFXj7SgDQ16T223T7j1eTCZ1UDE8wHRgvZw134
	 o67tGiBq5RH6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B9B03806671;
	Tue, 20 Jan 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: fix a race issue related to the operation on
 bpf_bound_progs list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176892660514.117222.932562208137734331.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 16:30:05 +0000
References: <20260116095308.11441-1-luyun_611@163.com>
In-Reply-To: <20260116095308.11441-1-luyun_611@163.com>
To: Yun Lu <luyun_611@163.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251550-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 100CB48D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 16 Jan 2026 17:53:08 +0800 you wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> The netdevsim driver lacks a protection mechanism for operations on the
> bpf_bound_progs list. When the nsim_bpf_create_prog() performs
> list_add_tail, it is possible that nsim_bpf_destroy_prog() is
> simultaneously performs list_del. Concurrent operations on the list may
> lead to list corruption and trigger a kernel crash as follows:
> 
> [...]

Here is the summary with links:
  - netdevsim: fix a race issue related to the operation on bpf_bound_progs list
    https://git.kernel.org/netdev/net/c/b97d5eedf497

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



