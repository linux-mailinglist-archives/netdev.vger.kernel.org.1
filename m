Return-Path: <netdev+bounces-211375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C63B1868F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5798D1C838E8
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2311271443;
	Fri,  1 Aug 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHffcs8F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91B222580
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068973; cv=none; b=TlXXXpK+j8IshrSt1GJwq7kgygh05CDExnyk9i+KXlM9Qr7aqHRHeo68TaFQyJiNUZaz/Z0vgBdXGNbvVh/NLhNzFaiUBaL+yt5F6sQxn5luLnowmGk931FZqP+uI8wQx/e5fG2NuOwDbYVxQA2yuP/ox7cREiNww5zemyqiE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068973; c=relaxed/simple;
	bh=O+cdPjij477Nr7pjwhV0+qgbrCpJf8aEWR+DX8FrlNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMGCDQqwTYmghHvfgsrXnUxmuRLNAxNtvqq6XmU7FYneDvhUC1nJXZ2aFzH3323TJVcCk6UCJUZ8eZMf0koOIjJHfiPIUYp5T1jF/HhI56xmIk44S1jUBAOYB2B0AGRbd9egekCPXOnypO3+v6tP+Ln9bKOBOzaSzmlHA8GaiGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHffcs8F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754068972; x=1785604972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+cdPjij477Nr7pjwhV0+qgbrCpJf8aEWR+DX8FrlNE=;
  b=ZHffcs8FsJTu1lI3HNvzmJ/0iWpsSL0d3uswv0IezGXBW5Wk5zkVERMw
   1zZeEMM4cr/YR+ETUWswC3tQMD84ex2e/47w1PnsGswc1sfwxaiDYrmct
   b7lbiWTyStbf0rJUON37HtBLBba7XjbCL+TGW3DJELWeiNxbqxvcMX8mu
   HDVOaHXSCoOcpJ71RH/W9wxFTpPcGuza8Xnx+cox0FS1kfRGKE2ei0AWL
   ZoANCuVG4sZsC6dnXvmieEFoPi+TkYb+/LCuMFvs39kJZbXxdgef7FxTd
   xpA6+KJcKpPqGmjtUa4yceWgMNrAZMq/HbLYEP2IgrTDMf9cfVn7f0DTg
   A==;
X-CSE-ConnectionGUID: h5FbxfQpRBy4sE1NRS1kHQ==
X-CSE-MsgGUID: 8ZXnlALRROyeXrcgnzujnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="59044384"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="59044384"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:22:50 -0700
X-CSE-ConnectionGUID: kbzas0WjQJCJlqIT+GCoBw==
X-CSE-MsgGUID: NSdHUsSoTrOr6KSA+K/m2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168915246"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 01 Aug 2025 10:22:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 1/2] devlink: allow driver to freely name interfaces
Date: Fri,  1 Aug 2025 10:22:37 -0700
Message-ID: <20250801172240.3105730-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
References: <20250801172240.3105730-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Currently when adding devlink port it is prohibited to let a driver name
an interface on its own. In some scenarios it would not be preferable to
provide such limitation, eg some compatibility purposes.

Add flag skip_phys_port_name_get to devlink_port_attrs struct which
indicates if devlink should not alter name of interface.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h | 7 ++++++-
 net/devlink/port.c    | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..bfa795bf9998 100644
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
2.47.1


