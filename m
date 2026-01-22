Return-Path: <netdev+bounces-252347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IvxAFUzcmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A767E71
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E53678760D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12272E7BDE;
	Thu, 22 Jan 2026 13:06:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D312D0C94
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087212; cv=none; b=fbr3ErvjoNfSg1NX9jD1XPlVHsaL6ZlGsuCpVLDTs4z0mDeGNHU5nbhvWb0YnwNr455q3FNfX3oC+pQAcFoZfkG+l7Ynl+5vS/RNQDyt6WpiCm0VWP5fAYHkLr8+U9WC1ETsoKCLaDc5c1WkMjyOROrxBqy/Ch5zndNeTS8TDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087212; c=relaxed/simple;
	bh=uS039cyrtjOxg/wM3DI/BK10nHxa405IMOYAtDuh/DY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtDbr88nPSrQds+KHx0+p445QBcZAn5f7kSijR1oDuWZ9LNLmE4Kb45FGmYf3BZNV0waIjkjqAD38OzABmRmkouHasod9uWjRHBERFq0s72C+uxDn8YBYhj0kgxNf+0hG7R/2cKUuZZiU89mcHLcgkYWKr+HO6x6T8kxu64BNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so758948a91.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769087210; x=1769692010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zGZyGl9NSng9r4hs69BE4M+bxPmbCQfkv05UmpOhTp0=;
        b=Bv9EU+70qZT1UxXZ/tViBM92kkhvYPQOlpUmqj/5GbWx+qszTPWjyb5egimLMVUaIJ
         VQgdkTDgE1eiR67y73Bsn2P58bB7/QVwJg3DaK6LESYuWtGELoV3RpXLcY45WEq8B5ZW
         A5ZnpFHLGGK0J1MghVX155teNrHLelsdOUPdFwLtx/cifd9Pjug17Cp+JaZtBRSgpPpB
         kjvwD+u4nmqAON5zBIjB3i11wNwGxRChke5Gyd6bZvIc4dPVrLvqphadis+lsa2sweo+
         X3hVDsyFAhmopjjiSVDOMt2OTTgIlUS6TMXYbhVP8My61UQj/2JFkG28EOWr2xudKG82
         HpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq/AnWJVfksfDgpRJHvnFi+D6kkcoWCehXTb7bM7+jwvIXgFwTH5MK2THVht8TnJ3jITv5XDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTV5Trvu0PPaFa7dRl2JFNy+rG+uZx6ztI4up5Z3oAV3qOWegX
	TU35lYQeZtU8OJ6ArfsqSGmt/8Y0wHtzGK+09ut/p1WBLAwdZJ2IKTwRVGKeRg==
X-Gm-Gg: AZuq6aKC3U3S+JluqYbGDVp34bfd2mzc2bb99iShGP0SwAahGAyV4rXvaSr06cgJQG1
	kgW+bwBFAWmcuZwtB9xVX03ik5oHZRZTyjK/xy0wb+bArK6TSwxa8cuycvoXz5D4U3UJVVyy56X
	+OaV42QD7ebtjwkQePK+Yy6yKHC/W2C+V5LlwO/g5qU2q4Cetlz6qfEGDLGvmEXjO+wjosC+2jB
	iYqAKfg8D02ATsi8FhQh/7Ps5sQpKvVbXcmq7cPv1Q58okyKlubEw9GeepnMCdqSJEMMUHmDB+q
	KA1io/XYO7GkOF/5Sm4EBwYmiBxt25OVe34U7Qxeb42d4HTrxVjuYKySu780qtlQCJUEfWOTTU2
	VTwHUaa6M1jviQkYqKn+g2rcZ0tuHXQRI6W8W7HYNwZT0eSoN1nVoVSHPU6VyMFsa9iVo1+W6zt
	Qmvw==
X-Received: by 2002:a05:6870:8916:b0:3fd:9f68:b8c4 with SMTP id 586e51a60fabf-40846d481c8mr4567448fac.28.1769081551732;
        Thu, 22 Jan 2026 03:32:31 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd150dasm13676435fac.14.2026.01.22.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:32:31 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 03:32:09 -0800
Subject: [PATCH net-next v3 1/5] printk: Add execution context (task
 name/CPU) to printk_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-nbcon-v3-1-a722f2f0dfa5@debian.org>
