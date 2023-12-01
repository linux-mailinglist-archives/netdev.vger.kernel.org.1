Return-Path: <netdev+bounces-53031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7B5801238
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1FC2813D6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7E4EB47;
	Fri,  1 Dec 2023 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzieZNU9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429BFF
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454135; x=1732990135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nbmzyceupvAW2bI3bEIn7PA3l4Ti1U1NC3FRbvG0xqI=;
  b=XzieZNU9lX0pEWPMWRQNd4byNyR75t0JR1jJYeV7/uZNk1Z9JtrUbPo7
   pClTHIbOaYOge+Dox+8GcyGN1RsQlpDip8b3JyZkTxhh20bsi1pStg8GA
   5cvP5DU/fq0+n4hVjRrVvsEO/pN7eblnJsrG1khP5Q2FE+u3v0uOxoUW/
   zHrEG9dbJVRTDqPlV9+FTGbeNCXQ91n42DraXb5PtpKjs2cxGAp48xv+c
   qPoiwy11KlZ3h6d+KS2mXKTwLwXEjlEyonZ5AYoxGd3bLdxYgNhNkb4Dw
   XTbncxxry9XeLIpTiJPc1bG9U/qJO3goZk62aUFycDu8NrVJQfM0DWUnl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244379"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272435"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272435"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates 2023-12-01 (ice)
Date: Fri,  1 Dec 2023 10:08:38 -0800
Message-ID: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Konrad provides temperature reporting via hwmon.

Arkadiusz adds reporting of Clock Generation Unit (CGU) information via
devlink info.

Pawel adjusts error messaging for ntuple filters to account for additional
possibility for encountering an error.

Karol ensures that all timestamps occurring around reset are processed and
renames some E822 functions to convey additional usage for E823 devices.

Jake provides mechanism to ensure that all timestamps on E822 devices
are processed.

The following are changes since commit 15bc81212f593fbd7bda787598418b931842dc14:
  octeon_ep: set backpressure watermark for RX queues
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Arkadiusz Kubalewski (1):
  ice: add CGU info to devlink info callback

Jacob Keller (1):
  ice: periodically kick Tx timestamp interrupt

Karol Kolacinski (2):
  ice: Re-enable timestamping correctly after reset
  ice: Rename E822 to E82X

Konrad Knitter (1):
  ice: read internal temperature sensor

Pawel Kaminski (1):
  ice: Improve logs for max ntuple errors

 Documentation/networking/devlink/ice.rst      |   9 +
 drivers/net/ethernet/intel/Kconfig            |  11 +
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  28 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  54 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  20 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  13 +-
 drivers/net/ethernet/intel/ice/ice_hwmon.c    | 126 +++++
 drivers/net/ethernet/intel/ice/ice_hwmon.h    |  15 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   7 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 117 +++--
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 444 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  48 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  14 +-
 18 files changed, 627 insertions(+), 297 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h

-- 
2.41.0


