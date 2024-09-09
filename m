Return-Path: <netdev+bounces-126511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55241971A60
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64DB1F2394A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC331BA274;
	Mon,  9 Sep 2024 13:08:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7C1BA275;
	Mon,  9 Sep 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887294; cv=none; b=FMFqIULTHYBu3SN1yYiyc0MpukCkyug99zGLobuhvwG1rK/punGTkjnAUsKXuK01YV5OCyigK2h0cye/WOC9RGnBY2QJSXtoxhpGiPipcor2KaKcSM8hiwB9SLKq65ZIC7ucbKkZCT74xrUFBVSJWJKFk4uB/x8WcgMwaNN+bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887294; c=relaxed/simple;
	bh=b0aIxet0QXlwVUlrSckU71HVdA5OMCthBU4wm1Oj+xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp10LS/eB/ipQclc5e+3dImaGkFcozg1bdfaGXrgWTSuoXXvO05iuaAGrt2ouGUrSV5FegHdEKhh3cYsKN2g4Qa5kzCwIeJ9gO660XKSpS3oYvGvKnWwfC+vHx5R8AxtxNko7IaIfCP3fHrU3er3G9Wqij0/4g5cEo/yHbrOtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso4025990e87.2;
        Mon, 09 Sep 2024 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887291; x=1726492091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6YmRt0ZJ0d/twgod5Qz5nnBIxWY8JCvQ0B1lUv4E5Q=;
        b=Z4ZSmg0Cl/jYk+bTI2nI4rfvoGAXNEjHmRneg63oapeG56pRR06e9n0sCdIz8y6yX9
         u9dJsTfgpBsZ+OwxTYBTGOqqVbecePzLwgWyAwQmPfOOkQjwhd1X2YEF1+5DlNpw/k8V
         lMgGj0HfVxCxpl1wGn1DVh0FKxMC0dCfeEkYjxDY0/7t6+MQKn1bex8p+/4UVvh41H5i
         GAchheFKik54eEjXBdnza1FUCbuat0GuI6vUpzy+X15BJjzUd4Yd0G6bT0NknUNNT/RY
         dfParut6VaA28L8NEih6qec6lRI1uT5JPyzpf8pJyj5MQAxQOUdMi3if4NUgOXVZmTpa
         1CBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0owp2mnboJe6jj1Lmt0XtpuEqJ6/Z8vs2voX76kBEbgTVKi+4zfT4QiQaqHyu4GC8U61VIFJ4@vger.kernel.org, AJvYcCVyeV80BrByLTdZe4YG/gsTN2MZa/srD504RUTQup9Sh7/+rq6UZAtUBkiVTTgz9CjLMfHtL7fiPePia2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkve/YsEahEKJYnfxcykTCUoqedHznVJbofYQYU46LLLJQGfB
	reCoRxHHrz8vL5SB+GDydvpYSxTNtUpNxe/7DQcMJcWMbTOFRa0+
X-Google-Smtp-Source: AGHT+IExl/fv4Y3nhEX82xi4IAL0eKbKKENkaDQZmm2yCCuqZHcYv6CWlRE0a36E4y2s55tVOl2VlQ==
X-Received: by 2002:a05:6512:1386:b0:52e:fd84:cec0 with SMTP id 2adb3069b0e04-5365881028bmr5805104e87.52.1725887290637;
        Mon, 09 Sep 2024 06:08:10 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72815sm342825966b.140.2024.09.09.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v2 03/10] net: netconsole: separate fragmented message handling in send_ext_msg
Date: Mon,  9 Sep 2024 06:07:44 -0700
Message-ID: <20240909130756.2722126-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the previous change, where the non-fragmented case was moved
to its own function, this update introduces a new function called
send_msg_fragmented to specifically manage scenarios where message
fragmentation is required.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 78 ++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d31ac47b496a..8faea9422ea1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1084,41 +1084,20 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	netpoll_send_udp(&nt->np, buf, msg_len);
 }
 
-/**
- * send_ext_msg_udp - send extended log message to target
- * @nt: target to send message to
- * @msg: extended log message to send
- * @msg_len: length of message
- *
- * Transfer extended log @msg to @nt.  If @msg is longer than
- * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
- * ncfrag header field added to identify them.
- */
-static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
-			     int msg_len)
+static void send_msg_fragmented(struct netconsole_target *nt,
+				const char *msg,
+				const char *userdata,
+				int msg_len,
+				int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	int offset = 0, userdata_len = 0;
 	const char *header, *body;
-	int offset = 0;
 	int header_len, body_len;
 	const char *release;
-	int release_len = 0;
-	int userdata_len = 0;
-	char *userdata = NULL;
-
-#ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
-	userdata_len = nt->userdata_length;
-#endif
 
-	if (nt->release) {
-		release = init_utsname()->release;
-		release_len = strlen(release) + 1;
-	}
-
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
-						 release_len);
+	if (userdata)
+		userdata_len = nt->userdata_length;
 
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
@@ -1134,11 +1113,18 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (nt->release)
+	if (release_len) {
+		release = init_utsname()->release;
 		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+	}
+
+	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
+	/* for now on, the header will be persisted, and the body
+	 * will be replaced
+	 */
 	while (offset < body_len + userdata_len) {
 		int this_header = header_len;
 		int this_offset = 0;
@@ -1184,6 +1170,38 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
+/**
+ * send_ext_msg_udp - send extended log message to target
+ * @nt: target to send message to
+ * @msg: extended log message to send
+ * @msg_len: length of message
+ *
+ * Transfer extended log @msg to @nt.  If @msg is longer than
+ * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
+ * ncfrag header field added to identify them.
+ */
+static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
+			     int msg_len)
+{
+	char *userdata = NULL;
+	int userdata_len = 0;
+	int release_len = 0;
+
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
+
+	if (nt->release)
+		release_len = strlen(init_utsname()->release) + 1;
+
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
+						 release_len);
+
+	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+}
+
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
-- 
2.43.5


