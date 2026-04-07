Return-Path: <netdev+bounces-276118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAR6AmhA1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC53B26B3
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B1BC30333A8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA7347BBD;
	Tue,  7 Apr 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="aS75Wrge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A6343D9E
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583254; cv=none; b=Z/bqsiTe7hElJHG+HsUNOcN98HgzWjF7vxy7JcIRbitG3yQFZedEPQGERF6eMlJsgtE6y4bmqiQCMu/MjW8ROiOCwtdHfYkczC1TBP0KtURF+MhejSm7AdKFp8KBsCPuHnjg0Y2HxFvMKbAGTf+dA4huD0k2amrvDd07ky9HsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583254; c=relaxed/simple;
	bh=k2OsgyNizxusADUde0S14UIFkxXaowbHk4UidSMtIxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQHtx2+uEmVH80LwhCEXjloTTNWgArRKf9h+eIFxVHH31hzG6K79W1M2Zw74ghmDwtWpnS1t+tOrRzPycbDyDWYZkJlkg15G5J4A0M4Bcq0UOSbrD7DRZQJWRAfrQ8BVigV+7mHvULLoPDTKYdb1YvDxkxa1F/T+6cZMIjVVKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=aS75Wrge; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488971db0fdso41817965e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775583251; x=1776188051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=aS75WrgeXCi797Wg1chcHq5c23rOXJXiJ3snu3TkPHASYqTEt0sY7RuNt43YySjwSL
         +PkoISDPilAxem5KevB7G+weescFIZLqXF5cYpKbvBdNvjdgU+zQvhwV0tkhclmVOImJ
         izLO80FTC0INwQjVfiY/5ZKtmfUH8gg+n9rwYKkDv2JpXJA/7iJSmUtkp4EmsD31o7AQ
         RsOWM46JQVUMQR6V/FiGhK05PuMpofLH3WoojwXMarfFfykRrnMGO41LfDUEqiwrsud7
         xo3jyBuM9sN7s62o1uyNoIAdQWKt+HC7mCS5pQw39e1KOKn6O9h5AA+Jpn348yr1DO48
         98iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583251; x=1776188051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+J3XqbnCoYpAGIzRu85OxjjRlSoL1F1apznBZBvmL0=;
        b=LGpz+kZcUWT2PXvN5uSDPdrPN/uR9Akl8Gg41u6aHugOdDzrg5zhgZVBnRiVcTbeYT
         A5Y1rK3H6gelolyrH42ntPqcVyGCFqXX+QfyAc916gVHRKai67eGp3v6mm6zbJOqG7k9
         FzavyjJ43xoKQlqx2/e+PH8jLL9rQqBpjE6oot0+Ks0+BCLJU4htDi+0GoaOBfXU2J4Y
         UFgYfgEB6bmNs/9LUxhTzE0I+zIPX4w/8XiRL0GjfaNGXP471NWYDGFNRyQwX5eefmmc
         qkxyWpaCnfSZHvXU0j+qhh7UkEBVFNUPm+wvs9uJdgkGi3TkV2rHaBdcctOQ3wK7Y55g
         Cb4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCOyeEV5LwW+OOHzuk9dHJhXtLGV/LEbFs2eGpQZgGpBGnOGNuZ2eYaqlZ/A1FMaSjX7tae6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxct5pmDcAgkxl08s3UlscN+pGv2GbojWDpn/Uf+dEhQj60dLuJ
	Rnd25rYsdTaDeBv+l3SnNGX0PTaln5GHvibvjhkvjq27XcwDI00lO01WEtc+9bZdTCY=
