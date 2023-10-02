Return-Path: <netdev+bounces-37361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3FC7B4FC4
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E1499281E9E
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B61D2F9;
	Mon,  2 Oct 2023 09:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16581C2EB
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 09:59:52 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69999CD5
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 02:59:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32615eaa312so2606885f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696240789; x=1696845589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCzyGNwJVaCnqtfyikHALmJUMV9gcSciRGd2YiYebKg=;
        b=RKgX8Xo6Pyh+xGQ+98SLyo5CJa6vsN3C3B2YclT23pcCXFZH1AhtsKRUIuHAhCY5qF
         zoxlcs3S6Bbr67W/Yh/vO2Jy0Qcdlx9aAVBviO1JxHFPQxreyyg+e8uNUpoEga++wILI
         TeEB73HGb0b8V3BCIuc++HoQwJDjMOF6q0bziiCZ/rmHCMXFi9u0cUOpg5NOoiEnjjp2
         3oAbKRlV3WsVYdL1NPyXgiMYwlFvyBefAxYHjGBwfcc5IuQFHimpoLDhQSIkjoU1MgDQ
         IKV5V+fBNXkdbI5Nqux4mWi9CzEbOiESvjRCyjkREG69lC4OdlbWWMSIFICfKjP10UDS
         tvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240789; x=1696845589;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCzyGNwJVaCnqtfyikHALmJUMV9gcSciRGd2YiYebKg=;
        b=T0zEI95o5dHtyjXrx/9cblaXudQIH4hmkUX91+gRFmFJ7Ne32Zs/54nTTs64d0S1D1
         y9qAh7q1M0GR93bjbLwGGreH6mdZjXnYhV4lhp5cIYQhZRnEn6405Ul0RfRjw6IcNYdb
         exVk2NX15+GZ6XQoGfJtBcBMrMcepOlOgT0olVa75X2S/0M8AeFQV4HGUFPB6cqi0K7o
         UOj4Y9hJ0RR6U512lmoqqng3HYw166W1ni9KZ5KjOTEy5JN0StozItF6ykHQC6wcf65J
         KlRYwfQEZmIz5RfBvKE9rQzf/tVwYYXwUszcQqKbdoSiA/3FIJdc42PqSMXa3RltWxhv
         NmrQ==
X-Gm-Message-State: AOJu0YyshOetUDSpRmjD1yHF50eFK9tD+RCGPW5UvfOpJvmoIAlSC6nh
	x0nS0HwMv7veSatYhAeHB19xHtnpY4QSDg==
X-Google-Smtp-Source: AGHT+IG8H5jtBlCTbFG5YY0P70di6i9O4tunIJR11QRkG5Ec5zBAgLweUuT3Zp1ZkJh+A+pLGToYQg==
X-Received: by 2002:adf:e9d0:0:b0:31f:f65f:74ac with SMTP id l16-20020adfe9d0000000b0031ff65f74acmr8803820wrn.70.1696240788462;
        Mon, 02 Oct 2023 02:59:48 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d50c1000000b003142e438e8csm27665775wrt.26.2023.10.02.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 02:59:47 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:59:46 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org, hkallweit1@gmail.com,
	nic_swsd@realtek.com, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH v4 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Message-ID: <20231002095946.GA21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
	jiawenwu@trustnetic.com, mengyuanlou@net-swift.com
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <31cdf199dad8e26bd5f732fd04b0d640c41f5616.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cdf199dad8e26bd5f732fd04b0d640c41f5616.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:32PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
>  currently contains only the wol_enabled field.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

