Return-Path: <netdev+bounces-28541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99BC77FC9C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD19C1C21491
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA9171A2;
	Thu, 17 Aug 2023 17:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4B171A3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE470C433B6;
	Thu, 17 Aug 2023 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292177;
	bh=a9TxjpkVEKa1vfH6tVjmdtzwOUGuaCCT6tdsS9drQIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ9YWqK/mRt7TmSRJtAhufUGyIOfAc+WDEX3Wh75zJAgv1wkaKED8KPjeiJELuvgc
	 uIGPhOrMMvchHVQdHQ9Yb7xSa2uWloM4T6zmkdS8PKgED4++2YfnnLG1jtx6v0Zime
	 FxV3yN2pVorVojrny3MrOkY5wLC2DjefvQKxdRlXOewGMOLEoM7t16XXM1MpkUAfBr
	 ahLz5pZ+nNtcy22ETfrKRk4nY6nE0QEuGKO7mTLAfYqqAge0WCNP85QSMAtlWPhGHQ
	 KDrW3ndl7KvTmjkq03W4/SzZd1Ryp9FpoGlS9f3teyDkYZc2TYkgK0+iSihQqm7MTZ
	 gKFRWF/k1E41Q==
Date: Thu, 17 Aug 2023 20:09:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next 08/14] ice: move E810T functions to before
 device agnostic ones
Message-ID: <20230817170932.GR22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-9-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:30PM -0700, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit 885fe6932a11 ("ice: Add support for SMA control multiplexer")
> accidentally placed all of the E810T SMA control functions in the middle of
> the device agnostic functions section of ice_ptp_hw.c
> 
> This works fine, but makes it harder for readers to follow. The
> ice_ptp_hw.c file is laid out such that each hardware family has the
> specific functions in one block, with the access functions placed at the
> end of the file.
> 
> Move the E810T functions so that they are in a block just after the E810
> functions. Also move the ice_get_phy_tx_tstamp_ready_e810 which got added
> at the end of the E810T block.
> 
> This keeps the functions laid out in a logical order and avoids intermixing
> the generic access functions with the device specific implementations.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 358 ++++++++++----------
>  1 file changed, 179 insertions(+), 179 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

