Return-Path: <netdev+bounces-243997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F6CACF06
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 423D2301596F
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12C2E7F38;
	Mon,  8 Dec 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qETfT/hR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83827FD6D
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765191676; cv=none; b=Jh8L1FMw429gJsQ4Ve69FUFwW90QgjREXO/7ydabh5QqzAlWVodhReDdMiq7FTeC6qlauQpuCiNIDeoN2/nByQq+8IqD+QKqzcx7yxp20HXUIfDhwsia8Wr4CHU/E2rNQSG4KfX32MVInB1fR3HbmCQc+Dm+ecXVGu2gLDL0/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765191676; c=relaxed/simple;
	bh=EWvc/einq7wa+8KFcyYFG7vM0xXZ/r4YrcAcJeNuWXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qZ4KKMRmsM4aoRazULAI44jIo0OtqUZhbt1ncE2PX5Z3w+6kfZAvxJ/z6arA7tTdlE0hNS+ZR9zDZ+oLcuZBDvSUdqsXtNevjxyCQUky0wOfCvwpXv3hd1AA+uzIiqSzDuJEH99g+pTkyTInNKt7bwi6Otm+TP7LNkhY0UJ25Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qETfT/hR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8A7F51A201C;
	Mon,  8 Dec 2025 11:01:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FB8F60707;
	Mon,  8 Dec 2025 11:01:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13A5E102F2491;
	Mon,  8 Dec 2025 12:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765191671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1zSah42/+YBihZaesWiQlClaUtuFRhwxCPiH/P5SAPs=;
	b=qETfT/hRZCegAxFoIyaCwbi6mvPDiMcRPtCo0j1YtbKqvmGT7MfIGuuugHfUllVwu5i0Lu
	naggpITgksDRbigMPkixqw+6cwehSlZYE9cqJ9U07oh2XkTkA6d1QmUo08GwPdGErhVHov
	lEEDfI6MVwm359wQJEeH42mUJJ43X24gNL283AVBqUUtLuzYcCsWfKxeC0iQvaK8npnuQ6
	/6ptz26EeoDnhZW50/gdRhg47l788bihnV2Ik5d+mVNv0xXjwcOstsFkQSNwRO1CcvT8z1
	lH2cuXPLrxtTBhJXk6YcgAAoUtRsFYKEqNZTjfDQbJIl58qKiC4tos1cwDwevg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Dec 2025 12:01:09 +0100
Message-Id: <DESS825O67J6.1XU39G8BM2YEJ@bootlin.com>
Subject: Re: [PATCH RFC net-next 6/6] cadence: macb/gem: introduce xmit
 support
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-7-pvalerio@redhat.com>
 <DEJKKYXTM4TH.2MK2CNLW7L5D3@bootlin.com> <878qfkzt2h.fsf@redhat.com>
In-Reply-To: <878qfkzt2h.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue Dec 2, 2025 at 6:34 PM CET, Paolo Valerio wrote:
> On 27 Nov 2025 at 04:07:52 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index eeda1a3871a6..bd62d3febeb1 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> +static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xd=
pf,
>>> +				 struct net_device *dev, dma_addr_t addr)
>>> +{
>>> +	enum macb_tx_buff_type buff_type;
>>> +	struct macb_tx_buff *tx_buff;
>>> +	int cpu =3D smp_processor_id();
>>> +	struct macb_dma_desc *desc;
>>> +	struct macb_queue *queue;
>>> +	unsigned long flags;
>>> +	dma_addr_t mapping;
>>> +	u16 queue_index;
>>> +	int err =3D 0;
>>> +	u32 ctrl;
>>> +
>>> +	queue_index =3D cpu % bp->num_queues;
>>> +	queue =3D &bp->queues[queue_index];
>>> +	buff_type =3D !addr ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
>>
>> I am not the biggest fan of piggy-backing on !!addr to know which
>> codepath called us. If the macb_xdp_submit_frame() call in gem_xdp_run()
>> ever gives an addr=3D0 coming from macb_get_addr(bp, desc), then we will
>> be submitting NDO typed frames and creating additional DMA mappings
>> which would be a really hard to debug bug.
>
> I guess we can add a separate boolean, WDYT?

I agree!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


