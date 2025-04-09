Return-Path: <netdev+bounces-180527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F98A8199A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296208A5BDB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59929D0B;
	Wed,  9 Apr 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxZ2iiMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D027462
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157066; cv=none; b=s8aleK8v3wxnDdowVpppn/Oa5IIu0ZKG9J5ozGcGfr8TVm9HnHf0QnUfGSdj4XWBvLi647xZ/pwYVodX22QCB3vJhzckfylcpmUv83TqIQCSxvDZ8H6fMoRAwJgsaY4FuHVMH97oqaxVVQeSNnfFdfbJUQyc57VWkdwiGjRDMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157066; c=relaxed/simple;
	bh=NhvMjoiHsWia/0AqFNClgkw6WJ80tX9orPBm3eX7BI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efy78tY6we2CnQTspGKsF9N7mbSkcvrc4/AWNuDKprpmLh4wYz2RnqGNOAIBx1+I+r7bF51xpv5fXub/ozB+md1hlqU25mnTDmw+cupDresT5dnxpKVfEFuZmae5LBvnSCw9FAX9UFsz/V4Bl77Wr5flMoWvd/wTErYG9LSQd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxZ2iiMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2580C4CEEC;
	Wed,  9 Apr 2025 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157066;
	bh=NhvMjoiHsWia/0AqFNClgkw6WJ80tX9orPBm3eX7BI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxZ2iiMT9++yh7/I5jT7CnpESkoaLKqXyD8SXobJq4tesVfSfCobc4I7wQoFPdM8/
	 z2wur9+WsH4UzBe25ZiNf0E9KmfRhrsi5mgetCPUoapTKHMmHENo21KLWlhVww5rAP
	 GhstA3xZSf+Nkz8+un9K1gRFdOREAOWHeZ9S+v9xRRxP9Z1T8qr61ukDmd/5bsCFjD
	 78tIzLbWckmk9QVEBFhpQf8h0XmBGjJyGBKHT4JnaBCKVWWTOt59R/HJy8UzPVT8rr
	 Iuv3gv8s8wdq/WWict6IKr2MdQp2mf+DLazR+vScqTQPYS8F3QzOoJd3JCDcASc+4y
	 GcUEDNvygDjWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 06/13] netlink: specs: rt-route: add C naming info
Date: Tue,  8 Apr 2025 17:03:53 -0700
Message-ID: <20250409000400.492371-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
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
 Documentation/netlink/specs/rt-route.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index c7c6f776ab2f..800f3a823d47 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -2,6 +2,7 @@
 
 name: rt-route
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -11,6 +12,7 @@ protonum: 0
   -
     name: rtm-type
     name-prefix: rtn-
+    enum-name:
     type: enum
     entries:
       - unspec
@@ -246,6 +248,7 @@ protonum: 0
 operations:
   enum-model: directional
   fixed-header: rtmsg
+  name-prefix: rtm-
   list:
     -
       name: getroute
-- 
2.49.0


