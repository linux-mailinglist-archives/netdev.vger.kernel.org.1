Return-Path: <netdev+bounces-16127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2574B733
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCDF2818FF
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B094182C4;
	Fri,  7 Jul 2023 19:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C5182A1
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:39 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962FC2D7B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so26148797b3.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758228; x=1691350228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uP/xR8GNlI9E0++CqO6Or9j9eKuQF1wvhQ+qGbLlU6w=;
        b=XTJck82fPkG97J5gsOeXeYkqH8nCywY1DDfNbK8/nCi8t2cRVkhEjX8VEAXIHg7/Zk
         8g6Kh8zn0HGfyoY1rXtGJmMTI79oYlidN/7ViT6Q3c4iAECAx/xkDR5s08nnVFf2T8xK
         XJtNYubm6/9qj6SSR7ZtaWfPq4QGnkORBbD+Oai538WBbEXAQ63/th5VRP+1HmV7rs00
         7YILxTLE9vBCRh/N1XUKP5whua8XBXiOkxXaHkhIYE7CIK8t4v4ilzSXq8lGb48xwd+3
         nmpMCdv1klmBA8Kz9Sz43YV66mRNR456QizOykw48EnUtcNoOdbF/J03eMmfAG9PQ1oI
         /ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758228; x=1691350228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP/xR8GNlI9E0++CqO6Or9j9eKuQF1wvhQ+qGbLlU6w=;
        b=iOicIAQX7ROn8TYOp3nanehDc2wWL3W7NQwi39V7z0WQIN3VENzSbbWr6MqetGEvow
         I2/KLPypg+nKdEmY+wfIfoM8d1RQdCnuB3ZpL2wadrYBkCUXLoxhpj8ehxv4d9nLUDMD
         dEWB80r0ER2igMyx8wwM8e7xVWnJfQ8eGWQDX6jiSTOpio9YkK+bct0f7378WTeh1tia
         b4/kouen5aLsOmmetutq3mqnQK4jp2TvJdY/fQMBvIuS4Yu7QNYVyfeVyELWGsFciAtW
         8xtmwsAb3ROs/y6fQGWGbK0So6eF/gsYM2yxHc1ZiTarUVnlCKD2Vxqwk1Z+3OSivu4A
         wGtQ==
X-Gm-Message-State: ABy/qLZXVdT6WFU/PvlrqDVDpG1Zvr4Dh8pLWu25IFO1pR8jj1YMwL8l
	lIGd8nXELdAtsFjR75B9sDHulVY=
X-Google-Smtp-Source: APBJJlFgJMbRpngCZb0FDr/VhvFmrEwCo2d0zmU6ymIwzLko5drtS0s4gPqFvXqZBR5r/curoHpemlM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4323:0:b0:56c:e585:8b17 with SMTP id
 q35-20020a814323000000b0056ce5858b17mr44285ywa.5.1688758227697; Fri, 07 Jul
 2023 12:30:27 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:30:03 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-12-sdf@google.com>
Subject: [RFC bpf-next v3 11/14] selftests/bpf: Add helper to query current
 netns cookie
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

Will be used to filter out netdev in AF_XDP metadata selftests.
The helper returns netns cookie of the current process.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a105c0cd008a..34102fce5a88 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -450,3 +450,24 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+#ifndef SO_NETNS_COOKIE
+#define SO_NETNS_COOKIE 71
+#endif
+
+__u64 get_net_cookie(void)
+{
+	socklen_t optlen;
+	__u64 optval = 0;
+	int fd;
+
+	fd = socket(AF_LOCAL, SOCK_DGRAM, 0);
+	if (fd >= 0) {
+		optlen = sizeof(optval);
+		getsockopt(fd, SOL_SOCKET, SO_NETNS_COOKIE, &optval, &optlen);
+		close(fd);
+	}
+
+	return optval;
+}
+
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 694185644da6..380047161aac 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -57,6 +57,7 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
+__u64 get_net_cookie(void);
 
 struct nstoken;
 /**
-- 
2.41.0.255.g8b1d071c50-goog


