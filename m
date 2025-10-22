Return-Path: <netdev+bounces-231557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F16BFA828
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F503A5503
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127D2F5A27;
	Wed, 22 Oct 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1GopDTiI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272722F60A3;
	Wed, 22 Oct 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117675; cv=none; b=A6Egz4hi7nB3/Va22DXau30qBO1pzoWdZe0gj4xvH4v0mq5e36gGtkCV4J6efbwQOFN/Pg8YJQ77KEOXgMG0/4HRmxatII9urIGgeSad4AU2yrptVVNe/nsFd9dSKxXRbqzN4+28mu6S194TpgrrRrtNCGOkiX7bYMlzk0Ec2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117675; c=relaxed/simple;
	bh=0X5dKAa3SDLazlwXWahk+LqNH9yNqgRauGM8jTpWM0c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh1RxM+LbGReODYiFK2Pud9GW/u+wu5rfWaqDW+nU9lHM0sKOejYo+qvmg42So48ynK732QaaZaEj4jOQPDOGorilgZb/K6mjJ8D/7PRlmRsyIqDYp8c6YwBCXVmkM5lA93HpxKVJPMDu8sbG6dNYWAiOE6JZokyZRwbVend7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1GopDTiI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761117674; x=1792653674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0X5dKAa3SDLazlwXWahk+LqNH9yNqgRauGM8jTpWM0c=;
  b=1GopDTiI3tmWKyCv+oCrG4d57uE8rsolGaXUjBh1GSoYl8YGh8EK4IrV
   mAhY3AyAg0nU8q5XtvZpZ1nSImXfmKdvwuT3KjWl9Lmt55PqhTdGJ64HX
   v8Bz/JcrZkZXWYC2vBRKU3yT5h5M+vOo+T/ulidll0Fq+Ttou9LTIUxNx
   Fvv8b9LGknwHb61hgVDFAHw3haOp5F31NsSj5IVkGK0pgu0grB6MlqQR3
   7pYBOVD58P87UabB5QlG42X6yt1kIggHNCn6bSVsaAOTQmk9qmld6KOyw
   6MqXXId24pXGdAo1rHZAwgzK47UVMNGZjy9pXDs2A4rf144dRqmd7yUmn
   g==;
X-CSE-ConnectionGUID: QDBNyPrKTQKJzRb0uyzElQ==
X-CSE-MsgGUID: izQcmeufRmmFU+brtPJG6Q==
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="279477685"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 00:21:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Oct 2025 00:20:26 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Oct 2025 00:20:25 -0700
Date: Wed, 22 Oct 2025 09:19:18 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Robert Marko <robert.marko@sartura.hr>, <daniel.machon@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luka.perkov@sartura.hr>
Subject: Re: [PATCH net] net: phy: micrel: always set shared->phydev for
 LAN8814
Message-ID: <20251022071918.2uytekajbs5g23dw@DEN-DL-M31836.microchip.com>
References: <20251021132034.983936-1-robert.marko@sartura.hr>
 <17e75178-582f-495d-97fa-0868c79b7026@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <17e75178-582f-495d-97fa-0868c79b7026@lunn.ch>

The 10/21/2025 15:32, Andrew Lunn wrote:

Hi,

> 
> On Tue, Oct 21, 2025 at 03:20:26PM +0200, Robert Marko wrote:
> > Currently, during the LAN8814 PTP probe shared->phydev is only set if PTP
> > clock gets actually set, otherwise the function will return before setting
> > it.
> >
> > This is an issue as shared->phydev is unconditionally being used when IRQ
> > is being handled, especially in lan8814_gpio_process_cap and since it was
> > not set it will cause a NULL pointer exception and crash the kernel.
> >
> > So, simply always set shared->phydev to avoid the NULL pointer exception.
> >
> > Fixes: b3f1a08fcf0d ("net: phy: micrel: Add support for PTP_PF_EXTTS for lan8814")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> Please could you look at how this patch and
> 
> [PATCH net-next v2] net: phy: micrel: Add support for non PTP SKUs for lan8814
> 
> work together. It might be this patch is not required because of
> changes in that patch?

I managed to reproduce this issue also with the patch:

[PATCH net-next v2] net: phy: micrel: Add support for non PTP SKUs for lan8814

The way I reproduced the issue is by disabling the config PTP_1588_CLOCK
and then just set the port up to get an interrupt.
Then I try to apply this patch and then the issue was fixed.

Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Thanks
>         Andrew

-- 
/Horatiu

