Return-Path: <netdev+bounces-289549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B33F4ueDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:31:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DB5831BF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEFF23085400
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811735201F;
	Tue, 19 May 2026 17:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CD367B91
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211789; cv=none; b=TBruZRveSZFFbrBSBsoToLIi/AQ6LsakusSUyHaL10jaOMqPSCxgpZJWJmcDA1TiUx7iD2rMelT6qa04suKy7Ic7GFRFt0CQ17b0LoXSyLAi2MUfmOd1obQ7VfdDZiuTGHosGZpJLWUz2cCvvOIL/G7gor22R6uNQbYhho7oroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211789; c=relaxed/simple;
	bh=3AK70A9kymoVOJt9mrGL78Ugh+WcL86YALeP3Xa+WKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZeugxhQ3DGerWOaKYUPzyH9FBO0Ycp7hyniHiWEe494n84kJROza4xSB4l4zP9oUiVDhOHFlHPqYHI29ADxtY2HBICDWRMnNLlKUVun9duqv7yLD1kFRqxGzWbiE0jAbRttGDl9ocEOzuUZOE2XYtKT2PpkI4znQBXLQDMnI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOGG-000000001ZV-4ASN;
	Tue, 19 May 2026 17:29:45 +0000
Date: Tue, 19 May 2026 18:29:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 4/9] net: mdio: realtek-rtl9300: Add pages to info
 structure
Message-ID: <agyeBuG9IJ0JOx6v@makrotopia.org>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-5-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TAGGED_FROM(0.00)[bounces-289549-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: CB9DB5831BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:57:42PM +0200, Markus Stockhausen wrote:
> The Realtek MDIO controller has a paging feature that allows to run C22
> reads/writes in one turn. At least this holds true for attached Realtek
> based PHYs. The controller is given the page, the register and the data
> and it runs all the page switching in the background in hardware.
> 
> There is however one special page that allows to pass through all C22
> commands directly to the PHY - without any caching. This so called raw
> page is dependent of the hardware. It is the highest supported page
> number minus 1. This is either 4095 for low port count SOCs (up to 28
> ports) or 8191 for high port count SOCs (up to 56 ports).
> 
> Provide the number of supported pages as a device specific property.
> The raw page directly derives from that as "num_pages - 1". Make use
> of it where needed.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 4533c2f68cab..0ea691d9fc1b 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -47,13 +47,16 @@
>  #define MAX_PORTS       28
>  #define MAX_SMI_BUSSES  4
>  #define MAX_SMI_ADDR	0x1f
> +#define RAW_PAGE(x)	((x) - 1)

Maybe use
#define RAW_PAGE(priv)	((priv)->info->num_pages - 1)

as anyway you are only calling it in that way.

>  
>  #define RTL9300_NUM_BUSES		4
> +#define RTL9300_NUM_PAGES		4096
>  #define RTL9300_NUM_PORTS		28
>  
>  struct rtl_mdio_info {
>  	u8 num_buses;
>  	u8 num_ports;
> +	u16 num_pages;
>  };
>  
>  struct rtl_mdio_priv {
> @@ -126,7 +129,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
>  
>  	val = FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
>  	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
> -	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
> +	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
>  	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
>  	err = regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
>  	if (err)
> @@ -179,7 +182,7 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum, u
>  
>  	val = FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
>  	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
> -	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
> +	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
>  	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
>  	err = regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
>  	if (err)
> @@ -512,6 +515,7 @@ static int rtl_mdiobus_probe(struct platform_device *pdev)
>  static const struct rtl_mdio_info rtl9300_mdio_info = {
>  	.num_buses = RTL9300_NUM_BUSES,
>  	.num_ports = RTL9300_NUM_PORTS,
> +	.num_pages = RTL9300_NUM_PAGES,
>  };
>  
>  static const struct of_device_id rtl_mdio_ids[] = {
> -- 
> 2.54.0
> 

