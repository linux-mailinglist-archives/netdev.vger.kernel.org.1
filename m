Return-Path: <netdev+bounces-126513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956D971A65
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8951F239A0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961001BA888;
	Mon,  9 Sep 2024 13:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954D1B86E6;
	Mon,  9 Sep 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887299; cv=none; b=eZuzsWNEgx0WiFK2rHKdzlMr6+e1+HL4XZiDwvsfNJk+QgzUplMk+71pUNWTYIJ/ubfTykuhx/VmqAlKcppzh0MEUlWbK/ZSdc4qjn/EemRK5AX5gGXaz2y1glwZ+ZvkerBkVR7bk5Wnlj3R/eisHaUCJ/871SARAtfFA3EgqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887299; c=relaxed/simple;
	bh=VV2zpiuKj7DKyxtXNIqhoTQLV28baNogHGEr1Aqy9DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVyx7+D3urcAg2nl7gwAvb39N5Arhg2GVUxyTde3P9+9bRUfnJN+olCVHOQTzxLqchVUazMmppKMLEoWx6wuIERy5dqdUleyJLcsnVsBaSvudmeaF7O3AmNYUuA5QJg6GuRdm70aL1Q6z+XPAPCPKZkV/YEDe9KXQudt3U8Tbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso5371903a12.1;
        Mon, 09 Sep 2024 06:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887296; x=1726492096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYym74QBEdDEHcZ5TJhaGw38Vw7Nq8JnshvqDISovk0=;
        b=XrvLL1RW5fyEj5U+EnbXAhedgzJHSMVk9hrakEtp//IFi6q0yDbRMV4Yx/tuJXF3cM
         EfNOPW8zm8dS0rTqR3ygyQfeOX5xtia1Xan15tN7wsU6KIWqBjxHXIReChJXyCyN3uJl
         gHgWciKmHxlikNvcdu3N954wK6VD34Y9wX77dPX9jj8HHQzVBwugQgqkt8fCU03YSTa4
         VDEV9yz7/KSmmHtar4oHVKK/d++YvIgalFsjeg3/WZAtmTHRMCv0iYtLUCKVSXpm52cy
         deTC3cvmecAQXvgyqg1kFrxcUO0Rx5LrXFJDD+opH7xsSTzBldsxOctt8y9/pB3NY5i1
         5SEA==
X-Forwarded-Encrypted: i=1; AJvYcCVYgIMUcj2JncOwTEXQrs5KdaCYMKOQfrLl0YfBFARDhjgp68Gpl9QxUAPlUawPWTvbpRGLBHHQ@vger.kernel.org, AJvYcCWNIPf1n3xbgLjb/kPvmfpPnj7acDyearHMKxCwT7joXw+YJKJwOSSZ7whySC2T/HGebdDzA1kfD+AYrcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxowoJ/3rQjTbYi9J3S+7guYKyRjaidrH2mQspTvjSI4PyrHGIf
	JXa/DyvxKOlD2WYKhRtCwY5pshzZkbLCjL4xP4+CGd5Tc3XP2oC4
X-Google-Smtp-Source: AGHT+IFDCAF9grHK/Qjnq7X6yZMGXs7FxOrYGIh/j4dbO3psd+oC9B/3WgbNkSBTr0aU2w2cV/j7xg==
X-Received: by 2002:a05:6402:3718:b0:5c2:6fd3:4a36 with SMTP id 4fb4d7f45d1cf-5c3dc79c8b5mr6954379a12.16.1725887295971;
        Mon, 09 Sep 2024 06:08:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46886sm2955479a12.34.2024.09.09.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:15 -0700 (PDT)
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
Subject: [PATCH net-next v2 05/10] net: netconsole: introduce variable to track body length
Date: Mon,  9 Sep 2024 06:07:46 -0700
Message-ID: <20240909130756.2722126-6-leitao@debian.org>
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
index c312ad6d5cf8..e3350016db0d 100644
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
 
 	if (userdata)
@@ -1122,10 +1122,11 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1133,7 +1134,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		this_header += scnprintf(buf + this_header,
 					 sizeof(buf) - this_header,
 					 ",ncfrag=%d/%d;", offset,
-					 msgbody_len + userdata_len);
+					 body_len);
 
 		/* Not all msgbody data has been written yet */
 		if (offset < msgbody_len) {
@@ -1156,7 +1157,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 		 * write, append userdata in this chunk
 		 */
 		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < userdata_len + msgbody_len) {
+		    offset + this_offset < body_len) {
 			int sent_userdata = (offset + this_offset) - msgbody_len;
 			int preceding_bytes = this_chunk + this_header;
 
-- 
2.43.5


