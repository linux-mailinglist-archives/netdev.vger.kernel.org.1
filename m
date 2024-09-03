Return-Path: <netdev+bounces-124563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDE969FE0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D021C22EB4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330469D31;
	Tue,  3 Sep 2024 14:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FF57CB4;
	Tue,  3 Sep 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372490; cv=none; b=VK0diBLL/Ec3ixwGezNKg37OONAzgCokBEc604P6TK7uieognuFV6VeLZsZvdv+2tDREkFe3pDujk7VG1V5/p4c+3jTtp3wbbuzju1lkrYzw07NHo0SzrSSdbq0nIdguxSOo2A7ZUVaSfvPkwXIEVUGgxahfIf3WlTxgEwOO2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372490; c=relaxed/simple;
	bh=J0ax/ms6BPhc5dtWz04kXQJE9Gp7S5ZujB4yIpDHEQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faH/vHnT5arFXTcvXiNfeXxcCO+r6j3Fp2XMQcE/Z52y4HFrkOqsXztyiuuO9wInDOuBTFCA6AUWOrSCovX7rgIo6Zo1H9gn/VPbqTLpo8MbE2KUlfG/6H83taWIyP+hJvdr2mLOSf3t5NOXPNpoy08LOsOZ2dcrfx8ilFvaYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so3626967a12.1;
        Tue, 03 Sep 2024 07:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372487; x=1725977287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhnUKYBqFoU50t/k4XKsK4OTUU5YHkYgYvF+1IbO5bo=;
        b=u2JtLI0/DHVFXZyQzpUG1SQ+4YTXavoQTwwu+ILmgSZQFqcGSdAUOxrXpQAdgpvED0
         McMp36dI6CBwLd8CyPcJtPwAlD3CZMUoBttTznTXgQKtzsNj//Zffkb/zI/Qd5xiPN9C
         0cTLBpj+nS168kn6ISvtpKs4RoZYQPbyXms+jQCrZ7yqJxWQI23x1CximDBi6XfbuilO
         5QI/9ejshJJre9K+jmAJUWrxq/mJlryNljNB6edY2F2QQmWC8UzcPvW59kCU6fuM7FpS
         tgpWpxFEpi0nJSV/prd5pdzTGVzhBHUn7pSnV3PvSqBZEmURZfhuJ7mgaCwjdK4ZWztE
         F3fg==
X-Forwarded-Encrypted: i=1; AJvYcCUsz+uF5hBZNpBkjIZNbKHrMGQ+Sdkn+onQDW+4wcdWKXv1y/OC67ECTwHNC1x7bLs3LiY/wiDTtEpEI3g=@vger.kernel.org, AJvYcCWOOwEdehdLxi63T8AtAy0UwdZ0syy95rc3HioZgyM8imOoOEw/yDYbEJmajvAWpYqGeM+rqFFr@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvpPNfX5MCGlbysY68/xPqwrgdfWMyjD/DiQAaSRspQz2dfu7
	i7+76vTlb1MbXtP8kF6aMzJEiUmtJbiytRJAk6oqOMyeOoaEYEUQ
X-Google-Smtp-Source: AGHT+IGb+WOqC2JVe3SnaVQOL/Fh5lVOUVB06ELOQFXMZb7AH/Lp2oaPuPmB8GSHWYXVSIxFhx7mqw==
X-Received: by 2002:a05:6402:350f:b0:5c2:6e51:9d1a with SMTP id 4fb4d7f45d1cf-5c26e519fdcmr1718563a12.14.1725372486302;
        Tue, 03 Sep 2024 07:08:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c243054c26sm4405248a12.15.2024.09.03.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:05 -0700 (PDT)
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
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 2/9] net: netconsole: split send_ext_msg_udp() function
Date: Tue,  3 Sep 2024 07:07:45 -0700
Message-ID: <20240903140757.2802765-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The send_ext_msg_udp() function has become quite large, currently
spanning 102 lines. Its complexity, along with extensive pointer and
offset manipulation, makes it difficult to read and error-prone.

The function has evolved over time, and it’s now due for a refactor.

To improve readability and maintainability, isolate the case where no
message fragmentation occurs into a separate function, into a new
send_msg_no_fragmentation() function. This scenario covers about 95% of
the messages.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 45 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 03150e513cb2..0e43dacbd291 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1058,6 +1058,32 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+static void send_msg_no_fragmentation(struct netconsole_target *nt,
+				      const char *msg,
+				      const char *userdata,
+				      int msg_len,
+				      int release_len)
+{
+	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *release;
+
+	if (release_len) {
+		release = init_utsname()->release;
+
+		scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+		msg_len += release_len;
+	} else {
+		memcpy(buf, msg, msg_len);
+	}
+
+	if (userdata)
+		msg_len += scnprintf(&buf[msg_len],
+				     MAX_PRINT_CHUNK - msg_len,
+				     "%s", userdata);
+
+	netpoll_send_udp(&nt->np, buf, msg_len);
+}
+
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
@@ -1090,23 +1116,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		release_len = strlen(release) + 1;
 	}
 
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK) {
-		/* No fragmentation needed */
-		if (nt->release) {
-			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
-			msg_len += release_len;
-		} else {
-			memcpy(buf, msg, msg_len);
-		}
-
-		if (userdata)
-			msg_len += scnprintf(&buf[msg_len],
-					     MAX_PRINT_CHUNK - msg_len,
-					     "%s", userdata);
-
-		netpoll_send_udp(&nt->np, buf, msg_len);
-		return;
-	}
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len, release_len);
 
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
-- 
2.43.5


