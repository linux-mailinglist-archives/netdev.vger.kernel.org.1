Return-Path: <netdev+bounces-261361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBTcCS5SoGnriAQAu9opvQ
	(envelope-from <netdev+bounces-261361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:01:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EE1A7216
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E396A30091C6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953739281D;
	Thu, 26 Feb 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l51pMmQ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AC396D2A
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113854; cv=none; b=R2PaLuIKcUHvBbzZdGzeD1sPKT+pNib7i2WcR+J2nEJymFbhSnkbbYgePp7mtZrI7c50R3B+Vz6GrZ7PlfwR9D/3nXJYCrw/iK6zlrdQE1aktu1KcfgYTprWVFC4ErxozKpBS7DIgndLFnZRNNtTJwRoZCSk2xDYa7+jy7vgB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113854; c=relaxed/simple;
	bh=i+zKmv4+udtvX0YbwvhHEiInOnygCFtEHB1xWsh0uOI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=HRjXQbpsAsoRhI9B/SKtOshNHaTS+GNN5ANalCgStwJgZywWnEjkX8hhHT4vugZT9tb6/2ndYbwv3V8XvzB3qIpAF12aUqeqpl0jXarTpozYU1H/p7DcPtvL5eUdnrnPHlBkTbu2Dkn9foy8qSVLpKvddBEDldDgXFPtwRhbjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l51pMmQ5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5B3571A13C0;
	Thu, 26 Feb 2026 13:50:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F7255FDEB;
	Thu, 26 Feb 2026 13:50:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA75710369396;
	Thu, 26 Feb 2026 14:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772113848; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vBPYWM3CgWmXUFYnjZ/i8OQXAAzoWlYYQ37qGqGJOSA=;
	b=l51pMmQ5QkOQTAGUwL58WWp1b77/xaGzi6KcC39biDfQRqjtwzaJhHqQAtzxTAAnkDut5W
	OmpiZC/kUaY/iLE25WaIuQIxgyM9ApfOsrKCI7D8EqAJbdfNoW1KDnJdnzQVf+AVZUegEs
	HDfloH/zd2VEfB+IzovpHf6nhNT4H9aStMbkmmq90SMRhzBE5kcXaMquCMhSsSteWqRUO4
	YOQyYQ/ul6lIgJBxLBv+Oo/teRHglJdnZP2moWlpGmEeSq3Phh3opQaWLpR009c3WSX0/Y
	4VKAiMFBDVOHAMYEUofehWV+4yU7yUODHMKh/eSqWM5kRvjI2vJrjhXuG6zGMQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 14:50:42 +0100
Message-Id: <DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <nicolas.ferre@microchip.com>, <pabeni@redhat.com>,
 <phil@raspberrypi.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
 <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
 <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
 <342fd96e9f9668392705496e54d93eff@tipi-net.de>
In-Reply-To: <342fd96e9f9668392705496e54d93eff@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261361-lists,netdev=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[bootlin.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:url,bootlin.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC3EE1A7216
X-Rspamd-Action: no action

On Thu Feb 26, 2026 at 11:49 AM CET, Nicolai Buchwitz wrote:
> On 26.2.2026 10:52, Th=C3=A9o Lebrun wrote:
>> On Wed Feb 25, 2026 at 6:50 PM CET, Russell King (Oracle) wrote:
>>> On Wed, Feb 25, 2026 at 06:42:08PM +0100, Th=C3=A9o Lebrun wrote:
>>>> On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
>>>> > @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_b=
uff *skb, struct net_device *dev)
>>>> >  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>>>> >  			     skb->len);
>>>> >
>>>> > +	macb_tx_lpi_wake(bp);
>>>>=20
>>>> Should this be protected by a bp->eee_active condition? It could go
>>>> in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for most
>>>> platforms. Probably negligeable though.
>>>=20
>>> It will read the register, find the bit clear, and then return if
>>> EEE is already disabled.
>>=20
>> Yes I agree with your sentence, sorry my point was unclear. I was not
>> describing a bug but rather a performance optimisation.
>>=20
>> We would look up bp->eee_active to know if we can avoid calling
>> macb_tx_lpi_set(), to avoid grabbing bp->lock once per xmit.
>> That spinlock is interface-wide.
>
> So you're suggesting to revert to the v2 approach?
> https://patchwork.kernel.org/project/netdevbpf/patch/20260224091821.47671=
-4-nb@tipi-net.de/

I discovered this series at its V3.
It seems like I was suggesting a mix of both V2 & V3 approaches.

// V2 was:
static void macb_tx_lpi_wake(struct macb *bp)
{
	if (!bp->eee_active)
		return;

	macb_tx_lpi_set(bp, false);
	cancel_delayed_work(&bp->tx_lpi_work);
	udelay(50);
}

// V3 & V3 are:
static void macb_tx_lpi_wake(struct macb *bp)
{
	if (!macb_tx_lpi_set(bp, false))
		return;

	cancel_delayed_work(&bp->tx_lpi_work);
	udelay(50);
}

// I was suggesting:
static void macb_tx_lpi_wake(struct macb *bp)
{
	if (!eee_active || !macb_tx_lpi_set(bp, false))
		return;

	cancel_delayed_work(&bp->tx_lpi_work);
	udelay(50);
}

But talking about perf, let's measure.

I don't get any measurable performance improvement on average/max time
spent in macb_start_xmit() between net-next and this series. We spend
<3=C2=B5s per call anyway. 10s iperf3 1G TCP test on EyeQ5, ftrace function
graph tracer on macb_start_xmit().

Summary: you can ignore my remark.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


