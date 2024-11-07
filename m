Return-Path: <netdev+bounces-143095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D19C120D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3831A1F22DDB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4872185BD;
	Thu,  7 Nov 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="he9bN0s8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C761DC04A;
	Thu,  7 Nov 2024 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020224; cv=none; b=HFQUnTsKnRdGWRp4KYfKoo0AaqfXFy+i8NKx9nFr0LR6190sxIlh7PCBjh07SNzjOETh7uB2URlF9wQMjCguxTZc8IIPci4I82G4pTKASezfHL88Pvj6xYBO+m29nIVoFqqL2GK59jeHKwxQs9yX9zBTM/qrQbcBegE8xwDy3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020224; c=relaxed/simple;
	bh=L3mXBeKU/8pm2ZNFXvC7OnqW/gHi7KoOFeU797wZ2P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZBwAbVKNIXWHs/l8OvAACpg2VK9luF76ebrmRMAmozyop9ZhEnJx0kphEiG1fl1cb5FsoJ4bsd6gylopMHdCZaNRZKPR2NHfRlvNeMIJ1bsRIWaW/i8FPFiK7y2KW4CyuRZRFOUTFn7RvXWXw5O/LndTiZ4smpdatmq3uxiI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=he9bN0s8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p/Fg7hJcFNbkaFQNMrRSc1TG0qh4lSIlIOsatLO1aUo=; b=he9bN0s8NNYDRfG3RF5YDWFgU6
	/EZr9xTizP07l0FGwwHdDoQFySEymwaGsAPGywABvJf9UNGeZUnEdGDqeuW/bXkbg/EvG07XEZtEf
	MCJvWpEWGrcGBrLfuzB0HzUSMATlkn5hXs6mnP6IznI7C0J5ALBcyj+EuyQLeEkvu0yI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9BQo-00CWID-61; Thu, 07 Nov 2024 23:56:50 +0100
Date: Thu, 7 Nov 2024 23:56:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 7/7] net: lan969x: add function for configuring
 RGMII port devices
Message-ID: <6fee4db6-0085-4ce8-a6b5-050fddd0bc5a@lunn.ch>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>

On Wed, Nov 06, 2024 at 08:16:45PM +0100, Daniel Machon wrote:
> The lan969x switch device includes two RGMII interfaces (port 28 and 29)
> supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.
> 
> Add new function: rgmii_config() to the match data ops, and use it to
> configure RGMII port devices when doing a port config.  On Sparx5, the
> RGMII configuration will always be skipped, as the is_port_rgmii() will
> return false.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  drivers/net/ethernet/microchip/lan969x/lan969x.c   | 105 +++++++++++++++++++++
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   2 +
>  .../net/ethernet/microchip/sparx5/sparx5_port.c    |   3 +
>  3 files changed, 110 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> index cfd57eb42c04..0681913a05d4 100644
> --- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
> +++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> @@ -9,6 +9,17 @@
>  #define LAN969X_SDLB_GRP_CNT 5
>  #define LAN969X_HSCH_LEAK_GRP_CNT 4
>  
> +#define LAN969X_RGMII_TX_CLK_DISABLE 0  /* Disable TX clock generation*/
> +#define LAN969X_RGMII_TX_CLK_125MHZ 1   /* 1000Mbps */
> +#define LAN969X_RGMII_TX_CLK_25MHZ  2   /* 100Mbps */
> +#define LAN969X_RGMII_TX_CLK_2M5MHZ 3   /* 10Mbps */
> +#define LAN969X_RGMII_PORT_START_IDX 28 /* Index of the first RGMII port */
> +#define LAN969X_RGMII_PORT_RATE 2       /* 1000Mbps  */
> +#define LAN969X_RGMII_SHIFT_90DEG 3     /* Phase shift 90deg. (2 ns @ 125MHz) */
> +#define LAN969X_RGMII_IFG_TX 4          /* TX Inter Frame Gap value */
> +#define LAN969X_RGMII_IFG_RX1 5         /* RX1 Inter Frame Gap value */
> +#define LAN969X_RGMII_IFG_RX2 1         /* RX2 Inter Frame Gap value */
> +
>  static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
>  	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
>  	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> @@ -293,6 +304,99 @@ static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
>  	return IRQ_HANDLED;
>  }
>  
> +static int lan969x_port_config_rgmii(struct sparx5 *sparx5,
> +				     struct sparx5_port *port,
> +				     struct sparx5_port_config *conf)
> +{
> +	int tx_clk_freq, idx = port->portno - LAN969X_RGMII_PORT_START_IDX;
> +	enum sparx5_port_max_tags max_tags = port->max_vlan_tags;
> +	enum sparx5_vlan_port_type vlan_type = port->vlan_type;
> +	bool dtag, dotag, tx_delay = false, rx_delay = false;
> +	u32 etype;
> +
> +	tx_clk_freq = (conf->speed == SPEED_10	? LAN969X_RGMII_TX_CLK_2M5MHZ :
> +		       conf->speed == SPEED_100 ? LAN969X_RGMII_TX_CLK_25MHZ :
> +						  LAN969X_RGMII_TX_CLK_125MHZ);

https://www.spinics.net/lists/netdev/msg1040925.html

Once it is merged, i think this does what you want.

> +	if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> +	    conf->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> +		rx_delay = true;
> +
> +	if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> +	    conf->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID)
> +		tx_delay = true;

O.K, now warning bells are ringing in this reviews head.

What i don't see is the value you pass to the PHY? You obviously need
to mask out what the MAC is doing when talking to the PHY, otherwise
both ends will add delays.

And in general in Linux, we have the PHY add the delays, not the
MAC. It is somewhat arbitrary, but the vast majority of systems do
that. The exception is systems where the PHY is too dumb/cheap to add
the delays and so the MAC has to do it. I'm don't know of any
Microchip PHYs which don't support RGMII delays.

	Andrew

