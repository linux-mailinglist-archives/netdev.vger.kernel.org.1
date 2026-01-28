Return-Path: <netdev+bounces-254308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OX+M2cjemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8CA3530
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E093069A0A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41C2DFF19;
	Wed, 28 Jan 2026 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bm7geCmB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUbDdIBQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577E291C10;
	Wed, 28 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611769; cv=none; b=EbbUHg/IHUXL9H9n2jBuwYyDu5V6n+bLcsO2MWcAXNfaWAZNwO1b5kQSujhHxU7+ECU5B2oJ7oYM2uLqbuMP+Axl+3EBkeUtyRbtlU+2IXOC23oX1tSvaU5yPxo5G3mqJH3FQFmq2oeZkD3MlXd0iBQxUsdrziArtdZLTgQrpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611769; c=relaxed/simple;
	bh=Hl7r5ottBqn33zr/iQl/s1av+yp/dTMhuQMXmo41TKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Py4k86TZQHk0ZnsSvOdfMCd+IB63ZEz9BWns+5PrOlUMaIqt+iu5Y/R0IEIibtmK4ENIAD03jziZXEWZ8xcj4BEtQ/Eo4hBV8OYFKXoCsT8SUW0QGfC4AuTrVGLumbkXTfAeIvt55VqRw6skPS3ts8DXJIomoyBt47TH8iKbw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bm7geCmB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUbDdIBQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769611765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/vWGICoApFxtNEDE/sAHqakShwhJUuziA/CPjsJAHY=;
	b=Bm7geCmBy7EUBx6Vi917C27yI2OyhB6AkK01DNF6e1IOMM1VU91yy+feIrJUJaANmEDoIa
	Qalsd6pvLGBijJwXlksl4c6BXf3gViwMY3I0M4/jfFIUpBIjWM5ASZlQQBuuhodNUA67XL
	CGIgzNzBbY1iuNgZgs11uye0Yb7GoVxznF9RufYt1P7yPyF/fJ3z/Xqlenow9353VbNv/D
	Fz42M9QHjfxTsbjhlOwWRpG3qR2kvEnJ2MskTuRI/7Cib/oP7VYA780WZWou8vHHKiZfPg
	vjfbP0+oxRPv6Z6L77d1lYqvN8BuwcBQhNngTXfJjIVJDQGUfO7kZWzLyAd5jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769611765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/vWGICoApFxtNEDE/sAHqakShwhJUuziA/CPjsJAHY=;
	b=hUbDdIBQDUCgQmGAk6GekfwdWIT1d/SFeV2Hu+axTwqkzNTmsIa/Wer6ePQaqpo7if5qvC
	ebQNXeatN0OHcqAQ==
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
Subject: Re: [PATCH net-next v5 3/4] netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-3-93b4ddbc181a@debian.org>
Date: Wed, 28 Jan 2026 15:55:24 +0106
Message-ID: <87cy2tlrm3.fsf@jogness.linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254308-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,jogness.linutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65A8CA3530
X-Rspamd-Action: no action

On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> Convert netconsole from the legacy console API to the NBCON framework.
> NBCON provides threaded printing which unblocks printk()s and flushes in
> a thread, decoupling network TX from printk() when netconsole is
> in use.
>
> Since netconsole relies on the network stack which cannot safely operate
> from all atomic contexts, mark both consoles with
> CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
>
> CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> scenarios (panic) where regular messages are sent in threaded mode.
>
> Implementation changes:
> - Unify write_ext_msg() and write_msg() into netconsole_write()
> - Add device_lock/device_unlock callbacks to manage target_list_lock
> - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
>   operations.
>   - If nbcon_enter_unsafe() fails, just return given netconsole lost
>     the ownership of the console.
> - Set write_thread and write_atomic callbacks (both use same function)
>
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

