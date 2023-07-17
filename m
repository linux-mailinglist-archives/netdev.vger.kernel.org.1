Return-Path: <netdev+bounces-18186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAAE755AFD
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F49A1C2092F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C266ADF;
	Mon, 17 Jul 2023 05:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759D15B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A0C433C7;
	Mon, 17 Jul 2023 05:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689573118;
	bh=TPHlk2vHNzE2ksqGQ3jqBZv6lNGQTuSrtKfYzPfbLdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVp3iDCTevV7/oqmSyT3tawf+uZs05PZzNCdeZJSvK+hnFy5eNg4tgfmThkzt0aJ3
	 K0gdAQhYc0ZVs9zdqq7RrIV+1lwkhrL1Z3lLYXSU1hBK5+BVLjvO6QBtVrx9+w36js
	 7xYJ33AUORPerRAiTax+f2LvmFnooB6ePR2eTmSshd5nYVZrhcZLZd1fXMuyOSUBfU
	 9IvLPGRalsphLGuuKgz9evnnkHWq7avT2teaX4MbRSDIWxNh/dfefdH2enzl9dfGwX
	 q51YPZ6/Fa19J4V9sRCu0UqBKy6x/Xbg3s7Slcy3c/LYzNPOTUekTQGqFg8jA0+3lG
	 9BLtBZaSH8PXw==
Date: Mon, 17 Jul 2023 08:51:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, simon.horman@corigine.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v4] net: txgbe: change LAN reset mode
Message-ID: <20230717055155.GD9461@unreal>
References: <20230717021333.94181-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717021333.94181-1-jiawenwu@trustnetic.com>

On Mon, Jul 17, 2023 at 10:13:33AM +0800, Jiawen Wu wrote:
> The old way to do LAN reset is sending reset command to firmware. Once
> firmware performs reset, it reconfigures what it needs.
> 
> In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> block PHY domain in LAN reset. At this point, writing register of LAN
> reset directly makes the same effect as the old way. And it does not
> reset MNG domain, so that veto bit does not change.
> 
> Since veto bit was never used, the old firmware is compatible with the
> driver before and after this change. The new firmware needs to use with
> the driver after this change if it wants to implement the new feature,
> otherwise it is the same as the old firmware.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v3 -> v4:
> - detail commit log
> - drop fixes tag
> v2 -> v3:
> - post to net-next
> v1 -> v2:
> - detail commit log
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 65 -------------------
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |  1 -
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  8 +--
>  3 files changed, 4 insertions(+), 70 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

