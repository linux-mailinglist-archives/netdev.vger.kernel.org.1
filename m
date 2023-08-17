Return-Path: <netdev+bounces-28399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5FF77F54A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D921C2135F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FA134AF;
	Thu, 17 Aug 2023 11:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FF12B9B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EE3C433C7;
	Thu, 17 Aug 2023 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692271842;
	bh=pKDzwMi3nRZZ5z+qWc5pfDjhlC6ppP8ra3pgmOCsWn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=al4P+wiO+SvKFv32Gx4nlfNGgCKe53+Uf18Yn+NJVvGo/lHycNjUjcYcvyGSnC6Nx
	 AaWIFZUF18kYgut5oyfqFi0jKWstEv5CoQtMqeN29UbmHpZdyKML7o70a1M5eJVIXK
	 MnwOTm3H3mrtZwjt0oaUiDKWwmSxVUEYMHy+kASYq3k7Gcq91FFWnDBq60USzTwejz
	 5WFkNstKhDPevUSGI/TksQavQmjocSEAWWffzE9Lf4T8iTOjwI3VLCCa6Pmlw6Cmy5
	 kW7eEcO0gjd0EIFYmY6UfpN6t7wrXADS7fZl8AIOyWtuB83ktg6UO2qilDwr4YdbHi
	 MgA3dQgzyJGGA==
Date: Thu, 17 Aug 2023 14:30:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 03/14] ice: refactor ice_lib to make functions
 static
Message-ID: <20230817113037.GL22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-4-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:25PM -0700, Tony Nguyen wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As following methods are not used outside of ice_lib,
> they can be made static:
> ice_vsi_is_vlan_pruning_ena
> ice_vsi_cfg_frame_size
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 70 ++++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_lib.h |  3 -
>  2 files changed, 35 insertions(+), 38 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

