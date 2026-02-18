Return-Path: <netdev+bounces-259321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EO7MAnalWmmVQIAu9opvQ
	(envelope-from <netdev+bounces-259321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:26:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ED15761C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCEA5300F5DA
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAA33BBC4;
	Wed, 18 Feb 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDEPFz7x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6433A9F0
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428358; cv=none; b=R+LKOhHOalywycON8/TMvM5Fxw9TxnOfZfftkJGGgiK65ntJVtee0wkd3+36aOGMAOejr8ee9gkP1ANu2CzAKnwIgAEJQriNKYBidNpeN5NpqoycJFSVPghgQw8LiMWESJqsFfqJT6L8G79ZxPhEzcByIsxihGDvEqP2YNYWDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428358; c=relaxed/simple;
	bh=B//NZ4Mzhr3iZA8BUoEBeIXXRA5tfuphbeT4gL5tXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSRAhkT/fmj2fsBAkfVUIWYSsiMkU+bbUL/qv4KsLEa5Kg2s4OVghHDbHQsYzeJA5KWyHwS73UiMieST5LNUJwOzXblTQib1k3wk+rQreENCLo8DOLUCek0jGjefEJqCs/TEuWzzpPHLEvd9Nfekm400TOxtRjvyjn6iu8DMJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDEPFz7x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4830f029407so11350475e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771428356; x=1772033156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mqOFZ3XWpW1EQtSaUw3QtH4Ru3KhtKI+tT2Fq8wPmQ=;
        b=QDEPFz7xnFm3ZKgAm0qFLNmAzjc1HKCiCJupjKPebeeU2Mrjnf/5V80gIyOgEML7/y
         EbUFvH913mPFAr32dijraO4gREjK/pKyDUTZzqOT9YGozFkmnBd1kpJ0D2ceKyzTBixV
         zSbtYO9Yohdo/eQMhLRgcY19ib3StmtiSIDmFo6A231PCjttSMtXhy8AUK4ga3gdjsjZ
         TjoC42WP/S23+KzPd3dqa1DnXaoyXF/Z+aSVfU2V6wB14doKlh1T7eVtj0Z4ntvkFCnM
         6eaOmb7BDQvtMh1G8ZaXAVTsZhNwTHv87BVcttce9HO3M7sZZx5qSba7HrzdFcXZrC0o
         lxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771428356; x=1772033156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mqOFZ3XWpW1EQtSaUw3QtH4Ru3KhtKI+tT2Fq8wPmQ=;
        b=Gwj0KZQj92e7jIHR7g1Nnzj/QMbuYV84qQh7mx0AvMYOu3aj3b04W9xVxS+O1qaFUk
         gGCyfD3k8j66YkSh13AGna4cgAERLW6wazdZDrk4b7oG0H9EFAtNVNEyOavBBOgcWHGA
         kRPniN23766L4gxMuHjuH5Yy+qgu9Insc3KJ4CBEVlT48lNHzhLvFfvnl6c4gS7bht9o
         JGrVx1uIYvLv51SVuY0Vn9HDehfepwyRj4XSH+6wpj13H+hMhT1F5uRe64I/E5QVaDKZ
         cf7sTRXtIO1Wv9QZkUZjGc7YIy05icRv1DbAoYDg1quqrAl4jgTdCbBSID8ywlNlqgGR
         9b9w==
X-Forwarded-Encrypted: i=1; AJvYcCWpMK+9rOOo3q6v9WOZoSZGsLL901WSZHP9vihQSovltl16v8zKwYjm7iMVlXQCTkBLlaNhEQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJrx7aTOxi0llo/F48OEg2abz3XjHVkAg+mdmm+mMLMIKJXvJ
	pEvRpgJr80LzQWwjoM1Dl/08BXMJJyKmDFY5iTStTirCsTibqYkA6ou8
X-Gm-Gg: AZuq6aI13QaHNcFwLFj03cOy0umDXIfxj57/UiVfC7rzTtj5kTpN68oJD3/5bH6gJXB
	pRW7afl2Ycvsax5sNyy+7uc4Xgg6yyneHF/ERypDdSNC+M/5VgHV7wf6lPyLLGkWbYOY5hmCR2A
	VxhYV3KkH61062wEg5x5G1Bqwd8Y0QhNYECLQdHu05nqXeC2Qo4fTZlmunzXiFteRhtAfYqsvjo
	UNsu8grFVIlO21R2ox4OyJLZAHTpoMYMJimYrwaVghoOOt3q3q+uJ+jEZvOEfIiclzODFsZ+kJ7
	wuXgy+5LJCs6WYfbtKXg3Jkrc5gP/nqWOq7vibDMPhnMQp7S8o26Io5TMjI/6BRvtOnXQzPcnqH
	hybQHepm2PvIKcqbUvSYK7Y31yOXwi5l6QxPoffKjeSkrPiOKKSjVNyK+OCKX/udh9PGOsmjzBG
	kWER2sKvJ2i8gdhc4=
X-Received: by 2002:a05:600c:8b35:b0:477:5b01:7d42 with SMTP id 5b1f17b1804b1-4837104003fmr188817315e9.5.1771428355662;
        Wed, 18 Feb 2026 07:25:55 -0800 (PST)
Received: from skbuf ([2a02:2f04:d404:ea00:555a:a733:bf42:162d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44427208f8f.26.2026.02.18.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:25:54 -0800 (PST)
Date: Wed, 18 Feb 2026 17:25:51 +0200
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
Message-ID: <20260218152551.vnqr7bl7yfrymrke@skbuf>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-8-652e021aae86@bootlin.com>
 <20260202134330.xzc2wmcwwqhw4dfc@skbuf>
 <b4997be6-fe03-4ac1-8568-38e0a78dc602@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4997be6-fe03-4ac1-8568-38e0a78dc602@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259321-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 230ED15761C
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:21:26PM +0100, Bastien Curutchet wrote:
> > You need to set port->last_tx_is_pdelayresp in the atomic section where
> > you know for sure that there's a single TX timestampable skb in flight.
> > There's no explicit lock which creates that atomic section, but the fact
> > that the worker kthread of the tagger processes work items one by one is
> > what gives you that guarantee.
> 
> Thank you for the explanations. I suspected a race condition here but I
> didn't know how to mitigate it. I tested a new version on my side with
> port->last_tx_is_pdelayresp set in the ksz_port_deferred_xmit() worker and
> it works fine.

Good.

Next question: if the logic is all in ksz_port_deferred_xmit(), which is
sleepable and sends packets one by one, do you actually need to save the
packet type in port->last_tx_is_pdelayresp? Can't you just keep a local
variable with it?

