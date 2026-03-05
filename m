Return-Path: <netdev+bounces-264379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAeuKRt9qWnl8wAAu9opvQ
	(envelope-from <netdev+bounces-264379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:54:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 269442122AC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A3063017FA9
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1B39FCBE;
	Thu,  5 Mar 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfxLUkDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BF39B4A9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715116; cv=none; b=TCCOYWZXctMXg17Qxn3/t+sVLaBUG14TD4qaGmtvxh+u4AZoBl6mVG+USMRB6LaLb6slA9d4skqSuB4FT69JBNQw92NOD7O19ZsX0lYpX8dNL8zyoikznY4kV/pZoAdAtHFnw3CwKRDImWxRooOSJChUxyzRsh7hsZkcb6apKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715116; c=relaxed/simple;
	bh=ypE2lSIVAY9y0+K1PIDAfdjKWnmQ8BkbmbQ4nskjkZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOAThMTVt9VwIC1NcFpyWypYcWAQiaJjf2wnzlLv6H1zbKAi4yhq2CZR9MQy5EmnQrypjPmzt8DBnCt+mxHsmtfEzgL07ESTmmF6vyUlGJd2KR9ceVPgLgGQCDPyRTpg4YOMDzZYdC+5753IctPspuL6Yhg1A5aY/07WFyudd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfxLUkDP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bc832351so374193f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715113; x=1773319913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRB4uIL09ozeBKw0FW4Il5M9k8G0bh8LloQo3nxJ1i8=;
        b=AfxLUkDPIHoC7JkSXEtMVfcI/hyE/HjXGHeiMoud8xE/6KoUjk9HRBAzDOioA0X2tb
         9h61d5EBQDaeRhrKnD+4vYxsEPcmHWO4d7B4STsKuF0Xk7LL37R0fuOAUUGmn227RgFg
         JdXipa5Klf75le/VZtGJc0WYV4z6nmd9FKVUwWa2HSMHeXPafZVNMLhFnh3AZmAWiK/D
         XpSnMI9+H9L43czr9IfF7aFHXLAstfKHG+4x+KU1tG352e4qcU/MESFNwfXn9aW/vMXE
         p5S6DWx5ooXF80RW4jmX/LKcMEW/fAy6spLDMD7+ry7nMFat2AHlHCRk72h7E/3oa7r0
         xBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715113; x=1773319913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRB4uIL09ozeBKw0FW4Il5M9k8G0bh8LloQo3nxJ1i8=;
        b=f+7DYq8q4uhkqMUoHV6oCJf1FV7WAXqLZkSz3UtY0RkZ2Su/6s33wwom7idI00wsvB
         IIVYf02zPLquUvLWPwqaC7StVZcQSdvkH38MzkUCAa2bBlbvvZnbhO2tVaBiCO+ARIQQ
         ADAWyvWQ0Xcul6dPnY4koO7RQ1mUdHlZEslRrqqA1NZt1Ct7aRryH8kZ20cp+OGWJutw
         iwc4CuACek5wQPHe77ZMy3a9z7oeAD5wyAGfRaVlSBXS00/ec+A/4RVjvkFFz8ZnFAQz
         wa+bK5tmLZdq0Rlh70qZtQ+/3FcKKCbfhteZtSFCP6UsZkUigodwfj00aA1aKwXNxMsg
         cmFw==
X-Forwarded-Encrypted: i=1; AJvYcCXRmnK90JjhI83E6fGDR/3cSWChRnUFifaIjInDbeLtcXPKayM1iak5W5HFkS3P/yj8up5nQao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+JHoRrmXe5DdgI9gIP5TtKkqtjujPLI7+14nfrgEB12mWASY
	V2NeUmD8qKYn15tVLWm+6Y5nR2yGlsFlISz6j+Ld7PzWrwu1JJ741ohk
X-Gm-Gg: ATEYQzwe28LoIiTOpL0Qs5zfIgnaUw21KQff14slS9TR+a+QQQxEXASQ6v/ieAX4jQ9
	iD2P3ZufYbjLciW+B3s0BcJzJzmhR99zedJ0D4BfmLYfhHMD741nItEH7DbTxV31yHZgf79o5LF
	DgJOhhn0gqGlrGWHPG/PIBbzMVvyjBpY8YMIwA0Mqj29orQpPENjBzwtQQ0HFR6B/8Ee3rh04ks
	ctX2s4yy6dLCwvnYKKd7hQZ+LZP3a4PkJpQQEFt6v+sSsHRM3EsaOlbVRJfK4tCpp0WM1WqGOpN
	ZYivHLeheJH3/QKUF8pdGoHaqPYUsJ5sH7i7leSiJgigwSkvm412w/2NameN9T9fwk8mBZp+Ylk
	bt5oNzC7e9gFD/OX0JY933k6P5UuUMUniaMfDNzYqCJWIB8QFN/7RQynBftk4JUH/eiMi05Wy37
	LO5wVVh0CBGNq0NBs=
X-Received: by 2002:a05:600c:4e4c:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-485198646b5mr58695645e9.3.1772715112909;
        Thu, 05 Mar 2026 04:51:52 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8a9542sm72393905e9.1.2026.03.05.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:51:52 -0800 (PST)
Date: Thu, 5 Mar 2026 14:51:49 +0200
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
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260305125149.ejju5ptrkviqi3sm@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
X-Rspamd-Queue-Id: 269442122AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264379-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:39:29PM +0100, Bastien Curutchet wrote:
> Hi Vladimir,
> 
> On 3/5/26 10:56 AM, Vladimir Oltean wrote:
> > On Wed, Mar 04, 2026 at 11:18:52AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> > > @@ -2890,14 +2899,18 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
> > >   	unsigned int nhandled = 0;
> > >   	struct ksz_device *dev;
> > >   	unsigned int sub_irq;
> > > -	u8 data;
> > > +	u16 data;
> > >   	int ret;
> > >   	u8 n;
> > >   	dev = kirq->dev;
> > > -	/* Read interrupt status register */
> > > -	ret = ksz_read8(dev, kirq->reg_status, &data);
> > > +	/*
> > > +	 * Most of the KSZ switches have a 8-bits long interrupt status
> > > +	 * register, but the KSZ8463 has a 16-bits long one. The overread here
> > > +	 * is safe because we only iterate over kirq->nirqs in the below loop.
> > 
> > FWIW, this isn't the only thing making an overread "safe".
> > If the adjacent register also has "clear on read" semantics, that's not
> > good.
> > 
> > I can't tell whether that's the case here, though. There are just too
> > many hardware variations to check for. I just wanted to point out that
> > the reasoning is incomplete.
> > 
> You're right, I hadn't thought about the 'clear on read' case.
> 
> I'll use ksz_read16() only for the KSZ8463 to be 100% sure it won't break
> anything for other switches.

I'm still on the fence on whether to say this or not, because I don't
really want to get so involved in internal driver bookkeeping, but...
this driver is just becoming a hell to review, even if I want to
concentrate exclusively on correct API use, like I try to do.

Linus Walleij has added a new ks8995 driver, which has some overlap with
the common ksz driver for the KSZ8 family. Now he wants to remove the
overlapping device support:
https://lore.kernel.org/netdev/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org/

Maybe we should go the other way around, migrate KSZ8 support to the
ks8995 driver instead? The common ksz driver is becoming just extremely
convoluted to handle all hardware variations. Would it help in any way
to maintain cleaner code paths, what do you think?

