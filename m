Return-Path: <netdev+bounces-175120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A90A635C7
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214F616DB48
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8419F487;
	Sun, 16 Mar 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KziF8D4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CF1EA91
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742131329; cv=none; b=OLMGDFj4OBX1pk3g6e0xk1F2Itl6SEer7e8NTKadNICuvRtrhEr66Mtr7fLmoIOMI/X0k5BnJEKVQF59VSTrKO/L+QhKuHYhcsCus/JZh9j7VhI0LfRMpOu50rtekj8rzF7/rYkVkOdC1AZlSyCXZeRQ5WeD0f0fp2ePWjoHI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742131329; c=relaxed/simple;
	bh=dJIYi9XqIpGvu0y49VgI+SQYjC4U9xN+ivoowR95nbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpTUMiS92+/9Az/hX7NT1Q6tAgKTOrGuHUuhLPK+3mNZt7f8I4qIwCg0Hp9rxbJA54h1/bg5NE2aqGRCaObtD6lNsm+72yN2khsDgoMBONMUbRUO3KngG4a2yX6vp8/IahccMcQZ39Ku6CByAOuViFsXgG17cZDaMnt3IwH9uXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KziF8D4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AFDC4CEDD;
	Sun, 16 Mar 2025 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742131329;
	bh=dJIYi9XqIpGvu0y49VgI+SQYjC4U9xN+ivoowR95nbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KziF8D4ZRHB2JdI5UMMwTv3QOqHoaR7FyPwpM0XpS6NkM26dm/wN/mxrDy1ZzWd6/
	 m8AbhJaKmWpnf/5YybcPq+9gra/o+UC909FHVxBk0SOk7Xxs3Q7HPCV0KAW3gm1Z/r
	 mVbmWN1bwvE7Q56Km4Ih1a/0DNwfQIDM3ypsCbqdBgiKtODu7OzqcTtyNk5qLdWs/R
	 1VZqnAFeEaW3qWDqIFYJ7lJ+gUfbj73FccUH31Q/pgRShfwI+8VF+vcHXZERosZr9c
	 A+vfAjiHzcrIwVj4ngvKM3gMkfL2pblpBYhu8ylhmn5vI9wUaE1rALevOCPvsGBc+D
	 9EOvptpKztlBA==
Date: Sun, 16 Mar 2025 13:22:04 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v8 2/6] net: libwx: Add sriov api for wangxun
 nics
Message-ID: <20250316132204.GB4159220@kernel.org>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com>
 <20250309154252.79234-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309154252.79234-3-mengyuanlou@net-swift.com>

On Sun, Mar 09, 2025 at 11:42:48PM +0800, Mengyuan Lou wrote:
> Implement sriov_configure interface for wangxun nics in libwx.
> Enable VT mode and initialize vf control structure, when sriov
> is enabled. Do not be allowed to disable sriov when vfs are
> assigned.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> new file mode 100644
> index 000000000000..2392df341ad1
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_mbx.h"
> +#include "wx_sriov.h"
> +
> +static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
> +{
> +	unsigned int vfn = (event_mask & GENMASK(5, 0));
> +	struct wx *wx = pci_get_drvdata(pdev);
> +
> +	bool enable = ((event_mask & BIT(31)) != 0);

Sorry to nit-pick, and I'd be happy for this to be addressed as a
follow-up, but I think that it would be nice to:

1. Both use some #defines and FIELD_GET() for the masking above.

2. Use !! in place of != 0

3. Arrange local variable declarations in reverse xmas tree order.

> +
> +	if (enable)
> +		eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
> +}

...

