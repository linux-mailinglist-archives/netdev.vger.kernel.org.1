Return-Path: <netdev+bounces-268204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLoGF8UvuGmvaAEAu9opvQ
	(envelope-from <netdev+bounces-268204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:28:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B49D729D62C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2633031307
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E890336880;
	Mon, 16 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YEcV8MwY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3631A7F6
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678276; cv=none; b=ZbPEeEvV3uWWOalnPQqZeLKLDliKpT0MadXynr/sDfEbaDaAO/ti06wfXNLdPUAuljYmamZHfu0yEtjsuQ6VhMZ6KXRl2I4Mtli8HcdUMV3OtjnI21MnZIQeNB2DNYi+8bCy8U1RTJfLS6lBMAQOCC0lyuIB+QSM1v15m8Vqhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678276; c=relaxed/simple;
	bh=1KUfuc3x4QUoJNvuysB7yyzuJMdot2txJAKzrXk4MQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=IJzR54aCYgkRssMxhu9ePyLDA0B6K2rGaO103FkcqGMig4Gw4eyvy9EOY1ImX9g9q6Akj6/XR0YO0I+GvBMGLYXmcyrFzPWEBBxkC9WO5RGnCtd8uYEdWVTl5pqvkKeEHHIz+0pVCezStbLd717ZD6wsLP7R+RN/NlebE2nnZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YEcV8MwY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 002654E4260A;
	Mon, 16 Mar 2026 16:24:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1CD35FC4A;
	Mon, 16 Mar 2026 16:24:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2525A103721FE;
	Mon, 16 Mar 2026 17:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773678273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2YtbT4zntwREC+7waJ7PgcL6xj0zcTivYvqR3OD4wXI=;
	b=YEcV8MwYNBdbdit005LivOmmY5ihyl5DObvJvJZEjHyAoQsI7gsC0yHXuFPmGM62AhKCY/
	PR72KdN0NAoRT99OcO/9FQrutrAXjOUTcIPizM4aX0XtmhusmgxOVw+sOzNYANdz4BMnra
	TDGKu+xF25ZDLSuwMSnYXLIa3/Ljb99CEeDvpEbtuqeKu533JqpwjDx8zn+TipswM46Ob7
	iezL4s4/hWIWxez47MAY+vRIFmfxusJUpcolSGxT8GW31ZmbiPOMsEv3BN0O/kzvftnM2G
	imUD71nkYK7aNGtRxEI5wBGE+2KA2umH7x58PZ+RBki3WuY3bbsPCCmpdL63oQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 17:24:28 +0100
Message-Id: <DH4CGZWQLUX0.17P120CM20SV8@bootlin.com>
To: "Jakub Kicinski" <kuba@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v2 1/2] net: macb: implement
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
 <pvalerio@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
 <20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
 <20260312182624.35ab61c8@kernel.org>
 <DH1R3P9TTPS7.1YE0XC8RTNTIJ@bootlin.com>
 <20260314075427.034097b2@kernel.org>
In-Reply-To: <20260314075427.034097b2@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268204-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B49D729D62C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Mar 14, 2026 at 3:54 PM CET, Jakub Kicinski wrote:
> On Fri, 13 Mar 2026 16:14:23 +0100 Th=C3=A9o Lebrun wrote:
>> > should we reorder this with the running() check? =20
>>=20
>> I don't agree. For example when an operation is not supported, we start
>> by checking that and returning EOPNOTSUPP. Then we validate the input
>> data. Then we act.
>>=20
>> Here it is the same. When netif_running(), we never reply to any
>> request even if it happens to be a no-op.
>>=20
>> I'll go ahead and send V3. Seeing how this was only a question I'll make
>> the guess you don't care much about it and are fine either way.
>> Same for me.
>
> Sorry for the delay. This code can only be reached from the IOCTL path.
> The Netlink path will check that params haven't changed in
> ethnl_set_channels() (look at the @mod variable) and return 0 directly.
> So you're basically adding a discrepancy between ioctl and Netlink.
> Not a huge deal but I don't envy any user having to debug this..

Actually, the IOCTL path also does the check (see below). So the
`count =3D=3D old_count` check shall be dropped from the driver
.set_channels() callback because it is redundant. Agreed?

Extract below for the ioctl codepath:

static int ethtool_set_channels(struct net_device *dev,
				void __user *useraddr)
{
	struct ethtool_channels channels, curr =3D { .cmd =3D ETHTOOL_GCHANNELS };

	// ...

	if (copy_from_user(&channels, useraddr, sizeof(channels)))
		return -EFAULT;

	dev->ethtool_ops->get_channels(dev, &curr);

	if (channels.rx_count =3D=3D curr.rx_count &&
	    channels.tx_count =3D=3D curr.tx_count &&
	    channels.combined_count =3D=3D curr.combined_count &&
	    channels.other_count =3D=3D curr.other_count)
		return 0;

	// ...
}

https://elixir.bootlin.com/linux/v6.19.8/source/net/ethtool/ioctl.c#L2263-L=
2267

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


