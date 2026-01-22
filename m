Return-Path: <netdev+bounces-252308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ6QJl0acmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:38:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBC66BC1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A12CD6A9EAA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63344103A;
	Thu, 22 Jan 2026 11:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CC43CED8
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081559; cv=none; b=El0fGyo+Z/8lpGe+tZTXz1ii7KdX9btJ8dO0b0c+ORavm5a9JDinyOetqfQfTrrCdb1hMcdQ79mhPd0sTdkruygklhAr2RxnKzDYOw0ah7pWc8vOazI8Tgz0YjnAIBTJjWCQ3vfOPr06oOuvG1csnPcO1443i38gcSH961dYLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081559; c=relaxed/simple;
	bh=7uJHyrOXDOd9FhTVAyYPXPCvAgryvDq0hreiCHLIU9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYrEg/wdVe21Xx/p6u1Db29ca93pw85k5gW8UVmpf0/JY6Wp9BH62cQLzm5IE6AZMH7PVffNFj3xEgshbS9JqHFTw1F/qBCzgQarn6VgyEgOZZiUfnlovQxWkNBBChPslhiYC84Szx2m2BCYzNVbwfPMKjDbsgpFcxvVyFK3y3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-661084916c0so379813eaf.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081555; x=1769686355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N7K9lAwaHOQ2RjvOXsUnNKNy17Hf4+SGCSY/7ykDtA8=;
        b=XLtUHNzuiLsGV12+G+8qgBvmeuzo6TozZv9atfMADf03OZLIL0hElgURzrJL3KXuox
         mrjyu2u0x909j+155w9sOWCmVWh5tavTUIHW7KpjTDOfnw07sz24difx3gmv0DrJzU5o
         CqDSPJ5Fb55pLUNqLbPpza2M7tN7mu346kDVcOtbjcS0ou/PdUOgmgFzLtDUxkegMHOj
         jUi9SRHw5QGxNGE9Z0yn+EBjuAGZZS6Pv6lVovRPn4bw4smjgzDUrZi0p3O5ZIZUCCAD
         vqQU5hUV1itLp+GYbEXUX7sDYarYweg1ESOJTULPkkUffDuHjrZnj1M+W8o88xvboc4l
         qmtw==
X-Forwarded-Encrypted: i=1; AJvYcCVMKOisorPhEgtDIvCt6u3qTMrfiMR3WQLVtYOU0TebdmrDM7mXODUug+W7gqK/+dGnPXvkdWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztw+vM2KpNiglvl4t02u+RaRU62NQdT4M/w/opd18HdrGDssJe
	mCQmc0h4CYyhpcEFo5zVyYm2Zc/CnZmV7cHLzYyQNKoewLohC10h5mBiwGRj2w==
X-Gm-Gg: AZuq6aJghLe6oF78QMMrMfrz3l0k0ynUlXWyr9WZEJCN5vYgvEMAVj6H25vhWkw9P3L
	atNrZjUqXw/m49aqyQFgr67elxIEU6Z9Yoq/0OAnIYXxVsVZULkSG59MA+TK8s++ni4xFpgZHVr
	BxmSVfy7RrWNl4DbrewIHQY5GJlqiYwNpNxtSKj+YqGpqf2abVj5WaAZ7mFuoylMiYJFFUiX5Vx
	+KyPRKWCQAacfL9wac9vPbe/bS5P834QgXjxGlAAi3BQjjiYjm9Qtx2irGfHjG+92KbMCwRtHRE
	/4+BuLCDNQLalzMKB1lFG7wPKqwwWAVi19O/WMmR6dKeRPO/IVf5GOQtfkPXgf1qHZH5VR6p92R
	99I9wDDy5H/dl6gvUP4MuSLKTrZEa9FEHFGGt8atmu9rD84o4cjshNEVbmqu4EHffekpAixFLym
	al
X-Received: by 2002:a05:6820:1ca2:b0:662:b831:b830 with SMTP id 006d021491bc7-662b831b9c0mr3070974eaf.65.1769081555331;
        Thu, 22 Jan 2026 03:32:35 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66289e3af7dsm7733666eaf.14.2026.01.22.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:32:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 22 Jan 2026 03:32:12 -0800
