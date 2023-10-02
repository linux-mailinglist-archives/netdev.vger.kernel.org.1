Return-Path: <netdev+bounces-37384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4E7B52CA
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BEF3A282490
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB3171A5;
	Mon,  2 Oct 2023 12:16:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455216419
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:16:57 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9094
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:16:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40651a726acso41918975e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249013; x=1696853813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVIYb8iR+IY1Vy1V/SixchvXPhBPU7v4GTxW9ZyB4CY=;
        b=PGVxXK1sOCkjz/tl/aDYwhertyJ3QHBEX8ZeJe4gggvUmc8oFFO/k7N3zyvNROh0k0
         O4oLj+jn7sBoKB1/9+FnQd/tkTyTSai77d1Uxw8afWUiIT+UXY5TTQqCahfeQzHmQw0Y
         406vvCKNvpaVurKT1+8KAvhT0yJkOkGJqwbHUrnO6WyEzfD/wcLumgYD0rcguWw110ml
         9VPFk1srHnE4981MqpdYhTDrUwnV3+0TrElxbpZSaO0Vr5GytbhO8UbWCwaL4HhIKWR0
         mdHZlPSgz6jBd1q9nxunAXHcId0KZM3lZvufTPoitWGUmX8vjZNXEVxD34kihi0OvWCV
         3H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249013; x=1696853813;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVIYb8iR+IY1Vy1V/SixchvXPhBPU7v4GTxW9ZyB4CY=;
        b=HJgXJqqqBhkovZAjcKxmJ0FJgtKGADagJw55Lkm4lA1AEoYueACskGkq3g9zLP/cZp
         MLd1w/HUa8i3klaLQ1hEOS+j+Wcjiy7kMjESoDwa/pfha/UV4A0b7F8OnjifrfUlLj9o
         LZReAldeV7oQF92WN4WM66ivvJlrWeJylqaUNslhCkPft+AS0n44F7nuFk3HM0ku3yBQ
         ZXHy0gK6PTaoKV9IEVEloRXcQh9N0EKFIiiH8M0Kag3KTRstHBGHn5IZia4+K8sZTO9c
         va5bmWSAzfNtdvEgCUsJWq5u23eqDWNNfkzIC7hpqXkDm6Q0FtJMl5gpAJ7P3QG9xCfG
         +/5A==
X-Gm-Message-State: AOJu0YykQ1i2Vy/EOdvg0Q6b5k7fwJX5jhNB2Ohd5oBFFc/60M8l8Q2J
	YF7avlX4iqVTROULNJS0ZuU=
X-Google-Smtp-Source: AGHT+IH+RXHNieBq5ENXvLGDVRBtmggyvpGCnvDeQNj4DBb19BHnniOaShNIY2AwO+guHV55ICDdHw==
X-Received: by 2002:a05:600c:2318:b0:401:be77:9a50 with SMTP id 24-20020a05600c231800b00401be779a50mr9373938wmo.8.1696249012415;
        Mon, 02 Oct 2023 05:16:52 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c34c400b003feea62440bsm7232984wmq.43.2023.10.02.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:16:51 -0700 (PDT)
Date: Mon, 2 Oct 2023 13:16:50 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting RSS
 contexts
Message-ID: <20231002121650.GF21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:37PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> While this is not needed to serialise the ethtool entry points (which
>  are all under RTNL), drivers may have cause to asynchronously access
>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>  do this safely without needing to take the RTNL.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  include/linux/ethtool.h | 3 +++
>  net/core/dev.c          | 5 +++++
>  net/ethtool/ioctl.c     | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index c8963bde9289..d15a21bd6f12 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1026,11 +1026,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
>   * @rss_ctx:		XArray of custom RSS contexts
> + * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
> + *			within RTNL.
>   * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
>  	struct xarray		rss_ctx;
> +	struct mutex		rss_lock;
>  	u32			rss_ctx_max_id;
>  	u32			wol_enabled:1;
>  };
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 69579d9cd7ba..c57456ed4be8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10074,6 +10074,7 @@ int register_netdevice(struct net_device *dev)
>  
>  	/* rss ctx ID 0 is reserved for the default context, start from 1 */
>  	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
> +	mutex_init(&dev->ethtool->rss_lock);
>  
>  	spin_lock_init(&dev->addr_list_lock);
>  	netdev_set_addr_lockdep_class(dev);
> @@ -10882,6 +10883,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  	struct ethtool_rxfh_context *ctx;
>  	unsigned long context;
>  
> +	mutex_lock(&dev->ethtool->rss_lock);
>  	if (dev->ethtool_ops->create_rxfh_context ||
>  	    dev->ethtool_ops->set_rxfh_context)
>  		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> @@ -10903,6 +10905,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  			kfree(ctx);
>  		}
>  	xa_destroy(&dev->ethtool->rss_ctx);
> +	mutex_unlock(&dev->ethtool->rss_lock);
>  }
>  
>  /**
> @@ -11016,6 +11019,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
>  		if (dev->netdev_ops->ndo_uninit)
>  			dev->netdev_ops->ndo_uninit(dev);
>  
> +		mutex_destroy(&dev->ethtool->rss_lock);
> +
>  		if (skb)
>  			rtmsg_ifinfo_send(skb, dev, GFP_KERNEL, portid, nlh);
>  
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 3920ddee3ee2..d21bbc92e6fc 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1258,6 +1258,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	u8 *rss_config;
>  	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
>  	bool create = false, delete = false;
> +	bool locked = false; /* dev->ethtool->rss_lock taken */
>  
>  	if (!ops->get_rxnfc || !ops->set_rxfh)
>  		return -EOPNOTSUPP;
> @@ -1335,6 +1336,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> +	if (rxfh.rss_context) {
> +		mutex_lock(&dev->ethtool->rss_lock);
> +		locked = true;
> +	}
>  	if (create) {
>  		if (delete) {
>  			ret = -EINVAL;
> @@ -1455,6 +1460,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	}
>  
>  out:
> +	if (locked)
> +		mutex_unlock(&dev->ethtool->rss_lock);
>  	kfree(rss_config);
>  	return ret;
>  }

