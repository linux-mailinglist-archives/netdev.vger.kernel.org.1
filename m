Return-Path: <netdev+bounces-107462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44291B196
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B2B241B3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9F19DF9E;
	Thu, 27 Jun 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdxhqNjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24231494A1
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524155; cv=none; b=Wmt6YnIB2o2vPAWbgmz5k5e6is/HAsykZ+Db4PTe4lzQ1tpqdfpkbil098t6KDu09sLmkRmTkdgFLiM+OLF+oZF4GD2UX6qV886htz7U2QeMWAjtt4wwVaTF5VX+kbCekJqzk5qOKTVRopMmGizpyKyee0hRNXXXd5RN1T9wPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524155; c=relaxed/simple;
	bh=x1YAzzvByhg9SSLXew0uDu+jljF+hXDIb6M+LAH1SkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4jGyZBGoN9zAZgL5VJYJooOnNdEJxjB2uAtJ7ElVT7CSh7w1uAplhb6KxbpjVxASZLjlDyoqUpQ/yKQWILa9FvDCfkrzUzTpwYycJZsy4ZMCVvR9Ix3qkBJexTmjJWmLjDq2G4lDc1O0nB9Q/ar9nwpB5KLI5nGfWoqG49gf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdxhqNjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA037C2BD10;
	Thu, 27 Jun 2024 21:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524155;
	bh=x1YAzzvByhg9SSLXew0uDu+jljF+hXDIb6M+LAH1SkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdxhqNjo3JV+vAsEJauCoy3wGoE7EHooUA0Q3kkbF1eW4rRasZFxLjYewh2ZH2W0Q
	 UZo7Wdqyy8wSDaHKOc4gNb6BxS1BJCwAnYt91tMLqVHy1vuEFwI9jC8bF5DU0R3ClG
	 V3kfPd314+0wnLC7rx6s5Y7CcciHe8Ig0Q9uzx40JS8Ro95dGiLyX/UUkBSXdsmy2i
	 VCZTyjGcglBhp8gBh9QyphmF0rElrHyVQR+MjM+vh2gKLuLftgB0KXn5NTr5vMCKyp
	 VpGoERRFhnI+TAfITTb6qlcP1WfKexO+jhw4X+fiyCR4ED5EsTyyNRoilLX5SSFNCs
	 FN8I/mySXWZLw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] tcp_metrics: add UAPI to the header guard
Date: Thu, 27 Jun 2024 14:35:50 -0700
Message-ID: <20240627213551.3147327-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627213551.3147327-1-kuba@kernel.org>
References: <20240627213551.3147327-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_metrics' header lacks the customary _UAPI in the header guard.
This makes YNL build rules work less seamlessly.
We can easily fix that on YNL side, but this could also be
problematic if we ever needed to create a kernel-only tcp_metrics.h.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/tcp_metrics.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp_metrics.h b/include/uapi/linux/tcp_metrics.h
index 7cb4a172feed..c48841076998 100644
--- a/include/uapi/linux/tcp_metrics.h
+++ b/include/uapi/linux/tcp_metrics.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /* tcp_metrics.h - TCP Metrics Interface */
 
-#ifndef _LINUX_TCP_METRICS_H
-#define _LINUX_TCP_METRICS_H
+#ifndef _UAPI_LINUX_TCP_METRICS_H
+#define _UAPI_LINUX_TCP_METRICS_H
 
 #include <linux/types.h>
 
@@ -58,4 +58,4 @@ enum {
 
 #define TCP_METRICS_CMD_MAX	(__TCP_METRICS_CMD_MAX - 1)
 
-#endif /* _LINUX_TCP_METRICS_H */
+#endif /* _UAPI_LINUX_TCP_METRICS_H */
-- 
2.45.2


