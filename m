Return-Path: <netdev+bounces-212568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71244B213EC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4C01906F87
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E02DECA5;
	Mon, 11 Aug 2025 18:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C562D6E69;
	Mon, 11 Aug 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936022; cv=none; b=cTcm3YPwKgjqODFMMbhkZ8nTe/BEtvXoHmAssTJVuYUId8lkd5kk8MaFtZJuQ9L7MBqR5epfA0W66ptz9kqYC7oUoCRD5on0ekT+2aCVK2/ZOjKNH9virfb8sjTVyB668+xEzZfDO0uQnfQNMSI7iPJsTmSgHeklkOhRgxFRrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936022; c=relaxed/simple;
	bh=t0nywAxhzDKESKlaUOamFLLZCT5IE22C/isprjTyA3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnddg8+M8zs7dXvOs4r8QQmU9g496zQPTvqePF9ZLEC9Jnmj/TtOMYWOK7vrFdJntnzvFtYaQ/hiZlimPDr1yBREGK3twCpFUsPbaBwHBL6hc8P3NuS5Eg0qbvux9c0fvqqoHvm+ylXBQ+bVY4IRRZb36e+WcuA7yIuPMugz53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af937728c3eso886908966b.0;
        Mon, 11 Aug 2025 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936019; x=1755540819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV9CK2FNV1Hmm/C2rkmRgK4FmGCVPwlQy2penm7Yjj0=;
        b=bDw0fZPzNzSrey0gCQNlzTuPSEhMd0BvXcfClb2pelvpXxwkUrw+BEsnNDpzseKLrV
         jK86XxgjzfdBnfAb5RMxwkCnkIPH81hKw4LeBJRD0zzFlxUyAGWCzCN40tbE2rLhLH+s
         MPq4QpptG87z1VGpBFIzzDQsDSJmDIpLCQkVsRwDPO1liGPO1+yCSepMjfh486fCZR+1
         0H/usX0BHxvFwR4EhCghxgfpFJeBpT1063QsHas6fSVQzh5N1wq8BSTZbVNUj8HcmvR9
         JAlkyQlv6hRyrGcW4RHx3jG5e6SVP3ZgOnT7eGo/BzgrN/FfDVIvmkeNO01o8hfZpd6N
         WHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUOUGfOqr25nOJFipHoNRKTWrpXRoAa+ghFtUvTnHnWYiiv8DhOUSA0SLFX3qfElua71/vu7v+/ZhU1C1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApo141rxJh2ZY6ZeK7oO7nkzgNfMfApIvCmEcz66UOCfK9Bft
	86gjsgwlEbvPCHVjydA0H80+X8WMgvtrsz1ELPb+VvBW3VA0zjylxL0/
X-Gm-Gg: ASbGnctiV3CifPFvos1dZKGSIFth2nseB+xbjkeV6ErUmLaPAspA332NmLaGtibOCRe
	B6qUXRZaNPrKYNCYBAV3A3CgrZqPf7qrRHLMrffyNwH62EyufAqvH1C7Pn8udrOPD8kgMMejJ/t
	lgpfRtdUqdM1HT8XXPp+GJQiuVpWOOAN/GMNE1wL9pAErW2W2unF9ZfEMolInbqelueYbGhpWql
	dtJ1iD+MYVcJLSNJVqkZQ3kxKIBIP3/uIQRtt1QSn7sLuVemaHuBDpgEbYKY+eZyW1GQ1mLF6y0
	UC2JClhqWWACgaqsWsJThvPsrpAgRqOV1h/xosYVG0m0Wvvh/4bN6/C2NQnkf3j02EVLRO8e1Gs
	9CZS6XVVFVFpRJw==
X-Google-Smtp-Source: AGHT+IGcodICKFzzClDeay7gx7ULx55WfovxXuBJt/2GnH5BzUI7IPXkDAZrsBVTCfrh9QWbFm21JA==
X-Received: by 2002:a17:906:fe41:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-afa1d65b1cbmr67832266b.7.1754936019007;
        Mon, 11 Aug 2025 11:13:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61821e562c0sm3023798a12.30.2025.08.11.11.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 Aug 2025 11:13:25 -0700
Subject: [PATCH net-next v4 1/4] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-netconsole_ref-v4-1-9c510d8713a2@debian.org>
References: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
In-Reply-To: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=leitao@debian.org;
 h=from:subject:message-id; bh=t0nywAxhzDKESKlaUOamFLLZCT5IE22C/isprjTyA3k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBomjLPzuEouyi566OYrtZ9xNUFhRilK2dUmHffz
 EBmhpXCb2uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJoyzwAKCRA1o5Of/Hh3
 bX5ND/93BmHnhsqtNODio27M1cnloTshRdJfx9sgw05vmFVAXwakGB09r7sJn2wja3o07E6pp6O
 vFha8QMIai37o7BdA217+r6JCVDLvNqL79I7E9jM82mSY9pD3x7IKHCXUqhJtV3XAv46/u6IPXi
 100a6Z8Vsw9nsrhqo99pQRVqLgZX5kPi8k5G/nik2/WF+rIQNK+eCdEXpn4KNFv+3+L9/IupLHM
 YPNDNfr/k9AUnvkVO+vrZ24jG4xYMF7SVTYuOnMkcZxdjRGacmfF0ORWdP6Ah9S3loMxOOS92Tm
 ky4wcdvZXg4xYanWpj5i6sbhhhf7TN4NuOl+OuOoNLA9DVDPuh6fhZ2KWwKThfzJjjpUKNtNCpm
 slKU/8V/A6HdtdvLSdolgSCB7WGPVTyYlOJOXpB/GMAeKHkneMvdHMT0K6eTww4xW+ZUfGwWH19
 LGohNVKrpXZRNRtauFS6RkqlLnlAb+SidifHvorQENxdoCxjYoom72lkotVcT2slFP634TujIcq
 MQ6KZBCLJxbMct2pDLqTMdpo5S6lGzYNtpx5YVLstk4y95lJln2rAofm3hl5OKgz/FaD9GhgS0D
 tJuzR4GigfIGO7IUIBSOKn5rvOTH23M+oHkTeZoe8Gu12Pg+tOj+IY/u5oOaaGlB5bkm0gcruQS
 xM2CgbknXuYxn+A==
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
2.47.3


