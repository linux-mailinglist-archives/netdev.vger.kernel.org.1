Return-Path: <netdev+bounces-28539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CE877FC8E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EDF282056
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FB168D0;
	Thu, 17 Aug 2023 17:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF114F65
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDEFC433C7;
	Thu, 17 Aug 2023 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292139;
	bh=ilXzsVJKdtYRUHLDwj6TNqhA9YxLtUSEu1TjUvRWNKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCMGHzTOHPVHUl1atkAAXeHmPB2MhtN7fFBT3XLeUYiXEDrlrSj80fH2Tr5ha/uzK
	 GeE2SWsegYHGnZVShvKv1HDZJQTv3/hjNpOIxqmrL7dLwTUAmbxVmuRNPIPrd74SnC
	 smvXkYQaian4gfnKVL5JRj7XS+G/gSI3zt+rS+3bLfIJ5Zp5YSXS+Qc9Fhh+Zc8Zln
	 ZRwYWNlpBEELZ/hKKAtLD4K6qwxOVmEmKGCwVffZ8kOGZmWYAHbOeBsNILlysEfbb6
	 GtN9eYml/dn149NGJDZfx+iXzqya6MRU0G2FW+V+5HzaL8Ef6dU8cpxVzopOBw/vGf
	 rhF1lv2vusNEA==
Date: Thu, 17 Aug 2023 20:08:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 07/14] ice: refactor ice_vsi_is_vlan_pruning_ena
Message-ID: <20230817170854.GQ22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-8-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-8-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:29PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As this method became static, and is already called
> with check for vsi being non-null, an unnecessary check along
> with superfluous parentheses is removed.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

