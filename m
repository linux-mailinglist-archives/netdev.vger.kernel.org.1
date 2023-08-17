Return-Path: <netdev+bounces-28554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176A77FCC9
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FE41C214BE
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752A171A9;
	Thu, 17 Aug 2023 17:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94514168D7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE39C433C8;
	Thu, 17 Aug 2023 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292252;
	bh=34PCt9i94OoGAc2xxBIjR0hztyfRxokeKo69iYmy6Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9XeR6dwzUtVqJcsH6fB0sGqKIT6xm37bV2dUYw90DqgerCUa9qRTm8havQAsZIAS
	 kkftZMGWM2dHgkbiRWce6Zvdj7m1RcKcBowv2fZBqrndKH9oQcluHQwQZXhAXxPZUR
	 ptUKJWyVku6X6CcM7t26HE1t5YUttK9Bz70/Gm+2w7s3u7DHWhsZ26W9RLUEN/RPaN
	 qrczqaKCKyrZI++ylxV3ZeoZEDdGNSnM9NdQZUSNIjMTgy3tXo4KLTupeGBr455uZm
	 tt/34WNuowcIWvMrFT0GlnjC2Q5fdrRT2X4LtBV1X/eLKHzT1zIq4JApbzjTwCnd4k
	 uxhDE/w0MZLDQ==
Date: Thu, 17 Aug 2023 20:10:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 13/14] ice: embed &ice_rq_event_info event into
 struct ice_aq_task
Message-ID: <20230817171048.GV22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-14-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:35PM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Expose struct ice_aq_task to callers,
> what takes burden of memory ownership out from AQ-wait family of functions,
> and reduces need for heap-based allocations.
> 
> Embed struct ice_rq_event_info event into struct ice_aq_task
> (instead of it being a ptr) to remove some more code from the callers.
> 
> Subsequent commit will improve more based on this one.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 18 +++++++-
>  .../net/ethernet/intel/ice/ice_fw_update.c    | 42 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_main.c     | 29 ++-----------
>  3 files changed, 40 insertions(+), 49 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

