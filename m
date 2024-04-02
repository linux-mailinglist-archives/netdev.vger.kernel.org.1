Return-Path: <netdev+bounces-83976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA889525E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A40B24C9F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAE78B49;
	Tue,  2 Apr 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzZzVkL0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152269DF7;
	Tue,  2 Apr 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059352; cv=none; b=Mpc5ZzdmlYThStBAmXm3jpwfQXBD8Gxj7mgk3pQP6uy1CoPWW1trH347e9dfN32462UZ/pXw/coS97cdQ4ErE2lKH5Tyl2vMYd9586TzCTt8EL8K4wqV7pU/Bw4AYx5qpcFvYFlXXlDrumwQs/WxeEOQV6jbcsjWP2AQzN4DG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059352; c=relaxed/simple;
	bh=xoRt2xQ9+6rlr6ERoM8rH7GWJQCgcNSvCwyFagdBgpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieW3D1M73NzmN68Dg4XhuCjz9puvKVMyshNyhny73zGUVGRCPmOygHWL5hhv4GMZhVTjJJnba+4EixvaliKkxalFphak1KMfo8SQ8CKMCesiUYV4GHCy146ChDJSXIwe0u5WSuGhfjieB+r5jTG3RhB3aeQkkHRj1m4/CkNaE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzZzVkL0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059351; x=1743595351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xoRt2xQ9+6rlr6ERoM8rH7GWJQCgcNSvCwyFagdBgpw=;
  b=jzZzVkL0myhxBphFySfvVwsZqomUgyvEXV6Ub9bWMVGiCQEbWVOOzuHu
   Cbyzht5uuT1JnvxW9l63Ixx8xfgtSvBvwWzY4NoLL+Y+iUzmHUu046DV/
   UcGSaVSNmkeedbais6uHDTr/aGUyfUMF5dRy1pAz8DqZxUWQ3E19k2Tc5
   /vsS6TTUQGkAY/13S5DT/Yx808zonAPLhR0wRsoSmjjcRCQCZOGy9lINV
   mf6przX3U6fOJCrgB3nBxT+NbDA0rPSBJnw/W4eqP68UdjBtmwQZlhjvJ
   c4RWvrDM8UNIfOncTIKUdITX02B5GewShp+HTYRIgEIWgIiauX/+Ve7IC
   Q==;
X-CSE-ConnectionGUID: qGTl/5RARkW5N1PPWvuttw==
X-CSE-MsgGUID: pZi4Z05xTNu1F0qmJ8taCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7067077"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7067077"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:31 -0700
X-CSE-ConnectionGUID: YQQiIckSTwmAKoJ7ylfWzg==
X-CSE-MsgGUID: sG0gL3m6Qg66yy0kqS7bew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494419"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:27 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v3 6/7] selftests/xsk: test AF_XDP functionality under minimal ring configurations
Date: Tue,  2 Apr 2024 11:45:28 +0000
Message-Id: <20240402114529.545475-7-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402114529.545475-1-tushar.vyavahare@intel.com>
References: <20240402114529.545475-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new test case that stresses AF_XDP and the driver by configuring
small hardware and software ring sizes. This verifies that AF_XDP continues
to function properly even with insufficient ring space that could lead to
frequent producer/consumer throttling. The test procedure involves:

1. Set the minimum possible ring configuration(tx 64 and rx 128).
2. Run tests with various batch sizes(1 and 63) to validate the system's
   behavior under different configurations.

Update Makefile to include network_helpers.o in the build process for
xskxceiver.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 8c26868e17cf..dac2dcf39bb8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2419,6 +2419,26 @@ static int testapp_xdp_metadata_mb(struct test_spec *test)
 	return testapp_xdp_metadata_copy(test);
 }
 
+static int testapp_hw_sw_min_ring_size(struct test_spec *test)
+{
+	int ret;
+
+	test->set_ring = true;
+	test->total_steps = 2;
+	test->ifobj_tx->ring.tx_pending = DEFAULT_BATCH_SIZE;
+	test->ifobj_tx->ring.rx_pending = DEFAULT_BATCH_SIZE * 2;
+	test->ifobj_tx->xsk->batch_size = 1;
+	test->ifobj_rx->xsk->batch_size = 1;
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch size to hw_ring_size - 1 */
+	test->ifobj_tx->xsk->batch_size = DEFAULT_BATCH_SIZE - 1;
+	test->ifobj_rx->xsk->batch_size = DEFAULT_BATCH_SIZE - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2523,6 +2543,7 @@ static const struct test_spec tests[] = {
 	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
+	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
 	};
 
 static void print_tests(void)
-- 
2.34.1


