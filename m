Return-Path: <netdev+bounces-293579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEmgGRkrHWo4WAkAu9opvQ
	(envelope-from <netdev+bounces-293579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0A61A5A5
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5585D3003832
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33E345724;
	Mon,  1 Jun 2026 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eNxET25t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3231197B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296470; cv=none; b=CNymZvys5ohjWOm9hdGf8H0fRQcS9lTqwuWbILGnlOA675TAHE7Q8U0O77s+f4QVS/ApR1b0aZPgGz4v40pFg/Ygszuo2F8CitUs2RvOIEPrvy4LcxcBqMl/6PDLxXTyvVx9YocyTujievPDujhz2Bl23r1za7TaLYARvcH70p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296470; c=relaxed/simple;
	bh=JOdm3q/EFYGOPeT0aaqQcmMMIOfVTEJc3ND/Ep4X074=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKB5m3Xzef4cEEUGxEzfI1M+E5T92cdcIE2AGuO6d0z7D5c8DZ1BxKfIxso2Id3YkKbG2cHRm1h742wLEopEHwQdefx+A6ZdkZ62DBvxyWr3OMY1sT4x9rwoD+QJE4T8QKkznfJWIkFaZo1S5WNOQQGz0+AL4lONdRfWfIDELFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eNxET25t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CB2284E42DCE;
	Mon,  1 Jun 2026 06:47:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EC37602AB;
	Mon,  1 Jun 2026 06:47:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71B3F10888CD6;
	Mon,  1 Jun 2026 08:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780296466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nGZxCB+5hN3temjBjJCyUMGMnkA6gaK68CldvQEZRVs=;
	b=eNxET25tJRTECq20VuHrHna6ghmWW9ptmC5CMHm9ZmH1N6ycq5i30LOlVVWEwDwO/g2+M2
	8pGdj0xRnZHISsBYpgc1xxQS/SCM5BaI3q6bIJsJaOvFPRuCsT0FRrTIXX77ld7wsUSZf0
	d/ycu/FuVWZIAYfbk0eOJ3GVQ3kb07bm2nAlM9wNB8rVGGcMLpc97CT9au0Ko29aAs9QTq
	BS5qjNNO0zpqtMyNJah7gDpFNDfahqKQ8eMuGGK2MV3XdEAKdi1UNIjDawBXCNDaoX9Pmd
	L9SQ4dZ7f6inIyLbEaxJ3O9gspiAv5jIC6PAR8qdRw5huafGndVFjMBM64FCkA==
Message-ID: <5cf32862-df51-4e80-8837-6fb21b53dc04@bootlin.com>
Date: Mon, 1 Jun 2026 08:47:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: clean the sfp upstream if phy probing fails
To: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260530072706.3167745-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293579-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,tipi-net.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 08A0A61A5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/30/26 09:27, Maxime Chevallier (Netdev Foundation) wrote:
> Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
> failure path, so let's add it, otherwise the sfp-bus is left with a
> dangling 'upstream' field, that may be used later on during SFP events.
> 
> This issue existed before the generic phylib sfp support, back when
> drivers were calling phy_sfp_probe themselves.
> 
> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3370eb822017..6c2ef91fd197 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3775,6 +3775,9 @@ static int phy_probe(struct device *dev)
>  	return 0;
>  
>  out:
> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +
>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);
>  
Sashiko said :

"
If sfp_bus_add_upstream() fails during phy_sfp_probe(), will this cause a
use-after-free and double free?

When sfp_bus_add_upstream() fails, it drops its own internal reference, and
phy_sfp_probe() calls sfp_bus_put(), which frees the bus.

However, phydev->sfp_bus was previously assigned to bus and is not cleared.
If phy_probe() then jumps to the out: label, calling sfp_bus_del_upstream()
will access the already freed memory and unconditionally call sfp_bus_put()
again.
"

It also pointed out the usual set of pre-existing issues...

So with this and Nicolai's comment, I'll sent a new iteration as a series with
some more cleanups.

Nicolai, I'll likely modify this current patch to address sashiko's comment, I'll
have to drop your review tag unfortunately :(

Maxime

