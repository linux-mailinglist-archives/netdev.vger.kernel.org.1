Return-Path: <netdev+bounces-249410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06404D18118
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EA2D3002177
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683030EF62;
	Tue, 13 Jan 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aodyyGCH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B882BE04C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300520; cv=none; b=tPR0P7IX06CyCBEHbEGBlAhGc8HOikBqFUa/N0o64GFs3G4zB5fp1FqCiX4F8ZrqLnBqz5eAEk5bdlN/eR72hfBq4ONdbNoVawvv7jSlx2WapDlJbeKOR9Q6tQED9gl+a2Qud6umwgt37Fe+Jmn1cCWXztIwG34NhZ89oCAL7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300520; c=relaxed/simple;
	bh=09Gs4odd/rtvn94Ew0LgnEIIw7A/loKNXXv4VArUb+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KwAlU692pv6p0j7ys3LPwYUGy2yXChZKf2iA5bAWQhRgWVOHEW+GGO2n4oUjLYV8SoC11YnW8g3LofFvqs8qyInO/X467st1MJV3x143gQeV+PtjMzYhaw1J1JOnpxnzNpVW10uhN8Q2YtiJXMIrF2YJKTDSOidPxsZ40F6mwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aodyyGCH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 888EAC2087B;
	Tue, 13 Jan 2026 10:34:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B68160732;
	Tue, 13 Jan 2026 10:35:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D404103C930C;
	Tue, 13 Jan 2026 11:35:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768300514; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PazMdjDxcBGmE2Y9Sh6VQc8HEOqaMALDr33jd/H6Es0=;
	b=aodyyGCHArSmqZA4hWkCpNZAUq1haeWRhrTWivjL0e7sHXcBRAE4JOS8iBRxNRLdkjvckJ
	XSQJ4k38zTbEp+H30lIoP317wSrNDBx637IVZy3MPpMORVlsuh7loLJZ8Ua6HgHNJXxki3
	tZ2+9N3ZZcxrWmptTqBez9TW1J1R3CVNTHTGcSG3b4qveAhSxtvBWPpFyXczGccIQfgIRa
	e50nqGHNozGnJ2tlJnZn99Poe/GQ+KXfTo4jFdoeHTbqS71yvcXc45jF9We58a81m+a2sK
	0abVoIX1IKH6CWDwPLJFbhXqABsFc5cSOmxit6Ni2DRZQdZJvb3rfQ4iXmMW5Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 11:35:09 +0100
Message-Id: <DFNE7RIDJY1D.EON8I6D22R5@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool
 support handle multi-descriptor frame rx
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Gregory Clement"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
 <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com> <87jyxmor0n.fsf@redhat.com>
 <87344ahdtp.fsf@redhat.com>
In-Reply-To: <87344ahdtp.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jan 12, 2026 at 7:43 PM CET, Paolo Valerio wrote:
> On 12 Jan 2026 at 03:16:24 PM, Paolo Valerio <pvalerio@redhat.com> wrote:
>> On 08 Jan 2026 at 04:43:43 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com=
> wrote:
>>> nit: while in macb_init_rx_buffer_size(), can you tweak the debug line
>>> from mtu & rx_buffer_size to also have rx_headroom and total? So that
>>> we have everything available to understand what is going on buffer size
>>> wise. Something like:
>>>
>>> -       netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
>>> -                  bp->dev->mtu, bp->rx_buffer_size);
>>> +       netdev_info(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroom=
 [%zu] total [%u]\n",
>>> +                   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
>>> +                   gem_total_rx_buffer_size(bp));
>
> I missed this before:
> I assume so, but just checking, is the promotion from dbg to info also
> wanted?

Ah no it was a mistake. I was lazy during my testing: rather than
`#define DEBUG` I changed netdev_dbg() to netdev_info().

I wouldn't mind but that isn't the usual kernel policy wrt to logs.
A working driver should be silent.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


