Return-Path: <netdev+bounces-250567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFBD33549
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F022630C901C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A032B9B4;
	Fri, 16 Jan 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wbxv4Nv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC133B6C0
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578712; cv=none; b=oMBBzPHlUgCa8H4P/wWVDPobbwsH27BgZJEjEqd30wa0QWbuTeUPtFI+H8kOzyz8ldPDY69fJNYwS9wy6K+6E4zl6ecTtQVecb/0yGgpOVGusid4IVBZdZR31hzECYpSpxK9V7OTMpwoFXM+qttOKeqh5txYY0g30MaHgWTUBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578712; c=relaxed/simple;
	bh=u4Cy3dy+Jt+nOhLZsenXS55g+kk8o9dxuY1nRgQlMj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiYv2K7wYnwHOXdHZLVWnTcFWFak5k3yLbwg53YDccRN9zIA8p+GZS/8J9vQOAnjO3O660pVyVFLrjrioQTJXWPAKZ8oFPqKABhrJZPLtctor2VE46KRJWMVdMwsGtJ3QEFuNRHzRPYtBrCq182WacFBMwhB16tmRLl2WmWtBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wbxv4Nv1; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so8751625e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768578709; x=1769183509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnYDOUmkfIQkeRwuM/CKf7bJKNlDv8Tunazw6EC/9Xw=;
        b=Wbxv4Nv1iN8E8s6o0eGCPSPjmYfTrD7YvmCbbzqBiCOfIpVSnLCSLdB6Dkk61iIa6r
         ZwMfm3fxcOxl5RsXS3eNjOWe83vS48wask5pl8FCxaNHzT3AYd0d0St2NEQbqcvXNbTf
         21Txm562jYoFfQu61e8ddmeFeGp8PSewZsXXCSs9dn5L7VhHX9A18sj13D/awGjIcWbo
         /Onr330RFzG2wS4BT3HjZ7+y7b7SIgx7TaZj5nHdumx+wcYTyboTK9HN0MHZaBtO2wei
         XpVyKcahSFdA3YtBbzoI38RtkvhTXHLPjDh72ZyH/GleFqF9+gdsu3/jku4g3Kr8YhgZ
         os0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578709; x=1769183509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnYDOUmkfIQkeRwuM/CKf7bJKNlDv8Tunazw6EC/9Xw=;
        b=V+TrtdCoxqYFL6oG+GEMomQvuhhk+2iBEjUFdQqf1czVPwIRgJLIKLEnkyY6AXwdbN
         V/r1OucA6GPfHEA7CQlS6Svyf93kUN7Lq4kNQKDZiLyKYcPzWFMWoZJmeCKIhq9mt6hP
         qBwt/rG7rArcWA32j83hgtviOJaMqIa2wbvdjxeXuqjVG+RFR/GcXX+CmtT8G1wWCyB4
         2x55gY2AtHM0w7JQXBlhj63fXH9zbuZtR/deyH3PnMtnYFxttIBv4i8ULHE0sq1GkV44
         f88IQ/lKAmCwLouvykN6brX/UzUk5/M7vH+ehOJCxwKk8Y4Uy5anSLl8tmdcerH/xRco
         +Www==
X-Forwarded-Encrypted: i=1; AJvYcCUemrj8+dGI0gRY33wjSJW/pDDFKnguayBfIjec4ZC4AFLjRgCaJLelGuxsPcmOFCVsTzE5JpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJu4FvT2TQmg3dF0h9L5pLzaJOgAPPnljKtbio8FNtaHihNFB
	4JTZtjgM3Aa9USYK8lm4C8yCdw86aY+gDNdOvFZsVRrUfatX4+EhfxnNuX9nizZu2YI=
X-Gm-Gg: AY/fxX4u/2GIulEhtk0+2C67xq0ez2r/jHoqc+DC6MMPwE4OMrNlvNVR4VMKKyAVKSd
	v7PVYbkg2ew6Tw1/d/7yKQ1w3zcmA9UoIjwu+b4fXzCx+aw3NHpOR1s7VhsJyJUQKD18zp/5fjQ
	lCdXvmlngUOaEDXEH0o0n2Orf3J2P8pXuZSaPzsIN9tNb4mA69djELrhSGM8CppNOjHtR0e71cf
	ij4xA3paQ9dVMbgmz7shb0pO6dtwiBgWPrIpoNE8dgafwBzEm32SO6RKoBj2HhW5dRXSWurjnPr
	ea2x6FzeIWq+NYnVz/zlMr6zZVRInxaJpmm1uAeAUepavjxQ0F4y5N0kdbqEGgZLwVi3NTab0dF
	iFFHAThT6HKyxAocBF1JW3KdaGrLA2KVIvcF1i0+ox/JsVuEbPse6veV7JcVSAn9EjzhC54o9pD
	42oAxhOGZk8mwwRg==
