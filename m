Return-Path: <netdev+bounces-192966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17320AC1E02
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44E04E719C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215828369A;
	Fri, 23 May 2025 07:56:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA242DCBE6
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986990; cv=none; b=iPuYUFsToynhsPn/1qMikvvvqwLjg+ENLz7Tzh+zrrHqDXByUus83SDs2DVvSusMKON+bPLXkEsJJB4IF5jpyQTNSYudgKLsYbBOjXNLXl2ZzlAgIdFoB6aImGiBrKGXeYSfsycsGrnz2XTxJhz/4kn63Dns+RrLiI4xivEml8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986990; c=relaxed/simple;
	bh=P88TP+Pt68/Jq+a5Z/jcH7J63gD62owO6vEe9V2g2S0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scwxMQTmFeQ4XdlToCTMHnlRZ2K/ZrSaBa6AZNmE6yYACgLcp9Eh9HjTeIFXWKdz3yNCAcTN7Av12G/EVCqJqA0kt03cGMmvViumFNdCu9+89h28yWQpFwZlwUJAQCf4HwMhHIL1tQEHMeeRW3i34/YWaPARFOON+mTibu4sYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EE334208A4;
	Fri, 23 May 2025 09:56:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0K9U5JWLDOz; Fri, 23 May 2025 09:56:18 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4DCB620748;
	Fri, 23 May 2025 09:56:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4DCB620748
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 23 May
 2025 09:56:17 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 09:56:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 135683181527; Fri, 23 May 2025 09:56:17 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/12] pull request (net-next): ipsec-next 2025-05-23
Date: Fri, 23 May 2025 09:55:59 +0200
Message-ID: <20250523075611.3723340-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

1) Remove some unnecessary strscpy_pad() size arguments.
   From Thorsten Blum.

2) Correct use of xso.real_dev on bonding offloads.
   Patchset from Cosmin Ratiu.

3) Add hardware offload configuration to XFRM_MSG_MIGRATE.
   From Chiachang Wang.

4) Refactor migration setup during cloning. This was
   done after the clone was created. Now it is done
   in the cloning function itself.
   From Chiachang Wang.

5) Validate assignment of maximal possible SEQ number.
   Prevent from setting to the maximum sequrnce number
   as this would cause for traffic drop.
   From Leon Romanovsky.

6) Prevent configuration of interface index when offload
   is used. Hardware can't handle this case.i
   From Leon Romanovsky.

7) Always use kfree_sensitive() for SA secret zeroization.
   From Zilin Guan.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 0c49baf099ba2147a6ff3bbdc3197c6ddbee5469:

  r8169: add helper rtl8125_phy_param (2025-04-10 20:18:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-05-23

for you to fetch changes up to e7a37c9e428a2912a4eec160e633503cd72e1ee6:

  xfrm: use kfree_sensitive() for SA secret zeroization (2025-05-20 07:55:00 +0200)

----------------------------------------------------------------
ipsec-next-2025-05-23

----------------------------------------------------------------
Chiachang Wang (2):
      xfrm: Migrate offload configuration
      xfrm: Refactor migration setup during the cloning process

Cosmin Ratiu (6):
      net/mlx5: Avoid using xso.real_dev unnecessarily
      xfrm: Use xdo.dev instead of xdo.real_dev
      xfrm: Remove unneeded device check from validate_xmit_xfrm
      xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
      bonding: Mark active offloaded xfrm_states
      bonding: Fix multiple long standing offload races

Leon Romanovsky (2):
      xfrm: validate assignment of maximal possible SEQ number
      xfrm: prevent configuration of interface index when offload is used

Steffen Klassert (2):
      Merge branch 'xfrm & bonding: Correct use of xso.real_dev'
      Merge branch 'Update offload configuration with SA'

Thorsten Blum (1):
      xfrm: Remove unnecessary strscpy_pad() size arguments

Zilin Guan (1):
      xfrm: use kfree_sensitive() for SA secret zeroization

 Documentation/networking/xfrm_device.rst           |  10 +-
 drivers/net/bonding/bond_main.c                    | 119 ++++++++++-----------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  20 ++--
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    |  18 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  41 +++----
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |  21 ++--
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |  18 ++--
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  28 ++---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   1 +
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |  11 +-
 drivers/net/netdevsim/ipsec.c                      |  15 ++-
 include/linux/netdevice.h                          |  10 +-
 include/net/xfrm.h                                 |  19 +++-
 net/key/af_key.c                                   |   2 +-
 net/xfrm/xfrm_device.c                             |  18 ++--
 net/xfrm/xfrm_policy.c                             |   4 +-
 net/xfrm/xfrm_state.c                              |  46 ++++----
 net/xfrm/xfrm_user.c                               |  77 +++++++++----
 18 files changed, 277 insertions(+), 201 deletions(-)

