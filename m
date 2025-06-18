Return-Path: <netdev+bounces-199264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A7ADF956
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CA74A122E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5427E7FB;
	Wed, 18 Jun 2025 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S248oXyi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFB3085AA
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285506; cv=none; b=QMyPOuW7Omzz6bwRLNq9P9HmN1bbzk8iLa76hvOv4KB+V2UQSzpusNiq9vPkWVbWfWgoSC7SSCYvxlO09VAW2pDi7AtNuC65uQZFmkC2d5KoVCk2XAvH7+mpu/+9SzhIf5W1mRJXoK3iK1gH+flDU3WXqeX4SEPCXr7Ld/K5rnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285506; c=relaxed/simple;
	bh=/C0mKxIHEbpL62vBDZxpL6tZO8RNdm66a6YCQJP1wVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=khvB2HV726hK5gO+Brxyl1HIxLgHtmk0SUdBYXenFEVizW5Fj+BOi4rQEiCI2MT4zlqNj2t13cgQT7LLJBVEC7kOWfoqalk5SaX9JNocE8h5v9WLaSLZfktOUbOzI1TlygUC+59/a6SRtL5izsOkAeACikFYESwpIgAnKNExPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S248oXyi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285505; x=1781821505;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/C0mKxIHEbpL62vBDZxpL6tZO8RNdm66a6YCQJP1wVE=;
  b=S248oXyipUsubdqI1BvDBSZcfoG2Bjcekym+LnfDItACFMEeAHqQP24E
   YTDQjg95ZNxDgtsiE2JweuoTpQNQa6QgKHygMFPq3y4LuJTxcvxop0mKs
   5CmsSJfjdTYmocybiMdvhUvxKGm0U9CPrd5478AmOhkWMx+fa4poqqLg9
   JkIKi8ZjKT+sh6Ood+cyOv0AiocHOUp5/e8jzEx6Mp74zATpigrM0ZjrE
   b/77ixGYVKe3WBvklbtlJslJ08FA5ftw38dOvtjEHCc6+jm+HlJ/ZcctE
   A8WW0HztgV/dwUHacs4338kWdlBJgg5cYE5bLRGSm3XzOuSD6yIZnNtlU
   Q==;
X-CSE-ConnectionGUID: p3yi28RPThOnTnPwpKM1FA==
X-CSE-MsgGUID: nGXusL0IQ4ufvoYA+CvEeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447731"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
X-CSE-ConnectionGUID: Dd23nvGPSJSF6pDs1bvqEQ==
X-CSE-MsgGUID: iWxuQtHMSRuepUX3zNd2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870000"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 0/8] ice: cleanups and preparation for live
 migration
Date: Wed, 18 Jun 2025 15:24:35 -0700
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKM8U2gC/03NwQqEMAwE0F+RnA20trrFXxEPolHjaldaUUH8d
 8OePL5hmLkgUmCKUCYXBNo58s8LdJpAOzZ+IORODJnKclVoh+S0wpl3woWH0GzSx+n7whpoRWd
 cp3JjbWs/IFsS9nz+fyrgY0ZP5wb1fT9yJPNqgQAAAA==
X-Change-ID: 20250618-e810-live-migration-jk-migration-prep-838d05344c47
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

Various cleanups and preparation to the ice driver code for supporting
SR-IOV live migration.

The logic for unpacking Rx queue context data is added. This is the inverse
of the existing packing logic. Thanks to <linux/packing.h> this is trivial
to add.

Code to enable both reading and writing the Tx queue context for a queue
over a shared hardware register interface is added. Thanks to ice_adapter,
this is locked across all PFs that need to use it, preventing concurrency
issues with multiple PFs.

The RSS hash configuration requested by a VF is cached within the VF
structure. This will be used to track and restore the same configuration
during migration load.

ice_sriov_set_msix_vec_count() is updated to use pci_iov_vf_id() instead of
open-coding a worse equivalent, and checks to avoid rebuilding MSI-X if the
current request is for the existing amount of vectors.

A new ice_get_vf_by_dev() helper function is added to simplify accessing a
VF from its PCI device structure. This will be used more heavily within the
live migration code itself.

REVIEW NOTES:

This is the first eight patches of my full series to support live
migration. The full series (based on net-next) is available at [1] for
early preview if you want to see the changes in context.

Some of these changes are not "used" until the live migration patches
themselves. However, I felt they were sufficiently large and review-able on
their own. Additionally, if I keep them included within the live migration
series it is 15 patches which is at the limit of acceptable size for
netdev. I'd prefer to merge these cleanups first in order to reduce the
burden of review for the whole feature.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: [1] https://github.com/jacob-keller/linux/tree/e810-live-migration/jk-migration-tlv
---
Jacob Keller (8):
      ice: add support for reading and unpacking Rx queue context
      ice: add functions to get and set Tx queue context
      ice: save RSS hash configuration for migration
      ice: move ice_vsi_update_l2tsel to ice_lib.c
      ice: expose VF functions used by live migration
      ice: use pci_iov_vf_id() to get VF ID
      ice: avoid rebuilding if MSI-X vector count is unchanged
      ice: introduce ice_get_vf_by_dev() wrapper

 drivers/net/ethernet/intel/ice/ice_adapter.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  14 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  12 ++
 drivers/net/ethernet/intel/ice/ice_lib.h        |   8 +
 drivers/net/ethernet/intel/ice/ice_sriov.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h     |  34 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h   |  19 ++
 drivers/net/ethernet/intel/ice/ice_adapter.c    |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c     | 233 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_lib.c        |  35 ++++
 drivers/net/ethernet/intel/ice/ice_sriov.c      |  19 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c   |  59 +-----
 14 files changed, 384 insertions(+), 68 deletions(-)
---
base-commit: d16813402994bde9201030ef877c9d753227e6dd
change-id: 20250618-e810-live-migration-jk-migration-prep-838d05344c47

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


