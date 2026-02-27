Return-Path: <netdev+bounces-261855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aObuNdqsoWk3vgQAu9opvQ
	(envelope-from <netdev+bounces-261855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:40:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41F1B920A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC46B302F996
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41011482E8;
	Fri, 27 Feb 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r4+8LzqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405C41322B
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203159; cv=none; b=EbUrPTiUAYzcj9CqJBCeAqp2q+Ai5CfnCg3A/fKP6cWjuEoQBx8OFyZcZWQSro9J/YQzImrVx8Oxqqa8m6sHy45A5PG/PECUFszcZ2S8kqbOgUKJ2tzKP80yf3W1p7ROkvDsPGz6ptgiXcy3HB3KptuS6zernxICw8oF2NPw1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203159; c=relaxed/simple;
	bh=HAByJrJ5n2U9c3+SaluXPZhzxMQngtQnSaDGY/9Jt6w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=irg3u5ofisDQyJFvk9Ao+P0SZ78fTQfOXp1fkoLu1bsp79agseMabMArRX1M/ru+3wIrKOCOcYuYAQDYAKwVanOyKKT5bT7vymrJz95nU+3+90HTI2q+QVBVW/MzardihyngaCFw814GJuWQYFYARkC/kEyqY++8grXIf1e1wAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r4+8LzqJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1E234C406A8;
	Fri, 27 Feb 2026 14:39:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24B9A5FE46;
	Fri, 27 Feb 2026 14:39:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8076103690DC;
	Fri, 27 Feb 2026 15:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772203153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nDg8l5o3Gm+uvjRi6vMF2oEJo+ETctFMNwu7Y2xx6/8=;
	b=r4+8LzqJPwhDEqRjsRYCyMa80lj+Xri9u6S+0bNUFigkSKaP3+z4Za1ZEoTzHXFJmpvOdq
	QV94zFCtJf1upKkLD6j+BeFQHMtF0KkJS1yB+XrYird/nlWhtenREaK2UuwxFYzru7kC8A
	aBAmP6xII2x2di/Q+tKbNUFaQ0dO/l/u0g+uNjmy09sV9TqGr5ONH5bW1c8fKe0jMdPOgQ
	hLVq5JgVsf7c3Va8Pw9GTzgxRgjwKoMIDDWDl6WrYh7cTjyrc3oa6X3Xgouk5brSI1S7B5
	eaJWgqOf9xLGohB/uB/ADgO5eW3pm2JAXjUSxss0GY7jTHuVEDoBKpQX1k4VHQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 15:39:09 +0100
Message-Id: <DGPTL3ER0WFH.FA79BTCTCWDO@bootlin.com>
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
 <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
 <aZ82VFPu2FDmPpJ0@shell.armlinux.org.uk>
 <DGOSV8GS9VI6.8IV6D1L3F94F@bootlin.com>
 <342fd96e9f9668392705496e54d93eff@tipi-net.de>
 <DGOXXGNSSMYK.2XNU9AQ6E077P@bootlin.com>
 <e90dc9e1ac7c9d85607c8fad6094d6b2@tipi-net.de>
In-Reply-To: <e90dc9e1ac7c9d85607c8fad6094d6b2@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261855-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: 5B41F1B920A
X-Rspamd-Action: no action

Hello Nicolai,

On Fri Feb 27, 2026 at 10:00 AM CET, Nicolai Buchwitz wrote:
> On 26.2.2026 14:50, Th=C3=A9o Lebrun wrote:
>> On Thu Feb 26, 2026 at 11:49 AM CET, Nicolai Buchwitz wrote:
>> But talking about perf, let's measure.
>
> Tthanks for testing! Since you have the hardware at hand, would you be=20
> willing to add MACB_CAPS_EEE to eyeq5_config as well? I'm happy to=20
> include it in the series if you can confirm it works correctly.

Tested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Tested using a hardware loopback and a net namespace.

# ip netns add netns_eth1
# ip link set eth1 netns netns_eth1
# ip -n netns_eth1 a add 10.0.0.2/24 dev eth1
# ip -n netns_eth1 link set eth1 up
# ip a add 10.0.0.1/24 dev eth0
# ip link set eth0 up

... ping and iperf3 ...

# ethtool --show-eee eth0
EEE settings for eth0:
enabled - active
250000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

# ip netns exec netns_eth1 ethtool --show-eee eth1
EEE settings for eth1:
enabled - active
250000 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


