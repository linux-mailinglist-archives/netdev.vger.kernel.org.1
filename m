Return-Path: <netdev+bounces-269045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NRaDzW7umk4bQIAu9opvQ
	(envelope-from <netdev+bounces-269045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F512BD7EC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C6903077A98
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F243DDDAB;
	Wed, 18 Mar 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VhW6SryZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDF3DC4BB
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844402; cv=none; b=IgNP7Vl/ka/0/XOFFqgSVgkvYOigbin9E5/vCi6aEdNXpUFcGfBjS/hD+Idqcgey8ubaAKb7mtaj50m0WDVHJV0l5q6+EsiXhXjGyXLYQ7r2jVE15MPDln1tDET8JHbQi8zEbuii9i6B3nGHAsU1WProewrrGCvYBKXPBqHP/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844402; c=relaxed/simple;
	bh=B+G/+mc9BswZ55CtM2PkkUejKc7fB3wrSEr0aRNwtQw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=uzqFcm/aLQ+TBm2O9QHzq6pjo4OSTup43YG+Y0ZuMYe0BC9abw3UOkurt+HpppJlN+D12YSBgNc0QJ+QGz8qbOSF7jLd9b1VstV+tPcu0GwtNllnanqVuC1fMCKXNVFrOhLJXim2DcsJvgl1PB7ETecHYI/nomx+4P19vy55/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VhW6SryZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F6FEC5506B;
	Wed, 18 Mar 2026 14:33:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B21396004F;
	Wed, 18 Mar 2026 14:33:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EC56104503A7;
	Wed, 18 Mar 2026 15:33:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773844390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dUunwxg0592PBm4F372zFsbuIss49BvyTs/ToS1elL4=;
	b=VhW6SryZ3FxcwOaTK/cLPyfPNde3QXwOD5XCHvWYq4mD5Rj5xoriAxPnA2o17M1XFUPCHK
	S2aRsW9rSOGySQagyM2OqmDvWXmqJgt75l2bGe2n9qSSsQoAkqnIvNcr7NN9VuKKwxR7dc
	FRCM/ryAzHoDg3qy3jYVCHYM8rwisg3VfG7fGzIb/SnelnFtsv9ESlCVy6GiFFW0W6M3de
	xv38caPnmLO6/YrkSdkmXIl92mAXF21ysbPwIWliAu0YWMQHDJcv74mhgU0DGgwkRRUe/f
	PMg8h5f+gN8rpUau7gnqOPlpRbN1mnoqeyDS0A/txsGe/ZIVpQ7CsjJqLMJJRA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 15:33:03 +0100
Message-Id: <DH5ZCS22J6AR.N95U8CLSHOYP@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Cc: "Jakub Kicinski" <kuba@kernel.org>, <nicolas.ferre@microchip.com>,
 <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260316092720.39198-1-nb@tipi-net.de>
 <DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
 <20260317152330.32998fdd@kernel.org>
 <1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
 <20260317162303.4065e307@kernel.org>
 <DH5TETVK34CG.V7P9P9Z1AAKL@bootlin.com>
 <46380e79a62bfca31a551cfd872e34ab@tipi-net.de>
In-Reply-To: <46380e79a62bfca31a551cfd872e34ab@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269045-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gnu.org:url,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: 63F512BD7EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Mar 18, 2026 at 12:25 PM CET, Nicolai Buchwitz wrote:
> On 18.3.2026 10:53, Th=C3=A9o Lebrun wrote:
>>> Hm, not really. Take a look at fbnic_set_ringparam()
>>> You need some struct that's config + pointers to all the resources.
>>> And make all allocation helpers operate on that without touching the=20
>>> HW.
>>> Then you can just allocate a new struct, give it whatever config you
>>> need, call all the alloc helpers with it. Now you have a fully
>>> populated struct and haven't touched the HW yet at all. Stop HW,
>>> swap the resources, start HW.
>>>=20
>>> I did something similar for the nfp driver but that code has been
>>> slightly adulterated since I left Netronome so fbnic is clearer :)
>>=20
>> Do you feel we should (1) clone the full `struct macb` as done by fbnic
>> or, (2) just partially, with the few interesting fields. Something like
>> `struct stmmac_dma_conf`.
>>=20
>> stmmac is not the greatest example. They have this struct that carries
>> their buffers but they still "close -> update -> open" on operations
>> versus the optimal "alloc -> reconfigure_hw -> free".
>>=20
>> With #2 we could use an unnamed structure field.
>> https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html
>> See commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
>>=20
>> struct macb_buffers {
>> 	struct macb_queue queues[N];
>> 	...
>> };
>>=20
>> struct macb {
>> 	struct macb_buffers;
>> 	...
>> };
>>=20
>> Goal is to keep `bp->queues` & co as before, to minimise the diff.
>
> The unnamed struct idea is nice for keeping the diff small, but I'm not
> sure it works cleanly for the per-queue case. The macb_queue_ring fields
> would be embedded anonymously in macb_queue, but the alloc helpers need
> to write into a separate clone. The swap then becomes memcpy/cast tricks
> between the anonymous portion of each queue and the clone's qring[q].
>
> Embedding the full queues[] array in the swappable struct would be
> simpler for the swap, but then NAPI, IRQs, spinlocks etc. travel
> along, which we don't want.
>
> For struct macb itself (rx_buffer_size, ring sizes, tieoff) the unnamed
> struct works fine and saves a lot of churn. It's really the per-queue
> ring fields where it gets awkward.

Agreed; we want to avoid swapping the whole of `struct macb_queue`
which carries too much weight and includes some pointers we registered
to other subsystems.

We can make it an unnamed field on a per-queue basis, with a union to
allow swapping. The usage of `bp->queues` stays the same with this.

struct macb_queue_resources {
	struct macb_dma_desc	*tx_ring;
	struct macb_tx_buff	*tx_buff;
	/* ... */
};

struct macb_queue {
	/* easy usage `q->tx_ring` and
	 * easy swap `q->resources =3D ...`
	 */
	union {
		struct macb_queue_resources;
		struct macb_queue_resources resources;
	};
	/* ... */
};

struct macb_resources {
	size_t rx_buffer_size;
};

struct macb {
	struct macb_queue queues[MACB_MAX_QUEUES];
	/* easy usage `bp->rx_buffer_size` and
	 * easy swap `bp->resources =3D ...`
	 */
	union {
		struct macb_resources;
		struct macb_resources resources;
	};
	/* ... */
}

// however now the swap is not a single expression like:
bp->resources =3D ...;

// but instead:
bp->resources =3D ...;
for (i =3D 0; i < n; i++)
	bp->queues[i].resources =3D ...;

If I get an ack on the concept I can attempt an RFC. It would probably
find its use in XDP/XSK as well.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


