Return-Path: <netdev+bounces-296265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /KpWGrymJWpuKAIAu9opvQ
	(envelope-from <netdev+bounces-296265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3956510EE
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 19:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GOnqxaAQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296265-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21863012EAE
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4E2E2852;
	Sun,  7 Jun 2026 17:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0145BE3
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 17:10:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852231; cv=none; b=CYRbYBCVgE84/DFRsaglMj+PWIrfpdjr8qAa0UY5Nk7Jc+NZhgQcn40BagYP3PufuWZtamZAuRWnUks4QWjoQ4I3mHrEQB4L13ua7AiC6UrvcD7FFJwHWQv7LKOEWQWMkQOzl0gi3+fRSHlqD1dVXO5bDwDZftHFST8I6L/p8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852231; c=relaxed/simple;
	bh=POr7Ix06Wp1uWzM/s/uHnlsY2+YTVLr9bOr1tz902ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHo2MNEUprKFpHmZl/QDlW6YbDk11OLKjMGp4Wy6ABYZh/Gzvo7iaud5g84pQ9eeeyDjy2timtZ1MvYhnOv7JZDxeImqZgxQDVdVD4A5cqFwvOyTsZRHBQr8/PxjdyJzxFnyzMK7Tu2sE9tlaqSsdI9RXd5UcMs3UvjqbQpKhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOnqxaAQ; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c3315c5dso38081695ad.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852229; x=1781457029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=GOnqxaAQGzQVjv888xjQFkCye5CGOIV+20umJK1IzH5A4zf4/fbK7of3ePnQhItiMx
         9C/rDthzXWuRA0H6mWLZ2sorIAqRbbjUgUzcRhsjIbs0oZ1luD/smsD00xAaY4OzACLl
         zivDjLU09inS7/B6LEfy8AuhLwV0vG0yV3FkVQ8xyNMqISLIcRhyiXZNbRtz2lC1uDXe
         a+5TLg7SgMEss/QL2NSKkESL+T03UyF+JwIBn2WgPAi0T0Z3aO7vk8bimoOSQCqr6sal
         IXIrjWTpWTIiWDPao/oR3BfvOatxLkmuCuhGHy+eUERJODWpIlTGL2RoiyVrEYWm+0s2
         KSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852229; x=1781457029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bTfbPBlxFmhjxsli3uFXWEfIKIHGvct1qlkSlFL8qW4=;
        b=n/OtHvNIEQthanWzbzrWFbEUv6rF2uUJUGKdzZYFKt2HkrQC4M5js4QN9N36jqT7e+
         BLDW/h9sT8DrAM4HAgnGYrpz7SiSdrl7O+XfnZJQBl1ARETOKfaPlcFTlo60TcDze81l
         KUhqfSXf71CmKiSmwgCRzsXE2bk1ElWAkgWEKLpHGPryYLmuoFxEicEqlZyacbZctW1B
         oo8SwIsJNm+4sDD5C9YSg+efQBYdfclwk2D+wGA59RWGkeQ1mZ0x35mIWsUqMXPQQehT
         F8z7y2w+lS4Kw2cVt7eD+kOSjK5+SY8xbXdQmAmAJWJngRvFpzQBuHsmxzDYTo//kkdk
         NacQ==
X-Gm-Message-State: AOJu0YwW0PUzhck4gWQ4TfbLmq3gYheaB9bKqZO5sPPifyHn051nPIlc
	7AyihowJ3fg2e6dF0RAT6lzTbuuSK1bUKFffFJLcI71uMoHCS3btDym+
X-Gm-Gg: Acq92OFIc+xWe9mv1BHGx6IqxYC7r9woxkhZRaQoQm5Uz95ZaRwcqELSeJ5vZdWcUA0
	e4REk5FMIiY51Mv5STWRulUAVDtjfX7EDMOOBI+rg6zCzDtVoaUFFhFomS46nPGTwRzvHzK9lqC
	8ClRGuJrTujxDtb4+Au9fl0fo9wk4PfvBXxPp5cYX8n1Yh7Zyg8mYUI+mkOjJrak5bpCM42brdJ
	vKgbOkFGE/EtX34XrRPq8ti5NN/smBIjk5S5NHUk0cdGXX2uj2ALs+mwFEipqwbirmKX6z1rLDD
	21QXYhty9bPhRkd48RFW/BF7KHGMbQOtixLqT0KD6xeGQdMU71sQZcBpYwbJBuNHrjHGtb0wrhE
	ODggLGirGnRUIH7Zp1GzrFot6tneg9MQbdl/2wIzI7J9TN9xULp3DeFi358iHrXZquFrB4AxzOy
	Y+DL1WzPc+zBVPPjrzhJ21Ow+QFiQ5vfVgt/lBTEldEQ==
X-Received: by 2002:a17:902:ef08:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2c1e820e30bmr150565325ad.13.1780852229364;
        Sun, 07 Jun 2026 10:10:29 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:28 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 3/3] selftests/bpf: add helper retval linked scalar pruning test
Date: Mon,  8 Jun 2026 01:09:58 +0800
Message-ID: <20260607170959.823755-4-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607170959.823755-1-jt26wzz@gmail.com>
References: <20260607170959.823755-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296265-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:sdf@google.com,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC3956510EE

Add a verifier test case covering a pruning bug where a helper return
value and another scalar become linked by scalar id on one path. A later
branch can then let the verifier explore an impossible continuation and
prune the real success path.

The test uses bpf_skb_load_bytes() to create a helper return value in R0
and a scalar derived from the tc test packet length. It then links the two
scalars on one path and checks that the later branch keeps the reachable
success path.

Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_reg_equal.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30f..269b2af50 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <stddef.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -55,4 +56,38 @@ l1_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile ("					\
+	r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);	\
+	r5 = *(u32 *)(r1 + %[__sk_buff_data]);		\
+	r7 -= r5;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r4 = 1;						\
+	call %[bpf_skb_load_bytes];			\
+	r6 = 1;						\
+	if r0 == 0 goto l0_%=;				\
+	r7 = r0;					\
+l0_%=:	if r0 != 0 goto l1_%=;				\
+	r7 <<= 32;					\
+	r7 >>= 32;					\
+	r6 = 1;						\
+	if r7 != %[test_data_len] goto l1_%=;		\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