Subject: [PATCH net-next v3 4/5] netconsole: Use printk context for CPU and
 task information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-nbcon-v3-4-a722f2f0dfa5@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4867; i=leitao@debian.org;
 h=from:subject:message-id; bh=7uJHyrOXDOd9FhTVAyYPXPCvAgryvDq0hreiCHLIU9Y=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcgrNx/dSKFHEWl3I4Vg07bhnKQsUcIF8yo/s9
 Rq+ZzJlKcCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXIKzQAKCRA1o5Of/Hh3
 bZYuEACH5VuwJ0LdxKPXnXTj3CyOlq7YimkNBI32njqX5MmN/gHQf/5EPJC6Q2tLAuFEwzk+23L
 p7RxVZ3SGGzBPz9O0zBwBF4hfJ44D+00ykxkLD+9mCFeNb9DaDkF/AGnjomhlod775U29nwc7nB
 NqMmbzxil9GIyv3z1oZvf8h0e51DJDfXq/efPtoUkAhEGRJPl7rkiV0Ho0UUpdGOCzFGU3RYHDX
 LMmfIYjcevlB0nB3ebJ5bVm5xL9eqshDZxToRBxCQsH+OkZRGnEpBZ8nL9mMcxHh4ZB/hPpXmD6
 XYNMyKTiKLSigiWW5J9XXMm5oqTPOqfa2hOGTfRcFP4aml0deidyyuruiRWrlruF6XtOo3aMgNr
 N8bSHdhDDCK4NUTq5i0kRsbr3nGHAfZBqiPFMNUC0qJmpjwjDiWCdlByRgw/De8vC9ANpDGZrPS
 k5b4Jt8971TnBuCfEwVU25DfHFayz7GXEzDoNFJyBHc7l8/5G71EI+VIuO7CQcLhg3oKYY+RC77
 iUJZrVjPSRH2HHbudLjoY8pOiig82GUrLaYo+Etv/ALk9QKud+bzKE/zBBgsT7dEckEixFDMaJ9
 Kors1Zy9vyDpCOiGriznjzj2Ma0u4PujKCbCQNm1iLhR9rMSKF9I5Wt8s8WIZtXvc8Ejr0QCUdu
 BGAPqbmFjyLAbNg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-252308-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5ADBC66BC1
X-Rspamd-Action: no action

Use the CPU and task name captured at printk() time from
nbcon_write_context instead of querying the current execution context.
This provides accurate information about where the message originated,
rather than where netconsole happens to be running.

For CPU, use wctxt->msg_cpu instead of raw_smp_processor_id().

For taskname, use wctxt->msg_comm directly which contains the task
name captured at printk time.

This change ensures netconsole outputs reflect the actual context that
generated the log message, which is especially important when the
console driver runs asynchronously in a dedicated thread.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c5d7e97fe2a78..1dc53b749c75c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1357,18 +1357,20 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
-static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
+static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset,
+				 struct nbcon_write_context *wctxt)
 {
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
-			 raw_smp_processor_id());
+			 wctxt->cpu);
 }
 
-static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
+static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
+				   struct nbcon_write_context *wctxt)
 {
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
-			 current->comm);
+			 wctxt->comm);
 }
 
 static int sysdata_append_release(struct netconsole_target *nt, int offset)
@@ -1389,8 +1391,10 @@ static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
 /*
  * prepare_sysdata - append sysdata in runtime
  * @nt: target to send message to
+ * @wctxt: nbcon write context containing message metadata
  */
-static int prepare_sysdata(struct netconsole_target *nt)
+static int prepare_sysdata(struct netconsole_target *nt,
+			   struct nbcon_write_context *wctxt)
 {
 	int sysdata_len = 0;
 
@@ -1398,9 +1402,9 @@ static int prepare_sysdata(struct netconsole_target *nt)
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
-		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len);
+		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len, wctxt);
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
-		sysdata_len += sysdata_append_taskname(nt, sysdata_len);
+		sysdata_len += sysdata_append_taskname(nt, sysdata_len, wctxt);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		sysdata_len += sysdata_append_release(nt, sysdata_len);
 	if (nt->sysdata_fields & SYSDATA_MSGID)
@@ -1681,31 +1685,33 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
- * @msg: extended log message to send
- * @msg_len: length of message
+ * @wctxt: nbcon write context containing message and metadata
  *
- * Transfer extended log @msg to @nt.  If @msg is longer than
+ * Transfer extended log message to @nt.  If message is longer than
  * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
  * ncfrag header field added to identify them.
  */
-static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
-			     int msg_len)
+static void send_ext_msg_udp(struct netconsole_target *nt,
+			     struct nbcon_write_context *wctxt)
 {
 	int userdata_len = 0;
 	int release_len = 0;
 	int sysdata_len = 0;
+	int len;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	sysdata_len = prepare_sysdata(nt);
+	sysdata_len = prepare_sysdata(nt, wctxt);
 	userdata_len = nt->userdata_length;
 #endif
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
 
-	if (msg_len + release_len + sysdata_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
+	len = wctxt->len + release_len + sysdata_len + userdata_len;
+	if (len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, wctxt->outbuf,
+						 wctxt->len, release_len);
 
-	return send_msg_fragmented(nt, msg, msg_len, release_len,
+	return send_msg_fragmented(nt, wctxt->outbuf, wctxt->len, release_len,
 				   sysdata_len);
 }
 
@@ -1750,7 +1756,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 			return;
 
 		if (extended)
-			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_ext_msg_udp(nt, wctxt);
 		else
 			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
 

-- 
2.47.3