One small nit below.

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/realtek/r8169_main.c        | 4 ++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 4 ++--
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 +-
>  drivers/net/phy/phy.c                            | 2 +-
>  drivers/net/phy/phy_device.c                     | 5 +++--
>  drivers/net/phy/phylink.c                        | 2 +-
>  include/linux/ethtool.h                          | 8 ++++++++
>  include/linux/netdevice.h                        | 7 ++++---
>  net/core/dev.c                                   | 4 ++++
>  net/ethtool/ioctl.c                              | 2 +-
>  net/ethtool/wol.c                                | 2 +-
>  11 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6351a2dc13bc..fe69416f2a93 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1455,7 +1455,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
>  
>  	if (tp->dash_type == RTL_DASH_NONE) {
>  		rtl_set_d3_pll_down(tp, !wolopts);
> -		tp->dev->wol_enabled = wolopts ? 1 : 0;
> +		tp->dev->ethtool->wol_enabled = wolopts ? 1 : 0;
>  	}
>  }
>  
> @@ -5321,7 +5321,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		rtl_set_d3_pll_down(tp, true);
>  	} else {
>  		rtl_set_d3_pll_down(tp, false);
> -		dev->wol_enabled = 1;
> +		dev->ethtool->wol_enabled = 1;
>  	}
>  
>  	jumbo_max = rtl_jumbo_max(tp);
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index ec0e869e9aac..091ee3d3e74d 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -34,9 +34,9 @@ static int ngbe_set_wol(struct net_device *netdev,
>  	wx->wol = 0;
>  	if (wol->wolopts & WAKE_MAGIC)
>  		wx->wol = WX_PSR_WKUP_CTL_MAG;
> -	netdev->wol_enabled = !!(wx->wol);
> +	netdev->ethtool->wol_enabled = !!(wx->wol);
>  	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
> -	device_set_wakeup_enable(&pdev->dev, netdev->wol_enabled);
> +	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 2b431db6085a..6752f8d04d9c 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -636,7 +636,7 @@ static int ngbe_probe(struct pci_dev *pdev,
>  	if (wx->wol_hw_supported)
>  		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
>  
> -	netdev->wol_enabled = !!(wx->wol);
> +	netdev->ethtool->wol_enabled = !!(wx->wol);
>  	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
>  	device_set_wakeup_enable(&pdev->dev, wx->wol);
>  
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index a5fa077650e8..32bfea9b5c6c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1282,7 +1282,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
>  		if (netdev) {
>  			struct device *parent = netdev->dev.parent;
>  
> -			if (netdev->wol_enabled)
> +			if (netdev->ethtool->wol_enabled)
>  				pm_system_wakeup();
>  			else if (device_may_wakeup(&netdev->dev))
>  				pm_wakeup_dev_event(&netdev->dev, 0, true);
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2ce74593d6e4..62afc0424fbd 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -285,7 +285,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	if (!netdev)
>  		goto out;
>  
> -	if (netdev->wol_enabled)
> +	if (netdev->ethtool->wol_enabled)
>  		return false;
>  
>  	/* As long as not all affected network drivers support the
> @@ -1859,7 +1859,8 @@ int phy_suspend(struct phy_device *phydev)
>  		return 0;
>  
>  	phy_ethtool_get_wol(phydev, &wol);
> -	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
> +	phydev->wol_enabled = wol.wolopts ||
> +			      (netdev && netdev->ethtool->wol_enabled);
>  	/* If the device has WOL enabled, we cannot suspend the PHY */
>  	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
>  		return -EBUSY;
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 0d7354955d62..b808ba1197c3 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2172,7 +2172,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
>  {
>  	ASSERT_RTNL();
>  
> -	if (mac_wol && (!pl->netdev || pl->netdev->wol_enabled)) {
> +	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
>  		/* Wake-on-Lan enabled, MAC handling */
>  		mutex_lock(&pl->state_mutex);
>  
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 62b61527bcc4..8aeefc0b4e10 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -935,6 +935,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  				       const struct ethtool_link_ksettings *cmd,
>  				       u32 *dev_speed, u8 *dev_duplex);
>  
> +/**
> + * struct ethtool_netdev_state - per-netdevice state for ethtool features
> + * @wol_enabled:	Wake-on-LAN is enabled
> + */
> +struct ethtool_netdev_state {
> +	unsigned		wol_enabled:1;

The use of bool seems to be quite well established in the kernel these
days. I suggest you use that.

Martin

> +};
> +
>  struct phy_device;
>  struct phy_tdr_config;
>  struct phy_plca_cfg;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7e520c14eb8c..05ea6cb56800 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -79,6 +79,7 @@ struct xdp_buff;
>  struct xdp_frame;
>  struct xdp_metadata_ops;
>  struct xdp_md;
> +struct ethtool_netdev_state;
>  /* DPLL specific */
>  struct dpll_pin;
>  
> @@ -2014,8 +2015,6 @@ enum netdev_ml_priv_type {
>   *			switch driver and used to set the phys state of the
>   *			switch port.
>   *
> - *	@wol_enabled:	Wake-on-LAN is enabled
> - *
>   *	@threaded:	napi threaded mode is enabled
>   *
>   *	@net_notifier_list:	List of per-net netdev notifier block
> @@ -2027,6 +2026,7 @@ enum netdev_ml_priv_type {
>   *	@udp_tunnel_nic_info:	static structure describing the UDP tunnel
>   *				offload capabilities of the device
>   *	@udp_tunnel_nic:	UDP tunnel offload state
> + *	@ethtool:	ethtool related state
>   *	@xdp_state:		stores info on attached XDP BPF programs
>   *
>   *	@nested_level:	Used as a parameter of spin_lock_nested() of
> @@ -2389,7 +2389,6 @@ struct net_device {
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
> -	unsigned		wol_enabled:1;
>  	unsigned		threaded:1;
>  
>  	struct list_head	net_notifier_list;
> @@ -2401,6 +2400,8 @@ struct net_device {
>  	const struct udp_tunnel_nic_info	*udp_tunnel_nic_info;
>  	struct udp_tunnel_nic	*udp_tunnel_nic;
>  
> +	struct ethtool_netdev_state *ethtool;
> +
>  	/* protected by rtnl_lock */
>  	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..9e85a71e33ed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10769,6 +10769,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	dev->real_num_rx_queues = rxqs;
>  	if (netif_alloc_rx_queues(dev))
>  		goto free_all;
> +	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
> +	if (!dev->ethtool)
> +		goto free_all;
>  
>  	strcpy(dev->name, name);
>  	dev->name_assign_type = name_assign_type;
> @@ -10819,6 +10822,7 @@ void free_netdev(struct net_device *dev)
>  		return;
>  	}
>  
> +	kfree(dev->ethtool);
>  	netif_free_tx_queues(dev);
>  	netif_free_rx_queues(dev);
>  
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 0b0ce4f81c01..de78b24fffc9 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1461,7 +1461,7 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
>  	if (ret)
>  		return ret;
>  
> -	dev->wol_enabled = !!wol.wolopts;
> +	dev->ethtool->wol_enabled = !!wol.wolopts;
>  	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF, NULL);
>  
>  	return 0;
> diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
> index 0ed56c9ac1bc..a39d8000d808 100644
> --- a/net/ethtool/wol.c
> +++ b/net/ethtool/wol.c
> @@ -137,7 +137,7 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
>  	ret = dev->ethtool_ops->set_wol(dev, &wol);
>  	if (ret)
>  		return ret;
> -	dev->wol_enabled = !!wol.wolopts;
> +	dev->ethtool->wol_enabled = !!wol.wolopts;
>  	return 1;
>  }
>  

