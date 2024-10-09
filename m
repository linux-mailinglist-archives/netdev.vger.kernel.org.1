Return-Path: <netdev+bounces-133834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC599972CD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797E5B24C40
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E91E1C17;
	Wed,  9 Oct 2024 17:13:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEC1E1A37
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493989; cv=none; b=BWy60VPwQ1FDxcawBijjGka73oNwVfRflAyIv7y3ykS2bdXo8v0UOfE/DyyOTAejNMzH9zVWi/Zt3HS9gacPYUNAEPhyeE1wsjZxS0HN3v+nChgQP2dGniUCnknrpzgSvShLOxpdpFwT58q/CBdHSZA1rMCRcnHi2al2dQYRxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493989; c=relaxed/simple;
	bh=/qVkdytMlaBiGOjGxXrXbqMZMovJTE1W72Hw9NA4+Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWCOk+6uABz+mG781mc2MYU+MGs/nkzGWZyFAYPiI+1GC6FQ1gmy7Swgxlu64xZVPeA88zA++zJe2Cb1DTRZM13EmJ73UJXARgOaJ0+nVNCsEhBUk4zNI4GKMB9fCtcTD0Y/5M45tuJ7xu1J7y+hTxJXu7h1P11xksCQZz+wVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71de9e1f374so28363b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493987; x=1729098787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MXqeeh4LmcyRK43z6/VTXXaUX+Z/swMGPXe+IPj444=;
        b=NWYg2VY0+y2LRBRLlufQFRhrjvJ8tNs56KvJdLKGY04Klk2uBfbkpaeRgdX1lSLl8b
         2K3kvMwhSdErk/JWUWWxkzUCA9PK7RjheX4Pg9L3sKELJQ0Axs2k/a6R1ANzipjLCmrq
         /47mIa5EN+OjiNnskM0MJol3oPMM0+8FJ0bAG2dVneBK30y9+3pVY39Qgh6Mc2II1piR
         c9/3Al+uq0uP1siqd4fy169mZaZaWlVMthS/hIgyBsvHiWKueTTUcQXhmUw7bAXSn4Xa
         f1cz67lfKrO5FzIkSFhHRcNYCzAPM4AlMmU/XnGg2sf49CwgwhbWWQ09pUvWsNHGs2k2
         BL5g==
X-Gm-Message-State: AOJu0YwHrIkAlyTmzLA4TeykaVmd05RpwfNNJJdYafAWPpwjWyF+ZWP1
	om8t0wCIhFjfpbusEPTWfWRTMlj+TX1LDvO006Kv1zmtC7c4S0eyLaQd
X-Google-Smtp-Source: AGHT+IEdtpm8FZT21bbfw2sFoASkEi115Pl9etjrAUDYGfnEFYA8gj71NLd8nVcoZmQD0qCyPFILHg==
X-Received: by 2002:a05:6a00:2394:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-71e1dbb53a8mr5057794b3a.22.1728493986840;
        Wed, 09 Oct 2024 10:13:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6520dsm8267416b3a.171.2024.10.09.10.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:06 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Wed,  9 Oct 2024 10:12:51 -0700
Message-ID: <20241009171252.2328284-12-sdf@fomichev.me>
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

This is where all the tests that depend on the HW functionality live in
and this is where the automated test is gonna be added in the next
patch.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/.gitignore        | 1 +
 tools/testing/selftests/drivers/net/hw/Makefile          | 9 +++++++++
 .../testing/selftests/{net => drivers/net/hw}/ncdevmem.c | 0
 tools/testing/selftests/net/.gitignore                   | 1 -
 tools/testing/selftests/net/Makefile                     | 9 ---------
 5 files changed, 10 insertions(+), 10 deletions(-)
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
index c9f2f48fc30f..7bce46817953 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,4 +26,13 @@ TEST_INCLUDES := \
 	../../../net/forwarding/tc_common.sh \
 	#
 
+# YNL files, must be before "include ..lib.mk"
+EXTRA_CLEAN += $(OUTPUT)/libynl.a $(OUTPUT)/ncdevmem
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
2.47.0


