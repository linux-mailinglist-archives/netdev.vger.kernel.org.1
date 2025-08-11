Return-Path: <netdev+bounces-212569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01092B213F4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7392A536C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C11B2E0920;
	Mon, 11 Aug 2025 18:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF72D6E6B;
	Mon, 11 Aug 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936024; cv=none; b=oTeAa6Z2z1xGFM57Wkxs0/L/5EF2H9S+WAiCwZb71TM/+RX4fnQbsoA27kzlhTM95aBOjC1M/WUyoJ/K5V60s9Xpe8/L0WuHp3v009+dtiqtaPwNvmOpwQJqmzArKL4nUF9oVeww8/1zvWqQYFAW72cowcEv+sI4neJPNkmJQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936024; c=relaxed/simple;
	bh=wffG3FnXGoTOqKyzZE+G6mW6Nsct3xKRJi9OEVHYC0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/MOUxzGfJzmcf0P5K6Ojp4zi9X02n2MLZiLBy2ADh1kSv0yAKxRcZh9h1FSH6tY0QpduMZmWcC/XQAxQ3RJ0QXG3A78+PF24q8Lu+SWGPcmRnoVAJQgyELn7xyWwTMduvjQpJVBAJ59eR/FWiuxloski0Gr8qG6q5Ww5NdAHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso6891938a12.0;
        Mon, 11 Aug 2025 11:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936020; x=1755540820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvLC3Qpe6aWWyqq8g7FM4Df5TfoCnYjGX1Dua/xEnsM=;
        b=FqOqiQvXBUDfTPZEj+aEA0cviwBLXc4pCLeC6H4n75qlXR6XkaUd7uH5Ez+YpfuflO
         2/FeEDMhw3m36EwFbE2iggt+Zae/VPmwptQqBUcsUI+518b8VWijW/6kkskoThzvCYTN
         UQKOGsk+jjFX2LqtmcqIos948LHJtp82hV8XSQvI5nnNEQWaXhylnVoc8HCQDq9wXmPg
         Od3LAV+H1k3VQ0r3pwh3G8L44rWwQXvBcVEVZ5W7q64k4V04eWDO+54njNtoCEeUTc+y
         S3mZ8DQF4FOaW6ZczLESvJ5KJhEoHda3R7X93/XeNHZi+h6baYnwRpkOFzwBVu1pkP7f
         9qdA==
X-Forwarded-Encrypted: i=1; AJvYcCXOjQ887bHiqC6Zwa5b9o6HCoiiHhJ5WH2lHhAIHDCUeXosGkO9OaGvu0gmaDk99jJRmnpkPfIko8MMVxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV96rw8h2AJSRkpkRwpiouFqMvc6dlpJydr/vxAUli85lpTmb
	rpcEfJU11GSXiRWtbNtebGMyMvdop0kofclARRPSO8BP4LG9l5to0LNI
X-Gm-Gg: ASbGnctaA04Hs/yaqMDontpZDuvjw4OULxY99miVNAAk4knjH7PUsV4MybqrW0zesuR
	+KCURQLjSmr9pPTQam/vjWZh+GZ2Ua7Qas50jeQOjicGTIj2aSKVmSPu2HdaOlQI4yiI0tZAxdg
	IbHClLXkWP3HFj6YO+PHHO79grMvUudCCDeuNygo3aXAjJjykydBhP1gESFmCIqPSrXO5a723pW
	dIzIcfGKFUkuqtpCaUcr55n/hDvI4PK3BFwqXkJsflYi0aUtbr3WrpKjpudpM0p4gPlCHzTGM5Z
	XL1+UfwyxVbbTkKx9nDHg0TGXTyQ/kUaTPQHyzKR/UovsNwwQ+dlqtFrbfj8YqsSPZ1i1icrkc9
	x/rjtSL9tyTxxqd1tHbPIQgGIUgKmRkk93Gg=
