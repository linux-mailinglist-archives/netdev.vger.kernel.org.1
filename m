Return-Path: <netdev+bounces-294346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0MOeCskmH2q3iAAAu9opvQ
	(envelope-from <netdev+bounces-294346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100C6313AE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="H/ujq6vX";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294346-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294346-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF303031000
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA403382E8;
	Tue,  2 Jun 2026 18:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDD2222C5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:49:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426156; cv=none; b=Z96q5Hy9PCdUgutrbxlC9THIoEwxBuyCnPILMLxsCliX2lWXiuWvUMI78WmvTHtrgFAveHUf9apuMdLkC8JXRockUz1YZ1DipPnwzrp8f6njHASn4Z6RDl9dnbp/NaPXNm0m9KSTgyNmav6tVZYF9qZMwAqjkrOvFVK7vCDdfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426156; c=relaxed/simple;
	bh=UOD9wdAXWmO1RapDQoutl9I7fXxwnGsaGJ37yt3Kl9I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWPoUqS3OjzlGKd/9tQZlMvKzdKZvzNa1Zz36ftkxivpfG5CwRw4/ROmA61sV7Bt+L2UpwcfsT4rJDPiF+5dQChqV8jbKG80vOGazM7wINeg36adlKj6m8HbEupbPDR4oWxCmY2y5uw0uS1Rs0qKRbpz0G4zkShoLmlKmkKN9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=H/ujq6vX; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780426120; x=1781030920;
	i=markus.stockhausen@gmx.de;
	bh=UOD9wdAXWmO1RapDQoutl9I7fXxwnGsaGJ37yt3Kl9I=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H/ujq6vX54qcPP/6jC517sx5adWL5j7sOstQG95UKA3MrDWNmor9xm6NO1aH4tSV
	 u2qipMX+yHXMH4dE5O6Ndu4v30jIi4+fI/9mwzjLQjfNFCx8IXZqnP6dbrmxxTrlz
	 c74AQqKTEz7OgjFcq0fl/+ylnghRoZbVQypSF6S3T5EfvgALuMnEnPLT45DkzOJiO
	 +YxLQ95hhi154Uz7NWmY0Fm1nHgOHrFfHvhdQ5tmlpOeAiHiKLIKemb2GkUXHHGuY
	 /SMx8K2IX/EUcqrvx0H7PjHgGdeDyhSlbKg9fvYX0PD39GFORWrQQJhAigmqeziu/
	 bmyWL+oJ8hHmtE6FMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdefJ-1x3Xnl0YKX-00n2RT; Tue, 02
 Jun 2026 20:48:40 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de> <20260602052640.93083-7-markus.stockhausen@gmx.de> <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch> <02b201dcf28f$e4794470$ad6bcd50$@gmx.de> <6ebe2342-fd11-4588-a17a-fdb057335915@lunn.ch>
In-Reply-To: <6ebe2342-fd11-4588-a17a-fdb057335915@lunn.ch>
Subject: AW: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate topology setup
Date: Tue, 2 Jun 2026 20:48:37 +0200
Message-ID: <00b401dcf2c0$6e2826c0$4a787440$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgFzUwJSAcESFFkBIjNNsgJMQir8uHSTgxA=
Content-Language: de
X-Provags-ID: V03:K1:Q1PN64FY6qoNsS91rWLrDXOp/5F98YBr6N32o+d6kGbBQOevuVo
 6srXq2+ru4NXFbTMdGuIMrbGXpERwFJ8WEYPlfjhRS8W6Q+gxgZogjseuYwt2eJekbCZgPp
 0qQWIT+ap4LCu4ADfZxl1XTSVAMf99wO/KHgnUAaXPJTL4j4ZzxZ1Y0Izg8oz+f7asS6pOp
 x2XIrLTzrw/AD2rWWklcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e9FY3oKTwZc=;8fBlGOQ6s8T0iIl62QsdehJQzym
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294346-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8100C6313AE

> Von: Andrew Lunn <andrew@lunn.ch>=20
> Gesendet: Dienstag, 2. Juni 2026 17:18
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
topology setup
>=20
> > With the next series I want to deactivate/activate hardware polling=20
> > during the whole probing process (besides other things). This avoids
> > that hardware polling fills wrong MAC register states during
> > bus/PHY setup.
> >=20
> > Are you thinking about this? If yes I can add that to this series.
>
> No, i mean during normal operation. When the core takes the mdio bus
> lock, you need to disable polling until the lock is released. That is
> going to need some additional API calls in struct mii_bus.

I have always tried to avoid kernel hacks downstream and never
thought about enhancing the mii_bus. But as this seems to be=20
some kind of invitation I will shortly explain the situation here.

The hardware polling in these devices is very important for the DSA
driver. Especially as a port can be either PHY or SerDes driven. Some
MAC operations simply do not work if a wrong state is reported.

Hardware polling and PHY access coexist without any issues. The
MDIO controller coordinates the different requests and the kernel=20
does not need to take care about that.=20

However we have rare cases where polling should be disabled.
There is no evidence about any issues in the OpenWrt ecosystem=20
but vendor SDK disables polling for certain sequence of operations.=20
These include

- PHY Firmware patching
- Switching the port on a dual Fibre/Copper PHY
- Enabling/disabling EEE on a port

So we can benefit from some kind of bus enhancement that=20
allows to "isolate" a PHY on a bus from any hardware interfering.=20
Best case would be to allow the PHY to access these functions.

As said no idea at the moment because never thought about it.
So any guidance is appreciated.

Markus



