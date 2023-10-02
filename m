Return-Path: <netdev+bounces-37383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D07B52C5
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 38AA62840B0
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCBF171B5;
	Mon,  2 Oct 2023 12:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0397171C6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:13:31 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7A170E
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:13:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so63871235e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696248793; x=1696853593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E6zLEbuF7yCYO5lVzEIKhDg6ftS0hm22ODHgX+gy94=;
        b=HwpCEUyF9/f8ED4gEG36XbpvSEp7nrsgnsIk5E5noDJkbQUUgPIMnMoTEcyx1gEyLj
         lvfX0Q7kVE+nRiJC1a+NdxO2W//G9AAUfd7w4wcLGRsfwiWpVOTQXfxBz2nkkaF/m9Az
         dKiNb0Anvb2PZtJ/gkB9ii6MvDCIxA2hLFPSbHwuGIqlmcfJdpVOoMi8EzGWZYGrpshr
         DuZm5qGLmba2Tv5UMfbn2tELhD+zW2XZbEu4Nt66EC2H9FA+4V16ZlEEsIlBxEI2gEG6
         WB8g8vANmFYs9hcEVMEVUtserGDMSmYQV7wjEanf+fhbi/ZVlfMzAr0skCpWW3fZn5nH
         qPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696248793; x=1696853593;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2E6zLEbuF7yCYO5lVzEIKhDg6ftS0hm22ODHgX+gy94=;
        b=EIpPycdLQEunbl3P8ad0b0QZ3ONcVaAB+qivGnptiqPqcpuALIxm099kuBx3yHR+FF
         dV6DblpkX8LgtDH5sBYM/FGMP80mM7BXX2x/J63YDiS9BMMnr7/HQsfOILS+Dk/obTm/
         oxxYkOjbUON8KPKcc58fFaFZ2NB6wsgQMvU79c2fZHt5DJYIWWEa3CeY4nB5LGEGBarH
         I6MwH4PRsgbjmb/pLcnJxoQPTyTBN5NICO1Ccm2kaDR3rLOsLne5zCT7c1oRTiBLLqu0
         36V22KpO8Z8tM+x7iE1n77nZ6tE1e6BHdbeNvQRqGZnEzSN6yqnqlExjMvWb+OHdWS6Y
         l0XA==
X-Gm-Message-State: AOJu0Ywm4G1tuqln4wyv3XZge1AZ4gDw4qSnRimq/OVuzjfngecql39O
	hcT1dF34NC8yd62U7XJeOCMmWzKAY2s=
X-Google-Smtp-Source: AGHT+IFp1Xc9/Fbjdtm4E3BmNvGZScZxOXiOhKPiPeTONM4tOtoU1f33SYztuOWZqoZLSsQ+J8SOvg==
X-Received: by 2002:a05:600c:2284:b0:403:e21:1355 with SMTP id 4-20020a05600c228400b004030e211355mr9436757wmf.36.1696248792966;
        Mon, 02 Oct 2023 05:13:12 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b00405d9a950a2sm6827308wmq.28.2023.10.02.05.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:13:12 -0700 (PDT)
Date: Mon, 2 Oct 2023 13:13:10 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	sudheer.mogilappagari@intel.com, jdamato@fastly.com, andrew@lunn.ch,
	mw@semihalf.com, linux@armlinux.org.uk, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 5/7] net: ethtool: add an extack parameter to
 new rxfh_context APIs
Message-ID: <20231002121310.GE21694@gmail.com>
Mail-Followup-To: edward.cree@amd.com, linux-net-drivers@amd.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
	leon@kernel.org
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <63183b19786e2a97dfe55ed31313ede1a50427fc.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63183b19786e2a97dfe55ed31313ede1a50427fc.1695838185.git.ecree.xilinx@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 07:13:36PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Currently passed as NULL, but will allow drivers to report back errors
>  when ethnl support for these ops is added.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  include/linux/ethtool.h | 9 ++++++---
>  net/core/dev.c          | 3 ++-
>  net/ethtool/ioctl.c     | 9 ++++++---
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 975fda7218f8..c8963bde9289 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -927,14 +927,17 @@ struct ethtool_ops {
>  	int	(*create_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
>  				       const u32 *indir, const u8 *key,
> -				       const u8 hfunc, u32 rss_context);
> +				       const u8 hfunc, u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*modify_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
>  				       const u32 *indir, const u8 *key,
> -				       const u8 hfunc, u32 rss_context);
> +				       const u8 hfunc, u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*remove_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
> -				       u32 rss_context);
> +				       u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
>  				    const u8 *key, const u8 hfunc,
>  				    u32 *rss_context, bool delete);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 637218adca22..69579d9cd7ba 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10892,7 +10892,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  			xa_erase(&dev->ethtool->rss_ctx, context);
>  			if (dev->ethtool_ops->create_rxfh_context)
>  				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
> -								      context);
> +								      context,
> +								      NULL);
>  			else
>  				dev->ethtool_ops->set_rxfh_context(dev, indir,
>  								   key,
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index c23d2bd3cd2a..3920ddee3ee2 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1381,14 +1381,17 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			if (create)
>  				ret = ops->create_rxfh_context(dev, ctx, indir,
>  							       hkey, rxfh.hfunc,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  			else if (delete)
>  				ret = ops->remove_rxfh_context(dev, ctx,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  			else
>  				ret = ops->modify_rxfh_context(dev, ctx, indir,
>  							       hkey, rxfh.hfunc,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  		} else {
>  			ret = ops->set_rxfh_context(dev, indir, hkey,
>  						    rxfh.hfunc,

