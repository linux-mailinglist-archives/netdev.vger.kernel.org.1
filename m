Return-Path: <netdev+bounces-259133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN88MU64lGlmHQIAu9opvQ
	(envelope-from <netdev+bounces-259133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:49:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B24C14F56C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2149300F11B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A0937419C;
	Tue, 17 Feb 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vm1SvlrW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37F7372B2D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354037; cv=none; b=VuRGjBTA+Z5AOIQbYLjPJBM9Tg6ewp0TjDmtRi+78oxBbhmPD6TCN6PU0xzqzJMIPAZhmKZO2y5cORSl8XcC5TvDR8Ej9qQFZzyFYYKXWszoAJ8dbte1wqPr1/K5pFt5Nyd0TE2DY+moLvQMsLmuWfwjT7nocEoFpn4/vZaKz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354037; c=relaxed/simple;
	bh=iI17eKY7831I4v/LSqilRIb3i55bBiPkk0Q8j+MduH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BICmD7NqrBDbtMeSTiYj+VSJQrl4CSJ0MoJPRfA9Q9kMTnaYgt6UCD5eR76d+pqX/9KvL0gTM8Q/B6kjyjILFF5g5nJeqwsgXHhGJak/AfYuMwAZ08R3MbuAI74dTyhGqjEBiejaX9uqtion7b0OqSbwFs+iHhfe1N4jIpvr04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vm1SvlrW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jkDG/6fbm0MndLXoxY+/V4qbC0GcfzAF/K4oVMflivw=; b=vm1SvlrWNEqPnPJVHxa2p3gE5l
	qHA8U43DvaIRVrJc40x3c0Zqw3Hrcgi6aLkbhfsI8FW2G6B7MHeHCEihN/Mx+LXeaRGcW4RtyHA22
	B62VZ/qaj08NnIv8SDuRwxGmMSYyWsSnVjj+dzFStCjMY56iKT+8vih6m1Jc6ZVolUq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vsQ6F-007g9S-Aw; Tue, 17 Feb 2026 19:47:07 +0100
Date: Tue, 17 Feb 2026 19:47:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, hayeswang@realtek.com, bjorn@mork.no,
	o.rempel@pengutronix.de, Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC net-next 2/3] net: usb: usbnet: switch to dynamic
 allocation of private data
Message-ID: <8d1bf5ab-f154-4e64-84a2-929d06fb4e6e@lunn.ch>
References: <20260210151416.42254-1-oneukum@suse.com>
 <20260210151416.42254-3-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210151416.42254-3-oneukum@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259133-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B24C14F56C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 04:11:13PM +0100, Oliver Neukum wrote:
