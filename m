Return-Path: <netdev+bounces-57124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387F8122D2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29E01F21A19
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B077B47;
	Wed, 13 Dec 2023 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myb/9fRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E677B42
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADC0C433CC;
	Wed, 13 Dec 2023 23:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510139;
	bh=tfTPS9f9KB5Y44fWE4ssGBkaJxzzO/CyKnWmpPQxmLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myb/9fRuHMJ4DTKAIChLXNlOdZyYRHMpPygfBse5EM9CrRNhk1APuanbIczaXNXzd
	 NC/iXfh2OcOGd/VVXDNJHg3irBIkyw8LyCfpG29EGTLsECXMXdG/Q47iu3ETE7oJPX
	 TQ0/m2/r0SEJh2FPr3s6H4Y+WuoEz5Z1nH0ty/SW8lZ6Dj/FV+EFYA1efwEIcUmHap
	 r5IxyK5MSYq5gjY8epG/DBJXGeaR+8tFUwj8cZwZzYRPyqwY7gc9qyE+hux5KmCZLs
	 VqN8F7GgIc1go3SWTCBKVsqRwiE2Twxs1/rJ2ZE8PIBChD9A7HXruqCtw4mHa3SbQJ
	 Uh72zV0770K7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] netlink: specs: ovs: correct enum names in specs
Date: Wed, 13 Dec 2023 15:28:21 -0800
Message-ID: <20231213232822.2950853-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213232822.2950853-1-kuba@kernel.org>
References: <20231213232822.2950853-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the enum-names of OVS with what's actually in the uAPI.
Either correct the names, or mark the enum as empty because
the values are in fact #defines.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ovs_datapath.yaml | 1 +
 Documentation/netlink/specs/ovs_flow.yaml     | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index 067c54a52d7a..edc8c95ca6f5 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -20,6 +20,7 @@ uapi-header: linux/openvswitch.h
     name: user-features
     type: flags
     name-prefix: ovs-dp-f-
+    enum-name:
     entries:
       -
         name: unaligned
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 29315f3538fd..4fdfc6b5cae9 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -124,6 +124,7 @@ uapi-header: linux/openvswitch.h
   -
     name: ovs-frag-type
     name-prefix: ovs-frag-type-
+    enum-name: ovs-frag-type
     type: enum
     entries:
       -
@@ -269,6 +270,7 @@ uapi-header: linux/openvswitch.h
   -
     name: ovs-ufid-flags
     name-prefix: ovs-ufid-f-
+    enum-name:
     type: flags
     entries:
       - omit-key
@@ -288,6 +290,7 @@ uapi-header: linux/openvswitch.h
         doc: Basis used for computing hash.
   -
     name: ovs-hash-alg
+    enum-name: ovs-hash-alg
     type: enum
     doc: |
       Data path hash algorithm for computing Datapath hash. The algorithm type only specifies
@@ -339,6 +342,7 @@ uapi-header: linux/openvswitch.h
           MPLS tunnel attributes.
   -
     name: ct-state-flags
+    enum-name:
     type: flags
     name-prefix: ovs-cs-f-
     entries:
-- 
2.43.0


