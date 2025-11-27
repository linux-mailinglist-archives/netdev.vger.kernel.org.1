Return-Path: <netdev+bounces-242162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CAC8CDFC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 06:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06D8F4E157B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 05:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB682D97B9;
	Thu, 27 Nov 2025 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l993spLS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED462D9485;
	Thu, 27 Nov 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221631; cv=none; b=MVjmAhN4YBuA2HHPtgp+sTQlSjrwlygs86BnzlW8LffEquMpGhtl0M92AEwjNjjSgdK3oID8rkjHUUxAx+NBoNd8DW1M3jSNoNyOF6OfQfMmCMFm0hDN46dfBpuagYTmpS7VXq6s9zo0gsDHCYzGnmR0f+0VJm8ii4SxQwaIwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221631; c=relaxed/simple;
	bh=iPCsuFfiS2DKQ0inyxYpJQt7Ri38mwkOaKUvMPHz6zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMWmK38Z37p5s2GaJyGmwoGMpZhiTRtkTv3rWB4m34tzsWvkxZt7KVJsrg5H3tSDEnwFhnzWjKMfQUoZOJuchgCFLRLcd6RDPBjbpgcwy4sK+q/hsWPLDdeP04Opyf0mfwwZEBEDkoXvAadsUhNg0EGDFkJ3F+/fpQLEguhsq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l993spLS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764221629; x=1795757629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iPCsuFfiS2DKQ0inyxYpJQt7Ri38mwkOaKUvMPHz6zs=;
  b=l993spLSN/Gg3QVmBPvJHKqR198ITBPA9FEqpxa4IdNEuzRqciOX/s6p
   WzJJamJ2ibKaRz6PmzRX7ezsJx/M1jNy716/+GF0oV0cNIyssWpyWhteM
   s051q0tXKb2oODI8WB3x+W3wdQ48sOc0uVIBVpb5PF4uKd61qPy/vHpzE
   86LQxwJq482oDIyDbbKRNC6cK4rNm+2hUpq2/t7ShNik5bzcVocgv/MEB
   Rk6DqkVzOIyqsyK9tT/aOR/EGtMmJqaA3MQZyK35hxf1N2sqoV3L7QT0o
   RXUb9yz3DhSiLUUa/Y0fKYlE3Uc5jJsTDHJDX7KALm7zGB16+02gGu86T
   Q==;
X-CSE-ConnectionGUID: Vj4K32jFRrCUeflhKQwlew==
X-CSE-MsgGUID: PHDwHrkGTEWl2Q0OVGx5Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="88908629"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="88908629"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 21:33:39 -0800
X-CSE-ConnectionGUID: vZpzfhJcTuOtqj2Gdegp/g==
X-CSE-MsgGUID: jEjZHILdR5Oz/qJWqgHPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="192954430"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 26 Nov 2025 21:33:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 449AC9F; Thu, 27 Nov 2025 06:33:36 +0100 (CET)
Date: Thu, 27 Nov 2025 06:33:36 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ian MacDonald <ian@netstatz.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad
 bonding
Message-ID: <20251127053336.GI323117@black.igk.intel.com>
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com>
 <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
 <CAFJzfF9UxBkvDkuSOG2AVd_mr3mkJ9yMa3D0s6rFvFdiMDKvPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJzfF9UxBkvDkuSOG2AVd_mr3mkJ9yMa3D0s6rFvFdiMDKvPA@mail.gmail.com>

Hi,

On Wed, Nov 26, 2025 at 06:39:50PM -0500, Ian MacDonald wrote:
> Hi Mika,
> 
> Following up on the previous discussion, your patch enabling MAC address
> changes allowed bonding to enslave thunderbolt_net devices, but 802.3ad
> still could not form an aggregator because the driver does not report
> link speed or duplex via ethtool. Bonding logs:
> 
>     bond0: (slave thunderbolt0): failed to get link speed/duplex

Okay thanks for checking.

> Bonding (802.3ad) requires non-zero speed/duplex values for LACP port
> key calculation.
> 
> The patch below adds a minimal get_link_ksettings() implementation and
> registers ethtool_ops. It reports a fixed 10Gbps full-duplex link,
> which is sufficient for LACP and seems consistent with ThunderboltIP
> host-to-host bandwidth with the USB4v1/TB3 hardware I am using.

