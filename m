Return-Path: <netdev+bounces-243996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197FCACEEA
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE7923005001
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9362566D3;
	Mon,  8 Dec 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lLJnv7Qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0352192F5
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191573; cv=none; b=RHZpRa8D+r66ckf0zcxCv4EmjhN6322dvNUT6effg9hsduNl21vyYgah+1xr08XznBkebMcOpBR/pGHATP8Rqnnu4F6likVEcE1ndd1Gh80moBG1244vznAcy/UK6yWDvJD0aVZfb2z0T0ishNTJGzM2nS83Y4y9sbs29xWaFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191573; c=relaxed/simple;
	bh=Szaw0wA3dn0+kiAQp1Qs2XqtNe9dNjlvVsSedZ1nwGQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aqetbCuyl9MhyauZIEouQm3nkLUrnq7AWmdl7jDMT9H4KEoOh7r/V+QhPlmc7EIUBd/FHJyECdjaFCHX9rz9EMJbKMNYUOsBNWUbP6B3iBZ+x5jNS2BLUt+Ps1DEDmTD/6JwAYRedHCn2ItgwsVUCYT2d2FHUI+yKW2ksd3CWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lLJnv7Qj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F10DBC180C6;
	Mon,  8 Dec 2025 10:59:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4C5160707;
	Mon,  8 Dec 2025 10:59:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD052102F2491;
	Mon,  8 Dec 2025 11:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765191567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IvNcd6lJzbUXM/Ne1Sxvld3QtNqcpI6lsl/gj1vAdyw=;
	b=lLJnv7QjTRg76rb6W+ujlfXTxgqRvI147dcHXoGJudeKdm6ZIUP77CU1G+2Yhcg6u8OHPM
	4QsrTI0o3cxvsg6wwBUgFHUY88L4xQf7mfpQTZQr60ZFZ18Yx/+Gh/Mb2ryntI9qQyfred
	81Ur0dpCQksGXwX5kM3mF+WOUkDAQHM74E5BeeHDzt31APV0QN2ukxFCvtRkKsWXBcx6iQ
	6XhoNzaYUZ0zvyievWN0TaPOf77AlssK+GKD8eqkyROZUZMGXxQTwSKlmUwrkzj9prVz5s
	pLblzpbN87tr4RIa+SKwSGVGT+qpiGJo7wFMteiquBo2vwEgSvTb7c3hNPz8fw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Dec 2025 11:59:23 +0100
Message-Id: <DESS6PMQCC80.L2KUOYYDCWQW@bootlin.com>
Subject: Re: [PATCH RFC net-next 4/6] cadence: macb/gem: add XDP support for
 gem
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-5-pvalerio@redhat.com>
 <DEJK1461002Y.TQON2T91OS6B@bootlin.com> <87bjkgzt52.fsf@redhat.com>
In-Reply-To: <87bjkgzt52.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Dec 2, 2025 at 6:32 PM CET, Paolo Valerio wrote:
> On 27 Nov 2025 at 03:41:56 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index 5829c1f773dd..53ea1958b8e4 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> +static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
>>> +		       struct net_device *dev)

[...]

>>> +{
>>> +	struct bpf_prog *prog;
>>> +	u32 act =3D XDP_PASS;
>>> +
>>> +	rcu_read_lock();
>>> +
>>> +	prog =3D rcu_dereference(queue->bp->prog);
>>> +	if (!prog)
>>> +		goto out;
>>> +
>>> +	act =3D bpf_prog_run_xdp(prog, xdp);
>>> +	switch (act) {
>>> +	case XDP_PASS:
>>> +		goto out;
>>> +	case XDP_REDIRECT:
>>> +		if (unlikely(xdp_do_redirect(dev, xdp, prog))) {
>>> +			act =3D XDP_DROP;
>>> +			break;
>>> +		}
>>> +		goto out;
>>
>> Why the `unlikely()`?
>
> just expecting the err path to be the exception, although this is not
> consistend with the XDP_TX path.
> Do you prefer to remove it?

No we can keep it, I had missed this was the error case.
Sorry about that.

>
>>> +	default:
>>> +		bpf_warn_invalid_xdp_action(dev, prog, act);
>>> +		fallthrough;
>>> +	case XDP_ABORTED:
>>> +		trace_xdp_exception(dev, prog, act);
>>> +		fallthrough;
>>> +	case XDP_DROP:
>>> +		break;
>>> +	}
>>> +
>>> +	page_pool_put_full_page(queue->page_pool,
>>> +				virt_to_head_page(xdp->data), true);
>>
>> Maybe move that to the XDP_DROP, it is the only `break` in the above
>> switch statement. It will be used by the default and XDP_ABORTED cases
>> through fallthrough. We can avoid the out label and its two gotos that
>> way.
>
> We'd not put to page pool in case the redirect fails or am I missing
> something?

Ah yes there are two break statements. I missed it.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


