Return-Path: <netdev+bounces-259332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YW7oIxjtlWn7WgIAu9opvQ
	(envelope-from <netdev+bounces-259332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:47:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F06CB157DB2
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0AE530073D8
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB93E2FC881;
	Wed, 18 Feb 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkhcmUDk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD00298CB2
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433237; cv=none; b=TjBqm/J5BrPlq+xLzNwvYmFRr0Jy8KiCooV+uAgv+IGXd4HraVDh8APl/WMPvrO5nrGNiXWDebMkAcvosT5z/fAbrxzSPoRJrGLwb+1oAo9WKrrjIg7Na8fhh7+7pNMULMcQMblEofv6dxBiXyRZYwgNJg6O7nAnjE5QkvL6zsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433237; c=relaxed/simple;
	bh=v6a0tSwoyjviP5o/SSTg+qX/yAR1Jmag3m6xO34oric=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AogMdPpsMJxtQKrRpuBXaz+CMydooWnQ1bnZgBQHlvWWTmehfaIxrLXqk3xBEHi3W77vlMRToBXfxRK3iMD7FvA/4kvtabAl/1jcce/PbD94ki1MPkLnHCjgcVUa3b4JWmprVM7+vqcImUcn3029P9TD3PhyKZggBi8OTaiqKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkhcmUDk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483708b697cso40985e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771433235; x=1772038035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=du4Nrq+7LsG/Kate6nNgSmb9eQhmGantuGa8Z1HBIjU=;
        b=OkhcmUDkrNm2O8mvp+tW44eRUhaDprkNMBgDRvMGAVu1vqDP7ujGIVjcPjCzp1tc3Y
         gXMWORU2ExjWYzejDWEjo+3fOvZSBP/xUcNJZg2paattLGOXQ5bNu0TOQJbyoRCumWDI
         6Phbgy5le6X6NIasHxv6G6mSY8/E3kozolZblhn1wbbbEMktJXtXzD55k2Ggc6FNOJ2z
         jGHCh96uI+Dc56GOL/mb6AUH7ENYooyxiRvb+y6HrFKue4Q9wXE77GkGwVX0J0q7cIRb
         Aw5jOw6Qfv52nUSO4lNDp5xaeZ+Wkon4yhYTrLzIAn/dpyZDTTQoK2sBEWxkUrnEtSux
         npjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433235; x=1772038035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du4Nrq+7LsG/Kate6nNgSmb9eQhmGantuGa8Z1HBIjU=;
        b=wuHGOMpUB5GbR6QbgRjHSHyz+24Gxe9IXVdoesCjefWGu0X+EXv4hNtoaC+jhkWRvj
         6UyKmY7FImFzGwBRUAmT6fvEOf9N+RkfF8Z+T9SVGFVf1LUqkQP7atyH3pNPdMLqCkRH
         IMuCmkD2OzyBrlQwVA20zwhixSS7d9o4X8bw6JhsYUqH2B/Ic39tE2Qdg5vBqm3yvPJH
         Q9dpTKni5P1m6UzyxBwxdoV9Iy6OK4QOuoPdnUGY7MsnQXxA6c6EzHQ3wojy5MREbFT3
         3JAdQX1sQ4X1OfTFz7OTjylg3WWqIqeyPJUmtvPGTjCey6tvbjUCzfD12M1IrreIm65D
         85dw==
X-Forwarded-Encrypted: i=1; AJvYcCWqcdDTvQ9s3JnmWDB+6JTT1jHMaMdgFZmcYCTcMlmI1Hdhn3u+b/CdUrUodkBbeVCo42j0wAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7owjIthph3p/Jv/8tRe7H6jOCDjzgA/Yq61B0udKgw6BJQSy3
	MsDyK73qxOuJmIJ5SWBXMa7FRqu3I1U1U5nB81HsK5VlFF34Th9O75aZQlIufg==
X-Gm-Gg: AZuq6aK5Km9Wdp1I99fmrr7Hj6zQDmriy/GglsBWTBU6HnoURSnv0ouk038jNdM9thx
	1ReH3sha3w+hGO26Ei7edkOGZYEkAZ5hWesOcoSMTHsH7sR1NGIDUNIAY9h75CRllAzhrxEAlMx
	j5FbBBZCLioGeFpZisRSJzzjRY2IaMbcXgMos0f3IYd5VbgVwJcsSqm777YgEFKFXzXcM1ueu4H
	zDz/J6p0eBH6SpWvVE6g30VI6j2CAOAZO/bjyX0qglywqhf+HrMY6LK0nTqmOuGStll83Dx6rOj
	cX0yIdLmqvxMWcL2x0Fn1W/gn0iOcmyNaWFd6PvfrD+Rs/kS7HylVhK78WtmDxxqd33FIQd+byW
	t2bjczpQb/K2NueUd5JrCbQIjcVx3wyZauFPkWOwa4FpmzlalypMD7eGEkUYMpb50w2HL3XqPYk
	DjDI2ueQ++7sTiWXE=
X-Received: by 2002:a05:600c:64cc:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-48371043eecmr169658225e9.3.1771433234448;
        Wed, 18 Feb 2026 08:47:14 -0800 (PST)
Received: from skbuf ([2a02:2f04:d404:ea00:555a:a733:bf42:162d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm676991105e9.3.2026.02.18.08.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:47:13 -0800 (PST)
Date: Wed, 18 Feb 2026 18:47:10 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/8] net: dsa: microchip: Add two-step PTP
 support for KSZ8463
Message-ID: <20260218164710.rimvimmiaqampvy7@skbuf>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
 <b4997be6-fe03-4ac1-8568-38e0a78dc602@bootlin.com>
 <20260218152551.vnqr7bl7yfrymrke@skbuf>
 <983ba1c7-06d9-4474-ac6f-ef3878b31436@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983ba1c7-06d9-4474-ac6f-ef3878b31436@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259332-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F06CB157DB2
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 05:42:32PM +0100, Bastien Curutchet wrote:
> On 2/18/26 4:25 PM, Vladimir Oltean wrote:
> > On Wed, Feb 18, 2026 at 04:21:26PM +0100, Bastien Curutchet wrote:
> > > > You need to set port->last_tx_is_pdelayresp in the atomic section where
> > > > you know for sure that there's a single TX timestampable skb in flight.
> > > > There's no explicit lock which creates that atomic section, but the fact
> > > > that the worker kthread of the tagger processes work items one by one is
> > > > what gives you that guarantee.
> > > 
> > > Thank you for the explanations. I suspected a race condition here but I
> > > didn't know how to mitigate it. I tested a new version on my side with
> > > port->last_tx_is_pdelayresp set in the ksz_port_deferred_xmit() worker and
> > > it works fine.
> > 
> > Good.
> > 
> > Next question: if the logic is all in ksz_port_deferred_xmit(), which is
> > sleepable and sends packets one by one, do you actually need to save the
> > packet type in port->last_tx_is_pdelayresp? Can't you just keep a local
> > variable with it?
> 
> Well, I think I could but it feels like a significant rework of the existing
> implementation. So far the register location is tied to the struct
> ksz_ptp_irq, since on all the other switches one interrupt bit is associated
> with one timestamp only. In fact, even on the KSZ8463 the same logic applies
> because there are two interrupt bits per port: one for the sync messages and
> one for the pdelay_req / pdelay_resp messages.
> 
> If I'm not mistaken, using a local variable here would mean moving the
> timestamp reading from ksz_ptp_msg_thread_fn() to ksz_port_deferred_xmit().
> We would then need to check the type of each packet before sending it, in
> order to know where to read the timestamp after wait_for_completion()
> returns.

OK. I no longer had a git tree checked out with these patches, so I
forgot you need the PTP type in the IRQ handler. It's fine the way you
plan to send the next version. Thanks for checking.

