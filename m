Return-Path: <netdev+bounces-307661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id giDlDIkaV2rJFQEAu9opvQ
	(envelope-from <netdev+bounces-307661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24E75AAE0
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:28:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=GziIJdyU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307661-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C132301D078
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60163B5E10;
	Wed, 15 Jul 2026 05:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D78381B1F;
	Wed, 15 Jul 2026 05:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093318; cv=none; b=LGHeJH0LhmxW79460cSWhzdEa2y/7qtLHy5BA/JOx38MnX3PylXX01FdHRKzflu31yPpWf0ArDmP31ph1fEVA8tZY5I6wXO1E5xHSOCoIhNRDOpAGw2F+JLFfraq/sFfANIhPoN5vmiVKDvTCV7tWqef+mQ6AOnH8bRVbxPqneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093318; c=relaxed/simple;
	bh=t+MFqbIS7aPa095ttTtlnUWjL9Jf/yk6MV51ukISM94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKTqtUA0V1/bLmeROZutyyw5ZwrVUw3SkblE7y1wPyT+0oVA7h3fLoze47fb+sZPtf4zkAX1GTr6gdHeeGBt6VCTI4/o5gjlpsDDPyyG1AM6eFv7LQoMRu+p9gz1LFG9aNOknM2PNEf71HxC358LEVcQ5l5sQy+W2Gs/ONgP53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GziIJdyU; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784093314; x=1784698114; i=markus.elfring@web.de;
	bh=t+MFqbIS7aPa095ttTtlnUWjL9Jf/yk6MV51ukISM94=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GziIJdyUvZY56e5lQBE/mLSeEp1/c5aGdACxYdTHHhU4kbsBVzag9usbrR9b5TDQ
	 2yj4LaOqH8xMXIN7VX2WZKbLyvuPXWb9mAtFc0SvybNiziXUVLxLGxC/Liym3/oS2
	 DVg/yr78g8Rk059JpvqBuHr5RG8WtwsmIPHNBJAXsEzSCkn1UCm8kmTkWW3T6tF18
	 XSJI6J5wIQVYvi/0AvPFAp/6DLCWqzv5Z7W+mXae5rmaukXRhwfDNNWvo3YWQR+80
	 gTw4m53pwt0nyEOccdSY+iPy8nsqUFA4RXgsJuj8TzhWdHbXk6Ekn64xqHYZOz9oK
	 ItvouYVnKvp3jNtf2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1xQfYR3AVJ-00prRu; Wed, 15
 Jul 2026 07:22:38 +0200
Message-ID: <10a32f39-2a5f-4e52-973d-d9a71b9b956e@web.de>
Date: Wed, 15 Jul 2026 07:22:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <dd0bb5df-22eb-481a-9274-7feb725172d0@lunn.ch>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dd0bb5df-22eb-481a-9274-7feb725172d0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tnYofw33Wv8/DzgTwSCgS4ev6+OuA/8hyLpcxsWRzooJfHG4q+R
 fqdVMFkIn8ealB9YnmjRtwOnAE2W+MrF23l140CwWweAmCjwss3rIqg6p9GSavalrg4o6cm
 lYwjX1tdTdFq+pjyKB5NlyT3YUzn3RY20nPd8W34KDVEqc8q4e3QBkyPVI9G/qX9e9LuJ79
 jI2TSQpDjKt/c49QrgL3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VPOFs+2aRk8=;+5iuowrTzYk5qHAawBY4sX9ClMt
 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
 fz+vc1hUM/dd88EQUI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307661-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A24E75AAE0

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.
>=20
> Please can you show the path taken that mucse is actually NULL.

The applied sanity check indicates a corresponding possibility.

Which result representations would you find helpful for the requested
data flow analysis?


> I tend to agree, that the correct change is to remove the NULL pointer
> test.
Will the omission of such a check gain wider acceptance?

Regards,
Markus

