Return-Path: <netdev+bounces-188599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4BAADCF8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60051BA1683
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF6215F5D;
	Wed,  7 May 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ4UFZE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B57215F49;
	Wed,  7 May 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615988; cv=none; b=O5RRyaROz1EaZ5v5ovZbaxQYkKMni+rFVJForvaM13HK+IThJ/BdU2W4vCOFtCT+Wusa7T/f7HYRW2X6FOQssxrKLETIrrY86ablAMzKfAuZV9f96rAxELetF4OamiebqEsJhEdB+lXNFozW4/VODjglxw4Mv8b6a4D8jOVPQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615988; c=relaxed/simple;
	bh=x6JZx+dOYymoRNv+YG8960djGVqVEcH0E3ay4BxKGss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpBjSiminz0l8BUkabq91gLLSUly8s20ZIGnDCU570hO/uFkiO8d1P2M4NmkA+XItvIFyBtjfrtkxo2zlLE/vxpOjrjYFyOsQ9oBY1axrfy3Q/YSEHm+hcUOqiz1kfl0No0UjsxXTuVoNBZ1rXRUko/dlzLcbXTWq+2JLAKz9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ4UFZE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7642AC4CEE7;
	Wed,  7 May 2025 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746615988;
	bh=x6JZx+dOYymoRNv+YG8960djGVqVEcH0E3ay4BxKGss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ4UFZE7muTuWd5GcbVqwDA1zs7oSSrN0OZsKGydTQNoAe5fZ+YxTKEKXmzA0uhbs
	 V1qlyS9BVuunskNg101PiJeI0r/gRvYL1h4PMRvC6pZRwPF3ZQ/17m1qVlnLkq+Uc/
	 9EBbdMXYPpyjslgWDmXjlB1lCMTw7RwH0l5uAttumKzAObETzWGcs+2ddjKTxtY1AD
	 Zco1ngz84KPnVTQ+k5YQtJX9CLvrHKdOaSc3ewX5Bfijhn358nWM9mDvoaiiIby5+x
	 ooKVq+AT6EaXXwaRi28HX7LMXb0WJkPWcAth3keDwxcYsXRZxYc2vZ3Zm2aN4V7gWp
	 LMyQIvlgErNMw==
Date: Wed, 7 May 2025 12:06:21 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
Message-ID: <20250507110621.GJ3865826@google.com>
References: <20250430101126.83708-1-ivecera@redhat.com>
 <20250430101126.83708-9-ivecera@redhat.com>
 <20250501132201.GP1567507@google.com>
 <a699035f-3e8d-44d7-917d-13c693feaf2e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a699035f-3e8d-44d7-917d-13c693feaf2e@redhat.com>

On Fri, 02 May 2025, Ivan Vecera wrote:

> 
> 
> On 01. 05. 25 3:22 odp., Lee Jones wrote:
> > On Wed, 30 Apr 2025, Ivan Vecera wrote:
> > 
> > > Register DPLL sub-devices to expose the functionality provided
> > > by ZL3073x chip family. Each sub-device represents one of
> > > the available DPLL channels.
> > > 
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > > v4->v6:
> > > * no change
> > > v3->v4:
> > > * use static mfd cells
> > > ---
> > >   drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
> > > index 050dc57c90c3..3e665cdf228f 100644
> > > --- a/drivers/mfd/zl3073x-core.c
> > > +++ b/drivers/mfd/zl3073x-core.c
> > > @@ -7,6 +7,7 @@
> > >   #include <linux/device.h>
> > >   #include <linux/export.h>
> > >   #include <linux/math64.h>
> > > +#include <linux/mfd/core.h>
> > >   #include <linux/mfd/zl3073x.h>
> > >   #include <linux/module.h>
> > >   #include <linux/netlink.h>
> > > @@ -755,6 +756,14 @@ static void zl3073x_devlink_unregister(void *ptr)
> > >   	devlink_unregister(ptr);
> > >   }
> > > +static const struct mfd_cell zl3073x_dpll_cells[] = {
> > > +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
> > > +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
> > > +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
> > > +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
> > > +	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
> > > +};
> > 
> > What other devices / subsystems will be involved when this is finished?
> 
> Lee, btw. I noticed from another discussion that you mentioned that
> mfd_cell->id should not be used outside MFD.
> 
> My sub-drivers uses this to get DPLL channel number that should be used
> for the particular sub-device.
> 
> E.g.
> 1) MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2);
> 2) MFD_CELL_BASIC("zl3073x-phc", NULL, NULL, 0, 3);
> 
> In these cases dpll_zl3073x sub-driver will use DPLL channel 2 for this
> DPLL sub-device and ptp_zl3073x sub-driver will use DPLL channel 3 for
> this PHC sub-device.
> 
> platform_device->id cannot be used for this purpose in conjunction with
> PLATFORM_DEVID_AUTO as that ->id can be arbitrary.
> 
> So if I cannot use mfd_cell->id what should I use for that case?
> Platform data per cell with e.g. the DPLL channel number?

Yes, using the device ID for anything other than enumeration is a hack.

Channel numbers and the like should be passed as platform data.

-- 
Lee Jones [李琼斯]

