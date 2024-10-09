Return-Path: <netdev+bounces-133831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007899972C8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BB71C22402
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5731E131E;
	Wed,  9 Oct 2024 17:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CB1D61B5
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493985; cv=none; b=hgpK++lYF9fz2RLtm6JysDjIcssYKWFRx/QXzfKPfNb5HkmoAHoV9FNHSbfFtOHm4i8GLaQtrt/x8RtrMApgCnaaJiPg+U5r9sW1Kp0C72dqwBbP2TZfc8YPzaWlHbmUE/WC84wNYTtboPx/p0zxTNJCMf/ms9Na63qFnySuh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493985; c=relaxed/simple;
	bh=zjtCRSGrLR3Je2W0eOuap/k0ZilkmVO01LKyqGubEVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLItAsOPhi4uUPahHFuWOI0mhrHgpqHr7WzmCBRGFFveQaENCROhQAOfN9X1ZmAxh7OsEGYBU2c2yy+jMVTnpNvebHStOqVU94jT3X/hl8yjk3iSqr8VB6BRiWsfdT5C2jxhn5K7Vuk2g6Lp/dNPceHo+F6ClAyGEI7lP1Nnqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b9b35c7c7so51106245ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493983; x=1729098783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/TS+Aq71vjUo51APt9hg7bhlQlYVdwazXqHzs4jF1E=;
        b=DJa+3CfOmtRKkGimVoVW0RjIXSGI26bsVSZ/Kp4Evd/Puy1y5Y8dT6jzUajIC9XSBO
         Vv6mIPSM5HpEePjUOBxec1KOTOYKubbMTNtX9eUPa5NVFbNBLFNAxOXECAr0Q+I3L64i
         Gy04+mZhjZZ1uVoyuETzMzETR6jZVVNZj1AEUTfM6MYWLqnAgKF44Fn0LmZTxTjp9YYV
         alrbesdZ26ZcdjfnN3ropT552snWJthSTHvnZzZL402/oYkP2kki86IL+zMgK4klP+r3
         3XpNycRjBKI/49HCDf/eZZPw+XJ2gaoTZAImaWsnF+WnLz1VaBjnXK4WKdxiXjL8odkM
         AhQg==
X-Gm-Message-State: AOJu0YywfNqOr05n08wyuWLQ5sHKRhm/rQYDwYKC4M1YkZ6RTPWVStrX
	dkNpHTkxJLpt6uU3kZdKFlIINVibtf50OIh2sI09xTrViiFfeq32rBxW
X-Google-Smtp-Source: AGHT+IFQBcFt+PZO3NKYkWwsFsNmVQS/HDDRuFQNVNmfpWel+uX9VqU6TEvploxSFEIiyUl4P0Kh3Q==
X-Received: by 2002:a17:902:da88:b0:20b:a728:d11e with SMTP id d9443c01a7336-20c63915481mr49255595ad.53.1728493982637;
        Wed, 09 Oct 2024 10:13:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930fecsm73506985ad.165.2024.10.09.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Wed,  9 Oct 2024 10:12:48 -0700
Message-ID: <20241009171252.2328284-9-sdf@fomichev.me>
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

In the next patch the hard-coded queue numbers are gonna be removed.
So introduce some initial support for ethtool YNL and use
it to enable header split.

Also, tcp-data-split requires latest ethtool which is unlikely
to be present in the distros right now.

(ideally, we should not shell out to ethtool at all).

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/Makefile   |  2 +-
 tools/testing/selftests/net/ncdevmem.c | 57 +++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 3 deletions(-)

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
index e53207045728..02ba3f368888 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -43,10 +43,12 @@
 #include <linux/netlink.h>
 #include <linux/genetlink.h>
 #include <linux/netdev.h>
+#include <linux/ethtool_netlink.h>
 #include <time.h>
 #include <net/if.h>
 
 #include "netdev-user.h"
+#include "ethtool-user.h"
 #include <ynl.h>
 
 #define PAGE_SHIFT 12
@@ -219,10 +221,58 @@ static int reset_flow_steering(void)
 	return 0;
 }
 
+static const char *tcp_data_split_str(int val)
+{
+	switch (val) {
+	case 0:
+		return "off";
+	case 1:
+		return "auto";
+	case 2:
+		return "on";
+	default:
+		return "?";
+	}
+}
+
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
-			   on ? "on" : "off");
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
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
+	/* 0 - off, 1 - auto, 2 - on */
+	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	if (ret == 0) {
+		get_req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+		get_rsp = ethtool_rings_get(ys, get_req);
+		ethtool_rings_get_req_free(get_req);
+		if (get_rsp)
+			fprintf(stderr, "TCP header split: %s\n",
+				tcp_data_split_str(get_rsp->tcp_data_split));
+		ethtool_rings_get_rsp_free(get_rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_rss(void)
@@ -358,6 +408,9 @@ int do_server(struct memory_buffer *mem)
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
+	if (configure_headersplit(1))
+		error(1, 0, "Failed to enable TCP header split\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
-- 
2.47.0


