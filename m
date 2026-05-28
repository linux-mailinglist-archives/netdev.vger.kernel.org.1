Return-Path: <netdev+bounces-292571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +/fXMXvsF2p8VwgAu9opvQ
	(envelope-from <netdev+bounces-292571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D25ED96C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F04453010BE8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F23195E4;
	Thu, 28 May 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="MckCByxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068062F691F;
	Thu, 28 May 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952759; cv=none; b=TrzfnG1Gl1xoNVzB62OiHti2MsYF+sF4AIfj7ps/xFbzkrKlpWgwloXmmqR/91r620eq5YGUh86nVhN+kwq63G1bDtlhRpEcXVy0jFgILjVNA5GcC3wciDVEVgei9XCwu6fptDwNKvXcLCGmwylfVD85EtaOBB7YJOyzpJSOmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952759; c=relaxed/simple;
	bh=boRg/gV4Z2pel+y5ceTw2ESCXgSC24QIp1dhRJ2mHd4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OEWgFr7Ib6SQXJCO0GQ3KBuYbTljaVyMBIhJWn3hnJR/2tKL8CiurFaxdpN/lxT6kOBQGp9MrSe4a5fjOvF0H58hWAIg5ab5DTE6KhnAzezyNTkZBEXBaE3BTO6kGTtQhGiPuIlQOkRz0O4QOhF/qUQhHOlscJlJc0/ry7iymyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=MckCByxa; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB2F6A0968;
	Thu, 28 May 2026 09:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779952746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AJ0jI1SKQMhpjLbBvZP5pomHZtdu2l1lzwGYvInLGx8=;
	b=MckCByxaCvEsEKXISvbzIXos3ONaGKAGEhcNVaC5W5WM5XRucQZK6SlgMIsmanFUOntOcN
	XI+64PiSv16MDK3jAdn4zjldEO9m2FnWQPEau1wj5JGopMTxZgkSF3VQXbnwz/KfDGvlhR
	mudcXAaBpuRoKkUGvTp6fLV7EPjJdRhuTzdDbgWqIE2Eu8mTEyaa/5DH9n8euNCuCR/nPq
	XaxjDlCRTP+0pIkgyXMrWczllYks+yhiwDInZQIkXnqNFT1oGpkyWKTJP64jk5lq2swEll
	/ntE+bLRK0MZn+5zZ8sOHXVu5Q+wzEReRZnODjq4gPXX1ckjXECMuhB1S/6vKw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 09:19:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>
Subject: Re: [PATCH net-next v7 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
 <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
Message-ID: <77de607f2f8330ae6a593a4803887c8f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-292571-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:url]
X-Rspamd-Queue-Id: 5A8D25ED96C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fidelio

On 24.5.2026 12:44, Fidelio Lawson wrote:
> Implement the "Module 3: Equalizer fix for short cables" erratum from
> Microchip document DS80000687C for KSZ87xx switches.

The commit message says this implements Module 3 from DS80000687C, but
the errata's Work Around 1 writes 0x15 to indirect register 0x3C
("PHY equalizer register"), and the patch never touches 0x3C. Could you
please clarify which document the register addresses
(KSZ87XX_REG_DSP_EQ = 0x08, KSZ87XX_REG_PHY_LPF = 0x4C) come from?

I checked against the the following document:
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf

> [...]
> 
> +static int ksz87xx_apply_low_loss_preset(struct ksz_device *dev, bool 
> enable)
> +{
> +	/* Apply the Microchip erratum short-cable preset (LPF 62 MHz, EQ 
> init 0)
> +	 * providing a conservative configuration for short or low-loss 
> cables.
> +	 */
> +	u8 lpf_bw, eq_init;
> +	int ret;
> +
> +	lpf_bw = KSZ87XX_PHY_LPF_62MHZ;
> +	eq_init = KSZ87XX_DSP_EQ_INIT_LOW_LOSS;
> +
> +	if (!ksz_is_ksz87xx(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!enable)
> +		return 0;

This silently returns when enable = false and nothing is written to the 
registers.
Either I'm missing something or the short-cable preset cannot be cleared 
through this tunable?

> [...]

Thanks
Nicolai

