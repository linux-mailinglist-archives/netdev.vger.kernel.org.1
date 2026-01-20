Return-Path: <netdev+bounces-251542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGzRNGLPb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D949DA8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7872958D9BD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3444CAC7;
	Tue, 20 Jan 2026 16:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02D44CF27
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926252; cv=none; b=cfmrl+TApnF56jQt42UWICEo33d9SToftc6ErR8aAVwrtbzYfDgignndCk8ioNfxWRDx8fq8nCRJWUyIaztt33x04ySM1S8IEzg2Ov5xFeCoOKspFVBeyEniUq9bIKRmK86n55sHKRyDJd9TC6Uf6P5fIqeyo+lsikIswJsHtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926252; c=relaxed/simple;
	bh=C3+2SHjtQfzMU1QwJyHpzEXry6g/X6KazovqMtfAam8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCvX1jL+UAgEUiwlEBtjYTXscIs2tzSb++95KoIR0pPvqKh67Ja4qguO7H7mF3gzc9cCSUi+3QOqYrjyvQYU5f7EB8Gelmb6+IHQgLMfudW4a4MaFQntUDyvNTtpXXLkHszpyn6/xhAkt5FFBMJ6FxVWBJac8xv/bicmOXWAEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4040996405eso3565041fac.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926249; x=1769531049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBdNkb22LXPO27vypR+xRQjGktOBTrzdp6bLqF4/Fms=;
        b=vJiHL3kT2WSns4fQe8RGMsmJURl8dh+tNNno/0511WKj7/QbQWqAEG475BMUUYYOJJ
         rNNhEU1oQ0wpZEAyeph29Uf06WKCeUVJhk+w1efiW+y+1ET68B72I1G9uvnWbj3RBHDB
         gDMiZBqaeBwqQ6V/wsVLUZujy96C/QxYmoOSz0GgN7TDmUur+JZB/Y8fOlv8skXwbquZ
         vWs6Bldl9OK9sXD3gbzYDoE2uG0p2/Xr/KofLgs7C2hYeuYHBwNL/Srshp0fQexlXrHJ
         SJ5bXBuzoD/2QyGlT+wW3SVYdG+itb4nGlRG3gcC4n7y3o2F721/VfOBiffgTSM8sPT1
         gAiA==
X-Forwarded-Encrypted: i=1; AJvYcCVyyzkoQWDzKGNa5KQ9Wt9XMHEZwohmZiTsTrBx3AQV1/inVb8+OvrpYPJEvhRJQElHnccz3b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjApTdUDoK7rJEJo0lZ9m76JfFDcroQGMfbsreJp3ITukEQ5W
	1VBTctOY8GjvMJvygtT1Vyj7umGt4cjw+aHDrUXxEAARzp3V09+t0Sah
X-Gm-Gg: AY/fxX58I3PC1NFSFY0m/4QReVp348JJ6972r97RqwnDX8/4ZCWI1Pr3Z+MaE+4FOZI
	h9Fla/jikP1lCvDLYs+ffBBG06fdxisxvSCzcZHMQ9RBFMeP2rBQREePLBxHd58PmoUUeXv8k84
	X3qG+SjDSf1NnTvhyhW2bjMyxn3gtBzZjnySvEwOLk1wW0n60OOpXL/+UH6GHWHc33jRBal5+Vf
	HjEFcGAAtl9j787d3i7vZVf+RghvZm751S7HU3JFiblgXVHX8ZvbiggDsMO8NUPm5w5hrTt64tB
	NV9QXLsMMnrwk9kQPOw7+LKcUkgqozgSHwYmoOEPPrXNTkzeivwfctmg8JEdUF2KqLCo67E/MfE
	RzPHTLlbBZlWUXSPjzDsLNHgLAD5uGamtAw+DjAOb2QrCuD8Ec8wdl7aaDi0qp71G1cx//H2gDM
	bllg==
X-Received: by 2002:a05:6820:190f:b0:659:9a49:8ecb with SMTP id 006d021491bc7-662b00f30d6mr818903eaf.79.1768926249573;
        Tue, 20 Jan 2026 08:24:09 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662b6c3ec82sm46001eaf.17.2026.01.20.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:24:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 20 Jan 2026 08:23:50 -0800
Subject: [PATCH net-next v2 4/5] netconsole: Use printk context for CPU and
 task information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-nbcon-v2-4-b61f960587a8@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4839; i=leitao@debian.org;
 h=from:subject:message-id; bh=C3+2SHjtQfzMU1QwJyHpzEXry6g/X6KazovqMtfAam8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpb6wiK2lNijph8Ob3JlC52xe9UowZSXsPao1ib
 h7cYIWiJ7mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaW+sIgAKCRA1o5Of/Hh3
 bTsWD/4sH6rFls+ZfRfP3Z7EbKP8D3TPqBiwU/jlr0DDVtJgFiAtULq7QLF0GVYvRO2Dy78xcUs
 bAgoPy8NQEJKb5mgVcE9G9Nw3P9fxB1jgL93gdxHiXhDUvoLOX/dWLPwklpI1XbkCQTpFUJfqXO
 zDvOOHu6WO4zoVmC+uPVa8WbhrSUfLcEoOhmJywey7VKTGbpkY3rJA+NiMRJMRl/NYQt/bsX1bj
 O6RtPjfMQMX4083/UoZn9I8h/dSU2luo0NQ5IsW+YiLtUe+A3DhQUnGH15aOmpLBrSo6C0mExyX
 KzmTb/MrRcM/lNB5auo1OaL4lpud9szjM4ZTj3YYMo0qo+ebfhXEPiyVTlSqdXrcDb5nPmHJhBf
 cXXBH0oCjcYRJpc/R7WQG85McQslPkeiUDDEBEc6kScqq/SERcXHcZryZ4pzV+aJ86ZGk1lwOhE
 p/wigXUOlk1WxlH3yRB/4aiKXb38FlEOaFnB2trlPrHd6Ipl05zCcpr0PyR0hLyl30VXOniSGbz
 HRHCS9m74iJRh6pMSTvNZXdumt6VLIeid413W+IH+pRcrAvktnEP4x0nGRTOZ2E0yjRkTXXTi+C
 yyliC00jkjaMCt+AHZwsuFtZoZdaN9QzwKJSj1DAbvknbxmxYYcQCf7mvKEi6PuNoyk3jo7Huk6
 GC40G8U2R/TyuMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-251542-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 810D949DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/netconsole.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c5d7e97fe2a78..d89ff01bc9658 100644
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
@@ -1681,31 +1685,31 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	sysdata_len = prepare_sysdata(nt);
+	sysdata_len = prepare_sysdata(nt, wctxt);
 	userdata_len = nt->userdata_length;
 #endif
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
 
-	if (msg_len + release_len + sysdata_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
+	if (wctxt->len + release_len + sysdata_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, wctxt->outbuf,
+						 wctxt->len, release_len);
 
-	return send_msg_fragmented(nt, msg, msg_len, release_len,
+	return send_msg_fragmented(nt, wctxt->outbuf, wctxt->len, release_len,
 				   sysdata_len);
 }
 
@@ -1750,7 +1754,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 			return;
 
 		if (extended)
-			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_ext_msg_udp(nt, wctxt);
 		else
 			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
 

-- 
2.47.3


