Return-Path: <netdev+bounces-163411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7194A2A35D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9203A3978
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C7225768;
	Thu,  6 Feb 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyGuF2S5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779B2253F1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831228; cv=none; b=nGoPW3fS+cVUg60uydj1GdhfSlBwNoTHrzhRWmE2cTqqbqufnOFOj01qSDVLxZSB/D4/1ER1b/fOqHKEDd/VLhfwaGTTPh1Eh1UKo/4C6KmLu8AuxqILq/uqjrHACFXTTtatb9PIix4r+NGMqu+oT9pp735ZavNpXDKCI3q5Fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831228; c=relaxed/simple;
	bh=di+hvTmQjctnKvY30xevDPGzRJy0W/wSEhqMf8pXGV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAA6KESSmSdUjTAGr/vAGwS1Ln3dr2ZNZrG8qI6rTuaxeD5S5SFkip4hiow0QC2wDOG5NUIHXPsZk5fs/Lm7nHXMVoWsG/Kxb6s/IyD72CSqxUtiaURsFUl8RnLbbZO37r27z1lJfScMHT4drgvMOP7Mk8J98tVx/95rE0agVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyGuF2S5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738831226; x=1770367226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=di+hvTmQjctnKvY30xevDPGzRJy0W/wSEhqMf8pXGV8=;
  b=PyGuF2S5rZ+Qhw+EmCfpzOdah/qOFrzSe6xKzD8Q7giSjDaTUFvdFe6T
   4/um0XPrKHtF2IL0wZpEeuTgdPy4b5nTAeMN8zjf/uChNlvHrJZgpSQ9b
   moIRSYUStMU3lHBXcC59YImb8Jt1z/ZUhUlj1NjuXUEdMQV8v+h0zdgBb
   J/6xGjTbIf/GPdLyqNBYrKYhpu6tPMG311sNjW/hz+OLdQlftGrQDHGOg
   2Y4zC7H6f4WBZwmcr/5iyWNytTiDVNbcN+LRt4FlHVugMlf7Vyz3B23xG
   l7yNZ3kAqJzuISKe4RQgtW032MtkN/NvlXAImu9XEPgmt1u7oQjkex9bG
   g==;
X-CSE-ConnectionGUID: gVi00x47QqaoQQP7KBHjpw==
X-CSE-MsgGUID: MC3tDWDhShaprwNW5g6l2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49667818"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49667818"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:40:26 -0800
X-CSE-ConnectionGUID: iOFVivvQRuOli/LD+8maIQ==
X-CSE-MsgGUID: sL4QVyujShCKT/m8CYcQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="110979363"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by fmviesa006.fm.intel.com with ESMTP; 06 Feb 2025 00:40:24 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 0/3] E825C PTP cleanup
Date: Thu,  6 Feb 2025 09:36:52 +0100
Message-Id: <20250206083655.3005151-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series simplifies PTP code related to E825C products by
simplifying PHY register info definition.
Cleanup the code by removing unused register definitions.
Also, add sync delay compensation between PHC and PHY for E825C.

Karol Kolacinski (3):
  ice: Add sync delay for E825C
  ice: Refactor E825C PHY registers info struct
  ice: E825C PHY register cleanup

 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 20 ++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 36 ++++-----
 3 files changed, 43 insertions(+), 88 deletions(-)


base-commit: 70bdf16570c2c207a562e996833ff196a4bd7029
-- 
2.39.3


