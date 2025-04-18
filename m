Return-Path: <netdev+bounces-184053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7DA92FDD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE06D3C0001
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB5268C62;
	Fri, 18 Apr 2025 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCo0QRuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9859268C5C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942642; cv=none; b=rv5aRz0ZVYUmKX7GoUTC812qymo17ZTaBhS2ZsChIJa/YE9BWC+124zKd245Vbub3NTy1zuJsWTCDITaO1WB5E5JTmW73Ha5yoZz0SnQMQ0qk3QEFV4OAaeHO8Pvuhw2vrnmYOvZQTKnYJ6lTVJapjHrZdM5CkCt2QwZ/fhHsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942642; c=relaxed/simple;
	bh=VMApbaSTIw4N8yMfUosHM16xMSRLhU4M0M0dXvKm8vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZMGM91jAaMUv5wIFtEmJ6XZOAt57tN8BzgHfBUQUspOyHOtS3RXPhu8qm1Am4AYKxJNtHb9p6H92GB8KiDc0+sREp6wQiEa5IJPGShhI8Rj4s/mWaqGhZZljM3334BvY13qT9G4ewn4nL+t/nFgRxqgPv8re1CrIEjsHSeXstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCo0QRuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62216C4CEE4;
	Fri, 18 Apr 2025 02:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942642;
	bh=VMApbaSTIw4N8yMfUosHM16xMSRLhU4M0M0dXvKm8vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCo0QRuwuZ47mLvAIRdry1EFg70FClZ0bI0l3Q4753Niwg8S+JhG9bElVQWLojRMd
	 NvkFBGJffBwYV/ajhblAa7ttz1dW46sSAMhvTR6Az6qX+rTVJXQ+QZoWg/XQ2IyFKW
	 1CgtX5PaLlbAB4Thq2cFoRxLpeNU1UcWVEIFoiNYeDJ1LlyvW7CQUJz5UPaR5sx15N
	 QEm5k75Oelzau6WuXFZCtyFdnm4C+mGVZJLGweK3UGt6C/L1ux1j/uUp8XJP1CgfM/
	 c93mjQyNKltyQ065IGYThHh7doMPNZ05uRQhTBJKhSZnSYA/n9HGNrTRoKmWrGvPvJ
	 V/FU5/kJBaihA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 12/12] netlink: specs: rt-rule: add C naming info
Date: Thu, 17 Apr 2025 19:17:06 -0700
Message-ID: <20250418021706.1967583-13-kuba@kernel.org>
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
 Documentation/netlink/specs/rt-rule.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index f585654a4d41..003707ca4a3e 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -2,6 +2,7 @@
 
 name: rt-rule
 protocol: netlink-raw
+uapi-header: linux/fib_rules.h
 protonum: 0
 
 doc:
@@ -56,6 +57,7 @@ protonum: 0
   -
     name: fr-act
     type: enum
+    enum-name:
     entries:
       - unspec
       - to-tbl
@@ -90,6 +92,7 @@ protonum: 0
 attribute-sets:
   -
     name: fib-rule-attrs
+    name-prefix: fra-
     attributes:
       -
         name: dst
@@ -198,6 +201,7 @@ protonum: 0
 operations:
   enum-model: directional
   fixed-header: fib-rule-hdr
+  name-prefix: rtm-
   list:
     -
       name: newrule
-- 
2.49.0


