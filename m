Return-Path: <netdev+bounces-268691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLZaF/iJuWmTJAIAu9opvQ
	(envelope-from <netdev+bounces-268691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5022AEED1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AABC304C68B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824503F7A9C;
	Tue, 17 Mar 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zgkUraPI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA43F7A8F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766813; cv=none; b=Boo5GLjaISeBZ7ceZrLOPQ43pgBCSNo3yxTOv/Du6g0uPaBtODhDdkegrcrw95GagH170l9hTVOmy1SSdD4iQsvhRcmBF74GBEpFoVJaRrslpM3b3qdUFCGkGIz7hzMiViJMTWcf1isXjnJyR5JDhnJ1cU4gm4UNNdMVugEknRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766813; c=relaxed/simple;
	bh=WQT6jmFJA3uviEhLH0taXdSjw3tw3CiMJ4lq4IwfOSw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gQ3skouXCXVst+IG6zSGDT5Ae9wG9XnnW5Vgg3VYnpIjZkjMezaW/N0AupYiDUJS4QVRxk5nWSaNGizOOcnmJjBByEy2MEjeWsYAMTgrLZt8SnMMD4WoUmdcgIMFPULsi5qegd2x6MFLwIafDXg29aliNE0UIKPRzE7zcuzhhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zgkUraPI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 217734E426D5;
	Tue, 17 Mar 2026 17:00:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBF665FC9A;
	Tue, 17 Mar 2026 17:00:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC69210450658;
	Tue, 17 Mar 2026 18:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773766806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aVsqQXYEuompi+Eq42HRdMHs1O3eSLydd+9BCe07Dng=;
	b=zgkUraPI3K7/Oqa5UhvofPyTb2Fbm6sgWNSdCt6+sZahUc3tVvP5mTvXdUiKd7edMG5y/y
	vZv3un2PPSUiClHiBlucIk3XFq+tnzDAOpBQZeM9Od8HT54UskLJGFKCqX+K2IXDXVNNuV
	7xubiho7wugAxelq/i8xS4SafMs4/gYzn2S1PUsBMCaHb6JmYWokDJ1/VPJYPHXn5H81fF
	wC1dKrMH4HTMUM2N8Ud+1jJqI0peXwN7JszVpoDmN9de93PPXRlfIGFNa8LFX1dRSKhRjm
	5E5OS9Bf1Ok/fwVmk7MVwqUIzPeGpsU4V/avAqHInrRyyvXY7tvUt42WOL9Kdg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 18:00:02 +0100
Message-Id: <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, <nicolas.ferre@microchip.com>,
 <claudiu.beznea@tuxon.dev>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260316092720.39198-1-nb@tipi-net.de>
In-Reply-To: <20260316092720.39198-1-nb@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268691-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:email,bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 1E5022AEED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Nicolai,

On Mon Mar 16, 2026 at 10:27 AM CET, Nicolai Buchwitz wrote:
> macb_change_mtu() currently returns -EBUSY if the interface is running,
> requiring users to bring the interface down before changing the MTU. This
> is unnecessarily restrictive.

One valid reasoning for making the operation return -EBUSY is that
macb_close() will lead to packet loss for a few seconds. Users might
not expect an MTU change to trigger that. -EBUSY means user (be it
human or software) becomes aware and has time for a second thought.

But clearly, it becomes annoying as the user in the long run, when you
own your platform and know the implications.

> Instead, close and reopen the interface around the MTU change so that RX
> DMA buffers are reallocated for the new MTU. This is the same approach
> used by many other network drivers (e.g. igb, tg3, stmmac).
>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 5e27e0e87a55..8dd01031250d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
> =20
>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>  {
> -	if (netif_running(dev))
> -		return -EBUSY;
> +	bool was_running =3D netif_running(dev);
> +
> +	if (was_running)
> +		macb_close(dev);
> =20
>  	WRITE_ONCE(dev->mtu, new_mtu);
> =20
> +	if (was_running)
> +		return macb_open(dev);
> +
>  	return 0;
>  }

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> # on eyeq5-epm

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


