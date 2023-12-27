Return-Path: <netdev+bounces-60401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2340481F12A
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128751C210F2
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE946557;
	Wed, 27 Dec 2023 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsOrgduU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6946556
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703701546; x=1735237546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pi2CQEvMJcn9IstpfXFRTE1ZH2zpKE6NRTN84+gfZzw=;
  b=SsOrgduUHpl7fIKUeB566PuoN5HLg73gMwpaQeAS7XdLGkP74lVLC3vS
   M0noaCvOhqeAOlLWeh3xzBxwEK5gvhLdiW4Ci/vrIUSOux/Lc05EVhkhs
   13ouydmsfKlgGURemlTbTwVCGfABEZai2m0mJtlZZaflUbhp/nyElMl3D
   xw/Mp4a/592dVQdGrOvrRLUfsnwuVdSDfOJGmCQY3vEvUVnEs8GoWULFx
   tk+uo0q3BcxGAHmX1Dvi/fahFbo4EGUDFBwKJ6DkZJ03DUKBKBD7rK961
   m52i3tZLQTrZiAfS5G06qwLEB6pKbyv+nPcqXKlAqI/n3oZQmu24oWRQm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3312821"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3312821"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="868921409"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="868921409"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2023 10:25:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2023-12-27 (ice, i40e)
Date: Wed, 27 Dec 2023 10:25:29 -0800
Message-ID: <20231227182541.3033124-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice and i40e drivers.

Katarzyna changes message to no longer be reported as error under
certain conditions as it can be expected on ice.

Ngai-Mint ensures VSI is always closed when stopping interface to
prevent NULL pointer dereference for ice.

Arkadiusz corrects reporting of phase offset value for ice.

Sudheer corrects checking on ADQ filters to prevent invalid values on
i40e.

The following are changes since commit 49fcf34ac908784f97bc0f98dc5460239cc53798:
  Merge tag 'wireless-2023-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: dpll: fix phase offset value

Katarzyna Wieczerzycka (1):
  ice: Fix link_down_on_close message

Ngai-Mint Kwan (1):
  ice: Shut down VSI with "link-down-on-close" enabled

Sudheer Mogilappagari (1):
  i40e: Fix filter input checks to prevent config with invalid values

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_common.c        |  4 +---
 drivers/net/ethernet/intel/ice/ice_main.c          | 12 +++++++++---
 3 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.41.0


