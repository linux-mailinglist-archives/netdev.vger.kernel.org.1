Return-Path: <netdev+bounces-27476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FBF77C1DF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF6280F3D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E5DF5A;
	Mon, 14 Aug 2023 20:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE9DDB5
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD85C433CC;
	Mon, 14 Aug 2023 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692046592;
	bh=gLQ5VU056H869PDuHq4uWCqUQzWL0qabrPkbUTmmMDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKV2+xnIVpPGnmjG9/4EWGNrTIPDPTaRgxb/fWcW/zhUXinbmpK0mjjCduUb2AZLp
	 hbOXgw590/aZFvP9UuFJjtshpTYOkIjPbVzVxKY82lSJ9y/Goao+G+uONlsj5H0oYT
	 S1j8pCPeBk3gy3pZLY3vLvYUWFaG/QnYM5nlHaefX1YeGF4eio8F7GK9jeU2EbSIfK
	 t6srU/P4FJbW49wQiqhgHbDk3c6jOYGAPw+1tP9k6RJCMhuVdTRrZYfBD5sfoAOOog
	 k83dFAeV92gbqJucZSbpZrWhqwgZew97J+oG865toR1TnoAVUTZo9A8qHrOKkUjCXS
	 XEuhrYbkyPeyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com
Subject: [PATCH net-next 2/3] netlink: specs: add ovs_vport new command
Date: Mon, 14 Aug 2023 13:56:26 -0700
Message-ID: <20230814205627.2914583-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814205627.2914583-1-kuba@kernel.org>
References: <20230814205627.2914583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NEW to the spec, it was useful testing the fix for OvS
input validation.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 Documentation/netlink/specs/ovs_vport.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index 17336455bec1..ef298b001445 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -81,6 +81,10 @@ uapi-header: linux/openvswitch.h
     name-prefix: ovs-vport-attr-
     enum-name: ovs-vport-attr
     attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
       -
         name: port-no
         type: u32
@@ -120,6 +124,20 @@ uapi-header: linux/openvswitch.h
 operations:
   name-prefix: ovs-vport-cmd-
   list:
+    -
+      name: new
+      doc: Create a new OVS vport
+      attribute-set: vport
+      fixed-header: ovs-header
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - upcall-pid
+            - dp-ifindex
+            - ifindex
+            - options
     -
       name: get
       doc: Get / dump OVS vport configuration and state
-- 
2.41.0


