Return-Path: <netdev+bounces-248173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E070D04BD9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 601343044DB2
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948902DC32D;
	Thu,  8 Jan 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cd7wCeCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNRJcD03"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09211A9F94;
	Thu,  8 Jan 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891055; cv=none; b=nkG8fkTe46pzznGV/4qVoXh2MLVwjrpCMx2dg0YMV2HcDcS0FVvx84fCNPQL7b4Cy2wKb+ghgEFRqP6hqmXDDlydxD1ssLlFcoMePFhTLarxovqofQxJV6t9gNOljgjnM0jupCHVBUsGtANy5XQv/tAF5hyo7AuAVyHVcfNpBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891055; c=relaxed/simple;
	bh=Iqoq1m/RT2bttxazyQgEEHP5Rc3/GttfjIFSvdipBfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s16iNqMZvr9pGxdnit1tkvx1Dgd8X6ZdhMebG2JG21BVOhDi+FJ9b60EjXh1sqBawOKK70Xqj4B7R86rF6h2NYr7AZ637A/FcyPjltzTgd4hFW3Ibu1cpuqyV9SEKoRHBsKnFKy7LNB6HBqMQCxPw7NOMikRN6s/cuUZvt6foWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cd7wCeCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNRJcD03; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767891045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yh3Bt5uWwYvi0HCGizakfaiy4BqE4GYy3HS/MV/Gc90=;
	b=cd7wCeCzwSNsFCLFwmla4Miij+Cuv8/eVpVtNiYS3dhT5pXbVwNVfWqz5ApCSJ5YUtsVXw
	kbv7CK2tohfGpBt/XbY9sqFkB3fNFgHPVvYUxmUVv4lOUtU4lOgq3mUvF9wujgtgfsQ2Zt
	lHRSm2b5+Z1fCpW9Y88vGD55NEB+MRDUEmJIoaJOr8P1EgOhtTO+LnvpHsMt7ZRngingm2
	tTs4VXmeDNkRX0Izv4RPcb5LuakaM2TnxWYl2+p4nMnC3Mm1TNoZkjlPZCXdc/u8S0j8Mx
	bBqBqEDw1Z2UlCiUtIVvDzcYlJdxrTLoGGB73aCRw5MeL0OarNlapbwKGXTuYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767891045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yh3Bt5uWwYvi0HCGizakfaiy4BqE4GYy3HS/MV/Gc90=;
	b=FNRJcD03Qk8U9BX7Q6PzCRHt+k1nwjYhSZ12ZdtFdJt65C4BBbW7i8pzBISApxSGqh+wmn
	zT8IWJqUgko+LPBg==
