Return-Path: <netdev+bounces-28396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694877F530
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AA61C2137A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A3B12B9E;
	Thu, 17 Aug 2023 11:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CF134A4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03301C433C7;
	Thu, 17 Aug 2023 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692271685;
	bh=mOCCWP+aQpqYYR0QDBBb7Gyz3OihgvABvPU85CoBlqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWvfGuHhWH1X0zsu88h7chWASx70gdfjQ/DsTz1bQIe8V5xJxUhpapBSUhBdDUqL0
	 aLwJPleGe3CtUI/1goKb3NQCyPfvW6q8j7yFQzI1IbGTDouT/HkcUzTBHDwVcY2hal
	 N83u9KoFgfJ56UwISOI+jM9zlKz18a5/Xtc212FimVWMSzFTqB3GgThODzjYM/Auvn
	 v+oC37nd8bBcBo9VWNZHjzAFassJ3NEnD9jtr7I7Bx1nD00/ekGwiQfkZ2wSun/orm
	 6LCAN7mESaUrDWybNM28XEz/z8rfHSjhn6htmqSilZHrLWMYa8+VdpeS0zP7AtFCOh
	 AOIrDf2odRXbg==
Date: Thu, 17 Aug 2023 14:28:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>, shannon.nelson@amd.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net 2/2] i40e: fix misleading debug logs
Message-ID: <20230817112801.GI22185@unreal>
References: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
 <20230816193308.1307535-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816193308.1307535-3-anthony.l.nguyen@intel.com>

On Wed, Aug 16, 2023 at 12:33:08PM -0700, Tony Nguyen wrote:
> From: Andrii Staikov <andrii.staikov@intel.com>
> 
> Change "write" into the actual "read" word.
> Change parameters description.
> 
> Fixes: 7073f46e443e ("i40e: Add AQ commands for NVM Update for X722")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

