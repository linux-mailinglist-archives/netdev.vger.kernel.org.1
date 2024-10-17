Return-Path: <netdev+bounces-136501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE09A1F05
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECEA2881C2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6121DD0F6;
	Thu, 17 Oct 2024 09:51:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897C1DD520;
	Thu, 17 Oct 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158662; cv=none; b=b6n+sG4F1YWMSNNIPh1lrT3tKsKkUZiUQwTC1Q5Qdnk3YDT4SBEl1Ufc+UoK93lCSmFJLndhdpV6BKLU5KXSEEz9bL5yh+VH90xmefaCMF/4Ob8+KVZfasyP2byWHEs7PipwqTwfFKvrNy6kcHtslZ12G728mSBosTm4p4rkqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158662; c=relaxed/simple;
	bh=DlibL+TKZQO6tpM9TN61ilfGkoHxF5bxE7lVgrwGP/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMUrWh3zRDQeqIBQJM86628TwHhObB/ZyfBLWns/tarW97G63XtFm7DISiaSx7waczDJIYN1bmnr1keM0Be0AvlBRt3TmA0xbiIb+3wBBpp1TOXm8Ypmy7+hWg+GPNKfcDUPGDMzTgtzVFbPRklBllVP3v8dTtfVzuXxBukG6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so950512a12.1;
        Thu, 17 Oct 2024 02:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158659; x=1729763459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A70dRnWs3e7CjR+g318TfrfK6CTl+FDvGZYubUStoxw=;
        b=Gckk+WWb/gII6c2YpV+iS4gu30LdM+YhF6L8mkbcsCf/O4R/YctFMcvDN1cZ8VAtQF
         p1Hejmd/dxIbplJfBbUy5G2X9cBZh1MPthO1mVQWCEKxBByHRoED1Mz4uOnOhtEsicSR
         ukYMtUYW2IjYyIO5p9kirzUgZx63N4cjVZ3FIFYGir59VvVa8wY61lGtbudkWovQFY7M
         Ewco688+1j4joC0pFGIE4nzbAXQtMtQR+0cMGuQaqknBBaV6wzRMgOZzJm696C+sRl4N
         d+hPyw3BmhM9D55K7EvrsIZBPQdYsAlBU3qyxdBW/m+fxBLrVSoiaPaPNAK921+0seOF
         7mOw==
X-Forwarded-Encrypted: i=1; AJvYcCVBz/kVQt1dzI1M9F0UJb17AYxtQG7YsnlO4en1CanQwuEerYZtmMtCJlXidAVioWc3HP/DZ3hn4FlU1Ps=@vger.kernel.org, AJvYcCX4+MTw5O7GAkx0xyVO+Vw5EMhi72Shug5yRsOhJks+2dM0AMznXtTAoS//y3tuRvx4ACV1tKGe@vger.kernel.org
X-Gm-Message-State: AOJu0YyReeqdLCSstqRfU/rkMvAXdJHSpVBS/AL2AyMUWUEjG2/6jnaz
	AkkiOKlV9WNyJZimqfgD+lU/5hx5mbrDQXLiCNPuCv1B9l07bAna
X-Google-Smtp-Source: AGHT+IHgBrNUNt9pWuE6OKsaGLrZFWsECCvUdzBJlFBMremSPxwLuNI9TXOvYhumBva5l/qA4AIfjw==
X-Received: by 2002:a05:6402:2714:b0:5c8:8d5e:19b0 with SMTP id 4fb4d7f45d1cf-5c995121654mr5881806a12.30.1729158659158;
        Thu, 17 Oct 2024 02:50:59 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d7b7be8sm2548554a12.97.2024.10.17.02.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:50:58 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/9] net: netconsole: introduce variable to track body length
Date: Thu, 17 Oct 2024 02:50:20 -0700
Message-ID: <20241017095028.3131508-6-leitao@debian.org>
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

This new variable tracks the total length of the data to be sent,
encompassing both the message body (msgbody) and userdata, which is
collectively called body.

By explicitly defining body_len, the code becomes clearer and easier to
reason about, simplifying offset calculations and improving overall
readability of the function.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3f59b841d659..6a6806eeb0c6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1090,10 +1090,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				int msg_len,
 				int release_len)
 {
+	int header_len, msgbody_len, body_len;
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
 	const char *header, *msgbody;
-	int header_len, msgbody_len;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
@@ -1124,10 +1124,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
+	body_len = msgbody_len + userdata_len;
 	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	while (offset < msgbody_len + userdata_len) {
+	while (offset < body_len) {
 		int this_header = header_len;
 		int this_offset = 0;
 		int this_chunk = 0;
@@ -1135,7 +1136,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 msgbody_len + userdata_len);
+					 body_len);
 
 		/* Not all msgbody data has been written yet */
 		if (offset < msgbody_len) {
@@ -1151,7 +1152,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		 * write, append userdata in this chunk
 		 */
 		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < userdata_len + msgbody_len) {
+		    offset + this_offset < body_len) {
 			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
-- 
2.43.5


