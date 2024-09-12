Return-Path: <netdev+bounces-127890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27629976F5B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FC91C23AF0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768DE1BF7F1;
	Thu, 12 Sep 2024 17:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2561BF800
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161183; cv=none; b=EDUm7qeW6MjUIXShPAVXDSWVIpxV6wtL5HREcgY61TwCHeEAAx7c/tmJLqAkk9LVO63hSzYZRIIWIUj5NfsuEtMPyGRQniO8KQAftI99uE4Ut6caaefzMVV5IH4UWbwyN9maEXfJk099L4PdRz5ASvE2+jqJlplfLBoNsIOv66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161183; c=relaxed/simple;
	bh=LAzwia09eV/4sSpw5mcMv/0gaW8i6IEmagmcjr/4NzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbbcph192O48WHnIYSLJXx8lVU/Dp3HbXrjrrJreyIwp+4F0dT9JLB+Bq4OYfVSj8wCDrkGe3SwZSEmFLG3Spp70y4ByCI47NeTuxBQktOJiTpbA4E0Px7HR3Tnwm1XjTNuQZ1jjEP1KqUkfiIA343Uf9nb1lXoWVoAu+9EDy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059112f0a7so8185ad.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161181; x=1726765981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFrKSN0qGcocZdoBbERENThA5G9MGT7/eNUPdgl7EpE=;
        b=LmhJxAXfd3WIwajh0b3ZKA18ZTN6u6dMonEBDhx7+BFAZc2lc4jOLMvR90lXMgB1k5
         CI6VHsT7KwibIKsyPxsGwINxXcV3nm9SJgLYcFQ69ESTRPf2ZJXrnYkOhbtW5K0NLkrP
         okBVl7QFKFCs0QaNDBUWJkp2vT8l3f2aTNP0shFrmhCR7ylYigUuAy8fCKPrx2/IGQXj
         0HTEVN9WYWMQIn+B8HarkSw8MyHDTk09CedyfF87MvUxdssCcohLJynaxav2dLR12hgw
         3DE/NUT02xaXaXSA1uI2dVEBjiHvhd74Wa5kRc84FdFhO5fzmdTxIt+2LI2ufAFObRZZ
         +Bjg==
X-Gm-Message-State: AOJu0YxVx6RmG4y0YzED3xVGpCUiQAnhuyKaYQCNqb06gv9tCkJF/WZu
	H8v9qNfC7fktVC+JDaFy08x+hRDaOzTE7V++bkqjDePTCcV5qtXuz4Zw
X-Google-Smtp-Source: AGHT+IHkkx1xCurwuETkXacyYdyxpvKtfCyPMJieuvBmVbwrKDeOfaiffEeZmZA39Nw6ytlBZPKKQw==
X-Received: by 2002:a17:902:dacf:b0:205:8b84:d60c with SMTP id d9443c01a7336-2076e3998damr47573045ad.35.1726161181072;
        Thu, 12 Sep 2024 10:13:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af47657sm16500015ad.79.2024.09.12.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:00 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 07/13] selftests: ncdevmem: Remove default arguments
Date: Thu, 12 Sep 2024 10:12:45 -0700
Message-ID: <20240912171251.937743-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make it clear what's required and what's not. Also, some of the
values don't seem like a good defaults; for example eth1.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 34 +++++++++-----------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 77f6cb166ada..829a7066387a 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -42,30 +42,11 @@
 #define MSG_SOCK_DEVMEM 0x2000000
 #endif
 
-/*
- * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
- * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
- *
- * Usage:
- *
- *	On server:
- *	ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
- *
- *	On client:
- *	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
- *		tr \\n \\0 | \
- *		head -c 5G | \
- *		nc <server IP> 5201 -p 5201
- *
- * Note this is compatible with regular netcat. i.e. the sender or receiver can
- * be replaced with regular netcat to test the RX or TX path in isolation.
- */
-
-static char *server_ip = "192.168.1.4";
-static char *port = "5201";
+static char *server_ip;
+static char *port;
 static int start_queue = 8;
 static int num_queues = 8;
-static char *ifname = "eth1";
+static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
@@ -573,6 +554,15 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
+
+	if (!ifname)
+		error(1, 0, "Missing -f argument\n");
+
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-- 
2.46.0


