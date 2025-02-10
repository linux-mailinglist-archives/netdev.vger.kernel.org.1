Return-Path: <netdev+bounces-164895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E89A2F891
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A4168FEC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE12586D2;
	Mon, 10 Feb 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfZaHLmD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756BD25742A
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215449; cv=none; b=ENbexmEYKRELRM6Qf0pRg5xxhmSFChDNz1JupFq7TgCTHufunXMwm8/XBm7yJEK4hWf1UsXydgTxz7en4hNAvdWvQsOWmFkAADGjMgC5R0MGp+wGeUk4h9oSIA66fHPNtdCWdTziv9JOJxFfzm1LUDEwRsIXrVETYRnf5BY6U2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215449; c=relaxed/simple;
	bh=Wm/op+FRH7z6WMPluF8VZFCEItvhqsZm3tpeM1FjYMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK9Ao/qXTirylv3cByaUSqD4ZMB82QXsl00dAXq4EjvoIHDqH5WwZRlfZcQWjFY5TfQEtDaVPpS0irD7N/CMSQN77lXshCi2KWPzZCvXympEyDi842p5H/SB79UMVhGZpT3fm1SG3rUBvWrTW9s6TBnsuPEvSHvxJ+2X4TblY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfZaHLmD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215447; x=1770751447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wm/op+FRH7z6WMPluF8VZFCEItvhqsZm3tpeM1FjYMU=;
  b=RfZaHLmDqXNcpwiINjPO2ffBUaCcnAAnFnVuiLLeHDPD3gxn8q3XgZhL
   kvVfLMhThvp55VHy1+nT7xDlTWYpfka36TaGy4/fIkvPvLTmpooKFP+P3
   DqymzdCv0t+ZZZBxnRcfXKqV3Kq//Jzu/9RDlrA/KiyGxFNeZLRAwceA+
   7I8wKBzgEcU56RdRQWNIEvaSfVGVyl4bJEYRNuJMG7qkKgQoNofsMcvHf
   uG2p05JQzEuuIbb3Io0pfJi9dYIOaOtGg8/rSudEECjUCU9XAEQHbb3fA
   R/IITJo5JoGre5WhzzvEgJtDGKy/OvTsl3/cWWGiopfj2R3qra6PU4x4s
   A==;
X-CSE-ConnectionGUID: 5wThqESnRjSwqfF/iWcNIg==
X-CSE-MsgGUID: S/YugGTER2Oqc7tow/w3/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929257"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:02 -0800
X-CSE-ConnectionGUID: 5NJdZ6CETmCp7bxKnz7JZg==
X-CSE-MsgGUID: aJby2XYOQZ6KWcJtauOukQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733884"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 08/10] ice: refactor ice_fdir_create_dflt_rules() function
Date: Mon, 10 Feb 2025 11:23:46 -0800
Message-ID: <20250210192352.3799673-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
References: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

The Flow Director function ice_fdir_create_dflt_rules() calls few
times function ice_create_init_fdir_rule() each time with different
enum ice_fltr_ptype parameter. Next step is to return error code if
error occurred.

Change the code to store all necessary default rules in constant array
and call ice_create_init_fdir_rule() in the loop. It makes it easy to
extend the list of default rules in the future, without the need of
duplicate code more and more.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index ee9862ddfe15..1d118171de37 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1605,22 +1605,19 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
  */
 int ice_fdir_create_dflt_rules(struct ice_pf *pf)
 {
+	const enum ice_fltr_ptype dflt_rules[] = {
+		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
+		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
+	};
 	int err;
 
 	/* Create perfect TCP and UDP rules in hardware. */
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV4_TCP);
-	if (err)
-		return err;
-
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV4_UDP);
-	if (err)
-		return err;
+	for (int i = 0; i < ARRAY_SIZE(dflt_rules); i++) {
+		err = ice_create_init_fdir_rule(pf, dflt_rules[i]);
 
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV6_TCP);
-	if (err)
-		return err;
-
-	err = ice_create_init_fdir_rule(pf, ICE_FLTR_PTYPE_NONF_IPV6_UDP);
+		if (err)
+			break;
+	}
 
 	return err;
 }
-- 
2.47.1


