Return-Path: <netdev+bounces-84379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F0896C2B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E2D1C21272
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872F1369B4;
	Wed,  3 Apr 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNcKVprs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CD13699E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139859; cv=none; b=SOGxuwfjeEV0iF8mC2iBHHgXHeCb+JQnjNUsb5wsaVFn3OfN95NrwjaZy3o+eaioj1vX9AGMtvvueoSbdSxJwviXuwpOYVd2buO4P1v655gdurW0+6MOzxbFryQyt45a6HqhaypC4GPCUA1msOeSR7VqZCDKuC33JxYfztKobL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139859; c=relaxed/simple;
	bh=bDyQv83waGmDhEPH2TjePdRLXfCa+ls3xnXd1RRn1IM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=daQ9Lith3nEKdUFQRuSQcs9JEGxBpzT1QkPfrVV06KPexMS8BdXZ3/aNLCgy+BODnAjxronnwCknkKuV6BPJDRZVpXTYYYLh0n6Ma6xEEz5Cr2eZ4S4hHBZnJbTvEfwwhGGi83PbMVN9z5yYKb1bSqw29n1ObgBu+Np6ADkUSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNcKVprs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712139858; x=1743675858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bDyQv83waGmDhEPH2TjePdRLXfCa+ls3xnXd1RRn1IM=;
  b=HNcKVprsm2bK6twN0L3QZiXUP5dCBSPyBP4JnAJqEYE5tbSJ4/mWiEQo
   8UDgTh0n1F38RkiBdEI9bhC5IQLZH82s1sjvDzcoxQEj0NDK44+cE1Gfc
   XvMvEc5w/YvjbjIgBko3n/mqHgEBfro0VnP8/x508/LUI8O+gcObbo7BC
   QP4RGRe5OjKNGeDwyeDbBc/cW9nbBb/y1jR6iTEoNxMAx2ibnUWWTR2Nv
   H9ECTjvnPVCe3hqCKAj4b/EiZb8PrES+r0eLR0FfrEPM0ctoAQN3kcp4Q
   cYjjMeheyJjb31mqD9zj7htFmEin3YNo6O3nPuAmNVqESvLCvSi54e+Ck
   A==;
X-CSE-ConnectionGUID: QlpsvC/+TEmWegOdQWRuVg==
X-CSE-MsgGUID: 8A5kRpOxRNumt58DOR7wiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7282809"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7282809"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:24:17 -0700
X-CSE-ConnectionGUID: H03ZWuT1Q0Kg7ULmUVF1Wg==
X-CSE-MsgGUID: B5q4JpETSvOkl2fpXzLGSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18292405"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 03:24:15 -0700
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.245.83.30])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A6AA6369EC;
	Wed,  3 Apr 2024 11:24:13 +0100 (IST)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v8 0/2] ice: Support flow director ether type filters
Date: Wed,  3 Apr 2024 12:24:00 +0200
Message-Id: <20240403102402.20144-1-lukasz.plachno@intel.com>
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

v8: Added check for vlan-etype when proto and vlan are specified,
    vlan-etype is required by HW
v7: removed 0 initialization of static const array (omitted by error in v6)
v6: removed ice_fdir_eth and reused ethhdr, removed 0 initialization
    of static const array
v5: added missing documentation for parameter introduced in V4,
    extended commit message for patch adding flow-type ether rules support
v4: added warning explaining that masks other than broadcast and unicast
    are not supported, added check for empty filters
v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 138 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 111 ++++++++------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 208 insertions(+), 47 deletions(-)


base-commit: b1f81b9a535b48b2c9ca460720a2bc73fd2001de
-- 
2.34.1


