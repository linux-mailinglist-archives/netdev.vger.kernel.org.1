Return-Path: <netdev+bounces-28401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DC77F559
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE13D281E0B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80F134C6;
	Thu, 17 Aug 2023 11:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F12134AF
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE46C433C7;
	Thu, 17 Aug 2023 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692272099;
	bh=RZdhpallw3HqqTd3YnmGRneMZjjvRS8b49GRP4Ic99k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3aQZI8unH3XZzPeztZe2GoXVRcyqnwBt39H5jLEYHHPuKLDyFfc51TD9m6/TB+4j
	 MK4LprCBSTyBK8EwtY8Q1zhTsgD1/2ixA3WYiZ30oehc3TGzGutirNB/tDVnSqlo8i
	 au2xX8RBS8YjgwuK4sSFLBpXSpd940nARnrAGhD67V0W5LHOvQteCKJY50GKXAso8o
	 Cy0XZVRX99gqr+AvCjHel90HALkYULfZyFL0/6P4QnpDRaV6EhfbECEeiYa6HjJKMC
	 egTen738zFvfquB0r3/xOc60DxHJe/XAHLLywwrc/ggogv00IX2w9NRD01SBlU85EZ
	 CLafGm3X52hvg==
Date: Thu, 17 Aug 2023 14:34:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 05/14] ice: refactor ice_sched to make functions
 static
Message-ID: <20230817113455.GN22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-6-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:27PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As ice_sched_set_node_bw_lmt_per_tc is not used
> outside of ice_sched, it can be made static.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.h | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

