Return-Path: <netdev+bounces-274561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LeTL5R1zmk6nwYAu9opvQ
	(envelope-from <netdev+bounces-274561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:56:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2238A199
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED5330632BB
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C6E2E0901;
	Thu,  2 Apr 2026 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ajROOsn1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350273C454B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137584; cv=none; b=fpBr+DlHLSbVxFl4uVvk407d/COeoGKcz+mibxKhhUen1lFmV36yOHqnPqTwAafpSpwm0ixEnq2REufAjHkDa/oR8DyWm5VRYKYxV4pxuWLpFZnSTM7b6U1fugyxb2onrANUB6b2SBSrha4DguyqkSYR3kj0jJ3kGZn8F0qmxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137584; c=relaxed/simple;
	bh=aHZ0S5vkSIsoJ7VYMzJPdRUpX0WJTbEOIGe0bUE4jp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=KKIHT320+D8ovJG/8/4h0ONOQ+YHzF7kKupYVaXibNUN6rRgGT7KbsrXoM68KLfurHz7s/HcHcuxhFtA0Vd1CLi3tH41PtGkJ9Dk9HAohjogi1N2TYKisXwoz2KQqkPRLaqdXotyqPMK3hPuCcIK27fIIhdCpDbzSqIY7mnx8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ajROOsn1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C90434E428AE;
	Thu,  2 Apr 2026 13:46:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 902DA5FDEB;
	Thu,  2 Apr 2026 13:46:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2D4510450262;
	Thu,  2 Apr 2026 15:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775137573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cja/NfeVOSO+/W7+EGsBFPgZjU9HqugPbefIoVB0XY4=;
	b=ajROOsn1SgPjCsZoKvuJ2CZiPusXmWczDSfbdaHud6AWwAan5VPeCFtAZl/+ydofTifspI
	byisYyp7PGCkY6jLeGoDu+eO+IdtpjK46hq8Hi6NpWSwcGfc3UA0gV6ofqT461u513OsP/
	CHWiuHwnbNPIcTW/iqpFFL+iokXCTokjMmCHHNn6snRB5yDZ8IGxPJHRYNbYoYcgGsdTyo
	il7LDk3H4JN6MoV6qP1ETD4R9mnajygMLKcxMnW4yAR/ylk71PrGgDO4cHYhMdgZlGF/a3
	G14HKSaiYRk4tZxgeeA0pf0if3KHczx3meCW0xpNY8rUvIbNgPNt4RzjBCxpxg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 15:46:07 +0200
Message-Id: <DHIPR0HVCE5W.1ZVH5VSPC1FSN@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 00/11] net: macb: implement context swapping
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Paolo Valerio" <pvalerio@redhat.com>, "Conor
 Dooley" <conor@kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401-macb-context-v1-0-9590c5ab7272@bootlin.com>
 <f399076d1791d9df325f967e50184c2e@tipi-net.de>
In-Reply-To: <f399076d1791d9df325f967e50184c2e@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274561-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,mobileye.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: 2FB2238A199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Nicolai,

On Thu Apr 2, 2026 at 1:35 PM CEST, Nicolai Buchwitz wrote:
> On 1.4.2026 18:39, Th=C3=A9o Lebrun wrote:
>> MACB has a pretty primitive approach to buffer management. They are all
>> stored in `struct macb *bp`. On operations that require buffer realloc
>> (set_ringparam & change_mtu ATM), the only option is to close the
>> interface, change our global state and re-open the interface.
>>=20
>> Two issues:
>> - It doesn't fly on memory pressured systems; we free our precious
>>   buffers and don't manage to reallocate fully, meaning our machine
>>   just lost its network access.
>> - Anecdotally, it is pretty slow because it implies a full PHY reinit.
>>=20
>> Instead, we shall:
>>  - allocate a new context (including buffers) first
>>  - if it fails, early return without any impact to the interface
>>  - stop interface
>>  - update global state (bp, netdev, etc)
>>  - pass newly allocated buffer pointers to the hardware
>>  - start interface
>>  - free old context
>>=20
>> This is what we implement here. Both .set_ringparam() and
>> .ndo_change_mtu() are covered by this series. In the future,
>> at least .set_channels() [0], XDP [1] and XSK [2] would benefit.
>
> Thanks for your work, the context swapping approach probably
> makes a lot of sense and will finally bring proper MTU change
> support that I tried to patch earlier.

Thanks for the review!

>> The change is super intrusive so conflicts will be major. Sorry!
>>=20
>> Thanks,
>> Have a nice day,
>> Th=C3=A9o
>>=20
>> [0]:=20
>> https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffc=
fca@bootlin.com/
>> [1]:=20
>> https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.=
com/
>> [2]:=20
>> https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootl=
in.com/
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>> Th=C3=A9o Lebrun (11):
>>       net: macb: unify device pointer naming convention
>>       net: macb: unify `struct macb *` naming convention
>>       net: macb: unify queue index variable naming convention and types
>>       net: macb: enforce reverse christmas tree (RCT) convention
>>       net: macb: allocate tieoff descriptor once across device lifetime
>>       net: macb: introduce macb_context struct for buffer management
>>       net: macb: avoid macb_init_rx_buffer_size() modifying state
>>       net: macb: make `struct macb` subset reachable from macb_context=
=20
>> struct
>>       net: macb: introduce macb_context_alloc() helper
>>       net: macb: use context swapping in .set_ringparam()
>>       net: macb: use context swapping in .ndo_change_mtu()
>>=20
>>  drivers/net/ethernet/cadence/macb.h      |  119 +-
>>  drivers/net/ethernet/cadence/macb_main.c | 1731=20
>> +++++++++++++++++-------------
>>  drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
>>  drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
>>  4 files changed, 1090 insertions(+), 832 deletions(-)
>> ---
>> base-commit: 321d1ee521de1362c22adadbc0ce066050a17783
>
> The series didn't apply cleanly on current net-next. The
> base commit 321d1ee521de doesn't seem to be upstream yet, is
> this based on your set_channels v4 series?

Surprising. I fetched net-next/main yesterday morning. My branch is:
 - net-next/main @ f1359c240191
 - my three series needed for working networking on MACB [0][1][2]
 - some dev defconfigs
 - finally the series sent upstream (b4 cover letter then series)

I confirm it applies on f1359c240191 but not on today's
net-next/main @ 269389ba5398.

I should experiment with b4 series dependency management. IIUC it would
have exposed through public metadata that my parent commit was
f1359c240191 even if it isn't strictly true locally.

We happen to add macb_{alloc,free}_tieoff() just above
at91_default_usrio which got edited by Conor in cee10a01e286 ("net:
macb: fix use of at91_default_usrio without CONFIG_OF"). Will fix in V2.

Thanks,

[0]: https://lore.kernel.org/all/20260225-macb-phy-v7-0-665bd8619d51@bootli=
n.com/
[1]: https://lore.kernel.org/all/20260225-macb-phy-v7-0-d3c9842ec931@bootli=
n.com/
[2]: https://lore.kernel.org/linux-phy/20260309-macb-phy-v9-0-5afd87d9db43@=
bootlin.com/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