X-Gm-Gg: AeBDieu1O881MtD9JO+jXCWIu10U6bVss8Ouzx0g3UIaV4a+bo3llJsALzXUazDoYw3
	IxYey2846qs2Yjl1v6P3QMLCf/melBUKMw7LDbZwwcgOogwx/oHTfou4lohxJSCotcrsElgwoCq
	xgugTyqdi4kaAe02i0cDSneE+d8Wcwgqe/Yjc+kgiaMfvuh47ORVIOR8AXEEHIUhMYljb0I9m77
	hbndbB9JKCWZqi9QwEw1vM/rq9JMQE3AJjHNeBlWK3sFmaLktL/OGd6+eWlMpctbPtDnDYtBhOq
	WpMcAravSkdljlxaatInjIpugZNMalA68XxpJjZdEAWTYFFSk2/qP53WOVCs6ZtDUBZelh6GRAg
	KzSlGEV4ohJv2L2b5T0OEG3/PYy+++4SYF4qOa5M86YZQn4jZKpvPfIfOMgNyBCoQ2BsCc+uzZB
	SdLI3I+SURb/DLyp3ND/iGiqiBD5UwRe40cSEdNxSsdCugoxeaUpK48U7sycCrMeApaxm1w9Mxp
	5OxW/nsgE2FHq+AQleMoA==
X-Received: by 2002:a05:600c:37c8:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488ba5f98cemr77455075e9.6.1775583251064;
        Tue, 07 Apr 2026 10:34:11 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c4e930c7sm6667275e9.6.2026.04.07.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:34:10 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/4] drbd: move UAPI headers to include/uapi/linux/
Date: Tue,  7 Apr 2026 19:33:53 +0200
Message-ID: <20260407173356.873887-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276118-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linbit.com:email,linbit.com:mid]
X-Rspamd-Queue-Id: 72EC53B26B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drbd.h and drbd_limits.h contain only type definitions, enums, and
constants shared between kernel and userspace. These should be part of
UAPI.

Split the genl_api header into two: the genlmsghdr and the enums are
UAPI, the rest stays there for now (it will be removed by one of the
next commits in this series).

drbd_config.h is clearly DRBD-internal, so move it there.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_buildtag.c            |  2 +-
 .../block/drbd}/drbd_config.h                 |  0
 drivers/block/drbd/drbd_int.h                 |  2 +-
 include/linux/drbd_genl_api.h                 | 40 ------------------
 include/{ => uapi}/linux/drbd.h               | 42 ++++++++++++++++++-
 include/{ => uapi}/linux/drbd_limits.h        |  2 +-
 6 files changed, 44 insertions(+), 44 deletions(-)
 rename {include/linux => drivers/block/drbd}/drbd_config.h (100%)
 rename include/{ => uapi}/linux/drbd.h (87%)
 rename include/{ => uapi}/linux/drbd_limits.h (99%)

diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd_buildtag.c
index cb1aa66d7d5d..cd0389488f63 100644
--- a/drivers/block/drbd/drbd_buildtag.c
+++ b/drivers/block/drbd/drbd_buildtag.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include <linux/module.h>
 
 const char *drbd_buildtag(void)
diff --git a/include/linux/drbd_config.h b/drivers/block/drbd/drbd_config.h
similarity index 100%
rename from include/linux/drbd_config.h
rename to drivers/block/drbd/drbd_config.h
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f6d6276974ee..f3d746a6d6fd 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -34,7 +34,7 @@
 #include <linux/prefetch.h>
 #include <linux/drbd_genl_api.h>
 #include <linux/drbd.h>
-#include <linux/drbd_config.h>
+#include "drbd_config.h"
 #include "drbd_strings.h"
 #include "drbd_state.h"
 #include "drbd_protocol.h"
diff --git a/include/linux/drbd_genl_api.h b/include/linux/drbd_genl_api.h
index 70682c058027..19d263924852 100644
--- a/include/linux/drbd_genl_api.h
+++ b/include/linux/drbd_genl_api.h
@@ -2,46 +2,6 @@
 #ifndef DRBD_GENL_STRUCT_H
 #define DRBD_GENL_STRUCT_H
 
