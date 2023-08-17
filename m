Return-Path: <netdev+bounces-28553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8DC77FCC4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA55282124
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4E171AC;
	Thu, 17 Aug 2023 17:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE0168D5
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16CC433CA;
	Thu, 17 Aug 2023 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292223;
	bh=PqSdFgDKbLnj8/ZuLRuCmNwFn/hjLwRqIW3ola0861o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5s3FL9molonDjYNqyas5ckmi3Iws+7glCfjFoB7VW+NlRODRZaEql3LZPSHFpKtf
	 nYC8WTkFc6Rk8QZ6sR8HTfegczEowhJNh61MTepTHDhlCWw9PHIiuUP66M6yhk9PPa
	 UFV+yYcP6VzZu/A+WUZ2iZWKgKJ+KFMj4UMpIVmlNIeQwZU3YDb+AqHWpnT5PheGJj
	 lq5dBsBhM12K3onKbZrZ69O4zozuSDyQSav2fFMGjirxiqQAUEYbutRcC4GzOSBu3Z
	 tOlaL7AKlr+5u0buh4aXDW0imPrvlPrOPp/WmbwcRNM+/x0rV4IQkpDTzIFf/WtFfX
	 772LN+ANoCfuw==
Date: Thu, 17 Aug 2023 20:10:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 11/14] ice: drop two params from
 ice_aq_alloc_free_res()
Message-ID: <20230817171019.GU22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-12-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-12-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:33PM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Drop @num_entries and @cd params, latter of which was always NULL.
> 
> Number of entities to alloc is passed in internal buffer, the outer layer
> (that @num_entries was assigned to) meaning is closer to "the number of
> requests", which was =1 in all cases.
> ice_free_hw_res() was always called with 1 as its @num arg.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 24 +++++++--------------
>  drivers/net/ethernet/intel/ice/ice_common.h |  7 +++---
>  drivers/net/ethernet/intel/ice/ice_lag.c    |  9 ++++----
>  drivers/net/ethernet/intel/ice/ice_switch.c | 16 ++++++--------
>  4 files changed, 22 insertions(+), 34 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

