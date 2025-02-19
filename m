Return-Path: <netdev+bounces-167805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F039BA3C67C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE258179C5A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7C1B4254;
	Wed, 19 Feb 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtOWIqMo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF1286284;
	Wed, 19 Feb 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987174; cv=none; b=HZWMBTTduEMFahaLlu6yBNy4MrFr3g1aablNSta8ULAuAmHO7n7pAUOJS3jfZWSQypO9EMagKH+xO9RRYM72FT6UITqumdljAiFcSWo0A4QCluqcU2b0EZHpMa+d3JX0pJP3H2w8iLn8gYx8NK9OKgUci8kHtYgmQy4aC0s8dJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987174; c=relaxed/simple;
	bh=OqS1vKlIpdTVaIkmp8i1OWbEscx84902VNdjPoE0Guk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhaDrq8E3BIeEqT3pjYdbPGWH+3ep6trBUAr4+4+K0R2p5VUqed/Pe23Y0qWdDCimSAjqEvPjOKB4B6iGd8zIK5IzBbfF8zR/qUY/t1W5+EmdCVfjomhan0CLyvRNgVHfdsDvooWIWOlX8PAJvBv+6gr8BwUfmYiA2QDpDefLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtOWIqMo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987173; x=1771523173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqS1vKlIpdTVaIkmp8i1OWbEscx84902VNdjPoE0Guk=;
  b=GtOWIqMoAmbpt68jLr2q5YBoshbmsOAfliAokHEEYE4E1xiTsQFO4jR1
   cCI+sdvvomx0UhL35D3fchjra7RnKdQhK2AY2L+1TutCKjPz2H2/1yZRk
   zjbf4WlDH7ozkDd5QxY8p0OCTyfO2Mk6Cbrz9WSSwQu0usJ4X2hS5JO9b
   5zCSWSm09ffMFv28IvlECOxylrOHXtFbpeWvSMY7vyMrGPOIZEFMgur7P
   gAbeoR4La28I6JXHcr50+eIpxIr6dUusRtq3AZnSNmOVn73MSd1OH5qQm
   y+2bKBW+8d2fMgNy2dEMoPKg69P2iu8mwRAs7zELnfmkfFRzodfdNEQIq
   Q==;
X-CSE-ConnectionGUID: CYLpdAS9QjSenVm8uBckkg==
X-CSE-MsgGUID: ZAI+qLHTQQe53vuxTOTi9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="50952999"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="50952999"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:46:12 -0800
X-CSE-ConnectionGUID: JfsQ4rI5SmOgRwqeVyN97g==
X-CSE-MsgGUID: WUiLLwANSHyTznJPs8d55Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119427318"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2025 08:44:32 -0800
Received: from pkitszel-desk.intel.com (unknown [10.245.246.109])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C85EE33E9A;
	Wed, 19 Feb 2025 16:44:16 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next v2 0/2] devlink: whole-device, resource .occ_set()
Date: Wed, 19 Feb 2025 17:32:53 +0100
Message-ID: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


I'm working on ice+iavf changes that utilize the two devlink patches
of this RFC series. The two are related in that I will group them anyway
for my actual submission.

Patch 1: add an option for drivers like ice (devlink instance per PF)
	to add a whole-device devlink instance, that wraps them together.

Patch 2: add resource occupation setter and a (better) mode of resource
	control for users

Przemek Kitszel (2):
  devlink: add whole device devlink instance
  devlink: give user option to allocate resources

 net/devlink/devl_internal.h | 14 +++---
 net/devlink/core.c          | 58 ++++++++++++++++++-----
 net/devlink/netlink.c       |  4 +-
 net/devlink/port.c          |  4 +-
 net/devlink/resource.c      | 94 +++++++++++++++++++++++++++++--------
 5 files changed, 132 insertions(+), 42 deletions(-)

-- 
2.46.0