References: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
In-Reply-To: <20260122-nbcon-v3-0-a722f2f0dfa5@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9173; i=leitao@debian.org;
 h=from:subject:message-id; bh=uS039cyrtjOxg/wM3DI/BK10nHxa405IMOYAtDuh/DY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcgrMze3n4dGE4JsfU8DqNfkSbYP85FBY00VgS
 4Epr3oFCSOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXIKzAAKCRA1o5Of/Hh3
 bYB0EACF7cMlPwE3Q5DTWQ7O17V60WPcG/vDV9Ow//GJhm9qgVZzUY3EQJgdiixAd4GVVupk3LO
 5QyXuSK1VQ3gojBML4aO5UF+IYL2/nKHUre23MJnAHdKgKT8sb9VlADd92SRTJFc8SZyi0PZn+8
 3dwE0HGpgNQXyBaKRZbRRYOGdJTyzBWNYNJWlASBDilFQ9H3pzTIcruPsw68B99lGrAKP9DW3i2
 jpo7Sq9z5hxlxixN9v5BNGsQu7Oqf6ecrfIoSe/2fm/WqViow1ULDQKaVfkPpJvs3KsBUFlVL9f
 Kx/GkHDtd7lsONtTUUlMH5VPJqEJpKVK7X9VQOJr9qTgGYBxCEpqzDxgogPK0H/L1BTGf6heOll
 nJ1JSNIoLGUTO4ghxYnum1cxhkUU8cAsiZqeDWN69LBqyeldBCnR+Rb6fYLEKNqmoo9QHhb6Vfk
 r1rvspMnDFskbQ/2V30i8LwdPuz/qSXo4D06UlYcYWgxOM2oyfD2ggEJjSjqnDJSU+rYAYb50fn
 vLycwCCpjja9zmCDPKwLiE26DN+Nxt3FQIuGud0JVFhNrMbKiJZ45yPgAUytFwrtUZ8P5vzoiPS
 0wmRX6lh1C+SvUdb2DcdCWiflV8e1DEfBKSlzijeFFrbbVcK6EarwQvb1OAoGxB5qqTKkNs68CU
 FwDb9wUTolH1YsA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	TAGGED_FROM(0.00)[bounces-252347-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A87A767E71
X-Rspamd-Action: no action

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
 include/linux/console.h           |  8 +++++++
 kernel/printk/internal.h          |  8 +++++++
 kernel/printk/nbcon.c             | 15 ++++++++++++
 kernel/printk/printk.c            | 50 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk_ringbuffer.h |  5 ++++
 lib/Kconfig.debug                 | 20 ++++++++++++++++
 7 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755d..e6a9369be2020 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
 	bool "Dynamic reconfiguration of logging targets"
 	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
 			!(NETCONSOLE=y && CONFIGFS_FS=m)
+	select PRINTK_EXECUTION_CTX
 	help
 	  This option enables the ability to dynamically reconfigure target
 	  parameters (interface, IP addresses, port numbers, MAC addresses)
diff --git a/include/linux/console.h b/include/linux/console.h
index fc9f5c5c1b04c..cc5dc3bf58b60 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -298,12 +298,20 @@ struct nbcon_context {
  * @outbuf:		Pointer to the text buffer for output
  * @len:		Length to write
  * @unsafe_takeover:	If a hostile takeover in an unsafe state has occurred
+ * @cpu:		CPU on which the message was generated
+ * @pid:		PID of the task that generated the message
+ * @comm:		Name of the task that generated the message
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
index 5f5f626f42794..5fdea56827564 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -281,12 +281,20 @@ struct printk_buffers {
  *		nothing to output and this record should be skipped.
  * @seq:	The sequence number of the record used for @pbufs->outbuf.
  * @dropped:	The number of dropped records from reading @seq.
+ * @cpu:	CPU on which the message was generated.
+ * @pid:	PID of the task that generated the message
+ * @comm:	Name of the task that generated the message.
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
index 3fa403f9831f0..1fd48d71cf8e8 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -946,6 +946,19 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg)
+{
+	wctxt->cpu = pmsg->cpu;
+	wctxt->pid = pmsg->pid;
+	memcpy(wctxt->comm, pmsg->comm, TASK_COMM_LEN);
+}
+#else
+static void wctxt_load_execution_ctx(struct nbcon_write_context *wctxt,
+				     struct printk_message *pmsg) {}
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
index 1d765ad242b82..7daaa27705339 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2131,12 +2131,37 @@ static inline void printk_delay(int level)
 	}
 }
 
+#define CALLER_ID_MASK 0x80000000
+
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + smp_processor_id();
+		CALLER_ID_MASK + smp_processor_id();
+}
+
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+/* Store the opposite info than caller_id. */
+static u32 printk_caller_id2(void)
+{
+	return !in_task() ? task_pid_nr(current) :
+		CALLER_ID_MASK + smp_processor_id();
 }
 
+static pid_t printk_info_get_pid(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return caller_id & CALLER_ID_MASK ? caller_id2 : caller_id;
+}
+
+static int printk_info_get_cpu(const struct printk_info *info)
+{
+	return ((info->caller_id & CALLER_ID_MASK ?
+		 info->caller_id : info->caller_id2) & ~CALLER_ID_MASK);
+}
+#endif
+
 /**
  * printk_parse_prefix - Parse level and control flags.
  *
@@ -2213,6 +2238,27 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 	return text_len;
 }
 
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+static void printk_store_execution_ctx(struct printk_info *info)
+{
+	info->caller_id2 = printk_caller_id2();
+	get_task_comm(info->comm, current);
+}
+
+static void pmsg_load_execution_ctx(struct printk_message *pmsg,
+				    const struct printk_info *info)
+{
+	pmsg->cpu = printk_info_get_cpu(info);
+	pmsg->pid = printk_info_get_pid(info);
+	memcpy(pmsg->comm, info->comm, TASK_COMM_LEN);
+}
+#else
+static void printk_store_execution_ctx(struct printk_info *info) {}
+
+static void pmsg_load_execution_ctx(struct printk_message *pmsg,
+				    const struct printk_info *info) {}
+#endif
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -2320,6 +2366,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_store_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3049,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, r.info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fbe..1651b53ece34f 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -23,6 +23,11 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+#ifdef CONFIG_PRINTK_EXECUTION_CTX
+	u32	caller_id2;	/* caller_id complement */
+	/* name of the task that generated the message */
+	char	comm[TASK_COMM_LEN];
+#endif
 
 	struct dev_printk_info	dev_info;
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79b..57f91ee10b8e6 100644
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
2.47.3


