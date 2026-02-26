Return-Path: <netdev+bounces-261265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C8yLtMYoGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:56:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E51A3D33
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A050C300B9D6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330B39A808;
	Thu, 26 Feb 2026 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xyjm4n7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA439E6D4
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099577; cv=none; b=l8a+IyFksr1p24y+UGNrSmLqp87llcrjAHgWrjP97H49LaaRf75rlvC86ZjZNBg5jzN9Gei5RIMPG7vXm35HTzmszeQdQILPe2rM42nqQldkmWMmSAUw5JFPYrxERI6isj0fd0nHo/8T9AQE76evZRdrFVFRnoDM0ohLFWy3oHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099577; c=relaxed/simple;
	bh=wms4zwUlt60cKabYAexMSmMsofSAX2pQWVavtfP6PjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=EfSsonLP4lS2jGq8RoiEEvwOeXOHazBVwYcC3ULnRaqfGFAUugdW8loxkvSizW73Cu59as+7NFBcdwtNWeAw0Q/0MCrqjoUVffKdY1mun2/36MrrApGaGtrvMf0gb4Cv1EToNJCeV0PS/NJ/KfcQXMmSdfMBAq/ssViwhUuzcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xyjm4n7w; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 91DE6C4068C;
	Thu, 26 Feb 2026 09:53:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24B8B5FDEB;
	Thu, 26 Feb 2026 09:52:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C738E10368F27;
	Thu, 26 Feb 2026 10:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772099569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Xus6MOJ+oi7USRzVb/6SHbLGtOywY7U0TUi1kiD6sI=;
	b=xyjm4n7wPGRbkxujVJQ27q/YzOvwxcQM+808jqfR2wyAplaiFSZlfYuQqX4IOEuWO8UhjZ
	HF4BMFobDyGeCo7vl7+AEcfIrryfh/wyJ9dJzPszSoqCznsodQKjIu3rNsrPC+8n1ba4yx
	Amzjgi+ko88J0kHXWTmbMYcRblRkp00DLyWcqku95GhGJ4Y9/0zicmayl44OI2jx3IoSVt
	AKeTDHPdKczBAJ7d1ODdQRdRNGwCZ6YB9IQFCZMhAf6fdgQIQRqdpHCXoAOdiDYvrKPTSL
	luu6oKcvbfYrZCaGk5xtkafF0qQYKR6H+Fogq6laskufyMQl/BI5acMirjPSmw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 10:52:42 +0100
Message-Id: <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
Cc: "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <nicolas.ferre@microchip.com>,
 <pabeni@redhat.com>, <phil@raspberrypi.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
 <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
In-Reply-To: <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.959];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 397E51A3D33
X-Rspamd-Action: no action

On Wed Feb 25, 2026 at 6:50 PM CET, Russell King (Oracle) wrote:
> On Wed, Feb 25, 2026 at 06:42:08PM +0100, Th=C3=A9o Lebrun wrote:
>> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
>> > @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buf=
f *skb, struct net_device *dev)
>> >  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>> >  			     skb->len);
>> > =20
>> > +	macb_tx_lpi_wake(bp);
>>=20
>> Should this be protected by a bp->eee_active condition? It could go
>> in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for most
>> platforms. Probably negligeable though.
>
> It will read the register, find the bit clear, and then return if
> EEE is already disabled.

Yes I agree with your sentence, sorry my point was unclear. I was not
describing a bug but rather a performance optimisation.

We would look up bp->eee_active to know if we can avoid calling
macb_tx_lpi_set(), to avoid grabbing bp->lock once per xmit.
That spinlock is interface-wide.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

