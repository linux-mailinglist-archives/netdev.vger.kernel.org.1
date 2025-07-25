Return-Path: <netdev+bounces-210155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A38B12315
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B05B7ACE88
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B12EFD8C;
	Fri, 25 Jul 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5CVIGVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3E2EFD83;
	Fri, 25 Jul 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465189; cv=none; b=OkjUTkbq/vS2rh60/YmrPLB3yr2RgXOh1Ah60V2zyHUxsWuRqQufA4QhhCs1ucgHeypWm7ehO79mSwJFSCG4ATqhqmoegLp6czrSJyYrvwj9pQtOKYPehVt0mQwwZYhfNDHglJRq5qFrFI/riVv9IeAjCin9XR/sOoxjFQYr79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465189; c=relaxed/simple;
	bh=WgJWl7erYwlBGAgNf9PftPX5Y5QAmyu3frFvneg9Tss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jbREuOYhh7DBw3FFM7t35Tcm6ULXnDSc/pDNzjXmHydPoJ2eYfIdPOUygOj6tycnSiydLrb7Ffd4FeGcLyeb69PvtIngAWfUgXdJKlqX2RqmRUuNOtpplwI1YCONtOSivNH7AvTqGJSF+4W6JUnkpPD5js/DMlCz5HrozifbEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5CVIGVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CBEC4CEE7;
	Fri, 25 Jul 2025 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753465188;
	bh=WgJWl7erYwlBGAgNf9PftPX5Y5QAmyu3frFvneg9Tss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5CVIGVBM9C9+il4yzH9bsJEq5g58gdJE+uu3dfOc/YalARDCgpwXkBQXNSGiwgDM
	 dfNs8N79wKhi5uZdxdiZQ70FlsDqruMrSwhpbn4jlbsm5ARuA1kSiNLCiMMmdmu7RU
	 +2mv/owWdGW3FEvLFBjqhFaIPJ+zr5pJTtZ3yZ1jevmnP2mQ5AZtOjYOEFd3km87p0
	 04OdaTOA6ql1AqpPbQ3zdBFeI5u/NBWv3UkQycqDWs2kVvuAwttpZ21HeMOkSHC0T9
	 t5l2I3ZNzTb2VaJ+Zw8zyvS/0Qsl2KAemA9FFquynpmSIm5xqxT2Ex/lMdO4OOelDM
	 4EWSM8OvtcRvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB2383BF5B;
	Fri, 25 Jul 2025 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: Fix typos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346520601.3214620.17200447923640485752.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 17:40:06 +0000
References: <20250723201528.2908218-1-helgaas@kernel.org>
In-Reply-To: <20250723201528.2908218-1-helgaas@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 15:15:05 -0500 you wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments and error messages.
> 
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

Here is the summary with links:
  - net: Fix typos
    https://git.kernel.org/netdev/net-next/c/fe09560f8241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



