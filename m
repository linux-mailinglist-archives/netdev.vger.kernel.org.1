Return-Path: <netdev+bounces-42766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69547D00ED
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B691C20E4F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA037CA8;
	Thu, 19 Oct 2023 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sozcOd+g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30B39861
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:50:02 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD8511D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:49:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso10984156276.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737799; x=1698342599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrMWyFZARXAbpMZ2Cvd01jTOzKURZkdFORFzsP3Nbog=;
        b=sozcOd+gm7+oWQr4Pdeaz4CG1/tv3av3wtbcpxuM5G7nEl21faL49eNShlaLa+XaQ3
         kPUkqLa+w0CdobN/ofrRTuhqk0p9Vk5qrimkGrof+i5dUAGSRmPaErC8hq6/LeKMzPRe
         7ov7dJbtmiD58M5d/MPhlyYpra5EunyHJKr4GCI6xKAmMk5dDqM8igMLucFPEkk5tutS
         qYPtJ1OzKdIQ3z00qWuHJx2/4VVXUfrn1QMmHmVO6TN+qI2M4ZR7CB8TpWKAUZBcadCV
         nH9BQQzTaUp7wqbBe3UGwo5jscS4BYOB11ElcslKXGHCA3psqjTyYlMNJAvQHhaDJONw
         VRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737799; x=1698342599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrMWyFZARXAbpMZ2Cvd01jTOzKURZkdFORFzsP3Nbog=;
        b=llAgitsjz0qSVuVK77H0pQyEZaKThkcYujKMSFU0/T/1dgql+T1fR8vN6GHuUiQGnb
         UdBpond+pdvN65/4olIqzJUXp4uRhrWX80XBK+G8uzOZI+9/qCz6+YYWciiPa5ogcxD5
         sMGB+ETkA2f2xioMbW0sHTvFQBGjQtddUUCyJ6azsCMBfdfSwuNf7l+e6EQAWMeyjo0d
         Xqrr5z+kwn0BL3gEF9uF7TcsOaTLdGx1ngLNOLSxKjUnSiqOJR6COeD2guGfSJI14ovK
         PxVW5tndhSsfaWqxhLEGvGztcvYV9f/XpCmKcFHYrg+MKiTOwzJjrEXGHJ5mTicBbv9W
         AmEQ==
X-Gm-Message-State: AOJu0YxIAmzOlxyD4z8OMbPMWAoxJ5QRYlnnyDqj847NpAKMPKaDnZuX
	UQQnntdg+TrKnZ6iC40nOMJcxXs=
X-Google-Smtp-Source: AGHT+IHxAHuZty9GGyTtLqkmEaq6ArCG74wlQJWAeDJOpo/lmMbANhh3Wg7LQS1zGZMT2E0QcNDyIUs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2683:0:b0:d9a:519f:d0e6 with SMTP id
 m125-20020a252683000000b00d9a519fd0e6mr64878ybm.6.1697737798751; Thu, 19 Oct
 2023 10:49:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:40 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-8-sdf@google.com>
Subject: [PATCH bpf-next v4 07/11] selftests/bpf: Add csum helpers
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
index 34f1200a781b..94b9be24e39b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,4 +71,47 @@ struct nstoken;
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
2.42.0.655.g421f12c284-goog


