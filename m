Return-Path: <netdev+bounces-158223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0AA111EC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDB51885088
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135120AF98;
	Tue, 14 Jan 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndv4QqP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495002080D9
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886529; cv=none; b=Zz8XaK1tzi1tlQRpiUUrQR4sZElCKGJAn88XckL3ELR9ib9nu3tVUq1nE2QvMvkuILqrnYdfHlT46NTJVeJ656H0BxhEcVH4+nf1LyuEHk3vNssoW0Tkn4kYLyQrX+VAlGZx+nuIFvwExqbIAuUum9E4x+BcKD8seolGeZ0GESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886529; c=relaxed/simple;
	bh=g8W9gmX6cST0rAYG+XUvlobJaj8I9rpr9JAD83vI2QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqJBwqxCOdKwOQnAz6mX2T+Kr8wceZ5vyefvz9PkZ6Z7Sig6Om9tgEWYjsPw+UsExD/iGl7Le4iAC7BNOZqvPgQQziNzsOhl9/wf/HO9s0n1s9VKIoLKUKaPh17APHFb4aRTbc3DrsXZ1WWbAdiL4Dcq/EnRfQR3NMOtosLGUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndv4QqP1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4363299010dso6435085e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736886525; x=1737491325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS4Wxdv2z85JzVf37y1D36qgWJoPNxZK2y7SNaI2jos=;
        b=Ndv4QqP1NgoZXEXWZV8dofIotOkcZ7JLpM3q8IYQY0WHo0zfet0vgk2MzfTnjMn1vS
         JPbFDcEtK0I0RUqY65RSOOjmpINOZs+Q4iScleD2Myi+GqYvFU5E9nHY++s8Nqv69SrO
         VUebKqd8BSgyB2YzAr3JjDsdKiIlkvy/5KsUfkKZQHXhl4YacKI0ipKm8rL6a2tb14d7
         vBkKz4Mt56rr9KV5oM79UBm9TtcLowusG5KxniaUWO8Y+GrxQgxhKJdbMML9r8WBt87A
         2FkA8A8Utr0eNlOFiRDqMZGLwVxEGyF5bw2behgP9AgNycwAZeVwr7dZTHYGCExySRDX
         mWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736886525; x=1737491325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS4Wxdv2z85JzVf37y1D36qgWJoPNxZK2y7SNaI2jos=;
        b=V3zPY2sEnuHjTnjoAwHGQIWD82DbYRZzG8uttND4m42/HEyry5GFeEPND0fKd3wCUF
         G/FYVGbLf9N8VktIKlHT7tWVSaWUR0f6gKLs2mDiwkRRYqFeOhU5WyKjBHha8eJoAyLx
         Mrzz4FytvrpxULKctmbY9ROjyRa5+oBbikJwzI9OBS5fq/4WUiVHMJ1bUi3uHzCKDi0/
         xjjDEqU6Dn/Ien0NCsptLpfjC5HP8R9bJyeMvaPLr7eUwpOj564Ot3ycnHnVm4FHQmos
         tOo/SO7fKPounhsO85Q9L+1imLfWAgPZcPdQBm+EOp5J/uyi/JbtStRwZlMLnGDYEUNp
         UI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoqbXzl/VLwrB+0RytjU+kDEqPYmMCqpafSqBkqPRddh3PxsME+7UVytMMTevP5rvOGkCWLxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+Ldw+w/qnR1gYvIz7kMkAIRT5zTDpom4EtjFq4suO1AYd+OF
	eB9a6CVc511MJc/T1v+Tc7bheihrB1LX34hpLb3al4fJYFTCgvwS
X-Gm-Gg: ASbGncuQ8TUqhMIVOPGxJZzLiDInv55PIYJER42v/NicGvR4pFzZIb3rrFWGIiXCzdC
	BF8l7WCg1Qy8meH21AgAlH/BwLvvc4fjZ3ItRbn4KTcWx/ajaZEVjDxsnxXfOjb7fghd/UFeFW3
	F99YHLyjKQgV3++A8pQzPJU/tb0HrCYqd80hfw6bcJvw9Wwm5URSPZlIhNop0yePWpeCllQZGe1
	thY0JPPkmE+kyLweFIxl0fYAKOQwTBMX4BcIsPGCtSC
X-Google-Smtp-Source: AGHT+IEU33fIHNbn/okRr8JUsVv3C++gKoC0+f27tclkArtV3nUfl1Wc1JVN9bZrD1YIOmFn/4buBw==
X-Received: by 2002:a05:600c:4fd6:b0:434:f5f8:22cd with SMTP id 5b1f17b1804b1-436e25603fdmr82902975e9.0.1736886525263;
        Tue, 14 Jan 2025 12:28:45 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92f7bsm222377555e9.38.2025.01.14.12.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:28:44 -0800 (PST)
Date: Tue, 14 Jan 2025 22:28:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 10/10] net: dsa: allow use of phylink
 managed EEE support
Message-ID: <20250114202842.yeevjylh6566wiwm@skbuf>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
 <E1tXhVK-000n18-3C@rmk-PC.armlinux.org.uk>
 <20250114192656.l5xlipbe4fkirkq4@skbuf>
 <Z4bC77mwoeypDAdH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4bC77mwoeypDAdH@shell.armlinux.org.uk>

On Tue, Jan 14, 2025 at 08:02:55PM +0000, Russell King (Oracle) wrote:
> > What is the reason for including this patch with this set, where
> > it is of no use until at least one DSA driver provides the new API
> > implementations?
> 
> No criticism against you, but I guess you didn't read the cover
> message? I tend not to read cover messages. I've been wondering for a
> while now whether anyone actually does and thus whether they are worth
> the effort of writing anything beyond providing a message ID to tie a
> series together and a diffstat for the series.
> 
> Here's the relevant bit:
> 
> "The remainder of the patches convert mvneta, lan743x and stmmac, add
> support for mvneta, and add the basics that will be necessary into the
> DSA code for DSA drivers to make use of this.
> 
> "I would like to get patches 1 through 9 into net-next before the
> merge window, but we're running out of time for that."
> 
> So, it's included in this RFC series not because I'm intending it to
> be merged, but so that people can see what DSA requires to make it
> functional there, and provide review comments if they see fit - which
> you have done, thanks.
> 
> I'm sure if I'd said "I have patches for DSA" you'd have responded
> asking to see them!
> 
> Of course, I do have changes that will require this - mt753x - but
> that patch is not quite ready because this series I've posted has seen
> a few changes recently to remove stuff that was never settled (the
> LPI timer questions, whether it should be validated, clamped, should
> phylink provide a software timer if the LPI timer is out of range,
> etc.) That's more proof that text in cover messages is utterly
> useless!

Ok, for your information, I had read the cover letter in its entirety,
including the paragraph which you are highlighting here again.

I still find it of limited usefulness for me to see and not be able to
leave meaningful feedback on a DSA conversion broken down into sets
which offer an incomplete image, especially when the API itself is still
subject to change. I wanted to leave an Acked-by but I didn't fully
understand where the conversion is going, so I asked the question instead.
I wonder what you would have done in my position.

I wish you a beautiful evening.

