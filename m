Return-Path: <netdev+bounces-184050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE9A92FDA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B0A3AE90A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD22686A9;
	Fri, 18 Apr 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DexSVItc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B226869F
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942641; cv=none; b=mCJYHMTzzV9ZJZbbedsWvwt2QXRyOzUf4XmvMGSVtuahcMeT5K5RiGefRDhyubswq8u/5+cRpma/DDx8z35g7FDhqWPJldlzUEdMXCovZpEgNwqQj9NM2lkFuIrT0xU9EF3DwCT0FGqGRbA5Y/Pg7TdB7LewC8LZtTv0+GFWTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942641; c=relaxed/simple;
	bh=OnRJ7aV6HvypbSTAmOW1ZM0vH47EZU11yXNQMrjqZ+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5Qf9fC3XROStO9lfmLIhEw0qqH56favg77eShXSjMR2Md2v5ep4L6NMY+WAUWWz4a58NSKX54Qz4kMxlOrfjZOGU/VS1bhTgyDUf7OIilYsUKkMjNQEknwAEq8eZqGUK3tQvGEssDmra+s0nR9j70kgqTa1Eh3vVEcl0NoPkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DexSVItc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824FC4CEE4;
	Fri, 18 Apr 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942641;
	bh=OnRJ7aV6HvypbSTAmOW1ZM0vH47EZU11yXNQMrjqZ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DexSVItcxE9bg2ulmNWBKaTnwJPlx5PH/eE5Mcjqp7V5ArS5/nHD02fRBsnRniiMu
	 kv2zpXdpSabKeNB38xp1oZFYK7XhhHYsfy6bMIy6MPDvoaPLlPmlAr2p40VAOFhuyt
	 7agfhs8YeNBiDYcSpRU21S5ot/BiNu+t7vvDKvmDmsga1RYjcPMy2TyuUbae5H9pDI
	 yxoPmQ4CSPU+Tz9ZLDIJ+7N2u3AE3IpOcQ9NPHREc7cuAFhVRsPMvKdcaRYtwYqDJs
	 m2QSyIJWyQS46H86Kh/4rRBYYdLPbZ30pE81yizc6QaDgDDL0S6bfYvSSpACjS/utv
	 roOvfCR9UVxKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/12] netlink: specs: rt-neigh: add C naming info
Date: Thu, 17 Apr 2025 19:17:03 -0700
Message-ID: <20250418021706.1967583-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties needed for C codegen to match names with uAPI headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-neigh.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index a843caa72259..9b87efaafd15 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -2,6 +2,7 @@
 
 name: rt-neigh
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -48,6 +49,7 @@ protonum: 0
   -
     name: nud-state
     type: flags
+    enum-name:
     entries:
       - incomplete
       - reachable
@@ -60,6 +62,7 @@ protonum: 0
   -
     name: ntf-flags
     type: flags
+    enum-name:
     entries:
       - use
       - self
@@ -72,12 +75,14 @@ protonum: 0
   -
     name: ntf-ext-flags
     type: flags
+    enum-name:
     entries:
       - managed
       - locked
   -
     name: rtm-type
     type: enum
+    enum-name:
     entries:
       - unspec
       - unicast
@@ -179,6 +184,7 @@ protonum: 0
 attribute-sets:
   -
     name: neighbour-attrs
+    name-prefix: nda-
     attributes:
       -
         name: unspec
@@ -241,6 +247,7 @@ protonum: 0
         type: u8
   -
     name: ndt-attrs
+    name-prefix: ndta-
     attributes:
       -
         name: name
@@ -274,6 +281,7 @@ protonum: 0
         type: pad
   -
     name: ndtpa-attrs
+    name-prefix: ndtpa-
     attributes:
       -
         name: ifindex
@@ -335,6 +343,7 @@ protonum: 0
 
 operations:
   enum-model: directional
+  name-prefix: rtm-
   list:
     -
       name: newneigh
-- 
2.49.0


