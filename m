Return-Path: <netdev+bounces-278786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPuMLA+c32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62A40524B
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA024300A59F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B233A5456;
	Wed, 15 Apr 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kkAcffNN"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0D379EE7
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262081; cv=none; b=SxUzEVym2iiHZX9QXqQXfcCUFhQB1Ojk+poKVVaUMYvYiAXeF8uZfYXwEt5I22o6wOP3aclnm8KCQzUjEqevPy4L/xQilS/wMpX+lDqJlI5agtG1nc7Ga7/Fos1s85tDUnqf8C1H0/LNjEABy66b8y0BQpmssuuWqN86RUN5LqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262081; c=relaxed/simple;
	bh=Fs4ebNmCBSRCtIeM3x+VpFjjj5xTJ3v3L14xv0j/0Dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=T7u3rD5+0swVBO9jUxdWK8Uh9oEA2D/wgzphMJLlyrkIIogKLPLsAMNqYDcmapeSvhPSgCyipII7Z5aOBqmNmxI7lhsM0wZVs/EIhlu/uVl40/SRBkBblgqYwHbqlvy4/aRE+VwG+AK/RVTCtZYt+2jo7BN6t5yEwhr2NxuPKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kkAcffNN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CCDEBC59F60;
	Wed, 15 Apr 2026 14:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20C0B60420;
	Wed, 15 Apr 2026 14:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C05E410451B9E;
	Wed, 15 Apr 2026 16:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776262070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oK2yz944i89PT8aKyVdZj6EXcfPBWWdS0h1p8cICzKI=;
	b=kkAcffNNoaNgw26VT6CGmEzg2VPwt5MN1jVQaMzxrRckOuSqUwa2xdLUakCwJoQRLN1FoU
	9Qf8TYKwKswy8b3SHEkkSpsshj4zts1oEH28e1ud8aKCTGXmlh7QPyNT1/7b7ONAsUfgUI
	H/tWRnqD9lMTKOAG2PUIDXiJILhBB0tIyX7QDz8INNNCr+TiKBvKko2xKhUhRYKRLFiX5i
	piNwzTVAdg+nDzuPqJxI8YwmCupJ3ecdflansC3ntmm9nyFlSX+q4gsAnH5uNN5n5KC8ax
	PbrCSN8cqHSTxM+IvP2P69RPLg2v0OnId/YVzH1KmLdQeCThMYSdrvkmhjzfWg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 16:07:48 +0200
Message-Id: <DHTSCP4FCOM4.2B6O9WMPO84YK@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 12/14] net: macb: re-read ISR inside IRQ
 handler locked section
Cc: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <pvalerio@redhat.com>, <conor@kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <benoit.monin@bootlin.com>, <tawfik.bayouk@mobileye.com>,
 <thomas.petazzoni@bootlin.com>, <maxime.chevallier@bootlin.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-12-af39f71d40b6@bootlin.com>
 <20260414005244.3758889-1-kuba@kernel.org>
In-Reply-To: <20260414005244.3758889-1-kuba@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A62A40524B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jakub's LLM,

On Tue Apr 14, 2026 at 2:52 AM CEST, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: macb: re-read ISR inside IRQ handler locked section
>
> This commit adds a second read of the ISR register inside the lock in
> macb_interrupt() to handle a race condition where the status might have
> been updated by concurrent hardware resets.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 2633234012bae..3deab87c565b5 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -2190,6 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void *=
dev_id)
>> =20
>>  	spin_lock(&bp->lock);
>> =20
>> +	/* `status` stack variable might be stalled =3D> re-read it */
>> +	status =3D queue_readl(queue, ISR);
>
> Will this second read discard interrupt events on older MACB variants tha=
t
> use clear-on-read for the ISR?
>
> If the hardware does not have the MACB_CAPS_ISR_CLEAR_ON_WRITE capability=
,
> the first queue_readl call before the lock already cleared the active bit=
s.
>
> Overwriting the local status variable here sets it to 0, which permanentl=
y
> drops the initially captured Rx/Tx completions and stalls the network
> interface.

The AI is correct. For R1C, we must check ISR inside the bp->lock
critical section. For W1C, we can check it outside to detect spurious
interrupt without grabbing bp->lock and then we check again in bp->lock.

So:

static irqreturn_t macb_interrupt(int irq, void *dev_id)
{
	// ...

	/* detect spurious interrupts without grabbing bp->lock */
	if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE) {
		status =3D queue_readl(queue, ISR);
		if (unlikely(!status))
			return IRQ_NONE;
	}

	spin_lock(&bp->lock);

	status =3D queue_readl(queue, ISR);
	if (unlikely(!status)) {
		spin_unlock(&bp->lock);
		return IRQ_NONE;
	}

	// ...
}

Or we could drop the readl(ISR) from outside bp->lock.

>> +	if (unlikely(!status)) {
>> +		spin_unlock(&bp->lock);
>> +		return IRQ_NONE;
>
> If the function reaches this point, the initial status read before the lo=
ck
> was non-zero, meaning the device legitimately asserted the interrupt.
>
> If a concurrent operation cleared the hardware state while this thread
> waited for the lock, will returning IRQ_NONE falsely flag this as a
> spurious interrupt?
>
> Since the interrupt was actually raised by the device, doing this repeate=
dly
> can cause the core IRQ subsystem to permanently disable the IRQ line.
>
> Could this return IRQ_HANDLED instead?

Disagreed on this one. This codepath, if it happens, is expected to be
infrequent and to protect against races by the swap operation disabling
the device. There is no chance we often land here and end up disabling
the IRQ line.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


