Return-Path: <netdev+bounces-63225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6957B82BE1A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4781F21B28
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A12857877;
	Fri, 12 Jan 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUM3ig28"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7135D720
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705054170; x=1736590170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k538U04y1+gFCDAOeeVHduwRHtJ/O1vY62vfMQ93t+4=;
  b=WUM3ig282DrTjbmX66TX/BaDcGzsX0DjcCS1KBYDD+f9OQjzbWkq6E8/
   4sdMNS44Lyzu8123B0YyqhvxYJKy3fovDUAR1WIoJpU3abB79FMgEXlXZ
   PJRbIE8HtVDZnaINlaNDOexgKaMWdgamuuPA+6gtT/iiBN1F9N/3G5+UX
   iKDi1JEaS5sQgcNTWEuUcxWX2PyEkfjwBpEAX75pRVUh+Y0L/ppTxK/w4
   x1r/O73d7j2ZYjUQpgXoyzd6flUE0qzp1TvGIbqnQjbuYqOOHq8V5Qf3n
   5YxqD4NB4kAegAkegI6P1l5onJep7Y4n+jinp+kil4s7l0uTsiWPwmIRE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5867343"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5867343"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="759083268"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="759083268"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2024 02:09:28 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 0/2] i40e: Log FW state in recovery mode
Date: Fri, 12 Jan 2024 10:59:43 +0100
Message-Id: <20240112095945.450590-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce logging FW state in recovery mode functionality.

1st patch adds implementation of admin command reading content of alt
ram.
2nd patch utilices the command to get trace buffer data and logs it
when entering recovery mode.

Jedrzej Jagielski (1):
  i40e-linux: Add support for reading Trace Buffer

Przemyslaw R Karpinski (1):
  i40e: Add read alternate indirect command

 drivers/net/ethernet/intel/i40e/i40e.h        |  2 +
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 40 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 35 ++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  3 ++
 .../net/ethernet/intel/i40e/i40e_register.h   |  2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  5 +++
 7 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.31.1


