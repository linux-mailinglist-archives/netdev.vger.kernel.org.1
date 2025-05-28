Return-Path: <netdev+bounces-193925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4205AC64ED
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13D61BA42A8
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83B2741C3;
	Wed, 28 May 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HAC9xmMQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FC272E44;
	Wed, 28 May 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422609; cv=none; b=KC35iZAo0Y3K+NEkobUm8+Fw1d4pEVxnAbTvuKZE0YiDWOq6Fz08MHhTDTMN5lupJs1v+jLWFS+pQNHByigU6oundfc2hL19mwLU8w3zMMqAWYoDVuPEqxqWll8ZWd5oXQsTQZhJrhwSeOEFCTk7OG/L+wzxyldsmxzfOq75i/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422609; c=relaxed/simple;
	bh=svgzjkQYPTqnXKLn5DAC0dIIjJ9S6ZgKgXWz9Lkp8Yg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBbPP8uLaJn0ENXkxLRSUysBhItciTerW9T0aHFx+fxAydrAjeBmvFKpzzzaykurgXfy/QXCfm0RJY0uipSPibtdsWZkDrjQ6DfeP2oJDXaxzER+kVOjIz5+lXkFUHK7ziLmEt7KoVLMguLkJcZnQChyL8E4NVFQSrP31/BpGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HAC9xmMQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748422607; x=1779958607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svgzjkQYPTqnXKLn5DAC0dIIjJ9S6ZgKgXWz9Lkp8Yg=;
  b=HAC9xmMQnnzDCMV6eALmwOQ6UswppfskB6HV+b0xWXEY5GOVCKdVGJbQ
   H4PS8zvNQkhYVmn5WnVRJi19BYRsUDJ91TVvf0eGNYjcLQ4JkJF8mQIPB
   SU4NNrbIOt/3y1aq2bSGC0+7i4ouhR35ecSYGwNTqy7UHclCc9OFfi7pj
   yO9G0ccbwj+f18HaXtk68mcBJ91dYpNNBJNE1nvFApOI1OQExZ+xLhKok
   NCuvFJ2cOWPzoz9525QNrUVDjiiw1cqQPpBzMO7IeDU2LYKwvRPJSew4o
   /7wGsI98paHSLupCSyEYmQYdV+LqqOr5QhY8FkppCT4Z/KbVaVrrNMWow
   g==;
X-CSE-ConnectionGUID: hzt0KrMvQKeqIu8ADV+dlA==
X-CSE-MsgGUID: hkm5CSArRziPKz9w1gSG0A==
X-IronPort-AV: E=Sophos;i="6.15,320,1739862000"; 
   d="scan'208";a="209648014"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2025 01:56:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 28 May 2025 01:56:37 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 28 May 2025 01:56:37 -0700
Date: Wed, 28 May 2025 10:54:51 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: Make sure to insert the vlan tags also
 in host mode
Message-ID: <20250528085451.bindv4477g56mfcu@DEN-DL-M31836.microchip.com>
References: <20250527070850.3504582-1-horatiu.vultur@microchip.com>
 <20250527103749.66505756@2a02-8440-d111-2026-8d50-1f4f-0da2-e170.rev.sfr.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250527103749.66505756@2a02-8440-d111-2026-8d50-1f4f-0da2-e170.rev.sfr.net>

The 05/27/2025 10:37, Maxime Chevallier wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Horatiu,

Hi Maxime,

