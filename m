Return-Path: <netdev+bounces-33323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF5F79D66E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF3B1C20F02
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F565C;
	Tue, 12 Sep 2023 16:36:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB638E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:36:38 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A15CF
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vkHIrUsfYPzdaP09GW2eh/cbVPFFtXY+QzcNCM5Z2tw=; b=aC8piOXpukpzakUQ+ZJuJAykWb
	J/0vjNz0bNx2E58kJl/sxXq1zcHOyQPN41/DHRP0+3ZMnG2GXV6bRSyH/5UGd/Tld6+LwdZ7e3ujV
	L9aT4CxhoQf8iKDie2q59ZGh2jWMx1UZStLLPRmKVpWzV+sih5p+yBl/t5NAzMQ4enR+GgHpZZmsE
	THNWCrEezIUSEypS5mnv95UOYxHlXQ2yYIA4vZdQI1JF0c70+lzKmyRbtjZQQca0q9fSuuinIjVLs
	uSXrWoNET9nyK5KWhwesM0urPAeAk128SBudKkaBWbOOm9nhbnL+e/DFnF2RlqLwosZcQHvRxIkbK
	7ksZ7Ahg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32858)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qg6NF-0001Rj-1O;
	Tue, 12 Sep 2023 17:36:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qg6NC-0002qv-3D; Tue, 12 Sep 2023 17:36:22 +0100
Date: Tue, 12 Sep 2023 17:36:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
	jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [RFC PATCH v3 net-next 2/7] net: ethtool: attach an IDR of
 custom RSS contexts to a netdevice
Message-ID: <ZQCThixvWBoCeT4r@shell.armlinux.org.uk>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
 <9c71d5168e1ee22b40625eec53a8bb00456d60ed.1694443665.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c71d5168e1ee22b40625eec53a8bb00456d60ed.1694443665.git.ecree.xilinx@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 12, 2023 at 03:21:37PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Each context stores the RXFH settings (indir, key, and hfunc) as well
>  as optionally some driver private data.
> Delete any still-existing contexts at netdev unregister time.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 43 ++++++++++++++++++++++++++++++++++++++++-
>  net/core/dev.c          | 23 ++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 8aeefc0b4e10..c770e32d79e6 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -157,6 +157,43 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  	return index % n_rx_rings;
>  }
>  
> +/**
> + * struct ethtool_rxfh_context - a custom RSS context configuration
> + * @indir_size: Number of u32 entries in indirection table
> + * @key_size: Size of hash key, in bytes
> + * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
> + * @priv_size: Size of driver private data, in bytes
> + * @indir_no_change: indir was not specified at create time
> + * @key_no_change: hkey was not specified at create time
> + */
> +struct ethtool_rxfh_context {
> +	u32 indir_size;
> +	u32 key_size;
> +	u8 hfunc;
> +	u16 priv_size;
> +	u8 indir_no_change:1;
> +	u8 key_no_change:1;
> +	/* private: driver private data, indirection table, and hash key are
> +	 * stored sequentially in @data area.  Use below helpers to access.
> +	 */
> +	u8 data[] __aligned(sizeof(void *));
> +};
> +
> +static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
> +{
> +	return ctx->data;
> +}
> +
> +static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
> +{
> +	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));
> +}
> +
> +static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
> +{
> +	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
> +}
> +
>  /* declare a link mode bitmap */
>  #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
>  	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
> @@ -937,10 +974,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
> + * @rss_ctx:		IDR storing custom RSS context state
> + * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
> -	unsigned		wol_enabled:1;
> +	struct idr		rss_ctx;

https://docs.kernel.org/core-api/idr.html

"The IDR interface is deprecated; please use the XArray instead."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

