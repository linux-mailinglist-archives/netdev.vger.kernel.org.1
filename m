Return-Path: <netdev+bounces-230883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D239BF0F73
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1019318A3B97
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426F30FC06;
	Mon, 20 Oct 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cf7dvSYh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BF304BA6;
	Mon, 20 Oct 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961541; cv=none; b=EHrYlMRw5HZJFYrMWw9Sch3z8U3kftnKgFVARYXE5PJOIRDN0QyYsybq/d98kWsbhmthSnrNfKyMk1DfuI0Kj2qeoVsXetnFbkpSErNtSf6NvN96CGy9AgU1Is6p1Zlw/2XX/e1qbvko5LFgqdhKHLC2Tu06SHcqCwlGzSq8eIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961541; c=relaxed/simple;
	bh=twDF9OguaUJ2De+Kad9iwRfsXW9uLjYealqHeC1163c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tcb9vHcpEpVC4+6K+49RRFHMD3B8dMpKNJRSSGGw+K8k7rJTfwnIsuAjVhMbu/UH82wlE7qDky2N8oibvak0qjiI7C2fz3wZg+H0IIQ3uqLlnwsBLLfUjbbbYvg/GH14WaLmc8sKb0RptWrHfQjHVt6lWFS5hs8O4PYt8jItQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cf7dvSYh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D5E81C0AFD7;
	Mon, 20 Oct 2025 11:58:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 576C7606D5;
	Mon, 20 Oct 2025 11:58:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4070102F2303;
	Mon, 20 Oct 2025 13:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760961535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+oTJtOzmO5MoG1vTfvH4VMt8dt9j6XcomPhTobdBBrw=;
	b=Cf7dvSYhSPPGCQtaDH/kArAbpv6iVQrLAZpoS/I53TZdgik8dxFC4VE12dOqsqAp9WA8Ed
	ITdeZ1QBV1wIISggBWfePNz0F+lK3bdQe7qBLWyBKO092dWw1mazGwNt74ia1QbBzaMfQp
	Ue5ST2TYfrWWYFDFBEnxxyG94XtIUzD0VPiuCZlbkvWnrl6iigMiF0FQvUiH4l5A9/09yg
	IWyFpxZzCzK4WYuP9Gx/lK7vk5lRs/P3ikfJf0bnXBMagwhgIXNXL7lPxS60Fymuw/YjQM
	MxvLco4azF+aL3bbdbkHhMquMaCVQjUWubMB55FhA3vafQS3pV+XsTc1/NGIdA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 13:58:49 +0200
Message-Id: <DDN4RIQJDP38.DTL27ATUDSYA@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 07/15] net: macb: simplify
 macb_adj_dma_desc_idx()
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Andrew Lunn" <andrew@lunn.ch>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-7-31cd266e22cd@bootlin.com>
 <3a36ff13-893d-429f-b46e-ade24836d27a@lunn.ch>
In-Reply-To: <3a36ff13-893d-429f-b46e-ade24836d27a@lunn.ch>
X-Last-TLS-Session-Version: TLSv1.3

Hello Andrew,

On Fri Oct 17, 2025 at 8:00 PM CEST, Andrew Lunn wrote:
> On Tue, Oct 14, 2025 at 05:25:08PM +0200, Th=C3=A9o Lebrun wrote:
>> The function body uses a switch statement on bp->hw_dma_cap and handles
>> its four possible values: 0, is_64b, is_ptp, is_64b && is_ptp.
>>=20
>> Instead, refactor by noticing that the return value is:
>>    desc_size * MULT
>> with MULT =3D 3 if is_64b && is_ptp,
>>             2 if is_64b || is_ptp,
>>             1 otherwise.
>>=20
>> MULT can be expressed as:
>>    1 + is_64b + is_ptp
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 7f74e280a3351ee7f961ff5ecd9550470b2e68eb..44a411662786ca4f309d6f93=
89b0d36819fc40ad 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -136,19 +136,13 @@ static unsigned int macb_dma_desc_get_size(struct =
macb *bp)
>>  static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int=
 desc_idx)
>>  {
>>  #ifdef MACB_EXT_DESC
>> -	switch (bp->hw_dma_cap) {
>> -	case HW_DMA_CAP_64B:
>> -	case HW_DMA_CAP_PTP:
>> -		desc_idx <<=3D 1;
>> -		break;
>> -	case HW_DMA_CAP_64B_PTP:
>
> I _think_ this makes HW_DMA_CAP_64B_PTP unused and it can be removed?

It does indeed. That constant gets removed in the following patch
([08/15], "net: macb: move bp->hw_dma_cap flags to bp->caps").
It  appeared to make more sense to remove all HW_DMA_CAP_* at once.
You probably noticed as you continued your review.

Thanks for the review! I guess you have spotted that the series got
applied to netdev/net-next by Jakub [0].

[0]: https://lore.kernel.org/lkml/176066582948.1978978.752807229943547484.g=
it-patchwork-notify@kernel.org/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


