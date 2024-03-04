Return-Path: <netdev+bounces-77270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D17368710D7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE76B221CA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3987C0A8;
	Mon,  4 Mar 2024 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ocl5RAEL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8687B3FA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593429; cv=none; b=cy0ETrXfsi/HCoAvOsL0XmwNcarfsFvf6iZEWdn/pv4DQ5XYFSU0ALAd5TzYKo6+IptZ+JI/fmZ5c26BKh77XeF+PrJPEBxwEzu49+w9dQdbfErX64AmVf4tRPPHhU4C2ZnU10F+nkMn60YzS5WVz7I6SEXU8XzQGk71q4ADxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593429; c=relaxed/simple;
	bh=EtDr3Y5rZ+SuQVzEWb04ywA9Iye+QIuH0OHvxenuvw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oycAneDKO+35eEUJJP82PBg/+sU3eoevhIMKm8HKAA1MTeuMLJdMLEWFZNgoZQ/i1dqINzK2If0vBf5yDQTdBjS8k0pPemapP203OrrsYRP7nsYsmHfmR90iLUswf+77G3KY3TdKLojVh4HQjh17o6KYGWYXeqwIHeS6mxOCVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ocl5RAEL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=opPB80CnLjIFhJ+2AVcrH9KaVYjmH1SvaeUo+CgL66g=; b=Ocl5RAELvstgzEcqbu0Jhf49oP
	pgEYW0fu8CGsfL995eoWIOI0in6H5pfhoBe5eXV2m71OIIvVCXT0E8tlH7uLZ+insz0dX+diDd0L1
	oIQIRVSJQGpji1u9Rk2bvexkKxyPvlsAM+rCTNNFUHjg9Q54QSCG4IdsgsbT8c5wQ90M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhHLw-009MRd-0h; Tue, 05 Mar 2024 00:04:12 +0100
Date: Tue, 5 Mar 2024 00:04:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 22/22] ovpn: add basic ethtool support
Message-ID: <57e2274e-fa83-47c9-890b-bb3d2a62acb9@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-23-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-23-antonio@openvpn.net>

On Mon, Mar 04, 2024 at 04:09:13PM +0100, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/main.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 95a94ccc99c1..9dfcf2580659 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -13,6 +13,7 @@
>  #include "ovpnstruct.h"
>  #include "packet.h"
>  
> +#include <linux/ethtool.h>
>  #include <linux/genetlink.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> @@ -83,6 +84,36 @@ static const struct net_device_ops ovpn_netdev_ops = {
>  	.ndo_get_stats64        = dev_get_tstats64,
>  };
>  
> +static int ovpn_get_link_ksettings(struct net_device *dev,
> +				   struct ethtool_link_ksettings *cmd)
> +{
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
> +	cmd->base.speed	= SPEED_1000;
> +	cmd->base.duplex = DUPLEX_FULL;
> +	cmd->base.port = PORT_TP;
> +	cmd->base.phy_address = 0;
> +	cmd->base.transceiver = XCVR_INTERNAL;
> +	cmd->base.autoneg = AUTONEG_DISABLE;

Why? It is a virtual device. Speed and duplex is meaningless. You
could run this over FDDI, HIPPI, or RFC 1149? So why PORT_TP?

> +static void ovpn_get_drvinfo(struct net_device *dev,
> +			     struct ethtool_drvinfo *info)
> +{
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->version, DRV_VERSION, sizeof(info->version));

Please leave version untouched. The ethtool core will then fill it in
with something useful.

> +	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));

This is also not accurate. There is no bus involved.

     Andrew

