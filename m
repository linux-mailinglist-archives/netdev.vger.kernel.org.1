Return-Path: <netdev+bounces-29578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F001783D78
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5036C1C20A86
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80699449;
	Tue, 22 Aug 2023 10:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F358F55
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:03:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3DA1B0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d+PLp4qGv9vyBKfdVLM+uFC8RtyxXmEgg449xXe+ZhI=; b=00DiuSTkr9j/IHq+UsXbi3ikpd
	M5/xGrJBCzwpTqEP+gogytb4rbMhzHARQuql9gWqxVnbnD3VnA4J0zEyYcsKZUViXgpx29XN5VU7z
	qeI2j4crsphzOy9dmvd/vSAZ8CfYetnyLPKf3dmhHVTArWX2K44FvqdA+XKF0CaHycSLTRMNJZlEB
	B5eq/C34+P70Ap7WO2WXGoI3ZBDSuTTdaSojF/82CfCl5sroFLyq2oNto47mIdxDh5626ZQYqnqgb
	VZyGurX8p7wgqipjXsC9883gxdmIrQI8ia63yQnZjwTJ0+DPjqDUTjKHLZmJRfE8OPfTHDoaP4i3o
	0M7ZEsYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34830)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qYOE3-0001E2-1A;
	Tue, 22 Aug 2023 11:03:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qYOE0-0005hB-T8; Tue, 22 Aug 2023 11:03:00 +0100
Date: Tue, 22 Aug 2023 11:03:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, dongbiao@loongson.cn,
	guyinggang@loongson.cn, siyanteng@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v4 01/11] net: stmmac: Pass stmmac_priv and chan in some
 callbacks
Message-ID: <ZOSH1GxHkWbDGSLj@shell.armlinux.org.uk>
References: <cover.1692696115.git.chenfeiyang@loongson.cn>
 <e452ba21887e37a747f8d4f0f74ef4f2590c3eac.1692696115.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e452ba21887e37a747f8d4f0f74ef4f2590c3eac.1692696115.git.chenfeiyang@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 05:40:26PM +0800, Feiyang Chen wrote:
> @@ -636,7 +637,8 @@ static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
>   * All slot > 0 need to be enabled with MAC_ADDR_TYPE_DST
>   * If addr is NULL, clear the slot
>   */
> -static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
> +static void sun8i_dwmac_set_umac_addr(struct stmmac_priv *priv,
> +				      struct mac_device_info *hw,
>  				      const unsigned char *addr,
>  				      unsigned int reg_n)
>  {

Given that hw is always priv->hw, would it be sensible to simplify the
callback by dropping the "hw" argument, and have the called methods do:

	struct mac_device_info *hw = priv->hw;

> @@ -657,7 +659,8 @@ static void sun8i_dwmac_set_umac_addr(struct mac_device_info *hw,
>  	}
>  }
>  
> -static void sun8i_dwmac_get_umac_addr(struct mac_device_info *hw,
> +static void sun8i_dwmac_get_umac_addr(struct stmmac_priv *priv,
> +				      struct mac_device_info *hw,
>  				      unsigned char *addr,
>  				      unsigned int reg_n)
>  {

Same here.

> @@ -680,7 +683,8 @@ static int sun8i_dwmac_rx_ipc_enable(struct mac_device_info *hw)
>  	return 1;
>  }
>  
> -static void sun8i_dwmac_set_filter(struct mac_device_info *hw,
> +static void sun8i_dwmac_set_filter(struct stmmac_priv *priv,
> +				   struct mac_device_info *hw,
>  				   struct net_device *dev)
>  {

Probably also worth doing for this method as well. I think the only
thing which this function uses is hw->unicast_filter_entries, so
one could declare:

	unsigned int unicast_filter_entries = priv->hw->unicast_filter_entries;

rather than carrying the pointer to both "priv" and "hw" through this
function.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

