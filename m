Return-Path: <netdev+bounces-126929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C269F973117
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814D1288E9D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B5196C6C;
	Tue, 10 Sep 2024 10:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD82194145;
	Tue, 10 Sep 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962675; cv=none; b=qkWnpuELqsYWBkHKFKX6SSqJ6XjKNR86uIuNbkmqKnshjrK5Wv+b+txWSm+lQ0dB+9QtDHGug+Y8K6ifeNBx3GESE1cvd7SOgKmdAI5isU3NpTOVAN3ErBeHS6Mpqzi999uMC3ssVs/IG6g4P+vuWVbW5bwkBDR464NBWPo1w2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962675; c=relaxed/simple;
	bh=VmHLDyvUMxnd2R9x0S5TGw53JhfqyA6sCShhqanF4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYeLKgcbU41jcZUIvewjpxDAQOSxAd0fqwSNpoFtSc8GJuq+humNaoSWVrubOKOfA4S5vMCwP6IuClk82yqZXiLnRW873Gr4wTn3CwLE2YN62woJTJH12do8c/DD/hdItOm7eFhfZ1ixK5NAGflDTcC2MXhx48nr/r7lOP6dTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so5976098a12.2;
        Tue, 10 Sep 2024 03:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962672; x=1726567472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Pqe4K0R7CoCqj5GJyoU7hPoXfTkXZJG/58IRFqgmqo=;
        b=xDZu/lHUbTAptLx528YQVqbD4e8b2uoWG0uY+h2oZcZ6L7+pp8nlc51rgnl50WdF4Q
         p2xMq18j4N3RTEGWnOZoI8zYROPAWG/61vlvYFIM2TXzOJCpAfToR8JUlTQfD5BwSsay
         m8SLbMu/vZYS2wU5wb4AGdjTaZF0msNOAfM3/77MLplul4ehKD2cXe7UOnlFPkI/Xnog
         Vw9NfJKO4OlwZ127UznDwLFRd1YVibdzmsm77Doex+kCHD7NK0AnGcqEhVvWG+ozjRsn
         ifMXlnISJ+Fiml+fATBFclXgzrdy6sXXzCbu40HHjTx8V1I5f+PUOyzCjK12gTI1O5KA
         UXNw==
X-Forwarded-Encrypted: i=1; AJvYcCUzs9u0JDxytr7t0mT1/sNIhOYBQS79lj9qa7VM3nWftkMM2xRIfz6WO8MdiZmFUOPLd2i5wco6sapNXRs=@vger.kernel.org, AJvYcCWB5IeaOFeb5FPSUrqdQhOXTxN5LS29c2+TMM5w/1B1JqsO+FnzpNMMlrAB3vRUeo1Fi2FRWHEe@vger.kernel.org
X-Gm-Message-State: AOJu0YzMw7sszWMSadbjb7B9MBV9QguAIX6IDyXOEmE5u2MX6s5XL2X1
	V9dIm/wkzGF2Lg81pDIX6lsKqi0XoIOoK2yJKCqIe+lDD73YRgPP
X-Google-Smtp-Source: AGHT+IGtg+3mKde3BezK/OSdRHNz2ImJo6UTLgRBpxLdF2FHuZHBdvceimsycIToJqIj2Dc6CbuGNg==
X-Received: by 2002:a17:907:7fa6:b0:a83:9573:45cc with SMTP id a640c23a62f3a-a8ffaabe5b9mr22721466b.14.1725962672033;
        Tue, 10 Sep 2024 03:04:32 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25833887sm460592566b.28.2024.09.10.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/10] net: netconsole: track explicitly if msgbody was written to buffer
Date: Tue, 10 Sep 2024 03:04:01 -0700
Message-ID: <20240910100410.2690012-7-leitao@debian.org>
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

The current check to determine if the message body was fully sent is
difficult to follow. To improve clarity, introduce a variable that
explicitly tracks whether the message body (msgbody) has been completely
sent, indicating when it's time to begin sending userdata.

Additionally, add comments to make the code more understandable for
others who may work with it.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ddf38141d30b..1366b948bcbf 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1128,6 +1128,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
+		bool msgbody_written = false;
 		int this_offset = 0;
 		int this_chunk = 0;
 
@@ -1146,12 +1147,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 			this_offset += this_chunk;
 		}
 
+		if (offset + this_offset >= msgbody_len)
+			/* msgbody was finally written, either in the previous
+			 * messages and/or in the current buf. Time to write
+			 * the userdata.
+			 */
+			msgbody_written = true;
+
 		/* Msg body is fully written and there is pending userdata to
 		 * write, append userdata in this chunk
 		 */
-		if (offset + this_offset >= msgbody_len &&
-		    offset + this_offset < body_len) {
+		if (msgbody_written && offset + this_offset < body_len) {
+			/* Track how much user data was already sent. First
+			 * time here, sent_userdata is zero
+			 */
 			int sent_userdata = (offset + this_offset) - msgbody_len;
+			/* offset of bytes used in current buf */
 			int preceding_bytes = this_chunk + this_header;
 
 			if (WARN_ON_ONCE(sent_userdata < 0))
-- 
2.43.5


