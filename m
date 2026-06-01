Return-Path: <netdev+bounces-293646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIksNDBSHWpfYwkAu9opvQ
	(envelope-from <netdev+bounces-293646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22261C86D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 721003010837
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6373911B6;
	Mon,  1 Jun 2026 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ag/zJ4no"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B2390C90;
	Mon,  1 Jun 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306329; cv=none; b=Zc6uPGO8K915pk5W2vUL6HULnjonLoRfIXbaA+ZiJzsZMgUCd0E2N27zSm1b6bFzss3FDs8IIaSlQm3fDgZqWFObXAiD1kcNB0yb46plpz8DEPO9c0yA6jaX0ej1nsaUJ1hus7GxV0cCueTiEKFusFnSZJmGa5bOruLL8HJkIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306329; c=relaxed/simple;
	bh=LqTRlHOp0YHQMBHFAbPqweqf7FuVo4edHss2+mASmZc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LlYZo/vFFIy9QkX7gFWjhMclhtR+e7JUkQTEZBH1m4KdLrkkyiuLgsfDP70qxMEklEdnABAGkFsFP5qYFck/N6uUFPo+kArh9VdBMChYFui+/cq/wx/EWSJIlz5w5uscB9/KfN8cYF+fB7DDPKAZvdDSzD6uMucH/eHVkkoM1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ag/zJ4no; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D289DA01FB;
	Mon,  1 Jun 2026 11:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780306326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p7m2ZvTWTpUZsSq2QqocuRSjvRDnNfWr7agiHb4ZjBI=;
	b=ag/zJ4nogUjrZK2L8q75HmD8aaNXznIk/rxYhiKIKB9IQ9KyiydYqi8gw470gMedsn7gAi
	F6ZniM/Rjpj0fbRwxaDwyPRuXlhvzGiVXAT16z+n+bFqPDt+P/7k0R+5jZ/zHH4VmJab+n
	3gixl8E090c5PcY5LlALb+HXicBnnbZF/w1dxSIoZcErvcx+vq6awhFvpy+fhtH4+OcwUb
	pkFfoINQO68bsVyS2vG7zpcbS3HhuTVTg0i/nSfO4UGmfPyteO9g5HBbRY30NPOSLrOXUJ
	K6u9T6KmtqvDDo/wc3Lyqhe2oFpvIszqz5H8yhsiV0e4e8bBoVghD1KT/MIMwg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 11:32:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 3/3] net: phy: don't try to setup PHY-driven SFP
 cages when using genphy
In-Reply-To: <20260601084029.815461-4-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
 <20260601084029.815461-4-maxime.chevallier@bootlin.com>
Message-ID: <090d7e9be921e62b94812785d1d8f54c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293646-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: DA22261C86D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.6.2026 10:40, Maxime Chevallier wrote:
> We don't have support for PHY-driver SFP cages with the genphy code.
> 
> On top of that, it was found by sashiko that running
> sfp_bus_add_upstream() for genphy deadlocks, as for genphy the PHY
> probing runs under RTNL, which isn't the case for non-genphy drivers.
> 
> This problem was reproduced, and does lead to a deadlock on RTNL.
> 
> Before the blamed commit, the phy_sfp_probe() call was made by
> individual PHY drivers, so there was no way to get to the SFP probing
> path when using genphy.
> 
> Let's therefore only run phy_sfp_probe when not using genphy.
> 
> Fixes: bad869b5e41a ("net: phy: Only rely on phy_port for PHY-driven 
> SFP")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_device.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c 
> b/drivers/net/phy/phy_device.c
> index a171cbe2a74a..8eace58e9f12 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3512,9 +3512,14 @@ static int phy_setup_ports(struct phy_device 
> *phydev)
>  	if (ret)
>  		return ret;
> 
> -	ret = phy_sfp_probe(phydev);
> -	if (ret)
> -		goto out;
> +	/* We don't support SFP with genphy drivers. Also, genphy driver 
> binding
> +	 * occurs with RTNL help, wich will deadlock the 
> sfp_bus_add_upstream().
> +	 */
> +	if (!phydev->is_genphy_driven) {
> +		ret = phy_sfp_probe(phydev);
> +		if (ret)
> +			goto out;
> +	}
> 
>  	if (phydev->n_ports < phydev->max_n_ports) {
>  		ret = phy_default_setup_single_port(phydev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

