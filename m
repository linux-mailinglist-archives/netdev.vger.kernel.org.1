Return-Path: <netdev+bounces-229743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C48BE0792
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4D93AAE34
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0FB3126A1;
	Wed, 15 Oct 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJKwJ6Zz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281E3115AF;
	Wed, 15 Oct 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556807; cv=none; b=WO50Jd7JvP9wY1TXXRfXDyUW6pu1vP3pB7HL3zK1tCmJY2Ra2DRKQWZkgmL95T3vmLN2VQvRa2Bbnvg0nzPOSlUxINiH2TXudBEQD9+eekipdqGh4gs1Fd7iD3pB5Za03EskULNsu/ftroufPyXh3yriyDRdzrgyva4jCrulWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556807; c=relaxed/simple;
	bh=yJCZP9OWnkJe1OZbCdYSF9r9tyYWrtN48qli69wNHC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I91lxOFW/7RK92W23+3I3STSEq4+c2vtfniQLYAETatcsEgbpSZTtM5YXPQbb0yC+FdyJO7ym03wZtz6AhO9+rhj+yf+2MkX4UL5XIDELm3EgFSIm0UGe7xK8UQ3odzVMr5uU8o8Kvy1RZgtfxHIfrL2DU0zuUnpDJgV4g2iAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJKwJ6Zz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556806; x=1792092806;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yJCZP9OWnkJe1OZbCdYSF9r9tyYWrtN48qli69wNHC8=;
  b=kJKwJ6Zz4vMGbF+Bicop6H+QgVM9W1dIOQU/9MzKhhDb6yEah1LE2THM
   qZT3xGO7oxpg/+OyjLcQTQMqdoJgiK0xuM5S1jexGxEb/eaLVIt6dwfjE
   ckD2PPo+zPmrDYePQsy2DD4bIJeLduZXIP8WT2XJVZyLyB9ujoat4/yz9
   fGZmSirVfJhp4ruoWHyhSTBz3xyC5aD7LavR3LMWNTZYkKoaUSn4onU2+
   5XRsQFZeCW2aeKBuGQUv+fJRNRwx/rG6v74WF510dIPjkR6/Kb7nscjRI
   wpGUzvDpV7rlXuh0F0T968/FuurXbSs3FgOg0syoTjHlYbli597vCnPl5
   g==;
X-CSE-ConnectionGUID: o5aQ8nrGTVOEQ+i3tnf86w==
X-CSE-MsgGUID: 3QUxpBrPRu+exZoKuQ+NIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74083529"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74083529"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:15 -0700
X-CSE-ConnectionGUID: Fq0lrg96SbatawPa5hNJlw==
X-CSE-MsgGUID: fxgbbfmyTx+n49kM11V/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182044895"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:33:14 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 15 Oct 2025 12:32:04 -0700
Subject: [PATCH net-next 08/14] net: docs: add missing features that can
 have stats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-jk-iwl-next-2025-10-15-v1-8-79c70b9ddab8@intel.com>
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
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Bmp3U9NiGZXDKGtFyvJZjXX7uiK/LEbc9IDT6Cidn6w=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoz3376v/C59+NL6mujuKpbys6+Scrx3XnovfXf935Mro
 4u6U+bwdpSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRfXyMDP9fnXHn7K3z77oR
 tH4y0zrGdsaZUm+miX9sWOWkq93WeI7hf0lA0/atn9bPS9CXmW5/RjRzohXL6yvJfcxBc/ezmt7
 x4gMA
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


