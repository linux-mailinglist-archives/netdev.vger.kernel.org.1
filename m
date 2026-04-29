Return-Path: <netdev+bounces-282193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2MK1Jl8WnhgQEAu9opvQ
	(envelope-from <netdev+bounces-282193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:56:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C548E297
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13064302C149
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B434332EBA;
	Wed, 29 Apr 2026 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MG/sEtMp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B01A6819;
	Wed, 29 Apr 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427791; cv=none; b=eEh3nsjBCZMdGCX7PmpguMtjTKQsnNrmzk7ffsyIHmyKnoEPGRs82ukvIDUgfXhCBMTAJxMpXunsLlE4UUddVniOvN1J9WbOr03HLISS6453k4dUogXbChcLtXOp1ouuOlGFNoVsV4qq6gA6SxEbq8YRU0Ajvlw/91rqyCrqEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427791; c=relaxed/simple;
	bh=2qPEQSfzoFkCtcSPzoMzywo6asWd2SqfOfQ7x2Q+YPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKpnTFnASj4zjVI2W4uy59gcy5+HZxOexX0u/zDuNH/WHzqrq4dJ7AKbbEKcT3etHpvEhZpN0zUZMdgiVhun+O8KslTJJNjxmxlThWPMhEEOlK4Tz2PrUfKl9qdp5dLKb6BJWp7qi8oTs23VIaJGY4a4axF2M92UK87jc8Z4Ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MG/sEtMp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cDbvanj8sEqFtgsbvVOkGMWvwYEkjKkO3DLaqyqfcRg=; b=MG/sEtMppUqNpyKcPQ1UOqFOdx
	xYLfZ0UbBIuC79zoOHyYKmtF7Q0KDjRbi46C8yROd7uDFSwrkqq3J355UqIgGu3hfhm8SNYL5JVjE
	lzHihXnbYOwK/ZI7BV23jTn7OiL4eBzOgvXf8AAGN81+OAIVTjURGqisu4YmssBJCiDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHuA3-000RpM-6T; Wed, 29 Apr 2026 03:56:23 +0200
Date: Wed, 29 Apr 2026 03:56:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
X-Rspamd-Queue-Id: 096C548E297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,birger-koblitz.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 05:47:23AM +0200, Birger Koblitz wrote:
> Add interrupt mitigation code for both RTL8157 and RTL8159 that prevents
> USB interrupt callbacks with urb->status ESHUTDOWN being triggered. While the
> issue is rarely seen on the RTL8157, without the mitigation, it is
> common on the RTL8159:
> [273.561863] r8152 7-1:1.0 enx88c9b3b5xxxx: Stop submitting intr, status -108
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/r8152.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 8255261d73148a7b4dabe0188faf07cb1f356437..08cc3c1dae0facb2400890ba4d093c97ed56d40b 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8444,6 +8444,12 @@ static void r8156_init(struct r8152 *tp)
>  	else
>  		r8153_u2p3en(tp, false);
>  
> +	if (tp->version >= RTL_VER_16) {
> +		/* Disable Interrupt Mitigation */
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
> +				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
> +	}

What does interrupt mitigation do?

Is this a different name for interrupt coalescence, where the MAC
delays interrupts for a period of time so more packets are in the
receive ring when it does interrupt, so reducing the number of
interrupts, and bigger bursts of packets are processed at once?

	Andrew

