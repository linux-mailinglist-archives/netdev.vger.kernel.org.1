Return-Path: <netdev+bounces-281732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP1zI3Z18GkMTwEAu9opvQ
	(envelope-from <netdev+bounces-281732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31879480A11
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87F25304290D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29293D811F;
	Tue, 28 Apr 2026 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGYY6pAT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBF3D7D96;
	Tue, 28 Apr 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365985; cv=none; b=B36TXbC304v0COi8MbHCXThE0Fbfs3x9pV4JhGeQsZqsk08p+LgkhEgQHSXu0u+/0hQPo7SXhMGfpzv7oWmHG65ZU0CP0A0NVV1pTd7WMlKC412Boa7cWY8t8at3Y/YDALN7LC1lsxaupQklYgXfztUjg3l/zoGApMocGCXd5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365985; c=relaxed/simple;
	bh=xKbLphO4plyGr7xfODrgX/Ml/CS1j4MGi1CczR5bmq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrAtvuoQQdmG5Jkqn1jXV1k5qGHTq9QZ2Y+8myer+l/mbOhQgq6Dz9oj9DchSH5n+9hWcPWckZzakafTIhqq2nJJr5vGgRO56DrP7ruUdAMvca+7qOEuLt5Ibsosg+F7S+VnPds49mZacWAEHhTuLPCfKe/mwDEeEu/RJG/n5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGYY6pAT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777365984; x=1808901984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKbLphO4plyGr7xfODrgX/Ml/CS1j4MGi1CczR5bmq8=;
  b=lGYY6pAT1vx81F2juJzRzaWuLhspnwtfen26KGRKjdQbQIVjiemT8ZI5
   WILKt42QOeHd7dYv10a6pqgZTiJZF9S5x1fAtu/Cg0JbzT3o4sVxoichs
   ka2GHBaptw7IFQtyzPe1hD3fvMuIFi7Dggoci8t2Z2YAbXZmzL29SdDoJ
   kkngQb3Gk82ZgT96O9BpmzafmhPMyBwaXFI9cNWdIL1ZZX/erlNK2T2mP
   7ll7hMmKfy8hHuE+MB12skuTGmUOUg96GLarVy+bIRE1VK65TxxdefGqu
   eFGjQYusPzddLYDL01traU6rpFoJaN3qNPwkEP6mpB4qLze3HBGvxA8iE
   w==;
X-CSE-ConnectionGUID: LWoG6i8uRSGoJwSXBNbe3g==
X-CSE-MsgGUID: gDplBIhySM+NPAPnHigCmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77433293"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77433293"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:24 -0700
X-CSE-ConnectionGUID: lYd4k5SJQDeIufTHeWrOQg==
X-CSE-MsgGUID: dNE9gYYTT5KBN+gRwr/G1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233027371"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:46:20 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH 5/5] selftests/xsk: Introduce mmap_size in umem struct
Date: Tue, 28 Apr 2026 13:33:16 +0530
Message-ID: <20260428080317.702124-6-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080317.702124-1-tushar.vyavahare@intel.com>
References: <20260428080317.702124-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31879480A11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

UMEM teardown currently recomputes the `munmap()` length
from frame geometry (`num_frames * frame_size`, shared-UMEM
multiplier, and hugepage rounding).
That duplicates setup logic in cleanup and makes teardown depend on
re-deriving values instead of using the exact mapping metadata.

Store the finalized mapping length in `xsk_umem_info` as `mmap_size` when
the UMEM mapping is created, and use that value during teardown.

This removes duplicated size arithmetic in cleanup and guarantees that
`munmap()` uses the same canonical size that was established at setup time.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 9 +++------
 tools/testing/selftests/bpf/prog_tests/test_xsk.h | 1 +
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index ba4768f83eb6..ba1bcfc6b74b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1594,6 +1594,8 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	if (bufs == MAP_FAILED)
 		return -errno;
 
+	umem->mmap_size = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
+
 	ret = xsk_configure_umem(ifobject, umem, bufs, umem_sz);
 	if (ret)
 		return ret;
@@ -1700,14 +1702,9 @@ void *worker_testapp_validate_rx(void *arg)
 static void testapp_clean_xsk_umem(struct ifobject *ifobj)
 {
 	struct xsk_umem_info *umem = ifobj->xsk->umem;
-	u64 umem_sz = umem_size(umem);
-
-	if (ifobj->shared_umem)
-		umem_sz *= 2;
 
-	umem_sz = ceil_u64(umem_sz, HUGEPAGE_SIZE) * HUGEPAGE_SIZE;
 	xsk_umem__delete(umem->umem);
-	munmap(umem->buffer, umem_sz);
+	munmap(umem->buffer, umem->mmap_size);
 }
 
 static void handler(int signum)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index accda2456fe6..0355a9d06b4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -85,6 +85,7 @@ struct xsk_umem_info {
 	struct xsk_ring_cons cq;
 	struct xsk_umem *umem;
 	u64 next_buffer;
+	u64 mmap_size;
 	u32 num_frames;
 	u32 frame_headroom;
 	void *buffer;
-- 
2.43.0


