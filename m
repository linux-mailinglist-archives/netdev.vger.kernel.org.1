Return-Path: <netdev+bounces-38917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8527BD005
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B56D1C209D3
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433481A5B1;
	Sun,  8 Oct 2023 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne8zeq7i"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B594FBF0
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 20:12:52 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F7B3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 13:12:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3af5fcb5e37so2714543b6e.0
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696795968; x=1697400768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ay/TcEg/S/ybayJhZXidfw3Q3AAi4EgcKb1TnJa9+s=;
        b=ne8zeq7iJ3JxY/MjK9vr51nja9PP9l7vhzuvx8lZPXZLVQn3y2G6XDbCYH0C8Kb1KD
         qhUoK8wU6x/MTX94fi5qOizPwcbPOh86vpboVCrYJE8K8+DcJsCi1RZDdYOinCZVSfIx
         7PzSlI5MW9XzP58rmhTUW1CSybam02kMdpRl8TK/2hfy67OFsdXhRjxQysS6IsP8uGv6
         GsWkDnZQm1lQRboF5vDUtuju2eBcDQBlW7JknyBWQtalgAJIrjFzBT084o6jOG5sVDlV
         G/UJ83Og49/Pjmrb+MeykAhMIR74X+TIlj8+gebFq3u/9uHUxpF4FlTTZAslN74Xwtm4
         Ng7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696795968; x=1697400768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ay/TcEg/S/ybayJhZXidfw3Q3AAi4EgcKb1TnJa9+s=;
        b=hayEEssYlkpNMjmQYrITVXgCzLoARRU8rnw1QSn7IGCB9yj/M/XjziQTJCUOJ5NRlx
         eRnkZae2AciS1mm6mMr3HrAtBpGcPyFnvcMta4RWW8g7cBu9gMlapISB7P3KpJA8rRyO
         DnWku2ned2UQK7P8DR4fT5gA9OvQ60EuOQNlN3hOVR70gqvUC2YANJgYamwk6z9sXPa+
         UdHktq1ses6OWwbXFLwt+LOjHyWr4JPpr1I4eVCFqp3/96LMNwZPl32ekq1JwNFgZMnw
         qDX0TAOD8jx+ihlYggr+2SrqdRpjpxhr0EoqtmtRiozovchoXbQzjXZX0FSIhJ3hFIh3
         5S7w==
X-Gm-Message-State: AOJu0YxAR6mYU7C6HGstk4LwGxP6MDN4x7yIKRbUL+pOKZUvM8G8asMG
	seCXWnhanr2XprOLHnuckWteo5PiKwiZfg==
X-Google-Smtp-Source: AGHT+IEEItzD3eOHtFP+UGr9TrCLB8kH92LEi5nAwAhd3xM1/FYzlGtIgbpNNRnvzX3eCG97xFc4cQ==
X-Received: by 2002:a05:6808:13d1:b0:3ab:84f0:b490 with SMTP id d17-20020a05680813d100b003ab84f0b490mr17442887oiw.27.1696795968171;
        Sun, 08 Oct 2023 13:12:48 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id v18-20020ac87292000000b00419c9215f0asm3075533qto.53.2023.10.08.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 13:12:47 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 1/3] net: add skb_segment kunit test
Date: Sun,  8 Oct 2023 16:12:32 -0400
Message-ID: <20231008201244.3700784-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008201244.3700784-1-willemdebruijn.kernel@gmail.com>
References: <20231008201244.3700784-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemb@google.com>

Add unit testing for skb segment. This function is exercised by many
different code paths, such as GSO_PARTIAL or GSO_BY_FRAGS, linear
(with or without head_frag), frags or frag_list skbs, etc.

It is infeasible to manually run tests that cover all code paths when
making changes. The long and complex function also makes it hard to
establish through analysis alone that a patch has no unintended
side-effects.

Add code coverage through kunit regression testing. Introduce kunit
infrastructure for tests under net/core, and add this first test.

This first skb_segment test exercises a simple case: a linear skb.
Follow-on patches will parametrize the test and add more variants.