I see. Yeah for speed we need to do something more than use the hard-coded
values because it varies depending on whether we have lane bonding (not the
same bonding you are doing) enabled and also how the link trained.

Let me come up with a patch based on yours that does that.

> With this change, 802.3ad bonding comes up correctly on my USB4/TB
> host-to-host setup. I also added link mode bitmaps, though they are not
> strictly required for LACP/802.3ad.
> 
> Signed-off-by: Ian MacDonald <ian@netstatz.com>
> 
> ---
>  drivers/net/thunderbolt/main.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 4f4694db6..b9e276693 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -15,6 +15,7 @@
>  #include <linux/jhash.h>
>  #include <linux/module.h>
>  #include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/sizes.h>
>  #include <linux/thunderbolt.h>
> @@ -1257,6 +1258,28 @@ static void tbnet_get_stats64(struct net_device *dev,
>   stats->rx_missed_errors = net->stats.rx_missed_errors;
>  }
> 
> +static int tbnet_get_link_ksettings(struct net_device *dev,
> +     struct ethtool_link_ksettings *cmd)
> +{
> + /* ThunderboltIP is a software-only full-duplex network tunnel.
> + * We report fixed link settings to satisfy bonding (802.3ad)
> + * requirements for LACP port key calculation. Speed is set to
> + * 10Gbps as a conservative baseline.
> + */
> + ethtool_link_ksettings_zero_link_mode(cmd, supported);
> + ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
> +
> + ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> + ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
> +
> + cmd->base.speed = SPEED_10000;
> + cmd->base.duplex = DUPLEX_FULL;
> + cmd->base.autoneg = AUTONEG_DISABLE;
> + cmd->base.port = PORT_NONE;
> +
> + return 0;
> +}
> +
>  static const struct net_device_ops tbnet_netdev_ops = {
>   .ndo_open = tbnet_open,
>   .ndo_stop = tbnet_stop,
> @@ -1265,6 +1288,10 @@ static const struct net_device_ops tbnet_netdev_ops = {
>   .ndo_get_stats64 = tbnet_get_stats64,
>  };
> 
> +static const struct ethtool_ops tbnet_ethtool_ops = {
> + .get_link_ksettings = tbnet_get_link_ksettings,
> +};
> +
>  static void tbnet_generate_mac(struct net_device *dev)
>  {
>   const struct tbnet *net = netdev_priv(dev);
> @@ -1315,6 +1342,7 @@ static int tbnet_probe(struct tb_service *svc,
> const struct tb_service_id *id)
> 
>   strcpy(dev->name, "thunderbolt%d");
>   dev->netdev_ops = &tbnet_netdev_ops;
> + dev->ethtool_ops = &tbnet_ethtool_ops;
> 
>   /* ThunderboltIP takes advantage of TSO packets but instead of
>   * segmenting them we just split the packet into Thunderbolt
> -- 
> 2.47.3
> 
> 
> 
> > On Fri, Nov 21, 2025 at 3:11 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > The below allows me to change it using "ip link set" command. I wonder if
> > > you could try it with the bonding case and see it that makes any
> > > difference?
> > >
> > > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > > index dcaa62377808..57b226afeb84 100644
> > > --- a/drivers/net/thunderbolt/main.c
> > > +++ b/drivers/net/thunderbolt/main.c
> > > @@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_ops = {
> > >         .ndo_open = tbnet_open,
> > >         .ndo_stop = tbnet_stop,
> > >         .ndo_start_xmit = tbnet_start_xmit,
> > > +       .ndo_set_mac_address = eth_mac_addr,
> > >         .ndo_get_stats64 = tbnet_get_stats64,
> > >  };
> > >
> > > @@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device *dev)
> > >         hash = jhash2((u32 *)xd->local_uuid, 4, hash);
> > >         addr[5] = hash & 0xff;
> > >         eth_hw_addr_set(dev, addr);
> > > +
> > > +       /* Allow changing it if needed */
> > > +       dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> > >  }
> > >
> > >  static int tbnet_probe(struct tb_service *svc, const struct tb_service_id *id)
> 
> Basic testing below on Debian with kernel 6.17.8 shows aggregate
> speeds within the expected range.
> 
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate         Retr
> [  5][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec    0
>     sender
> [  5][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec
>      receiver
> [  7][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec    0
>     sender
> [  7][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec
>      receiver
> [  9][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec    0
>     sender
> [  9][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec
>      receiver
> [ 11][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec    0
>     sender
> [ 11][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec
>      receiver
> [SUM][TX-C]   0.00-10.07  sec  22.3 GBytes  19.1 Gbits/sec    0
>      sender
> [SUM][TX-C]   0.00-10.07  sec  22.3 GBytes  19.1 Gbits/sec
>      receiver
> [ 13][RX-C]   0.00-10.07  sec  3.72 GBytes  3.18 Gbits/sec    1
>     sender
> [ 13][RX-C]   0.00-10.07  sec  3.72 GBytes  3.17 Gbits/sec
>      receiver
> [ 15][RX-C]   0.00-10.07  sec  11.1 GBytes  9.50 Gbits/sec    4
>     sender
> [ 15][RX-C]   0.00-10.07  sec  11.1 GBytes  9.50 Gbits/sec
>      receiver
> [ 17][RX-C]   0.00-10.07  sec  3.72 GBytes  3.18 Gbits/sec    1
>     sender
> [ 17][RX-C]   0.00-10.07  sec  3.72 GBytes  3.17 Gbits/sec
>      receiver
> [ 19][RX-C]   0.00-10.07  sec  3.73 GBytes  3.18 Gbits/sec    1
>     sender
> [ 19][RX-C]   0.00-10.07  sec  3.73 GBytes  3.18 Gbits/sec
>      receiver
> [SUM][RX-C]   0.00-10.07  sec  22.3 GBytes  19.0 Gbits/sec    7
>      sender
> [SUM][RX-C]   0.00-10.07  sec  22.3 GBytes  19.0 Gbits/sec
>      receiver
> 
> iperf Done.
> ai2:~# iperf3 --bidir -c 10.10.13.1 -P 4 -t 10
> 
> ai2:~# networkctl status bond0
> ● 3: bond0
>                  NetDev File: /etc/systemd/network/50-bond0.netdev
>                    Link File: /usr/lib/systemd/network/99-default.link
>                 Network File: /etc/systemd/network/53-bond0.network
>                        State: routable (configured)
>                 Online state: online
>                         Type: bond
>                         Kind: bond
>                       Driver: bonding
>             Hardware Address: 82:36:12:ad:a1:c0
>                          MTU: 1500 (min: 68, max: 65535)
>                        QDisc: noqueue
> IPv6 Address Generation Mode: eui64
>                         Mode: 802.3ad
>                       Miimon: 500ms
>                      Updelay: 0
>                    Downdelay: 0
>     Number of Queues (Tx/Rx): 16/16
>             Auto negotiation: no
>                        Speed: 20Gbps
>                       Duplex: full
>                      Address: 10.10.13.2
>                               fe80::8036:12ff:fead:a1c0
>            Activation Policy: up
>          Required For Online: yes
>           DHCPv6 Client DUID: DUID-EN/Vendor:0000ab111c6e5c59896f0172
> 
> Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: netdev ready
> Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: Configuring with
> /etc/systemd/network/53-bond0.network.
> Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: Link UP
> Nov 26 17:46:52 ai2 systemd-networkd[641]: bond0: Gained carrier
> Nov 26 17:46:53 ai2 systemd-networkd[641]: bond0: Gained IPv6LL
> 
> ai2:~# ethtool thunderbolt0
> Settings for thunderbolt0:
> Supported ports: [  ]
> Supported link modes:   10000baseT/Full
> Supported pause frame use: No
> Supports auto-negotiation: No
> Supported FEC modes: Not reported
> Advertised link modes:  10000baseT/Full
> Advertised pause frame use: No
> Advertised auto-negotiation: No
> Advertised FEC modes: Not reported
> Speed: 10000Mb/s
> Duplex: Full
> Auto-negotiation: off
> Port: None
> PHYAD: 0
> Transceiver: internal

