Return-Path: <netdev+bounces-209608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FBB1000D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 07:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF650967D99
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425A1E6DC5;
	Thu, 24 Jul 2025 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KM5yrygk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4627461;
	Thu, 24 Jul 2025 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336177; cv=none; b=l8U9jTc5YQaaDKuajxIdZCvghlCjsGZ4uTefrjUXIBgZ16DUuakUDovXpfhZtqlCaa5g9lgEd+pbfWxh4vnH3a8rkTzClwmxLj3541tbUm27qPuZTGeZLcY+UyOHxJOpZRLV3RTqPTBjBs9yf2ExIhSgsbc1TuBRJuDVaD4GFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336177; c=relaxed/simple;
	bh=E4pvkt3WPy6wv2L0Cl4P1RKdvunQ2Cf5tLUgkOI8y3s=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QGObL84L13I3HIkMLv88dv4BofiVdoScAZpDj4BMDjVGyyGmxxiazAztDe6ybeJZlnGhn0AM2YjZxvflKiWePFjfD/fti8ROFRaVvweTM+pfx5S+E+sujV2elwoQsiPC467n+XHTNL85RCOPZP1bzKcJNZYhuUVv33xIScbIQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KM5yrygk; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1753336176; x=1784872176;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=8rXWMCJs2reKmOTrDp+6hju6ytK5A3jKvfCLoVTCkSs=;
  b=KM5yrygkO5pYo0YRUjVEyhFa8HQ8fQoFyEfzOO0/k8KkCRHwhUh8Apmt
   yq34BLcp3+JYOxf5BPtj6gU+GCOW2Z1KsTPqJTnlydkU6HbHYuAdbU4Zs
   Kb8MOyavb7LZcOgnuY7oGyfagwDNNT+Ueqq3ysNaCdS82LxPbxXdI7h49
   THlVfe79rxhqonm3jDSs3qgGXDKaMYJfjjcB1eEGY0YTZHDmNldzk83lP
   v0Xda+tSNt139N7TMmGm0SBZ6UFMmD20xa/wZBgTuK4wHXekrkjchJ0pC
   iYVE/LTz8Awqxidc4Bg6HF+3ILqWIO4eC4c22nCGvPRWeGNCBoUVrI3sl
   A==;
X-IronPort-AV: E=Sophos;i="6.16,336,1744070400"; 
   d="scan'208";a="512508763"
Subject: RE: [PATCH] net: Fix typos
Thread-Topic: [PATCH] net: Fix typos
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:49:33 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:10188]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.12:2525] with esmtp (Farcaster)
 id a59c0b64-55c6-44db-886d-cacb011e5613; Thu, 24 Jul 2025 05:49:31 +0000 (UTC)
X-Farcaster-Flow-ID: a59c0b64-55c6-44db-886d-cacb011e5613
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 05:49:31 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 24 Jul 2025 05:49:31 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Thu, 24 Jul 2025 05:49:31 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Thread-Index: AQHb/A6mh9gTUEl2+0SS8UVRprZD47RAxK/A
Date: Thu, 24 Jul 2025 05:49:31 +0000
Message-ID: <b9e2a164eee44c5ba8b5f0b14ca7ee06@amazon.com>
References: <20250723201528.2908218-1-helgaas@kernel.org>
In-Reply-To: <20250723201528.2908218-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Fix typos in comments and error messages.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_admin_defs.h     |  2 +-
>  drivers/net/ethernet/broadcom/b44.c                  |  2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c      |  2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c  |  4 ++--
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_fw_defs.h  |  2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |  2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h       |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c            |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c      |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c                  |  2 +-
>  drivers/net/ethernet/cavium/liquidio/octeon_main.h   |  2 +-
>  drivers/net/ethernet/cavium/liquidio/octeon_nic.h    |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb/pm3393.c           |  8 ++++----
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h           |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c    |  4 ++--
>  drivers/net/ethernet/chelsio/cxgb4/sge.c             |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c           |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4vf/sge.c           |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4vf/t4vf_hw.c       |  2 +-
>  drivers/net/ethernet/dec/tulip/tulip_core.c          |  2 +-
>  drivers/net/ethernet/faraday/ftgmac100.c             |  2 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c      |  4 ++--
>  .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  2 +-
>  drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c     |  2 +-
>  drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c           |  2 +-
>  drivers/net/ethernet/intel/ice/devlink/port.h        |  2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c            |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c             |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c          |  2 +-
>  drivers/net/ethernet/intel/igc/igc_mac.c             |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/vf.c              |  2 +-
>  drivers/net/ethernet/marvell/mvneta_bm.h             |  2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c    |  2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c  |  2 +-
>  drivers/net/ethernet/marvell/pxa168_eth.c            |  6 +++---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h         |  2 +-
>  drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c      |  2 +-
>  drivers/net/ethernet/micrel/ks8842.c                 |  2 +-
>  drivers/net/ethernet/neterion/s2io.c                 |  4 ++--
>  drivers/net/ethernet/pensando/ionic/ionic_if.h       |  2 +-
>  drivers/net/ethernet/qlogic/qed/qed_dev.c            |  2 +-
>  drivers/net/ethernet/qlogic/qed/qed_ptp.c            |  2 +-
>  drivers/net/ethernet/qlogic/qla3xxx.c                |  2 +-
>  .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c    |  2 +-
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c      |  2 +-
>  drivers/net/ethernet/sfc/mcdi_pcol.h                 |  6 +++---
>  drivers/net/ethernet/sfc/siena/farch.c               |  2 +-
>  drivers/net/ethernet/sfc/siena/mcdi_pcol.h           | 12 ++++++------
>  drivers/net/ethernet/sfc/tc_encap_actions.c          |  2 +-
>  drivers/net/ethernet/smsc/smsc911x.c                 |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c    |  2 +-
>  drivers/net/ethernet/sun/niu.c                       |  2 +-
>  drivers/net/ethernet/sun/niu.h                       |  4 ++--
>  drivers/net/ethernet/sun/sunhme.c                    |  2 +-
>  drivers/net/ethernet/sun/sunqe.h                     |  2 +-
>  drivers/net/ethernet/tehuti/tehuti.c                 |  2 +-
>  58 files changed, 77 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
> b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
> index 562869a0fdba..898ecd96b96a 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
> @@ -986,7 +986,7 @@ struct ena_admin_feature_rss_ind_table {
>         struct ena_admin_rss_ind_table_entry inline_entry;
>  };
>=20
> -/* When hint value is 0, driver should use it's own predefined value */
> +/* When hint value is 0, driver should use its own predefined value */
>  struct ena_admin_ena_hw_hints {
>         /* value in ms */
>         u16 mmio_read_timeout;

Reviewed for ENA. Thanks for identifying this typo.
Shouldn't think patch be for net-next?

Reviewed-by: David Arinzon <darinzon@amazon.com>

