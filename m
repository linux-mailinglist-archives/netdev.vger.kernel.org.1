Return-Path: <netdev+bounces-191954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4FABE07D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CA01885C44
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C29258CDD;
	Tue, 20 May 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6JEqTam"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331B2522AC
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757964; cv=none; b=Gl6Xb8ttIA05KrQCwM5YAHxZNM5jnpLk/oIDsr3wQTUL5IvuLwko6eg2Fic+5xwQWgtnOG7Q1OHhW93NUpReWQ2aSZ95zTXtjbYdiNtqNUKXhlfZul9MoFR1cp1rO19hF8BFmTdFWLqHcnzci8NAFNG1ppcZpnpUfL8aDtvC32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757964; c=relaxed/simple;
	bh=gHB+EBx132QnV15nyPcMh8RHuNJVqYtf14Cu4w7tXaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru9PprXwMqlRnx2kHgCBfD9tfaNvYbs4w+ybaLiVG7FCgg19Lm2OsE2xvIIeAkYLh/YeFoN7MEeanznUV7lOGDGX+mA20Nbfs0633dJzMMev/gzuR/Hh6qwiWlEL0MG276/eTmkagaRYLABbQHTX06hkN8sEpUKTPjJCeilvQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6JEqTam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F596C4CEEA;
	Tue, 20 May 2025 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757963;
	bh=gHB+EBx132QnV15nyPcMh8RHuNJVqYtf14Cu4w7tXaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6JEqTamVfPyhjSqFWivwxhK8HgRaRq7Wci1V0uTCG6L29yhuQUNALD/6ilWOPFsA
	 WwGVDUQBbASilfrvtDsZNgDOohUmMRwOYjnKprf4GAbT07ZqPcdsDCXal2aL8PpP8p
	 JUQOF2zGpP+v2TVEUTVd/HEwCrAvlg+1KWGWdsWeSxY98pvGAaogeAJQQscXbU9JGL
	 Pr+i58tIREvHUD/Es1Q32T9MxGnIugnGgVda46DSzne5xqyYGmUFDjbOT9PvEIpu+8
	 mOvgCKYCmqfrgNimJeza20s9OvVKOGXSB4rmhWF0HldbIk8waeOWfKJI3QtjxpS3t2
	 Isr8o9mOA16MA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/12] tools: ynl-gen: add makefile deps for neigh
Date: Tue, 20 May 2025 09:19:05 -0700
Message-ID: <20250520161916.413298-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kory is reporting build issues after recent additions to YNL
if the system headers are old.

Link: https://lore.kernel.org/20250519164949.597d6e92@kmaincent-XPS-13-7390
Reported-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: 0939a418b3b0 ("tools: ynl: submsg: reverse parse / error reporting")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - new patch
---
 tools/net/ynl/Makefile.deps    | 3 ++-
 include/uapi/linux/neighbour.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index e5a5cb1b2cff..8c378356fc87 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -35,7 +35,8 @@ CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
 CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
-CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 5e67a7eaf4a7..b851c36ad25d 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __LINUX_NEIGHBOUR_H
-#define __LINUX_NEIGHBOUR_H
+#ifndef _UAPI__LINUX_NEIGHBOUR_H
+#define _UAPI__LINUX_NEIGHBOUR_H
 
 #include <linux/types.h>
 #include <linux/netlink.h>
-- 
2.49.0


