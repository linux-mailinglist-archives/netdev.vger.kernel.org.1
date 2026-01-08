Return-Path: <netdev+bounces-248127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4291D041B9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2577D30C5179
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF9328B6E;
	Thu,  8 Jan 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EJkuhDM8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D222424E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885882; cv=none; b=hXBOxDMrHKmFwsliJI5f6sMhdwywiJ+Yja4yUsAUXc+JreuDkzc2BwZ2tiT9FJe6ssD++eSamQaDUSPoTWh2OmF0OVu1T6S9ykSY9FTolXEGn82wIfXlsbMQlRLAyyONjjz6dEuCFFNythUzsDAHXwyFFhLEgQMSsbCuM63fNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885882; c=relaxed/simple;
	bh=se7mjTrEljDa5+xJptV2C6dIFdLvtjzl3IzTbjxdV2Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=igdju1whIzHR2DyVznVpDMsKme6WS2f7OH0zP7dlnLo33G8lj00UrtfRBaMuOWxqjCljUSBzrOWjCkX852IBZV38BfTSYlGrFMXBzfLH0jv62uBYWxPSzZgFl1IXsIs2a9/PtnrmIqVfeJVzaezAqdf2ellsWRi3cQKxqZ2O8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EJkuhDM8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB792C1ECB4;
	Thu,  8 Jan 2026 15:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA767606B6;
	Thu,  8 Jan 2026 15:24:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EC3D103C889B;
	Thu,  8 Jan 2026 16:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767885876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q2L7agkPWdUdZsOD1rRtCCHaHCmFCKB7oA88Pha1Tb0=;
	b=EJkuhDM8l2x72dF88nadNboT+6Vb4TJTVyCSS+birec3IHH+uO2j/yCCS8xIV0L7S/WKui
	+Xe8tlDxozuKSJPwwJEGvYxQ7cmas9t1ipdMljT6C9g9sKmLJspi1jZekY4zCKwcVC4Eur
	+NMgRKx8UwHkAUNRChBfowmrTq/XlLvBJEyVpjUbE+1cFrdUixGo23f5Xpe6q2ivoHQCxj
	7ivO6fbveoZrL5dMaVd9crG1VDRKtTZr14lVMSFR8lEZF643kbAafPN2TwK7rKZtrHG/R3
	2Lb6CgwJtbo+ZdBOK5keYgY2zugLMFitHMCORs7NJC5ttTLymwXVxW/kysyMMA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 16:24:32 +0100
Message-Id: <DFJB8LYO40ZD.394UQ8NLOQ9WP@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 1/8] net: macb: move Rx buffers alloc
 from link up to open
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-2-pvalerio@redhat.com>
In-Reply-To: <20251220235135.1078587-2-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo,

Nothing major in this review. Mostly nits.

On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
> From: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
> alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
> up all slots with valid buffers.
>
> gem_rx_refill() is called at link up by
> gem_init_rings() =3D=3D bp->macbgem_ops.mog_init_rings().
>
> Move operation to macb_open(), mostly to allow it to fail early and
> loudly rather than init the device with Rx mostly broken.
>
> About `bool fail_early`:
>  - When called from macb_open(), ring init fails as soon as a queue
>    cannot be refilled.
>  - When called from macb_hresp_error_task(), we do our best to reinit
>    the device: we still iterate over all queues and try refilling all
>    even if a previous queue failed.

About [PATCH 1/8], it conflicts with a patch that landed on v6.19-rc4:
99537d5c476c ("net: macb: Relocate mog_init_rings() callback from
macb_mac_link_up() to macb_open()").

I don't get a merge conflict but the
   bp->macbgem_ops.mog_init_rings(bp);
call must be dropped from macb_open() in [1/8]. It doesn't build anyway
because that call passes a single argument.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