X-Received: by 2002:a05:600c:37cf:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4801eb041f7mr33515455e9.20.1768578708783;
        Fri, 16 Jan 2026 07:51:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569927007sm5815673f8f.16.2026.01.16.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:51:48 -0800 (PST)
Date: Fri, 16 Jan 2026 16:51:45 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>, osandov@osandov.com,
	mpdesouza@suse.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	kernel-team@meta.com, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <aWpekVlhRpD4CaDI@pathway.suse.cz>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
 <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
 <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jakydyx5dprrzgbsb6lorgpova46jbhq5tecwwtiihkhyi6ofy@olsrizfk52je>

On Mon 2026-01-12 04:44:42, Breno Leitao wrote:
> On Mon, Jan 12, 2026 at 02:55:06AM -0800, Breno Leitao wrote:
> > > My ordered preferences for right now would be:
> > > 
> > > 1. keeping @caller_id semantics + adding @cpu + adding @comm (similar to
> > > your C)
> 
> ...
> 
> > Let me hack a new version of it with @comm, and post here to check how
> > it looks likes.
> 
> How does this version look like according to the suggestion above. It is
> mostly Petr's option C with a few changes:
> 
>   a) caller_id continues to be unchanged with (pid and context bit)
>   b) Append @pid and @comm to printk_info
> 
> 
> Author: Breno Leitao <leitao@debian.org>
> Date:   Thu Jan 8 03:00:46 2026 -0800
> 
>     printk: Add execution context (task name/CPU) to printk_info
>     
>     Extend struct printk_info to include the task name and CPU number
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
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -23,6 +24,10 @@ struct printk_info {
>  	u8	flags:5;	/* internal record flags */
>  	u8	level:3;	/* syslog level */
>  	u32	caller_id;	/* thread id or processor id */
> +#ifdef CONFIG_PRINTK_EXECUTION_CTX
> +	char	msg_comm[TASK_COMM_LEN]; /* name of the task that generated the message */
> +	int	msg_cpu;	/* CPU where the message was generated */

I would allow to store the caller_id complement so that we
always store both cpu and pid.

Also I would remove the "msg_" prefix. It is not bad. But it is
inconsistent with the existing "caller_" prefix. And the meaning
should be obvious because it is stored in struct printk_info...

Otherwise, it looks good to me.

I tried to update your patch with the above proposal to see how
it looks and I got:

From ac9d7962d478bda9b5c7ef1d42e14c46c9d576fc Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Mon, 12 Jan 2026 04:44:42 -0800
Subject: [PATCH 1/2] printk: Add execution context (task name/CPU) to
 printk_info

Extend struct printk_info to include the task name, pid, and CPU
number where printk messages originate. This information is captured
at vprintk_store() time and propagated through printk_message to
nbcon_write_context, making it available to nbcon console drivers.

This is useful for consoles like netconsole that want to include
execution context in their output, allowing correlation of messages
with specific tasks and CPUs regardless of where the console driver
actually runs.

The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
the helper functions compile to no-ops with no overhead.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/net/Kconfig               |  1 +
 include/linux/console.h           |  8 +++++
 kernel/printk/internal.h          |  7 ++++
 kernel/printk/nbcon.c             | 15 +++++++++
 kernel/printk/printk.c            | 53 ++++++++++++++++++++++++++++++-
 kernel/printk/printk_ringbuffer.h |  5 +++
 lib/Kconfig.debug                 | 20 ++++++++++++
 7 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755..12e47cb27ffa 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
 	bool "Dynamic reconfiguration of logging targets"
 	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
 			!(NETCONSOLE=y && CONFIGFS_FS=m)
+	select CONSOLE_HAS_EXECUTION_CTX
 	help
 	  This option enables the ability to dynamically reconfigure target
 	  parameters (interface, IP addresses, port numbers, MAC addresses)
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04..47477fd05ee8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -19,6 +19,7 @@
 #include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/vesa.h>
@@ -298,12 +299,19 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @msg_comm:		Name of the task that generated the message
+ * @msg_cpu:		CPU on which the message was generated
  */
 struct nbcon_write_context {
 	struct nbcon_context	__private ctxt;
 	char			*outbuf;
 	unsigned int		len;
 	bool			unsafe_takeover;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	int			cpu;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+#endif
 };
 
 /**
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5f5f626f4279..cf9c01a02853 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -281,12 +281,19 @@ struct printk_buffers {
  *		nothing to output and this record should be skipped.
  * @seq:	The sequence number of the record used for @pbufs->outbuf.
  * @dropped:	The number of dropped records from reading @seq.
+ * @msg_comm:	Name of the task that generated the message.
+ * @msg_cpu:	CPU on which the message was generated.
  */
 struct printk_message {
 	struct printk_buffers	*pbufs;
 	unsigned int		outbuf_len;
 	u64			seq;
 	unsigned long		dropped;
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	int			cpu;
+	pid_t			pid;
+	char			comm[TASK_COMM_LEN];
+#endif
 };
 
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 3fa403f9831f..c2b3c4d2146e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,19 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+					    struct printk_message *pmsg)
+{
+	wctxt->cpu = pmsg->cpu;
+	wctxt->pid = pmsg->pid;
+	memcpy(wctxt->comm, pmsg->comm, TASK_COMM_LEN);
+}
+#else
+static inline void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+					    struct printk_message *pmsg) {}
+#endif
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -1048,6 +1061,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
+	wctxt_load_execution_ctx(wctxt, &pmsg);
+
 	if (use_atomic)
 		con->write_atomic(con, wctxt);
 	else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1d765ad242b8..bc09fb6e33d1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2131,12 +2131,40 @@ static inline void printk_delay(int level)
 	}
 }
 
