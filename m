Return-Path: <netdev+bounces-44678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110307D92EF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7528235C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB521172C;
	Fri, 27 Oct 2023 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEumZx2w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BD14A9C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:45:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B107E1FDB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698396299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xlOjhzT38JEX2MXymGe8DdL0zIY2s21S/8BbYITwZw0=;
	b=YEumZx2wWbpY54YkDCVkgdOT6NmYCQazwysShJYUj68P5bkWCZRJPOdmTw7wefqJ6DJasE
	XJrkiv//e+nW+Ov5iuU7QRf3gWJw+GqAZcbX0VIwDcowTMLWfGfU/TS6N5YMClcBnNnAus
	wrO09zDM6rKh4nHfZy/HP5KYu15/k6k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-E9Za8ZJ_PmqdppCYp7OTXQ-1; Fri,
 27 Oct 2023 04:44:52 -0400
X-MC-Unique: E9Za8ZJ_PmqdppCYp7OTXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DF101C0896A;
	Fri, 27 Oct 2023 08:44:52 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B920C1596D;
	Fri, 27 Oct 2023 08:44:51 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: netdev@vger.kernel.org
Cc: matttbe@kernel.org,
	kuba@kernel.org
Subject: [PATCH net-next] doc/netlink: Update schema to include cmd-cnt-name and cmd-max-name
Date: Fri, 27 Oct 2023 10:44:48 +0200
Message-ID: <0bedbe03a8faf1654475830b88e92ece9c763068.1698396238.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

allow specifying cmd-cnt-name and cmd-max-name in netlink specs, in
accordance with Documentation/userspace-api/netlink/c-code-gen.rst.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 Documentation/netlink/genetlink-c.yaml      | 6 ++++++
 Documentation/netlink/genetlink-legacy.yaml | 6 ++++++
 Documentation/netlink/netlink-raw.yaml      | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 812113280148..80067cd1212d 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -46,6 +46,12 @@ properties:
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
index aa32649e20e9..a6b371bc6c27 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -46,6 +46,12 @@ properties:
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
index 96913857ac71..fd79dbe941cf 100644
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
-- 
2.41.0


