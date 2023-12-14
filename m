Return-Path: <netdev+bounces-57340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36E1812E7A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EEA1F2151F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB803FB24;
	Thu, 14 Dec 2023 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2kFqja5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC3BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702553104; x=1734089104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qWNU/qKUCy72Z2wZf+28srtB/TxNz/lfvuv54u997mQ=;
  b=d2kFqja5/RiiyqBrm/Pmmg0ea7IWV4KZR3GcitANazU4FaAHE8TWSvCY
   /im13/T96hUViPLGoAE1/SEnn2lVuYD67cQd0jg899KRpH3ccQQUD5DPr
   lcNC5XKMRTavvnfuMAsJ12xE5P+tSYBP72mMP3nRSj0Y0CeKHZPqnfdBs
   skXuVqaTrdmCBApWIy4c/wn7wIu/dOAKmVkYV308/YsmSmjby5eg1gPgC
   04pmedXbmOiJ7guF7fq2OkB0t/z3mZdV4lKOcrABwFjlsnV/nea3772Us
   FZblM6R3iSFVCxddI+x/QxKzCU6meGArqAZEEKMkHCB5NFrypJfFX7y9v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393977386"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="393977386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750503271"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="750503271"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 03:25:02 -0800
Received: from lplachno-mobl.ger.corp.intel.com (lplachno-mobl.ger.corp.intel.com [10.249.145.51])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2D0313A3C8;
	Thu, 14 Dec 2023 11:25:01 +0000 (GMT)
From: Lukasz Plachno <lukasz.plachno@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Lukasz Plachno <lukasz.plachno@intel.com>
Subject: [PATCH iwl-next v3 0/2] ice: Support flow director ether type filters
Date: Thu, 14 Dec 2023 05:34:47 +0100
Message-Id: <20231214043449.15835-1-lukasz.plachno@intel.com>
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

v3: fixed possible use of uninitialized variable "perfect_filter"
v2: fixed compilation warning by moving default: case between commits

Jakub Buchocki (1):
  ice: Implement 'flow-type ether' rules

Lukasz Plachno (1):
  ice: Remove unnecessary argument from ice_fdir_comp_rules()

 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 128 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 112 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 205 insertions(+), 47 deletions(-)

-- 
2.34.1


