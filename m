Return-Path: <netdev+bounces-261040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAPiBXs0n2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6A19BB47
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA5ED300C002
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049C3D6674;
	Wed, 25 Feb 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z809eauC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8D3D1CBB
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041336; cv=none; b=OozlFZUueGyX8kaLXo7e5773hqWZp9EaekMvhLFlZ9iTCrE92rYthZ5qurO0hgvR2Y2EUyh8ojZOfI9U6qN84zkzyZdQKmm0p0DZSSshuFZL098pZWnpGldrUu+FmqnZvS9fV0vZd64X+Za10mROOTKyBPKNIZw6mdT7ELFvN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041336; c=relaxed/simple;
	bh=xzrEVWd6VkI2RRxct2Zx/+mUbX1Dsh5R3vgl8pEOChU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jCa4RZHdd5ToYfGa60QreHIDCb+RmbX6pJr541gFN8A+mDMRC6R1IrFuEG89xcTkD2KJq05e98VjD7iohvyIcn5dcPVyfkC7FTSAvTtdwaYc6jTyEt9vlu+jdDecRaNIZK+tx5MOGKOd2n+EiKKPgJNts5TFtwRF+WRStRrz9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z809eauC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 60ACE1A12ED;
	Wed, 25 Feb 2026 17:42:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 233535FDE6;
	Wed, 25 Feb 2026 17:42:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AB9710368CA9;
	Wed, 25 Feb 2026 18:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772041332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8ehkN9gRCcAmYKz588331O0LBZbMErU/m5PmKWIZd4w=;
	b=Z809eauCeTJn7rYtjz9XlLdUHAkEZLJBBM0T+x/Fiq4SQMq5XcFPRlS8JiGbqp4bz6/w6Y
	RTpW74V5lqiCNR7+/yBzBg+N7NuWGDQmH/f+QcFZq5IPHXlJIw3eogq4a/lwADc+X9fQDy
	WrFIBUx0SougUpUNTzV2aZ3F/zkSAPKdJOPSQ6XnFGVx3O/wgcrv8FCjNo6cL4q5AJ8kGs
	asz4giS/qdOEC54EXcs5Gg/lrRBotDx9bibLJN+Wb9HvS9rXpLsoQ/2acfipYMfchRt4eu
	W5RdO82LdjGvISm6BKkFa5ELjWjPHkwlhGCuqwSSrLCqm4XAPxQrCjJkUISaPA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 18:42:08 +0100
Message-Id: <DGO88446M74S.6C1O0I79IM0E@bootlin.com>
Cc: <andrew+netdev@lunn.ch>, <claudiu.beznea@tuxon.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <nicolas.ferre@microchip.com>, <pabeni@redhat.com>,
 <linux@armlinux.org.uk>, <phil@raspberrypi.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
In-Reply-To: <20260225091558.51157-4-nb@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261040-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2D6A19BB47
X-Rspamd-Action: no action

On Wed Feb 25, 2026 at 10:15 AM CET, Nicolai Buchwitz wrote:
> Implement Energy Efficient Ethernet TX Low Power Idle using phylink's
> managed EEE framework. The Cadence GEM MAC has no built-in idle timer
> =E2=80=94 TXLPIEN (NCR bit 19) immediately blocks all TX when set and the=
 MAC
> does NOT auto-wake =E2=80=94 so the driver uses a software delayed_work t=
imer
> for idle detection.
>
> The TX LPI lifecycle:
>   - phylink calls mac_enable_tx_lpi() after link-up with the negotiated
>     timer value. The driver defers the first LPI entry by 1 second per
>     IEEE 802.3az section 22.7a.
>   - macb_tx_complete() reschedules the idle timer after each TX drain.
>   - macb_start_xmit() wakes from LPI by clearing TXLPIEN, cancelling
>     the pending work, and waiting 50us (conservative Tw_sys) before
>     initiating the transmit.
>   - phylink calls mac_disable_tx_lpi() before link-down, which cancels
>     the work and clears TXLPIEN.
>
> The phylink_config is populated with LPI capabilities (MII, GMII, RGMII
> modes; 100FD and 1000FD speeds) and a 250ms default idle timer, gated
> on MACB_CAPS_EEE.
>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   5 +
>  drivers/net/ethernet/cadence/macb_main.c | 111 +++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 43cd013bb70e..a9ae7ecf9fe9 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[...]

> +/* Wake from LPI before transmitting. The MAC must deassert TXLPIEN
> + * and wait for the PHY to exit LPI before any frame can be sent.
> + * IEEE 802.3az Tw_sys is ~17us for 1000BASE-T, ~30us for 100BASE-TX;
> + * we use a conservative 50us.
> + */
> +static void macb_tx_lpi_wake(struct macb *bp)
> +{
> +	if (!macb_tx_lpi_set(bp, false))
> +		return;
> +
> +	cancel_delayed_work(&bp->tx_lpi_work);
> +	udelay(50);
> +}

[...]

> @@ -2349,6 +2454,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  	netdev_tx_sent_queue(netdev_get_tx_queue(bp->dev, queue_index),
>  			     skb->len);
> =20
> +	macb_tx_lpi_wake(bp);

Should this be protected by a bp->eee_active condition? It could go
in macb_tx_lpi_wake(). We avoid a spinlock acquire per xmit for most
platforms. Probably negligeable though.

For the full series:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


