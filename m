Return-Path: <netdev+bounces-57125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3D8122D3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA90282660
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665C77B4E;
	Wed, 13 Dec 2023 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyTHFcVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D877B48;
	Wed, 13 Dec 2023 23:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F83C433C8;
	Wed, 13 Dec 2023 23:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702510140;
	bh=bQFS5XIbCiYEO8ACxFU8M1epjSvbP3micQbdreXRNEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyTHFcVdvnwyPTAz8hNe757eUfiHu+4P6+ZOLZQ2Mx1KupCeTwW+Xv88d6n4zVhIm
	 GviGtf6/1XVrQqCU717NWQKUjUkdiM2Ob0HJnXZpK3G2vkgrILJZh3PfUnC948YFR9
	 viY5iMTvX1IDebcTDQd7mIL/QMEjB3FR/29Whq4d1/yNkuDht2ApcR5ZizuMILmXCZ
	 L9drv0zZfOd+1/IQDrS00xSGMe29trGakJFSd/nU8Kos+mMGTfZt2Bu1rWJoSRJSwI
	 H9uEzob7SCOvd1vS8G/HskwAYGVvB+603fQFV+WRxQq08BXChWIAMpD4QRUWpkjGek
	 NUot+Hle1k+Rg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	matttbe@kernel.org,
	martineau@kernel.org,
	dcaratti@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 3/3] netlink: specs: mptcp: rename the MPTCP path management(?) spec
Date: Wed, 13 Dec 2023 15:28:22 -0800
Message-ID: <20231213232822.2950853-4-kuba@kernel.org>
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

We assume in handful of places that the name of the spec is
the same as the name of the family. We could fix that but
it seems like a fair assumption to make. Rename the MPTCP
spec instead.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: matttbe@kernel.org
CC: martineau@kernel.org
CC: dcaratti@redhat.com
CC: mptcp@lists.linux.dev
---
 Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} | 0
 include/uapi/linux/mptcp_pm.h                             | 2 +-
 net/mptcp/mptcp_pm_gen.c                                  | 2 +-
 net/mptcp/mptcp_pm_gen.h                                  | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
similarity index 100%
rename from Documentation/netlink/specs/mptcp.yaml
rename to Documentation/netlink/specs/mptcp_pm.yaml
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index b5d11aece408..50589e5dd6a3 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/mptcp.yaml */
+/*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN uapi header */
 
 #ifndef _UAPI_LINUX_MPTCP_PM_H
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index a2325e70ddab..670da7822e6c 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 /* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/mptcp.yaml */
+/*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN kernel source */
 
 #include <net/netlink.h>
diff --git a/net/mptcp/mptcp_pm_gen.h b/net/mptcp/mptcp_pm_gen.h
index 10579d184587..ac9fc7225b6a 100644
--- a/net/mptcp/mptcp_pm_gen.h
+++ b/net/mptcp/mptcp_pm_gen.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/mptcp.yaml */
+/*	Documentation/netlink/specs/mptcp_pm.yaml */
 /* YNL-GEN kernel header */
 
 #ifndef _LINUX_MPTCP_PM_GEN_H
-- 
2.43.0


