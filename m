Return-Path: <netdev+bounces-137623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D169A72FC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6729BB228C0
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0401FBC81;
	Mon, 21 Oct 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sgOKrCFU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CCC2209B;
	Mon, 21 Oct 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537856; cv=none; b=uJlYMHJQpCjmJMxQ0npWNbxMmMfmzKeJlCCNFvFv/3j5hDvurk749+o14PCBbLtdxzqgQHHvyNI1LMQh10t49eGv4oGl+KYpxXDaIpK56k6ivJ7Br8vHiH99k8Zv1zA4F5Y3TqXZfB10UPIo/rohiWATuqRmCeI0ZddeiFiNI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537856; c=relaxed/simple;
	bh=5Npb0UB3xjxu34VLa/hXfqiKXjp+NHGyBf4A2zbCrLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAiiFFZNnMQrkQo9fr/cw3PVu7pl5NE/oeq1ykJxzgEXqrwdNhqS+pMegl8CX4f3HHXKjHzPunS+YObsvOxh85UR8YW0JgXCs+yLKRO3j7InkRgk5GwDDIIwz3wX2U/G1lu+u07VcRAwlmJR4JKiSgPu86tJkvOJpFmfjEloc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sgOKrCFU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729537854; x=1761073854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Npb0UB3xjxu34VLa/hXfqiKXjp+NHGyBf4A2zbCrLw=;
  b=sgOKrCFUFresoonOtetxw744HzBfZ5b3WY4c2cpty4SoSZmEU8cxHB6G
   aS2JdIP/lzgiJZLAxo2VWPk5phx9bvLOrEYvUhzVuq0bGqxjyxSIejScs
   Zgta4Ga5ux9hunDcQTYdXbzUPJZYdYUsnDjgLjnuVgrbRYbzVbujK87Ss
   YoUoKkVf0PCsmygN4UULECASK6wQ4ewWzbB3gfJ6BIvi3oG8Gykz+lyQj
   GExjWyt03Do8o+zgAGU4iy6wM2HW43dt70VUUHL41w+jsdPSWElcX1o80
   YFatwSgBCkyNhzCMYy0GOyR37jQkt5FCLyUIekhHnJVZbujmx8T0T/GMK
   A==;
X-CSE-ConnectionGUID: AY5F0AEfSvWQ3nuwGvWjFA==
X-CSE-MsgGUID: GZEoHNsmRTe4gsUIApM8fg==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="36683189"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 12:10:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 12:10:32 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 21 Oct 2024 12:10:28 -0700
Date: Mon, 21 Oct 2024 19:10:27 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 05/15] net: sparx5: add registers required by
 lan969x
Message-ID: <20241021191027.wgtyhy53ect2xhko@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-5-c8c49ef21e0f@microchip.com>
 <20241021193348.7a2423db@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021193348.7a2423db@device-21.home>

> Hello Daniel,
> 
> On Mon, 21 Oct 2024 15:58:42 +0200
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> > Lan969x will require a few additional registers for certain operations.
> > Some are shared, some are not. Add these.
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]
> 
> > +#define PTP_PTP_TWOSTEP_STAMP_SUBNS_STAMP_SUB_NSEC GENMASK(7, 0)
> 
> I understand that this is partly autogenerated, however the naming for
> this register in particular seems very redundant... Is there any way
> this could be improved ?
> 
> Thanks,
> 
> Maxime
> 

Yes, this might be a new candidate for "the longest name in the kernel"
award.

This particular register is a concatenation of: PTP (target) PTP_TS_FIFO
(register group) PTP_TWOSTEP_STAMP_SUBNS (register) STAMP_SUB_NSEC
(field), and as you can see the register group part is already removed.
That said, the tool for generating this, can be tweaked to rename
registers if required - I will do that here :-)

Thanks!

/Daniel



