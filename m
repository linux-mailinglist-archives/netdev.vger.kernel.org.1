Return-Path: <netdev+bounces-130380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44798A49B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEBAB2902F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1A192D7F;
	Mon, 30 Sep 2024 13:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73856192B6B;
	Mon, 30 Sep 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701955; cv=none; b=KjwTgPpKcYiDFQXSmqJZC3FSBVY3+mVNZEWTMDikOOkSr3rqBjuvJopredLNu2aZ/nc9vUgIsxYnbi5ipW6tTD2Fth2LtAITLesbaU8jIXtIsKdninLHRzBobTVoiq68n93UpDUMf6iU+nRtHo0wEqnBU9CJy+/ky36lf8+DkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701955; c=relaxed/simple;
	bh=WhY8AarLSn1RIRR7rpc3dbIpD+E52YcOd7B65Pc8uJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoPP1w7KnZZaj5Y3WyOLYlGdoV1NRtl/7w5T7ab+XHEHHrqDIBxplinwfwqBYLy7eCU8SJ8ppPdAWbf/U2DGKZMmXUVS5tmQFI31HshvDniLIKGiBaMxMe+VPQmTHd4Rn+4Lh76JR7pC4yZsuqhFt5cUYaTKKtSchKTn8u9wAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so5326402a12.1;
        Mon, 30 Sep 2024 06:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701952; x=1728306752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz+SZr3/kWcukH8OzB83TA3rnjsiwupgf9c024P3hEw=;
        b=SP1XvZ5K84FCxByuZn9e8Lfd5J33Usa3qNAE42Q8YnsME8fr/akuG5jViJHburwcrM
         QVqy9cKruhtJN2ecVcdIy1wfwms91Lp/qHVuVIugOuy7JKiuQZhpuKhqfxlampFNCMCs
         82iFeARVijp1k1AhyH5fLDXzySddBFJyHgnW3yYmNllnGsFCIZNxL5bcekbdlsA3EDYi
         Hfdvh73i4iY31ob5FYSskzxfMeawF83dCbYLJ3mQXdBXxvZL9N3hUdjYAgJ9/wpzy/0i
         egOBUZxEoluAtyzvHYGbFMX7IKVKVE4J8hUfcWPIWZdqAEs3yLY6ErR+k/ZF8/bQdAW+
         HkGw==
X-Forwarded-Encrypted: i=1; AJvYcCW6MlEYe1gVemKkjk0A1oMUuf2nr1vInSTEb586/5i6ZxxVVt2ycLnijLwzhLotvqRv2ib4F4L141mSM8g=@vger.kernel.org, AJvYcCWNMLUxK1ihCwQlmxfZMqUDCSornD71KcVJt4BcHrItza373k/RbVbxTP7f0kVNK9CWa+6JF4pl@vger.kernel.org
X-Gm-Message-State: AOJu0YySfSjaJhX4rvI0UTWQk8TYcp0Jg7f+4ZEIrk1XXY6KcNK/f1td
	9lZ/x0fXpUPz4Jv2PDwrarSWbwh12SEW25U/v/f/gr4hhxqcR1Ro
X-Google-Smtp-Source: AGHT+IFgV7yBJRkLc6WJ2T/GvT1/jjkoLis6hnEjnPgYzYEMF7c9GF911qRl8/AE79jF5/gwyYqkUw==
X-Received: by 2002:a05:6402:2788:b0:5c8:9e36:ccb4 with SMTP id 4fb4d7f45d1cf-5c89e36cf0fmr1934400a12.9.1727701951545;
        Mon, 30 Sep 2024 06:12:31 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882495491sm4489250a12.87.2024.09.30.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:12:31 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/10] net: netconsole: extract release appending into separate function
Date: Mon, 30 Sep 2024 06:12:06 -0700
Message-ID: <20240930131214.3771313-8-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930131214.3771313-1-leitao@debian.org>
References: <20240930131214.3771313-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the code by extracting the logic for appending the
release into the buffer into a separate function.

The goal is to reduce the size of send_msg_fragmented() and improve
code readability.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4e3b68a2c7c6..4a20bcab0b02 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1084,6 +1084,14 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	netpoll_send_udp(&nt->np, buf, msg_len);
 }
 
+static void append_release(char *buf)
+{
+	const char *release;
+
+	release = init_utsname()->release;
+	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+}
+
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				const char *userdata,
@@ -1094,7 +1102,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	if (userdata)
@@ -1115,10 +1122,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (release_len) {
-		release = init_utsname()->release;
-		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
-	}
+	if (release_len)
+		append_release(buf);
 
 	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
-- 
2.43.5


