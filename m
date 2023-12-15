Return-Path: <netdev+bounces-57710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7C813F84
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32379283F6A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326887E4;
	Fri, 15 Dec 2023 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhz4KChy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15315EC0;
	Fri, 15 Dec 2023 01:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631EAC433C7;
	Fri, 15 Dec 2023 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605459;
	bh=UuZFxFlwbmpPRrY5GjCKO15m/OziS7jzWA1yhdKyjpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mhz4KChyjqOwCF0PuvM4eeXrQ0SD83vRKyzMbvKYpzi3LIB6qG3m23P9ph+vB9125
	 YLFR7otIdKJmoTPezyRxPMnucwGKNgOMrUqLKxzdBQxmykBjXCLRo9ydJJjgHb6cTC
	 j8vVtwFVqTf1q+HrCEPw7P4Al2qAGL1Ia1aT4UOW0E/qyQ37BUv0cQAHuX/xUIe+Yj
	 uV2t8PlDo3nIM8ERMO6aZilfG5ZDgguF786aYpeWjj0KMZvjwJ0zkkvDKP0dPo2RcR
	 bYjUuuA+mnOQG08cUXFuXSzpvhY5WLXTd172tP5Ydx24sWMimx1823nlWpYggTC8ZO
	 UA9r1LY3V/rSA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	matttbe@kernel.org,
	dcaratti@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH net-next v2 3/3] netlink: specs: mptcp: rename the MPTCP path management spec
Date: Thu, 14 Dec 2023 17:57:35 -0800
Message-ID: <20231215015735.3419974-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215015735.3419974-1-kuba@kernel.org>
References: <20231215015735.3419974-1-kuba@kernel.org>
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

Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix MAINTAINERS (build bot)
 - remove the (?) in the title

CC: matttbe@kernel.org
CC: dcaratti@redhat.com
CC: mptcp@lists.linux.dev
---
 Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} | 0
 MAINTAINERS                                               | 2 +-
 include/uapi/linux/mptcp_pm.h                             | 2 +-
 net/mptcp/mptcp_pm_gen.c                                  | 2 +-
 net/mptcp/mptcp_pm_gen.h                                  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/netlink/specs/{mptcp.yaml => mptcp_pm.yaml} (100%)

diff --git a/Documentation/netlink/specs/mptcp.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
similarity index 100%
rename from Documentation/netlink/specs/mptcp.yaml
rename to Documentation/netlink/specs/mptcp_pm.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c09e713284d..b2d8fcf067fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15085,7 +15085,7 @@ W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
 T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
-F:	Documentation/netlink/specs/mptcp.yaml
+F:	Documentation/netlink/specs/mptcp_pm.yaml
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
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


