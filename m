Return-Path: <netdev+bounces-276687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBd6Gtuo1mlKHAgAu9opvQ
	(envelope-from <netdev+bounces-276687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:13:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD93C29B0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1FA7315CF3B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3ED355F30;
	Wed,  8 Apr 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Gy/QgCHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249E337B81
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674159; cv=none; b=VKqfaUANP2w7+ogbndWNxYwhPOGWis13zwFEEHnaJW8Pzd/KdXFTfqdDeWpxMkpeq4VjxQVLSRKhvjNT1DHa8D3d6NPXbL+DqaeoFYuhb2hVJUys1Q3je7MRU/rqe9xe/gP3yrIffqNZbG+BHLiawMeBNIwRmoaApTY7lEgXMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674159; c=relaxed/simple;
	bh=9nwjvMTURmEimYoM34lgEzzFizceHlzxg1S5VFy4ta8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4PVTy13bYiPUaHPrECoM+RybCwy1PvrypFLLc9yFKZV4AkQ56fcZN4MXHJ38zFdVrh3/JW1Hw/NNKU9o8LC/MLsNm8+Uh/iG9eNSNHlGxGuATHkI/HhUedEJ8WehW4EF2FhKxp4+ydM8TfvkrZH9j3j73Q0AQQWq/3kEME/x4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Gy/QgCHD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d95017a68so88209a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775674157; x=1776278957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgfDguXq0Z2TYsaZoeNncQSV60WxEaZyK7h7hjWHVek=;
        b=Gy/QgCHDqT6IpztP8PICkXJJMX8G29tToLzW1lzueFRKiC0YKkG4usTXlOVV3LSyAB
         vtltG8SaVE6t7ooJL2noHZNnjpKYYveumFcbdnV280g+tfa8SqAwH1q/jIxiu8V7nigE
         IJ3VtDGwBsf4BjNQOGKI0gw5bhptxpJz0s4gTbJWVS9JrklOnb2aBm3wv99jXb9rizjh
         p1A+Qbbu+HUvPMZNExoDRYdAQSvSMusYGRf3FiEFsaeNWKIv2vu5iqpRUn9nbM0LpzDu
         XKi/JRAborsTs2ZYYFLO9BPM1s30b3zl/qEgvl+BPM5I+FJOtUEdGp+M9rViM2t23XqI
         5wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674157; x=1776278957;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgfDguXq0Z2TYsaZoeNncQSV60WxEaZyK7h7hjWHVek=;
        b=Tm0TFWj3lZ4FWtkcMmA2r746EOKgnnCT1FJ6S9TZ2WRR9/NgziLO4u3QC+6OzZoNsP
         vmahnKwqoUrxfo+4Z9EL8MLIuttI5UvcHVzTKcnHgmh6P+ierZVUhTA/+6PoJVEDO0E5
         25NVzbHC2gO+B4cuxbFthhDifWbYavFRuqGl7CCQCcvn8x0werDHFbWRrciJCp405/e8
         YnReEOYL0xCICMv7HmJCIA6Cbk9S22px4kLD/6DLeYmlbzYEkuZKqTttK6MI9rcwoqHS
         fau7cfAwP+qCKgcVYtubgGKtA+Q/gF4N+/thr6bwcEaAXB7gDSjY2qkXCRNOl63wIdNh
         ddAQ==
X-Gm-Message-State: AOJu0YyNNnrIeCydKUXPF6drPIJ+9y2cJPWC5NXvDmqLdPD9RvKT/vq2
	OUU7aN+OxQ1Y04dmrsls6mcUAjh52eCyYjudgtoVVbmeY9A5Qbq9OyyHofIow2tqTMI=
X-Gm-Gg: AeBDieudaWeZaVkS9GdNoltEbG6sBhRfY6QI5iJz1PSipvfSDV2YV/NCywEy9hWAhm5
	XKSdqgq2lrSCSOvtyoU5fbgeJCI2kYwmhGe/dwsDqo8cUg4VXlAkPv/BOW263sByOg1DQ7iOURp
	hhQTiw5ImBJVcbfkis5O4/SrKakFfG1R/r598E9n+ZzJTbAHIKZbChPEF7dD+nTuwY2fVXKG7ZT
	7Ofc5GEEDb7Lbcj2kAdo/HF0NIw8MQEZzyPKmf+AeVaYNF2Qr5b7bRmDiMHybo37p9eLsTa/MbM
	dw4OmXfzfCa1KSC51CSUm7d4rbQZj+etY70feeSzVdd6jc8R3OIQHdqJLr8oEnrsYq+qh/us7Ll
	8JKJJ2jR+O6GCN3JXhPe2e2brTZZBCRiCTp+Shn0/LRg6t2qzhOcXsXMBnr3dCVH5NhebLsyatO
	Qn67c=
X-Received: by 2002:a17:90b:37d0:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-35e35969b39mr332551a91.16.1775674157566;
        Wed, 08 Apr 2026 11:49:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm17475484a12.11.2026.04.08.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:49:17 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:49:16 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v9 07/10] net: bnxt: Implement software USO
Message-ID: <adajLCnP2eCSBLVq@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260407220313.3990909-1-joe@dama.to>
 <20260407220313.3990909-8-joe@dama.to>
 <adWR1OiPlQCJ8idj@devvm20253.cco0.facebook.com>
 <adaKt/VwrajKraR8@devvm20253.cco0.facebook.com>
 <20260408110652.652e4732@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408110652.652e4732@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0BD93C29B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:06:52AM -0700, Jakub Kicinski wrote:
> On Wed, 8 Apr 2026 10:04:55 -0700 Joe Damato wrote:

[...]

> >    2. Or, keep the smaller buffer that we have now (BNXT_SW_USO_MAX_SEGS (64)
> >       * 256b = 16kb per ring) and fix the try_stop like this:
> > 
> > +static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
> > +{
> > +       return BNXT_SW_USO_MAX_SEGS -
> > +              (u16)(txr->tx_inline_prod - READ_ONCE(txr->tx_inline_cons));
> > +}
> > +
> > 
> > -       slots = txr->tx_inline_prod - txr->tx_inline_cons;
> > -       slots = BNXT_SW_USO_MAX_SEGS - slots;
> > -
> > -       if (unlikely(slots < num_segs)) {
> > -               netif_txq_try_stop(txq, slots, num_segs);
> > +       if (unlikely(bnxt_inline_avail(txr) < num_segs)) {
> > +               netif_txq_try_stop(txq, bnxt_inline_avail(txr), num_segs);
> 
> I think option 2 makes sense. The point (which I think you got) is that
> the condition must be evaluated after the memory barrier.
> 
> Since the condition is repeated in your latest snippet - you can
> probably use netif_txq_maybe_stop() ?

Yea, that's better, thanks.

I'll go with the inline wrapper above and:

-       slots = txr->tx_inline_prod - txr->tx_inline_cons;
-       slots = BNXT_SW_USO_MAX_SEGS - slots;
-
-       if (unlikely(slots < num_segs)) {
-               netif_txq_try_stop(txq, slots, num_segs);
+       if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
+                                 num_segs, num_segs))
                return NETDEV_TX_BUSY;