> 
> On Tue, 27 May 2025 09:08:50 +0200
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > When running these commands on DUT (and similar at the other end)
> > ip link set dev eth0 up
> > ip link add link eth0 name eth0.10 type vlan id 10
> > ip addr add 10.0.0.1/24 dev eth0.10
> > ip link set dev eth0.10 up
> > ping 10.0.0.2/24
> >
> > The ping will fail.
> >
> > The reason why is failing is because, the network interfaces for lan966x
> > have a flag saying that the HW can insert the vlan tags into the
> > frames(NETIF_F_HW_VLAN_CTAG_TX). Meaning that the frames that are
> > transmitted don't have the vlan tag inside the skb data, but they have
> > it inside the skb. We already get that vlan tag and put it in the IFH
> > but the problem is that we don't configure the HW to rewrite the frame
> > when the interface is in host mode.
> > The fix consists in actually configuring the HW to insert the vlan tag
> > if it is different than 0.
> >
> > Fixes: 6d2c186afa5d ("net: lan966x: Add vlan support.")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../ethernet/microchip/lan966x/lan966x_main.c |  1 +
> >  .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
> >  .../microchip/lan966x/lan966x_switchdev.c     |  1 +
> >  .../ethernet/microchip/lan966x/lan966x_vlan.c | 21 +++++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 427bdc0e4908c..7001584f1b7a6 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -879,6 +879,7 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
> >       lan966x_vlan_port_set_vlan_aware(port, 0);
> >       lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
> >       lan966x_vlan_port_apply(port);
> > +     lan966x_vlan_port_rew_host(port);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > index 1f9df67f05044..4f75f06883693 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
> > @@ -497,6 +497,7 @@ void lan966x_vlan_port_apply(struct lan966x_port *port);
> >  bool lan966x_vlan_cpu_member_cpu_vlan_mask(struct lan966x *lan966x, u16 vid);
> >  void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
> >                                     bool vlan_aware);
> > +void lan966x_vlan_port_rew_host(struct lan966x_port *port);
> >  int lan966x_vlan_port_set_vid(struct lan966x_port *port,
> >                             u16 vid,
> >                             bool pvid,
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> > index 1c88120eb291a..bcb4db76b75cd 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c
> > @@ -297,6 +297,7 @@ static void lan966x_port_bridge_leave(struct lan966x_port *port,
> >       lan966x_vlan_port_set_vlan_aware(port, false);
> >       lan966x_vlan_port_set_vid(port, HOST_PVID, false, false);
> >       lan966x_vlan_port_apply(port);
> > +     lan966x_vlan_port_rew_host(port);
> >  }
> >
> >  int lan966x_port_changeupper(struct net_device *dev,
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> > index fa34a739c748e..f158ec6ab10cc 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c
> > @@ -149,6 +149,27 @@ void lan966x_vlan_port_set_vlan_aware(struct lan966x_port *port,
> >       port->vlan_aware = vlan_aware;
> >  }
> >
> > +/* When the interface is in host mode, the interface should not be vlan aware
> > + * but it should insert all the tags that it gets from the network stack.
> > + * The tags are no in the data of the frame but actually in the skb and the ifh
>                    not
> > + * is confiured already to get this tag. So what we need to do is to update the
>          configured
> > + * rewriter to insert the vlan tag for all frames which have a vlan tag
> > + * different than 0.

Well spotted!

> 
> Just to be extra clear, the doc seems to say that
> 
>         REW_TAG_CFG_TAG_CFG_SET(1);
> 
> means "Tag all frames, except when VID=PORT_VLAN_CFG.PORT_VID or
> VID=0."
> 
> Another setting for these bits are "Tag all frames except when VID=0",
> which is what you document in the above comment.
> 
> In this case, is there any chance that it would make a difference ?

I don't see how will this make a difference but I will update it to set
the value of 2 which means VID=0 and also update the comment.

> 
> > + */
> > +void lan966x_vlan_port_rew_host(struct lan966x_port *port)
> > +{
> > +     struct lan966x *lan966x = port->lan966x;
> > +     u32 val;
> > +
> > +     /* Tag all frames except when VID == DEFAULT_VLAN */
> > +     val = REW_TAG_CFG_TAG_CFG_SET(1);
> > +
> > +     /* Update only some bits in the register */
> > +     lan_rmw(val,
> > +             REW_TAG_CFG_TAG_CFG,
> > +             lan966x, REW_TAG_CFG(port->chip_port));
> > +}
> > +
> >  void lan966x_vlan_port_apply(struct lan966x_port *port)
> >  {
> >       struct lan966x *lan966x = port->lan966x;
> 
> Sorry for the typo nitpicking, but with that :
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Maxime

-- 
/Horatiu

