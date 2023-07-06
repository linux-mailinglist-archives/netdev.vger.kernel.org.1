Return-Path: <netdev+bounces-15729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98C7496CB
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33F41C20CE6
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94D15B8;
	Thu,  6 Jul 2023 07:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A0184F
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 07:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA3C433C8;
	Thu,  6 Jul 2023 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688629855;
	bh=Ws6B+fmnNQclM13TEqyaMpcCVIlIoR9AyoMunptoLxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YT4b7R6bQcqaHQH6ju1MIZi5923WbjerC1oB8abTulEJVRjQ+RK1oEIRiS3T59XC0
	 NK3jicqJJ0viHpwTUMm/AOdjLFWXqrpVICfWZJfzxe8TmHrd46S3GxLDxlGJhO5X/z
	 qwJi313d+TME9XD8MtAjxdNMZkToIsupr9c8aDzHU+njkm5aYv3aoD7R/IKlERX5i+
	 APUexGzM8S06IHFEPDV2o3xojDzTLWsAy9qTDLfiACk724Odx2JIxZ8AM8Lm2+C3Ql
	 Hkf2ehoL7rDfetXPYP8bQqR1GJ3hQ9wPwXezdlwUJo31qcJJwvKDsL6egVc+Dgza/z
	 SRh7K17N3o3RA==
Date: Thu, 6 Jul 2023 10:50:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Subject: Re: [PATCH net 2/2] ice: Fix tx queue rate limit when TCs are
 configured
Message-ID: <20230706075050.GR6455@unreal>
References: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
 <20230705201346.49370-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705201346.49370-3-anthony.l.nguyen@intel.com>

On Wed, Jul 05, 2023 at 01:13:46PM -0700, Tony Nguyen wrote:
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Configuring tx_maxrate via sysfs interface
> /sys/class/net/eth0/queues/tx-1/tx_maxrate was not working when
> TCs are configured because always main VSI was being used. Fix by
> using correct VSI in ice_set_tx_maxrate when TCs are configured.
> 
> Fixes: 1ddef455f4a8 ("ice: Add NDO callback to set the maximum per-queue bitrate")
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  7 +++++++
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 22 ++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

