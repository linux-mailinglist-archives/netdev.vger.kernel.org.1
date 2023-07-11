Return-Path: <netdev+bounces-16718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E374E7FF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB31C20A72
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275A171D9;
	Tue, 11 Jul 2023 07:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1B5CBC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:31:36 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DB195
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:31:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2955577b3a.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689060693; x=1691652693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mU7adQxergy0+EODg7ZGlSf1AjfLmSwIzNA8dsXtYw=;
        b=gtysNIRX3U6hTOJBac7SvT3Z4d0hasjxDd9qUCQ2VrXofYumAJypIJZCNsOHls3rur
         QeY5+Y9/DuGAEGNd4OB8lVuYbxEyuDoT/14UPMkTCGeHil5/HLMd4EMB3UlNhu5ueOJW
         9fptDDKGK9wVpv9TBP4yWYpRJMzF5yJGLFohSqKxwPeqIVFTO7tG+nY6Oj1mbmA02G4j
         eaaowE4a+mhho1WV7wgh7by8FtT2jkM742pprfahfVgVCZMFxxumiwJF5mTjiDEmW+6N
         dwqr8akMckGqxR2sPGXYNnZUBPMjRb4/4Zs3UA2oSOHPmdV9KUHe1BYVa+IqI21AZdTV
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060693; x=1691652693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mU7adQxergy0+EODg7ZGlSf1AjfLmSwIzNA8dsXtYw=;
        b=EusZmWQkAxsPN1bw4qPVpA1ujoxWWueDMBHXQKsjRgvOwYtUZo4Y2Rc7w/dXLdfF90
         CZCXOG08p71J5VDDiZjp42RiQVJShbUPzL7pLZy5HnGKourNQf0INdhkzltIQNSAcXDZ
         zSu7v9F6hkfmosdFxbn/x3zCGIfE6oaqS8JbhgeQXAERtF3/L07fCI1zHX4RPuqYCPcd
         Rk/yJBvYzcs0hndPU/WeLFKE+Iwv3mGSeSFIlWqnHo7KWO/HRmSS+7/AEZmXgw9MCG/Q
         bYYQeIgDeVeNuCmqIUnT8D81jU7jRcRfZU1akekL49eglgccLbpbBtdLO8Nv1xVT8opn
         2luw==
X-Gm-Message-State: ABy/qLZ6gIivysj7r/Kz0g3rVzRofk2QKK5DYptNVX8zpnWpq4Lnq0ep
	+YilllmcL564Br6sgXyd8PwEzjrvvurWaQ==
X-Google-Smtp-Source: APBJJlEF8jjXXgnNQD/QVp7zAJWL6KyDs7S+n4BUfHHKmuEK5A0xvRaZYSJFPJQoifvd3AGymAuQGA==
X-Received: by 2002:a05:6a20:7489:b0:126:78b0:993a with SMTP id p9-20020a056a20748900b0012678b0993amr13810426pzd.29.1689060692562;
        Tue, 11 Jul 2023 00:31:32 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([2409:8a02:7829:4ce0:2824:2fe6:d3e1:6539])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78e13000000b0062bc045bf4fsm1076138pfr.19.2023.07.11.00.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:31:28 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrea Claudi <aclaudi@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ying Xu <yinxu@redhat.com>
