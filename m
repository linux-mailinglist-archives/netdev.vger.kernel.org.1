Return-Path: <netdev+bounces-301405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0hSKAyzOmoJEQgAu9opvQ
	(envelope-from <netdev+bounces-301405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:23:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087B6B8B2F
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=YE5a2DeG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301405-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EAE3074666
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467F311968;
	Tue, 23 Jun 2026 16:23:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50C306757
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:23:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231795; cv=none; b=JiY/fm6oB62OkIqDHrM2zC/MJe8LmLEiku6FTYzvB+B2QRYvbqWEv4VlKECSgR9EbPUT64qJb3aqZCuD3afkA68Ix949rnNG3Jn2H7Rr/+2+m0rNcUu7PJYxkyYcHj1U4ul/epKL60HlN5NoVF5MfoPFj1BL81mRJppAbNOwi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231795; c=relaxed/simple;
	bh=vpm2sYXVp2f19p7aRTZC+CwjaVK2aPR511GU9AtxiTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS0cuxqZeX5urSIahQ655zJRU3l232OkXRFDSNHJ870vUAPyZ6nVt8RJs8deOzefI316DN8JY01Y+Fp6gClszevnWHrXEl+rtVVUJMFXGlV85/sYbwA7gr8WCdPtWY31kCtWAqYDdUBg3x9sHdk/PBeMiXlXoBqG8eG5D0oT9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YE5a2DeG; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9B2221A08AE;
	Tue, 23 Jun 2026 16:23:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57704601C2;
	Tue, 23 Jun 2026 16:23:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E7DC106C841A;
	Tue, 23 Jun 2026 18:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782231788; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/9CbdAPN/4V+FSMLtSl5yulm65CsF7yRuepdwDsnG3I=;
	b=YE5a2DeGmMl4nhclGldtGgDPhgjcVG06bQ67THBJgVOCnGHBEb/G7C1pXG0iHvf1ZJQcQY
	b4k4eQ5Km9bP3HTv74szkqqfJD7c5Weq6CnltVyxIV4/WAplF/7YowNGJZA1NYiQCIsP7x
	KtstEYRrDJ23nwq5f3E9yHdDNbWBTHIZCVPagjuvrs9VHChsiECSU642Csf8I/ui6JAQlQ
	v0oNJsl9Fq6q2cIi44cqMfNJvX733/ebA2aVAJDDMfgsmGd+wKRaujWcycg2r1IWBy3oSI
	t3UToQRIxF9wTQ0RiiO101u3NUFMhZXDacI1FcvqwERrPNv9PatCuzxqg0JMJg==
Message-ID: <376a850a-dabe-421a-b227-9b612056583f@bootlin.com>
Date: Tue, 23 Jun 2026 18:23:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: phy: sfp: free mii_bus in
 sfp_i2c_mdiobus_destroy
To: Petr Wozniak <petr.wozniak@gmail.com>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, bjorn@mork.no, olek2@wp.pl, kabel@kernel.org
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
 <20260623080538.7646-2-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260623080538.7646-2-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1087B6B8B2F



On 6/23/26 10:05, Petr Wozniak wrote:
> sfp_i2c_mdiobus_create() allocates the I2C MDIO bus with mdio_i2c_alloc(),
> a plain (non-devm) allocation, and registers it. sfp_i2c_mdiobus_destroy()
> only unregisters the bus and clears sfp->i2c_mii without calling
> mdiobus_free(). As the only reference to the bus is then cleared, the
> struct mii_bus is leaked.
> 
> This is hit whenever a copper/RollBall SFP module that instantiated an MDIO
> bus is removed: sfp_sm_main() takes the global teardown path and calls
> sfp_i2c_mdiobus_destroy(). sfp_cleanup(), on driver unbind, frees
> sfp->i2c_mii directly, which is why the leak only triggered on module
> hot-removal and not on unbind.

which is worse, this can happen many times in a row :)

> 
> Free the bus in sfp_i2c_mdiobus_destroy() to match the allocation done in
> sfp_i2c_mdiobus_create().
> 
> Fixes: e85b1347ace6 ("net: sfp: create/destroy I2C mdiobus before PHY probe/after PHY release")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>

With this patch sent towards the -net tree,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/sfp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 03bfd8640db9..c4d274ab651e 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -963,6 +963,7 @@ static int sfp_i2c_mdiobus_create(struct sfp *sfp)
>  static void sfp_i2c_mdiobus_destroy(struct sfp *sfp)
>  {
>  	mdiobus_unregister(sfp->i2c_mii);
> +	mdiobus_free(sfp->i2c_mii);
>  	sfp->i2c_mii = NULL;
>  }
>  