> usbnet used an unsigned long[5] scratchpad space for private
> use of subdrivers. That is inelegant and not enough space
> for some drivers. Switch to letting drivers specify how much
> room they need in their driver_info.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/net/usb/ax88172a.c   |  1 +
>  drivers/net/usb/cdc_mbim.c   |  4 ++
>  drivers/net/usb/cdc_ncm.c    | 82 +++++++++++++++++-------------------
>  drivers/net/usb/sierra_net.c | 21 +++------
>  drivers/net/usb/smsc75xx.c   |  4 +-
>  drivers/net/usb/usbnet.c     |  2 +-
>  include/linux/usb/usbnet.h   |  5 ++-
>  7 files changed, 56 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
> index 1694d6ca2b7b..34884805730d 100644
> --- a/drivers/net/usb/ax88172a.c
> +++ b/drivers/net/usb/ax88172a.c
> @@ -355,4 +355,5 @@ const struct driver_info ax88172a_info = {
>  		 FLAG_MULTI_PACKET,
>  	.rx_fixup = ax88172a_rx_fixup,
>  	.tx_fixup = asix_tx_fixup,
> +	.required_room = sizeof(struct ax88172a_private),

A change like this makes sense, given the commit message.

> @@ -107,7 +107,7 @@ static void cdc_ncm_get_ethtool_stats(struct net_device *netdev,
>  				    u64 *data)
>  {
>  	struct usbnet *dev = netdev_priv(netdev);
> -	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private[0];
> +	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->private;

But it is not clear why changes like this belong on this patch. Can
they be moved into another patch with a good commit message?

>  static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
>  {
> -	if (ctx == NULL)
> -		return;
> -

Maybe a patch of its own?

>  	if (ctx->tx_rem_skb != NULL) {
>  		dev_kfree_skb_any(ctx->tx_rem_skb);
>  		ctx->tx_rem_skb = NULL;
> @@ -782,12 +779,13 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
>  		ctx->tx_curr_skb = NULL;
>  	}
>  
> -	if (ctx->is_ndp16)
> +	if (ctx->is_ndp16) {
>  		kfree(ctx->delayed_ndp16);
> -	else
> +		ctx->delayed_ndp16 = NULL;
> +	} else {
>  		kfree(ctx->delayed_ndp32);
> -
> -	kfree(ctx);
> +		ctx->delayed_ndp32 = NULL;
> +	}

Another patch, with an commit message explaining why this is needed.

> --- a/drivers/net/usb/sierra_net.c
> +++ b/drivers/net/usb/sierra_net.c
> @@ -190,14 +190,7 @@ static const struct net_device_ops sierra_net_device_ops = {
>  /* get private data associated with passed in usbnet device */
>  static inline struct sierra_net_data *sierra_net_get_private(struct usbnet *dev)
>  {
> -	return (struct sierra_net_data *)dev->private[0];
> -}
> -
> -/* set private data associated with passed in usbnet device */
> -static inline void sierra_net_set_private(struct usbnet *dev,
> -			struct sierra_net_data *priv)
> -{
> -	dev->private[0] = (unsigned long)priv;
> +	return (struct sierra_net_data *)dev->private;
>  }
>  
>  /* is packet IPv4/IPv6 */
> @@ -653,7 +646,7 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
>  	u8	numendpoints;
>  	u16	fwattr = 0;
>  	int	status;
> -	struct sierra_net_data *priv;
> +	struct sierra_net_data *priv = (struct sierra_net_data *)dev->private;
>  	static const u8 sync_tmplate[sizeof(priv->sync_msg)] = {
>  		0x00, 0x00, SIERRA_NET_HIP_MSYNC_ID, 0x00};
>  	static const u8 shdwn_tmplate[sizeof(priv->shdwn_msg)] = {
> @@ -682,11 +675,8 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
>  		dev_err(&dev->udev->dev, "No status endpoint found");
>  		return -ENODEV;
>  	}
> -	/* Initialize sierra private data */
> -	priv = kzalloc(sizeof *priv, GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;

Removing the sierra drivers own memory management should be a separate
patch.

> @@ -1500,7 +1500,7 @@ static int smsc75xx_bind(struct usbnet *dev, struct usb_interface *intf)
>  	cancel_work_sync(&pdata->set_multicast);
>  free_pdata:
>  	kfree(pdata);
> -	memset(dev->private, 0, sizeof(dev->private));
> +	memset(dev->private, 0, sizeof(struct smsc75xx_priv *));
>  	return ret;
>  }
>  
> @@ -1511,7 +1511,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
>  		cancel_work_sync(&pdata->set_multicast);
>  		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
>  		kfree(pdata);
> -		memset(dev->private, 0, sizeof(dev->private));
> +		memset(dev->private, 0, sizeof(struct smsc75xx_priv *));

These also might need investigating. Why is it necessary to memset
this memory? Has the life cycle of the memory changed? Can these be
removed? Again, a separate patch, with a good commit message
explaining why?

I think the general idea is good, it just needs breaking up into
smaller patches with good commit messages, and you should try to make
it look more normal, void *, little wrappers, no casts, etc.

   Andrew

