Return-Path: <netdev+bounces-115838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B195947F85
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA359284E03
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543C15B97E;
	Mon,  5 Aug 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz4qorLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF83E479
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876117; cv=none; b=IEzoJZ0W4+iN+kWAfopXBz8OINxOhFaxmwkvMsbZVa0/tApCl/AdtJLvGOC7TtlyAhnm+ojVTUeJrvXmr1mjWC7ZBq/DdBUlFdvMmiEXXBos48jAdxyL/V1HKmhV8VNOCERk8FTEijdnEKoctf75JTIcIliKpEBK/xG6HCuEVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876117; c=relaxed/simple;
	bh=jG0dL9NG8NCb4BlhNYX+BcCg1vAW9fmvE2XvL1T2kkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKsrX2mZsiXIqsSLgYb7Dtti+Gmsk9PmLy6BIvyClDIDHpwQjJx6L3LEag+kptbE5V7iEckWHu8ISWTatJjjkpMIUeqOKsm/KhBZxVO+/eWcZ/Ygl8hhZ8eDTQKxYtIXYqjRi9Yd2X4SUXBpTtVn3EXPWo9CL7jGgVc75AlSmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz4qorLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1169C32782;
	Mon,  5 Aug 2024 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876117;
	bh=jG0dL9NG8NCb4BlhNYX+BcCg1vAW9fmvE2XvL1T2kkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pz4qorLH2JBSRkVTUK3Lic+p4YybcBvgutsO+q3xr6KRnTdul/XUt2Ay8mHkSZkVE
	 q/3KHh6HGSPF8R1sbZOgmKzDEJ5Usex01kPpwZPx+tzZdAZco86gDgg8ITwd0eTtpt
	 Z85XPCBvF2uLJNV0cxWyfkg9x1mVzuUzH+KgXyZU8kmwv4ppejPxSUwvlMx/DyY/s7
	 7PcFCD8Oa45Xd3B2BwuMurOHAocFwp4yHQCIXp4Xmokv93UuugoXRSg4LbXXYZEPLV
	 5q9du29XTbTmY9/yBydepidDavXdqr1Lv48l6flbMoerAH0TFUatYaPQR1+grgUgco
	 m3f7Svx02jE2A==
Date: Mon, 5 Aug 2024 17:41:54 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/10] net: libwx: Add malibox api for
 wangxun pf drivers
Message-ID: <20240805164154.GJ2636630@kernel.org>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <78F07A41FB029765+20240804124841.71177-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78F07A41FB029765+20240804124841.71177-2-mengyuanlou@net-swift.com>

On Sun, Aug 04, 2024 at 08:48:32PM +0800, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..5062ddb2ce39
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,175 @@
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
> + *  return: return 0 on success and -EBUSY on failure
> + **/
> +static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
> +{
> +	int count = 5;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox = rd32(wx, WX_PXMAILBOX(vf));
> +		if (mailbox & WX_PXMAILBOX_PFU)
> +			return 0;
> +		else if (count != 1)

Should this be 'else if (count)' in order to skip the delay
on the last rather than 2nd to last iteration without success?

> +			udelay(10);
> +	}
> +	wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
> +
> +	return -EBUSY;
> +}

...

