Return-Path: <netdev+bounces-254203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKfsKAzreWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193B9FC66
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92379301DAF9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017F33123C;
	Wed, 28 Jan 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="E9BCQzLO"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647732D45C;
	Wed, 28 Jan 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597572; cv=none; b=Dx8V12KQS3JJCPufnlpTD8C7P7HK6byWoU8ceQ9QvTUgj0megAwoRhWiWUzPY8xna/OLg0GUtWUOkUL4M3kGz/ieNfuw8dKE0Cb+2gq6bCTDGjYChhpUzBh+xd1kXGTXA3pc7ix+e7m0tlY6liauysotTM9GMo4UJbWf8WCjh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597572; c=relaxed/simple;
	bh=chFVlExx02x7eOkOc52rAKK3G+AgR3nxx/rr3P2A+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDQmrA8xjWRoQbiRMzLGojVom1KMRvTt2JKkVKeLJBPJ/604ClA3/HA5wpXyVA4rUoOpA1fM/zaFbra57J9MkaVn8ha+8ES4nJt8Asl141CE5CSHKu8Gbxfi5JPvs4e5qtUtGz43pYl89q5wXqoF3+XakREjuAo3XXWm/aMfoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=E9BCQzLO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TkMLrcCk4up3zhJI58Pdp/XlfDts76WUyYeW8kG7V2k=; b=E9BCQzLOfQCqzzVpXEWsfVE6n/
	hQKoIEVWKmXFSQyitLOtpcpkrWaa84GEj7yjpdf8x+cYG7FUM/iwG/KGmq6938EbLbkqsSWRWrcS2
	79JNrqqqkbEhyyIGhPI4IGwopDVzp38qNkXpOviNo4Ts5aVKLDQGIH4bb8oT48FQiEwMhV+pmxfMp
	lvkq36QijUtp5LHhibj5m7r8ZqB2EZXhMJ8nIOZee/F59cLkTA/ilYscMEMSvQQ3GqdDQOh6FCHoa
	L0pOz/pbR+cYNjuh5/ft22WO18vUe7FnRs6MKdjAdIMEsRauAzAGCL1kMKsRhZTNryU7FTrqpPrCY
	CU7X28Hw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl39v-00077K-7T; Wed, 28 Jan 2026 10:52:27 +0000
Date: Wed, 28 Jan 2026 02:52:21 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 1/5] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aXnp0uRXlrSMUlcH@gmail.com>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
 <20260123-nbcon-v4-1-46a5cf567926@debian.org>
 <87ldhi7pn6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldhi7pn6.fsf@jogness.linutronix.de>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254203-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2193B9FC66
X-Rspamd-Action: no action

Hello John,

On Tue, Jan 27, 2026 at 09:49:25PM +0106, John Ogness wrote:
> On 2026-01-23, Breno Leitao <leitao@debian.org> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 32fc12e536752..391a58be0c5b3 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -946,6 +946,19 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
> >  }
> >  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
> >  
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> > +				     struct printk_message *pmsg)
> > +{
> > +	wctxt->cpu = pmsg->cpu;
> > +	wctxt->pid = pmsg->pid;
> > +	memcpy(wctxt->comm, pmsg->comm, TASK_COMM_LEN);
> 
> Perhaps using sizeof() instead?
> 
> 	memcpy(wctxt->comm, pmsg->comm, sizeof(wctxt->comm));
> 
> And adding a static assert that the sizes match?
> 
> 	static_assert(sizeof(wctxt->comm) == sizeof(pmsg->comm));

Sure, I move the size from TASK_COMM_LEN to sizeof(wctxt->comm) and also
adding the build time assert.

> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 1d765ad242b82..7daaa27705339 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2131,12 +2131,37 @@ static inline void printk_delay(int level)
> >  	}
> >  }
> >  
> > +#define CALLER_ID_MASK 0x80000000
> > +
> >  static inline u32 printk_caller_id(void)
> >  {
> >  	return in_task() ? task_pid_nr(current) :
> > -		0x80000000 + smp_processor_id();
> > +		CALLER_ID_MASK + smp_processor_id();
> > +}
> > +
> > +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> > +/* Store the opposite info than caller_id. */
> > +static u32 printk_caller_id2(void)
> > +{
> > +	return !in_task() ? task_pid_nr(current) :
> > +		CALLER_ID_MASK + smp_processor_id();
> >  }
> >  
> > +static pid_t printk_info_get_pid(const struct printk_info *info)
> > +{
> > +	u32 caller_id = info->caller_id;
> > +	u32 caller_id2 = info->caller_id2;
> > +
> > +	return caller_id & CALLER_ID_MASK ? caller_id2 : caller_id;
> > +}
> > +
> > +static int printk_info_get_cpu(const struct printk_info *info)
> > +{
> > +	return ((info->caller_id & CALLER_ID_MASK ?
> > +		 info->caller_id : info->caller_id2) & ~CALLER_ID_MASK);
> > +}
> 
> It is a bit odd that printk_info_get_pid() uses local variables and
> printk_info_get_cpu() does not. I could understand if things evolve that
> way over time, but it is odd to use the two different styles from the
> beginning.
>
> I would prefer the local variable variant. But mostly I would prefer
> that they are the same style.

They evolve different, I will get both of them using local variables and
in the same style.

> > +
> > +static void pmsg_load_execution_ctx(struct printk_message *pmsg,
> > +				    const struct printk_info *info)
> > +{
> > +	pmsg->cpu = printk_info_get_cpu(info);
> > +	pmsg->pid = printk_info_get_pid(info);
> > +	memcpy(pmsg->comm, info->comm, TASK_COMM_LEN);
> 
> Here I also suggest using sizeof() and static_assert():
> 
> 	memcpy(pmsg->comm, info->comm, sizeof(pmsg->comm));
> 	static_assert(sizeof(pmsg->comm) == sizeof(info->comm));

Ack! I will respin it.

Thanks for the review,
--breno

