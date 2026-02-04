Return-Path: <netdev+bounces-256871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A35FxPRg2m5ugMAu9opvQ
	(envelope-from <netdev+bounces-256871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:06:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B57ECED2A3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 00:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70AE9300917A
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 23:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B72ECE86;
	Wed,  4 Feb 2026 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O2sSR1/S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WsFvj53N"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87C7E0FF;
	Wed,  4 Feb 2026 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770246415; cv=none; b=q5Z8m3dW3qXcfb+gWiEpNUSxilEiwlbcxW2dFMqgu0I6hanmIYzuWfwL/o/X5IvBu+oZnrB5dwN52vkQmb8zmP+JFWiSydDuV5ZPVpTzNkASXsxyk4mMyibtF0haGXA5zRuxHYDbdPLnlrc01WU+0qM3tUx/eX+ZZCdywk4DSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770246415; c=relaxed/simple;
	bh=qHTZrVOA6lt1VPG6nShf3Uf1dP+eEJrxjdXR6PNSoNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSNEQ1emfbTfN6+3SVWRi6LtqVu/Mt1Rjk5aLzVY9/Ve9/MHxSEPHvn3uXS5nAcfJmJHvI/CKgedoJM8qtVMXdEyyYz4eYZrdb9cf4dF4SDcJ1jPiCWMo3rCqv8FGDLcE8spHt6at8T2afjuxblnJp2ibbHvO6hmVRmq86qtJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O2sSR1/S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WsFvj53N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770246413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpitTzrTVEv/Lc254EiSPn/Xtv+lPFW5oSP6A2bo4CU=;
	b=O2sSR1/SJAn7Q+nuvB6c5NshuUaPdLp0BdWnApRh21CTLqJ1WfzdRy0zgFEoPNJW8O8oGy
	yZ/tgkwUC2wZ0DABwQ470Izq6T1tL4i7wur6tWqCCwkqF6GSCuqBclkSdk3VkZwga6+8ck
	7rEtZcjVfX83mERB3/KhROhS9U8lIBKFnJoKTKapg/YIJgZfkibxVW+LW329rk7ejXtsR/
	uTSH+2Y3it/+XP9CHjwQscG7/nDDEVBiwT/ZgtOLh79jUKcCBYahTxh/4Frk/A/3XDTKb7
	JggNRGIouFFDdcKCeUQulxMAMGhTeT58EzmIF8wIy54SG1d1rHBCR38GFNLB8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770246413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpitTzrTVEv/Lc254EiSPn/Xtv+lPFW5oSP6A2bo4CU=;
	b=WsFvj53Nj2lRIDBhTMdAtzYmYCiGgRLuGdA0991nSsbRBDAkdtfB+6Qpf34fE3nm59/50d
	dCGC2N8KMM7VkZBA==
To: Breno Leitao <leitao@debian.org>, Breno Leitao <leitao@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v6 0/4] net: netconsole: convert to NBCON
 console infrastructure
In-Reply-To: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
References: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
Date: Thu, 05 Feb 2026 00:12:52 +0106
Message-ID: <87fr7gp0qb.fsf@jogness.linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256871-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jogness.linutronix.de:mid]
X-Rspamd-Queue-Id: B57ECED2A3
X-Rspamd-Action: no action

On 2026-02-03, Breno Leitao <leitao@debian.org> wrote:
> This series adds support for the nbcon (new buffer console) infrastructure
> to netconsole, enabling lock-free, priority-based console operations that
> are safer in crash scenarios.
>
> The implementation is introduced in three steps:
>
> 0) Extend printk to expose CPU and taskname (task->comm) where the
>    printk originated from. (Thanks John and Petr for the support in
>    getting this done)
> 1) Refactor the message fragmentation logic into a reusable helper function
> 2) Extend nbcon support to non-extended (basic) consoles using the same
>    infrastructure.
>
> The initial discussion about it appeared a while ago in [1], in order to
> solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
> cause is that some hosts were calling IRQ unsafe locks from inside console
> lock.
>
> At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
> kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
> nbcon: Allow unsafe write_atomic() for panic"), and now we can
> implement netconsole on top of nbcon.
>
> Important to note that netconsole continues to call netpoll and the
> network TX helpers with interrupt disable, given the TX are called with
> target_list_lock.
>
> Netdev maintainers, Petr suggested that this patchset goes through netdev[2]
>
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Link: https://lore.kernel.org/all/aW9D5M0o9_8hdVvt@pathway.suse.cz/ [2]
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
>
> ---
> Changes in v6:
> - Do not select PRINTK_EXECUTION_CTX in NETCONSOLE_DYNAMIC (Jakub)
> - Do not make PRINTK_EXECUTION_CTX user visible (Jakub)

I am really sorry, but I failed to communicate what I meant about
introducing the CONSOLE_HAS_EXECUTION_CTX symbol.

As Jakub mentioned, NETCONSOLE_DYNAMIC should just directly select
PRINTK_EXECUTION_CTX and get rid of the CONSOLE_HAS_EXECUTION_CTX symbol
(like you had in v1).

I apologize for the confusion and wasted effort here.

John

