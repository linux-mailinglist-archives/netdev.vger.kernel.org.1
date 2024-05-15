Return-Path: <netdev+bounces-96603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0B8C69AF
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC43B21E07
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF7156880;
	Wed, 15 May 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3wmJJEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6215687A
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786897; cv=none; b=V4vSuY1zUYjbb0+89zoFhRspW/vdJ/Ya2ql4vmY5wi4Oihx6Jq1Y9mHJVzFngvDUI+oiPw0rBjQwagoz3X9cOxf3R7PU2io9h5KKfbi5DhtH06I2OypiULq5Pn/3nzi1HuV9uHOJoXfzjAsNd2MhuLo8ph4eZuk/JT14ufOzhUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786897; c=relaxed/simple;
	bh=GytrIhtmdfu0oaB0b2Uah8SUegaI6ji7N51A0DFGszQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpVnuV3jW1EtrCTiNaDaf4rNWe2+nsyae1E48oMreTsQtILBYGVHwuClqfA4fe69QLoK4FSuPYmUq06nQgIzcoKQpJ3QQMZoK8jh+5D5aPpSyJ/eJb8c2BHOcFM+bhL37RS4TOOpVAf3w+mOC61RHBNRpDWc1SnnSBG7exNNqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3wmJJEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC832C32789;
	Wed, 15 May 2024 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715786896;
	bh=GytrIhtmdfu0oaB0b2Uah8SUegaI6ji7N51A0DFGszQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3wmJJEX9mmEGXfhJ5D68k/6fskok+5Ffn6nUdzewpnNxlcGJVQ5Ted4nIimtQslw
	 WDzDwJA938maYDxejMDegb8Xxrz42vBVn7ef5qtIctXcd/+WUbQVv2r5uiaqLzqQBs
	 GHB3QVUEPLQTGNV+A+su6VHfjqVXhYmftwi01/HjqevPP98vgTGy47q7b7LCq4+JFQ
	 hXie60RaBFRMkxeA/kRTULdqZEBS+brQIS7b5JsvCsP4AFlTw/D5vgxqC3xe/I2vRy
	 FJLXb940roA125Zhj2MN8b0rvcgQf95drLUfSTquX84myWV5TEsGfZnGBUxiM2PtgO
	 ZBw5amHblKixA==
Date: Wed, 15 May 2024 16:28:13 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 1/6] net: libwx: Add malibox api for wangxun
 pf drivers
Message-ID: <20240515152813.GO154012@kernel.org>
References: <20240515100830.32920-1-mengyuanlou@net-swift.com>
 <E46F2D38B2634039+20240515100830.32920-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E46F2D38B2634039+20240515100830.32920-2-mengyuanlou@net-swift.com>

On Wed, May 15, 2024 at 05:50:04PM +0800, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..26842043630b
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#include <linux/pci.h>
> +#include "wx_type.h"
> +#include "wx_mbx.h"
> +
> +/**
> + *  wx_obtain_mbx_lock_pf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return SUCCESS if we obtained the mailbox lock
> + **/

Thanks for including a return section in Kernel docs.
It seems that the correct format is (case insensitive)
one of:

* return: ...
* returns: ...

So I think you need to add a ':'.

Likewise elsewhere in this patch-set.

Flagged by ./scripts/kernel-doc -none -Wall

...

