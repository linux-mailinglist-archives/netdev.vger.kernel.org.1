Return-Path: <netdev+bounces-90712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7B8AFCFE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 01:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AC0285A26
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470674644C;
	Tue, 23 Apr 2024 23:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58553800
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916749; cv=none; b=P0p0+dluThuNZtkOuC3B5t06SZt6pU9OyQcyzi6OJWpAwlElRmi3KBhpgnw41cnudAALHFBIi7LQT8LCvsozX0K2LRaEvmLWCuDuFJcnhH974RUrure6ysgRVYNZQJmWRtd6GbxDwj1Mcn85FvfDVpd8ESV3R2Q3kJL0nG7J5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916749; c=relaxed/simple;
	bh=v5HpaNzjnS+nzagCgPnhRXGNmlFHAWypeXId0ro+rLs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow8hSuiRg7R+YYwHZStA6ALyqcCnzM7PgH9D/HpXvJbY/Pdk1b0g+Dtd1uttJz9UNK0W1C0HRvVHOpZpa0/vLlbh2dhUE6eOD91dUEQLiDSL4W/tmRN96lrOk3lVay6dw2UXFpilZxUrg6T9gt6NEH7W3N+x3dvbMKnbeHO6UkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 772b339a-01cd-11ef-b972-005056bdfda7;
	Wed, 24 Apr 2024 02:59:05 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 02:59:04 +0300
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Duanqiang Wen <duanqiangwen@net-swift.com>,
	"open list:SYNOPSYS DESIGNWARE I2C DRIVER" <linux-i2c@vger.kernel.org>,
	"open list:WANGXUN ETHERNET DRIVER" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/4] i2c: designware: Create shared header hosting driver
 name
Message-ID: <ZihLSKe_BHxasBql@surfacebook.localdomain>
References: <20240423233622.1494708-1-florian.fainelli@broadcom.com>
 <20240423233622.1494708-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423233622.1494708-2-florian.fainelli@broadcom.com>

Tue, Apr 23, 2024 at 04:36:19PM -0700, Florian Fainelli kirjoitti:
> We have a number of drivers that reference the string "i2c_designware"
> yet this is copied all over the places with opportunities for this
> string being mis-used. Create a shared header that defines this as a
> constant that other drivers can reference.

...

>  #include <linux/i2c.h>
> +#include <linux/i2c-designware.h>

Can it be hidden in the subfolder?

...

> -#define DRIVER_NAME "i2c-designware-pci"
> +#define DRIVER_NAME I2C_DESIGNWARE_NAME "-pci"

Oh, this makes all the things hard to read.

>  /* Work with hotplug and coldplug */
> -MODULE_ALIAS("i2c_designware-pci");
> +MODULE_ALIAS(DRIVER_NAME);

I believe we shouldn't use MODULE_ALIAS() without real justification.

...

> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c

All as per above.

-- 
With Best Regards,
Andy Shevchenko



