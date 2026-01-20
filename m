Return-Path: <netdev+bounces-251573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACiIBNLYb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9CF4A87C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2607F44CD85
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C60244A708;
	Tue, 20 Jan 2026 18:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF343B8BD4
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932022; cv=none; b=MkNmUEZQZpByEzUyhie/I8EoRSIo/OvgDG2gWG7loU4k/zoeiql4qvCnNy9qlQ+1aaNSfjszovwMDyvCcm4hBnawJKFPgmVMITTW2uLdtkAM2Tc61qYVsjpXFhBSsM6RsZ/IAGDV28zfUOINUxHyb8Ky8Cq/mcEsJ8Jtbjyqrs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932022; c=relaxed/simple;
	bh=uhMN5SDvwZKz4HUOAWprEN0emQee+wLZlPBbDgAYD+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTyq9Fnn+c8ed9qDcnJ9qdNS/wB5QV1EN1QlWC7duRs80hbu9cSswzRsI9D4oFoOxt/nHdlgObeM7QUk/etqmtWttC5pUZXLR/UUtBPCKplTf5IigVkveymrlBZMU7DSfwUvSx5RzdOH30EI3jG1G485fLFTP+ga6AvN1ceX61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5349ba802so522540985a.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932018; x=1769536818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QtgxYc8DWWj4JDK65TWyeuo8xjeUjjmBnOPjo+S2drw=;
        b=QgEShsrfOQ+y4HLvccg2OBM+A1chDcPSaq/NqZE+952ZYI8ioZRQnxW7dGL6wWcN32
         DQZ72a6Jp2GJBuu5w7za+egS/25ipO3IMFMRpZ84YS9OYUiYbeccsRTGVc2TeR/JCgRv
         tqslZJDxABBDOxxwFUeSGWU5mV8jgKH6Tt9FjMK4dDefrhpgxawMFRzg2+KE5nF+5W/E
         xVy0T9f5qgdDWtj9FQNuGDePZDw8kO4CRhROQnzg1VU+F/j320TJM6yY3dCTLGqMt7Mz
         Fgq/CJPGKIUGeSIewlLx0aIc0xijNiHsZHBn0cT9AiUM3DNGEKf8Ri+82juU4wIbalQZ
         QzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBd80R6xApBmqqaHCuCWB5ordKCrzIy8Lleh9z9oDXG8nPNNZgxGC9txuyLogs3DTa4PUkuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztb61L3iWHr1yJdZFRs0HWYD7cY73BDcYPlZUcO2VguIO59xYs
	X8NlhrM6KFWOua/pLSR1BT5Lbjiye1hMvQAq3B8URG4tyEstNSifGAlT99eFIg==
X-Gm-Gg: AY/fxX77Ur28s+MuNwI6D8cGH8h7yXpJVlPMKB1oO+nKxycDP/XtXEbRBqgjOs27BK/
	gFwNARyq0hVxTYmOk7lO+P27R8f8OsEHpV74b4gcYp7u0fgatv8Td7UYHh1uGL8AyzTB2yKRGLZ
	vJC1c5QZw9KcRtz/mChl0JWpGVbKKHcOg9oqQnkvZnZ4PVI0Rg4HFZsK4QiTacVRRPyMkVDpU1K
	2RZ5sdOHD78XClutuSInVD4ppOpo80eicdOxQTKYr5ikOdvIjMVmPNFwrSjgYmRAMk3p7Kwj95D
	Vromg5fIRC82KqnLgou1rM1LAeH8OaHu6mHla3/ykBLkfnfe2ujcP1ouCGKLAW80ZCcoFuuVBsK
	m8jxt5CTgEnCq2CESYXudFqTxAcxX47H+6JBcoeZLejTJs9/dx+zNXnKkPShjcsVNbchyFMxKlO
	+m
X-Received: by 2002:a05:6830:3744:b0:7c7:690c:8a80 with SMTP id 46e09a7af769-7cfded44fa9mr6579427a34.9.1768926245620;
        Tue, 20 Jan 2026 08:24:05 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28ef44sm8865220a34.18.2026.01.20.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 20 Jan 2026 08:23:47 -0800
Subject: [PATCH net-next v2 1/5] printk: Add execution context (task
 name/CPU) to printk_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-nbcon-v2-1-b61f960587a8@debian.org>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
