Return-Path: <netdev+bounces-230320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6ADBE69B3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE36627799
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED13148A1;
	Fri, 17 Oct 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSwMkwWj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7831280E;
	Fri, 17 Oct 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681464; cv=none; b=ViHweGXV580mT087X1gfiItL+W3ro8zq01BGpahXQ6ZTQNG5GGxPsJwqUURcNrQEbAMoYX/jYv6rZhcuc99u4mI9lS3PUlls9t61op5I/634KEADxwhCi2S+WGPdaYqpjeH/aE1CTPMd6Eo093kuG7DD01WbCx6LF0fVfSwJuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681464; c=relaxed/simple;
	bh=yJCZP9OWnkJe1OZbCdYSF9r9tyYWrtN48qli69wNHC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSL6qEagq7o/VDP2ClQWFPqWMQkMZhYfZcqyJMR1V3YR8aQepDdRQ8IEdCbvql/e7I8HWsCOfCJ5+mz2bryEOMMIId6be1BSoFPxMBBrS5gIfuhUSuWS5pY6LeXD3y7G0z5kD59eVPBBzdrQg2P2J30rT5/g+fxtTAgj4LUC+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSwMkwWj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681460; x=1792217460;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yJCZP9OWnkJe1OZbCdYSF9r9tyYWrtN48qli69wNHC8=;
  b=hSwMkwWjX8UPp3NeTKYLzreUkTDW+Jxe/GJEnDAmtCyGXkFGEyqGhM77
   eCxDTGHcPwDT+wKEPxWkAprl3VC8LCRYMnRmhNnMRkU0h5UbJ2m8C3V4l
   Ic1xfrJ6Ooi62hBPxQ1ukNwKgPGeCfMnuVJ2Wf1TK5AQSmqfJV7gSM9N2
   KsU1OzHxWR+I+yF+AUt0f3jzBXjxzD/l01OkN+ozb5cRiGJPEsNfoWJwc
   h2qOGpgR/5xinetS1bsfXAoApJMYA2/GQxJ40aX/Z/kLOSiUOWHJjqOcD
   O1sLRVr1Rp05lBYxX5whDaJtpBpM4LV3YFvVf6uaP5Qpz4HluQzzmt0Ll
   A==;
X-CSE-ConnectionGUID: ZJLTTzXRTgK8gpYVD9c7Iw==
X-CSE-MsgGUID: jT885KvzSiilH0YAGAe/5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50453978"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50453978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:54 -0700
X-CSE-ConnectionGUID: 33ztjZ6hScC+vcBcO2P75Q==
X-CSE-MsgGUID: IQvrv+JbT5+nvi9eMx/HZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059502"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:54 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:37 -0700
Subject: [PATCH net-next v2 08/14] net: docs: add missing features that can
 have stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-8-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Bmp3U9NiGZXDKGtFyvJZjXX7uiK/LEbc9IDT6Cidn6w=;
 b=kA0DAAoWapZdPm8PKOgByyZiAGjx3ejILBoXWgSsUkCPtv4YzGhHqyV9yAQzm7U91YFuVo5jP
 Ih1BAAWCgAdFiEEIEBUqdczkFYq7EMeapZdPm8PKOgFAmjx3egACgkQapZdPm8PKOg5wwEAgICv
 x0TO4fNmDudPoTxcoLqWU9KhBc0fOkYkgfFq3vEA/A9kJELuO3h5YDDTcYFnxPDuwUrLYTsCUFx
 LY+pbXyEO
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

While trying to figure out ethtool -I | --include-statistics, I noticed
some docs got missed when implementing commit 0e9c127729be ("ethtool:
add interface to read Tx hardware timestamping statistics").

Fix up the docs to match the kernel code, and while there, sort them in
alphabetical order.

Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/networking/statistics.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 518284e287b0..66b0ef941457 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -184,9 +184,11 @@ Protocol-related statistics can be requested in get commands by setting
 the `ETHTOOL_FLAG_STATS` flag in `ETHTOOL_A_HEADER_FLAGS`. Currently
 statistics are supported in the following commands:
 
-  - `ETHTOOL_MSG_PAUSE_GET`
   - `ETHTOOL_MSG_FEC_GET`
+  - `ETHTOOL_MSG_LINKSTATE_GET`
   - `ETHTOOL_MSG_MM_GET`
+  - `ETHTOOL_MSG_PAUSE_GET`
+  - `ETHTOOL_MSG_TSINFO_GET`
 
 debugfs
 -------

-- 
2.51.0.rc1.197.g6d975e95c9d7


