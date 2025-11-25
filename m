Return-Path: <netdev+bounces-241691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D8C875B7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 689B04ECCCA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224133DEC0;
	Tue, 25 Nov 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbFmJwYD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D133B6D8
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110209; cv=none; b=KYmKVPthluUCsQiJEdi3ahvHLz7pPiB+t/Tl8z0+4FJKIEcJryU/Ruy0TmTrAOZ6hmjKxPLE8fQlC5mV8O/XAdwWRmUmVFy50VBp7hHS0UZY61Lgi46OydoAL7U++EmcGjj7cpD6naBMOvCMnuykJ9+LfPLBHori/rqjgVpfOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110209; c=relaxed/simple;
	bh=aDXmeEM0FSJQm1dg5yPoiTto1AEQX/jJkvIaN5d2aX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GscwNN8ryeaBvv74t1gEiyTX0eEiaFWn6IrEYR2lJHU1a0+4pI4OlUYTYFmpFDOn0KHh1fUAOx8sSh8YZsCRg3OrNQmjeeQ2QBTqiMAPui+roIZn1NbyizgnWpBSIOsSEWXL5+kjRGlHKjLcf8GQ65hfZa3B+fapse3CJ/nCbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbFmJwYD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110208; x=1795646208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDXmeEM0FSJQm1dg5yPoiTto1AEQX/jJkvIaN5d2aX4=;
  b=kbFmJwYD7w2f/bZaWyFycgp/N5IcBR1bFuciUTm9i9UoD7Euew3RN3Yc
   QIxFIc6fP8DK0keCyXqCP+l2MPEDlS6FleM+pzpevGOoSEhAIfiypO/Fb
   33YF1KDGoR9gr4lHUxuhehlwgs/suiqMUqlz9auLIItFBcqcvv74W8UAb
   lE/BH5PiSOGvT3IhTO0PrynaKru1G6UFrTSQIbThrR6M5zXn2Ws/KQijv
   eogAjn/9o9jxJbWUgk8MFEJzypEQJI4yr4Q8QAyAyS7dirBofB9f3JOXs
   SF5cPVA2QyIAJ+ueCncq5OLfaGySLMeiT3bGxMndAb+Doo5/MTgY7sTvX
   Q==;
X-CSE-ConnectionGUID: RExfuh0ASt6MB6Zd7LeVVA==
X-CSE-MsgGUID: u7MvKfasRDS81pBbSJhN1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729927"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729927"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:43 -0800
X-CSE-ConnectionGUID: P4Jc1jT1S6qJwLhX8AGXxQ==
X-CSE-MsgGUID: Ivd48mmiQYGSwOvk07xSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209573"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	alok.a.tiwarilinux@gmail.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 10/11] ice: fix comment typo and correct module format string
Date: Tue, 25 Nov 2025 14:36:29 -0800
Message-ID: <20251125223632.1857532-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

- Fix a typo in the ice_fdir_has_frag() kernel-doc comment ("is" -> "if")

- Correct the NVM erase error message format string from "0x02%x" to
  "0x%02x" so the module value is printed correctly.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c      | 2 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 26b357c0ae15..b29fbdec9442 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1121,7 +1121,7 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
  * ice_fdir_has_frag - does flow type have 2 ptypes
  * @flow: flow ptype
  *
- * returns true is there is a fragment packet for this ptype
+ * Return: true if there is a fragment packet for this ptype
  */
 bool ice_fdir_has_frag(enum ice_fltr_ptype flow)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index d86db081579f..973a13d3d92a 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -534,7 +534,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 	}
 
 	if (completion_retval) {
-		dev_err(dev, "Firmware failed to erase %s (module 0x02%x), aq_err %s\n",
+		dev_err(dev, "Firmware failed to erase %s (module 0x%02x), aq_err %s\n",
 			component, module,
 			libie_aq_str((enum libie_aq_err)completion_retval));
 		NL_SET_ERR_MSG_MOD(extack, "Firmware failed to erase flash");
-- 
2.47.1