-/**
- * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
- * @minor:
- *     For admin requests (user -> kernel): which minor device to operate on.
- *     For (unicast) replies or informational (broadcast) messages
- *     (kernel -> user): which minor device the information is about.
- *     If we do not operate on minors, but on connections or resources,
- *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
- *     is used instead.
- * @flags: possible operation modifiers (relevant only for user->kernel):
- *     DRBD_GENL_F_SET_DEFAULTS
- * @volume:
- *     When creating a new minor (adding it to a resource), the resource needs
- *     to know which volume number within the resource this is supposed to be.
- *     The volume number corresponds to the same volume number on the remote side,
- *     whereas the minor number on the remote side may be different
- *     (union with flags).
- * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
- */
-struct drbd_genlmsghdr {
-	__u32 minor;
-	union {
-	__u32 flags;
-	__s32 ret_code;
-	};
-};
-
-/* To be used in drbd_genlmsghdr.flags */
-enum {
-	DRBD_GENL_F_SET_DEFAULTS = 1,
-};
-
-enum drbd_state_info_bcast_reason {
-	SIB_GET_STATUS_REPLY = 1,
-	SIB_STATE_CHANGE = 2,
-	SIB_HELPER_PRE = 3,
-	SIB_HELPER_POST = 4,
-	SIB_SYNC_PROGRESS = 5,
-};
-
 /* hack around predefined gcc/cpp "linux=1",
  * we cannot possibly include <1/drbd_genl.h> */
 #undef linux
diff --git a/include/linux/drbd.h b/include/uapi/linux/drbd.h
similarity index 87%
rename from include/linux/drbd.h
rename to include/uapi/linux/drbd.h
index 5468a2399d48..7930a972d8a4 100644
--- a/include/linux/drbd.h
+++ b/include/uapi/linux/drbd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
 /*
   drbd.h
   Kernel module for 2.6.x Kernels
@@ -389,4 +389,44 @@ enum write_ordering_e {
 
 #define DRBD_CPU_MASK_SIZE 32
 
+/**
+ * struct drbd_genlmsghdr - DRBD specific header used in NETLINK_GENERIC requests
+ * @minor:
+ *     For admin requests (user -> kernel): which minor device to operate on.
+ *     For (unicast) replies or informational (broadcast) messages
+ *     (kernel -> user): which minor device the information is about.
+ *     If we do not operate on minors, but on connections or resources,
+ *     the minor value shall be (~0), and the attribute DRBD_NLA_CFG_CONTEXT
+ *     is used instead.
+ * @flags: possible operation modifiers (relevant only for user->kernel):
+ *     DRBD_GENL_F_SET_DEFAULTS
+ * @volume:
+ *     When creating a new minor (adding it to a resource), the resource needs
+ *     to know which volume number within the resource this is supposed to be.
+ *     The volume number corresponds to the same volume number on the remote side,
+ *     whereas the minor number on the remote side may be different
+ *     (union with flags).
+ * @ret_code: kernel->userland unicast cfg reply return code (union with flags);
+ */
+struct drbd_genlmsghdr {
+	__u32 minor;
+	union {
+		__u32 flags;
+		__s32 ret_code;
+	};
+};
+
+/* To be used in drbd_genlmsghdr.flags */
+enum {
+	DRBD_GENL_F_SET_DEFAULTS = 1,
+};
+
+enum drbd_state_info_bcast_reason {
+	SIB_GET_STATUS_REPLY = 1,
+	SIB_STATE_CHANGE = 2,
+	SIB_HELPER_PRE = 3,
+	SIB_HELPER_POST = 4,
+	SIB_SYNC_PROGRESS = 5,
+};
+
 #endif
diff --git a/include/linux/drbd_limits.h b/include/uapi/linux/drbd_limits.h
similarity index 99%
rename from include/linux/drbd_limits.h
rename to include/uapi/linux/drbd_limits.h
index 5b042fb427e9..a72a102d1ca7 100644
--- a/include/linux/drbd_limits.h
+++ b/include/uapi/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.53.0


