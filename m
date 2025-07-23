Return-Path: <netdev+bounces-209428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878DCB0F8E9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B29567986
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515321FF42;
	Wed, 23 Jul 2025 17:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78F1E5B63;
	Wed, 23 Jul 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291261; cv=none; b=UKikommL7ocFl3FKCaI85oXxlbm18LRB2S/KM31/vvwEhLZvpukLubVbf7/JbqSSOzQCNE4J+PvGD+aIYN1n3Dq5gXPq6QogBQOrJIM9aK76VjXzq5AuPLm82UEFS5fUlkjG3IIFXWKcklcjLz0BIbcIy9zfqBQWatTvC+XOLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291261; c=relaxed/simple;
	bh=JNCUvYAKAcYvytYcFZUC0ZZQ+BKoXgzr4rgXZit3ClM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEFxzEk2KRu7+clJXsRBNSTk0uqpBWXP8ey9YPp4SL2ht9P8D6uFB8x1WkcWMB1RLC3EBalamVIzXeLReyqCb6vyLTOZNVt75/LYt0yJdmoVL5zI8QV9qvLa0G491kbGNmWqf8MnnXadyqQ5W8IUNqsLrptvbaK4XQ5cNmwQROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso12599966b.0;
        Wed, 23 Jul 2025 10:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291258; x=1753896058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmhoj0JvlwtC+WTj7uDYiiR+4+HR3hBWi5xamQPnXa4=;
        b=rYNtfr5QzzzqepdWSbmTssZqtoFSJd51aNymNGR4W9OH/8TYd6Fdd/tBCpojf5Lhk7
         wQMTNRdMNatnFjBeUcJ9Ibghh2d/GjhIn7AShvXE9Al3aC40OFee8EGrJUW7eS8EMKQb
         cIZ9fPQ24P5IjPvtA2lt+suNVNTaKOQt99i8GPJ4XGDaAnJWJG7z2K2lua7JJnT8CpJJ
         TROaj4tjejMt96ws+Ikgm32x0ug7LZaYfXYyNC/GzVeDItRH7CtU5E1n4R5CHSezd93W
         LE5bDiE0immrrU9mCOnGyPtAW0c/DCtaf6rP/k4WxR7Sh1qR7rwm/UsGuVOp4xNYtRKs
         yMOg==
X-Forwarded-Encrypted: i=1; AJvYcCUquNM6tnw6ksVr54pUeypRWwVGWTRg2SxjW1o9uIeBs0zAX0BvU7tmLlSvjv5n9QZNcFo1409bXgAV4h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK/l6zCBycoilaQcatTGN2F2XUF2HiXZ+S9z+HpYpj6Sbvfq5
	6HTCRLpjmJKMk5kLH6xCHeIrSd5Nm1mppz2duxsfKVCanSbxA4xOKbOx
X-Gm-Gg: ASbGnct2oPxBaAwRk68tca9ADOCxOnTXpRu0FfXHpaN5I5n3vSUJSdIoqmZDE1ogktP
	Qd6zKM9nN1S3U2Gxmcui0ogR0j/oauagT9r9bqxYmVy2mzNcNAaLJ2RrmH1QPtKR80a126OWxak
	xGp6R2BBqai+DAYrB3mP+4LU3mt+m54hQIdpNGBP+R5tgjfcA7OIOjqkBJaUU0lZzu5N8i8xcnY
	PhlNE8i3SURe4avmj3YhsueXfB69Qcye6kaB5F1G+GNjKHL6hy2gT3G2/FlSSqcV1OauAnwy5Zc
	ZtaPSbTA8Lu3JTMokPfm613cNhE2UHG7uLOOWB/t7Xlkmzn/UV2iUAlZoWX9z3c+oviwFx52hT7
	9p60VHrjHgS+p2RADcASopCg=
X-Google-Smtp-Source: AGHT+IHY6YrdU2+GO9vQ4Fgm4/VL3gp8dUmKwH701rEWCVtSjU/EYUkDpWQprPaWqOdAk/UOml29UQ==
X-Received: by 2002:a17:907:7f8d:b0:ae0:cf01:a9ad with SMTP id a640c23a62f3a-af2f8d4b228mr409250066b.40.1753291257969;
        Wed, 23 Jul 2025 10:20:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf733fsm1082540266b.159.2025.07.23.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:20:57 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:20:29 -0700
Subject: [PATCH net-next v3 1/5] netpoll: Remove unused fields from
 inet_addr union
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netconsole_ref-v3-1-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=760; i=leitao@debian.org;
 h=from:subject:message-id; bh=JNCUvYAKAcYvytYcFZUC0ZZQ+BKoXgzr4rgXZit3ClM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn2T8QeYxrubimxme4+wOa2iP25+m3GQjOaU
 IxTeI8PTlKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9gAKCRA1o5Of/Hh3
 bVtZEACGe5N+nbAIGUv2s9xowE18Yo+Ue634JeZRWjfbbpPoHAr0Bn12hF/14U+xYyi3hiVyAzk
 PrCEooBeUfp4whkCyDi/xMbJ8LjJiAacTZDyt6ZxaXqeyfrt1KF6ivAHPJp4HxHuOD9K6F1Zc4b
 RD5n7IjZG1ycTBa31q8KToecCQrrA6AS6LEzXRKPJd2DEKHsUI9TKQeZBbh3JCRWrSJmOfORMzl
 zRDF8bYrIOb92Wpzxc8l/XY9+2ZPlnL+iN67gvN1C5m6Z9AlruK3tzvN2LKL/AXA3QfeHQR/UyR
 n+VBEgBU29TF0OcN5QcR5E77cT5c/9+rY/zlM9/im/4cK83nhqEPft21zn8oLXSEuPQtlFuQ2va
 qJV6IqqbDIi7kV+fcxlynkYbqE4YV3+ijE790RKdVDG3QW0kP5pBAkRyigfGwANzpA3Bw/GPAJG
 e54dje+TnKLnsKEWSYtcEH2TX3dPUgJDaN8nTTNKsb0lA+R7NfAwd8OJ0EXU6iOe+zNttLOvoFW
 +ov8CbmRulO2fdNKQxK4sMAPBCY7N+oVqi34tS+5ylLwFBiaCttWZJiSf7IQpp3JLvZrrBsCRAo
 ANNiIO70WzMXW5t3hyPyG6SlyVj0WSt9N6KJ2fk0NFjtKKEP8hxt4RZ28OQUhbbJNDD4f39Eq3k
 SLoskxW6CFXdl2A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Clean up the inet_addr union by removing unused fields that are
redundant with existing members:

This simplifies the union structure while maintaining all necessary
functionality for both IPv4 and IPv6 address handling.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/linux/netpoll.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 735e65c3cc114..b5ea9882eda8b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -15,10 +15,7 @@
 #include <linux/refcount.h>
 
 union inet_addr {
-	__u32		all[4];
 	__be32		ip;
-	__be32		ip6[4];
-	struct in_addr	in;
 	struct in6_addr	in6;
 };
 

-- 
2.47.1


