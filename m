Return-Path: <netdev+bounces-278785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4aADMGea32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:02:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A7405184
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 567413009CCD
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A43CEBBD;
	Wed, 15 Apr 2026 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JwHIk7+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE93CF66C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261531; cv=none; b=oZfCrSp3WPCJNDDokU8l7Kwyi2J1X27Z+0S2kb1iZ+D+WCraN21Ws4xJ1hcU1xRqstQxq6NXbT8jZlB1yPWa5WlBzLiY8QrjyG1W4HCE+y53td5rc4ki6ZnLm6OPN//pwwyjI2gltOEcbgGwa3du++EPXKZ67R2kcPhZZNuW+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261531; c=relaxed/simple;
	bh=KVm/tY6w+kdunUTwYx4U3wsMo7hGZxtExa/KLaQ8Wy4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=N6ty/IQeklhpj7ZkdTFj4W0zwYJhgiHwEvKOtUsUBi8Wz5Gh+YnvG5HSrZsvFhmybpd9gfWRSWOwraJ/FSjktOBC/ALOh7xS+4iT9/L0tLSGwG1kVuU2bd/VKKbvdH4MbGoHxYur7kqPvNIwsw0Y45Ar2Kf17dxptD0POHAXheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JwHIk7+i; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 52AC01A32AF;
	Wed, 15 Apr 2026 13:58:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FE5260420;
	Wed, 15 Apr 2026 13:58:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA56610451B91;
	Wed, 15 Apr 2026 15:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776261526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HcMqybTHU4A+1EvWFs8Urw2JMl9qnbaqkhl2nSKP1eo=;
	b=JwHIk7+iZvW41zELSnd+KWdw/2oqDrjnzPzebytKbS0L25EAXY2w3t3x4dvvYrF4u6Odhk
	DD+9v6htXT5ptk7v1lcVKXgJiaVcsExfPgyOvjxEWj0c4b4SCLQkbQ3pLq3C1raWAGpc3o
	lMsF20nBTh9CbJnjFxt8nWpO4rFjzo8RJcSrvuYlUdyQ1Va3WCRIdxGt0oBCWze1wbAO5f
	6rV+DYMrqr+OgNbZKNIvdB91oSOGecL6XeOmDL6+FYAybPrZMKFrH8P6nsONs/sb/C+DNW
	v/PYVgl4hhvO3QiuH3MxmCg1mOskOqQxz04b92tKdH/MDgFhMDHACRt1IgkfmA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 15:58:40 +0200
Message-Id: <DHTS5PDTC8VJ.3H8M84MQTV6RX@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 09/14] net: macb: change caps helpers
 signatures
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "Paolo
 Valerio" <pvalerio@redhat.com>, "Conor Dooley" <conor@kernel.org>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
 <20260410-macb-context-v2-9-af39f71d40b6@bootlin.com>
 <20260413174716.39915c92@kernel.org>
In-Reply-To: <20260413174716.39915c92@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,kernel.org,tipi-net.de,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: 645A7405184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Jakub,

On Tue Apr 14, 2026 at 2:47 AM CEST, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 21:51:57 +0200 Th=C3=A9o Lebrun wrote:
>> For parallel MACB context to start become a reality, many functions will
>> soon not have access to `struct macb *bp`. Those will still have access
>> to caps through ctx->info->caps.
>>=20
>> Change all caps helpers signatures, from taking `struct macb *bp` to
>> taking `u32 caps`.
>
> Subjectively I feel like this is a slight loss of type safety.
> Someone may pass the wrong u32 and compiler will not help?

Agreed. We can solve that using our new `struct macb` subset called
`struct macb_info`. It contains the caps and is available from both bp
and ctx.

So it will be one of:

   macb_is_gem(bp->info)
   macb_is_gem(ctx->info)

No more obscure u32 argument.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


