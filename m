Return-Path: <netdev+bounces-239033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE48C62A39
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33ABE4E71A4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B073168F6;
	Mon, 17 Nov 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WafxGHBB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCDC1946DA;
	Mon, 17 Nov 2025 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763363070; cv=none; b=N40jaBsHrG15sZNJtWBsfL0ZSanrXjLj3C2C5ALfGQJFvTXuUzdPdQ8lwu1aFDlhVNryHgPPYViSRWcoe38plaEMNyWNdVKuPcYgCOnnymqL12xz56UhVApxqzpS0zpL1avjwKJewddM3hBgv9KOI9fpltzOsl8MBCW2hQKoCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763363070; c=relaxed/simple;
	bh=dAkB/zPq+9yCAeJRIc2n358wVTyQGSnb5GkGxbn5VtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/axhZ7NP630jcfz1zkqa3qarX5yw8oz2y8yI8ut93Ne8qXTQWSu/MHlm5icMeFyhj3jGxQ1Pp6Aa4FfhSfc4Ml9i2kbCbI7zjs/GPUGD1ukYDjoSwNdPlX/obQSIkILLDfBB9dUPnae3g1ozxCbzR+7xsZHNZSKFJ7gQ11OXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WafxGHBB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763363068; x=1794899068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dAkB/zPq+9yCAeJRIc2n358wVTyQGSnb5GkGxbn5VtQ=;
  b=WafxGHBBaZSnZlqU+xeYxyrmxqyzslOBTTw0vi6tPk7CuCtBS2ANBgMN
   7JM9MU9CH9OG1RLPYDKW0WQObhKTZVs3NqV7wtB55EunYde4b/6o7jMBA
   wkULvzkA1Fi3ieTSJOOpFItpZNv82zQM4cR7WNQlwcA2ZqQ8w71rTwsB8
   gyhnWKBCUOcSMN1Zj0ixDyDz+54bkTjHRN4VHPePgbpdMQR0n6B0KZK6T
   vLg7CntLgyqF8UghZWVrvo0JEt+UnSal5BZHnqVfTjwq+5Bs4CjJg3yGX
   4UGetjaDwvKL2MFlPD4tlNt5rRCxjQkb4PsBwZbrqLsMYdHZeOsifztQG
   A==;
X-CSE-ConnectionGUID: 3U+Lbi6IRLmvvRnFtvEeWw==
X-CSE-MsgGUID: m5LJKQ9tQ3+Jy6d55ET0JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65508106"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="65508106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 23:04:28 -0800
X-CSE-ConnectionGUID: DR7IFLaZQWOwO9AuIQ7/3g==
X-CSE-MsgGUID: QGJntOxRQuiBvCqrUR6USg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="221265651"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 16 Nov 2025 23:04:25 -0800
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 87FE434334;
	Mon, 17 Nov 2025 07:04:23 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>
Subject: [PATCH iwl-net] idpf: fix aux device unplugging when rdma is not supported by vport
Date: Mon, 17 Nov 2025 08:03:49 +0100
Message-ID: <20251117070350.34152-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If vport flags do not contain VIRTCHNL2_VPORT_ENABLE_RDMA, driver does not
allocate vdev_info for this vport. This leads to kernel NULL pointer
dereference in idpf_idc_vport_dev_down(), which references vdev_info for
every vport regardless.

Check, if vdev_info was ever allocated before unplugging aux device.

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index c1b963f6bfad..4b1037eb2623 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -322,7 +322,7 @@ static void idpf_idc_vport_dev_down(struct idpf_adapter *adapter)
 	for (i = 0; i < adapter->num_alloc_vports; i++) {
 		struct idpf_vport *vport = adapter->vports[i];
 
-		if (!vport)
+		if (!vport || !vport->vdev_info)
 			continue;
 
 		idpf_unplug_aux_dev(vport->vdev_info->adev);
-- 
2.47.0


