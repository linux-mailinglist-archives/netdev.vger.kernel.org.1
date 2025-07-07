Return-Path: <netdev+bounces-204511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0AAFAF57
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C423B17F4D9
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C428C85B;
	Mon,  7 Jul 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWbKy5/m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FD2A1BA
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879696; cv=none; b=aXGRYfoatV47WpSHo7UIOPeKjAGFp8yqZ7sCa0bC2IoZug+zlMMWlWsI8kDPEnhgt4i0xIRWmwb7J5VOYuusi8M3BSX3vXn0Tg9/c9I1/NfIYihawDg9+BvofZM0EuU2uC80GCEr4g30PUEN896NTEbOBUHOl/dIYkUlqvEQVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879696; c=relaxed/simple;
	bh=86jbnWjsFrfyIh+jJs4CKjLVgJRfSWiYlFK4OCBp3sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nkQPayN/aPKMoiFzkiG/dVFgKva8TsHALJhPL0tYHsPfpRSU63ps6w+LXQ0BUPKc71vx8KYQc69P3Zum8YbbCWxNZmgQ9qJYpYsDGeNIA1RWEXAUUVW0UCSiSdIv8N1sZb8wvXdlW2Be2DD8uvagAB1yxwKfMD8/g1h546g4c7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWbKy5/m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751879694; x=1783415694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=86jbnWjsFrfyIh+jJs4CKjLVgJRfSWiYlFK4OCBp3sk=;
  b=eWbKy5/mNAjHuR2TlYWehQwXQZUy+CCGtuILVloh17S6+fb0Jw+R6uXX
   MfapXKtr48ba+Zuk+TdzT8q+ML9o3FBK0Cx7+tuGfkxf4z3le7ni6C0E6
   8NRJ11IC+LVvvWt7DSAWx+1zill1dU5UsoNvAKJMh6GqlnsaW15aryerl
   214DlsJzr6n0X97tqrj8wQaxDl7TF/Kf9Y/sxhdD+1BPuuP5O7VUMvyQE
   xEPQVvqvjCx7ycTOqRpDLoI+WB/V8wOxVTjF5LpE61p/rnxU7D3wDqCzv
   gf20l3oFEjWK5tXB0rHRhpis6YUdTwduzzzy7MhePjFQnIvt0+fuiQkkT
   w==;
X-CSE-ConnectionGUID: bJInxNgARJ+42FYFM+bTtw==
X-CSE-MsgGUID: pKw7kdpETT6Q99l3afmXZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="57897098"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="57897098"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 02:14:54 -0700
X-CSE-ConnectionGUID: D1hSd1KqSsyPbzd4ucoQSA==
X-CSE-MsgGUID: oJwViJ0XTbuGe/IHjBdqnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154578647"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 07 Jul 2025 02:14:51 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	dhowells@redhat.com,
	David.Kaplan@amd.com,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-net v2 1/2] devlink: allow driver to freely name interfaces
Date: Mon,  7 Jul 2025 10:58:36 +0200
Message-Id: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when adding devlink port it is prohibited to let
a driver name an interface on its own. In some scenarios
it would not be preferable to provide such limitation,
eg some compatibility purposes.

Add flag skip_phys_port_name_get to devlink_port_attrs struct
which indicates if devlink should not alter name of interface.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: add skip_phys_port_name_get flag to skip changing if name
---
 include/net/devlink.h | 7 ++++++-
 net/devlink/port.c    | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0091f23a40f7..414ae25de897 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -78,6 +78,7 @@ struct devlink_port_pci_sf_attrs {
  * @flavour: flavour of the port
  * @split: indicates if this is split port
  * @splittable: indicates if the port can be split.
+ * @skip_phys_port_name_get: if set devlink doesn't alter interface name
  * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
  * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
  * @phys: physical port attributes
@@ -87,7 +88,11 @@ struct devlink_port_pci_sf_attrs {
  */
 struct devlink_port_attrs {
 	u8 split:1,
-	   splittable:1;
+	   splittable:1,
+	   skip_phys_port_name_get:1; /* This is for compatibility only,
+				       * newly added driver/port instance
+				       * should never set this.
+				       */
 	u32 lanes;
 	enum devlink_port_flavour flavour;
 	struct netdev_phys_item_id switch_id;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..bf52c8a57992 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1522,6 +1522,9 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 	if (!devlink_port->attrs_set)
 		return -EOPNOTSUPP;
 
+	if (devlink_port->attrs.skip_phys_port_name_get)
+		return 0;
+
 	switch (attrs->flavour) {
 	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
 		if (devlink_port->linecard)
-- 
2.31.1