+#define caller_id_mask 0x80000000
+
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + smp_processor_id();
+		caller_id_mask + smp_processor_id();
 }
 
+
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+/* Store the opposite info than caller_id. */
+static inline u32 printk_caller_id2(void)
+{
+	return !in_task() ? task_pid_nr(current) :
+		caller_id_mask + smp_processor_id();
+}
+
+static inline pid_t printk_info_get_pid(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return caller_id & caller_id_mask ? caller_id2 : caller_id;
+}
+
+static inline int printk_info_get_cpu(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return (caller_id & caller_id_mask ? caller_id : caller_id2) & ~caller_id_mask;
+}
+#endif
+
 /**
  * printk_parse_prefix - Parse level and control flags.
  *
@@ -2213,6 +2241,27 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	return text_len;
 }
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static inline void printk_store_execution_ctx(struct printk_info *info)
+{
+	info->caller_id2 = printk_caller_id2();
+	get_task_comm(info->comm, current);
+}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct printk_info *info)
+{
+	pmsg->cpu = printk_info_get_cpu(info);
+	pmsg->pid = printk_info_get_pid(info);
+	memcpy(pmsg->comm, info->comm, TASK_COMM_LEN);
+}
+#else
+static inline void printk_store_execution_ctx(struct printk_info *info) {}
+
+static inline void pmsg_load_execution_ctx(struct printk_message *pmsg,
+					   const struct printk_info *info) {}
+#endif
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -2320,6 +2369,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_store_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3052,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, r.info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fb..8943c02995af 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -6,6 +6,7 @@
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
+#include <linux/sched.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
@@ -23,6 +24,10 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	u32	caller_id2;	/* caller_id complement */
+	char	comm[TASK_COMM_LEN]; /* name of the task that generated the message */
+#endif
 
 	struct dev_printk_info	dev_info;
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79..57f91ee10b8e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,26 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config CONSOLE_HAS_EXECUTION_CTX
+	bool
+	help
+	  Selected by console drivers that support execution context
+	  (task name/CPU) in their output. This enables PRINTK_EXECUTION_CTX
+	  to provide the necessary infrastructure.
+
+config PRINTK_EXECUTION_CTX
+	bool "Include execution context (task/CPU) in printk messages"
+	depends on PRINTK && CONSOLE_HAS_EXECUTION_CTX
+	default CONSOLE_HAS_EXECUTION_CTX
+	help
+	  This option extends struct printk_info to include extra execution
+	  context in printk, such as task name and CPU number from where the
+	  message originated. This is useful for correlating printk messages
+	  with specific execution contexts.
+
+	  This is automatically enabled when a console driver that supports
+	  execution context is selected.
+
 config STACKTRACE_BUILD_ID
 	bool "Show build ID information in stacktraces"
 	depends on PRINTK
-- 
2.52.0


