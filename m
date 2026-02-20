Return-Path: <netdev+bounces-259737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLs6IKqBmGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:45:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD616900B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654433038A60
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20212765F5;
	Fri, 20 Feb 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pKW6eCbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842423EA8A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602343; cv=none; b=FUUu0pWq+9B1WLifD0Fm+fqidg9h6bjO7/phrS6xyaMvmt0u+GeL/2g0TQhlN+/mLZLUuIdhas4n/f+uWzisKnjarsPTQ9Be0WrpKaD3OBfwkUZSdgwjsySFmexeY8ODiyj/3r4Fnf9mCnDznHTVu5wSNz62ocIkh2C0lsPGoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602343; c=relaxed/simple;
	bh=iEaB2BYxr5VrVKzcPcGHtBvWRVFPeRc8QGQ8pjXNTSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mCT8T+qVAJ44AO1OHUumNntrXzqcB86+oOCi3PsLueVFT6Ff5wg2UH4A+v28vQ/bnPBiSLVWJZeJK/2rEITqpHYVsYPiSOW7a+IO/lrROksiR58tfOuQfHIUOcvAJGVVJxgaoYFVOZsqxD8UuTTugotK1T7vQJ3nS5KFNDY04zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pKW6eCbc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E5878C16540;
	Fri, 20 Feb 2026 15:45:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB7035FA8F;
	Fri, 20 Feb 2026 15:45:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C84310368D3F;
	Fri, 20 Feb 2026 16:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771602338; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=abi9yTKt/lNy8gDC78zkCbAwrbxZIVdBIOqfAJRHwiM=;
	b=pKW6eCbctldTsEnBNJEER5XRRTk708VER/oIvIabwdaM8bKexv3h+v30Rr528dIxLqo48a
	1018bqxzfT1N9SO35iJBAPhidjNrewpVkZ3Wy2LwvFrv1Qr54QLJya/4zGTdOdtL9Ms+Cm
	22FDUNiWkfDxX/q+CUa0+cnZzIKNhi3BZf0VVc3qJy01xbi+nLWSWE2zthQrwruuef/hLa
	I91Z5ytmYwfKrBBTaW9eNMxyB5hi+s2U44pjK7ts5Lyb8J5XqqrmjQ8PgfHeCUm672P3Bo
	6lZCmjjh/5LcK8RmYLSLu/EZqUfbSp8CMDUvLEoumJRArjoVx48fh5c+sx6eqA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 16:45:33 +0100
Message-Id: <DGJWM4LCB6ZL.1SVODR6XP10XB@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
In-Reply-To: <20260115222531.313002-4-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259737-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Queue-Id: DCAD616900B
X-Rspamd-Action: no action

On Thu Jan 15, 2026 at 11:25 PM CET, Paolo Valerio wrote:
> @@ -1382,58 +1381,117 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
> -			    skb->len, skb->csum);
> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
> -			       skb_mac_header(skb), 16, true);
> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
> -			       skb->data, 32, true);
> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
> +				    queue->skb->len, queue->skb->csum);
> +			print_hex_dump_debug(" mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
> +					     skb_mac_header(queue->skb), 16, true);
> +			print_hex_dump_debug("buff_head: ", DUMP_PREFIX_ADDRESS, 16, 1,
> +					     buff_head, 32, true);
>  #endif

I think the print_hex_*() calls need some updating. The first call
prints the MAC header (which is sensible) but the second one prints the
first 32 bytes of buff_head, which points to the headroom.

I have been using those calls today to debug something on a new
platform, and I replaced it by:

#if defined(DEBUG) && defined(VERBOSE_DEBUG)
         BUG_ON(!first_frame);
         netdev_vdbg(bp->dev, "received skb of length %u (len %d), csum: %0=
8x\n",
                queue->skb->len, data_len, queue->skb->csum);
         print_hex_dump_debug("buffer: ", DUMP_PREFIX_ADDRESS, 16, 1,
                    buff_head + bp->rx_headroom, data_len, true);
#endif

So I replaced it by a single call that prints the full buffer.
 - It prints packets in their entirety, in a single call. Being a single
   call is important because then with scripting it can be imported
   into wireshark. Yes this is ugly but tcpdump is too late for my
   debugging needs.
 - This does not work if an SKB spans >1 frame, which is why I put the
   BUG_ON() call. It is fine for my usecase but upstream might need
   something more resistant.

Here is one proposal for upstream:
 - We move the printk from last_frame to first_frame.
   That way the debugging code avoids dealing with fragmentation.
 - We print `buff_head + bp->rx_headroom` with a size of
   `min(=C2=B164, data_len)`, to avoid printing full packets.

I can deal with it if you want. If I do, you should probably drop the
print_hex_dump_debug() calls in your series because they are broken
as-is. Or you do it, as you want!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