Tested: Built and ran the test with

    make ARCH=um mrproper

    ./tools/testing/kunit/kunit.py run \
        --kconfig_add CONFIG_NET=y \
        --kconfig_add CONFIG_DEBUG_KERNEL=y \
        --kconfig_add CONFIG_DEBUG_INFO=y \
        --kconfig_add=CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y \
        net_core_gso

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - add MODULE_DESCRIPTION
---
 net/Kconfig         |  9 +++++
 net/core/Makefile   |  1 +
 net/core/gso_test.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 net/core/gso_test.c

diff --git a/net/Kconfig b/net/Kconfig
index d532ec33f1fed..17676dba10fbe 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -508,4 +508,13 @@ config NETDEV_ADDR_LIST_TEST
 	default KUNIT_ALL_TESTS
 	depends on KUNIT
 
+config NET_TEST
+	tristate "KUnit tests for networking" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests covering core networking infra, such as sk_buff.
+
+	  If unsure, say N.
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 731db2eaa6107..0cb734cbc24b2 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
 obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
+obj-$(CONFIG_NET_TEST) += gso_test.o
diff --git a/net/core/gso_test.c b/net/core/gso_test.c
new file mode 100644
index 0000000000000..eaa85939ed208
--- /dev/null
+++ b/net/core/gso_test.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <kunit/test.h>
+#include <linux/skbuff.h>
+
+static const char hdr[] = "abcdefgh";
+static const int gso_size = 1000, last_seg_size = 1;
+
+/* default: create 3 segment gso packet */
+static const int payload_len = (2 * gso_size) + last_seg_size;
+
+static void __init_skb(struct sk_buff *skb)
+{
+	skb_reset_mac_header(skb);
+	memcpy(skb_mac_header(skb), hdr, sizeof(hdr));
+
+	/* skb_segment expects skb->data at start of payload */
+	skb_pull(skb, sizeof(hdr));
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	/* proto is arbitrary, as long as not ETH_P_TEB or vlan */
+	skb->protocol = htons(ETH_P_ATALK);
+	skb_shinfo(skb)->gso_size = gso_size;
+}
+
+static void gso_test_func(struct kunit *test)
+{
+	const int shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	struct sk_buff *skb, *segs, *cur;
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	skb = build_skb(page_address(page), sizeof(hdr) + payload_len + shinfo_size);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	__skb_put(skb, sizeof(hdr) + payload_len);
+
+	__init_skb(skb);
+
+	segs = skb_segment(skb, NETIF_F_SG | NETIF_F_HW_CSUM);
+	if (IS_ERR(segs)) {
+		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
+		goto free_gso_skb;
+	} else if (!segs) {
+		KUNIT_FAIL(test, "no segments");
+		goto free_gso_skb;
+	}
+
+	for (cur = segs; cur; cur = cur->next) {
+		/* segs have skb->data pointing to the mac header */
+		KUNIT_ASSERT_PTR_EQ(test, skb_mac_header(cur), cur->data);
+		KUNIT_ASSERT_PTR_EQ(test, skb_network_header(cur), cur->data + sizeof(hdr));
+
+		/* header was copied to all segs */
+		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+
+		/* all segs are gso_size, except for last */
+		if (cur->next) {
+			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + gso_size);
+		} else {
+			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + last_seg_size);
+
+			/* last seg can be found through segs->prev pointer */
+			KUNIT_ASSERT_PTR_EQ(test, cur, segs->prev);
+		}
+	}
+
+	consume_skb(segs);
+free_gso_skb:
+	consume_skb(skb);
+}
+
+static struct kunit_case gso_test_cases[] = {
+	KUNIT_CASE(gso_test_func),
+	{}
+};
+
+static struct kunit_suite gso_test_suite = {
+	.name = "net_core_gso",
+	.test_cases = gso_test_cases,
+};
+
+kunit_test_suite(gso_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for segmentation offload");
-- 
2.42.0.609.gbb76f46606-goog


