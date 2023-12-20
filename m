Return-Path: <netdev+bounces-59186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1E819B99
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589C8B25288
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D31F5FA;
	Wed, 20 Dec 2023 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hbt1/iby";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bScPBrRJ"
X-Original-To: netdev@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A41CAA7
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B7E4A3200A6C;
	Wed, 20 Dec 2023 04:44:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 04:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703065444;
	 x=1703151844; bh=Ls+WKw9KClvsNkQvaepGMoohiyAloZB9fflQvlu/laE=; b=
	hbt1/ibyBHT11K/+9XVI8kGscBCHgMDNNlt83Ly2VNSxh0w3i/6nMqjCxYpS3uaC
	jz9a+2Ur6CeeinMgW4tJ/lIoC7JhqCsEBtqjFsuLiKNpU+X8SGVFzYa9c6cYvxWA
	33z4pGtj2YGUMyS/WWOIT4vl9SMCr092+MVSJxdScKj31swYqt9TX56ajI9N12Ij
	UU1TkjdC5vmZjqc6z3816Zr2QchkMW37ZWeSi7u80kYN1KJ6VnH8ILdgnsT6nmVl
	AGulzPKAx0hOx6fcA4ln46Fx48suR0yv76VFku+I7CdYJF4pfCglABh5NP6Cc5mm
	bf7Cys6zEcmrOheoilGYNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703065444; x=
	1703151844; bh=Ls+WKw9KClvsNkQvaepGMoohiyAloZB9fflQvlu/laE=; b=b
	ScPBrRJtS/Lk4mU7fKCaLmIiWAuqWC/8+6e9TAbJDsW5gWZeAXIQBCZgCKWE3rNe
	v0oLtVd1ZaDQiohjeRVIYzpXmgKsPrPP88Rkgt4OTUAcTr2FME/zfD4NafPktSmr
	6SvUoubGB7NIxVl9I3N9QVqzzHKmHYfOjFTWcooLjPETHX9H+YvgNI6AT/FBs6bx
	cyMWTd51HtlpCyUn3Nk7QKyfiR/DDBDwx1i8p8hEzIk/oPyibGse96Q6qDxVusFa
	GmaNs+r63VaStBQ70v7ZvK9WNIzGIj2QL9UmV9sEuoIQtuzz4DCohdMy8Xq3vMh2
	0azh/2V072stVPhxTm1+w==
X-ME-Sender: <xms:Y7eCZfSmc3W1-YPHy1NwGFWZeIxPYMWHaE2z75WOlBm9d-e0rg6UIg>
    <xme:Y7eCZQxqI7NanAYuXJIINFE4368EgyvA_-KXJ4Iqq6TNQi0IIh95AF9Abf2V6tBdK
    QOUh3kl4JmIxV2hZzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Y7eCZU1HyznyxYL_3b8Gq1GK97lxoQfX0Q2z0JtAo5H5uz3aQ2dnvw>
    <xmx:Y7eCZfD1ewN4sQZ24Ek4vCCc2YlMrC7egLLkQsnXoB5WlQ2Kn7VgwA>
    <xmx:Y7eCZYgbQfB1pgnYUe7z6gMfQzZWa1rdbeCmYYeaFyO8xa0XKGbUJg>
    <xmx:ZLeCZbsR8ZeiYRI7X7DncSSPDAHjNgKYNrwgYimOUMrNffnda71UBA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7F599B6008D; Wed, 20 Dec 2023 04:44:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
In-Reply-To: <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
Date: Wed, 20 Dec 2023 09:43:45 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Thomas Lange" <thomas@corelatus.se>, Netdev <netdev@vger.kernel.org>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>
Cc: =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> Thomas Lange wrote:
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 16584e2dd648..a56ec1d492c9 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk, struct cm=
sghdr *cmsg,
>>                  sockc->mark =3D *(u32 *)CMSG_DATA(cmsg);
>>                  break;
>>          case SO_TIMESTAMPING_OLD:
>> +       case SO_TIMESTAMPING_NEW:
>>                  if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
>>                          return -EINVAL;
>>=20
>> However, looking through the module, it seems that sk_getsockopt() ha=
s no
>> support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
>
> Good point. Adding the author to see if this was a simple oversight or
> there was a rationale at the time for leaving it out.

I'm fairly sure this was just a mistake on our side. For the cmsg case,
I think we just missed it because there is no corresponding SO_TIMESTAMP=
{,NS}
version of this, so it fell through the cracks.

In the patch above, I'm not entirely sure about what needs to happen
with the old/new format, i.e. the

   sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D SO_TIMESTAMPING=
_NEW)

from setsockopt(). Is __sock_cmsg_send() allowed to turn on timestamping
without it being first enabled using setsockopt()? If so, I think
we need to set the flag here the same way that setsockopt does. If
not, then I think we instead should check that the old/new format
in the option sent via cmsg is the same that was set earlier with
setsockopt.

For the missing getsockopt, there was even a patch earlier this year
by J=C3=B6rn-Thorben Hinz [1], but I failed to realize that we need patch
1/2 from his series regardless of patch 2/2.

     Arnd

[1] https://lore.kernel.org/lkml/20230703175048.151683-2-jthinz@mailbox.=
tu-berlin.de/

