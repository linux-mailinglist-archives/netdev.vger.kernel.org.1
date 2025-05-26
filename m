Return-Path: <netdev+bounces-193371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF76AC3A46
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C2C3AE558
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323E1D63E8;
	Mon, 26 May 2025 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="goLW3uCB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E383FD1;
	Mon, 26 May 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242627; cv=none; b=o9hQksmp59yYkBNZrzkOS3HBSd9tvZY39PRTuj5wmICERMoOZ4rIn4MhUhKKIJ3hu0u5O3rbH6d8uUnStGT3xCSe9c/MKpgOXUGPQYykDr96hASn/nndmKvkmrOMgkdj7MBkbLdkJ2xsD+K8Nyhj7d6cg1npFLfO8v/ccKfCM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242627; c=relaxed/simple;
	bh=oZQN+ug918+BLKQ/ARQBkx0CRSMO2V0v/6JWUiYv6pA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYCUeF8HE24ZmTeXGNv8H27247MTO9GxsL9GybYVS8Yxk1zudiOV+b5/JoVMsJUL5gh+L2ne671PgFGm+2X/zQlG4XHli1t70FwnFB/vFaIRdeaJ0PgutfeyaZt5h3jLr8AoUn5SI2ImhKCyZZnMClPb62Ce5hcFREv39f6sKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=goLW3uCB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748242625; x=1779778625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oZQN+ug918+BLKQ/ARQBkx0CRSMO2V0v/6JWUiYv6pA=;
  b=goLW3uCBiDLvaieT8tyCtiggBP0E8CnXS+nIy761A5bXitV7yTVsyFe5
   kEYoj/0dYPQKNBhjJRuw7CCOHPjWnZDOiR+Dgqy2hz5MurLMDzP5sXb8z
   CGtLCScp+vpGQJ3FO+ri2xNtd7nZre6tkVuAgDWknKaVxdPbmiALMBATw
   KoRP86Cw6fxrAtNwM4rzFHu72ipZ71v87rEYaQv2mduMq6oFZDDXJiYZs
   RidlMb4Y3Bs/gSUxGKfXydcBdLiT16oJNSGI4NLyEXsNLYu//NUZlCawk
   nuaveUv5r3VxOzJ/ZuBt0HtKdoVfUn3uA8N6EvqO9tXAJTQyWGPi1zaSU
   A==;
X-CSE-ConnectionGUID: 2ChXxIHBTJS4QRZjcLK3sQ==
X-CSE-MsgGUID: H9vU0z7vRy2ybCEZXv41MQ==
X-IronPort-AV: E=Sophos;i="6.15,315,1739862000"; 
   d="scan'208";a="46897844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2025 23:56:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 25 May 2025 23:56:28 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 25 May 2025 23:56:28 -0700
Date: Mon, 26 May 2025 08:54:45 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <kory.maincent@bootlin.com>,
	<wintera@linux.ibm.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: mscc: Stop clearing the the UDPv4 checksum
 for L2 frames
Message-ID: <20250526065445.o7pchn5tilq7izmx@DEN-DL-M31836.microchip.com>
References: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
 <13c4a8b2-89a8-428c-baad-a366ff6ab8b0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <13c4a8b2-89a8-428c-baad-a366ff6ab8b0@lunn.ch>

The 05/23/2025 14:59, Andrew Lunn wrote:

Hi Andrew,

> 
> On Fri, May 23, 2025 at 10:27:16AM +0200, Horatiu Vultur wrote:
> > We have noticed that when PHY timestamping is enabled, L2 frames seems
> > to be modified by changing two 2 bytes with a value of 0. The place were
> > these 2 bytes seems to be random(or I couldn't find a pattern).  In most
> > of the cases the userspace can ignore these frames but if for example
> > those 2 bytes are in the correction field there is nothing to do.  This
> > seems to happen when configuring the HW for IPv4 even that the flow is
> > not enabled.
> > These 2 bytes correspond to the UDPv4 checksum and once we don't enable
> > clearing the checksum when using L2 frames then the frame doesn't seem
> > to be changed anymore.
> >
> > Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/phy/mscc/mscc_ptp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> > index 6f96f2679f0bf..6b800081eed52 100644
> > --- a/drivers/net/phy/mscc/mscc_ptp.c
> > +++ b/drivers/net/phy/mscc/mscc_ptp.c
> > @@ -946,7 +946,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
> >       /* UDP checksum offset in IPv4 packet
> >        * according to: https://tools.ietf.org/html/rfc768
> >        */
> > -     val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
> > +     val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
> > +     if (enable)
> > +             val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
> 
> Is this towards the media, or received from the media?

It is when the vsc85xx PHY receives frames from the link partner.

>Have you tried sending packets with deliberately broken UDPv4 checksum?
>Does the PHYs PTP engine correctly ignore such packets?

No, I have not done that. What I don't understand is why should I send
UDPv4 frames when we enable to timestamp only L2 frames.

> 
> I suppose the opposite could also be true. Do you see it ignoring
> frames which are actually O.K? It could be looking in the wrong place
> for the checksum, so the checksum fails.

I have not seen any frames being ignored by HW. The HW is configured to
set the nanosecond part of the RX timestamp into the frame. And it is
always doing that, the problem is that sometimes on top of this change
it also replaces 2 bytes in the frame with 0. And it is the userspace
(ptp4l) who ignores those frames because the are corrupted.

> 
>         Andrew

-- 
/Horatiu

