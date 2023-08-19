Return-Path: <netdev+bounces-29078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B978190B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB1B280291
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4A19BD7;
	Sat, 19 Aug 2023 10:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D419BA7
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A11140C3
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438617; x=1723974617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7CpkAGm9AMDYpLCrvBWk5/DAhJHRJZsYuZXPpX0QRn8=;
  b=MeNgNig1sq347P8Sx18OJy8POE6I940MRquVyjaRW6BGrclyZQEnVCcl
   kcyx3eQefx/0wV2mqVqSMsgwYLIRkhin9Ie3T3aF52RONhAAjq3L4zIw7
   JAemRqHmonZsXZWtOp17NOjMluXBno9km3SYCw1yubJa0TG3N+1ao5TOD
   4qdg9I0CRfF/kGxf8wXfvc1SeqGE+LF/oqJDl7GHbBFZMhv2iO+wYEDqq
   A7xgRxdybTQddPbQ1oxjeWSCviDg3yw1U1u4We80v5Ne1mMV3sJEBSrhS
   Cglrq13RN3AFutqipNsglgJXC3S0FyfHVoqwgGvoXeh9e/0YLJmPkBQZb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="370726091"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="370726091"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="981922765"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="981922765"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2023 02:50:16 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 9/9] ice: Enable support for E830 device IDs
Date: Sat, 19 Aug 2023 02:42:52 -0700
Message-Id: <20230819094252.15319-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d6715a89ec78..80013c839579 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5630,6 +5630,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_10G_BASE_T)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP)},
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD)},
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT)},
 	/* required last entry */
 	{ 0, }
-- 
2.39.2


