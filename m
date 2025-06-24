Return-Path: <netdev+bounces-200839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC067AE7150
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24D73BF1A5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D712586CA;
	Tue, 24 Jun 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6PRdiWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF3257AFB
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799408; cv=none; b=V9lJHUutqlbRdCtdBvrh25aq0HAGCsYIHonxethnrKwYZNgD3P2JdXfKtv4OHUEgyvC5SriLjZz0Y1CNNsrlmeDoRheqOUmsmCmTR1PJwfNDaQGxBVoF2yLdQ2obh0y6XHrk6FVCkl9rmwY/ejlTrExCppfTnb2ZxlIqwzJBK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799408; c=relaxed/simple;
	bh=wAvxHFOuCj0gNM4Tkx6/JrhaPnwAHb3BfcY5eqivnnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBXhOD6QOcIqVIRepLY1QQjf5DQ0elC0CdxZbX8pLzz8YXX7/ni61ACwFQw4HGQhANu/Qlfr64zscmxl0LKhgnWj2gqv4GNSVJjScJejd0l8FJ6Cw1LO+wfc41A+X7X6PR6TutpPmyEq5lKswPzSXCp0IwBfE48VVTOiNm5ygm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6PRdiWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36429C4CEF4;
	Tue, 24 Jun 2025 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799407;
	bh=wAvxHFOuCj0gNM4Tkx6/JrhaPnwAHb3BfcY5eqivnnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6PRdiWju/CQ2tXcCQiN3vXFVz7FGxcaJkqAJX8S8WdBNuT0WPpi0z6nqTXZBhABx
	 dgCtbFb4d777P0LZ/Vz3ZRk4GQVrf0/ery7CN78FxlHVxK54XP/NDp3wyqy0p7+Dli
	 wkTqn/a22aVeAcxVx41s05c0vbydv6FONd94U0+XXumuSHRE7eAV/1MvyzPzSS/Q5F
	 52PDZgslshdEgN6nsr2a/iPTstzOb004bHVGv/XLSTlz+/8okuGqE1v2WwO/V+U9pB
	 Y3m1hYtZqdNPD3+pUYnqAHNxTV3e8Rlb7OnxJcxm/i+3/IC02YhHgnUq8yl/6agQp9
	 N4wstvoGgRSOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sdf@fomichev.me
Subject: [PATCH net 02/10] netlink: specs: fou: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:09:54 -0700
Message-ID: <20250624211002.3475021-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: 4eb77b4ecd3c ("netlink: add a proto specification for FOU")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
---
 Documentation/netlink/specs/fou.yaml | 36 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 0af5ab842c04..b02ab19817d3 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -15,7 +15,7 @@ kernel-policy: global
 definitions:
   -
     type: enum
-    name: encap_type
+    name: encap-type
     name-prefix: fou-encap-
     enum-name:
     entries: [ unspec, direct, gue ]
@@ -43,26 +43,26 @@ kernel-policy: global
         name: type
         type: u8
       -
-        name: remcsum_nopartial
+        name: remcsum-nopartial
         type: flag
       -
-        name: local_v4
+        name: local-v4
         type: u32
       -
-        name: local_v6
+        name: local-v6
         type: binary
         checks:
           min-len: 16
       -
-        name: peer_v4
+        name: peer-v4
         type: u32
       -
-        name: peer_v6
+        name: peer-v6
         type: binary
         checks:
           min-len: 16
       -
-        name: peer_port
+        name: peer-port
         type: u16
         byte-order: big-endian
       -
@@ -90,12 +90,12 @@ kernel-policy: global
             - port
             - ipproto
             - type
-            - remcsum_nopartial
-            - local_v4
-            - peer_v4
-            - local_v6
-            - peer_v6
-            - peer_port
+            - remcsum-nopartial
+            - local-v4
+            - peer-v4
+            - local-v6
+            - peer-v6
+            - peer-port
             - ifindex
 
     -
@@ -112,11 +112,11 @@ kernel-policy: global
             - af
             - ifindex
             - port
-            - peer_port
-            - local_v4
-            - peer_v4
-            - local_v6
-            - peer_v6
+            - peer-port
+            - local-v4
+            - peer-v4
+            - local-v6
+            - peer-v6
 
     -
       name: get
-- 
2.49.0


