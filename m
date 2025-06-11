Return-Path: <netdev+bounces-196468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291BAD4EB7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E17A15AB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0D23F43C;
	Wed, 11 Jun 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDWIflgr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9F23C8CD
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631572; cv=none; b=KaoGEInsAxIxdhEs6d8ecktIGc9EGDa6VFVen2z00xBgo7qww242PxUlmIqV3JgFJlk9RMiL6LEDIObrOHyZ5M0aX//TBnz3j4oe0ywdIEp/2aYKXJJArTybBnMVTyLFu4U6gtuI+ksauSv/6bjDahoAJIJJDKGeRLcZRNvCaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631572; c=relaxed/simple;
	bh=lefHV1vQLDgNtGs4h7hH9bY2WDelV3RUOmHc9mMdkE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gm/UKMXMD14DxDUeiWaESmK1lF+GAzHGgkOOJbw9E1bAXHnUxXhzCbR7jWzXYCtJFhKPx/TEz+HNrkLddMi83UeSvAll3aBZpX9+WldtBZaXDlkfNPrBaDtQ5Kp/Gz6TUk8fMCRERPdSnzH3FXe1PooDqikOwLqOeL7BYu75Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDWIflgr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749631571; x=1781167571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lefHV1vQLDgNtGs4h7hH9bY2WDelV3RUOmHc9mMdkE0=;
  b=BDWIflgrv9LjZksvI1JC+F5QftFpPQs4AB3tJSrZ3NwFHngsIm37NqQQ
   HTxLn4bj7SaRF3MteITkf+gAi5OVgvQQP9/1l7OoM9pGPDLbf9LXYO4OE
   dxqxvzWJ1948Y1FaPpOPGa/kCyoHaaUeAwVBLc4xdRcv6Xby208sgfqEc
   rvZYpUEpm2Iyn+Cel2po2n+Z94W73TjgRMwdr5S95jPTQ6AsZFHtol/KS
   l+oIQGh9EzxrUdlVmHOZ1cPNCLp01TlvGo509y9aECUlnLD3oT+hR48Co
   pzhl16T/NpS2Szc/JS3jvHvi0d9GNHeKGTWCbtnKp49OGDDvHZWiD11yG
   A==;
X-CSE-ConnectionGUID: CLPwnLJuS1a3duOJn8rJnw==
X-CSE-MsgGUID: fxSJ8ScHSWOlrUpXxw9ZAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62046152"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62046152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:46:11 -0700
X-CSE-ConnectionGUID: 2rNX7uIhR72Ef4PSnjgtxA==
X-CSE-MsgGUID: 2iB52CDzS4OYqj8Uc4mvrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152298376"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 01:46:09 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 79BC5332AE;
	Wed, 11 Jun 2025 09:46:08 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 1/3] devlink: add overwrite mask from factory settings
Date: Wed, 11 Jun 2025 11:01:20 +0200
Message-Id: <20250611090122.4312-2-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250611090122.4312-1-konrad.knitter@intel.com>
References: <20250611090122.4312-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain sections of the device flash, containing settings or device
identifying information, may be set by the OEM.

This patch introduce the ability for users to decide whether these
sections should be overwritten with data from the image or retained
from the factory settings.

The new option, DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS, is
intended to be used alongside DEVLINK_FLASH_OVERWRITE_IDENTIFIERS
and/or DEVLINK_FLASH_OVERWRITE_SETTINGS.

This combination allows restoration of data such as MAC addresses set
by the OEM manufacturer, rather than using those found in the image.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 Documentation/networking/devlink/devlink-flash.rst | 3 +++
 include/uapi/linux/devlink.h                       | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-flash.rst b/Documentation/networking/devlink/devlink-flash.rst
index 603e732f00cc..7b04fcb95279 100644
--- a/Documentation/networking/devlink/devlink-flash.rst
+++ b/Documentation/networking/devlink/devlink-flash.rst
@@ -36,6 +36,9 @@ This mask indicates the set of sections which are allowed to be overwritten.
        components being updated with the identifiers found in the provided
        image. This includes MAC addresses, serial IDs, and similar device
        identifiers.
+   * - ``DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS``
+     - Indicates that device shall overwrite settings and identifiers from
+       factory settings section instead of provided image.
 
 Multiple overwrite bits may be combined and requested together. If no bits
 are provided, it is expected that the device only update firmware binaries
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index a5ee0f13740a..b7c4b367df64 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -270,6 +270,7 @@ enum {
 enum devlink_flash_overwrite {
 	DEVLINK_FLASH_OVERWRITE_SETTINGS_BIT,
 	DEVLINK_FLASH_OVERWRITE_IDENTIFIERS_BIT,
+	DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS_BIT,
 
 	__DEVLINK_FLASH_OVERWRITE_MAX_BIT,
 	DEVLINK_FLASH_OVERWRITE_MAX_BIT = __DEVLINK_FLASH_OVERWRITE_MAX_BIT - 1
@@ -277,6 +278,7 @@ enum devlink_flash_overwrite {
 
 #define DEVLINK_FLASH_OVERWRITE_SETTINGS _BITUL(DEVLINK_FLASH_OVERWRITE_SETTINGS_BIT)
 #define DEVLINK_FLASH_OVERWRITE_IDENTIFIERS _BITUL(DEVLINK_FLASH_OVERWRITE_IDENTIFIERS_BIT)
+#define DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS _BITUL(DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS_BIT)
 
 #define DEVLINK_SUPPORTED_FLASH_OVERWRITE_SECTIONS \
 	(_BITUL(__DEVLINK_FLASH_OVERWRITE_MAX_BIT) - 1)
-- 
2.38.1


