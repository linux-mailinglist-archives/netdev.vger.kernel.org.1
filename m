Return-Path: <netdev+bounces-28552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2766477FCC3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58D02820EF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83019893;
	Thu, 17 Aug 2023 17:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557B19890
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA719C433CB;
	Thu, 17 Aug 2023 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292203;
	bh=Hj4CfmVc4rTkkQ3xrVmWCADkunjR5XyNfIchtWDs7+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0alYyoBKNajoqcxvWCmNhVLC1LvYFXHMoWnI8wQoBC8jRY+sCcnp1n/bAkn2zFx9
	 kG4M7iXYKRR18Vwue4UHVz3KASQBLlsYi0MDinaWcLnidojoVm5k9fv+Ofsq8QOt2q
	 ob9MANmCl5ubOdKEAA2mT/Y3RFjGgTvQCMnADDDRlM69vHlWZEVE2pC103AVbHmRyI
	 pNCmkFoVfmcd7e6rlPA5teGfS/VEl5IqoYcIaxMVfzYAiKbtpt98G8lerhgwRkj313
	 b5A49d99b+OmnYM7bb87qW3QnuzGsMRS5wI2rB6FdbvSQWA+r92csuAIeyIKk1Tm1Y
	 /uBsycEz3lN0w==
Date: Thu, 17 Aug 2023 20:09:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 10/14] ice: use list_for_each_entry() helper
Message-ID: <20230817170959.GT22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-11-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:32PM -0700, Tony Nguyen wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> Convert list_for_each() to list_for_each_entry() where applicable.
> No functional changed.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

