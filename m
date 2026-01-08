Return-Path: <netdev+bounces-248138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9098D042F2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AC47305A2CA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C8261B80;
	Thu,  8 Jan 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ePrbtzKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9A2620D2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887662; cv=none; b=t//+/DhBORaCt/z1fjS3/UhzLw2PGvzF/3QLXkz2NCFOScGtjQGGefgV55XF1IdHW7+JVIbqyw8TGnFYcYcyCxak7/L1l0mlExb1mzt7rFnwdyyEHkcTBM6vmmd0ujQZQ0gX5T3TBd5DnWQR1me7Ye8svdTGbemnxJ0b4VSAe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887662; c=relaxed/simple;
	bh=Ebf9ED4E2DrYDUeb5/Z3l+FqEQuAjHWRa1ZEjzvJbro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dJr7AR8TEktjx+SDnZx5b/39AnLLSdfNU5h3xdXQrS12b2RDvYfW53Xca/maUlZ1VDxlddQ+QaOkjV/nysf8MsMS+vDKV/GIcJnwVeUez4baNZowHKlCk5lA6Z112MKMd+6/dd/DQEgOWgz9/9jDzt/7UNmgufVIqw//ftbIMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ePrbtzKi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7AA601A2715;
	Thu,  8 Jan 2026 15:54:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D6FB6072B;
	Thu,  8 Jan 2026 15:54:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26423103C88AD;
	Thu,  8 Jan 2026 16:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767887656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oNfdH53kQuTuXNIKre/qRSoBoNj+epfNl5b+1DiEuPI=;
	b=ePrbtzKiiZ/g2cIR7eGmilTYBEtczpPaW7zs4DbwGItBcJfrI7nHVlQDcRjIiNYVJOOuLr
	oNL1+3M2AiTYN/OxZ3UnKQ1nFVJKb8yPR50wvd/iaSA93B56LpW1I7SXoGlr3PHwr6CDx8
	WKxU76bug5mPPPc0kzFZaNXK6YDnbKXbZvKEf5ueip9KjgJjuoAbok6shzeYbvfvV3H5ph
	256MBTzcIhqEdIltFHSbV81PVZse2ZVzk+aaE3/64rjhJp0SQ1Ktb6xN3p/tgbqEXLuitV
	HpaNFEYp1MVwH3rLmtz57EHRAP97o8m44JzPaBYa0tKOz06Aoiwl0BkNIHnodQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 16:54:14 +0100
Message-Id: <DFJBVCNFR0ZE.2ZIJ3RYVOMQP1@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 8/8] cadence: macb: introduce xmit
 support
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-9-pvalerio@redhat.com>
In-Reply-To: <20251220235135.1078587-9-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
> Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
> redirection, and update macb_tx_unmap() to handle both skbs and xdp
> frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
> to process XDP_TX verdicts.
>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
>  1 file changed, 158 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index cd29a80d1dbb..d8abfa45e22d 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> +static int
> +gem_xdp_xmit(struct net_device *dev, int num_frame,
> +	     struct xdp_frame **frames, u32 flags)
> +{

nit: a bit surprised by the first line break in the function header.
Especially as it doesn't prevent splitting arguments across two lines.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


