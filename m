Return-Path: <netdev+bounces-126516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E1971A6C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE10BB23BCF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D51BB692;
	Mon,  9 Sep 2024 13:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA21BB696;
	Mon,  9 Sep 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887306; cv=none; b=N/hlFGkjaBerPQGrXjaDZcxSD8lHvavrtqU5AhRADTexk34PS9unc3QaqqELO3TX98q5EzabwQL6ZR/bDzP4FKNTWbsqMi7NBXLOKHnNm57gwjJKts6UwrQPK7xkWX0XiAf7JCwMkqFCufOMtt4IlHdEBz5/3SL8pi1PHrSWUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887306; c=relaxed/simple;
	bh=EtjSQnPNIJ95ZklMek21/jf8gOIAaIEvedCephVcUxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjFUzdd5VxredMq2WV37LStAM1CVvUjsM2/RfCy/+JsGoKkUsy2PJYYZYdth4MRmIyNbeZLWxPOeGywHTsdhc/hqa7INGaEVvL8tSovS9nv1kk9RYCxWofdhp5Ifgy/yT/uvU5oZAK/7B6/cFg7g7UluotmFC7X/rRKuOkk3uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so2077073a12.1;
        Mon, 09 Sep 2024 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887303; x=1726492103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFn6nX3drdenAEXYyF+UJuZhfXzH0bJrdOrn5tiRtrw=;
        b=rTl9i1kpjAgitHVCrVz6EFogF6HMYiOSfqIoIKtgvFdnxf1iTpCXBn0wr5k0LUxco6
         wperB+poYzwlV3G54zxar2sQj1iBTi4BGFktQ+9WINQRYTeAj9DuwwqFzqg9IpXY2tNL
         mEXpDy0FreGnrqW7OoK91awflkJXc53GH84amvr9Q8NlPhVbEpGXRTCNuLftd6Y3NHvR
         28nAK76HAFGznIYkhSPCBfOrkskAabSl83m3rdZCMpiYIdAV+KmHaPKVysYvvn4QVJx2
         zysf9KDT7jcRDDbnSOoh/8ueHI5c16pDbMXXfiahnW0CQ8kcuwavxOYzbCHkARf2PvYt
         P/9w==
X-Forwarded-Encrypted: i=1; AJvYcCXAX1CjdMo3asLJgrOa2E4Z1fOJHCqwKo9nSS/r5HfhWHFlrGiGQ27HcUXbgNHWrihXOlN4MOTy9YvQbH0=@vger.kernel.org, AJvYcCXwq401wOO7rQGejax8egmKh2+br1ZbIVAmhl25iOAet+aif5GN6zldjhdZqNRDA5piV7cS426C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kI0R2u7OwBzGXVx8WiuLapdoLS6JhG5qNw0NaQl/yXjNuIJg
	br9qwdYBMgjffY9/Qr4gUw91IiZbHQ3VqHmE1QiykkKNzKGzpvhA
X-Google-Smtp-Source: AGHT+IF1WXJ+AkVqtoYOjqn6bdo7t8I7Lssml/gQzNonf6Q+0N2fPfTpXzuazFGy3GPJH4aAHr1FrA==
X-Received: by 2002:a05:6402:5386:b0:5c2:6bb8:1859 with SMTP id 4fb4d7f45d1cf-5c3dc79768emr9939844a12.19.1725887302653;
        Mon, 09 Sep 2024 06:08:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5214fsm3001212a12.54.2024.09.09.06.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:21 -0700 (PDT)
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
Subject: [PATCH net-next v2 08/10] net: netconsole: do not pass userdata up to the tail
Date: Mon,  9 Sep 2024 06:07:49 -0700
Message-ID: <20240909130756.2722126-9-leitao@debian.org>
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

Do not pass userdata to send_msg_fragmented, since we can get it later.

This will be more useful in the next patch, where send_msg_fragmented()
will be split even more, and userdata is only necessary in the last
function.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2cdd2d6a2a18..4044a6307d44 100644
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
@@ -1103,8 +1106,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
 
-	if (userdata)
-		userdata_len = nt->userdata_length;
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
 
 	/* need to insert extra header fields, detect header and msgbody */
 	header = msg;
@@ -1201,12 +1206,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
 
@@ -1214,10 +1217,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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


