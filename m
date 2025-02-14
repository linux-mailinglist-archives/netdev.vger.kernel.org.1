Return-Path: <netdev+bounces-166453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D875CA36070
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59651895526
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B5266585;
	Fri, 14 Feb 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THybl9/e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC23266571
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543358; cv=none; b=DZ88TwRbouUHJtBppE4aPRNzFx3S1JzUcc44tdbd55bjStUXvMA7Fk1Vg9pqmOmFTNB5aDEeqZbYisopgMvhFg7SGBMO9eYuRPjBxtV+rz2MBhq7xzgqEMuYXvyfS5JUG1pz/F0eghP8Kg/pBFX2iPtqy/UWy40NZpXU/uk0BdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543358; c=relaxed/simple;
	bh=ToeXWe3IP3qc2T8aXJTUctf7wVvrNLEhK64L+14DMqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJsAH0h6ks4RnxKrYhlRiKJAoc6iMHnyJl7XFzC9z/QmEp44ZrI46KdBdNyB+MJGm5j+1g5dLL+JmmK7MQh+bBcyIPaLK33tki9QR+sR3fadLnRdj7vOp2eI5lNWJm99Z1pYW8ohplBeXEqsOM1YsTqg1fmhneKLufNrEGfZz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THybl9/e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739543357; x=1771079357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToeXWe3IP3qc2T8aXJTUctf7wVvrNLEhK64L+14DMqw=;
  b=THybl9/eOWp37b6vbuH9DT49VIQ1NzDgSLIc6tsmcE0iOHLXB+a89ofO
   nSqSlTyrz8piZMoDjV5A8YN2OL7vAQ+NnA4r84A5PvK13j+tCM/5cF7Qp
   tHKweXw9cmt1jNd/KIJA7Apodfiorl5yHF8Pcrc5I20tMRw6BM87Exkpw
   cf5XbrcklliVfZR0ogC7jrUZ9k9qZYWu2K5jQMuPMyELuIzYJ0rlykTTS
   +FsLEKSMCdf8LJOxrb64jzg2IvWuk9Mk3CeUQGE74sDC61h0wWU7cwOir
   kMhXqG8SqpWk3q4xBGZFOya9NI1fxoJ+VXs0se8FC2bFxEEy5qck37DG4
   Q==;
X-CSE-ConnectionGUID: +YRcq9+cR/SXuVC9ca4aKw==
X-CSE-MsgGUID: mnX6SzxvTJqGrRCaPsnfaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50936631"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50936631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:29:17 -0800
X-CSE-ConnectionGUID: AYUaJxWKSUWE4iTqjmPWDA==
X-CSE-MsgGUID: e6LHuMCpRmmbBq0tBgEA5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="118503746"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 14 Feb 2025 06:29:15 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next v3 3/3] ice: add ice driver PTP pin documentation
Date: Fri, 14 Feb 2025 15:23:32 +0100
Message-Id: <20250214142332.600124-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250214142332.600124-1-arkadiusz.kubalewski@intel.com>
References: <20250214142332.600124-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add a description of PTP pins support by the adapters to ice driver
documentation.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v3:
- add missing reviewed-by and signed-off-by
---
 .../device_drivers/ethernet/intel/ice.rst           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index 3c46a48d99ba..0bca293cf9cb 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -927,6 +927,19 @@ To enable/disable UDP Segmentation Offload, issue the following command::
 
   # ethtool -K <ethX> tx-udp-segmentation [off|on]
 
+PTP pin interface
+-----------------
+All adapters support standard PTP pin interface. SDPs (Software Definable Pin)
+are single ended pins with both periodic output and external timestamp
+supported. There are also specific differential input/output pins (TIME_SYNC,
+1PPS) with only one of the functions supported.
+
+There are adapters with DPLL, where pins are connected to the DPLL instead of
+being exposed on the board. You have to be aware that in those configurations,
+only SDP pins are exposed and each pin has its own fixed direction.
+To see input signal on those PTP pins, you need to configure DPLL properly.
+Output signal is only visible on DPLL and to send it to the board SMA/U.FL pins,
+DPLL output pins have to be manually configured.
 
 GNSS module
 -----------
-- 
2.38.1


