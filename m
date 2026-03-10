Return-Path: <netdev+bounces-265964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBGyHMror2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:47:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6796248C9D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFBC73009F92
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E508430B91;
	Tue, 10 Mar 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GjRKtB2g"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4A3451B5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135784; cv=none; b=hVy/W/KtDJCpGh3ygTfMfYBVOWsQw4H82t+4nuXXCP9RBttcr0rjsO/jWJp/2uqv8LVaHGTw2dh35rCv2DDn70RxbqRPMhJEak5I0Tvv/6gkccynmwjkYCSvp8wFYP2Ws9kg5BV//45qu40483Q9W9nG800lHaT+44JQki1vEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135784; c=relaxed/simple;
	bh=UvG+3RrnfJDgPru2ORmG+RIp4PunVyBaqPu4bI4E7v8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Tc8gcYNFhPl3dxtZ6V8yl+GWhQDRs+cyMz9CkjFAjEmjSm3VOLQEBXoM2HMw04BHQHzpMQTO3h27LIklqo0q5zPTLXTJdHrkTT/VeqUJAvHv8TSZfJ+YyArVDhGo6kolHFoL36D9h4IR2F/7Zc7/+nU3QCHfsk6lI1khwPnhmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GjRKtB2g; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C0889C40404;
	Tue, 10 Mar 2026 09:43:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0281F60002;
	Tue, 10 Mar 2026 09:42:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E249A103697F6;
	Tue, 10 Mar 2026 10:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773135773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3fFbEQvVsQ3IRalcwIqZe+U20pkjEonkpr/WuxVe4/A=;
	b=GjRKtB2gBQzWIah5EhyJDMnl3AguxdyZ1leHh/SDVcuHUpEVQp1uZxKqsk/RcxuTDPjyXp
	32WzEeZiCqyFft7QNdsXASIT6NTh727vncOzCKJ7MWYyV+YFBPWQ7uu6U0xdPXc4RyOIhI
	2++Ps0pMUAllMyTpPdvaRlpxjmvyf29iSKaJUkZFOOT6K6pnW9k5R6gIFDJAPnfUnShGJp
	foDFsWzZacU4ygs4cY+nTzsoUGZNaeysTxmNft7NPm0LmX/aWSayb0iSUbxV+Fb5uEptEz
	b643EpRiYq97e3ztAEx/7p7lQD6MME0sp4oVigtLH0CEFnbeSZxfNQZNpldiRg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 10:42:48 +0100
Message-Id: <DGZ066LXHG3P.3NQL2OQZ3X398@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
 <20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
 <20260306190948.44d23f8f@kernel.org>
 <DGYEXIY7VNHX.1IUJHFGOJ1B9S@bootlin.com>
 <20260309141542.5a8403eb@kernel.org>
In-Reply-To: <20260309141542.5a8403eb@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: B6796248C9D
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:url,bootlin.com:mid]
X-Rspamd-Action: no action

On Mon Mar 9, 2026 at 10:15 PM CET, Jakub Kicinski wrote:
> On Mon, 09 Mar 2026 18:04:06 +0100 Th=C3=A9o Lebrun wrote:
>> On Sat Mar 7, 2026 at 4:09 AM CET, Jakub Kicinski wrote:
>> > On Thu, 05 Mar 2026 18:20:14 +0100 Th=C3=A9o Lebrun wrote: =20
>> >> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
>> >> +		return -EOPNOTSUPP; =20
>> >
>> > Why not set max to 1 in this case? =20
>>=20
>> With !QUEUE_DISABLE, we only know how to run with all queues enabled.
>> It doesn't imply that max_num_queues =3D=3D 1.
>>=20
>> MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE (BIT0) in the
>> per-queue register RBQP disables queue Rx. If we don't have that
>> capability we can have multiple queues (if HW supports it) but we must
>> always run with all enabled.
>
> Oh, I see! Perhaps just a comment over the check to inform the reader
> that the lack of capabilities means all rx queues must be enabled.

ACK, will insert a comment.

>> >> +	if (running) {
>> >> +		ret =3D macb_open(bp->dev);
>> >> +		if (ret) {
>> >> +			bp->num_queues =3D old_count;
>> >> +			netif_set_real_num_queues(bp->dev, old_count, old_count);
>> >> +			macb_open(bp->dev); =20
>> >
>> > both macb_open() calls may fail under memory pressure
>> > For new functionality we ask drivers to allocate all necessary
>> > resources upfront then just swap them in and reconfigure HW =20
>>=20
>> The main reason we want to set queue count is memory savings. If we take
>> the Mobileye EyeQ5 SoC, it has a small 32MiB RAM alias usable for DMA.
>> If we waste it on networking we have less available for the remaining
>> peripherals. Is there some way we could avoid upfront allocations?
>
> We've been asking everyone to follow the "pre-allocate resources
> paradigm" for a few years now. It has huge benefits for system
> reliability. If you don't want to complicate code at this stage
> you can support configuring queue count only when the device is down.
> But the ask will keep coming back, any time you try to do the close+open

I'll iterate with a .set_channels() implementation that returns -EBUSY
if netif_running(), making sure to leave a comment explaining the
tradeoff.

Thanks Jakub,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


