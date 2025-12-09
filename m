Return-Path: <netdev+bounces-244081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE5FCAF5FA
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367D53019F40
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3121F63CD;
	Tue,  9 Dec 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dUWuyDIf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB74A0C
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270919; cv=none; b=oh5ouKlqbOdE80IgXNML5ZnqLg4nwLKDbOj6SfSyLXR83tPWBKH9eBgtmBzaSwiaxnZAtvl+BxAr+wmBl2BFR/eWNVCJIqSTYT+aOofGOZfs1T2c1iPv5aKAaO6XLgbkv9XG/+dlA2qx6oF8bSH5r0VFf+xxIIOv2SM+g/yO6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270919; c=relaxed/simple;
	bh=9MKzMErOKe+ynoz4KSwRUfOkGhvx+9B+eGVGwYSudiQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NZWJE2Gjd1BNRBqHZ3nWhxH9mdR+hfMsboBPLH8AEOfyiARXoGUKpCQb2diSt50YHAPcljITpRkt3/g8qxl/vvA8QF7B1lJFXz+6+BAWAGOYHQ2piWWx+UDVy+eUOMHM9fl8ACFzAsWoy4/ZR3sAtZJiorKCqgigiSh7rlrkTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dUWuyDIf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DE6534E41B1B;
	Tue,  9 Dec 2025 09:01:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A0AA3606E2;
	Tue,  9 Dec 2025 09:01:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D07A411930250;
	Tue,  9 Dec 2025 10:01:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765270900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=auXgVkWzE6K5IVy5m07/ZvlWDbyGm+Tg2ilQeF5HwHE=;
	b=dUWuyDIf+EaYOckPrpZYbB3S35bzimaf/bXs9r0bxLCQ1WX6rRjCcozJ1cAxriYm8fYxpV
	I25RswKC3umhh68XSnZczvrr3+Q9f7hJIZ9Ejkk8bK93n3BTAvrYOdxWCjA6PQPtYitHM5
	IBcg9qDuTu5hzFUh5iG27SrF615/tQvK+T1TS9iijcm+b4H6iOZu2rgggU8fnTHekYX++u
	jYlRTdN2KCFI4n9Ja/E3UfJgr5/lPd81eTnXHdTWqOvhJK0Nny4WL+8b2dghcwNsRzPS3a
	ji6zZ+4jC4cmuxIWpssr7gGrJB94XRT63tmNCoA51dVJ/3Ml9pfX+UJX5aEo8g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 10:01:31 +0100
Message-Id: <DETKB07L5M29.W6ES6AZIA9AQ@bootlin.com>
Subject: Re: [PATCH RFC net-next 2/6] cadence: macb/gem: handle
 multi-descriptor frame reception
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-3-pvalerio@redhat.com>
 <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com> <87cy4wzt5x.fsf@redhat.com>
 <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com> <878qfd5e3d.fsf@redhat.com>
In-Reply-To: <878qfd5e3d.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Dec 8, 2025 at 1:53 PM CET, Paolo Valerio wrote:
> On 08 Dec 2025 at 11:21:00 AM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Tue Dec 2, 2025 at 6:32 PM CET, Paolo Valerio wrote:
>>> On 27 Nov 2025 at 02:38:45 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.co=
m> wrote:
>>>> I forgot about it in [PATCH 1/6], but the error handling if
>>>> gem_create_page_pool() fails is odd. We set queue->page_pool to NULL
>>>> and keep on going. Then once opened we'll fail allocating any buffer
>>>> but still be open. Shouldn't we fail the link up operation?
>>>>
>>>> If we want to support this codepath (page pool not allocated), then we
>>>> should unmask Rx interrupts only if alloc succeeded. I don't know if
>>>> we'd want that though.
>>>>
>>>> 	queue_writel(queue, IER, bp->rx_intr_mask | ...);
>>>
>>> Makes sense to fail the link up.
>>> Doesn't this imply to move the page pool creation and refill into
>>> macb_open()?
>>>
>>> I didn't look into it, I'm not sure if this can potentially become a
>>> bigger change.
>>
>> So I looked into it. Indeed buffer alloc should be done at open, doing
>> it at link up (that cannot fail) makes no sense. It is probably
>> historical, because on MACB it is mog_alloc_rx_buffers() that does all
>> the alloc. On GEM it only does the ring buffer but not each individual
>> slot buffer, which is done by ->mog_init_rings() / gem_rx_refill().
>>
>> I am linking a patch that applies before your series. Then the rebase
>> conflict resolution is pretty simple, and the gem_create_page_pool()
>> function should be adapted something like:
>
> Th=C3=A9o, thanks for looking into this. I was pretty much working on
> something similar for my next respin.
>
> Do you prefer to post the patch separately, or are you ok if I pick this
> up and send it on your behalf as part of this set?

You can pick it up if you agree with the patch; it'll avoid series
dependencies which is annoying to deal with for everyone.

Thanks Paolo,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


