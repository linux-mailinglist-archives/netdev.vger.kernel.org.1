Return-Path: <netdev+bounces-227281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEAEBABC0B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F4171EDF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A00627875C;
	Tue, 30 Sep 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FRQl2LEz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B22367CF;
	Tue, 30 Sep 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216099; cv=none; b=rOAneUlEAOecYvm1mReDawhr74pbFvlAUP5gf+Z7eF9U5kGoJagWasvtjegVOoPYFzv361c7T1u558kXVo8U59iKQTedgPYjcybvawWXXeKST+BCTQ68DDw0XJ/8DwBsMMOuM/YZ7N4rPfV9sG/BA0swu2YEeugr8voOeUBKF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216099; c=relaxed/simple;
	bh=eO7HBzwE2G+/p7nPEVxTKuhlvp5k2eOtqaVQ1m7bSDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLtw5q5bmI7+aydRAzvKap+5+B89idGMAxNjtow/hwZTyBdbH6iEjiLOZ5ky2ykI/aU3g8DKgS9AOwDwM/teL9xLtyhoCFrGZB31CeWK5KXFGEAZ233ikl56rwvO0dGNaLI+fpe5c0oeAeErSgc+3gKOLEnmqDImls6He6BMlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FRQl2LEz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759216097; x=1790752097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eO7HBzwE2G+/p7nPEVxTKuhlvp5k2eOtqaVQ1m7bSDU=;
  b=FRQl2LEz/Vi7LOiWmucSZBwNl+6WW6lcQpjXWsPkPNFFP22iA0/KQxgk
   Ddkkg6GhAwcdvujTzLUv9MzubpybGJor4Vd9ZLQ9PMeOZrEYM0XIk+Xo2
   C1DFjxbyOl8aJCcy/DdS7M6/N6YvmKwbYpDbowlfAr6iN0hhSqa/tyKYz
   853njeMXM7vtAvMKlP7GnhASdkaL6pzuc6goGOkuKnure+ACc3wH6vV56
   AWe/zPjgR8eGrAWSxmp4ejD5pwIMDbRkO9IazbOqGlO2Lys4Yd3bAYRfG
   5gbMNTocjlH/4kFH5Yya21OS9IxCE7qIM63MWbc3PPZsXCf2Jvpu92XLS
   Q==;
X-CSE-ConnectionGUID: C3Wgn4EdQpGGq/DP0Wqg7g==
X-CSE-MsgGUID: Cm4R3luxQzSBLd7Z5UI1ww==
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="46562260"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2025 00:08:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Sep 2025 00:07:58 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 30 Sep 2025 00:07:58 -0700
Date: Tue, 30 Sep 2025 09:07:17 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<rosenp@gmail.com>, <christophe.jaillet@wanadoo.fr>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 0/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
Message-ID: <20250930070717.4oad7l6ab3jxjl2e@DEN-DL-M31836.microchip.com>
References: <20250929091302.106116-1-horatiu.vultur@microchip.com>
 <20250929184700.50628a5f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250929184700.50628a5f@kernel.org>

The 09/29/2025 18:47, Jakub Kicinski wrote:
> 
> On Mon, 29 Sep 2025 11:13:00 +0200 Horatiu Vultur wrote:
> > The first patch will update the PHYs VSC8584, VSC8582, VSC8575 and VSC856X
> > to use PHY_ID_MATCH_MODEL because only rev B exists for these PHYs.
> > But for the PHYs VSC8574 and VSC8572 exists rev A, B, C, D and E.
> > This is just a preparation for the second patch to allow the VSC8574 and
> > VSC8572 to use the function vsc8584_probe().
> >
> > We want to use vsc8584_probe() for VSC8574 and VSC8572 because this
> > function does the correct PTP initialization. This change is in the second
> > patch.
> 
> This doesn't apply cleanly to net. If it was generated against net-next
> - perhaps wait a couple of days until trees converge before reposting?

Yeah, I have generated this patch series on net-next instead of net.
Yes, I can wait before reposting.

> --
> pw-bot: cr

-- 
/Horatiu

