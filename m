Return-Path: <netdev+bounces-149456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616869E5B53
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C30B28568E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA0222594;
	Thu,  5 Dec 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWBx6RTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29742F29;
	Thu,  5 Dec 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415943; cv=none; b=n1ZoDsCzTUITO0jFzpGQBCxindOYCprUXXUfj8E1regCNDOoptcOzsSexPWdiCViRP5lA7SkyaAHWi5lyC4jFla8x0qd57T21B29usKz6io0gG/q+TXyEBFYILrKbgc4Q5A5OIR2wjT3/qLyD5PuishfX0r03f61iF+fzXMLhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415943; c=relaxed/simple;
	bh=/ki5E+7xbCWAwJjJ32uJns8Y1daZpPPT3bCuaz9NeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFvvea4hL4QtFpuXshxCFmPP3XZ8Rr2B7EoLq8u8Atiu7tRmnVI6pHw3R11+VOwmhEPKKDNwzKxWJJF0cXEQrqEPV2XaBAoRdvpC1I2D6xxP6ZDyNvM7iNriwh2ZxA2Woryw2lK5L9eLF1+yjMnrT2XX3QrGB1pHz5AGpS/5wi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWBx6RTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C10C4CEDC;
	Thu,  5 Dec 2024 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415943;
	bh=/ki5E+7xbCWAwJjJ32uJns8Y1daZpPPT3bCuaz9NeYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWBx6RTsZzjMj/eGQnXhL0Dba+kyQiW47to05so9OUaiP/5DRpGs47V6x2myULUyq
	 K/fx6P75wTxkzjfED/IOCGJ0rVJQlGJkj144cwiTnxcSGZ2JN9MxzfM9toXbeTVgZz
	 z3hJ+HMI106VrNl8HrEaHS7vvYhrcXPW3+ZmyU4JrblXB3gj03j/GeBLo6L9N5s9YT
	 i74vY9nZMrAML7W4s/M7WSyD0elLF/8wQLSqEkXTdPu3DRN3dfdYoFFAz5h0ek8Cy/
	 DENQpkVVcxPm8Uk19p6c06iZVnC2CLjK8AoLYkPAoimlOllrZflDbeiqcBSWF0hSRT
	 jKgHJiqgAhSTQ==
Date: Thu, 5 Dec 2024 16:25:37 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V4 RESEND net-next 2/7] net: hibmcge: Add irq_info file
 to debugfs
Message-ID: <20241205162537.GB2581@kernel.org>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-3-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:26PM +0800, Jijie Shao wrote:
> the driver requested three interrupts: "tx", "rx", "err".
> The err interrupt is a summary interrupt. We distinguish
> different errors based on the status register and mask.
> 
> With "cat /proc/interrupts | grep hibmcge",
> we can't distinguish the detailed cause of the error,
> so we added this file to debugfs.
> 
> the following effects are achieved:
> [root@localhost sjj]# cat /sys/kernel/debug/hibmcge/0000\:83\:00.1/irq_info
> RX                  : enabled: true , logged: false, count: 0
> TX                  : enabled: true , logged: false, count: 0
> MAC_MII_FIFO_ERR    : enabled: false, logged: true , count: 0
> MAC_PCS_RX_FIFO_ERR : enabled: false, logged: true , count: 0
> MAC_PCS_TX_FIFO_ERR : enabled: false, logged: true , count: 0
> MAC_APP_RX_FIFO_ERR : enabled: false, logged: true , count: 0
> MAC_APP_TX_FIFO_ERR : enabled: false, logged: true , count: 0
> SRAM_PARITY_ERR     : enabled: true , logged: true , count: 0
> TX_AHB_ERR          : enabled: true , logged: true , count: 0
> RX_BUF_AVL          : enabled: true , logged: false, count: 0
> REL_BUF_ERR         : enabled: true , logged: true , count: 0
> TXCFG_AVL           : enabled: true , logged: false, count: 0
> TX_DROP             : enabled: true , logged: false, count: 0
> RX_DROP             : enabled: true , logged: false, count: 0
> RX_AHB_ERR          : enabled: true , logged: true , count: 0
> MAC_FIFO_ERR        : enabled: true , logged: false, count: 0
> RBREQ_ERR           : enabled: true , logged: false, count: 0
> WE_ERR              : enabled: true , logged: false, count: 0
> 
> The irq framework of hibmcge driver also includes tx/rx interrupts.
> Therefore, TX and RX are not moved separately form this file.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


