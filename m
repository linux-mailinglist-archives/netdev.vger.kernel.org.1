Return-Path: <netdev+bounces-33965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF597A0F8B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 23:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96BB1C20ECB
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B3273F9;
	Thu, 14 Sep 2023 21:05:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACB273EA
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 21:05:07 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589726B7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:05:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5659b9ae3ebso1109485a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725506; x=1695330306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14VbHOqDafwAEmRkcsvovpu96sXlLVwtTgqqhNnYgGk=;
        b=K7ZVy7yzeaqIQY74d/bmQ4dq8jAWhVknqfFm2IRjfI2jqO3YehlaHxGqZKHNvs1D1A
         /bGqi2T8KOmL3o0hwYQsRyfP1+xZwK3QpKsusqd/u6ewY8J+9qbst4iA/MMyclGlyZIH
         HzA/0b2PDsQOEUhCJDihzZr2IB430NMgI2bliqCYWi02OoVfI6nhPbBn3GdO68kj44dY
         srKqwUGWOmJcj0hX+M9rBXMyuxDAutYV2URUU40o1EZGwe/5WR4qaXNL4ySXfv+dKRxD
         7vyzSmYsq2haOcpVE+dyvewn/ZZY+tcah/hSPXXgeVfahWuo/CbN5Yi+1e2I/5YKr2lJ
         db/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725506; x=1695330306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14VbHOqDafwAEmRkcsvovpu96sXlLVwtTgqqhNnYgGk=;
        b=fnREMzuaNv/VQZ4smtQ6+CRrVY7/zQCqEFJmnO5cD3Piv3UIl9lzqbkcNXQzgzNfas
         mowmBkR+TtCvJFoBLVI1IA1xt4WFJ3TI16KVl7FdyxRZ//+GmUmVd72CMarpmiR4/PCz
         sJpOv5QrRxmVoPEtlfCKLvBzvUYVplHTmYtV6iX+ESu4BshPg9LLNX5ntcD6u8UdyYZD
         TuTfpiyHfw7v9GTwt7MkrwC/0gEtOG6ZUc4pWpwTM6nyKRIqUO/M6Ei9wV0ILZrKsLHA
         PtZstPjymXkTjzm+iTNBg+H/E2EUu3E3ukGaR/buz1Uw85IltuHY1RttRSt4IEpa2J+u
         se8Q==
X-Gm-Message-State: AOJu0YyTbEDAo4ePiki+6uhMdQMXq66pXTDzmYPYX5WZxsajfrqKH6bT
	dnyNKgRNs9Q3ShD638MQNaEl6EU=
X-Google-Smtp-Source: AGHT+IHwSi48qvJdhvmPfcZWPgqPC20HubxSk5DHX5wOCnxgL7h677co1BhFyfAM+WdU60ZWR+hFZKA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:be41:0:b0:563:84fc:f4dd with SMTP id
 g1-20020a63be41000000b0056384fcf4ddmr146499pgo.6.1694725506209; Thu, 14 Sep
 2023 14:05:06 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:49 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-7-sdf@google.com>
Subject: [PATCH bpf-next v2 6/9] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

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
2.42.0.459.ge4e396fd5e-goog


