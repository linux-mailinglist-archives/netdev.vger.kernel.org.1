Return-Path: <netdev+bounces-28397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9577F53D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CA281EA5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EA134A5;
	Thu, 17 Aug 2023 11:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD312B8E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6C4C433C8;
	Thu, 17 Aug 2023 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692271766;
	bh=WWFsPHR3/d+VV4dkCbvtlLBL8iRBS1k99wsKXFrDYzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsITzNI9ljNtjGotH57CPevmPry1OVoBgVt8tru24TuxFi9iAyNIdwghelb2F4B4p
	 jB3iDCCP3jZ32QPh6N/Mq/273/OwdN4GX+PfQLNw71hSrY1R/u4RthiWd+NoZQpt/H
	 wdapFQCqJOBofSCMH/pD705rj+PqoLZEJgiK5eP4Uq020nmT7AUEY2Ardlx5uioiSD
	 FLO6o8VMzWgTJSrLLZH2b6tzte3dg9RgbNjlfl3TE/VH1Kils1yHGwasn9esJpf/KR
	 bbvdnnl4ke/786ONMD7DPcjqhH3OUbxJossCWtRXD0QVqfgBMZ6mPa+BnNC8nY5nyb
	 Wqe5O4mZJVGnA==
Date: Thu, 17 Aug 2023 14:29:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 01/14] ice: remove unused methods
Message-ID: <20230817112921.GJ22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-2-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:23PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Following methods were found to no longer be in use:
> ice_is_pca9575_present
> ice_mac_fltr_exist
> ice_napi_del
> 
> Remove them.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c    | 15 -------
>  drivers/net/ethernet/intel/ice/ice_lib.h    |  2 -
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 19 --------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 -
>  drivers/net/ethernet/intel/ice/ice_switch.c | 48 ---------------------
>  drivers/net/ethernet/intel/ice/ice_switch.h |  1 -
>  6 files changed, 86 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

