Return-Path: <netdev+bounces-35532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77B7A9C82
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F4C283316
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685F4C850;
	Thu, 21 Sep 2023 18:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEA4BDA0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:11:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A6A0C14
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319054; x=1726855054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IHstn1eCvB1+dZ/JDbHZp06bG5jNeGjcEDmKLrsRWKU=;
  b=Gy0NzfiweEhyBxKsQGmVJTcxNlEKMAyUfV+nivPEO73G7FNlqH5m3xXp
   wdpIv3WAbwbSrApOHV0r3rNW4y7WEPAtKbQ93/EODA8+hdVfPbuELchrk
   eIexe4w4pNnA/p3IkAhbAJLQbvTH4VFkGFuadxvzN1HL22slQ2GAy1b5Q
   Rh673Ca/Zsb3hTwJD75VXZW1E1zosHUFOTpWyZnX+rb6rFpJdwXlltzsb
   789tgNGCwKoc9+PbLXwJ4cYKHZ4sN1ApF2LqKgfM1n2Tc+aGjrkPA23xw
   RaC/aI5JkGp4Ne82JLncOlAwAy3YGSzYI0EDP6nrYzw+we2hHCzcHmk0D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383278144"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383278144"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 06:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890377513"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="890377513"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2023 06:54:05 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E830284C9;
	Thu, 21 Sep 2023 14:54:54 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	horms@kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH iwl-next 0/2] ethtool: Add link mode maps for forced speeds
Date: Thu, 21 Sep 2023 15:51:38 +0200
Message-Id: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following patch set was initially a part of [1]. As the purpose of
the original series was to add the support of the new hardware to the
intel ice driver, the refactoring of advertised link modes mapping was
extracted to a new set.
The patch set adds a common mechanism for mapping Ethtool forced speeds
with Ethtool supported link modes, which can be used in drivers code.

[1] https://lore.kernel.org/netdev/20230823180633.2450617-1-pawel.chmielewski@intel.com

Changelog:
v1->v2:
Fixed formatting, typo, moved declaration of iterator to loop line.

Paul Greenwalt (1):
  ethtool: Add forced speed to supported link modes maps

Pawel Chmielewski (1):
  ice: Refactor finding advertised link speed

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 201 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  24 +--
 include/linux/ethtool.h                       |  20 ++
 net/ethtool/ioctl.c                           |  15 ++
 6 files changed, 178 insertions(+), 85 deletions(-)

-- 
2.37.3


