Return-Path: <netdev+bounces-239873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 065DCC6D725
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB524F8F1C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C02DECA0;
	Wed, 19 Nov 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JaTguXb9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245B329C4F;
	Wed, 19 Nov 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540820; cv=none; b=FKp2/15G/kYS7pJRF/i/tzujtqgrntDWj4vYv1j6MvXB7K+8srRTRdJk1GAnp37o+qP3ZFUvhEUBPJE3K0xrlapChEala55DrB1x+2sUK5HImA7m5ZNe0CDKOb8QrjJA+oQoYUYmcjhiQjbGyiyslqfuKYgmTQ6quR13Aw+5Uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540820; c=relaxed/simple;
	bh=562TRvOYpTfbZYxHdjL2nk07jp8Sy/M4MIM7w8TGRjI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sab2NNjAK1R9i1yUjIL4wdIqR3MU9FTpURFH5mCXaSHK/eW89+sJ7lGX81zQet1LJ0yfOj1pvqxzV+g/4cob+WIT8K0oJOhuYpIK63VjIiEXs+4+7zKWbVn0H9Q2IJLqfLoolxYSRINO+1WiIUI0zhpPwH55RN4XqWc/TB3vCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JaTguXb9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763540818; x=1795076818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=562TRvOYpTfbZYxHdjL2nk07jp8Sy/M4MIM7w8TGRjI=;
  b=JaTguXb9iFUbk4btfzMwpCN4j2BUxh8u+mrpLE+I0gmNdXYn+WUUXY6/
   ltnweOKws3AhS/2UENNzYA6YBj0vexPz8UZE9n+dXQbMkSLeRZY+JJf/h
   jERxy2VsLLgmZbkF+BdqpuV27e6MIJ5HrklrdvJ727eMB0OyuT3DK7o8K
   VkYZ8wWnYd8wA0hNX90rUDzZnpkmvq0guvBufBbmDhHrgB1LEaFvQ1cYw
   +vFBmMdshjwYHD1nD//21AdQIH9huClBgzG8A9j/9nglWcVnv7on/LOra
   nYmIFM0NrtxNR8C0SqXfcopM7wjbjG12FykijQkoHDWQabXz0gDF2ISiw
   g==;
X-CSE-ConnectionGUID: cEq/CI6AT96jsUbww01iHw==
X-CSE-MsgGUID: T2Mm98yESXWk9k9HyabURQ==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="49371616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 01:26:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 19 Nov 2025 01:26:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Nov 2025 01:26:42 -0700
Date: Wed, 19 Nov 2025 09:26:46 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: Fix the initialization of taprio
Message-ID: <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>
References: <20251117144309.114489-1-horatiu.vultur@microchip.com>
 <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch>

The 11/18/2025 20:20, Andrew Lunn wrote:

Hi Andrew,

> 
> On Mon, Nov 17, 2025 at 03:43:09PM +0100, Horatiu Vultur wrote:
> > To initialize the taprio block in lan966x, it is required to configure
> > the register REVISIT_DLY. The purpose of this register is to set the
> > delay before revisit the next gate and the value of this register depends
> > on the system clock. The problem is that the we calculated wrong the value
> > of the system clock period in picoseconds. The actual system clock is
> > ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> > not 15125 as currently set.
> 
> Is the system clock available as a linux clock? Can you do a
> clk_get_rate() on it?

Unfortunetly, I can not do clk_get_rate because in the device tree for the
switch node I don't have any clocks property. And maybe that is the
problem because I have the system clock (sys_clk) in the lan966x.dtsi
file. But if I go this way then I need add a bigger changeset and add
it to multiple kernel trees which complicate the things.
So maybe I should not change this patch and then create another one
targeting net-next where I can start using clk_get_rate()

> 
>         Andrew

-- 
/Horatiu

