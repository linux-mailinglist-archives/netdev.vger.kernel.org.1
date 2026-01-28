Return-Path: <netdev+bounces-254301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHjlApAhemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:47:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0CA317E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667D4303FF01
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB323360752;
	Wed, 28 Jan 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2nZnemG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4A8E+wf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B7256C84;
	Wed, 28 Jan 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611340; cv=none; b=F460L6uyC1Pr7bIVLZv1ah7hYH9iRb6n/Qnpvsz7LsmY4FKYRCOTMWobFbBI4CLz6tDmDsLCxjiMU/GhoCS0B0gcMw0RiURMzPHYFpG06Tr+3ZIDGTsN+3HDUFbAspHVk5laGfBrhe7mJnJvnlwt+U6C4vW6hJyMUteKyEKDz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611340; c=relaxed/simple;
	bh=xSjS2RKpoVgS/10b893h19VYCPQFY/jVY+kvb7CcMhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tohOJBbAKb9A4mzE6gXDzrymBNT6ZPESu3piApngVz4Hw4RzEG1T4vnGDn70Rf0nW08aMxUBBPUmved+A2OamFvUFMfiU0fY8d1qDj1GrHM9pslMZkMl3zXkPmvnIchaA8o1VRHq3ORlYzwRcFgwkfbPb7VIbrgxgI7t+rFkvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d2nZnemG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4A8E+wf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769611337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSjS2RKpoVgS/10b893h19VYCPQFY/jVY+kvb7CcMhQ=;
	b=d2nZnemGWw8GrootCvxx9xk10RJBVsu8sYEnrqqyOQbMncwgopjIRK9SdygTVNWguFDW4B
	O4AOPILYd0rhVJGKADcoa38uAAPApB+6m5B1Lt8M+ybDumnS5+FLs1WVGJ3gmmTjB3jjwl
	zUITRaAM5+4da6vS9M0i9FrjyE529wcbGySrJhbPzXIH6XewJe9y1+69COXbFg1YPIeqcN
	urhk98TWXOre5fKTzLe2UKKgkSlwwYuJHNS6MiXF+CmCAcVFawVSjB+OGZE8gB24FA6EY8
	nsS3gAa3+WtMbr0ubSEQfAjGY+Lr4aE4cZnTvgmgpNvJc3A/DLSiQfS+BHwIqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769611337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSjS2RKpoVgS/10b893h19VYCPQFY/jVY+kvb7CcMhQ=;
	b=M4A8E+wfBy9Eyiq3lK/btWOUYH45dCwKUBzh0d7Erhvno3SuHTdftdjch84PTo8b9nfmrD
	Zh2gW0uosD0f27Dg==
To: Breno Leitao <leitao@debian.org>, Breno Leitao <leitao@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
In-Reply-To: <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
Date: Wed, 28 Jan 2026 15:48:16 +0106
Message-ID: <87ikcllrxz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254301-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,linutronix.de:email,linutronix.de:dkim,jogness.linutronix.de:mid]
X-Rspamd-Queue-Id: 5FB0CA317E
X-Rspamd-Action: no action

On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
>
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
>
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks!

