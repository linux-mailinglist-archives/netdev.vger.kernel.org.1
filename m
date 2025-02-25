Return-Path: <netdev+bounces-169355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB8A43923
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A24919C817B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB8260A35;
	Tue, 25 Feb 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoycRVf3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6311FCCFA
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474546; cv=none; b=H8nP1M2CQs8gAiWXtCI3QGpwmkGmWOAOOB4WUjANajQYhMD6Ys9+AXYFzE96Z1881N9PPo52hzNseEq/lZ4tgJIPMukeD/YcCk5xHN238TyzXG1yYIz5ZQNP7YOjtYWCZPs4giVwXc9SJKWdfQQrVSMiFZyAuIaAgdEH0dMTO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474546; c=relaxed/simple;
	bh=FU+O1e+YZ+rOaKF4ncQzawYy76qQnRc2DJx5v5qVT4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnJTyv5u1x9tamuKQxFlHi6wHcP1dWWi9Fqike6vtzMbWUJsCH6xjKQ1MlYvNNIRhZJEwY/HynLMCaFjBB99TDzZpL8tQdxZNI7jAjs50/0NwdEFOKWhqBhowxtU3uLFLvoyWDYfd6jeZVD9aXlokngiM6v1ak8dA/6C9sqrGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoycRVf3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474545; x=1772010545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FU+O1e+YZ+rOaKF4ncQzawYy76qQnRc2DJx5v5qVT4U=;
  b=QoycRVf33dcbAPZeBuVF+EDA7pnpGLTHB7ZIitAb2bHqhQSRu+Wznmqe
   CVstS5s6tQF019jqNvLc7rrKtePj+qJeNhMlVkymJyOoNAT89JDH8mybL
   RIXn3n+/kt8gAWPYaO0QSbA16/tzz1ZHAlGMcg3qOIcZ90BmkYTAO2kQX
   ldKtZn7kNgvipicxWWwzDj3UBAbp8Tsx90Lw3kKwUa2g8YwAQ29Db2bAv
   1A7DQvYH/FgUik6ntzXoAe2WoZiFJi3NRqQuqC3s3MgnNAMPG0XhuxTaR
   vDE0Fivhi7aRHuR7RoE6va3qgOEwWu+8HE2mTwCZKiZ1g3/AQHuQ3JHE9
   A==;
X-CSE-ConnectionGUID: k2Ez70rSTXGdyqHZrKeu5w==
X-CSE-MsgGUID: vZTGWCS6Riu2wi3cYGafww==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810286"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:04 -0800
X-CSE-ConnectionGUID: l3qYIBBmRBi/S55cr8jQaw==
X-CSE-MsgGUID: xxHHLYjYRMCUUEhFz6wYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275455"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:03 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 0/5] ice: fix validation issues in virtchnl parameters
Date: Tue, 25 Feb 2025 10:08:43 +0100
Message-ID: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses validation issues in the virtchnl interface
of the ice driver. These fixes correct improper value checking,
ensuring that the driver can properly handle and reject invalid inputs
from potentially malicious VFs. By fixing validation mechanisms,
these patches strictly enforce existing constraints to prevent
out-of-bounds scenarios, making the system more robust against incorrect
or unexpected data. 

---

v2 -> v1:
attached Mateusz's related patch
rephrase some commit messages to indicate that this are feixes and should target net

---

Jan Glaza (3):
  virtchnl: make proto and filter action count unsigned
  ice: stop truncating queue ids when checking
  ice: validate queue quanta parameters to prevent OOB access

Lukasz Czapnik (1):
  ice: fix input validation for virtchnl BW

Mateusz Polchlopek (1):
  ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 39 +++++++++++++++----
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 25 ++++++++----
 include/linux/avf/virtchnl.h                  |  4 +-
 3 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.47.0


