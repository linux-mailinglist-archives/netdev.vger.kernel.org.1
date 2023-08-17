Return-Path: <netdev+bounces-28546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C877FCBD
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB46B1C214CF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21961171A4;
	Thu, 17 Aug 2023 17:09:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E5174C5
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 17:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91FDC43395;
	Thu, 17 Aug 2023 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692292189;
	bh=vs0TJaqKk6L5saGTEiMJY047+Q/0bMAeGCAf/v+DYM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMmrBd9w3Kfc/paUv9sjHyEpGiWo5Z06hQMmyAChDZLST275KcC6Fab7TM8eVs2Vx
	 wIreCLRiAeWl2werqB0w3SSYnCjmU2YytDLg0SmeR1MulCbsVnkCHfzTeoQ8Ps5bZD
	 anDeBjZfk/drno09LuR4FuFrtF4i+hDYP5J1tpH7JcdVSVsvElQLzN8zVR4OPZ46PB
	 dlbkTIi+26bieAJCyXnlDSo+Fnfth4qUBXERbUrgna8UUZMO/3Bkr7uX0p4yhBxnpz
	 bdQq+oW7gI/3/qwrGPThEP4gAc/dhuVVe3V2S5N31g/jST2jMPjuTPGpd8PSRLSrCM
	 hB/6ScE+db82A==
Date: Thu, 17 Aug 2023 20:09:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 09/14] ice: Remove redundant VSI configuration
 in eswitch setup
Message-ID: <20230817170945.GS22185@unreal>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-10-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204736.1325132-10-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 01:47:31PM -0700, Tony Nguyen wrote:
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> Remove a call to disable VLAN stripping on switchdev control plane VSI, as
> it is disabled by default.
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

