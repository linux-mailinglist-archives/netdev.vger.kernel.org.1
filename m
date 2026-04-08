Return-Path: <netdev+bounces-276656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMjxNdOK1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:05:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBA3BF425
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E68E302D94E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710773AC0F1;
	Wed,  8 Apr 2026 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="b6vbNUj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDF33B6C4
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667899; cv=none; b=qwnz05m0HPXk1xN9m8TvG3FwH/VptDWRN49XZqeuNODemJq0a9NnYDMaVWFN9+WwbFh10hw4LWkGXRy+7CpLBkJ9T6hP70BoGmCoGYBp9AbVvB59TEjPUDU/mLTIyWCYKEU7ZiMU7iisOooFg1gXF6fi7A7fN4cbC5dAcuamrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667899; c=relaxed/simple;
	bh=WzgMLR02aMIYU0eRFEH84rhz5dfSsyoujom26UzQZbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/bbb5ML7yb3E87MmJcrHr/y4X56QUZydqI/Ucxgau3v2l3APeK6e4XIlteSzZDQ4HOMY5M/Mm/BWTPChEKQoEOWKkGZ6TxqlESdrP7B5oifqzWjjKSrsYxkKDDYEDz3zceX2AnMHldmN0UpgCz/w7oZfhg7DTt/AP/W7k6o2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=b6vbNUj4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b23fcf90b2so458835ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775667897; x=1776272697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXowYY0DVF1N96YYrGQNG2P8wtcdfXOfx1x2wUYN09w=;
        b=b6vbNUj4/qSh0h2gd36t5f3/FV00aQJErEwRwb6m7JvUQXhU67OVYj8pp/t9mvxJIw
         sXKtmc++5xkJiz2U85cIrs/VFGzs+veJn8deAZmKpZV5ZKaMxdjYHtP5nFG63uxSKAEd
         N2VDXtdqXbH3lxbKgLv+N0wkh+zbY2c0lQH4BdL/WVUELyRsOY6aWI8I+vExLTklLt+O
         Euc7jGNCzwP0c9EeAqrh2QUBaZDSRsXe+xtfmmJUrYOsg8xf91sOb5YB/Kuo0/ptE+TO
         JQaFJIpkkRfQTmWO465xg9TRmzMBP2Mg/N5FSTMV7Q2VKce7XzCqF5CHBDfcTxDnMR/o
         ItpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667897; x=1776272697;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXowYY0DVF1N96YYrGQNG2P8wtcdfXOfx1x2wUYN09w=;
        b=dJuL52E1PYLZd1u6ay/4mhgcoUsGbO8Ow3ACQ304BBmZEBXjNBVe/CmizviO2EhFT6
         VKv6rg90LjUEnryDcIlSKGp6iGBOGyH0bLx4VvUt1IPvkR4uVz3nBQfKA1Z2BmIQIBZU
         TpUsQm1Kpy92fDR7OtWoh2eGpzshVRu4Dx4McjEnt5/HhpfSaY0wK5WyfyzD096gQkdA
         3CGJwRrTF0r80OGbVCZxFAt71rDj5UO+SExjwN62VP8rOnL8B+UZo/JNfB6LtbYwU+Un
         OgKTupCsQSr81DJbqOBi9TZWXAnpaSVhGIb//+arxUo7eK3B1ona9hgkAMrgaojT5Ym/
         w8aw==
X-Gm-Message-State: AOJu0YycDYbBhnheU6RZnraOQY9y5A/tc0Sxsm5kej2weEa31mtKEVBF
	3gqblRdFEQ5A71iMKqqejrSH4EPSWMQz3hWvPCXfKq4sxQNvVE8+jkUClPdKhK7cWzQ9FO1psuk
	H6DecNwE=
