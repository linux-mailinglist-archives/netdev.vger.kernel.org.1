Return-Path: <netdev+bounces-229741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAFBE074D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEDF7358146
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE33115AD;
	Wed, 15 Oct 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCCV0La8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5C30BB99;
	Wed, 15 Oct 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556805; cv=none; b=pVjlfzyhSttIFY/WjUo19+BvxkVgv3gcKfdWwWhO/r3Q/xRibBtecKStbeFaZpzBaHk6JsaWTQ/0ae0aMtyrGaigtDYQ9l7mqb4jkxwwrV8nHLCDTiQxk4Z1s/KIxnwuo6qphWD3zCae4mI+Z5GyBs5iL+QOup/z4qHfkexPKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556805; c=relaxed/simple;
	bh=1S8oGspI95G1x09C/Ign9dmKxuBXrkyXu1Cqhf8xqF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O72CyT673Cepy583k9SgYRE9s8C2BRKpuKx+RM+AcQ3Hx0a0AaNKmmL8G4j31Z+62eQE5le7G4As5VArzKNLWIVTW0K8bAFagBz/0dFNpFfJntzetVfbVYWBs3Q08Xu/xxkPZ6hdcYXoYsyzwIYHXaiIWQekKb2OiNvdfhXn+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCCV0La8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556796; x=1792092796;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1S8oGspI95G1x09C/Ign9dmKxuBXrkyXu1Cqhf8xqF0=;
  b=GCCV0La8R9XjrCqbm+8VLSLtVQl+HzCYylvwKr6lk8H/vKOiSZh+vIyX
   vN6NKeKWQMbUJpckEhPYiVZY5gxXOwlKxxqmmgYLVOT0H4opX3KBYB4FE
   GReXtDuiBEt0PYG8GPsGjT/etO22Hq/tkUslvv2BGv7IehnB/2agG2fKn
   rzpVBNCnIK0A/im2qAGaHAFhapKv8ve+/2Xeu20meiPpTg9MQPdrUYqkf
   rvMSBwyXYrr9I7M44d3ptTEbLM0lakgVFqxKunQNoLrbAaath5lJhbY76
   LxqOK8f7QwEf7gkX3q6s+9mPfVLB+IaMuBp60aXxiMv0TVoENpsqVk2A/
   w==;
X-CSE-ConnectionGUID: 8gI+vLygQwq7FXTzXlLscg==
X-CSE-MsgGUID: rCKD5ZjkSoOZsMEtR59lAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083469"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083469"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:14 -0700
X-CSE-ConnectionGUID: UxfR9vNFRIaHU5X/XIkqMw==
X-CSE-MsgGUID: +ZVJgb6TT0+52HXewe/iuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044869"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:13 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:31:57 -0700
Subject: [PATCH net-next 01/14] devlink: Add new "max_mac_per_vf" generic
 device param
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-1-79c70b9ddab8@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
In-Reply-To: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Mohammad Heib <mheib@redhat.com>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=zAPsi0PcTqjXPt4eBr5ahPf0TWS+g8Ij/TLDr5ZJ5aQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3377Gd33fHprD9KtvRuuHl3feOd81OnCa896/yE2Hb
 aSnvZgT0lHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBEok8z/LOYJ3KMbbZA3+as
 uzLB4YYCD3ay3/ox8c7/nW91rQzSP69n+O8x+XCF0Vcj7fdiDxSZWTgSN/hOZkg/vWDtpeP+E6p
 V2xgA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Mohammad Heib <mheib@redhat.com>

Add a new device generic parameter to controls the maximum
number of MAC filters allowed per VF.

For example, to limit a VF to 3 MAC addresses:
 $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
        value 3 \
        cmode runtime

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9e824f61e40f..d01046ef0577 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -532,6 +532,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -602,6 +603,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME "num_doorbells"
 #define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
+#define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 70e69523412c..6b233b13b69a 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -112,6 +112,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 0a9c20d70122..c0597d456641 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -151,3 +151,7 @@ own name.
    * - ``num_doorbells``
      - u32
      - Controls the number of doorbells used by the device.
+   * - ``max_mac_per_vf``
+     - u32
+     - Controls the maximum number of MAC address filters that can be assigned
+       to a Virtual Function (VF).

-- 
2.51.0.rc1.197.g6d975e95c9d7


