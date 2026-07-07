Return-Path: <netdev+bounces-305544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PnA/Hag4TWo4xAEAu9opvQ
	(envelope-from <netdev+bounces-305544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:34:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F371E56F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="pA3+/vbt";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305544-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305544-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82AF0303C4D4
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB862EBBA1;
	Tue,  7 Jul 2026 17:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7611A682E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:34:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445668; cv=none; b=L63TPQwTwzZyHJiiWFHkHPOhUAFamNhZzGb8MqQoOJ8+3S/VBCtjIBDK+hz1Qw7lfReLSYMQ0UXOgcIrNnwYe9W0Xe+WdjWHDgyokAg9O3GmFMBgzID6R1QaRsKufuOFRKlpn/rOiiK9erD/3iBO3ywGjtSvM+XatmfQEjoYwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445668; c=relaxed/simple;
	bh=beAz6lsgDrchDZ/6u3XdDTWLW4VSMLJ9oCgRdfGYjoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt6YnMA2usSRMXgUta3dyDT3dM9UJr1uwdQ5hywVYNf3TPJFXaq4mcdwDRdF/lNgSn3GE+WrdPeby+6YaUT4IHwSCtOYBPHuw11/Y6R3nztsKIPAqQk/ROT1/Dg0hXI7abspNpyS8G3KWzws5JknCLW4Xn6w7l62xnJiJS6enC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA3+/vbt; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49392c85c8cso2044895e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783445666; x=1784050466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=beAz6lsgDrchDZ/6u3XdDTWLW4VSMLJ9oCgRdfGYjoM=;
        b=pA3+/vbt8tLDdJcH9nMuapUuLHNQwPWsAK5UwusD1kc0wcaY6WdyCJo9HsHRLxNkTk
         ucNQE6V+nuBE0hCs1pg/9MPDEieRt05a3pB6Rf48xxL6eIoUPizCUn6pVy1F/tmWrsgT
         reZFdPx5Do7yzdjeFoXFFE7mRZ2dMHcyJel07LG7hCkl5k7JWZqeVACP+nE0Ckxoxyex
         z2RK+SGsAu/ySPTesfVmhGHUcYSAsEVWP1U3fHL3zqyhh4YEgYhUogOUWYqYpueyLjxJ
         6ZHBlKmQlAib4xcqaJTYGZQMFok4PFLDdYpJDV8vaIRHjyy102mSJ6oafM+pwD/aMpOG
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783445666; x=1784050466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=beAz6lsgDrchDZ/6u3XdDTWLW4VSMLJ9oCgRdfGYjoM=;
        b=Bn9avxxQ7dK59B4nspt2f/TLI9i0abZ5ivIp6j08eR8mW0UMfUaa1nKolNqbN3yIZm
         gjgvfqvqUDEsYUb5XXW8JYs8xwdr73Iu0YjWMoqc9JDEa8V7yDssPAE6tUrp9+mfbbWQ
         PsvEE+9frPKNOrPnB42O81M7kxz+br6FHdbLdwUrYUjZCtE8LbuU/zbLGw23+Q6P7BCz
         Ejvz4d7wPKovP2tdvaZ2FHcGkjqFNaPXVpBOnmghLnSdgBkxHDYj8KdWVPMfXmnJltHp
         8+XOKRNfJzAF/7UVLQirh/9lLwX7oKzLAUUgEghPksxmCK2c+SrtfGyb4OHrrnYvDza7
         NOoA==
X-Gm-Message-State: AOJu0YwI3VbTWof2Z2ceLEyvFyWtYwB3viH8M7OiV2+V4KQuJIt+xx1D
	X6r4Aanhd5B3mz84OwxN8YOwsiVjl0Sb13Dx23V/kkIG5vCVnQDHdpNI
X-Gm-Gg: AfdE7cnay9yI1zw1OCw1bWnpxE2nWMy4gX1bKZLFbTK/uBgW90DAcn3wlY1LXxR2PiF
	a8XLnLT4bo9PDdp0qL2UZZI2RAHgiKS0ow18av2JTXWQpWDFLAxlUoe1q9xa8eITojknxQUISXk
	n94JnvKgpmSpGge78qssAS+1/lqXjqu6qe6mJWv7/2Ew70WVTUulxV8Azxx8+k1ZXL2W1A2/H2J
	zzJor5trRag44jRK2l+f4st6G0Ua7z0oX4uRsKtt8KgYWGCqGaKaO7UvCn03rtsmdOBQHDccIrz
	Sli+qw8svnWlq265+z0tXjmXgqzCmAbvDQ4rFOAanS0EqcdEGo4iMXc/8EHxNjkZQEvP7LmbXQJ
	YI+K1qJsVGWFRtiktgaoB3ODBVliH5MOmfM48axIDV8O0PE6CcrO9V9Rp09/QeLgmMNITNMupwW
	eJY4am
X-Received: by 2002:a05:600c:5249:b0:493:d282:8275 with SMTP id 5b1f17b1804b1-493d2828325mr109539005e9.0.1783445665573;
        Tue, 07 Jul 2026 10:34:25 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:a377:64bd:e25e:a10b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm34456301f8f.33.2026.07.07.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:34:23 -0700 (PDT)
Date: Tue, 7 Jul 2026 20:34:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dpaa_eth: convert to napi_gro_receive
Message-ID: <20260707173420.6qkzi75hegx4dq7b@skbuf>
References: <20260706030632.1826810-1-rosenp@gmail.com>
 <20260706083906.5oxmr47vbnaztfu2@skbuf>
 <CAKxU2N-6Msn+WciepQ3rnP64fUE6s_jviWfy8no_-qorPoyJEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-6Msn+WciepQ3rnP64fUE6s_jviWfy8no_-qorPoyJEw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305544-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,skbuf:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C49F371E56F

On Mon, Jul 06, 2026 at 04:25:31PM -0700, Rosen Penev wrote:
> On Mon, Jul 6, 2026 at 1:39 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > Have you tested traffic in mixed scenarios, where flows from multiple
> > interfaces land on the same CPU?
> Just iperf3 --bidir.

Just this would not have reproduced the problem I pointed out.

> > Until further evidence comes in:
> Maybe netif_receive_skb_list is a better fit here.

Maybe or maybe not. I don't know how netif_receive_skb_list() is
implemented and whether it shares the same pain points as
napi_gro_receive() on DPAA1, or what performance it has to offer.
Testing in a wide variety of circumstances should show that.

I currently have very limited access to email for the rest of this week.
I did not mean to completely dismiss napi_gro_receive(), just point out
what kind of complexity is required for proper operation when the QMan
portal mixes frames from different interfaces in the same NAPI poll
cycle.

