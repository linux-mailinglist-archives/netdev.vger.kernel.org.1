Return-Path: <netdev+bounces-130375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB098A46C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B433A1F24055
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E81917E3;
	Mon, 30 Sep 2024 13:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F819049B;
	Mon, 30 Sep 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701945; cv=none; b=laL2aqiwUZ5zJps+49/Css+4rLi65G41lD1fxHq2dAVjliKb6tz+tNMAndzEFU4H6K2Q0SDB0cm2JM2ICS5fYsvbERj2hSS3ob8wVZNRb4GkKx8V5HZFfbXsxpH9N+I48czSu2Zj9YdoDqk4WmXcyVujzMquxdiOzImuFzKlITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701945; c=relaxed/simple;
	bh=oJIDy0qtaGw6j830beA+G8p0IPumns4yvWEkwTqum/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brt7oxET1m/Gunxw7AqDIuSx+FDQuQhxTjE04W2s3zXPemkfaRpn5aqc3P4jh+JamJmlxnaddgJefCvcMwHLDl4W+/w+O4M+Anzn49SbpVDpreftz2x4F6aOLFOftdpnUf/9Sze/nGSGxcsWcF0dL4dspR4B+LnVQFaKtFBtobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so6469535a12.1;
        Mon, 30 Sep 2024 06:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701942; x=1728306742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8arzrtSLiNViV6wdJz5xajd0j0cCB30Ei22v2izotk=;
        b=EExCKw1SIZg5EfZ+rKDRl5QFJTp5uI+pxJLMEjIus8AslFdyqYsRT5LmIMLNB7DXsp
         +BgiGNOnlTnMPmp+JR8QzUpPw1ccgAjxINsLTlugqCdgh8xGeB0c73UTyrAsqTEbtTZ3
         11TFeigzzdhIA4kVB7hWdD4MM0ZtUbLI0Bc4k4P7xnKQsDpZymMqnKCZ8AmkT0Smi1u9
         DdTeOINjkEHB+txXwYu1A+RAI204i06brqp2Psm1TniPnnuqzqlrwRRlZ7wsAiISEaKf
         Ftz0b9Gw3AjSlypsCiBjuoi7VH9ZXiJz/mBf5QeirLwJJ1KksCOKpi6Aci3TxqYBuAjL
         27eA==
X-Forwarded-Encrypted: i=1; AJvYcCV3uNdFQyoiR7uXGfhuflSjXHfl8RGpivXmCce7r097BzGR5tnJiWt9PIjn4ozQft9j12yiDWyg4axkuF0=@vger.kernel.org, AJvYcCX85NVHKov/RZVF+pR/OeDnOtpecusXZTbx85UzThhMCjKk7RJCnyuDXl9Nj827DaSDhXHLaxhD@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsA1My2tnXakkdmOVPcDyqhq3g/PcY7XlCS/4je+DLyNtCdBC
	NZ7HY/PejKAZz9/5h/wjmhFZdvChudS0LSyzc0WbxWiFYkjMM3Q/
X-Google-Smtp-Source: AGHT+IHyBpmUVzZ0O2BMdKrjyrPUVceR2YtVu1A/TtxUg+WNR62bbWI8Ib0xVC2GwGkjCVg1rN8wZg==
X-Received: by 2002:a17:907:31c4:b0:a8d:4cec:fcec with SMTP id a640c23a62f3a-a93b165dbafmr1719795266b.26.1727701941952;
        Mon, 30 Sep 2024 06:12:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948231sm531563166b.99.2024.09.30.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:21 -0700 (PDT)
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
	max@kutsevol.com
Subject: [PATCH net-next v4 02/10] net: netconsole: split send_ext_msg_udp() function
Date: Mon, 30 Sep 2024 06:12:01 -0700
Message-ID: <20240930131214.3771313-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 03150e513cb2..d31ac47b496a 100644
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
@@ -1090,23 +1116,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
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
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
+						 release_len);
 
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
-- 
2.43.5


