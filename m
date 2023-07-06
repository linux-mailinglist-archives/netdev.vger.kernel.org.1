Return-Path: <netdev+bounces-15728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29A7496C8
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74275281291
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A215B8;
	Thu,  6 Jul 2023 07:50:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283F15A1
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA11BC433C8;
	Thu,  6 Jul 2023 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688629847;
	bh=sBSWDMayWAbO6Gg72UFSKra94+4M+CRDzMwhyCJgtMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDpNosiNYAuJmjqzXEfodioJvltky/jVF8az+Qv0uwZSY9DiBmaiv4910N15Qf3GO
	 fhIdaO1So6CNZQkfXk/1VffM+etRc2vzBPvY4NrLkT6XkocKxtbKJwQaVUFv6NcpFF
	 pNzZHbvYaSPqdAmuojBwhEHFFzNjzZdLVtVTV4SP9R0/4HbebdztRWyTzJNmeYYImo
	 okHO07eQH83dy2A9E43VErWRob3328oTlREL/AsqSJs+pBdHElsHDEbMebnInZRsMu
	 mjV3tuRMLF+otRaPWECiJv98t1HnxK1QMkor0/ZaXzavhzQLE2oM/W7e/vHqWNxc3H
	 Xrit+iMASvVTw==
Date: Thu, 6 Jul 2023 10:50:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: Re: [PATCH net 1/2] ice: Fix max_rate check while configuring TX
 rate limits
Message-ID: <20230706075042.GQ6455@unreal>
References: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
 <20230705201346.49370-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705201346.49370-2-anthony.l.nguyen@intel.com>

On Wed, Jul 05, 2023 at 01:13:45PM -0700, Tony Nguyen wrote:
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Remove incorrect check in ice_validate_mqprio_opt() that limits
> filter configuration when sum of max_rates of all TCs exceeds
> the link speed. The max rate of each TC is unrelated to value
> used by other TCs and is valid as long as it is less than link
> speed.
> 
> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

