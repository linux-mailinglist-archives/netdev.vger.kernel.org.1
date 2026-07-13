Return-Path: <netdev+bounces-307013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPOZFSt/VGqimgMAu9opvQ
	(envelope-from <netdev+bounces-307013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C162074767A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=MolmdQXV;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307013-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307013-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CE973009140
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14E360EF7;
	Mon, 13 Jul 2026 06:01:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6A3603EB;
	Mon, 13 Jul 2026 06:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922471; cv=none; b=uCN5dCp5jr4PCnATT5xCh1shmodawFtRp6MirOsaufL80FnEjnY6RpfDf8EPZgD+0dF6J7SFTIMkSepqE2aNCtz2K6F2SzpAWSo+hCZObr+VavU4/924Ej3YA5oVRpd9+CodHE1xCs+BzYvNU7MV0bkTXt5Iu/u+uA6Y7lxryV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922471; c=relaxed/simple;
	bh=ZxVp0tFLwEDH83P+uahtCa7C1V7nyzmcMzNNAxm9S+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gj3X9CFwSJNie5k5+WNg2WlrXidY4vsUXJSDLO6cG05ghSOA1iDxq6uow59g1YS7kl1Ee5LS3jVdGExEL7yjrwKmyS9CvmkscGR9o2z5f8mlIrXAeV2XYTLnC+zOUw5T8/4o6vDFnxPRuD+ni6mnouyuXzistTUUgHJKMEgtIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MolmdQXV; arc=none smtp.client-ip=212.227.15.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783922467; x=1784527267; i=markus.elfring@web.de;
	bh=qtnbzBIOhY8KSrPOroAuSTqhwFkVUPEHXlZYJRTfnSw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MolmdQXVtTjgXJhMLbAMqMI+Xlbi78cBI2DQWyRsWvd+OkPjDzXGQ/jrqhlND6Ms
	 kJAqE0Gbjliod7lLKz4sQmZ/AHi5/jD7Pz6XiF9JTw1575WqxPxTzzXicPH35dr36
	 Mv5ObN3HnHNCGVXJnzDc2fH3zZlANnEPsjI0pE70nzyrcmfc3Y/oTWM6rzpijKEt7
	 yxJ8Fd0RoCTjojbEhbNvotDkh8Gt8XWiLd0RNCdKsNL82DJ6Pi+GJ9xI1O/mHivQa
	 39XOzgFmfnvvxL1pZaPYxRGknQACyW/mgfO6wu6YVBdKEMTJ3snRM+yIrqt0Lb6DU
	 czrnAIayFZsRTcmuXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1wmfpO0ZJF-00C6jh; Mon, 13
 Jul 2026 08:01:07 +0200
Message-ID: <15aecb26-cc04-4cdf-9372-65ab4943abfe@web.de>
Date: Mon, 13 Jul 2026 08:00:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yibo Dong <dong100@mucse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <165fca2f-2259-42c0-bac7-58685a4c5ebd@linux.dev>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <165fca2f-2259-42c0-bac7-58685a4c5ebd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:09Utz90S+BkqwnNSB/hiAwT9z2EBHs0i/d724ozg6GHR3UTueIU
 MnIvl1ppRQ9gV3CeIOnOiVQdtiVGjHY0ikHmDTp7rpBopGehvHFgagtCWsRlSnP2/LpuTJY
 ChKeejyWUAISlHGydj4OyCc2Go2yerv7VZ6xv7S1m1I6dYygXH8CimSPqjw3OQ1yuXl+hZ0
 PsbZ2rJGaLQM8SjRRIQ2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MJb4YQnKVag=;x2fV81naSQRc2FmLrb0/2Bo/9NR
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307013-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:mgr@kernel.org,m:pabeni@redhat.com,m:u.kleine-koenig@baylibre.com,m:dong100@mucse.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C162074767A

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Crnpgbe_rm_adapter=E2=80=9D.
>=20
> The null check in rnpgbe_rm_adapter() looks more like defensive
> programming,

This can be fine, can't it?


>              which got into the code unnoticed.

Some patch reviews happened accordingly.


>                                                 pdev will not exist if
> netdev is not allocated, where mucse is netdev private data.

Would you like to reconsider the relevance of another null pointer check?

Regards,
Markus


