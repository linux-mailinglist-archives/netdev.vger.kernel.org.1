Return-Path: <netdev+bounces-126926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F672973110
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39A61C24319
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF11940B3;
	Tue, 10 Sep 2024 10:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB0192D96;
	Tue, 10 Sep 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962669; cv=none; b=hfQIUdSqsSj4wnRQy1fUzzI9j5q3eyDl4uTzMrGoOsxftmRF9EqlA1pMVELSM5ntt/IlyLrvKw7oqrr8gp9caoGG/U1lrR6CocZDNZsDqGSbCSb8pSWhJHpWdarpebdH9JWQ2aS+RBDlQYifooTvV+6jZSsJo89nbt2AnWySLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962669; c=relaxed/simple;
	bh=b0aIxet0QXlwVUlrSckU71HVdA5OMCthBU4wm1Oj+xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXfV7UHtFAubAOk8mgm0o11s2/2a8zRjLn0ZfuO+/fk+/3+I48QHzDhYxyaKUoq2ibo4d3ZhsLDMB9nUrBe9n36DSF3DNoNmAbN4yFfHI08GP7e9nZMk4Z9xaoAjz1EsDMjINeZxWU9iJfNDF/6oNvTzkRe10YEc41Jp4ZCG7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so411293566b.1;
        Tue, 10 Sep 2024 03:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962666; x=1726567466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6YmRt0ZJ0d/twgod5Qz5nnBIxWY8JCvQ0B1lUv4E5Q=;
        b=kQhEVFg0UXGxj24KgOzDtS2hvfCtp4YxwCj6ThYBYaH1KLfDi4Zo1DRH3hZZ/6LM1j
         iTcGfg3kpbghNMg8elt5qVohpOpBHbN1IBNQNMr4gPn9rODRg/Gg3jKR3LWD6mCBM/Yl
         F61ir/xmBhYldh6RUjb1wJPx8oHVM1tXt4w+lawWG49ZLVOE5N0dn5rnH12SOw73aaG5
         irr1poLooa9aFRP92XQlO6A+nXGRc3Njs9LfjLUlYOtDPgmedeJLqwQ9GSCT8D6VOawp
         XcXZg0K/a+W4Mfhti/XQj/b1DsiGNcA7hQikb3s9W5cxDbhj07eB48nrTfPWHOWoYKzl
         LZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUChveBrZpLyCUphamO4NawvfipT4IteOTpm7iAVXmg1Mqm5gYpaYcTl9Du5PvNHbMmxUzVhCAlAdm2kyE=@vger.kernel.org, AJvYcCXnpT8XalR/dH8ZvGEItwO0jjjh5e3c/ugm4D2Cz0X0ebsbchdz/OJ++M/BCt7ggtRV5LnXx2nL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxamr8KUXQn0W/0egQDbi8xHVACgk6kUNpOmUuYV/u5hXVoQiHP
	FVLCWZAERfRijn5t3lrbrh6hDDjNqV1Hc5pwioiZ2CFnGAjxsJMp
X-Google-Smtp-Source: AGHT+IFSG0Q3/0KAfQPCfDnyMN9V6STYJa1aHoiU6E4XT8a2r6mo+jKSOyxoV9lh1Gi+yZAM5KbckA==
X-Received: by 2002:a17:906:6a1b:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a8ffaaa23bbmr26374166b.9.1725962665751;
        Tue, 10 Sep 2024 03:04:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce96a7sm458426766b.158.2024.09.10.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/10] net: netconsole: separate fragmented message handling in send_ext_msg
Date: Tue, 10 Sep 2024 03:03:58 -0700
Message-ID: <20240910100410.2690012-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
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


