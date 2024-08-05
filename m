Return-Path: <netdev+bounces-115837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FC947F84
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557C4284FD0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617815B97E;
	Mon,  5 Aug 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDaoH39T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B763E479
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876077; cv=none; b=jmRDK+5pSl0ZLBqDJz7oKnau7HFsiuB+YNXQLMNvYE6g7J2L7I/mZ/7p7m+cgDKDNP18C1boHXJvrfR1v8jHksDx1W1wP6s2gQfEgAfd41ro0yC2zWWzAyR4xefqz+TyFcArTVowkympmc1yTdGKWobiv8MTfbISLO0VEUVW7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876077; c=relaxed/simple;
	bh=nh8tZd8NrCakiZtXJuJ0i+pgpG13+xDZ0JjvP+4sW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mewPPiFsbSfrx+KJfcMSwvNQ/PVziok95XnHj7wuvF0eA2nsXR8WQ+2HzaW9cclckQRXEZkCU/BydInPpjVgf5Gphqzps6ky0xmkbWESqGPyy5CwPHg46cs5UkD0D8NKFu8A2E9m85EWGeNu193hGaDXk5kIue8ySRSWl6ySGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDaoH39T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B2C32782;
	Mon,  5 Aug 2024 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876077;
	bh=nh8tZd8NrCakiZtXJuJ0i+pgpG13+xDZ0JjvP+4sW7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDaoH39T8WUmsOHHByE/zznxkK7ZiBz8i/Xkp2elTmowOd88QkSDrA4LcsFvv3V4Y
	 GPsMhbAZdr9ItBUhcH1PfZv+Cv7H82tr+OVKrsA0JwX8wPpCdec/YMDsqCi5teAhdz
	 2VU2Jd1ZDzrj/YYekmyaLwewvTDmhVCRjylLsrWGYO4LQ/EaB7decRRLaSzAmKDD8s
	 k6W5E7NuhsaTlLGgYtnZdAUNbSru5/f75klNdTi/FoP344IXR+jKWclJBldoEvb3/r
	 ji1X4K42evD39xk7SDFj5XIV5FeUWG2sc2kaFqaCgI3QvlYy+Eid0tJx38l1PYujNU
	 RWNyvrs/CSJjw==
Date: Mon, 5 Aug 2024 17:41:14 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/10] net: libwx: allocate devlink for
 devlink port
Message-ID: <20240805164114.GI2636630@kernel.org>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <5CCBD90FF2823C29+20240804124841.71177-8-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CCBD90FF2823C29+20240804124841.71177-8-mengyuanlou@net-swift.com>

On Sun, Aug 04, 2024 at 08:48:38PM +0800, Mengyuan Lou wrote:
> Make devlink allocation function generic to use it for PF and for VF.
> 
> Add function for PF/VF devlink port creation. It will be used in
> wangxun NICs.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_devlink.c b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
> new file mode 100644
> index 000000000000..b39da37c0842
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +
> +#include <linux/vmalloc.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_sriov.h"
> +#include "wx_devlink.h"
> +
> +static const struct devlink_ops wx_pf_devlink_ops = {
> +};
> +
> +static void wx_devlink_free(void *devlink_ptr)
> +{
> +	devlink_unregister((struct devlink *)devlink_ptr);
> +	devlink_free((struct devlink *)devlink_ptr);
> +}
> +
> +struct wx_dl_priv *wx_create_devlink(struct device *dev)
> +{
> +	struct devlink *devlink;
> +
> +	devlink = devlink_alloc(&wx_pf_devlink_ops, sizeof(devlink), dev);

Perhaps this should be sizeof(wx_dl_priv *) ?

Flagged by Coccinelle.

> +	if (!devlink)
> +		return NULL;
> +
> +	/* Add an action to teardown the devlink when unwinding the driver */
> +	if (devm_add_action_or_reset(dev, wx_devlink_free, devlink))
> +		return NULL;
> +
> +	devlink_register(devlink);
> +
> +	return devlink_priv(devlink);
> +}
> +EXPORT_SYMBOL(wx_create_devlink);

...

