Return-Path: <netdev+bounces-176079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEFCA68A69
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59771B60034
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A9254AE9;
	Wed, 19 Mar 2025 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GULJDtOp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461225486D;
	Wed, 19 Mar 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381902; cv=none; b=djoE+fPtcFs4u3ri2vi9JF7HzRP3h1gTehTAPlxMKjHBUmhDXYE0dAqNaIlhXYgNrCIgxYxan85OpvD9k7II0cu29y8tWGe1aUB/wVn6ZRch04Fs0BwpLfxf72iD/zYmtx3EFTH0pnSXFW5jIL5D91phzHqnOg14LTFnoKys/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381902; c=relaxed/simple;
	bh=+/dmn4mx7IxUfx7QV05ZUkDLqZfdlNNkCGP3sHxaKow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mf4j9+EypWYHHdTu01Vq8WYNrqvJHyI8jMzfCZgTB4F25JCYniAyQKQiOE2fQxOr1WRnaam3kr7eLO07PykPq8HJTvNF2ubiORdvvbIQO8UDsetijRNM0njA+r69AHAdNta7vcahyDc2dFbqCUZeCET7hl73wPXMACWvUAlmKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GULJDtOp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742381901; x=1773917901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/dmn4mx7IxUfx7QV05ZUkDLqZfdlNNkCGP3sHxaKow=;
  b=GULJDtOpDSp+QAKy2j14CnFnozTWUfh1xIdW7PyuswN9KEETNSAuqddI
   zrx/zGdpiRQfe36Uj3Od4lLPm3MlSj4Bf8CGQ+QpFtnU36tWeft2FXQY9
   YYiHe2gfM3tAR67Yqsv+tuubg+oTrRBQo+Aa9BEwo7K8zF1qimoAUnkap
   4xdga0h4ZKYonggcjzU4XRaUjtRpYx/vpMCdYF9xwvXoVSuNUdq29xK7k
   jRljXnrfe4mZuX6WkvMKQZK1fP/FNPuKhkpKCOrPnCZMcX5LNRUPChBjC
   OyfhZpxVICFVRmR8H7Ml2oFScoFUnGZAEKjVcyJpZBnduEf1NVDddhXR0
   A==;
X-CSE-ConnectionGUID: eYA9ZJFRTJ2PnSRWErAkRQ==
X-CSE-MsgGUID: pEnrinHfQES9KcNDLAUXCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43296772"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43296772"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 03:58:20 -0700
X-CSE-ConnectionGUID: EAqeZCr3TaWb1FiRLi13FA==
X-CSE-MsgGUID: /COVgeKMSYqBBD8whJB9Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122593881"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2025 03:58:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 88BAB165; Wed, 19 Mar 2025 12:58:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v2 0/2] net: phy: Fix potential string cut when using PHY_ID_FMT
Date: Wed, 19 Mar 2025 12:54:32 +0200
Message-ID: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The agreement and also PHY_MAX_ADDR limit suggests that the PHY id can't occupy
more than 2 hex digits. In some cases GCC complains about potential string cut.
Avoid that by limiting specifier to print only 2 hex digits (patch 1).
With that, fix the ASIX driver that triggers GCC and use agreed + 3 in the size
of the phy_name (patch 2).

In v2:
- added first patch
- added a conditional to the ASIX driver (Andrew)

Andy Shevchenko (2):
  net: phy: Fix formatting specifier to avoid potential string cuts
  net: usb: asix: ax88772: Increase phy_name size

 drivers/net/usb/ax88172a.c | 9 ++++++---
 include/linux/phy.h        | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.47.2