X-Google-Smtp-Source: AGHT+IGA3WJgCbNV+wAPymyZ7WBnTQc9uloBr0NaE/FwU+TV7wB97NkoiCndobCIjAX+siBSsyWF+w==
X-Received: by 2002:aa7:dd13:0:b0:615:78c6:7aed with SMTP id 4fb4d7f45d1cf-6184eca72f3mr189568a12.32.1754936020376;
        Mon, 11 Aug 2025 11:13:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7a20sm18930344a12.34.2025.08.11.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 Aug 2025 11:13:26 -0700
Subject: [PATCH net-next v4 2/4] netconsole: add support for strings with
 new line in netpoll_parse_ip_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-netconsole_ref-v4-2-9c510d8713a2@debian.org>
References: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
In-Reply-To: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=leitao@debian.org;
 h=from:subject:message-id; bh=wffG3FnXGoTOqKyzZE+G6mW6Nsct3xKRJi9OEVHYC0w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBomjLQ/2vMJy6snG7KhBlfNfJY1oKh9EyCFhMZR
 e8eH1Em6JWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJoy0AAKCRA1o5Of/Hh3
 bRhjD/0XV5S6QH18UZClmhbCtJfZv7zO9a31YFOFqdAuGS4pV0+hGkySIXKYFtvwgHtlh6t2RA8
 T18qoOD40Y7snNwAJdSPQXJlDKTZM2Yd95u0le33AA0xlY8HF2F++cjEfp5cLOOhZXd2cLA60ZH
 joY3iEoTD+8w41UalFIYke53sumXjsSmm8S79yv/J4XMo1RCAjiK3oyUYADu1D5umE26Lkxa56I
 X2gv/KbZXV3ncMJlsGdAujTd8LuBiMydrUi5w+pYDs9khFZQQqbX7o72afKM0k80dsFqSwnyofT
 nrmDfCi5nwWcUpaJlrGzWqqy4f4gKJHIX7DvQnawCzFhhjuf7nVBuN5SV1ezc4pdsoHLICgobcw
 pv1VIiUrCK+QvMBzlLCH8wLWzK5Pxor44OZGyTW+fg6Wt5aV/SF4sJXBNC/OwCdWibccRy7IGvf
 9lreqVta10mvq0tPfqp5EoCdT1HPqkt52xDgmHxnLzc3DT+/pu8tpnBPiMKypcLEhGHM/8E8k30
 IwV2gOVTuTieYNiJVzpGTmxfDTV+6V5a6TZ3v2yqsAlLkqnFED3E2c/+I0hCRDGffDUdlH3VqFY
 Al8FiRB2P7UY4M/nxkypCEsUDnpKFXVNDeBsUYDy6E98hl8KRBP8KAHrWOMJs7cCBXrgHlSiDLz
 CEWSfy8Ouc12KwA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The current IP address parsing logic fails when the input string
contains a trailing newline character. This can occur when IP
addresses are provided through configfs, which contains newlines in
a const buffer.

Teach netpoll_parse_ip_addr() how to ignore newlines at the end of the
IPs. Also, simplify the code by:

 * No need to check for separators. Try to parse ipv4, if it fails try
   ipv6 similarly to ceph_pton()
 * If ipv6 is not supported, don't call in6_pton() at all.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8d1b93264e0fd..2919522d963e2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -300,23 +300,30 @@ static void netconsole_print_banner(struct netpoll *np)
 	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
 }
 
+/* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
+ * populated, 1 if IPv6 is populated, and -1 upon failure.
+ */
 static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 {
-	const char *end;
+	const char *end = NULL;
+	int len;
 
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
+	len = strlen(str);
+	if (!len)
 		return -1;
-#endif
-	}
+
+	if (str[len - 1] == '\n')
+		len -= 1;
+
+	if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
+	    (!end || *end == 0 || *end == '\n'))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_IPV6) &&
+	    in6_pton(str, len, (void *)addr, -1, &end) > 0 &&
+	    (!end || *end == 0 || *end == '\n'))
+		return 1;
+
 	return -1;
 }
 

-- 
2.47.3


