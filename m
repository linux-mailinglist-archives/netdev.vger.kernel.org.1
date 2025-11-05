Return-Path: <netdev+bounces-235789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB5C35AAC
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEAB04EB91C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD421313295;
	Wed,  5 Nov 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG4puGY1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5C313E0C
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346082; cv=none; b=EFH+bdDJ3g5efqDpoCBJahW4wsZ4zo6j700Avfx8sQsHs0q+oRIvJcpIelxS2zGxf+Ya7UszEpfWW6Oyn2uaeDUat8OpvaNBN6hFff0cN3qSNQKc0AQ7PRUVVWIZnDjUwXh4pRo8c04pAbQIixuG44JbeMP+7oXXfD4GwLv1kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346082; c=relaxed/simple;
	bh=s+Hmi6t44VWKMMKuarLYfvp86vaNLRxUOKz2NtS36pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvYtBZTjeQdv9i8+jkWXkg1/banl+dh+PJfdy9yO8JCw15fLlNsXBErF++WrqOUXfR/dPJth0P1NJ82opfq8XSjipjBPaMG+ebqcv3DafpmN9cPvEZvQOL4o/XNy1EmYkBBKX6tPoFnEite6c5FeGGdRabbemGv7VkLFYdpi6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG4puGY1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762346081; x=1793882081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s+Hmi6t44VWKMMKuarLYfvp86vaNLRxUOKz2NtS36pg=;
  b=CG4puGY1/ruH/RPVC1HokGJcU0PiA7R5HfmdepPcT1j7419nce6XFFmt
   SBcUb19f6RZDce1APdrGGMAYVnhvyfeb9ORcF9+dz+wT8EYa7FqpS3yL6
   RQpLruKNXOM2AQhz6tX9Lj3kQtu0dUQY2VIqmlyMaZTae0GodkdPv6nfc
   X4q/ytyVrLXhMbzRbAEKhtwfaOWG8yh6PgDOuZoBSYDwHNekxRzc8vFuR
   4bNZcrj/EG5yD70V0n26OK8ruUNxRCyBRu3POqlIUUlCyJnvjaNrsPbn5
   zz4kR7j/es/j9pz3En4xFwA0SXjmo2NFrpUEhXgBqu2935hxifMf+IdMp
   A==;
X-CSE-ConnectionGUID: MaxGaTzARDaIeJugXhR6Pg==
X-CSE-MsgGUID: 7qYeo6bNQh6HSTTNvKIkgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="89920308"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="89920308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:34:40 -0800
X-CSE-ConnectionGUID: bLHsCdiYQSeGfCcLX5useA==
X-CSE-MsgGUID: bbBEwNWOQ6aMlLlKnzXlXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191734435"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 05 Nov 2025 04:34:39 -0800
Received: from korred.igk.intel.com (korred.igk.intel.com [10.237.113.2])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 17D8F28798;
	Wed,  5 Nov 2025 12:34:38 +0000 (GMT)
From: Natalia Wochtman <natalia.wochtman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1] ixgbevf: ixgbevf_q_vector clean up
Date: Wed,  5 Nov 2025 13:21:47 +0100
Message-ID: <20251105122147.12159-1-natalia.wochtman@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flex array should be at the end of the structure and use [] syntax

Remove unused fields of ixgbevf_q_vector.
They aren't used since busy poll was moved to core code in commit
508aac6dee02 ("ixgbevf: get rid of custom busy polling code").

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Natalia Wochtman <natalia.wochtman@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 039187607e98..516a6fdd23d0 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -241,23 +241,7 @@ struct ixgbevf_q_vector {
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
-	struct ixgbevf_ring ring[0] ____cacheline_internodealigned_in_smp;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	unsigned int state;
-#define IXGBEVF_QV_STATE_IDLE		0
-#define IXGBEVF_QV_STATE_NAPI		1    /* NAPI owns this QV */
-#define IXGBEVF_QV_STATE_POLL		2    /* poll owns this QV */
-#define IXGBEVF_QV_STATE_DISABLED	4    /* QV is disabled */
-#define IXGBEVF_QV_OWNED	(IXGBEVF_QV_STATE_NAPI | IXGBEVF_QV_STATE_POLL)
-#define IXGBEVF_QV_LOCKED	(IXGBEVF_QV_OWNED | IXGBEVF_QV_STATE_DISABLED)
-#define IXGBEVF_QV_STATE_NAPI_YIELD	8    /* NAPI yielded this QV */
-#define IXGBEVF_QV_STATE_POLL_YIELD	16   /* poll yielded this QV */
-#define IXGBEVF_QV_YIELD	(IXGBEVF_QV_STATE_NAPI_YIELD | \
-				 IXGBEVF_QV_STATE_POLL_YIELD)
-#define IXGBEVF_QV_USER_PEND	(IXGBEVF_QV_STATE_POLL | \
-				 IXGBEVF_QV_STATE_POLL_YIELD)
-	spinlock_t lock;
-#endif /* CONFIG_NET_RX_BUSY_POLL */
+	struct ixgbevf_ring ring[] ____cacheline_internodealigned_in_smp;
 };
 
 /* microsecond values for various ITR rates shifted by 2 to fit itr register
-- 
2.45.2


