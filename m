Return-Path: <netdev+bounces-50046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0F97F47D1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499A81F22007
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86654F8A;
	Wed, 22 Nov 2023 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZGy6+h9F"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC33197
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700659747; x=1732195747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8Qx7YfFUxNR+Ie0FYpvO3arONICr3f/8OTctudJOCc=;
  b=ZGy6+h9FYdEULCu5C9K20/dpTQ7qR0E/6uaHSZLorKwCtU9xSFdZ1Pfa
   AeqKgy0n1Wn8tA6ujL5Zph7wfnax82MAamZ5W2E2/nsH9ImWAmS4DUAWU
   RDRalUz1HC14YSNgX/JgoJdrAAOslUvlz5vq94cSf6RPB8FDtELX4Sc4B
   vSndXpCSCQOW+E1nd9sGahWObQIf/NiQrZhP47DBFuppY+bsQoe/4+Lf/
   iwmgp5c6fmhOm/Z0WRS+SStjZwaqovOOXVZz9a3XMkVr8WKuke6J9VyQg
   rSWtpXrM3tYXX8478TLaYPZvtHjeMB6EW8KO8TfyJb76vXc6ayxgz3Sr2
   w==;
X-CSE-ConnectionGUID: 8fkZwiXeRiyZeqDSvRnwOw==
X-CSE-MsgGUID: sMcdIeZdSFi0yzmMe/hnvg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="179253324"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Nov 2023 06:29:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Nov 2023 06:28:04 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 22 Nov 2023 06:28:04 -0700
Date: Wed, 22 Nov 2023 14:28:04 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Woojung Huh
	<woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Per Noergaard Christensen <per.christensen@prevas.dk>
Subject: Re: [PATCH net-next] net: dsa: microchip: add MRP software ring
 support
Message-ID: <20231122132804.3tqmhj2aahmqcf7o@DEN-DL-M31836.microchip.com>
References: <20231122112006.255811-1-rasmus.villemoes@prevas.dk>
 <20231122113537.o2fennnt2l2sri56@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231122113537.o2fennnt2l2sri56@skbuf>

The 11/22/2023 13:35, Vladimir Oltean wrote:
Hi Rasmus,

> 
> On Wed, Nov 22, 2023 at 12:20:06PM +0100, Rasmus Villemoes wrote:
> > From: Per Noergaard Christensen <per.christensen@prevas.dk>
> >
> > Add dummy functions that tells the MRP bridge instance to use
> > implemented software routines instead of hardware-offloading.
> >
> > Signed-off-by: Per Noergaard Christensen <per.christensen@prevas.dk>
> > Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 55 ++++++++++++++++++++++++++
> >  drivers/net/dsa/microchip/ksz_common.h |  1 +
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> > index 3fed406fb46a..b0935997dc05 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -3566,6 +3566,57 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
> >       return -EOPNOTSUPP;
> >  }
> >
> > +static int ksz_port_mrp_add(struct dsa_switch *ds, int port,
> > +                         const struct switchdev_obj_mrp *mrp)
> > +{
> > +     struct dsa_port *dp = dsa_to_port(ds, port);
> > +     struct ksz_device *dev = ds->priv;
> > +
> > +     /* port different from requested mrp ports */
> > +     if (mrp->p_port != dp->user && mrp->s_port != dp->user)
> > +             return -EOPNOTSUPP;
> > +
> > +     /* save ring id */
> > +     dev->ports[port].mrp_ring_id = mrp->ring_id;
> > +     return 0;
> > +}
> > +
> > +static int ksz_port_mrp_del(struct dsa_switch *ds, int port,
> > +                         const struct switchdev_obj_mrp *mrp)
> > +{
> > +     struct ksz_device *dev = ds->priv;
> > +
> > +     /* check if port not part of ring id */
> > +     if (mrp->ring_id != dev->ports[port].mrp_ring_id)
> > +             return -EOPNOTSUPP;
> > +
> > +     /* clear ring id */
> > +     dev->ports[port].mrp_ring_id = 0;
> > +     return 0;
> > +}
> > +
> > +static int ksz_port_mrp_add_ring_role(struct dsa_switch *ds, int port,
> > +                                   const struct switchdev_obj_ring_role_mrp *mrp)
> > +{
> > +     struct ksz_device *dev = ds->priv;
> > +
> > +     if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
> > +             return 0;

As Vladimir mentioned, you should add some rules to trap all MRP frames.
Otherwise, if you configure as MRC then you need to foward the TEST
frames and copy to CPU the CONTROL frames. And if you start to have more
than 2 ports under the bridge, then the traffic will be flooded on the
other ports that are not part of the MRP ring.
If you configure as MRM then you will never terminate the frames
otherwise the HW will just forward them. And of course you will have the
same issue if there are more than 2 ports under the bridge.
I hope I didn't forget everything (as I didn't look into this for some
time). But willing to look more into if it is needed.

> > +
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static int ksz_port_mrp_del_ring_role(struct dsa_switch *ds, int port,
> > +                                   const struct switchdev_obj_ring_role_mrp *mrp)
> > +{
> > +     struct ksz_device *dev = ds->priv;
> > +
> > +     if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
> > +             return 0;
> > +
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >  static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
> >                                   const unsigned char *addr)
> >  {
> > @@ -3799,6 +3850,10 @@ static const struct dsa_switch_ops ksz_switch_ops = {
> >       .port_fdb_del           = ksz_port_fdb_del,
> >       .port_mdb_add           = ksz_port_mdb_add,
> >       .port_mdb_del           = ksz_port_mdb_del,
> > +     .port_mrp_add           = ksz_port_mrp_add,
> > +     .port_mrp_del           = ksz_port_mrp_del,
> > +     .port_mrp_add_ring_role = ksz_port_mrp_add_ring_role,
> > +     .port_mrp_del_ring_role = ksz_port_mrp_del_ring_role,
> >       .port_mirror_add        = ksz_port_mirror_add,
> >       .port_mirror_del        = ksz_port_mirror_del,
> >       .get_stats64            = ksz_get_stats64,
> > diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> > index b7e8a403a132..24015f0a9c98 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.h
> > +++ b/drivers/net/dsa/microchip/ksz_common.h
> > @@ -110,6 +110,7 @@ struct ksz_port {
> >       bool remove_tag;                /* Remove Tag flag set, for ksz8795 only */
> >       bool learning;
> >       int stp_state;
> > +     u32 mrp_ring_id;
> >       struct phy_device phydev;
> >
> >       u32 fiber:1;                    /* port is fiber */
> > --
> > 2.40.1.1.g1c60b9335d
> >
> 
> Could you please explain a bit the mechanics of this dummy implementation?
> Don't you need to set up any packet traps for MRP PDUs, to avoid
> forwarding them? What ring roles will work with the dummy implementation?
> 
> +Horatiu for an expert opinion.
> 

-- 
/Horatiu

