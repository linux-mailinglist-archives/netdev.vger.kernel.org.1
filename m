Return-Path: <netdev+bounces-209429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4CB0F8EB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968F63BD52E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33351223323;
	Wed, 23 Jul 2025 17:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC721D3F5;
	Wed, 23 Jul 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291263; cv=none; b=sxYamMGn/uN0brw7eDu6XG4fJW7I1DAvwcH/gmclAaRyfvyvkIUjujLd16D/eslT/ts/69RjSCxCBN/h/iGQsZoza2azdYLAm2f6Kd+cKYaqYL7Q4USqQXsU0lOzJJrxVOpUQ0W1rRrMCe7Jrj3uzdGfC4lm3ZGwO1DeouW9NA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291263; c=relaxed/simple;
	bh=OM3IImDRGqZmUbq5qP8uyYsos+SkAacwLNF9cykp+Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9IVU3s4W2BMCLVulC/8Ra1WEo7N/alcHRkpraxBWGBIBT5AqNDxXNbbR6qMRm5V9c9OHKNgLZLXX9Ai+4BT4jg4YNA+62syd62sjk8JhOw10gQXp+NfQW24I0ZCsHdwT41SeesRZWCzG66UG+1xctLIT1y7ucFnKx+TJVDSzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so2209049a12.0;
        Wed, 23 Jul 2025 10:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291260; x=1753896060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/74Bzq1P0o5+YitmjEt8L3G5nczQsOUBPud/iN6bQu4=;
        b=Q4hMtBMzYPLRErWN/2PO2HDaZ5oeoher1Rb7/7UePPgiFpUY1e8IGp/wwYFEWM95dw
         Vc/vjkNY5V19TPnuj7MWtm+fE/H4s++YdbhRLYiUqCYcpfCfE3QyLcCmyd0loWGAx8eg
         v7Odms7d/H9lW/pBCVcwIA18V8z1p0Pksv0tB6V5mqus9A+yd7nHJQHvfMGmZQXJW2uC
         Vny1TwFm9iQSTFsAoSMm3/Mu+2H5It4lUYbnqx3r6IX3Gfgo8SWts2AspJnGFbQkHJH1
         +ywpMgFkpicsLvWCkw9AmnxrWZp9HYtzUfjqBPLPOwKhT/o0qmpUB1NN82zlNcki2uwu
         MiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt6H/ngLIojASOAj0DDfODpTOTGBhZyL9H7lLkKEO4z+d3r6l0xhkh+9cFN3mMCU9sjlT5SINVzKyKgOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Jn73T3VE7w/M6ttleb5hUEViVKg/z0drxaWIoOV25yNItQo4
	WQ63Ly+LcKrUSSMCo15P4O/piphy86JpxP0/4krrz4jX/r9GwJsIxx2E
X-Gm-Gg: ASbGnct7mkcHKJ2S5Bif/gRpa+FpF3LbrFpLdXYdqlsXpSTcHEfSxDUD8x6t+NETzUA
	6zZfWvnTx9t9Y7SxonBBZcEbjck4twQRY+C4sdtwHhShLkjJm3BIjjma8LgRHEZg0UwKIx5K/aE
	1cMghGq7TAa2MZ5w2Np/ab7xyFq8Qik0yeRj/pS33hYaP5rpFnCWbNPKajcQmcmFlAVaw4haVJL
	ZQ1GmXhp4qeO6v1M2GjDMCQnZjEJYifrxuT+LLhTyX/wuPpds5QliFZ61zlFBmAVsfxrZ43oxRV
	v+xPFpTJRqf05XmDxrPklnb3OaJt1RJink60AI2jGNCShTs9UJOlJW2Fd6jvvCUAJ9K7rgfDw2L
	dUjZ1btew2K4O
X-Google-Smtp-Source: AGHT+IGUKM7AP19DWc8FQYi3jxaktMBtD5Ry+WcbHmK+KU2BjYrzuoT/UnpNLN/F/4U6QIlZQ2vqDA==
X-Received: by 2002:a17:907:1b08:b0:ae3:c777:6e5e with SMTP id a640c23a62f3a-af2f48b0b06mr271638766b.19.1753291259411;
        Wed, 23 Jul 2025 10:20:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d347sm1087745466b.128.2025.07.23.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:20:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:20:30 -0700
Subject: [PATCH net-next v3 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netconsole_ref-v3-2-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=leitao@debian.org;
 h=from:subject:message-id; bh=OM3IImDRGqZmUbq5qP8uyYsos+SkAacwLNF9cykp+Uo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn2Vnil9wAfl13ASovyAgNOXZ7bzmoqnYgLG
 1GJ2xp9kwqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9gAKCRA1o5Of/Hh3
 bY9IEAClVEdbFuHwBu6UFP6VfJGRUN08CIcJ1xMr16jJPyEsIASVewdnhtNqyMcCHH8tCL5PUbh
 ad+7idDo2Joh2K6cdxPiQg6EW88UTFykBRt3gU/TrFwyZ1TF4nbYGFzdbPJtnTlQZQPp9TqJSAR
 4iEpKCAlRbeUz0Uzfpj8XgzcJMYjPvK4mdmHifttvEBnJw7KlxLPfHwvo54L+iXjDLsmWbEaUB+
 878D5GxgijC5BBrb7xdFewn2XC9OLVoSmIlu4OF2nNtr91AH2RV3s3pInWV/D+TdFuft7g4uAPd
 baII/9UTIkYmrsZpP8grzxrld/4pBoubTIo1mDXjORsLbhDI+7AVQCAlXNyQ485av6EdDj5ajTc
 s1Zg9+8LTe9FBuJTN7l4iP8EldV5ZIO4go1MYdBOPDG2WvmtN5fBi6fRDUQkdo5De54gFJpAd/T
 K4WA/hLXpAgaunJCRQUq6OgLfj4ATpn2Ta3d7PlLTisrXiytHLnQMnYqOkVfgwCdvVSwHwhGNoI
 Dlmp//UilabWK9wPQpP8AAULNqx/ETQQDbPrFEzJSleq3k+AnXbEowFXOWyJl0x6IsWHze1My0W
 IDeABZoWjfPJUhtw7Ts2hLjOgK5Gqv0N0PXufOICrirPZ81jfZ3k/tcQs5+TvnyikF7JlefsXlN
 Ln1f5ojoSUqYLLQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move netpoll_parse_ip_addr() earlier in the file to be reused in
other functions, such as local_ip_store(). This avoids duplicate
address parsing logic and centralizes validation for both IPv4
and IPv6 string input.

No functional changes intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9f..8d1b93264e0fd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -300,6 +300,26 @@ static void netconsole_print_banner(struct netpoll *np)
 	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
 }
 
+static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
+{
+	const char *end;
+
+	if (!strchr(str, ':') &&
+	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
+		if (!*end)
+			return 0;
+	}
+	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (!*end)
+			return 1;
+#else
+		return -1;
+#endif
+	}
+	return -1;
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -1742,26 +1762,6 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
-{
-	const char *end;
-
-	if (!strchr(str, ':') &&
-	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
-		if (!*end)
-			return 0;
-	}
-	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!*end)
-			return 1;
-#else
-		return -1;
-#endif
-	}
-	return -1;
-}
-
 static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 {
 	bool ipversion_set = false;

-- 
2.47.1


