Return-Path: <netdev+bounces-281571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN1bB3cG8GmoNQEAu9opvQ
	(envelope-from <netdev+bounces-281571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:59:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AC47C465
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456F7302D5F8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F6285C84;
	Tue, 28 Apr 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+vEgr6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB740DFA4;
	Tue, 28 Apr 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337972; cv=none; b=deZfe1mwacSCWVOU05JbxZlfjWQGza9rm9Ltxn2gaHxdTVA9iKNfzv1uX4QXmiE9GcxchCMvXWCc31MfYPzS+7WBkhjwiAvgz85YVzHdN9sj+oqJiCNd4CiyVycfxWCcssrZr2ZQ3sDJTe5GWZ1D++HgGEQ1aPCmry1lUPP4KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337972; c=relaxed/simple;
	bh=mjRXv6kzYdkDfMJMvOHLBH0FA+3MSBtmLLNASDy8OYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4hLiWvKDWWfNUxlRLHjcbxjOQmu30D2oSqntiLU9yayu5KkJRwCAg1oVWExj/6Y8LkszZVVKRrnavTKMv6dQxljpdP32RcCJFz2cHgPvOg+xijdGVtMrJiFfKWOjC5mGmApVYMk1ox1jXS7HG2Ahb2wQQ0Ns/JdxxmUbT6Xm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+vEgr6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0676C19425;
	Tue, 28 Apr 2026 00:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337972;
	bh=mjRXv6kzYdkDfMJMvOHLBH0FA+3MSBtmLLNASDy8OYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+vEgr6juGMgK25uV+gj3S22n3/1z61h32JhRewTolBQBBjgwC5hMsF/BLhxVEvG3
	 d5Hpnc1jVqnmTQK1wQK8vD77DNG34M75UMw3OMO5MdfTab51DynjPbJjWV1EMj4zkf
	 lUKRKvbYkDQisr3nwjdK5qOpalNLiK9XjI27OB9HO5n9hxePCE9sZmNzQKjas2TP2D
	 uobGLYGSQtDPc/gBCJCTnTi8tuCK9lEQMqbHoSYB1oVW9TrVh2vCgetkAO6Tlt2MFq
	 W8o1pjIXVwGAuBGvyuHlp0jxmItjO+3NUCsU5QDiYSC+vM4WQp9zfR5rtwJgK2ZQQA
	 WoB2jNj42AJdQ==
Date: Mon, 27 Apr 2026 17:59:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
Subject: Re: [PATCH] net: atheros: atl1e: use atomic functions with memory
 barriers for next_to_clean
Message-ID: <20260427175930.3c170c98@kernel.org>
In-Reply-To: <20260422093717.893646-1-hanguidong02@gmail.com>
References: <20260422093717.893646-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 810AC47C465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 22 Apr 2026 17:37:17 +0800 Gui-Dong Han wrote:
> Found by auditing atomic operations used for synchronization.
> A similar fix can be found in 6df8e84aa6b5.
> 
> Do not change atl1e_init_ring_ptrs(). Its atomic_set() runs during
> bring-up before NAPI and interrupts are enabled, so it is not a runtime
> publication point between Tx cleanup and Tx submission.
> 
> In my opinion, implementing ad-hoc lockless algorithms directly within
> individual drivers is highly error-prone. To avoid these subtle memory
> ordering and barrier bugs, drivers should rely on established, well-tested
> kernel libraries like kfifo to handle this type of concurrency.

I don't think this is sufficient, we can still race stop vs wake. 
Please convert the driver to use netif_txq_maybe_stop() and friends.
-- 
pw-bot: cr

