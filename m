Return-Path: <netdev+bounces-136303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFB9A1421
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E896BB22E56
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BF218312;
	Wed, 16 Oct 2024 20:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F702216420
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110878; cv=none; b=uWswdpYHBJ7lN1FdVcmvL0WCQqCAp70qUXiAuvYPYnr/75Z5mdJZSKD7xvr8Va0+gx6OpefJzhAXeMXkNlTGA8km0sGhgr72PgBWKCw5UP/DMFGzTv9KHQD+PmdBzxLTfZATSRkdJcar3/X+kdI2tSwIbIjfrgzLx0vQLodf34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110878; c=relaxed/simple;
	bh=QNIVoaUG6HoJ02+8aCHTzhZtbDvKJFEGC7k27W7G0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFlKkHiMMGELd186UYQq//8cK4O5x5IpB7F1KFP0j/B6rgwGF5K/NG8R6dt+CL8NRcjqYdmS+tK3TSTkMEjYB+9Z0PI6hPcaiknNDu9FytvsRWvE545obkgQZSk2Pcm7K1N/Xel4px+UMol2X86eJfTRDhmGDVFp8XHk8sdFH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cb47387ceso1978445ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110876; x=1729715676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLuAo808h43hPUqDZon7CMUoTgxLTq7GJOn3Y6RziyQ=;
        b=pF64veiiK+DuHeCKB+5U4pLaziod1zZtyRqHvvK99j8lBe+ltCjLXlpahC+1q4X0J4
         4HHzq4Vwc9sVZHE2utp8j3rHq4JnbBKPo7xvWD4V3qaR+HfJPmbUQIrQFOX/gzG3wMeX
         J6zVM4rIWyUT5cd2/0G7AJrkbjfobUC9dq4aMna+Iz6b8dWM4AjObdmjkoH09RsQv7CV
         lT7LEfSkIeEGKyyZIfHORIgNfVltfdPqYOKRJUiXzTsoSTR2YMNYjAsTEoDJpQ826t8D
         TJgQyOXNcGyIHaa21xggS5gsTuEoKonUZR1yGV3VOoN1/peaZetIvTHIS4tDHbVI2M9L
         JVqw==
X-Gm-Message-State: AOJu0Yx2u+69x0QK+gm731IhoMUwc7NKuB6BYLtgsHfhXfDKY+qoIOim
	9k825IWxDEx3KtG2uLArJHkBvubpfKstJvDVpw0WaiCNQI+eLdska/BOqwk=
X-Google-Smtp-Source: AGHT+IFinQFZKzO/61kwIWOjS6mMDf0MN1h96r0rr4DD5SRZTbtJmxos2CGMNHSciHzYqunD3BE8Lg==
X-Received: by 2002:a17:902:d4c6:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-20d27ed00e8mr59825605ad.28.1729110876392;
        Wed, 16 Oct 2024 13:34:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805ca55sm32542835ad.261.2024.10.16.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:36 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Wed, 16 Oct 2024 13:34:21 -0700
Message-ID: <20241016203422.1071021-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/.gitignore         | 1 +
 tools/testing/selftests/drivers/net/hw/Makefile           | 8 ++++++++
 .../testing/selftests/{net => drivers/net/hw}/ncdevmem.c  | 0
 tools/testing/selftests/net/.gitignore                    | 1 -
 tools/testing/selftests/net/Makefile                      | 8 --------
 5 files changed, 9 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 rename tools/testing/selftests/{net => drivers/net/hw}/ncdevmem.c (100%)

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
new file mode 100644
index 000000000000..e9fe6ede681a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -0,0 +1 @@
+ncdevmem
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc30f..182348f4bd40 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,4 +26,12 @@ TEST_INCLUDES := \
 	../../../net/forwarding/tc_common.sh \
 	#
 
+# YNL files, must be before "include ..lib.mk"
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../../lib.mk
+
+# YNL build
+YNL_GENS := ethtool netdev
+include ../../../net/ynl.mk
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
similarity index 100%
rename from tools/testing/selftests/net/ncdevmem.c
rename to tools/testing/selftests/drivers/net/hw/ncdevmem.c
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 217d8b7a7365..a78debbd1fe7 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -18,7 +18,6 @@ ipv6_flowlabel_mgr
 log.txt
 msg_oob
 msg_zerocopy
-ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 759b1d2dc8b4..22a5d6a7c3f3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,10 +97,6 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
-# YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := ncdevmem
-TEST_GEN_FILES += $(YNL_GEN_FILES)
-
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -110,10 +106,6 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
-# YNL build
-YNL_GENS := ethtool netdev
-include ynl.mk
-
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
-- 
2.47.0


