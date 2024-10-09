Return-Path: <netdev+bounces-133827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E39972C2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDEB247A2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB21E0DFC;
	Wed,  9 Oct 2024 17:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F831E04BF
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493981; cv=none; b=BfRPY8L+G15iiAnAiHUoEvLVZyKTNTdpXoWUjJEYXeWuHkg4iun7OsQ71RJ6I3p2J63VZd92euw2NS+ctwiQRnQ+NWrcwl/v9CyUqSR2ra7I1xkieqYLTeM01eoZnqXEDc+klz7XcnidWthkO26dUm3ogvLNQM7vC5mJWXcfIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493981; c=relaxed/simple;
	bh=Q9XouAJAMxZkDAHhshqh950WBwXQGagiWbRZjmNXB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiqXQQndgqwshezWXmYZPMtm5wqaMlgLATSwvUhVUaZdcPSQ/UgEeSaCXvAN0QJJPI1ZRb9J148MM11HGXwAk2i+PriNSHnQXpSPp20tHY5jn1zP1jykX+CBTHD8FQ18AEly172cjy8ZrZtkGXt9F3FXUiBm7JcrQZknLvLvR2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso6772a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493979; x=1729098779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxn4VHXUc/ouDRHYAGg/9EidMYk+lmD6ujLsvzqZiYw=;
        b=R7euU4Q1TEluQ/Fi5FTAQ9Iuhg8spmhDsjdvpqqFiMahtgSQ+WY8Xb1yrhvcbpiUrc
         wx+HtygeDB5kLgkgXvAObYWqR7EQckVzx8MuiQETJg1wbMeLohiigExONfoCKxwjX4fR
         NxJhRiMzeTkOMrfsbTCMB6KXg4HkOAdQrKoYWyD/1sILVbC1luR63bzcV45hqnyXODDR
         hvRXB8MxmApNrZ8DBeLud6VwQmZUkXydVOw1G+yW4QQGiNGKj/if0iosnymFqJbgcoQX
         qTL5IjdLaRXpqlJKnrQeDZQ5b1jdLHFUVMuzPF0me9kwOyHD2QoCKLzdlmgyg/41WLy6
         YR/w==
X-Gm-Message-State: AOJu0YyJTeDUcwoxow/heYduat5sGLK8oTx253brOyo8z4Vwa3j57bgr
	fzAZrYpsI4Z4JqJhC+o+qA4nd59mrzNf/aVVAjZFM4FZwleEz3Bl17y3
X-Google-Smtp-Source: AGHT+IH9t7dAeaNOMoxaJJHsKidG/Q03HnCXI/vq2Wb6jRWu09CG2ojcN+QgkM6WUR25N8YKVdD3VQ==
X-Received: by 2002:a05:6a21:107:b0:1d8:aa9c:d939 with SMTP id adf61e73a8af0-1d8ad8613e9mr904552637.47.1728493979240;
        Wed, 09 Oct 2024 10:12:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a1ffsm8004838b3a.132.2024.10.09.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:12:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 05/12] selftests: ncdevmem: Remove default arguments
Date: Wed,  9 Oct 2024 10:12:45 -0700
Message-ID: <20241009171252.2328284-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make it clear what's required and what's not. Also, some of the
values don't seem like a good defaults; for example eth1.

Move the invocation comment to the top, add missing -s to the client
and cleanup the client invocation a bit to make more readable.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 49 ++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 2ee7b4eb9f71..99ae3a595787 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -1,4 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
+ * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
+ *
+ * Usage:
+ *
+ *     On server:
+ *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
+ *
+ *     On client:
+ *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
+ *
+ * Note this is compatible with regular netcat. i.e. the sender or receiver can
+ * be replaced with regular netcat to test the RX or TX path in isolation.
+ */
 #define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
@@ -42,32 +57,13 @@
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
 
@@ -596,6 +592,15 @@ int main(int argc, char *argv[])
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
2.47.0


