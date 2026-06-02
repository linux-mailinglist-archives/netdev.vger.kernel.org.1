Return-Path: <netdev+bounces-294179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id voH7BALKHmqNVAAAu9opvQ
	(envelope-from <netdev+bounces-294179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:18:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C962DEDC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:18:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=oHaM3+dV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294179-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294179-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 711243022DD9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A53D1CD1;
	Tue,  2 Jun 2026 12:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9930FF2A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:14:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402452; cv=none; b=Q8LNsF/8lDzVUAjzKDxf2zPqqerIVGj2gjubEPJLBbwRuLow/XAENt2CcoAw+cNMUlIYmrmmr+93ohuqZbAq41sKUlKRhIXUO4OGXB4JhUekGY3PpMu2mxXdAgNZ7PRipcx6j8YPCejcBPWSjnaTrKTRNQIiw7UwNJo6K+DXl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402452; c=relaxed/simple;
	bh=LOh/gzAWvvjVXnZ6FqflrWOLErMGSTAHhcWjVTXsKzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkF/5kXqpT9l93F+rQDNQemr1UFK0gQ7Cja81izMpgYdYdvz3Kkyl/rMt6QNudRA8fX4w3Wxj3OH/cTFRR4Ip2VqA+nG7HnhT/M1w47orpFLZgjLh/w8r8Qpia4bgzSL7V7gf5OYPXd9NX1JEeftVWBW9I583rhQFAvnbqTFV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oHaM3+dV; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=skChEZ5rNkBdSM26eWlE/MYi8w9c3PNgfltehp4DK2M=; b=oHaM3+dVqjKEtI28bCvH9v/+HS
	1/OwY3rjTkkmR9bChAZAf89Qdqs/jBwG8/cU7Zh8KiyUQN+gJUvsILIuSCu2I9Fy4myNQD5uujOdc
	uMvy0z+v9Z+BFg71otE7KDoeILdsh/Ay7lKs1vL/CAwMzsSdpviUIPNFEx2j8ncFluD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUO0O-005gN5-D3; Tue, 02 Jun 2026 14:14:00 +0200
Date: Tue, 2 Jun 2026 14:14:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
 otto_emdio_map_ports()
Message-ID: <0cef9fd1-7686-4eb4-862d-ed4a3fd730f5@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602052640.93083-4-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 695C962DEDC

On Tue, Jun 02, 2026 at 07:26:35AM +0200, Markus Stockhausen wrote:
> Due to its design the MDIO driver needs to set up a port to bus/address
> mapping during probing. The "ethernet-ports" subnodes are scanned and
> from the "phy-handle" property the MDIO nodes are looked up. In case of
> a malformed device tree the driver might produce out-of-bounds accesses.
> The PHY address is not checked against the maximum supported address.
> 
> Add a sanity check. Do not use the existing (unused) MAX_SMI_ADDR define
> but drop it in favour of PHY_MAX_ADDR.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 381c45e0597b..517b01115f34 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -78,7 +78,6 @@
>  
>  #define MAX_PORTS       28
>  #define MAX_SMI_BUSSES  4
> -#define MAX_SMI_ADDR	0x1f
>  #define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
>  
>  
> @@ -495,6 +494,9 @@ static int otto_emdio_map_ports(struct device *dev)
>  		if (err)
>  			return err;
>  
> +		if (addr >= PHY_MAX_ADDR)
> +			return dev_err_probe(dev, -EINVAL, "illegal smi address %d\n", addr);

Maybe use the existing helper: of_mdio_parse_addr(). It already has
error handling.

	Andrew

