Return-Path: <netdev+bounces-293642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNZ0FydSHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAE61C85E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E083A3008285
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794038E8AB;
	Mon,  1 Jun 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="E/RDE4DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF77223DCE;
	Mon,  1 Jun 2026 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306302; cv=none; b=TqQb6rBS6UpF5YLVELPhg2g94TumA3VN6JQQwVTNdHCzmMGvxllCx+c1+e3Kawu7nKDqwOrGKPaSgmz68VU9NtJuZV20IGP/CpgPNbMDG8i7RuuVqsyoX5vkhOuyWo134+zmRSaTGkB6SlKJOkPT4T3Li1hpKxeEdX/iIM7UGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306302; c=relaxed/simple;
	bh=Q1Spfa7XTwaRrUROrJWo2/Yz8MnZACrzNSeVA4MSuCw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OWFAn72Ucr9rWkpHV8Lf0MstIBaYZcoof5i0VIr1Mo+Poo2wMoDdWZxOE+/fhsfF6tP9fmI+j7/dc4VzjhqEmJAPXH9LV2oUCfP0cvQ6mtvj9H0b8Gm1fNjoVBYcaUndAwGQq44WCDdhdj1nq7TLobrvfiGfWFnk7oDMz9SWSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=E/RDE4DQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F86AA4BF7;
	Mon,  1 Jun 2026 11:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780306295; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hcHasTy/GEKNYjpzFRPcXZ9lQ+13TQzVfxr1PSWVejE=;
	b=E/RDE4DQX1brevBixC7/SBOPvlP3Uv4Rf7LDFb5Z9jS+JUF8W0ckyJWLsk9OSwUiYTBHWc
	qHikpHjvKUnivt9Rhgk7O9Q5TtLLvkXAbDAGBvnLp6w5JpuLt396reRDuq9FyMK1una+qZ
	nwxRiPG5epVTXczPrHRE6tNH+Ic8VdN0wfQuRC7F03qPqiS2oowHUbxnxXC1r2Q5m0Thvn
	PuMJE1kTALyhs5TOn0RpwEDY+GwSrHdElxKU3CCFPh3S9fluNfXgo1z3Dc11dqYS4gkTDj
	hzgTpSzeJYAE+hNADxVU0BWb0w9LiCUUsGJyWyJk1lZJ7MhzDxZKEo3zsmEfKw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 11:31:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 1/3] net: phy: clean the sfp upstream if phy
 probing fails
In-Reply-To: <20260601084029.815461-2-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
 <20260601084029.815461-2-maxime.chevallier@bootlin.com>
Message-ID: <584458cf6c80f6b0143e80e36018e921@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C6CAE61C85E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.6.2026 10:40, Maxime Chevallier wrote:
> Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
> failure path, so let's add it, otherwise the sfp-bus is left with a
> dangling 'upstream' field, that may be used later on during SFP events.
> 
> This issue existed before the generic phylib sfp support, back when
> drivers were calling phy_sfp_probe themselves.
> 
> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2: Null-ify phydev->sfp_bus upon sfp_bus_add_upstream failure
> 
>  drivers/net/phy/phy_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c 
> b/drivers/net/phy/phy_device.c
> index 3370eb822017..6ccbfacf7d1d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1718,6 +1718,9 @@ static int phy_sfp_probe(struct phy_device 
> *phydev)
> 
>  		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
>  		sfp_bus_put(bus);
> +
> +		if (ret)
> +			phydev->sfp_bus = NULL;
>  	}
> 
>  	if (!ret && phydev->sfp_bus)
> @@ -3775,6 +3778,9 @@ static int phy_probe(struct device *dev)
>  	return 0;
> 
>  out:
> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +
>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