X-Gm-Gg: AeBDievsD+b0EDo7lqjPLIbPVRoAZ7XklCz6SeXcPR6FSrWbsF4jDpffW3KNp3BLsDj
	QoVZlHxF7QLOT5I/JMjHmJ0xz+tgKns7XDt+RWI5efLhLShDvHHpVHFziGuizGxnQMNnDyhDMhz
	WuntrhTCf2QBkJ+R1ayStFf/gI3B+IK1jxoC/FudlzX89a41N7XnPb0bmiLMC2nXIl2XSQkBias
	DJO1jBdEen8kwzdUHFA4XLaMWwwcQFNLWqaGTL3oHW8LJsvhBIdx64NmytmG3lmW7KrdGp2g0/3
	v77T0hcErVfh6CSihpE6DJ5cCcKd21GuMhrf2WPfZRzHPQ6CgUIY5DvYm+GhNpvz9OZwzAdI6wN
	n6R34dU0l7+SxZIzmCEkie010Xp4JnWVmQmEXYoFnljKIvziyUrRz26g/3ovZSrwvOW2rbsXJf7
	3YKzNa
X-Received: by 2002:a17:903:1a90:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b2c726c892mr2613665ad.15.1775667896897;
        Wed, 08 Apr 2026 10:04:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478b84esm200556755ad.32.2026.04.08.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:04:56 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:04:55 -0700
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v9 07/10] net: bnxt: Implement software USO
Message-ID: <adaKt/VwrajKraR8@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260407220313.3990909-1-joe@dama.to>
 <20260407220313.3990909-8-joe@dama.to>
 <adWR1OiPlQCJ8idj@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adWR1OiPlQCJ8idj@devvm20253.cco0.facebook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 8DCBA3BF425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:23:00PM -0700, Joe Damato wrote:
> On Tue, Apr 07, 2026 at 03:03:03PM -0700, Joe Damato wrote:
> 
> [...]
> 
> >  v9:
> >    - Added inline slot check to prevent possible overwriting of in-flight
> >      headers (suggested by AI).
> 
> [...]
> 
> >  netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
> >  				 struct bnxt_tx_ring_info *txr,
> >  				 struct netdev_queue *txq,
> >  				 struct sk_buff *skb)
> >  {
> 
> [...]
> 
> > +
> > +	/* BD backpressure alone cannot prevent overwriting in-flight
> > +	 * headers in the inline buffer. Check slot availability directly.
> > +	 */
> > +	slots = txr->tx_inline_prod - txr->tx_inline_cons;
> > +	slots = BNXT_SW_USO_MAX_SEGS - slots;
> > +
> > +	if (unlikely(slots < num_segs)) {
> > +		netif_txq_try_stop(txq, slots, num_segs);
> > +		return NETDEV_TX_BUSY;
> 
> This is the check I added. AI says this is wrong and netdev_queues.h says:
> 
>   * @get_desc must be a formula or a function call, it must always
>   * return up-to-date information when evaluated!
> 
> which I obviously failed to do, so I'm pretty sure I got this wrong.

So, there's two options to fix this that I can think of. I am leaning torward
option 2, but if there are any strong opinions (or other options that I am
missing) please let me know:

  1. Allocate the maximum number of slots per ring and eliminate this check
     entirely. I figured this would be disliked because it potentially wastes
     memory. The driver would need ring_size / 3 slots, and if we assume the
     maximum is 2048 and the slot size is 256b, that works out to 175kb per
     ring. Of course, this only affects NICs with SW USO and the buffer isn't
     allocated for NICS with HW USO.

     This is probably simpler, but costs more memory than the existing design.

   2. Or, keep the smaller buffer that we have now (BNXT_SW_USO_MAX_SEGS (64)
      * 256b = 16kb per ring) and fix the try_stop like this:

+static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
+{
+       return BNXT_SW_USO_MAX_SEGS -
+              (u16)(txr->tx_inline_prod - READ_ONCE(txr->tx_inline_cons));
+}
+

[...]

-       slots = txr->tx_inline_prod - txr->tx_inline_cons;
-       slots = BNXT_SW_USO_MAX_SEGS - slots;
-
-       if (unlikely(slots < num_segs)) {
-               netif_txq_try_stop(txq, slots, num_segs);
+       if (unlikely(bnxt_inline_avail(txr) < num_segs)) {
+               netif_txq_try_stop(txq, bnxt_inline_avail(txr), num_segs);

