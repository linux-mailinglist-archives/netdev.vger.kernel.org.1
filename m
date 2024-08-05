Return-Path: <netdev+bounces-115839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75DF947F86
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD7C1C210DD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44D15C12C;
	Mon,  5 Aug 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqpewI9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759743E479
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876233; cv=none; b=WokrLoA4Sah6Vqr/UCJwUsuFHjmnpF3j57gQYraYTk1JijZbzwyQ5ZEBRzdBy/pwRXgqFNlEi/vChqcbGIoO4Fq3L/5i/pAcLbRebbBPRhozCVuLTnao2oKH8XHWJN3+HW0Rw8ck4wRrGsFOT433jtea+mdHuWVuSww268YNDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876233; c=relaxed/simple;
	bh=IYzpIwgA749ubwDygqpbEn776r+mWf0oLwip73DVMlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9/9ELjFUhQ4V6EXccHlpxispJMoqaEcXLUMk90dstN5mpy+KSKA6QLWK3oUNE9mGsQX8Y07OXMw//sIR7aPGsRmIZNMMzh3AOY67Y4dnGfrkAlPJ9ha0V3Ggo4soNVQlZTuyKp3DihlZdtlkcj+qbKWji0RBGN2VpLX37QsL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqpewI9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F14CC32782;
	Mon,  5 Aug 2024 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876233;
	bh=IYzpIwgA749ubwDygqpbEn776r+mWf0oLwip73DVMlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqpewI9OOvyZmfgD1idpqNKZ7lOkuYQKrPv0AlOxNsweZOIlvylqzPmj4qN7Zd22K
	 3OY2j3RGR3Qk7dSYmf3lYWzGat8HxrVr9YcvTUDPk2D1lKr6xzloo/0JxTPh8WD2EU
	 xHp9txoKRPAwYF6QA3s3N67qsJ0KfOuq7j689NpQNY+AKjXEBERZkw2FvSSFphVsY0
	 ACtQ9wjeGNNwI7FMVEDhIwJ0ehPPVnPLzQeBWP24hEPNIR032CsCLDWl40dG0u3mfS
	 z6yLf22RQShthmoyUXlkUIE7dzVan/nggkTVA4mz90fYz7dCF3bYsfpxR0mmBIPRxS
	 glOQ+eEJEa/iQ==
Date: Mon, 5 Aug 2024 17:43:50 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for
 devlink ops
Message-ID: <20240805164350.GK2636630@kernel.org>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>

On Sun, Aug 04, 2024 at 08:48:39PM +0800, Mengyuan Lou wrote:

Each patch needs a patch description describing not just what is done
but why.

Also, please seed the CC list for patch submissions
using get_maintainer this.patch. I believe that b4
will do that for you.

> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

>  static void wx_devlink_free(void *devlink_ptr)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
> new file mode 100644
> index 000000000000..a426a352bf96
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2019-2021, Intel Corporation. */

Are you sure Intel holds the copyright on this code?

> +
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_eswitch.h"
> +#include "wx_devlink.h"
> +
> +int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
> +	struct wx *wx = dl_priv->priv_wx;
> +
> +	if (wx->eswitch_mode == mode)
> +		return 0;
> +
> +	if (wx->num_vfs) {
> +		dev_info(&(wx)->pdev->dev,
> +			 "Change eswitch mode is allowed if there is no VFs.");

maybe: Changing eswitch mode is only allowed if there are no VFs.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (mode) {
> +	case DEVLINK_ESWITCH_MODE_LEGACY:
> +		dev_info(&(wx)->pdev->dev,
> +			 "PF%d changed eswitch mode to legacy",
> +			 wx->bus.func);
> +		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
> +		break;
> +	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
> +		dev_info(&(wx)->pdev->dev,
> +			 "Do not support switchdev in eswitch mode.");
> +		NL_SET_ERR_MSG_MOD(extack, "Do not support switchdev mode.");

maybe: eswitch mode switchdev is not supported

I am curious to know if you are planning to implement eswitch mode in the
near future.  If not, is wx_eswitch_mode_set() needed: it seems unused in
this patchset: it should probably be added in a patchset that uses it.

> +		return -EINVAL;
> +	default:
> +		NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
> +		return -EINVAL;
> +	}
> +
> +	wx->eswitch_mode = mode;
> +	return 0;
> +}
> +
> +int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode)
> +{
> +	struct wx_dl_priv *dl_priv = devlink_priv(devlink);
> +	struct wx *wx = dl_priv->priv_wx;
> +
> +	*mode = wx->eswitch_mode;
> +	return 0;
> +}

...

