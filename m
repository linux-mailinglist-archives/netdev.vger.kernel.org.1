Return-Path: <netdev+bounces-208606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFABB0C4B8
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A2F1AA516C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DB2DAFB2;
	Mon, 21 Jul 2025 13:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1F2DA77C;
	Mon, 21 Jul 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102941; cv=none; b=fwrCAijJOYCAzIapZzEoybZ3OrwAs0HXNJ14nlfD66nNVj/w6kBTCrRO7ltw4OqPbdji0aQLR4t90rvuVjfZsyT4y4N3xX1MA9iN8ni7ek5EfdDqHtcQZcJ2NGfj2qMzGXeVdmNVDHNUEu6ktNoHEqZBukHee76zPVDMxq5wNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102941; c=relaxed/simple;
	bh=HGHEJEpfTTnCKMSvXmSpHaX+D9jiWr0GaLfvMmv8weM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXhtVyHcyIiXEU9cNwPhbsNDg9X8qbIq6jXdN8hIWbyFXXBHrEUsJj7ZDmn92P0WTUqsymBnA+qtIdUNAx3x73YsyoePhma6Ju8B84XHgRB8g5/Hj1Tmg0jsRuu94ybeGbgBWz9yBE1RLA8wrshyOMburFyAQRDTtLht+I571Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so815228266b.1;
        Mon, 21 Jul 2025 06:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102937; x=1753707737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pcsGFA/z4E3qlFNo4KXPlzv38omzg647OE6G+86p80=;
        b=k2z6OgUnCAiwDlCdmU0ECFyqdFVeFd5FLzGAU7KEZWh8MDmSsZE4xDh19zQTgqejAT
         yxBZGoVfEEZEvBoDpWNTMQ2Y/2kZzefYe6GnTpwEAcmYo6zkZ6+QjukuSHtHdtA992B4
         5bA4p+zNj4JmM/qqmK5slCPIzeC42pq9WCQS8/4Vam7PD4+hDZiNYvzTmvgaA8nkgT2p
         MknnSBrd+Y2OgS31snTf2KfBC/gr+B3ns7MwonhrmPfDI9nptXImtgF6JoLLos9Nohdg
         ozpXzwJW6ccbMkHhm7mgTByguG2hL7Nisd2At6AG7GgJOUW3bwHIpJVG4TaBtgbaMGhy
         OtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4OhpTlpxUUm/Bw+X2pTeEpcso5oyrsyGGuocPs7PLQxAUcv7EUX0106eXcpPZmwzqkvFIRoioVN9wGFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyFWnjFEbeSXC8dWpEMcDbcii9wMcUA7Rq6inSYnCyMUGA61q
	OszNi/rBomXbFLl1VmjQuiA5jDtVb0hevDEmusFqhs7UW2WDm82jyRFE60XIWg==
X-Gm-Gg: ASbGncsRR8uARVuc0ssH+L6kLLbrZeLe9A5dFaKsj0Sk82+X3EIi0cmodeZEaEIWUI1
	jwUzlgP7ArXApsjM4Lgu6jXAQGQ0W0OWOb+UEblf/FMm6XUJx/YeDIUGmgOnNsd+1d073dJA5oo
	XoVgh5q3REHKYJ1h9mIKE76SI4Kk2qayIWmTjKKguXRJG7Y/EO5f8Y7qhubb8a5GJLbfB51efc8
	FD+iXPOKfeILx6yeLFgwQongos3C5b455NUiLowUBBWg3LWyM+iIMuZKnony2V/0K2bBPUMMoLy
	i/COefpPHZJs4bk2d8abviI5MFKOISBmgncIa/Q+V7Aoacah+v1RCOgnAYoNrLR1zZkn7KBz8aD
	R7muKWjYLt669rw==
X-Google-Smtp-Source: AGHT+IG2YiDZgdlBrQItp7gCjN55Ql8F3DS6tT3ajOj0xJ8Rnm4TSHk6fmVhSaBREMZf+Cc2a7/q2Q==
X-Received: by 2002:a17:907:c008:b0:ae3:b94b:36f5 with SMTP id a640c23a62f3a-ae9ce0d2fb2mr1686007866b.34.1753102935290;
        Mon, 21 Jul 2025 06:02:15 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf80e5sm676792466b.163.2025.07.21.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 06:02:04 -0700
Subject: [PATCH net-next v2 4/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-netconsole_ref-v2-4-b42f1833565a@debian.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
In-Reply-To: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=leitao@debian.org;
 h=from:subject:message-id; bh=HGHEJEpfTTnCKMSvXmSpHaX+D9jiWr0GaLfvMmv8weM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOHJ80y3tzMth9ZwSgs9lqGcV7CSXUEn4kM
 6TrA8ECkmaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 baNvD/92ebA1ITNkN/bRA9TApce74oVY/Kcikc05GVXljrN/ETvcSD1VjUnTuNOLN0TuEl2G4NX
 ppPKKQ0DjoaJZa2YRaa9+v093kbb+9boOmXkPDi1/LkMmaZHoM+0Y43hGGg3/NEIbZJXsX/M0gq
 YCFQcGcmaKly+a6mqovVOf2cvBUdJqpp0Xfa0C4aINMEVoqN1YS8G0QPsTT+EygoKpae+fdKuaP
 vULt/yPE9dLZ69zxrDeW9ujlXN8cVy2bavu3U44ybFSqWcqX2xgFylNC6mrQNkIa6ENExPanL1s
 +JC//8zKnesfCUZ2bxPoZ01jGvqEZoZAJ4sPIOa9oDiJPBE9unzwSYAktOPnhpDN3iTT8vFA/3T
 ZzS84eOeTLda3ypqxGU8SLX2QX/GuN+T/eGcc4q2EwzL3P1Glo3NH+S4tvGn0WVRXMZ3OsYR/bD
 exkL9XuG33P5aMZmkbplJda32wqDQ1yluaUBuxb999qO2MLKUYAEYwi5hrj6qQw+oqnTuyd761z
 gWIPi3LfKLamQs6O08M0YfHHvQauE0oIZHj59igORG+EVzNxgP9e9KB096V5acZkJT9r4b/6e96
 4lKNEqAUdZkQDfwUEh0wctfeKRMdbP5+1BC6DW+3nbosD8GIEc20M+LDHzh6TC09/wilUwdtdf8
 NWxGn3P69qcefkg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in local_ip_store(), simplifying the code and reducing the chance of
errors.

Also, remove the pr_err() if the user enters an invalid value in
configfs entries. pr_err() is not the best way to alert user that the
configuration is invalid.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f2c2b8852c603..b24e423a60268 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -751,6 +751,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -759,23 +760,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	if (strnchr(buf, count, ':')) {
-		const char *end;
-
-		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
-			if (*end && *end != '\n') {
-				pr_err("invalid IPv6 address at: <%c>\n", *end);
-				goto out_unlock;
-			}
-			nt->np.ipv6 = true;
-		} else
-			goto out_unlock;
-	} else {
-		if (!nt->np.ipv6)
-			nt->np.local_ip.ip = in_aton(buf);
-		else
-			goto out_unlock;
-	}
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
+	if (ipv6 == -1)
+		goto out_unlock;
+	nt->np.ipv6 = ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


