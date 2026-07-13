Return-Path: <netdev+bounces-307084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 172IK3ijVGp+ogMAu9opvQ
	(envelope-from <netdev+bounces-307084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:36:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3A748C46
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:36:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=EpuGfazL;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307084-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307084-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA3363017CB3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4F3ABD83;
	Mon, 13 Jul 2026 08:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C43A7F75;
	Mon, 13 Jul 2026 08:22:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930958; cv=none; b=eR7G4x2yielGB+22E0bhD85qVpJLnPtk4HYUY9+AVyS4LWw2OJYqJcibvuFyxH+wfYjXySOhz6WHFBspIh5HIBN1Y88XskWHrpifA9/pUKIhy7qpNPfyinC0+gb/FtWy5iFkfwA42fPfi8D/EWqdzOR6/5CPsMvsZCZNdSiEI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930958; c=relaxed/simple;
	bh=wYql/GaIAEiSrBuZlAUHALXl5BN6M8Q5cDMjyxFjiRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssDHTWz8+lq3UFroeLdcJda+hq1vCPtKwEv89HEw/bAOCuVutfqX0inBkMlEORVYor+ZoV0l9OD0NOdo04qzoRihlvfV3ayHz77mjqQFVOZ6n9kajR5SOvN20+TW1bZF+uc2ow1kUUB+8gjDIOiSF27sSKqrYBo5ZSB+x7wmPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EpuGfazL; arc=none smtp.client-ip=217.72.192.78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783930941; x=1784535741; i=markus.elfring@web.de;
	bh=31TWtz9z/QRC6KGiYgf3V0dBYm1WLC4uR70r6MXeiwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EpuGfazL1fon+8UvjiUDZ7logKlqc08lC32G4G6kMdMHkbp5QIEFXs1WWmVmPWzu
	 /p7z0W41k8pZd9oA7cQdMCrA+f06lP652bmyh7PvlytWf96OvTRuiq6yGp4F1mpa7
	 myXvPxF/hGxWxzSdTWMlHZe0AYb7MGGV+FJFqRScEiNaVIqD5GdGTRW0Q5Al++jWb
	 6WDHhMBcLEIleV96cryfE0S28F5jP4blxp6pokfv71PWmQnCn51kKrmGgMoNewupG
	 ReO4wbKDahBzmlhDCoibt+hbx98yRsSwnASmS6A+uCMURA2AC66dliWBR+DesOXTm
	 EYG13VQ3B3d55onqMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElZB-1wqbu33QWh-00HZoB; Mon, 13
 Jul 2026 10:22:20 +0200
Message-ID: <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
Date: Mon, 13 Jul 2026 10:22:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: rnpgbe: Pass an expression directly in
 rnpgbe_rm_adapter()
To: Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Yibo Dong <dong100@mucse.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alScHkiC3EmGzOlI@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RMkm6zxoWC7F0OdKHKUfAAhD3bHC9BFP6uJWi6V+9jup7jLPMGw
 0fWw5lxj3debsxP3I3IKpJmLqqDPC9P3jaj48u6BFQXNf/PUbrEe6BwQucRqulCTw/1REIY
 ZzjrQtWpRYXKO9wj/KbTa1NqvKRim052DWfqriR1aGO2tQ2F3LrpE5HqUSmuxV/5d7w3RTh
 Hdd5Cgf6b6GO16RCIN+Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n/TGa89xiMA=;FgtNVRDqXAMH0GmJeutL3+Z3ePk
 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
 mHmGETrQbr6h3Pz1kgCRg
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:vadim.fedorenko@linux.dev,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307084-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[web.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9A3A748C46

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by omitting the variable =
=E2=80=9Chw=E2=80=9D.
>> Pass the required address directly to a function call.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Fixes: 2ee95ec17e97c58b65e978a08b75fa8cb6424e4e ("net: rnpgbe: Add regi=
ster_netdev")
>=20
> There is no NULL dereference here.  It's just pointer math.
> No need for a Fixes tag.

How does your view fit to information in an article like =E2=80=9CFun with=
 NULL pointers, part 1=E2=80=9D(by Jonathan Corbet from 2009-07-20)?
https://lwn.net/Articles/342330/

Regards,
Markus