Subject: [PATCH iproute2] lib: move rtnl_echo_talk from libnetlink to utils
Date: Tue, 11 Jul 2023 15:31:17 +0800
Message-Id: <20230711073117.1105575-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In commit 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()"),
some json obj functions were exported in libnetlink. Which cause build
error like:
    /usr/bin/ld: /tmp/cc6YaGBM.o: in function `rtnl_echo_talk':
    libnetlink.c:(.text+0x25bd): undefined reference to `new_json_obj'
    /usr/bin/ld: libnetlink.c:(.text+0x25c7): undefined reference to `open_json_object'
    /usr/bin/ld: libnetlink.c:(.text+0x25e3): undefined reference to `close_json_object'
    /usr/bin/ld: libnetlink.c:(.text+0x25e8): undefined reference to `delete_json_obj'
    collect2: error: ld returned 1 exit status

Commit 6d68d7f85d8a ("testsuite: fix build failure") only fixed this issue
for iproute building. But if other applications include the libnetlink.a,
they still have this problem, because libutil.a is not exported to the
LDLIBS. So let's move the rtnl_echo_talk() from libnetlink.c to utils.c
to avoid this issue.

After the fix, we can also remove the update by c0a06885b944 ("testsuite: fix
testsuite build failure when iproute build without libcap-devel").

Reported-by: Ying Xu <yinxu@redhat.com>
Fixes: 6c09257f1bf6 ("rtnetlink: add new function rtnl_echo_talk()")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/libnetlink.h     |  3 ---
 include/utils.h          |  3 +++
 lib/libnetlink.c         | 22 ----------------------
 lib/utils.c              | 22 ++++++++++++++++++++++
 testsuite/tools/Makefile |  8 ++------
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 39ed87a7..1c4557e8 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -171,9 +171,6 @@ int rtnl_dump_filter_errhndlr_nc(struct rtnl_handle *rth,
 #define rtnl_dump_filter_errhndlr(rth, filter, farg, errhndlr, earg) \
 	rtnl_dump_filter_errhndlr_nc(rth, filter, farg, errhndlr, earg, 0)
 
-int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
-		   int (*print_info)(struct nlmsghdr *n, void *arg))
-	__attribute__((warn_unused_result));
 int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 	      struct nlmsghdr **answer)
 	__attribute__((warn_unused_result));
diff --git a/include/utils.h b/include/utils.h
index 0b5d86a2..841c2547 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -385,4 +385,7 @@ int proto_a2n(unsigned short *id, const char *buf,
 const char *proto_n2a(unsigned short id, char *buf, int len,
 		      const struct proto *proto_tb, size_t tb_len);
 
+int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
+		   int (*print_info)(struct nlmsghdr *n, void *arg))
+	__attribute__((warn_unused_result));
 #endif /* __UTILS_H__ */
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 7edcd285..55a8e135 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -1140,28 +1140,6 @@ static int __rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 	return __rtnl_talk_iov(rtnl, &iov, 1, answer, show_rtnl_err, errfn);
 }
 
-int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
-		   int (*print_info)(struct nlmsghdr *n, void *arg))
-{
-	struct nlmsghdr *answer;
-	int ret;
-
-	n->nlmsg_flags |= NLM_F_ECHO | NLM_F_ACK;
-
-	ret = rtnl_talk(rtnl, n, &answer);
-	if (ret)
-		return ret;
-
-	new_json_obj(json);
-	open_json_object(NULL);
-	print_info(answer, stdout);
-	close_json_object();
-	delete_json_obj();
-	free(answer);
-
-	return 0;
-}
-
 int rtnl_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n,
 	      struct nlmsghdr **answer)
 {
diff --git a/lib/utils.c b/lib/utils.c
index b1f27305..8b89052c 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1952,3 +1952,25 @@ int proto_a2n(unsigned short *id, const char *buf,
 
 	return 0;
 }
+
+int rtnl_echo_talk(struct rtnl_handle *rtnl, struct nlmsghdr *n, int json,
+		   int (*print_info)(struct nlmsghdr *n, void *arg))
+{
+	struct nlmsghdr *answer;
+	int ret;
+
+	n->nlmsg_flags |= NLM_F_ECHO | NLM_F_ACK;
+
+	ret = rtnl_talk(rtnl, n, &answer);
+	if (ret)
+		return ret;
+
+	new_json_obj(json);
+	open_json_object(NULL);
+	print_info(answer, stdout);
+	close_json_object();
+	delete_json_obj();
+	free(answer);
+
+	return 0;
+}
diff --git a/testsuite/tools/Makefile b/testsuite/tools/Makefile
index 0356ddae..56d7a71c 100644
--- a/testsuite/tools/Makefile
+++ b/testsuite/tools/Makefile
@@ -1,13 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS=
-LDLIBS=
 include ../../config.mk
-ifeq ($(HAVE_CAP),y)
-LDLIBS+= -lcap
-endif
 
-generate_nlmsg: generate_nlmsg.c ../../lib/libnetlink.a ../../lib/libutil.a
-	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(EXTRA_CFLAGS) -I../../include -I../../include/uapi -include../../include/uapi/linux/netlink.h -o $@ $^ -lmnl $(LDLIBS)
+generate_nlmsg: generate_nlmsg.c ../../lib/libnetlink.a
+	$(QUIET_CC)$(CC) $(CPPFLAGS) $(CFLAGS) $(EXTRA_CFLAGS) -I../../include -I../../include/uapi -include../../include/uapi/linux/netlink.h -o $@ $^ -lmnl
 
 clean:
 	rm -f generate_nlmsg
-- 
2.38.1


