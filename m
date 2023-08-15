Return-Path: <netdev+bounces-27766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB577D1EA
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707D51C20E23
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7414AA1;
	Tue, 15 Aug 2023 18:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735614276
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65444C433C7;
	Tue, 15 Aug 2023 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692124471;
	bh=zMC6PsjUY3Yq7OJqlmuW8VvAtLE3VXwPHaS/2IG7fF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbCVnCQHd4Ol7D5gUzgfD38w3NXS6NxA1sxpFEJZqY/UDp3BtlLog7cBLVPFxDw7d
	 eN5dFKQWbDvLzaCXeQ+jmIhr5VYWR8XQMg2iE4qTnl0UmTR+S6dsHlTq2WZUJaD+gq
	 7Bws6aVH9HAK0XQ5uFOvrOFmC4e8ejnq0nkTwwKcWdH309kaiV864MwPPFLErjnzeg
	 fxIwVaBuagoOuBwAhozuXA6ktaQqqoO+Llc94jJUCsnHuKbnqIBK9Rou31hTmrCfU3
	 ty+18QFNFjQ5z+UpboLnyHeGqNsPkE0DxfuPFpOsmf6ydSuq0KtV0IYqMDjMvSy4y2
	 R7ZYNDYxyq63A==
Date: Tue, 15 Aug 2023 21:34:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	jacob.e.keller@intel.com, horms@kernel.org,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v3 1/5] ice: remove FW logging code
Message-ID: <20230815183426.GT22185@unreal>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815165750.2789609-2-anthony.l.nguyen@intel.com>

On Tue, Aug 15, 2023 at 09:57:46AM -0700, Tony Nguyen wrote:
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> The FW logging code doesn't work because there is no way to set
> cq_ena or uart_ena so remove the code. This code is the original
> (v1) way of FW logging so it should be replaced with the v2 way.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  78 -------
>  drivers/net/ethernet/intel/ice/ice_common.c   | 217 ------------------
>  drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
>  drivers/net/ethernet/intel/ice/ice_main.c     |   3 -
>  drivers/net/ethernet/intel/ice/ice_type.h     |  20 --
>  5 files changed, 319 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

