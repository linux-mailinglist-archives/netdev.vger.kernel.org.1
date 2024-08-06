Return-Path: <netdev+bounces-116082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D213B94907B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F19AB25B99
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B51D1F70;
	Tue,  6 Aug 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBmV2dGD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8161D1F50;
	Tue,  6 Aug 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949992; cv=none; b=Ox5sYwkciZZY5qZQEDpuE+oYqG82WZ6JPnYsyClNauaHk2Y9zI4Hfs8oeD7kDCc2yqpOD4FW9Vq9xzufpaTD4XIXIU+EBckUs8MU0hsW0Z+aoMkgN9pc3gy4ZSc0gKe/I24WDi3+As7YY4rL9f+eL9EkcH1Va9JFeHaTKutD+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949992; c=relaxed/simple;
	bh=lfliiD9dtcEG344A0Se/HN7jBzJiQBOpagRt04D+Nvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWjvDNzUhcMGpJBdKF2EhtVXrDDlz8yWHy+OGrJ5oCsWhPfTuDslQEZM3FFvuoOwNnrXFR41ezy1GY35bueeMiHTsLh7mvnkQq1TlvKKdtewYS+B+RUM97eW9C0BbOV2opfehZQxKYLAY0BDkYKFKp7cu72rZBhMuLA1ePs88Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBmV2dGD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722949990; x=1754485990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfliiD9dtcEG344A0Se/HN7jBzJiQBOpagRt04D+Nvw=;
  b=fBmV2dGD6jsKBGAcqNc7NMUOS/mIGjcINWm71jjF/cH0mtXh0eShzedw
   pH7ERVCJelxbCOyKJ504/ezxt1Qk0jfB/sqzuyLTr6d6mUCkoFGwbS7Wj
   FZEA8Q6Pt/Bl6MNFOxiwngF2ypxAqaPb7eCbvaQHv2UJB/cMoDQz8fL5S
   /Bw/yfBnrMGF8sOTuxb7Ofqcr9V4Pg6tw0mv+KU8GvqtON3MiigViljvN
   sl5V9r7dkj4oFPL3FEvVPvgrCpUZgwHgMlBi9dNrwb8pTeapRmHq/Sd+q
   2JZvYMoLZKcBQm9UTIpEDr/DsHraexxlnm3VZK0AptNFITi++h9VCw174
   Q==;
X-CSE-ConnectionGUID: zrI0g1t/QfWsM0NyHcYg4g==
X-CSE-MsgGUID: qEGrhkAJRr2A1mUbBlAmVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20842075"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20842075"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:13:10 -0700
X-CSE-ConnectionGUID: 16IgqtC6SOargJEsfZV4Eg==
X-CSE-MsgGUID: f3BC7GwTS6q0dm8SundO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56475796"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 06:13:07 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>
Subject: [PATCH iwl-next 1/9] unroll: add generic loop unroll helpers
Date: Tue,  6 Aug 2024 15:12:32 +0200
Message-ID: <20240806131240.800259-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131240.800259-1-aleksander.lobakin@intel.com>
References: <20240806131240.800259-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases when we need to explicitly unroll loops. For example,
cache operations, filling DMA descriptors on very high speeds etc.
Add compiler-specific attribute macros to give the compiler a hint
that we'd like to unroll a loop.
Example usage:

 #define UNROLL_BATCH 8

	unrolled_count(UNROLL_BATCH)
	for (u32 i = 0; i < UNROLL_BATCH; i++)
		op(priv, i);

Note that sometimes the compilers won't unroll loops if they think this
would have worse optimization and perf than without unrolling, and that
unroll attributes are available only starting GCC 8. For older compiler
versions, no hints/attributes will be applied.
For better unrolling/parallelization, don't have any variables that
interfere between iterations except for the iterator itself.

Co-developed-by: Jose E. Marchesi <jose.marchesi@oracle.com> # pragmas
Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/unroll.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/linux/unroll.h

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
new file mode 100644
index 000000000000..e305d155faa6
--- /dev/null
+++ b/include/linux/unroll.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _LINUX_UNROLL_H
+#define _LINUX_UNROLL_H
+
+#ifdef CONFIG_CC_IS_CLANG
+#define __pick_unrolled(x, y)	_Pragma(#x)
+#elif CONFIG_GCC_VERSION >= 80000
+#define __pick_unrolled(x, y)	_Pragma(#y)
+#else
+#define __pick_unrolled(x, y)	/* not supported */
+#endif
+
+/**
+ * unrolled - loop attributes to ask the compiler to unroll it
+ *
+ * Usage:
+ *
+ * #define BATCH 4
+ *	unrolled_count(BATCH)
+ *	for (u32 i = 0; i < BATCH; i++)
+ *		// loop body without cross-iteration dependencies
+ *
+ * This is only a hint and the compiler is free to disable unrolling if it
+ * thinks the count is suboptimal and may hurt performance and/or hugely
+ * increase object code size.
+ * Not having any cross-iteration dependencies (i.e. when iter x + 1 depends
+ * on what iter x will do with variables) is not a strict requirement, but
+ * provides best performance and object code size.
+ * Available only on Clang and GCC 8.x onwards.
+ */
+
+/* Ask the compiler to pick an optimal unroll count, Clang only */
+#define unrolled							    \
+	__pick_unrolled(clang loop unroll(enable), /* nothing */)
+
+/* Unroll each @n iterations of a loop */
+#define unrolled_count(n)						    \
+	__pick_unrolled(clang loop unroll_count(n), GCC unroll n)
+
+/* Unroll the whole loop */
+#define unrolled_full							    \
+	__pick_unrolled(clang loop unroll(full), GCC unroll 65534)
+
+/* Never unroll a loop */
+#define unrolled_none							    \
+	__pick_unrolled(clang loop unroll(disable), GCC unroll 1)
+
+#endif /* _LINUX_UNROLL_H */
-- 
2.45.2


