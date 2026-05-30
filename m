Return-Path: <netdev+bounces-293347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L9ZCjPZGmqE9QgAu9opvQ
	(envelope-from <netdev+bounces-293347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 14:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757B60CD45
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D0E83028665
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD239478D;
	Sat, 30 May 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0ci+IJtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65F35202D;
	Sat, 30 May 2026 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780144432; cv=none; b=WJtuVh/lroRYaB7cwmg/ZVh8w1yUPYpzAUg2tEn4Fb0+QclO9Nqe0BGAmq0OJRE6jDPZKE04oOeCgl2ME6L77tPqvWIsm4T9y2nqcypoZHnvc/sEaGfn5kasfgTcTJvUIRiB/1W169RnWlBISx9HDk2cX6YUvAMOvnvv4CJBPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780144432; c=relaxed/simple;
	bh=FVzu+jOauDq6f5xbyxt3UGZcyypS3GCv2v5kSRdGvnY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Mek75c1y0KvaNxCWJQw+2NCTUE6Hc8CjD5swZkhqqXGn9qiZxon6ZwwSIBw6cSxxTkc1dlkuSfz2jTZ20A9h2ZwftJbdQ9rmjZKQ7aRYddMWTN4JJvy+fOuxNWEunNTTSsRs6dFTvWA9Zdq9QODzEWYd8cQ3HsUku5SLIg1kK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0ci+IJtU; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34994A08DA;
	Sat, 30 May 2026 14:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780144419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P7PESjsUf1EFCTeforqehft+BJJDknN1xZrEHuBl+1A=;
	b=0ci+IJtUf2Qy4E2Afy4mp6gUkA6zSnDiEsw/XtavbE/a0b41QoxXzi00FeT5K4FeatFRQF
	gQSK2pzJ6hCOcNSMqrECLCqPL4nPXUalPRZYNCeEd/pkYDW2xnMVUK7SodwCWBTOuHQNid
	XCaAMeABje6c77u/Tt5QDYEajMPSlm59whBjkp0HbbBSgRPXCLuHfSsm1F0UQd29q7Bvxr
	7kPsw91yDUPrVptq6reea8+kjL+4AKHfgBq5bUK3dQ9TR5YYhj7cMJ7o/plI7lVDSaFZ8g
	hYNvLzdC14ejtNnJWbH4q1IrgPPSrNTMYkU/WaTKsHsXQ4HPPfNLwSNWuyHtTw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 May 2026 14:33:35 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net] net: phy: clean the sfp upstream if phy probing fails
In-Reply-To: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
References: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
Message-ID: <e7237bce1d68920b054da56abddf94ef@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9757B60CD45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Maxime

On 30.5.2026 09:27, Maxime Chevallier (Netdev Foundation) wrote:
> Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
> failure path, so let's add it, otherwise the sfp-bus is left with a
> dangling 'upstream' field, that may be used later on during SFP events.
> 
> This issue existed before the generic phylib sfp support, back when
> drivers were calling phy_sfp_probe themselves.
> 
> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
> Signed-off-by: Maxime Chevallier (Netdev Foundation) 
> <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c 
> b/drivers/net/phy/phy_device.c
> index 3370eb822017..6c2ef91fd197 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3775,6 +3775,9 @@ static int phy_probe(struct device *dev)
>  	return 0;
> 
>  out:

While at it, should phy_cleanup_ports() also be added? Failure 
of_phy_leds() or
genphy_c45_read_eee_adv() would IMHO also produce a leak.

> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +
>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai

