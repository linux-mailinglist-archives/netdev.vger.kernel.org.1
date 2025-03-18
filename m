Return-Path: <netdev+bounces-175882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC123A67DAC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E7A3B6E15
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145152135A5;
	Tue, 18 Mar 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wu8ddNeE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CD20468F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328325; cv=none; b=sn8PwAHGhFOAbaopj2ktH4R/UG9d46ZYjB0JKG/knCyC4tqe1QtoYx1RpFZet1GU8GdLA84PSESfBIYoyUx/mr7uI80tpoTm9iba1tJ9x8eoem2Smm9kIcxKjQTXfP1Hj9neffwGYBFT33SkP4oOJ8MpUWXt0ihy6dYoPGeH0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328325; c=relaxed/simple;
	bh=1WqwqIOGWYmr7zEri+X5r+ddtzpl2wbOreTgxZ3AHas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOg9vZJ1QkVnpWuTjGpzvjm51lxm0GM43j6Mr8gttPdH1l67xsY3mMWFUFl3kgJz4ZrYHZJpjzki35fBflBbvJvJlfmwr4jf0I+xNPkOQAbDBesEDfaF0NPKTR0VWr/IFQOSJOpJHZQFd8odfUAQIlqli7LU+g+pQlpWVUZPw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wu8ddNeE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328324; x=1773864324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WqwqIOGWYmr7zEri+X5r+ddtzpl2wbOreTgxZ3AHas=;
  b=Wu8ddNeEuZZRXRF53LfImmPIybkSUR5l2Ex1Z393iRFv3zCXAz4tZect
   eaPKF797jvFfxMPvRK6Vj1zHF1f3ggEl6xmVfyBhx2Itn2txnjM87rr6k
   omM+CZo4UBTbYsSb5QaWbmY2yjFtP30uhmbNCsm/fi0HkmH2+ZEBFrb2T
   LsmW7/8objjQQyXiKg4rYeLxB8x3hosRRDIwlMyKQL3cHjrDMOVzF/tqd
   euGj99dsTD7Yhidq6DQ7pwTz6YXclU9x/4m1OdON6nLpDr7aMKWRz0k1j
   joDZgVPZEpZ5YNKOIzLTMgWeWBA2lkpiM18mvFY9KQ4t27GuxHEBwiOs9
   A==;
X-CSE-ConnectionGUID: jJstnkf7To69b/znMEHbPQ==
X-CSE-MsgGUID: Pd3RIdiKR9O9gdQNzT8Qkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593034"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593034"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:20 -0700
X-CSE-ConnectionGUID: 7CGTMaGiQhaBlunkCi/R0w==
X-CSE-MsgGUID: 3v/9n1HMRrO2oO+cmWXGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363137"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jan Glaza <jan.glaza@intel.com>,
	anthony.l.nguyen@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/9] virtchnl: make proto and filter action count unsigned
Date: Tue, 18 Mar 2025 13:04:48 -0700
Message-ID: <20250318200511.2958251-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

The count field in virtchnl_proto_hdrs and virtchnl_filter_action_set
should never be negative while still being valid. Changing it from
int to u32 ensures proper handling of values in virtchnl messages in
driverrs and prevents unintended behavior.
In its current signed form, a negative count does not trigger
an error in ice driver but instead results in it being treated as 0.
This can lead to unexpected outcomes when processing messages.
By using u32, any invalid values will correctly trigger -EINVAL,
making error detection more robust.

Fixes: 1f7ea1cd6a374 ("ice: Enable FDIR Configure for AVF")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/linux/avf/virtchnl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 13a11f3c09b8..aca06f300f83 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -1283,7 +1283,7 @@ struct virtchnl_proto_hdrs {
 	 * 2 - from the second inner layer
 	 * ....
 	 **/
-	int count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
+	u32 count; /* the proto layers must < VIRTCHNL_MAX_NUM_PROTO_HDRS */
 	union {
 		struct virtchnl_proto_hdr
 			proto_hdr[VIRTCHNL_MAX_NUM_PROTO_HDRS];
@@ -1335,7 +1335,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(36, virtchnl_filter_action);
 
 struct virtchnl_filter_action_set {
 	/* action number must be less then VIRTCHNL_MAX_NUM_ACTIONS */
-	int count;
+	u32 count;
 	struct virtchnl_filter_action actions[VIRTCHNL_MAX_NUM_ACTIONS];
 };
 
-- 
2.47.1


