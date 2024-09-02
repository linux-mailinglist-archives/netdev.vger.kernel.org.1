Return-Path: <netdev+bounces-124301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B37968E18
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F601C2203F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF81547DB;
	Mon,  2 Sep 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWY29MFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D21A3A98;
	Mon,  2 Sep 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303985; cv=none; b=XFH730hl8yiBJZHSf4ws9JqiMlOFXRskg/a+yvkOIFKOV8D0hUMOD1miIPy3FHQqVPq7uftpjsbgliluF6cNtWL9A3ATdWm3KqGCDuKDB3g8Z9ovZAUynid8iyjNNvEIpCnAlKTSwZvcGe/acJCm2qMnEqE+nKarhlHQXSow3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303985; c=relaxed/simple;
	bh=9gi4vtZ53gXL63JT96oPtYo589ZDEjl2XCscZ9LWgw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/zQETscmfedaIYOVJGUkjoP2Rb8xNqtKewJo5Rd9ctufk4EP3YgeY5w/VuoDNmA5VYJMHgrfxGBn8AoqXu7K5KnZmfkeZ4NJZW961yrAHcykUSdcO1PHKP1yHOd73d3IE/uC5Uhr7IQkjPJ8eYaIHdTqzzydjIeVbghph8vV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWY29MFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DACBC4CEC7;
	Mon,  2 Sep 2024 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303985;
	bh=9gi4vtZ53gXL63JT96oPtYo589ZDEjl2XCscZ9LWgw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWY29MFxSs9+qUQPzahYj8583WiTEixPQFJO5mH3WwjAArQEu8pRtOZNVcLGWcLdA
	 IE0F0Zr6yKmwuJ0RFCnbyIkBybRRFmux/3QBjOJO/l9JMmwjRsDKydWCSxCa1nlp6v
	 MWclHR0jsXaZ0arklZED0Nv6R2E4OpuIlQRyTURZ1NtIt9MtmdENAlRuhWV/AKgp6d
	 Ct3oUj8V9q3tSMZ2kK6m6NsO7cHUuK+z4EQ6uIpZJnmuEHTDP4BC6cYlv3CLv0YccI
	 SbvS6Cp+jnRoapommuAC0yP26KVxVq+7Ve6AcmGx3zZxTYwx2te+QBOS8OzWgDF+Y5
	 y92vzBwQGeRCg==
Date: Mon, 2 Sep 2024 20:06:20 +0100
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, andrew@lunn.ch,
	kernel-team@meta.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: fbnic: Fix modpost undefined error
Message-ID: <20240902190620.GM23170@kernel.org>
References: <20240902131947.3088456-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902131947.3088456-1-ruanjinjie@huawei.com>

On Mon, Sep 02, 2024 at 09:19:47PM +0800, Jinjie Ruan wrote:
> When CONFIG_FBNIC=m, the following error occurs:
> 
> 	ERROR: modpost: "priv_to_devlink" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "page_pool_create" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_info_serial_number_put" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "page_pool_alloc_pages" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_priv" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "page_pool_put_unrefed_page" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_unregister" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_alloc_ns" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_register" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 	ERROR: modpost: "devlink_free" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
> 
> The driver now uses functions exported from a helper module
> but fails to link when the helper is disabled, select them to fix them
> 
> Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Thanks,

I believe a patch for this problem is already present upstream.

- 9a95b7a89dff ("eth: fbnic: select DEVLINK and PAGE_POOL")
  https://git.kernel.org/netdev/net-next/c/9a95b7a89dff

-- 
pw-bot: not-applicable

