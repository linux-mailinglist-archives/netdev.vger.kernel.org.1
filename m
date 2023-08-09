Return-Path: <netdev+bounces-25981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1407765BD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469371C2137D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C061DA52;
	Wed,  9 Aug 2023 16:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEA1D2F5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:54:33 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDEB128
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:54:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56463e0340cso104638a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600072; x=1692204872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPNCL2h2Yk0iVM2TXMAyw8lteKar2ayTQ5gnI+CrlwY=;
        b=GicCoH9oxpAap2NbclDS+ijO8buo3MYC+WBOhdHvZWEGNWxoSjHEFY8e8/K8gbgHy4
         snYETT/pzh2iJ6GygT/K3hMwG621KGphqH/njC4rtPxFsKivW4TaHksAgcsJJi02TNJD
         I2sguxYimENc2zRlmF264uNrtCAYNXRmMR6/nsOGBKG0KkItmyo659GTiWFoGx09ffT7
         CWVGrrzxFzjhUTffXVkEncnxbXCZCjQXO1azrzK+NnQOjFHRNY1Sv5WUnzO5TNitqQbc
         aSMboJkb/AGjLQ8rLvYY+q5RbCcG0ZOKrGBWXEGd3MtJyIwfeNBEkRCzni7PuhaNz9vB
         5ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600072; x=1692204872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPNCL2h2Yk0iVM2TXMAyw8lteKar2ayTQ5gnI+CrlwY=;
        b=jOA3L1eDIV0ijc5R4Z02jHbIJqjvfZN/RTM7varj+sytKCwjlBk7y5/5paBL7M5okU
         0iEt/E4mtudUvwCuHyMzcMQXIW2KIUMDz83cFLgHK5kPyjI6X3bV5t3dCFQWrI43Cqwq
         awcwX8iDC0i4NiLUjQD+feQqkPdfVIaSdRU+0HCpeO1Dzw5lBfuc4hmPO+10DymqMuLP
         R7FRgjemm8b+8MdUK2U6HpROy4aUS+NE0efm3MHvYFlkwMZ7vNO4N38YFA/xNzxzhCAB
         EVSGELFdOH1C236yzwIvNmBcVX7EVOhjWITKmGo85Y6LUr+XbAB3RMahmAgAtCCh8fEl
         xyiA==
X-Gm-Message-State: AOJu0YxGApRg0NskbcJiAQkrZmGfDBRequdLxNpOW4+slZfRL30pPcWH
	D1QxMgQLZveghWyk0MA+Ua7dwhQ=
X-Google-Smtp-Source: AGHT+IEQ7jDbp63pxepzuS37WQVUvH0F8J/jIFOfJDxRIhRIMXfGCPUxrcw+7XNUyKR4ZuJcrc2C/N4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3dc3:0:b0:53f:f4ca:1b0 with SMTP id
 k186-20020a633dc3000000b0053ff4ca01b0mr294649pga.9.1691600071807; Wed, 09 Aug
 2023 09:54:31 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:15 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-7-sdf@google.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Checksum helpers will be used to calculate pseudo-header checksum in
AF_XDP metadata selftests.

The helpers are mirroring existing kernel ones:
- csum_tcpudp_magic : IPv4 pseudo header csum
- csum_ipv6_magic : IPv6 pseudo header csum
- csum_fold : fold csum and do one's complement

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 5eccc67d1a99..654a854c9fb2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -70,4 +70,47 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+
+static __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__u16)~csum;
+}
+
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		s += (__u32)saddr->s6_addr32[i];
+	for (i = 0; i < 4; i++)
+		s += (__u32)daddr->s6_addr32[i];
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
 #endif
-- 
2.41.0.640.ga95def55d0-goog


