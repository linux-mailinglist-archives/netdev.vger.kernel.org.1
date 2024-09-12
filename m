Return-Path: <netdev+bounces-127893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE5976F5F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C7F1F24206
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458111C0DEA;
	Thu, 12 Sep 2024 17:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22871C0DCB
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161187; cv=none; b=XvVWn/js6x4ass6zGA8A/KAlD/FYlN+Tncr1Edx4dncz23yPRcdeaL+6YnKWiYJIUs5nqFD34dKvppPQmzi41Jsb0CijrLshq3vjISv7I0ODoGRQ8DudCV5pm81z9wZqvNgY3MTjw/IUTw/PRnoKUUOKEnMpnn9asgbkWTX6lKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161187; c=relaxed/simple;
	bh=VR+N+n1NKVC5fxaVvwepaSZO/cKUhS6JJCWTHq5LAcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouKZlVpB+LM95PDcsx4SXcG/ZK4ZCtpgD8Fe3ahSKfXy71TFeqEZ8ZL7lKCxQdCcdtMINOC6n2k2rZ6eexpvKYhzkYpRZopeqy3QETF1e7+6u+UlJk4QpnN8+2h1MlSvVayNBB+DCI5yq5Q4vA9cUOq2pbOeCPr6X0UPOd9w3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717911ef035so837707b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161185; x=1726765985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/C5b82XcGrHLwyLahH7loZCBq6ghcLRWWuHXkHy25Q=;
        b=Kqq+XauN/GLWE+gMyU3eEjbdv/pZV4B7tssxckmA2S1Zhk5FzpxkvyDJN/IbXf1wdP
         IFmSRuW/fgFwsZ2qAbvYyEGPgVGhz1dTsdNIW5qHt/TD7JATqEPIpLh9TR0us6dvKnL2
         Fi2IgMR/BShAydb248Y+JF+yF3VC3hr9Dqa5Fh2XIhxUtI4z1qJDLJXbewH3GNHSsnPJ
         37LaVVzFgjUJpfBjngexsi84RrCugHY3GmFyHuld8GMrygX+wsESSjVXmdd574YIR8z1
         /iaAq10YrTl/GlG2QSBFCy/1L3klJ1V5Wl7GFwDyLrj+kaIuzq8cx6e7KeJI7Gn8y8/m
         4pvw==
X-Gm-Message-State: AOJu0YwfhYOe+1xnu4w3XQxCCDQIndwfcNZDjYdFGV6OBjFNzV6NzWpS
	dgBLVEJ+MhI8q9KMa2Qe/tNVwhUMWZAcoNn6XC1fiqOkwAhflal6FvzD
X-Google-Smtp-Source: AGHT+IFhIDmYD09Q4y8zdBJ4Nslxhp6vNn82w9RaffZuPD/nqZh+NYxHvpNL35sAkH9GbK6qAEa/1w==
X-Received: by 2002:a05:6a20:9287:b0:1cf:4f09:ef25 with SMTP id adf61e73a8af0-1cf75ebae28mr3954619637.13.1726161184913;
        Thu, 12 Sep 2024 10:13:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddc6eesm1990004a12.59.2024.09.12.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:04 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 10/13] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Thu, 12 Sep 2024 10:12:48 -0700
Message-ID: <20240912171251.937743-11-sdf@fomichev.me>
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

In the next patch the hard-coded queue numbers are gonna be removed.
So introduce some initial support for ethtool YNL and use
it to enable header split.

Also, tcp-data-split requires latest ethtool which is unlikely
to be present in the distros right now.

(ideally, we should not shell out to ethtool at all).

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/Makefile   |  2 +-
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 649f1fe0dc46..9c970e96ed33 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -112,7 +112,7 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := ethtool netdev
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index c5b4d9069a83..f5cfaafb6509 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -32,6 +32,7 @@
 #include <net/if.h>
 
 #include "netdev-user.h"
+#include "ethtool-user.h"
 #include <ynl.h>
 
 #define PAGE_SHIFT 12
@@ -191,8 +192,42 @@ static int reset_flow_steering(void)
 
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
-			   on ? "on" : "off");
+	struct ethtool_rings_set_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_rings_set_req_alloc();
+	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
+	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	{
+		struct ethtool_rings_get_req *req;
+		struct ethtool_rings_get_rsp *rsp;
+
+		req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(req, ifindex);
+		rsp = ethtool_rings_get(ys, req);
+		ethtool_rings_get_req_free(req);
+		if (rsp)
+			fprintf(stderr, "TCP header split: %d\n",
+				rsp->tcp_data_split);
+		ethtool_rings_get_rsp_free(rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_rss(void)
@@ -321,6 +356,9 @@ int do_server(struct memory_buffer *mem)
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
+	if (configure_headersplit(1))
+		error(1, 0, "Failed to enable TCP header split\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
-- 
2.46.0


