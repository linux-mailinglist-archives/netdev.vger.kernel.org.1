Return-Path: <netdev+bounces-124568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBD969FEA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CB3B25A86
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281913D625;
	Tue,  3 Sep 2024 14:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69013C809;
	Tue,  3 Sep 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372499; cv=none; b=NZDhFoupPRdnad0ybtcRsHy1+zUglwhu0HPFpVXRim1JnuUhftUDIeoH8rRWt5qDv4rMDUsUn5QUSDSMqdEVQlqWRBcBNIU2HpSccDHOSkUhLX/E/PszXsKxfKwgjW2PeCkl2cGiiVWrgb6PPrGyzX5q56DGxejVhjkZFhmotdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372499; c=relaxed/simple;
	bh=+M7qNuodo5sP01NttdMsZ+3umS8JGZnU5Tz9IBweLxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OilW8QTRUu3Q52qX33O1YGcKkCyY9l365cHLKuopFgxOPZzbd7juAaLCxW1P5Hr/mPLXsaDS+hkHWYaqe0l4taY5Q5TeW7gFqw5g0c//RR2n60d+0y29CPdTmCr9MUdNXYOFtLBice17V386qAPfu70z5rdxM8lki0cvPQjhtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a866d3ae692so307864466b.0;
        Tue, 03 Sep 2024 07:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372496; x=1725977296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnViOBozUk8wAT0QTZsOHNZO3CKQ095N/f5pUDM9mxI=;
        b=C/M9qTyYxuriddn/3v39QPzD1PppMy26vyTyYgpHrZVA3ek7plIsMAy5J+aFIrHWWI
         LDALhjowS+9vdAAJhZxKBYsVXCzCqZIpVEG5XsF4Ny2TRQYcXOtVBP+nrj7Sy+JMkiZy
         7zgm9TxXvcjQlnPdI3acPF9KbrI2WTwjwo+0lCQLHXpmoV76+TZ8DZCYFano0WPRawwf
         z3n76d9Prhh+ygPJjjanstPwukSybvHt8EbzEoJ3O73C7hT73DbcKymq1yoPe/wegQd+
         DReqWXuzp07Zq43U0EvI4FnSqAZJUYr4xlsJ9KfrBGR/OkKEP6ePS6a231DOngDB1MV6
         5iCw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgHNF10VWEN43epjyMhVdEJYuWi0yKxHAWc38CwZ6X2VfP4a6xABVzv809t2GlqAjol4af/1q@vger.kernel.org, AJvYcCXhg4A+c1nI9UCYGGTEf1mrTwAw0e8nmUGug4l/OJTIT/BTijVZCiISvgEodQcFllyyzLJSMIL20jwSJ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLECy3HTpPsaW3dBO7ElceEVOLlxxlQzPba5xIdpacY6UCOMN
	YN+YSARSXMR8VkfDsfWDqY+eXAJkXBjzMlua2ArnKZR+8NNpaL+M
X-Google-Smtp-Source: AGHT+IEo+Yj6GkA9PjgFilL8U4exSqzOIEsEaenuHaaVd2L8e+E2fX7KfM3shNgq1QOzqbSAZ9tmpg==
X-Received: by 2002:a05:6402:42c5:b0:5c2:6dcf:8e24 with SMTP id 4fb4d7f45d1cf-5c26dcf900emr1979397a12.18.1725372495895;
        Tue, 03 Sep 2024 07:08:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfe78sm6389290a12.69.2024.09.03.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:15 -0700 (PDT)
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
Subject: [PATCH net-next 6/9] net: netconsole: track explicitly if msgbody was written to buffer
Date: Tue,  3 Sep 2024 07:07:49 -0700
Message-ID: <20240903140757.2802765-7-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current check to determine if the message body was fully sent is
difficult to follow. To improve clarity, introduce a variable that
explicitly tracks whether the message body (msgbody) has been completely
sent, indicating when it's time to begin sending userdata.

Additionally, add comments to make the code more understandable for
others who may work with it.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 22ccd9aa016a..c8a23a7684e5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1102,6 +1102,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
+		bool msgbody_written = false;
 		int this_offset = 0;
 		int this_chunk = 0;
 
@@ -1119,12 +1120,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 			memcpy(buf + this_header, msgbody + offset, this_chunk);
 			this_offset += this_chunk;
 		}
+
+		if (offset + this_offset >= msgbody_len)
+			/* msgbody was finally written, either in the previous messages
+			 * and/or in the current buf. Time to write the userdata.
+			 */
+			msgbody_written = true;
+
 		/* Msg body is fully written and there is pending userdata to write,
 		 * append userdata in this chunk
 		 */
-		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < body_len) {
+		if (msgbody_written && offset + this_offset < body_len) {
+			/* Track how much user data was already sent. First time here, sent_userdata
+			 * is zero
+			 */
 			int sent_userdata = (offset + this_offset) - msgbody_len;
+			/* offset of bytes used in current buf */
 			int preceding_bytes = this_chunk + this_header;
 
 			if (WARN_ON_ONCE(sent_userdata < 0))
-- 
2.43.5


