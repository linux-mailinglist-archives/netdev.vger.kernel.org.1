Return-Path: <netdev+bounces-22623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9B768587
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2CF1C209DF
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D091FBD;
	Sun, 30 Jul 2023 13:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBD363
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 13:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B0FC433C9;
	Sun, 30 Jul 2023 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690723353;
	bh=km2k/6uwy/xOQz1eHj5n4RA09bTRYn/p68VxBxTwuUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t52nIL/ScA2k7TN2nr78RV5Jm0j1ug+N3SHAU1ihRCfUoZxOjTM9nNkjo8+fJeOyj
	 tNVOhUQSNknJFNBAK0UyrrVcpXH+/AlW+WiAzXFXXpbNllJ0zotgNgCUUkBK8bbgjI
	 vCFvTbYz2EmULi8d56wl3dSfWtG2IUwfgpWgVbh0V+KnkjCNGZK5iIB6xm4z0L81sM
	 AtaxI9mR2Y7mKzazP/wFcvgfatMgz159negH6pph27Ih+kE6EchrtNhgElISQRbfqo
	 LxenXVRpZpY/f9ZyFdJo8Zqepi/rn9tRxzpSUkCe3/7SGLZFRt2uaZOq7HsPzBOUPj
	 8Lc1Kdij4ac2w==
Date: Sun, 30 Jul 2023 16:22:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Gurucharan G <gurucharanx.g@intel.com>
Subject: Re: [PATCH net-next] i40e: remove i40e_status
Message-ID: <20230730132229.GF94048@unreal>
References: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728171336.2446156-1-anthony.l.nguyen@intel.com>

On Fri, Jul 28, 2023 at 10:13:36AM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Replace uses of i40e_status to as equivalent as possible error codes.
> Remove enum i40e_status as it is no longer needed
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> It was recently discovered that this patch was missed on the original PR;
> sending it now to complete the removal.
> 
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  49 +++--
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 116 ++++++------
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  20 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   2 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_diag.c   |   6 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c    |  21 +-
>  .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  54 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  48 ++---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  52 ++---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_status.h |  43 -----
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 -
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 179 +++++++++---------
>  16 files changed, 275 insertions(+), 327 deletions(-)
>  delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_status.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

