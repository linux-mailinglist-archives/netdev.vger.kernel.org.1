Return-Path: <netdev+bounces-136504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10119A1F0C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F0286138
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC81DDA14;
	Thu, 17 Oct 2024 09:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8D1DDA1E;
	Thu, 17 Oct 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158668; cv=none; b=JKPruj7+AwbaQDPapEtI8uvpKBb5OaoQq5ve9gc0we8w+s/1aZX8Eel88KU2eCBff2gxTsx17rIbYYOUgl/tU5a1my5aYKFt69FqQLcnd55sKi/TXiCmafcCQRvEFvS98EDDwZZZQbpCtU0WF2LvU1pzDwyADzFv34WVXIg+bYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158668; c=relaxed/simple;
	bh=CK6YVX7DrhvqsRMXrMk7N8jXqOjvz5bNUqayjvuoHek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqAWxMF4FOnIKt4y/1gzb8+zktnZ7IBN1IM+WLYkhtvQU2jpHaxTyJqx04nAJr1Ev6QeX2m0xPSWxQcjCZv1cBRtJhjCBSeZ/5RnJYglT2yumh7MsYzaxMEDzUGvjSjydP3hTk5IBvFYK4AOeU2etl1Gw9FfXDeQn9BpCINfkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99cc265e0aso90655866b.3;
        Thu, 17 Oct 2024 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158665; x=1729763465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMa9T4GRybMuiSZbSNjPfnUtfOBoz1IdxikzoXqbnME=;
        b=UY05XAXtbWz5ie5RJqovrwP7LotZphMB8U3FpTxQchBtRoBs+SAd6vHiYXCOWEjS7q
         6PxBMg5BGkA84QvFqoeVlo7sHHsVvixcFl3NkG80u3CDHvK2X2FfVdfrNPLqLRkseiqI
         V208cvZGhGXh6Z4vRU7XzpFwsPy45zqQx2mJGOsL0uoYXnGj2Lcb629lWs7qsdGP4T2n
         aRvUyG9C8SKbWJK85vXT/4p0yu6aqB1KqIYebyz0V85E4ccwKEjwWZHpqFiVGPeFIozh
         /JJMdpO+UieROfjhlu0lUFoXw1GFQyuo4UMld/CftjaoU6fjOBHOue5osVY9KHDHCeUg
         8T4A==
X-Forwarded-Encrypted: i=1; AJvYcCUi3nYrWkTqeF8jo4Mkeorxe3f592uDX3Mcl3t2yTK71zYPmTufBQqKfxZReLRvw4zr17PGTYIm@vger.kernel.org, AJvYcCVdybOj2cOI0WuT5vEbrjOSWZp0thsHP1ciZw/0LlP7ErikR92VxjSG1FrH+6iWqNkBBwbcwnOJn2FUkZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyH/i+OlDmhrzcMdOjDMeBw/quhVJzugU9mPFpsdy6pTthyKT
	IZL3qa1oqh6s8AoOd7bubt1J8wgWR+eWXvXK9dXl8izquIfdarYp
X-Google-Smtp-Source: AGHT+IEBJWX1Qsqdjfs5888W8eeR8qgYZe5327bEqWvzvSaplKe63qpSpB17OPBrqaeBMG9Z4E8tAA==
X-Received: by 2002:a17:907:3f9e:b0:a86:8e3d:86e2 with SMTP id a640c23a62f3a-a9a34c8357fmr582735066b.11.1729158665339;
        Thu, 17 Oct 2024 02:51:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2971b0bfsm279935166b.10.2024.10.17.02.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:51:04 -0700 (PDT)
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
	max@kutsevol.com,
	kernel-team@meta.com
Subject: [PATCH net-next v5 8/9] net: netconsole: do not pass userdata up to the tail
Date: Thu, 17 Oct 2024 02:50:23 -0700
Message-ID: <20241017095028.3131508-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017095028.3131508-1-leitao@debian.org>
References: <20241017095028.3131508-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not pass userdata to send_msg_fragmented, since we can get it later.

This will be more useful in the next patch, where send_msg_fragmented()
will be split even more, and userdata is only necessary in the last
function.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e86a857bc166..b04d86fcea8f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1060,13 +1060,17 @@ static struct notifier_block netconsole_netdev_notifier = {
 
 static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      const char *msg,
-				      const char *userdata,
 				      int msg_len,
 				      int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *userdata = NULL;
 	const char *release;
 
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+#endif
+
 	if (release_len) {
 		release = init_utsname()->release;
 
@@ -1094,7 +1098,6 @@ static void append_release(char *buf)
 
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
-				const char *userdata,
 				int msg_len,
 				int release_len)
 {
@@ -1102,10 +1105,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
+	const char *userdata = NULL;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	if (userdata)
-		userdata_len = nt->userdata_length;
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
 #endif
 
 	/* need to insert extra header fields, detect header and msgbody */
@@ -1208,12 +1212,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
-	char *userdata = NULL;
 	int userdata_len = 0;
 	int release_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
 	userdata_len = nt->userdata_length;
 #endif
 
@@ -1221,10 +1223,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		release_len = strlen(init_utsname()->release) + 1;
 
 	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
-						 release_len);
+		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
-	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,
-- 
2.43.5


