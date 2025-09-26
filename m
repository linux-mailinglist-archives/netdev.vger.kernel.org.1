Return-Path: <netdev+bounces-226654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82592BA399F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C24A56056D
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784C2EBBB7;
	Fri, 26 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="efbHAPVf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A52EACF2;
	Fri, 26 Sep 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889557; cv=none; b=X7yV41QQssYXKkatebXvVM7iBzUbfIuvKrd04o1AHmiolbsclAlNp5u5HedV7OAUJaJxFqoXpuALPHFHxyVMZ14HXUSj19rblgv5YrpJnTn0osNtqGgQpPzvojWofv7wY5U1UTlozD3t3GW1myR9I6w5jVCL+I/lRdK9fCgUDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889557; c=relaxed/simple;
	bh=KvVX2xfRB1KJuG+RF+XQr6knawYBotgnnhKSYkVebvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7IiDXezdgTfIiQqwvjNUYfqXn81vqmewsP93FFfGokcjjVmqGyFZTzHWpmlYuYP8m0HR9IApjQ1NeLB+bkdLrJ0eQW5zSe1Cq+Ux/a62hzC5dipI9tH8aYGa3JB3rWHHlL9EXpZIkwoKnAIlmMNp+SyVi0QW5mk6L88MiOAjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=efbHAPVf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758889556; x=1790425556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvVX2xfRB1KJuG+RF+XQr6knawYBotgnnhKSYkVebvo=;
  b=efbHAPVfmNMDp7+dnFzhzUVTtSj6xRmlTpCwCTfTIXhTJsvBrM1yUCel
   pMEceWTKdM9P/kGmyrNdG0n0gM2FEcQF2ifsSWfW69z/zPRXDJqwZ95oy
   FGR1tK75KJD+jH2Tgqz5LyHChU3Gf3leidlze/5T2fKzYqUIASZsSqyGI
   1wJ25o82umYBoydjqsbM6ndyFarbZGnnb8Q0B6eRB3GQxnAvPxIsiske6
   HBJ3zfOIMhSkmtnEe2jJ0nli2XknlYpquYI5GITOTpx5DFyfsivT5KgVh
   45RnRmY/gtx70QpPqVFwmt6w42i5lz8bOZJBUD7RNSLft/OHz+0F2fx5k
   Q==;
X-CSE-ConnectionGUID: BkTGbS8hRJilq+LaizyS6A==
X-CSE-MsgGUID: uynarNiRQr21WxfBAj49yw==
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="278399278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2025 05:25:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Sep 2025 05:25:24 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Sep 2025 05:25:24 -0700
Date: Fri, 26 Sep 2025 14:21:16 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Jakub Kicinski <kuba@kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926122116.iixyzxl3cjp2z66j@DEN-DL-M31836.microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <20250922132846.jkch266gd2p6k4w5@skbuf>
 <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>
 <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
 <20250926122038.3mv2plj3bvnfbple@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250926122038.3mv2plj3bvnfbple@skbuf>

The 09/26/2025 15:20, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, Sep 26, 2025 at 09:11:11AM +0200, Horatiu Vultur wrote:
> > I have been asking around about these revisions of the PHYs and what is
> > available:
> > vsc856x - only rev B exists
> > vsc8575 - only rev B exists
> > vsc8582 - only rev B exists
> > vsc8584 - only rev B exists
> > vsc8574 - rev A,B,C,D,E exists
> > vsc8572 - rev A,B,C,D,E exists
> >
> > For vsc856x, vsc8575, vsc8582, vsc8584 the lower 4 bits in register 3
> > will have a value of 1.
> > For vsc8574 and vsc8572 the lower 4 bits in register 3 will have a value
> > of 0 for rev A, 1 for rev B and C, 2 for D and E.
> >
> > Based on this information, I think both commits a5afc1678044 and
> > 75a1ccfe6c72 are correct regarding the revision check.
> >
> > So, now to be able to fix the PTP for vsc8574 and vsc8572, I can do the
> > following:
> > - start to use PHY_ID_MATCH_MODEL for vsc856x, vsc8575, vsc8582, vsc8584
> > - because of this change I will need to remove also the WARN_ON() in the
> >   function vsc8584_config_init()
> > - then I can drop the check for revision in vsc8584_probe()
> > - then I can make vsc8574 and vsc8572 to use vsc8584_probe()
> >
> > What do you think about this?
> 
> This sounds good, however I don't exactly understand how it fits in with
> your response to Russell to replace phydev->phy_id with phydev->drv->phy_id
> in the next revision. If the revision check in vsc8584_probe() goes away,
> where will you use phydev->drv->phy_id?

I got a little bit confused here.
Because no one answer to this email, I thought it might not be OK, so
that is the reason why I said that I will go with Russell approach.
But if you think that this approach that I proposed here is OK (as you seem
to be). Then I will go with this and then I will not do Russell
suggestion because it is not needed anymore.

-- 
/Horatiu