To: Breno Leitao <leitao@debian.org>, pmladek@suse.com, mpdesouza@suse.com
Cc: pmladek@suse.com, mpdesouza@suse.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
In-Reply-To: <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
Date: Thu, 08 Jan 2026 17:56:44 +0106
Message-ID: <87eco09hgb.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-01-08, Breno Leitao <leitao@debian.org> wrote:
> On Wed, Jan 07, 2026 at 08:58:39AM -0800, Breno Leitao wrote:
> This is what I am thinking about. How bad is it?
>
> (I've also implemented the netconsole part as well, so, if you want to
> have a tree, you can find it in
> https://github.com/leitao/linux/tree/execution_context)

Thanks. It is very helpful to see how you intend to use it.

> commit fe79961da6cabe42343185cf1a7308162bf6bad3
> Author: Breno Leitao <leitao@debian.org>
> Date:   Thu Jan 8 03:00:46 2026 -0800
>
>     printk: Add execution context (PID/CPU) to dev_printk_info
>     
>     Extend struct dev_printk_info to include the task PID and CPU number
>     where printk messages originate. This information is captured at
>     vprintk_store() time and propagated through printk_message to
>     nbcon_write_context, making it available to nbcon console drivers.
>     
>     This is useful for consoles like netconsole that want to include
>     execution context in their output, allowing correlation of messages
>     with specific tasks and CPUs regardless of where the console driver
>     actually runs.
>     
>     The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
>     automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
>     the helper functions compile to no-ops with no overhead.
>     
>     Suggested-by: John Ogness <john.ogness@linutronix.de>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755..e6a9369be202 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
>  	bool "Dynamic reconfiguration of logging targets"
>  	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
>  			!(NETCONSOLE=y && CONFIGFS_FS=m)
> +	select PRINTK_EXECUTION_CTX
>  	help
>  	  This option enables the ability to dynamically reconfigure target
>  	  parameters (interface, IP addresses, port numbers, MAC addresses)
> diff --git a/include/linux/console.h b/include/linux/console.h
> index fc9f5c5c1b04..c724f59f96e6 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -298,12 +298,18 @@ struct nbcon_context {
>   * @outbuf:		Pointer to the text buffer for output
>   * @len:		Length to write
>   * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
> + * @pid:		PID of the task that generated the message
> + * @cpu:		CPU on which the message was generated
>   */
>  struct nbcon_write_context {
>  	struct nbcon_context	__private ctxt;
>  	char			*outbuf;
>  	unsigned int		len;
>  	bool			unsafe_takeover;
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +	pid_t			pid;
> +	int			cpu;
> +#endif

Something like msg_pid/msg_cpu or printk_pid/printk_cpu might be better
to make it clear we are not talking about _this_ context. This struct is
used by code outside of the printk subsystem, which is why I think it
needs to be more obvious what these represent.

@Petr: Any suggestions for names (assuming this is even acceptable)?

>  };
>  
>  /**
> diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
> index eb2094e43050..42ee778b29dd 100644
> --- a/include/linux/dev_printk.h
> +++ b/include/linux/dev_printk.h
> @@ -27,6 +27,10 @@ struct device;
>  struct dev_printk_info {
>  	char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
>  	char device[PRINTK_INFO_DEVICE_LEN];
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +	pid_t pid;

I am not happy about this being resolved by the netconsole printer to
get the task name. A lot can happen between now and then. But I also
shudder at the thought of making dev_printk_info much larger. This is
already a horrible waste of memory (which I talked about here[0]).

I also do not think dev_printk_info is the appropriate place to store
this information. These new fields are not related to the dev_printk
API. They belong in printk_info.

> +	int cpu;
> +#endif
>  };
>  
>  #ifdef CONFIG_PRINTK
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 5f5f626f4279..81e5cd336677 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -287,6 +287,10 @@ struct printk_message {
>  	unsigned int		outbuf_len;
>  	u64			seq;
>  	unsigned long		dropped;
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +	pid_t			pid;
> +	int			cpu;
> +#endif
>  };
>  
>  bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 3fa403f9831f..2465fafd7727 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -946,6 +946,18 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  }
>  EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
>  
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> +					    struct printk_message *pmsg)
> +{
> +	wctxt->pid = pmsg->pid;
> +	wctxt->cpu = pmsg->cpu;
> +}
> +#else
> +static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
> +					    struct printk_message *pmsg) {}
> +#endif
> +
>  /**
>   * nbcon_emit_next_record - Emit a record in the acquired context
>   * @wctxt:	The write context that will be handed to the write function
> @@ -1048,6 +1060,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>  	/* Initialize the write context for driver callbacks. */
>  	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
>  
> +	wctxt_load_execution_ctx(wctxt, &pmsg);
> +
>  	if (use_atomic)
>  		con->write_atomic(con, wctxt);
>  	else
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1d765ad242b8..ff47b5384f20 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2213,6 +2213,26 @@ static u16 printk_sprint(char *text, u16 size, int facility,
>  	return text_len;
>  }
>  
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info)
> +{
> +	dev_info->pid = task_pid_nr(current);
> +	dev_info->cpu = smp_processor_id();
> +}
> +
> +static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
> +					   const struct dev_printk_info *dev_info)
> +{
> +	pmsg->pid = dev_info->pid;
> +	pmsg->cpu = dev_info->cpu;
> +}
> +#else
> +static inline void printk_save_execution_ctx(struct dev_printk_info *dev_info) {}
> +
> +static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
> +					   const struct dev_printk_info *dev_info) {}
> +#endif
> +
>  __printf(4, 0)
>  int vprintk_store(int facility, int level,
>  		  const struct dev_printk_info *dev_info,
> @@ -2320,6 +2340,7 @@ int vprintk_store(int facility, int level,
>  	r.info->caller_id = caller_id;
>  	if (dev_info)
>  		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
> +	printk_save_execution_ctx(&r.info->dev_info);
>  
>  	/* A message without a trailing newline can be continued. */
>  	if (!(flags & LOG_NEWLINE))
> @@ -3002,6 +3023,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	pmsg->seq = r.info->seq;
>  	pmsg->dropped = r.info->seq - seq;
>  	force_con = r.info->flags & LOG_FORCE_CON;
> +	pmsg_load_execution_ctx(pmsg, &r.info->dev_info);
>  
>  	/*
>  	 * Skip records that are not forced to be printed on consoles and that
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ba36939fda79..197022099dd8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -35,6 +35,17 @@ config PRINTK_CALLER
>  	  no option to enable/disable at the kernel command line parameter or
>  	  sysfs interface.
>  
> +config PRINTK_EXECUTION_CTX
> +	bool
> +	depends on PRINTK
> +	help
> +	  This option extends struct dev_printk_info to include extra execution

It should extend printk_info instead.

> +	  context in pritnk, such as task PID and CPU number from where the

                     printk

> +	  message originated. This is useful for correlating device messages

Rather than "device messages" I suggest "printk messages".

> +	  with specific execution contexts.
> +
> +	  One of the main user for this config is netconsole.

Rather than saying which drivers might support this, it would probably
be better to make it explicit. For example introducing a new config
like:

CONFIG_CONSOLE_HAS_EXECUTION_CTX

that can only be selected by the console driver (or in your case, the
console driver option NETCONSOLE_DYNAMIC). Then make
PRINTK_EXECUTION_CTX depend only on CONSOLE_HAS_EXECUTION_CTX. That way
it is only available if the console driver supports it.

> +
>  config STACKTRACE_BUILD_ID
>  	bool "Show build ID information in stacktraces"
>  	depends on PRINTK

While this patch might be "good enough" to preserve the current
CONFIG_NETCONSOLE_DYNAMIC features for NBCON, I am not happy about it:

1. It relies on the printer context being able to determine context
information about the printk() caller. I would prefer adding the task
name directly to printk_info instead.

2. It adds information to printk records that only netconsole can
use. If we want other consoles to support this, we would need to modify
all the console code. I would prefer it is dynamically added to the
generic printing text. We could do this by extending
msg_print_ext_body() based on some user configuration. But it would
conflict with the current netconsole format.

Despite my concerns, adding the PID and CPU information is generally
useful. So I am not against expanding printk_info. My concerns are more
about how this information is being used by netconsole.

@Petr: I am really curious to hear your thoughts on this.

John Ogness

[0] https://lore.kernel.org/lkml/84y10vz7ty.fsf@jogness.linutronix.de

