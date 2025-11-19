Return-Path: <netdev+bounces-240096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E0C7064D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 236082F30C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60831354F;
	Wed, 19 Nov 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="daYjYNsB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413D3019A9;
	Wed, 19 Nov 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572653; cv=none; b=DPkVM7kBlQOr/CuEcqk2UgwJH4uNEeuQnaTs1eXJYyl8ABL++6UHq2FFMcTe0YcjvudU4f1kyM3KbDxvd4WQqGfFAldU/NSu6z661vRPFtbR82x8nyjFY6+P9jNMBoGT/osCGssI3H6n1vgYaWMZ1138o5epbqSnK2yeE1hGKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572653; c=relaxed/simple;
	bh=5CUlStCfNECa9wLs9DQHrdx1f/W7SC2S7TRk4T7h7qo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfqnhQcCHJgbF0E4twUktnjpPmg1P32wCcNeU5sbK0e9/2hm3OcNuUVmtlyvnAd2RdX8Z/fqojInkiC5dDsq0Y7JOMirQDxPZNSUY8KhX8nyTIHc2mHlfNzZMzCg7hRTPB8mU1rIXGlDQiA3CrZFd59f02Bujmfakk1ZHaZ67ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=daYjYNsB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763572651; x=1795108651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5CUlStCfNECa9wLs9DQHrdx1f/W7SC2S7TRk4T7h7qo=;
  b=daYjYNsB359F8esmyfffnbPh4Fo9NGNHualac8hY3wbVfeuAN7UAM0df
   rnspQB39/R1TE7+2oOBUsLUI8DkacGxsQAT9jzldlfMbN39R9jsewEr1N
   iF1qYjRrTpU+xthqN+YjhYa9L9lO1tVP2bgRfmB3DJg8Kqo08tMtC2bcX
   IbvSvSwhETYcwdNzZyrrjcibsVVz5srTpGn179IkPGJ3Piaf3jI2ClI/c
   bGJbfcbc5doWD/CqxMJYGfww8QsiF30tp4VwL9kK1kQfGpXKGgK2Ixz2X
   xqdAIxGvIIWKPMYUJ+LhBiIH58MSGsfFxNnkhDGYSkM/tvk85OY4BuKXO
   A==;
X-CSE-ConnectionGUID: /fk1tT3pTcO9z4HWKNs8AA==
X-CSE-MsgGUID: Xv1dQ+w5RQmlmIecCLQ8qg==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="55908951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 10:17:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 10:17:11 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Nov 2025 10:17:10 -0700
Date: Wed, 19 Nov 2025 18:17:14 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: Fix the initialization of taprio
Message-ID: <20251119171714.qrzxeufuchci5xfq@DEN-DL-M31836.microchip.com>
References: <20251117144309.114489-1-horatiu.vultur@microchip.com>
 <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch>
 <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>
 <4f8b0e67-1cc4-4387-bad3-0c5ae2092f52@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4f8b0e67-1cc4-4387-bad3-0c5ae2092f52@lunn.ch>

The 11/19/2025 15:26, Andrew Lunn wrote:
> 
> On Wed, Nov 19, 2025 at 09:26:46AM +0100, Horatiu Vultur wrote:
> > The 11/18/2025 20:20, Andrew Lunn wrote:
> >
> > Hi Andrew,
> >
> > >
> > > On Mon, Nov 17, 2025 at 03:43:09PM +0100, Horatiu Vultur wrote:
> > > > To initialize the taprio block in lan966x, it is required to configure
> > > > the register REVISIT_DLY. The purpose of this register is to set the
> > > > delay before revisit the next gate and the value of this register depends
> > > > on the system clock. The problem is that the we calculated wrong the value
> > > > of the system clock period in picoseconds. The actual system clock is
> > > > ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> > > > not 15125 as currently set.
> > >
> > > Is the system clock available as a linux clock? Can you do a
> > > clk_get_rate() on it?
> >
> > Unfortunetly, I can not do clk_get_rate because in the device tree for the
> > switch node I don't have any clocks property. And maybe that is the
> > problem because I have the system clock (sys_clk) in the lan966x.dtsi
> > file. But if I go this way then I need add a bigger changeset and add
> > it to multiple kernel trees which complicate the things.
> > So maybe I should not change this patch and then create another one
> > targeting net-next where I can start using clk_get_rate()
> 
> This is fine as is. But maybe rather than use the magic number, add a
> #defines for the system clock rate, and convert to pico seconds in the
> code, and let the compiler do it at compile time. The code then
> documents what is going on.

Yes, I will add a define for system clock.
I will do it as suggested by Eric.

> 
>         Andrew

-- 
/Horatiu

