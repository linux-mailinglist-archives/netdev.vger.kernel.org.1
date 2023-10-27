Return-Path: <netdev+bounces-44773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 266237D9AC7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B725DB214F5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE3336AE0;
	Fri, 27 Oct 2023 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMEFybuq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459F358AD
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 14:05:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C9D48
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698415502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ClzXOEttjWErCkxGgYMmfDZQp0IjON50h0Ig7jl7UCY=;
	b=gMEFybuqYDgl54AKQuvpTCHsaYKw5MtxjpuG87ZDMzUcz4w8nAqQArJSmATgmxbuBM5eQk
	XzIpSsKlqAPHqmtpMC+wB59s4VcRfLhFe5GC6u8CSgxoS5aLM1pAmhQaavuh4peiG5ZmTE
	jAhKpi6HN6w3TQgvBjAvIiMp4SFDABw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-h7OsnAZ7Os26bOETSEUl_A-1; Fri,
 27 Oct 2023 10:04:59 -0400
X-MC-Unique: h7OsnAZ7Os26bOETSEUl_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09FA91C0BA48;
	Fri, 27 Oct 2023 14:04:59 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 339C52166B26;
	Fri, 27 Oct 2023 14:04:58 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	matttbe@kernel.org
Subject: [PATCH net-next v2] doc/netlink: Update schema to support cmd-cnt-name and cmd-max-name
Date: Fri, 27 Oct 2023 16:04:54 +0200
Message-ID: <12d4ed0116d8883cf4b533b856f3125a34e56749.1698415310.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

allow specifying cmd-cnt-name and cmd-max-name in netlink specs, in
accordance with Documentation/userspace-api/netlink/c-code-gen.rst.

Use cmd-cnt-name and attr-cnt-name in the mptcp yaml spec and in the
corresponding uAPI headers, to preserve the #defines we had in the past
and avoid adding new ones.

v2:
 - squash modification in mptcp.yaml and MPTCP uAPI headers

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/genetlink-c.yaml      | 6 ++++++
 Documentation/netlink/genetlink-legacy.yaml | 6 ++++++
 Documentation/netlink/netlink-raw.yaml      | 6 ++++++
 Documentation/netlink/specs/mptcp.yaml      | 2 ++
 include/uapi/linux/mptcp.h                  | 4 ----
 include/uapi/linux/mptcp_pm.h               | 8 ++++----
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9d13bbb7ae47..c58f7153fcf8 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -47,6 +47,12 @@ properties:
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
     type: boolean
+  cmd-max-name:
+    description: Name of the define for the last operation in the list.
+    type: string
+  cmd-cnt-name:
+    description: The explicit name for constant holding the count of operations (last operation + 1).
+    type: string
   # End genetlink-c
 
   definitions:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 0daf40402a29..938703088306 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -47,6 +47,12 @@ properties:
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
     type: boolean
+  cmd-max-name:
+    description: Name of the define for the last operation in the list.
+    type: string
+  cmd-cnt-name:
+    description: The explicit name for constant holding the count of operations (last operation + 1).
+    type: string
   # End genetlink-c
   # Start genetlink-legacy
   kernel-policy:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 48db31f1d059..775cce8c548a 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -47,6 +47,12 @@ properties:
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
     type: boolean
+  cmd-max-name:
+    description: Name of the define for the last operation in the list.
+    type: string
+  cmd-cnt-name:
+    description: The explicit name for constant holding the count of operations (last operation + 1).
+    type: string
   # End genetlink-c
   # Start genetlink-legacy
   kernel-policy:
diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp.yaml
index ec5c454a87ea..49f90cfb4698 100644
--- a/Documentation/netlink/specs/mptcp.yaml
+++ b/Documentation/netlink/specs/mptcp.yaml
@@ -8,6 +8,7 @@ c-family-name: mptcp-pm-name
 c-version-name: mptcp-pm-ver
 max-by-define: true
 kernel-policy: per-op
+cmd-cnt-name: --mptcp-pm-cmd-after-last
 
 definitions:
   -
@@ -167,6 +168,7 @@ attribute-sets:
   -
     name: attr
     name-prefix: mptcp-pm-attr-
+    attr-cnt-name: --mptcp-attr-after-last
     attributes:
       -
         name: unspec
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 64ecc8a3f9f2..a6451561f3f8 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -28,10 +28,6 @@
 
 #include <linux/mptcp_pm.h>
 
-/* for backward compatibility */
-#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
-#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX
-
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 0ad598fe940b..b5d11aece408 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -100,9 +100,9 @@ enum {
 	MPTCP_PM_ATTR_LOC_ID,
 	MPTCP_PM_ATTR_ADDR_REMOTE,
 
-	__MPTCP_PM_ATTR_MAX
+	__MPTCP_ATTR_AFTER_LAST
 };
-#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
+#define MPTCP_PM_ATTR_MAX (__MPTCP_ATTR_AFTER_LAST - 1)
 
 enum mptcp_event_attr {
 	MPTCP_ATTR_UNSPEC,
@@ -143,8 +143,8 @@ enum {
 	MPTCP_PM_CMD_SUBFLOW_CREATE,
 	MPTCP_PM_CMD_SUBFLOW_DESTROY,
 
-	__MPTCP_PM_CMD_MAX
+	__MPTCP_PM_CMD_AFTER_LAST
 };
-#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_MAX - 1)
+#define MPTCP_PM_CMD_MAX (__MPTCP_PM_CMD_AFTER_LAST - 1)
 
 #endif /* _UAPI_LINUX_MPTCP_PM_H */
-- 
2.41.0


