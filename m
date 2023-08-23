Return-Path: <netdev+bounces-30075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A66785E96
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F91C20CA9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15E1F198;
	Wed, 23 Aug 2023 17:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E41F193
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:30:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B14E7B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692811854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YA7yvBy+YjOzps+3DAp9V5ZbeCkQpGhp7ng8IJtzjlU=;
	b=fA54jldX7etPY/x4UODgzp0qxIpaguP7fAgwaCpsR44lk+u9G5dj27nKDVq4NJ1NSYvl4T
	+pTKmqOYgqetnP8n8CWOcgdc4vv0fjDffMwKOiK8kGxqpDpOp5U2h8FKIDRoin0VPCEKId
	eG20JKrwxMkph+P5QqBmF0W860ccZ34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-8kamPRonPtaN0uwUfmj44A-1; Wed, 23 Aug 2023 13:30:53 -0400
X-MC-Unique: 8kamPRonPtaN0uwUfmj44A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF83C101A5BA;
	Wed, 23 Aug 2023 17:30:52 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1F9C492C13;
	Wed, 23 Aug 2023 17:30:51 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next 3/4] lib: add SELinux include and stub functions
Date: Wed, 23 Aug 2023 19:30:01 +0200
Message-ID: <3cac535713c87bb3e759e4d3210a0e56cf5398ed.1692804730.git.aclaudi@redhat.com>
In-Reply-To: <cover.1692804730.git.aclaudi@redhat.com>
References: <cover.1692804730.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ss provides some selinux stub functions, useful when iproute2 is
compiled without selinux support.

Move them to lib/ so we can use them in other iproute2 tools.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 include/selinux.h |  9 +++++++++
 lib/Makefile      |  4 ++++
 lib/selinux.c     | 32 ++++++++++++++++++++++++++++++++
 misc/ss.c         | 34 +---------------------------------
 4 files changed, 46 insertions(+), 33 deletions(-)
 create mode 100644 include/selinux.h
 create mode 100644 lib/selinux.c

diff --git a/include/selinux.h b/include/selinux.h
new file mode 100644
index 00000000..499aa966
--- /dev/null
+++ b/include/selinux.h
@@ -0,0 +1,9 @@
+#if HAVE_SELINUX
+#include <selinux/selinux.h>
+#else
+int is_selinux_enabled(void);
+void freecon(char *context);
+int getpidcon(pid_t pid, char **context);
+int getfilecon(const char *path, char **context);
+int security_get_initial_context(const char *name,  char **context);
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index ddedd37f..aa7bbd2e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -13,6 +13,10 @@ UTILOBJ += bpf_libbpf.o
 endif
 endif
 
+ifneq ($(HAVE_SELINUX),y)
+UTILOBJ += selinux.o
+endif
+
 NLOBJ=libgenl.o libnetlink.o
 ifeq ($(HAVE_MNL),y)
 NLOBJ += mnl_utils.o
diff --git a/lib/selinux.c b/lib/selinux.c
new file mode 100644
index 00000000..4e6805fc
--- /dev/null
+++ b/lib/selinux.c
@@ -0,0 +1,32 @@
+#include <stdlib.h>
+#include <unistd.h>
+#include "selinux.h"
+
+/* Stubs for SELinux functions */
+int is_selinux_enabled(void)
+{
+	return 0;
+}
+
+void freecon(char *context)
+{
+	free(context);
+}
+
+int getpidcon(pid_t pid, char **context)
+{
+	*context = NULL;
+	return -1;
+}
+
+int getfilecon(const char *path, char **context)
+{
+	*context = NULL;
+	return -1;
+}
+
+int security_get_initial_context(const char *name,  char **context)
+{
+	*context = NULL;
+	return -1;
+}
diff --git a/misc/ss.c b/misc/ss.c
index b3183630..2ef19039 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -33,6 +33,7 @@
 #include "version.h"
 #include "rt_names.h"
 #include "cg_map.h"
+#include "selinux.h"
 
 #include <linux/tcp.h>
 #include <linux/unix_diag.h>
@@ -71,39 +72,6 @@
 #define BUF_CHUNKS_MAX 5	/* Maximum number of allocated buffer chunks */
 #define LEN_ALIGN(x) (((x) + 1) & ~1)
 
-#if HAVE_SELINUX
-#include <selinux/selinux.h>
-#else
-/* Stubs for SELinux functions */
-static int is_selinux_enabled(void)
-{
-	return 0;
-}
-
-static int getpidcon(pid_t pid, char **context)
-{
-	*context = NULL;
-	return -1;
-}
-
-static int getfilecon(const char *path, char **context)
-{
-	*context = NULL;
-	return -1;
-}
-
-static int security_get_initial_context(const char *name,  char **context)
-{
-	*context = NULL;
-	return -1;
-}
-
-static void freecon(char *context)
-{
-	free(context);
-}
-#endif
-
 int preferred_family = AF_UNSPEC;
 static int show_options;
 int show_details;
-- 
2.41.0


