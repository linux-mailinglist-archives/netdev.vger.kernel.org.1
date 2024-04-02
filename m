Return-Path: <netdev+bounces-83977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EAA895260
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0351F21BAA
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5F76C61;
	Tue,  2 Apr 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvwl4TSH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BA76C76;
	Tue,  2 Apr 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059356; cv=none; b=uGkD1l8xyrOyYo2X9BMmEJlqBdsvusDGqhPLMkwnenu5XBDpCFGxq2HIIU/44CQtKuXEe/pa7SNMo9ePXD3jBnlwW/3brLfy4JFhWIJLBrU4Y9X2vvcQIMOC0YIzmODUOc+lI7vzgmAmnY1YwGtjGgN76yVoWLW3f1HueSht/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059356; c=relaxed/simple;
	bh=3uNXAkTK6wlGV4bLJ+siP19LdInTvZftHrQul3EII+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnraPw6F+yrsDouMUX3oQlCaS8nyPE8QjaSBDW511oLbmZcDN3tERrqcjW8g0qsAIcM2H1AyPtRBj3HZo37I1hqCx2wp0ryYROgfmCS/1dA4hDJaifIYGGVxLRDbQvrW4s/+s6giAU8Xq1/6Y4t4niCRq4ZOTBWDIJrSIclkXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvwl4TSH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059355; x=1743595355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uNXAkTK6wlGV4bLJ+siP19LdInTvZftHrQul3EII+Y=;
  b=Dvwl4TSHuQCKtjEr7x2UbYs/J3wyNfo1bIodcZ/PfKMcV1k63Lq3r4Qn
   er7dx/a8f7014phyljPHQMSwzeV2NxsqILkpMFIK5Yj+WKhh5eFeF0ldo
   daeMprzjufD0SpH8+8eVqImtTzQUfI8KNsEDt1DjbQ1/SXnTcf9WH0+Sb
   QJctVxUpCWUzQYuQRg0erxJpBC49vbnyP0rIcFi0aw7cmZcZks1MZxL41
   CTeNlBuOc6MyKYcNEO5lpn2ekfLwVG3x/JLOFObUI1K394/fzPf8dBnFh
   Ei2hz98azP7Iy8faINWRFHxyg7gnXpgOLO4pVu0HLH7C8qGa8WfrL7w9v
   Q==;
X-CSE-ConnectionGUID: M44xb1R+RnarVhSWntNHOw==
X-CSE-MsgGUID: EGfQXLMXQe+sdeosnEaw2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7067093"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7067093"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:34 -0700
X-CSE-ConnectionGUID: 5X4BrsoDQwqbsbzgQBWB4w==
X-CSE-MsgGUID: KfHLaNGNTGyaNFL/PvDjLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55494433"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:02:31 -0700
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
Subject: [PATCH bpf-next v3 7/7] selftests/xsk: add new test case for AF_XDP under max ring sizes
Date: Tue,  2 Apr 2024 11:45:29 +0000
Message-Id: <20240402114529.545475-8-tushar.vyavahare@intel.com>
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

Introduce a test case to evaluate AF_XDP's robustness by pushing hardware
and software ring sizes to their limits. This test ensures AF_XDP's
reliability amidst potential producer/consumer throttling due to maximum
ring utilization. The testing strategy includes:

1. Configuring rings to their maximum allowable sizes.
2. Executing a series of tests across diverse batch sizes to assess
   system's behavior under different configurations.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index dac2dcf39bb8..2eac0895b0a1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2439,6 +2439,30 @@ static int testapp_hw_sw_min_ring_size(struct test_spec *test)
 	return testapp_validate_traffic(test);
 }
 
+static int testapp_hw_sw_max_ring_size(struct test_spec *test)
+{
+	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
+	int ret;
+
+	test->set_ring = true;
+	test->total_steps = 2;
+	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
+	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
+	test->ifobj_rx->umem->num_frames = max_descs;
+	test->ifobj_rx->xsk->rxqsize = max_descs;
+	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+
+	ret = testapp_validate_traffic(test);
+	if (ret)
+		return ret;
+
+	/* Set batch_size to 4095 */
+	test->ifobj_tx->xsk->batch_size = max_descs - 1;
+	test->ifobj_rx->xsk->batch_size = max_descs - 1;
+	return testapp_validate_traffic(test);
+}
+
 static void run_pkt_test(struct test_spec *test)
 {
 	int ret;
@@ -2544,6 +2568,7 @@ static const struct test_spec tests[] = {
 	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
 	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
 	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
+	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
 	};
 
 static void print_tests(void)
-- 
2.34.1


