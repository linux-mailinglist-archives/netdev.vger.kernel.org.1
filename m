Return-Path: <netdev+bounces-150432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A39EA39E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA51885C24
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE42D524F;
	Tue, 10 Dec 2024 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5i1+cZy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18541B665
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790404; cv=none; b=SfpFU8JCJUFpZ8UgG3qSU/v4hCYMDI+w9UWyJAhIlObKa0rJSl55R/J0PNadxTPv+QGNiAePuU5J1Ymiaq7eqMWR0EoP1W99e3SH3l0idBccrZF9sS59MvsvI+5oI52CGF8SCjME3C61Rby1JgHBZYTcqsUsmAQ+4IJ6kFwTqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790404; c=relaxed/simple;
	bh=r5zc0yySDDLCvH/uAqc6cFyI/K7kQYTxKVHdUDc7sTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEGvE3adK3qVbmhdun+AjVP2eZLsw8ewdXDsxL8RHVXuq72BlekkZ389r1YUsjIo5Y6IFM8ee36KpdVseCx1z1LJwEU+FTgnuzMiphb7Qxk09DVjk4AF3f+x5/8tKWqKSjKkMDo8I+ycOrNsFdFBlZM7Z26QSaAqeF4NvtUiv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5i1+cZy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733790403; x=1765326403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r5zc0yySDDLCvH/uAqc6cFyI/K7kQYTxKVHdUDc7sTI=;
  b=F5i1+cZyLaB/k81ZBWLgcTRwJ6Y/fJIKZO3qBhX80LDB9AtgZe4SlD4C
   QTKKTz1M4hHUkf1x44pG7rxwBcLTIZ3HkKYlfa7zaiy/qFrSmRoJkdIXU
   8AH5MyToWFeME64DzMGiYRo1pxslzj5QvGVM9nKlh4Yh3opgGZON0DshK
   Ooy01PNpbKKMz4hJ0j5VrjahLvRnQxECC72M6462AESlmXADY1ZnF4lee
   5B/AG7/XnD4CQMGu5fQYpJnC9SdJR+tgIM/5TSJHLLfg5wlza9omE+HQf
   iGDKLN7miytg529ML9MOuITCdJrdqDmxXFd0UbuwvCb8D9kKGd176eZI4
   Q==;
X-CSE-ConnectionGUID: BQTXCwLATAyeTN8CEfjmWA==
X-CSE-MsgGUID: vD3Qr0UAS6qReP1yIDkvKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44791383"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="44791383"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:42 -0800
X-CSE-ConnectionGUID: xOhnTAYVSU2xk+AVwoOtOA==
X-CSE-MsgGUID: Zwa5mrsERkaR3ZTM3a+07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="126132066"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.109.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:26:38 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH v1 net-next 0/6] net: napi: add CPU affinity to napi->config
Date: Mon,  9 Dec 2024 17:26:20 -0700
Message-ID: <20241210002626.366878-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IRQ affinity management to the napi struct. All drivers that are
already using netif_napi_set_irq() are modified to the new API. Except
mlx5 because it is implementing IRQ pools and moving to the new API does
not seem trivial.

Tested on bnxt, ice and idpf.
---
Opens: is cpu_online_mask the best default mask? drivers do this differently 

RFC -> v1:
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (6):
  net: napi: add irq_flags to napi struct
  net: napi: add CPU affinity to napi->config
  bnxt: use napi's irq affinity
  mlx4: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 ++---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 drivers/net/ethernet/broadcom/tg3.c           |  2 +-
 drivers/net/ethernet/google/gve/gve_utils.c   |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  3 --
 drivers/net/ethernet/intel/ice/ice_base.c     |  7 +--
 drivers/net/ethernet/intel/ice/ice_lib.c      |  9 +---
 drivers/net/ethernet/intel/ice/ice_main.c     | 44 -------------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 19 +++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  6 +--
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  8 ++--
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 33 +-------------
 drivers/net/ethernet/mellanox/mlx4/eq.c       | 22 ----------
 drivers/net/ethernet/mellanox/mlx4/main.c     | 42 ++----------------
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  1 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  3 +-
 include/linux/netdevice.h                     | 11 ++++-
 net/core/dev.c                                | 33 +++++++++++++-
 23 files changed, 73 insertions(+), 209 deletions(-)

-- 
2.47.0


