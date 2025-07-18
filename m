Return-Path: <netdev+bounces-208143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37606B0A394
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05B01C25615
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAA52DAFDB;
	Fri, 18 Jul 2025 11:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4792DAFA5;
	Fri, 18 Jul 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839541; cv=none; b=bVhZBEHaRQVoZvag+cuHE4/qocs1ZuHhYb+TgvLgHP5A0ZhJHrhLgoFsmo7cYC5b8k7zzXxbMWCm5jdQQ79ENT0Ds6OVqYfXokEnHuFA78Sbnwq2X9IHuk8x1olls5uU2BOkfq7pK41lmJV5ZoMWwXjAerKaGOFw5T+fk0Qsg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839541; c=relaxed/simple;
	bh=IMfpWIVzwNE/CautlO4cDyaZHeGdlClnmsL7yApRzm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfbyhWegZyoLYRc6OhBmVgvI6MtL4kkQTuL014Y2PVOt0gFJQdAhne03whiDNk/O1ngemWG1GAtb6XCzOJOpCG5CBpza2c1CadCx43bQnpBPvXz0d+KjzFWukBjK56vWDnLBcTu6+dYdojxQD9yFptRgonThhXgUEU8hWRDwXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso351294366b.0;
        Fri, 18 Jul 2025 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839538; x=1753444338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+h8p6sEGFtr0FceQPsI3sO4b1Oa9QuYzPZCWPb/Agc=;
        b=t42/oytBPyfCnO/Dytj7X8GwldG4FJ0fb21cYThzdamqUrt7PhDqo5qie4KZvCbbWP
         DEKHH+jzNUrn7W5WReLsdzeHxh5z3I4NMi24ZILOww/tGdxODFU4RqATuD3AHSzeVBN4
         MHF66z0wyh9t/pQF8JJsZTfAORwbvOkI8TvDOW+Npdt/rO8XhdKx/KfSA4L6Aq1/7Z+D
         558H0/edmQTXL2wVZeXGI29JkcyFzfdhoRIlFOYqRjnkW/o00DlDzjpexreJKwx51nAp
         K4G8T5wVxumWkxoaLt/Lf1ENhO6Mr0omnlRpvh3aufoirF0s6ZpuOfn+OuWq6qUGw2UZ
         /MOA==
X-Forwarded-Encrypted: i=1; AJvYcCXOQ97DkiuER/fxN4AiatBYnyEyGOQb+OUbd0Oo1l3SsyorRaXFyIzr/dFyqUQQ8BtxfBH4uYlicazEssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsaKhP4Aa/VK4hkDlCBhQ1Yd6bW0xW6Wx4dDMi9Mxy5TFPLTp
	L1LON0pdPV5Njsv3y2sdK0r5Mkq4dtoFw9pjFPGTRlgWgSuQB5pjB+t5
X-Gm-Gg: ASbGnctizRFbDz0P2txCxDlb6r17KBDGNNigbT648rq8wf+jz9UiO+2vrZ7l0DlA0W5
	yUBjp/zBMeIFUWE1Kx2rvegjvogQZ6xWCFCkISfLCLa3ZOe1TdMIuFvbSdlt/zM2fgEDtJCOG1t
	ps5Gn0ievL6iw2ZQqGY0s+twna3U4dKOPoVKBVjapk2vCUBhwfOh6zDyQquled8scQF+LgVY+hK
	OfYX+seYssp6XYhP18bhlbrlQxCq253cCYm7mViFyNcb1bLiOInCES/IXEVMmlaLOwb658IW5Kn
	nMKjulHp92dx2NPCSTZse9u7DiKowpoqsE6WheTjZOUBYcPqT8QUaIAK5ukeFnwY5yTANvisSn9
	awW5SG/ymjv3n
X-Google-Smtp-Source: AGHT+IEAygu32B4TQS5fBN26Fs9PDr+Fd01yTcicqF/h1rLiUp04Zj1jztpcBFGKAOV9vGYWpGTDHg==
X-Received: by 2002:a17:907:2d86:b0:ae9:cd0a:5827 with SMTP id a640c23a62f3a-aec4deaf092mr654005966b.20.1752839537516;
        Fri, 18 Jul 2025 04:52:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d46ffsm108722866b.42.2025.07.18.04.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Jul 2025 04:52:03 -0700
Subject: [PATCH net-next 3/5] netconsole: add support for strings with new
 line in netpoll_parse_ip_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-netconsole_ref-v1-3-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
In-Reply-To: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586; i=leitao@debian.org;
 h=from:subject:message-id; bh=IMfpWIVzwNE/CautlO4cDyaZHeGdlClnmsL7yApRzm8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVqy3So1+x1j7XK0UhNrX2J1Qg2qbPyX7HV4
 5cItbY77iyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bXHdEACQZp2jQJKftx67h4D9lE2zLsxxEYw3H0BdII6RxeKM5e7JeYSuND3vApKrY1HmryqwM0m
 n/vEn15t+jRrHAb9kEuNn8oUFFdgwvq0VXYRVfzZmIZkhuffTtCp+m6AMLwTNAU9lUw8BusNt10
 XSwpYBLkRMCDAN3YTfqE3l6wdbGaukk7J80KbkfacmaKrMMvOSQ3y4pkWxZZzTZsxFpX8l6rQ6I
 FOtp0qvzzzwpjCu8fmBDxWrr3zjnpFksgfdg1+GSsbzhgeCHyEX9cd9JN6AKlB8Gh3BiHC7g1oj
 IfhcMF7T/haRg+mZLEPA/gkm1IYNsp59FL9V58NEsJwPJDk1oF192LApHKRGP+tH5cPTH6b0rSE
 wbkxaJfCoPEsOkFOxMLNAmJ7uZ7R/WCX4XEmuTbToA2KkuznjM1IxVibDU3p7orJcmNxPjCB3R1
 BjuOris62fpRPbCbmXCYWdwxGHwM5uWdEpc4WujptdgwjL90dstMTA9O0S337S1h1ekdwKvw9w4
 C3nzbar8QzgwjxfoSRdfT29YkQ7BxW5mIx+VJCv0ql0tBCiz5lw94Pdsav+fEdZlaXdC2dlQKa9
 roWuL9g7o7Q0T72gsp0hhOw8RJ3anyibqoTBTvDqxLkc1CJLPqLitefhLwpIUrxR1XAaO4RVlSN
 1MitWVUADuFvUjA==
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
 drivers/net/netconsole.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index be946e8be72b1..7ea265752e021 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -363,20 +363,21 @@ static void trim_newline(char *s, size_t maxlen)
 static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 {
 	const char *end;
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
+
+	if (str[len - 1] == '\n')
+		len -= 1;
+
+	if (in4_pton(str, len, (void *)addr, -1, &end) > 0)
+		return 0;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (in6_pton(str, len, addr->in6.s6_addr, -1, &end) > 0)
+		return 1;
 #endif
-	}
 	return -1;
 }
 

-- 
2.47.1


