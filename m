Return-Path: <netdev+bounces-127895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8F976F61
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F1DB22B7A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162901BFDFF;
	Thu, 12 Sep 2024 17:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D1C0DCB
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161190; cv=none; b=Uedooj7tzubaO+aCbIEV0FhsEmTpWsD6zvDtgXeQBEd7Wk+DnsjO2wdHE8x41MQJMLsJ6qyhlrXa4ua5oBOe35KQjz4SyGaBoOHZhxKeXBDllUo3TBG+oJMHbHD3Tfn15KPDhsNK3c2JMoZQblN6feUVGVhQ9Rmws4AgkE2kyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161190; c=relaxed/simple;
	bh=aY9IKzJ+/Z7qBD4T7/hej92PLmomDK8vSLzho7l1aoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Zi91qQ3Zfu0PuVtlWp/ZBuMSu9+oXTaLEvvUEPlr7f9eILzhN5YTLE0cJO1VP60xMgBAgpPZslyGMLt8/R7PBBP24g/xvdg4BmnFiWXdgtPNuXMS1oDRenIE9wx2WCxRnN/eiQPQI8iInHsgKd+073wedhpmj7/2JUiDZtQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717849c0dcaso82073b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161187; x=1726765987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS3kqnfbA9PQ+xFCHu6mnQBzNhe7mokZPsZ2P0mtUkc=;
        b=SCitoRO7MviQbh/zc6wqSrC74/4dqyJEdJGayn6lPlNBB6w8mkuYCgV5UoEqqPIWxV
         W4JgqAz6j8UQXOgT3dYi1yWOR1f3358qKXSy1mffJ9UqYD9vYf7oKL9wkvJnFeoljlcT
         ZAotdSmM/O/bdvFM5ErmrL7pOu691zAfEvnZYRxD33rgvST5hgLlWQ308UEsO29smGan
         +C3R8ZZFqjlynXthNtfQjwg/dusf1ennWTNnuDqaVjaSoNHjyqh9BMlHlyOlYTs5HIPX
         HmeKWkO24+9FYyKloGyOfzLmoqU6cWbMOfSeRqbHybzAwpvy5PQCovi2ySlhmBwlAoZk
         O4TA==
X-Gm-Message-State: AOJu0Yw6jZVgF2hfdokWV4uZn3iuHCYKHS90i55hvp8lvwNif4Shngsb
	0YOSoID4jEjmayvswnXHVOV2ir3oDqSme0PWxwLLu99QBPXnj0qPw7HD
X-Google-Smtp-Source: AGHT+IHmAzqCgD5+ALk//iwfL9YGHkZcXB/MPBCrvl//h69+geq0nnYjELIF8Kgz9dWmK6+wZW8OEA==
X-Received: by 2002:a05:6a00:17a5:b0:714:228d:e9f5 with SMTP id d2e1a72fcca58-7192606354emr5451355b3a.2.1726161187499;
        Thu, 12 Sep 2024 10:13:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909092516sm4810737b3a.136.2024.09.12.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 12/13] selftests: ncdevmem: Move ncdevmem under drivers/net
Date: Thu, 12 Sep 2024 10:12:50 -0700
Message-ID: <20240912171251.937743-13-sdf@fomichev.me>
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

This is where all the tests that depend on the HW functionality live in
and this is where the automated test is gonna be added in the next
patch.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/.gitignore       | 1 +
 tools/testing/selftests/drivers/net/Makefile         | 9 +++++++++
 tools/testing/selftests/{ => drivers}/net/ncdevmem.c | 0
 tools/testing/selftests/net/.gitignore               | 1 -
 tools/testing/selftests/net/Makefile                 | 9 ---------
 5 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 rename tools/testing/selftests/{ => drivers}/net/ncdevmem.c (100%)

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
new file mode 100644
index 000000000000..e9fe6ede681a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -0,0 +1 @@
+ncdevmem
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 39fb97a8c1df..bb8f7374942e 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -11,4 +11,13 @@ TEST_PROGS := \
 	stats.py \
 # end of TEST_PROGS
 
+# YNL files, must be before "include ..lib.mk"
+EXTRA_CLEAN += $(OUTPUT)/libynl.a $(OUTPUT)/ncdevmem
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../lib.mk
+
+# YNL build
+YNL_GENS := ethtool netdev
+include ../../net/ynl.mk
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/drivers/net/ncdevmem.c
similarity index 100%
rename from tools/testing/selftests/net/ncdevmem.c
rename to tools/testing/selftests/drivers/net/ncdevmem.c
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 1c04c780db66..923bf098e2eb 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -17,7 +17,6 @@ ipv6_flowlabel
 ipv6_flowlabel_mgr
 log.txt
 msg_zerocopy
-ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 9c970e96ed33..22a5d6a7c3f3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,11 +97,6 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
-# YNL files, must be before "include ..lib.mk"
-EXTRA_CLEAN += $(OUTPUT)/libynl.a
-YNL_GEN_FILES := ncdevmem
-TEST_GEN_FILES += $(YNL_GEN_FILES)
-
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -111,10 +106,6 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
-# YNL build
-YNL_GENS := ethtool netdev
-include ynl.mk
-
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
-- 
2.46.0