In-Reply-To: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9280; i=leitao@debian.org;
 h=from:subject:message-id; bh=uhMN5SDvwZKz4HUOAWprEN0emQee+wLZlPBbDgAYD+4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6wiwrhHlnYabC1yTvrM1KVwgr+iv/GVWDHYM
 sd7IDRnDGCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIgAKCRA1o5Of/Hh3
 bbyBD/0VCaiJBo5QXkxWDoJGYYoqA910sbr7HZqiI0UfSg8QKFYFFmWJOAucqFFdh+xJzeVkKbK
 1sCFQDhOPTntTHNYOcY2Dk9yJEJRWjGs6gVXddm+m9D0rUdlcTz5CKatZrq2BPx0U9nlnqBoVVN
 lEnJO+XRdgcBxPl8hRTyU8ww0FVQqqIkSusd1dkr9YCfYmPpnELfYezeUJj0n9dFmCB47Z8m1Y7
 nRLgbcsfZEJ3kx1xYU3XT7bUBB+P80rxeCMU8qtDWpYlKCg2SthkWryjO2jaYUSnlpon5dABfAf
 z9strlni9WgTzhB0pQm2+WIcWproMAGljxyMeVJxyTy7qs9SQ8aW07bIb5r4WPt+Pzlvtv/JaDl
 OgK9Z/oELQ2KFc6lddXfQCX/incQcWnP8HYGcPEid+7F8oRfNH8AxAwd4dkak4BgoGSUHwVj9Cc
 CVoTjtuHLryfGIGfcz4OTrnCpER6uz7L3o832BPTnM0M3JoWK/lkY8aw8JZ4PqI37kBhFTiE9wy
 c4xyTHhRAFLtZ8cmb1TPcXXjKsDlalT+gb0SkBA4iSjG6vyqoiwlKM3w8VO1bbEzLiZ5JlWa3MD
 LKaNBZWj3HGNq0sRvvwMJN//9ypH1iUv2Bo0tmPq7AVOM5OHA80xco/JZkfpBjfQ4+u53OIl9OF
 zC6VouwQ5P9f5cQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251573-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,r.info:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BF9CF4A87C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 include/linux/console.h           |  8 ++++++
 kernel/printk/internal.h          |  8 ++++++
 kernel/printk/nbcon.c             | 15 +++++++++++
 kernel/printk/printk.c            | 52 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk_ringbuffer.h |  4 +++
 lib/Kconfig.debug                 | 20 +++++++++++++++
 7 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755d..12e47cb27ffa5 100644
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
index 3fa403f9831f0..c2b3c4d2146e3 100644
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
index 1d765ad242b82..8885e8e7753fe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2131,11 +2131,38 @@ static inline void printk_delay(int level)
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
+static inline u32 printk_caller_id2(void)
+{
+	return !in_task() ? task_pid_nr(current) :
+		CALLER_ID_MASK + smp_processor_id();
+}
+
+static inline pid_t printk_info_get_pid(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return caller_id & CALLER_ID_MASK ? caller_id2 : caller_id;
+}
+
+static inline int printk_info_get_cpu(const struct printk_info *info)
+{
+	u32 caller_id = info->caller_id;
+	u32 caller_id2 = info->caller_id2;
+
+	return (caller_id & CALLER_ID_MASK ? caller_id : caller_id2) & ~CALLER_ID_MASK;
 }
+#endif
 
 /**
  * printk_parse_prefix - Parse level and control flags.
@@ -2213,6 +2240,27 @@ static u16 printk_sprint(char *text, u16 size, int facility,
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
@@ -2320,6 +2368,7 @@ int vprintk_store(int facility, int level,
 	r.info->caller_id = caller_id;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+	printk_store_execution_ctx(r.info);
 
 	/* A message without a trailing newline can be continued. */
 	if (!(flags & LOG_NEWLINE))
@@ -3002,6 +3051,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 	force_con = r.info->flags & LOG_FORCE_CON;
+	pmsg_load_execution_ctx(pmsg, r.info);
 
 	/*
 	 * Skip records that are not forced to be printed on consoles and that
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 4ef81349d9fbe..bf5b23a0bf54e 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -23,6 +23,10 @@ struct printk_info {
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


