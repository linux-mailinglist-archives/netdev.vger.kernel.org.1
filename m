Return-Path: <netdev+bounces-54841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B5F80884E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FBF1F21FCA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D203D0B8;
	Thu,  7 Dec 2023 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHdg1Wpk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85011F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701953336; x=1733489336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PypshdJBiWJ8UuGO1KeStpKR9p6uxObiG6BXtzxh8Xw=;
  b=mHdg1WpkzgXPb3hHXlmsjkyLoW1AfwT5UQORRzD0kJYkvTJydSPqivVs
   r1TD+Ns5VLJItePCGqIEiw+Deymy7/H1HqPD6LSSzq1QpG4BAVaLs6nmj
   yQPIXL+W1mW6tvdtXHbd1GGNqVqgPMjlvl3GhranKy7VFtIn/SB6R6bJc
   00nDui22QpzCayMzxMOoYbd2qckeyc4LPKTTo0QiIu27HXa7QhgGnRKW3
   UbmwM0vU0KLafwSdscxEPdYcwcDhy9CBAXGnBZvbnarTeJDii0uM28Mur
   gPeuglqXsTn9vaeEjVpPEQzIIG5UxJg/IIaZ+k4rLfLoUAlK7eTphZrEW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="397015133"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="397015133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:48:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="837704127"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="837704127"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2023 04:48:54 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.249.158.92])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 211C233EBF;
	Thu,  7 Dec 2023 12:48:53 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v2 0/2] ice: Support flow director ether type filters
Date: Thu,  7 Dec 2023 13:48:37 +0100
Message-Id: <20231207124838.29915-1-lukasz.plachno@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ethtool allows creating rules with type=ether, add support for such
filters in ice driver.
Patch 1 allows extending ice_fdir_comp_rules() with handling additional
type of filters.

v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 126 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 204 insertions(+), 46 deletions(-)

-- 
2.34.1


