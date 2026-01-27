Return-Path: <netdev+bounces-254001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ExiMnkjeWndvgEAu9opvQ
	(envelope-from <netdev+bounces-254001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:43:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCD9A6CC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80C1301C17E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1C32E733;
	Tue, 27 Jan 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LbDx3g+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7huW96G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC123C503;
	Tue, 27 Jan 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546610; cv=none; b=p5rQD7UkWm5ahP/v0Iw0UoVI3/A6DaVEf57XQxVGs9eQpm84yO8yJ5pBmS87FGeR0b75sPbKCuQJQtNJdyyvkOT6qCYu7CZvRlxTrBih8/I36nwv7GaXdhv7w5tdNi0dTogZutwNjGcheDiw4YGiJ33tuiQXUxDgV40k4rimiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546610; c=relaxed/simple;
	bh=zfolhV9Ze02+UuPt5wWghVk9sRVd8mMoFTahMiBUxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lzxgeb4u8ZUkB+5mzFS3qzvP6y9VGnwHp4OVHb+2O65sgaTM8YMWciwYz/3jkj++aOlT2SMvGM1SJpYoeTMi7wRYFJZ+i3068pUnL4f0VY+YvEThVWBKFBzeN7pybLi/m15J2oeEG8g0wg5SEi9KUqcAnamwmINuotxIGNeNnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LbDx3g+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7huW96G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769546606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqM0U1ZHpg6/6FCY9/v7F7AqZW0Y4S7oYJKqS3Z8UY=;
	b=4LbDx3g+8h+jX9AJt6MMvJmeP76qCaXhN3d9gZJnVb3YXH1BJxfe9/87rbTpntiPt6i+Yj
	uNheZP9S6MzLe5jWzDmV3voDcOYMj5eWMUYb7YQ36a69ts+xqLCTKa02A37j+D6jjgv/HB
	gSQ6a0cEvjWgE8NrXzBCOGgimCfYSgs5tgmR/KrCrBGK/qPJ24XRIWUwHxoM8G6R/Xip2T
	Qhy/6LfIQR4UjQ1EEZIb1hWV63MWHRdkAYj2CtEw2Rx73dqbHuFR/a01rtu1A8Xu+GNFQF
	1URl2NsXAnUBOrjz21dAT6R4PDTaFGHKisLK8HuqrDMB0whc93K5LQmVR7iH5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769546606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqM0U1ZHpg6/6FCY9/v7F7AqZW0Y4S7oYJKqS3Z8UY=;
	b=C7huW96Gin8geMejn6PtonNf1Fyc6G1X7ZsjsQIB3BaG3vHdHzFBGw6jGnHOL4zlGZKonS
	bq8Z4/rz2nDr4kBA==
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
Subject: Re: [PATCH net-next v4 1/5] printk: Add execution context (task
 name/CPU) to printk_info
In-Reply-To: <20260123-nbcon-v4-1-46a5cf567926@debian.org>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
 <20260123-nbcon-v4-1-46a5cf567926@debian.org>
Date: Tue, 27 Jan 2026 21:49:25 +0106
Message-ID: <87ldhi7pn6.fsf@jogness.linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254001-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jogness.linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68CCD9A6CC
X-Rspamd-Action: no action

On 2026-01-23, Breno Leitao <leitao@debian.org> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 32fc12e536752..391a58be0c5b3 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -946,6 +946,19 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  }
>  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
>  
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> +				     struct printk_message *pmsg)
> +{
> +	wctxt->cpu = pmsg->cpu;
> +	wctxt->pid = pmsg->pid;
> +	memcpy(wctxt->comm, pmsg->comm, TASK_COMM_LEN);

Perhaps using sizeof() instead?

	memcpy(wctxt->comm, pmsg->comm, sizeof(wctxt->comm));

And adding a static assert that the sizes match?

	static_assert(sizeof(wctxt->comm) == sizeof(pmsg->comm));

> +}

[...]

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1d765ad242b82..7daaa27705339 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2131,12 +2131,37 @@ static inline void printk_delay(int level)
>  	}
>  }
>  
> +#define CALLER_ID_MASK 0x80000000
> +
>  static inline u32 printk_caller_id(void)
>  {
>  	return in_task() ? task_pid_nr(current) :
> -		0x80000000 + smp_processor_id();
> +		CALLER_ID_MASK + smp_processor_id();
> +}
> +
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +/* Store the opposite info than caller_id. */
> +static u32 printk_caller_id2(void)
> +{
> +	return !in_task() ? task_pid_nr(current) :
> +		CALLER_ID_MASK + smp_processor_id();
>  }
>  
> +static pid_t printk_info_get_pid(const struct printk_info *info)
> +{
> +	u32 caller_id = info->caller_id;
> +	u32 caller_id2 = info->caller_id2;
> +
> +	return caller_id & CALLER_ID_MASK ? caller_id2 : caller_id;
> +}
> +
> +static int printk_info_get_cpu(const struct printk_info *info)
> +{
> +	return ((info->caller_id & CALLER_ID_MASK ?
> +		 info->caller_id : info->caller_id2) & ~CALLER_ID_MASK);
> +}

It is a bit odd that printk_info_get_pid() uses local variables and
printk_info_get_cpu() does not. I could understand if things evolve that
way over time, but it is odd to use the two different styles from the
beginning.

I would prefer the local variable variant. But mostly I would prefer
that they are the same style.

> +#endif
> +
>  /**
>   * printk_parse_prefix - Parse level and control flags.
>   *
> @@ -2213,6 +2238,27 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  	return text_len;
>  }
>  
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +static void printk_store_execution_ctx(struct printk_info *info)
> +{
> +	info->caller_id2 = printk_caller_id2();
> +	get_task_comm(info->comm, current);
> +}
> +
> +static void pmsg_load_execution_ctx(struct printk_message *pmsg,
> +				    const struct printk_info *info)
> +{
> +	pmsg->cpu = printk_info_get_cpu(info);
> +	pmsg->pid = printk_info_get_pid(info);
> +	memcpy(pmsg->comm, info->comm, TASK_COMM_LEN);

Here I also suggest using sizeof() and static_assert():

	memcpy(pmsg->comm, info->comm, sizeof(pmsg->comm));
	static_assert(sizeof(pmsg->comm) == sizeof(info->comm));

John Ogness

