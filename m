Return-Path: <netdev+bounces-57877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59474814629
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FDE28597A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D21C2A8;
	Fri, 15 Dec 2023 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfZD7M4E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078E241FB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702638223; x=1734174223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ifBqiRbZSFJIDtKEP14esPwUo7A2NcTv92fXWwVO+E8=;
  b=UfZD7M4EZdrl6nUloraDzcgfSOeaYl9jZwmZV7KWt1HcmQvrtAjLY+YP
   qxRGRDjhDXKdfthdw0VpAgsabRtlRkj7uoOHBnGuZmNRgj7ZB7g013ZBV
   /Al0SpGvKN9XPUfaiAFnRCzn+kjo1MDUkpW+XDyBx7rPrdR1p9TPMXpZf
   yT1AFfS/BNHkd2CveOT0T2XXFLMLuwPep+OHdd7DWAPhC8+1CVafmlV6h
   PWjHy5w1lUcNGuGNc+kGKn/IdS+3mZ23+SPFZVN3iHPSYY6Sh1xRoPprE
   v/apeZzbSbYIjTd2h13cSvNloy1pP66RipbBGJr95aMoNRCSTHIPiwPUC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385679105"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385679105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:03:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918408307"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="918408307"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2023 03:03:42 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 60C7B39C82;
	Fri, 15 Dec 2023 11:03:41 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 0/2] Fixes for link-down-on-close flag
Date: Fri, 15 Dec 2023 12:01:55 +0100
Message-Id: <20231215110157.296923-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small series of fixes for link-down-on-close ethtool flag usecase.

Katarzyna Wieczerzycka (1):
  ice: Fix link_down_on_close message

Ngai-Mint Kwan (1):
  ice: Shut down VSI with "link-down-on-close" enabled

 drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.40.1


