Return-Path: <netdev+bounces-20605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A1476037D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B190280C26
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6C154BB;
	Tue, 25 Jul 2023 00:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA6154B7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:00:12 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03F172D
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:00:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5734d919156so49071247b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243210; x=1690848010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0xCHxAGKShVCxci31z5oM/FwnvfCpkAI53IOFmhMP4=;
        b=jvqN6LEFCiL/2RpEj9tFUv78qoXSNVJQ8GmjzbkVkfI1nBhvq2pRPEOyK3DGZp9psG
         EhcLMiGs/jpeQzi9FFKzCyIbtjatViStG1YmXhdiGbAJX4uVs5giviHuycjy2DhebK4a
         1hGs77DA+OCyleHZSohx66GAaNRGt4b/JN17bDb81CPM7XDPaX1CMob0FxwNr1OzkkDm
         P5XtlNZLqsSWYQGk9B6KbZzO1ayZ6LmvRKlPl9XViqxWV9u238UiS+9w0DCvR6+Eugws
         fqfXtoO6CDj/AQTRwtzMMIKSkQhBEMrptyZe9DHKjnwsNIBFrFeFsdQG6R20H3nFQbAX
         P3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243210; x=1690848010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0xCHxAGKShVCxci31z5oM/FwnvfCpkAI53IOFmhMP4=;
        b=jjSWIEiWolx6ksxZ09aBhCeeR5/X3Xt77ygSudG8a8qvbgWu8WeR/5WJ4Au22c2RIg
         LjIkSCQbyyW+40KZFOwzucCQ+s9ctzt+d+JtNsiRCuDnm9vfIdTCOR4sAncssHeDYEEU
         cYRxeUP6H+anMwKpUJw/Zx59I41dFcRZ8ysUlSJTfZxTMmEANxNRlongMk6Tjm1VFmPz
         1heIrqtsbtkbBDtmVWMv834ck/1VR0EbHzANQ6utHXnUvoYRy5TpbiE6dziZD/O37Vdf
         aNC0VcVoEO60eRtB3DFJ4suQuGI00Kn8JKV7IFKYwacy1+GonV6ntUNBZlkXoZVanOJx
         s1bw==
X-Gm-Message-State: ABy/qLYB17IRGo+WhCkXq4Agu8T6flvWdl6irMYqQlAs3Ae9jkJflI6S
	eHFGdtEpPl4AnOAY8Y7UPR65CL4=
X-Google-Smtp-Source: APBJJlEgxr/axKa6jbuffaWm0GOh8TggDPXk67nc+YfYvbSh3OyokwhpRZY+YAjRzvWJ2vov0tNpeGY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af21:0:b0:56c:e585:8b17 with SMTP id
 n33-20020a81af21000000b0056ce5858b17mr75742ywh.5.1690243210706; Mon, 24 Jul
 2023 17:00:10 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:55 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-7-sdf@google.com>
Subject: [RFC net-next v4 6/8] selftests/bpf: Add csum helpers
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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
index 694185644da6..d749757a36a3 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -67,4 +67,47 @@ struct nstoken;
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
2.41.0.487.g6d72f3e995-goog


