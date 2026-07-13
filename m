Return-Path: <netdev+bounces-307231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id faCpOWoAVWrZigAAu9opvQ
	(envelope-from <netdev+bounces-307231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:12:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961774CDD5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=BAdeQwP9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307231-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307231-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF093150D67
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873F3DDDDD;
	Mon, 13 Jul 2026 15:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F133A033
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 15:04:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955094; cv=none; b=t2ip/zeNdIR0sIxWnK3YB0LZMxcdHYSKA1xCPCkNmaVqHMWJSZG0FWALLV/tknab8mcq09/66388BAQZ798+zSr0lpf4MpayT43FawVkD6kB+V9frpyLh0G41MLv61ABOuc1PK+s1kuPNKEPrR8G13neplVk1sg68cO08N5Ab3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955094; c=relaxed/simple;
	bh=aZsghplprXQkanjC/2ViaOIi2RUUIO+lCIWfWBh7wtY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=k0Lz2oihP3E5uFAxisjwK4fySO9mH7duTsUAx5Kb4iCd8pqIzy8PVDzc9KI3VrW2BssyWE2lh+CKtVpQvv7Qn0NlzX122bXXaK9hP5ted4hnq2qkLgb23uiInYVEQqTG37eyxOH1Gm0S4JeskhAfISUGEcv4aMOrM9S2OjOS2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BAdeQwP9; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 38D011A0FA0;
	Mon, 13 Jul 2026 15:04:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0980360345;
	Mon, 13 Jul 2026 15:04:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D6A511BD3A4E;
	Mon, 13 Jul 2026 17:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783955088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CmJzIfsuUG4qmBib+pba3w+zKMKmXhM7aYF0ATHO3+U=;
	b=BAdeQwP91W5eXZExZD46BqTCXvuoF0hhXB7ln5oAzT9igHxeBKTSvQufG0MyExrWVjNPgv
	UPsYi+TXVLilTFNQPEdcJJDxt9UuvwY4vGNXlzz434KZYBrhBV/4NkTTm6b/y6RBBB4Lzn
	YziC9bfLYcVmZ/Nr5oc+aoHaAVaUGQ28EII9LArXOtV+6BjlzQurD7As8IAi5nDLX4QWCz
	+Tf0DiOdAI7KEjrbtNzsju+X81IQE1hIkQ7/wQMWIejon8TNyQT/fX8UMCfyG3spzl/IL8
	wGDPmtk7xnakfDdpNU1tyNjvn2d1WIrGw7otqEJsboaBBBUswIR9lTgcdTs6Zg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:04:42 +0200
Message-Id: <DJXJAR4XVB70.1NT2W8SA233GF@bootlin.com>
Subject: Re: [PATCH net-next v3 13/15] net: macb: re-read ISR inside IRQ
 handler locked section
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-13-00268d5b1502@bootlin.com>
 <20260703-faction-system-20af97e12412@spud>
In-Reply-To: <20260703-faction-system-20af97e12412@spud>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307231-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4961774CDD5

Hello Conor,

On Fri Jul 3, 2026 at 2:09 PM CEST, Conor Dooley wrote:
> Hey,
>
> I'll admit to being a bit confused by this patch..
>
> On Wed, Jul 01, 2026 at 05:59:16PM +0200, Th=C3=A9o Lebrun wrote:
>> The IRQ handler reads ISR register into the `status` stack variable.
>> If empty, it early returns. Else, it grabs bp->lock and iterates on
>> the status bits.
>>=20
>> If we tried grabbing bp->lock while already acquired, we might have
>> slept and the status might have been updated. Our most likely
>
> This mention of sleeping I think should be removed, it implies sleeping
> is required for the status to be updated.

Yes "slept" wasn't the right word, "waiting" would have been more
appropriate. Or it could be a race even if bp->lock acquired
immediately.

>> competitor in this race (condition) is a swap operation, used in
>> change_mtu and set_ringparam. It is the only MACB codepath that resets
>> interrupts and HW inside a bp->lock critical section. Other codepaths
>> that clear HW IRQ status do so outside the bp->lock critical section.
>
> Where do change_mtu and set_ringparam take the bp lock?
> As far as I can see, they don't. The commit message should reflect how
> the code behaves at the time of the patch, not at some point in the
> future after it.

You are correct: this commit doesn't see change_mtu/set_ringparam take
bp->lock. It only will happen in the future. Will fix.

>
>> We can only detect spurious interrupts before grabbing bp->lock if
>> MACB_CAPS_ISR_CLEAR_ON_WRITE. If we don't, then we only read ISR once.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 7245c345c78f..5a32d5cb759e 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2184,13 +2184,21 @@ static irqreturn_t macb_interrupt(int irq, void =
*dev_id)
>>  	struct net_device *netdev =3D bp->netdev;
>>  	u32 status;
>> =20
>> -	status =3D queue_readl(queue, ISR);
>> -
>> -	if (unlikely(!status))
>> -		return IRQ_NONE;
>> +	/* detect spurious interrupts without grabbing bp->lock */
>> +	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE) {
>> +		status =3D queue_readl(queue, ISR);
>> +		if (unlikely(!status))
>> +			return IRQ_NONE;
>> +	}
>
> To be honest, this check feels like penalising the likely^2 case* with an
> extra read favour of the unlikely case where there's contention on the
> lock and the contending function is capable of affecting the status
> register. Could we get away with just the single check of the register
> with the lock taken?

I agree!

> * although I don't know what percentage of hardware supports this cap,
> so maybe most devices will never run this code

I expect all modern(TM) MACB blocks to be write-to-clear, at least
that's what I heard but I don't remember from where.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


