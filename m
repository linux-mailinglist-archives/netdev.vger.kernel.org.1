Return-Path: <netdev+bounces-130490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C598AAF1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0021D1C2328B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B55195FFA;
	Mon, 30 Sep 2024 17:18:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE46198A34
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716684; cv=none; b=XxyHCotUBOy0oBYM24NA+P+GYUNIen4vcSXWDcXOrHmu/WwzJC7TZUwWbxip7kEfpmYEkUwAdFzl08T6IKQTa1ecsK6mmkSFnI+iJ6Au+neHEirTKpbvH0C2VsMWXgc5MzK+ZrIlP8EFsq595MAN3gBI/tV60jsuhieegk//JuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716684; c=relaxed/simple;
	bh=ZLy9o70mm8QxL0HkNd/A5JwdWyv7JQBFoH1edCFqIww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY1TEw+Yst7UbUiFCdYMaVfdfyytbmdUB/i8v654OEBbPoMmrq0VgaS8p6LXpJ3VWUNDnxZDrYKfOp5i3piPZGA2V7cXJLaCKl1zaC3iF2P6+NrBEBvCc2n7aGKrncYOMm9ym9rJiZpNE6Beg6B1D9jT29yzMDRMJv/uCg3qN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206b9455460so35176155ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716682; x=1728321482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Am1750WxY5slKQ9JPH0IFp8T+o0hCjOvXnXFSzTaW0=;
        b=wPkOiNBZ18Zy1cw8iYfv5oyFNHfjnIkvQLXEIvW3QJTWbztxWXhCoP4D3VguUXkvYK
         Jt6VFyczFhqAnaixt0hfTFmucou5Ss25mSRcC+6HMm1cfMtHK3kbRmW0nye8Up740RKY
         MWjsgabiRAznrLc2JbjyHvy9607v8wY2lVzjzu5QB0DVAQ4T6k1569xti+WIOkFAt3cd
         rcvPL8aDSsKC5Wz2jbiVgM5dKrqJx1c16AIfdJxgEINKDl9QWqcMyXj8EtYRe41ciOKJ
         EDNTcueTeTSXwTqJVMolyjS1mZ/Yh6FF1qDwAmR7oTVo1zN24rs0sxGwTVFwNGoAn+jh
         0TJg==
X-Gm-Message-State: AOJu0YzWniLy6d9RdGOYHNAOX2lPrrSPO4EO8W/OChDkG+w83/g6GR5n
	GhIab+qjOVTUlahOcAW7D8UtUpCQ/wuEKqAuUOaQygQcT6mMzZe0VuLm
X-Google-Smtp-Source: AGHT+IFGTyKRQydBrc2ct+YbqmUgTS4av8yaWaBXLuNa64BMObODPfZoc/Yv/GLC8W3DhPqNCvEBxA==
X-Received: by 2002:a17:902:ec85:b0:205:4d27:616e with SMTP id d9443c01a7336-20ba9f059b9mr3960175ad.22.1727716682465;
        Mon, 30 Sep 2024 10:18:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8d522sm57057595ad.78.2024.09.30.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 05/12] selftests: ncdevmem: Remove default arguments
Date: Mon, 30 Sep 2024 10:17:46 -0700
Message-ID: <20240930171753.2572922-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
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
index 699692fdfd7d..bf446d74a4f0 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -42,32 +42,13 @@
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
+static char *server_ip;
 static char *client_ip;
-static char *port = "5201";
+static char *port;
 static size_t do_validation;
 static int start_queue = 8;
 static int num_queues = 8;
-static char *ifname = "eth1";
+static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
@@ -613,6 +594,15 @@ int main(int argc, char *argv[])
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


