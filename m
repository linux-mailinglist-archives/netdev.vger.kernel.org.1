Return-Path: <netdev+bounces-258866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF3pJngKk2nw1AEAu9opvQ
	(envelope-from <netdev+bounces-258866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:15:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A3143430
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863B53013A62
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799843081D6;
	Mon, 16 Feb 2026 12:15:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3082690C0;
	Mon, 16 Feb 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244147; cv=none; b=X6YyJjQOpYtoBWa50VoG5cMZrUdtl8QXOFJ5iS6iy8PR0rNCe62U7p8LSgR/cxluBIJUh9Ez0buR4emQQgWzHk1rNR9WgFnUXp7GwZQqUj6gNd0vvR8cDP/xxQJbiCs+gGPHvsG32XyfVaChY9L5JPid9XexcowSEoIzTPjkhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244147; c=relaxed/simple;
	bh=P/0XkNFt6Y7qOtSbIlMVIVDPWkCJW8egWendUV2pzoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIdLl45bGChVhWdLbNkLXT2OcKUcA3IA1Kf4rcBljR5rkzBLwDnmtvryOfcNamcuE7s0SqgW6WhFXI14fOqnXwo9Df777LdTAoF/V8Se8jJPZumJaW5zWzDwTt9lKWCPJ97QBvG9PQkwEOPSKx7mJLnj9UBvbXP7KXlbmSbFTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vrxVj-0000000006z-44Ze;
	Mon, 16 Feb 2026 12:15:32 +0000
Date: Mon, 16 Feb 2026 12:15:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Message-ID: <aZMKXavVQPelSXcG@makrotopia.org>
References: <20260216105522.2382373-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216105522.2382373-1-arnd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258866-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,roeck-us.net,arndb.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 394A3143430
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 11:55:17AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added dsa driver attempts to enable the corresponding PHY driver,
> but that one has additional dependencies that may not be available:
> 
> WARNING: unmet direct dependencies detected for MAXLINEAR_GPHY
>   Depends on [m]: NETDEVICES [=y] && PHYLIB [=y] && (HWMON [=m] || HWMON [=m]=n [=n])
>   Selected by [y]:
>   - NET_DSA_MXL862 [=y] && NETDEVICES [=y] && NET_DSA [=y]
> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_probe':
> mxl-gpy.c:(.text.gpy_probe+0x13c): undefined reference to `devm_hwmon_device_register_with_info'
> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_hwmon_read':
> mxl-gpy.c:(.text.gpy_hwmon_read+0x48): undefined reference to `polynomial_calc'

I assume this happens in case CONFIG_MAXLINEAR_GPHY=y and
CONFIG_HWMON=m, right?

None of the PHY drivers seem to adequately prevent such situations,
which in my opinion would be worth correcting, ie. by preventing any
PHY driver using HWMON from being built-in while CONFIG_HWMON=m.

> 
> There is actually no compile-time dependency, as DSA correctly uses the
> PHY abstractions. Remove the 'select' statement to reduce the complexity.
> 
> Fixes: 23794bec1cb6 ("net: dsa: add basic initial driver for MxL862xx switches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

As there is no compile-time dependency, this change is fine.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/dsa/mxl862xx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
> index 4db7bab21a71..3e772298cc89 100644
> --- a/drivers/net/dsa/mxl862xx/Kconfig
> +++ b/drivers/net/dsa/mxl862xx/Kconfig
> @@ -2,7 +2,6 @@
>  config NET_DSA_MXL862
>  	tristate "MaxLinear MxL862xx"
>  	depends on NET_DSA
> -	select MAXLINEAR_GPHY
>  	select NET_DSA_TAG_MXL_862XX
>  	help
>  	  This enables support for the MaxLinear MxL862xx switch family.
> -- 
> 2.39.5
> 

