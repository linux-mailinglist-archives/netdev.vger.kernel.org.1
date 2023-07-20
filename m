Return-Path: <netdev+bounces-19542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8575B241
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C891C2145C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0718B11;
	Thu, 20 Jul 2023 15:17:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059C18AF6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65510C433C9;
	Thu, 20 Jul 2023 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689866263;
	bh=qYHzhCAUIzF07jkVYTmVpGY6QuZJidrqSGysBgEQ+mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P16yasElhZTEVFOLsqDGNj4lriTO6FsUW8YABCZuFpIMFix1NMiwqPaxeOXOJGNOk
	 VfOItlUQjULagwjy03aN/moX4p0fVX1uyxELFFx7ST2p8Y2LanDjA80FYWJYqo902U
	 B1dPtPEPCXdcO2vuWr+smF+q+CudYO+XVVfGf4muamAjCqLdYs5ly7RxarL53ghMO1
	 c7z4tglFywO9GUJRvnBTv0bIV43yd7al05bkCq1t3oVmo4Q8veUrMy96QxeUPfZzHU
	 5XBwXPyYA9MApwhmFlvKbYMA+lkCuL/2H3vC+cqcQMFlqFT90CDLJVT0Z8BkAASI1o
	 Buaey1/Wipc4w==
Date: Thu, 20 Jul 2023 08:17:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Md Danish Anwar <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v10 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
Message-ID: <20230720081741.0c32d5e6@kernel.org>
In-Reply-To: <17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
References: <20230719082755.3399424-1-danishanwar@ti.com>
	<20230719082755.3399424-3-danishanwar@ti.com>
	<20230719213543.0380e13e@kernel.org>
	<17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 17:12:50 +0530 Md Danish Anwar wrote:
> Patch 1: Introduce Firmware mapping for the driver (icss_switch_map.h)
> 
> Patch 2: Introduce mii helper APIs. (icssg_mii_rt.h and icssg_mii_cfg.h). This
> patch will also introduce basic prueth and emac structures in icssg_prueth.h as
> these structures will be used by the helper APIs.
> 
> Patch 3: Introduce firmware configuration and classification APIs.
> (icssg_classifier.c, icssg_config.h and icssg_config.c)
> 
> Patch 4: Introduce APIs for ICSSG Queues (icssg_queues.c)
> 
> Patch 5: Introduce ICSSG Ethernet driver. (icssg_prueth.c and icssg_prueth.h)
> This patch will enable the driver and basic functionality can work after this
> patch. This patch will be using all the APIs introduced earlier. This patch
> will also include Kconfig and Makefile changes.
> 
> Patch 6: Enable standard statistics via ndo_get_stats64
> 
> Patch 7: Introduce ethtool ops for ICSSG
> 
> Patch 8: Introduce power management support (suspend / resume APIs)
> 
> However this structure of patches will introduce some APIs earlier (in patch
> 2,3 and 4) which will be used later by patch 5. I hope it will be OK to
> introduce APIs and macros earlier and use them later.
> 
> This restructuring will shorten all the individual patches. However patch 5
> will still be a bit large as patch 5 introduces all the neccessary APIs as
> driver probe / remove, ndo open / close, tx/rx etc.
> 
> Currnetly this single patch has close to 4000 insertion and is touching 12
> files. After restructring patch 5 will have around 1800 insertions and will
> touch only 4 files (icssg_prueth.c, icssg_prueth.h, Kconfig, Makefile). This is
> still significant improvement.
> 
> Please let me know if this is OK.

SGTM, thanks! One patch still being larger than others is a bit
inevitable.

> Also this patch has Reviewed-By tag of Andrew. Can I carry forward his
> Reviewed-By tag in all patches or do I need to drop it?

If the code is identical I reckon you can carry it.

