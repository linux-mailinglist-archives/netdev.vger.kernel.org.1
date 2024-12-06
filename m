Return-Path: <netdev+bounces-149528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E069E61F8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC5A280FC9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56491805A;
	Fri,  6 Dec 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1H/F7V3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02C1A269
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443940; cv=none; b=ekB8wrxI3ENvtKz6yVjZKk0Nu2wSx4TcVMTwXlgCjJNrI4LM7Gvh9JSmXXgoR5hGjTmyv0H4NBsi6V/lp/dLtq7zPeMemJaghfU8HPvr8B7+F+ZWpZFruMJzwfm4CWNsQrYfREqF/EEErHPP5T7T0Ma6xATqJFzT4j5KV0a8JJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443940; c=relaxed/simple;
	bh=UTqJoFiFcb7QWbJLCYZ6vV6S83KBmqu79iJXV1WF98g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SP4Iu7JBE3T+Qc4B0vaFXk45VZn3NH/Isy+r9AhoRF1pK5Wgw8aqkVoJCXfLhcwIXNHIDlPXUwtEirZVuA11o73Guu8/YRnqE7AlULWEqnOeTsReWzWRjy1w5Bvj5nCyxh9npz0qjRENYxsZeueHakQux7t5HZ2bUaks2gr29Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1H/F7V3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733443939; x=1764979939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UTqJoFiFcb7QWbJLCYZ6vV6S83KBmqu79iJXV1WF98g=;
  b=K1H/F7V3Ejsg2FylzfWI4jjq1G31jdPlCiy0Yxf7a4bZ0Gw9BrLguA3Z
   bF+VSysnnnN28fYTMtKgOkinUXTBKd8XWeRTgEGEAlPyZiuxvAcXfIbal
   AGOQKnh39yy8H5qqlnmLf2vwAayg6wMoCYf/t4GvLla/KZTS6UKcjY5WW
   GV/BHSsVdsCbwvvXdxpDZR7yOzltDI0aFY27roPFCG5+QIbjV82JlzjGB
   /3dnlBYzEcRoEyZlQEXRtf4KVla5dO1bYrFkXUYVlufi78nsjNU4Gz0ID
   1on/QkPtv+OX2pn2yKD34xa4JQiYi4EhJVsGKGcWSEbsg2E/NpGQkeMiB
   g==;
X-CSE-ConnectionGUID: xvSR0y+6QTKTHOqBU8KHUw==
X-CSE-MsgGUID: dHVnglLJSzaXro5UOLR5Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="45162750"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="45162750"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:12:18 -0800
X-CSE-ConnectionGUID: UQjJkFFXQb+3UFnATqaG5A==
X-CSE-MsgGUID: d5avdj05QH62pSTxESEZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="98694923"
Received: from ibganev-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.131])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:12:17 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH RFC net-next 0/2] net: napi: add CPU affinity to napi->config
Date: Thu,  5 Dec 2024 17:12:07 -0700
Message-ID: <20241206001209.213168-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Jakub, move the CPU affinity mask from the driver to
napi->config.

Tested on idpf.
---
if accepted, will fix all drivers already using netif_napi_set_irq() 

Ahmed Zaki (2):
  net: napi: add CPU affinity to napi->config
  idpf: use napi's irq affinity

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 18 ++++-------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++----
 include/linux/netdevice.h                   | 22 +++++++++++++++++++++
 net/core/dev.c                              |  7 ++++++-
 4 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.47.0


