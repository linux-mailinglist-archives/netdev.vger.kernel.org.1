Return-Path: <netdev+bounces-180992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BCA835EA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737E43BEAC8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BEC1D5166;
	Thu, 10 Apr 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbMxN2gk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7091CBEB9
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249634; cv=none; b=WW/VIPBJtZ62PWQYLKTy0f7C3GHB2fTcerwZdkdAqD/N81ISI2Jyg5/HsAT6kSIi6LOIKeGzPxJwfVbStey08ne341OIFfa41cMcT90nz56hd30FftxwUgzkSwWJG3Q1crhTyRGArzrFz0BfKrJeDg5MQHPt0wGrYRw4k5IKLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249634; c=relaxed/simple;
	bh=k2+h2FiGJevGsxX9slUplG7xTRQcVTv0EDEzMzhjK/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/HLU/WTu/Ja5rZq9I0AHqCEgS4rnXDV4afC5MSjPTSxreF3aN68f4paBpfFGhqoYWNNUXVibPUuo1l7zpD6yIbEP+zUrpDCOiV3qqBwEViNFPFnkYT66YSidZ/XdjgaDZq/KRE6V60wmM3Ib4qNxuCubtKeyncNpBTc1h/9Klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbMxN2gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230D8C4CEE2;
	Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249633;
	bh=k2+h2FiGJevGsxX9slUplG7xTRQcVTv0EDEzMzhjK/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbMxN2gkVO3Ez+ehYYEwo7WgL9zN3EcK/x8aDrHyfnlAbzk9mGuALOQ16Fg/eZaQP
	 1TgVyh9MyOQ6zHm6fQw6rfaWNk9XvuR2TdfsBBa6djVY1K2JdFfw+kh1qW4mbFCy/W
	 Jn7ibYEciEDQlSl5o3APc9LNo9BmOx/xvpBUGwQkkFr4D/0FsAoCXwCNbJs0pwdY7K
	 GjitzgoKOscwm4eDmFIfG5ozdjKBXDoAtSmFnXrjqjX/Z/CBir6hi7YC7RPmjioBGB
	 wc0nLXPpL5UMMy6pWma69ZQd3JySV8Le4Mm3v+236O/25C18fMx0ch2USn8REhcUAk
	 R16HSlHnG7tLg==
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
Subject: [PATCH net-next v2 05/13] netlink: specs: rt-addr: add C naming info
Date: Wed,  9 Apr 2025 18:46:50 -0700
Message-ID: <20250410014658.782120-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add properties needed for C codegen to match names with uAPI headers.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-addr.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 0488ce87506c..4f86aa1075da 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -2,6 +2,7 @@
 
 name: rt-addr
 protocol: netlink-raw
+uapi-header: linux/rtnetlink.h
 protonum: 0
 
 doc:
@@ -49,6 +50,8 @@ protonum: 0
   -
     name: ifa-flags
     type: flags
+    name-prefix: ifa-f-
+    enum-name:
     entries:
       -
         name: secondary
@@ -124,6 +127,7 @@ protonum: 0
 operations:
   fixed-header: ifaddrmsg
   enum-model: directional
+  name-prefix: rtm-
   list:
     -
       name: newaddr
-- 
2.49.0


