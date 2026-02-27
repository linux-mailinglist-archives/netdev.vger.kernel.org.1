Return-Path: <netdev+bounces-261818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANj9OHl3oWnJtQQAu9opvQ
	(envelope-from <netdev+bounces-261818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:52:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 600311B6390
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 568D4301D326
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6043B5303;
	Fri, 27 Feb 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uqC5BgEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2237FF6E
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189557; cv=none; b=AStDm4idEwlPVgXXGl6N3kaLQFH4Wu2khcukA2F55GK+/y9KxWhXjWt1qv4yGP+Tycuo2vIpJ4zz3XTLZ6Eq6juI17TnNqxMEfee+oUeIjWz9rETr+dkcVodEabRk83nCo9aJo+d5iO5S67pXXrSNLgFAZ1rrjl6saDz4oIz+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189557; c=relaxed/simple;
	bh=ZWP0LURNHTFwo6WdRckV4T1yQKogN+iy1vcJYn+TwZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iXJlFTx/zj9u0eTs9R3TxldVnIXHp8DkMpkS1qaiin6uoF9RkAWbjI7DaXQNnsFO7wsY/cHVo8C6OW8jtQuotWUDMlsl80OgNjdUzZDtk0567ClS7H3zzQZD5ZZLiBamVlBniKxJBKsnPW7otQzSYovLjapqdHu6U2xL5PY74PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uqC5BgEj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 909A61A1A54;
	Fri, 27 Feb 2026 10:52:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DB375FE46;
	Fri, 27 Feb 2026 10:52:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B5DB10369426;
	Fri, 27 Feb 2026 11:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772189552; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XObck1fL7yI8Otsd8p4sQIJN4SGqXdd1BQ1y1Vx7rto=;
	b=uqC5BgEjLO8qP0VzypiTmaft2lVStC26lLYN31L9z2GUmHTfvdO/mwPZrMxf3x0Re1OnXP
	xpG2Xjs7qrM6MMLLHGyCV1KTAjUkyOYcGaHLBZosAOlSxtMclATXWwHXSFF2msCLjOjzfw
	92dyPtvYHyvsK7J10G9311uDdVDPV5gpWXCuwBpIqSC1Sn+GsK5yeaHuVw81dpzmcQ9JvG
	udO/WifOvTkL82tk1dGglukfI78iEfvCMcGe17Zcolr1+UG6ExKj3hW4BUff0Y5qsaGuLN
	U2OzTeab/EDN054BY1+IaKF8DRJ5MsZOJvDFXtom1SqjkJ3rOFMbrWGw8BiXCQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 11:52:27 +0100
Message-Id: <DGPORITW7CFW.1DBYQHGBZ8CEC@bootlin.com>
Subject: Re: [net-next,v2,5/8] net: macb: add XDP support for gem
Cc: <davem@davemloft.net>, <claudiu.beznea@tuxon.dev>,
 <nicolas.ferre@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>, <lorenzo@kernel.org>,
 <andrew+netdev@lunn.ch>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, "Jakub Kicinski"
 <kuba@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260223182632.1681809-6-pvalerio@redhat.com>
 <20260224000844.140431-1-kuba@kernel.org> <878qcgn0av.fsf@redhat.com>
In-Reply-To: <878qcgn0av.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: 600311B6390
X-Rspamd-Action: no action

Hello Paolo,

On Wed Feb 25, 2026 at 7:30 PM CET, Paolo Valerio wrote:
> On 23 Feb 2026 at 04:08:44 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>>
>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loc=
al.html
>> ---
>> net: macb: add XDP support for gem
>>
>> This patch introduces basic XDP support for the macb/gem driver with
>> XDP_PASS, XDP_DROP, and XDP_REDIRECT verdict support.
>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index 708107e47ae3..26b517ed251c 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
[...]
>>> @@ -2641,21 +2724,23 @@ static int macb_alloc_consistent(struct macb *b=
p)
>>>  	return -ENOMEM;
>>>  }
>>>
>>> -static int gem_create_page_pool(struct macb_queue *queue)
>>> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>>>  {
>>>  	struct page_pool_params pp_params =3D {
>>>  		.order =3D 0,
>>>  		.flags =3D PP_FLAG_DMA_MAP,
>>>  		.pool_size =3D queue->bp->rx_ring_size,
>>>  		.nid =3D NUMA_NO_NODE,
>>> -		.dma_dir =3D DMA_FROM_DEVICE,
>>> +		.dma_dir =3D rcu_access_pointer(queue->bp->prog)
>>> +				? DMA_BIDIRECTIONAL
>>> +				: DMA_FROM_DEVICE,
>>>  		.dev =3D &queue->bp->pdev->dev,
>>>  		.netdev =3D queue->bp->dev,
>>>  		.napi =3D &queue->napi_rx,
>>>  		.max_len =3D PAGE_SIZE,
>>>  	};
>>>  	struct page_pool *pool;
>>> -	int err =3D 0;
>>> +	int err;
>>>
>>>  	/* This can happen in the case of HRESP error.
>>>  	 * Do nothing as page pool is already existing.
>>>  	 */
>>>  	if (queue->page_pool)
>>>  		return err;
>>                        ^^^
>>
>> Does this return an uninitialized value? The patch changed 'int err =3D =
0'
>> to 'int err' without initialization. The early-return path for HRESP err=
or
>> recovery returns err when the page pool already exists.
>>
>
> argh, I missed this patch removing the initialization while rebasing.

I debugged a nasty bug yesterday, which ended up being this typo
combined with the fact that we call gem_init_rings() through the
mog_init_rings function pointer twice at open. Once near the end of
macb_alloc_consistent() and once from macb_open().

This bug is invisible because we supposedly skip the second
gem_create_page_pool() with the queue->page_pool check.

On my system it lead to the "DMA bus error: HRESP not OK" error;
my theory (which I didn't dig into much as the root cause is known):
 - undefined behaviour leading to the compiler skipping the
   `if (queue->page_pool)` condition in gem_create_page_pool()
 - leakage of the old page allocator and the old buffers leading to
   buffer lifetime issues somehow

I still don't understand how we all tolerate -Wno-maybe-uninitialized in
the kernel under GCC. But now that it has been here for a long time
many false positives slipped in, making it harder to re-enable.

https://elixir.bootlin.com/linux/v6.19.3/source/scripts/Makefile.warn#L184-=
L186

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


