Return-Path: <netdev+bounces-271964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLVAHY4IxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7C33336B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F58632256DF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385483BED36;
	Thu, 26 Mar 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq1Y382j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09413B47C1
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519370; cv=none; b=Tw6YHHop82CInupKdgSEY3KtvKT+PsH8jw9O9YqkifP1HQRrD/MDVW8+ih7xuxPFYYhiPZ2GizzPNQxOowKk8vcSwZZwN38o8fihO4JQe5H7o8qFiwF3VA6p1Yewq4EmzM12H7HmYAxepGAz97QALD6eB0d3mlh9fKry3P0eW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519370; c=relaxed/simple;
	bh=08lpgqFUpAIwc6HYcdjxzgJm+GiXbChw20x8AbBMuck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xga/fZapMZTN9zGFt3602xduEknEV9b47/WqD4U47WC1NuH5C5HvL38N46RxwO6I42hu64YEvciZnIrk5eSQpG3nDrVvIOtoRGq98M5Fal1CItOmzzFCnXVsXglazwqfFEdJ4bgJXC75yEkYdpC740Mo2VRPec4vjlQohq9DgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq1Y382j; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so1167635e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519367; x=1775124167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utiWtVJp/arBLJjuDQPxcAdocop4MVdMp6I/Iu6QHDc=;
        b=Tq1Y382jnmR11i3nllw1ktiG0MuYuL8Qn6JyB4auF5keMDIC3vx6RPQWWZaddosfyN
         WnriYgNRb+6LQCyiyjb1RfJuAO872tA/JTnXLbPzb6+1xFWVQAqk/LHt/kA2bWXZPouG
         bCZXub2zIhPbYOcP6T/gH4FgTX6sZ01zw+HF2Bi6lUX/fc6GNnE5SCind/greT2hbDHb
         +/s+NP1NXe3aBqqYbLvT9Vi5/RoLq5NG9HoWbSc+nZfXflOwgv+pj3JwQ07ktLdhkcyv
         dwrgOc1iHfz/XNI7tf4zzwMcavT/YWV6dmtQDc2xEL1J1Dn/gPr1stlJf83Rou7cuDgX
         htxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519367; x=1775124167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utiWtVJp/arBLJjuDQPxcAdocop4MVdMp6I/Iu6QHDc=;
        b=KV27Xw2NDL3xsBwnNAEOlhpCdpRgNf95Ww+kXXXC38aRCFkfxVcYrvTuFa/RvUb/Ja
         YnPfFTRA3d/fJhQHAG8OHjySpdrBrNlYw/sCs92UFe57rcsXPfZcjTZeKa3Gywam94C7
         HVgUmB0iJv5Zs+8EftvRQ4JvH1oSH3WmN8yNw7ANmIyvUOHqQwQyWvCmBIdxSffg4+1Q
         NIxDF2kNPId0+eu9EF5UZzLlHpEJQc+K6RXJgRDr/DEAo697ZiiTer2dDLRDoGoJtWQY
         Gh0Ln0EyDHGJZokA6DNrOH+zhGrInZI3EVNOUTuyAbpTgK8+vGCHPkcLAGx2Sncg2zy/
         vT9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpBniod5dAQFCTMSO0oZN2gWJLn/Vt1SLF9bt4yO1kzkmyYeMQ12lgAFa8Mgc75zQpZjW4bYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXAxMW5FXqrAGlNJuNwkV6xwcAmmbubEB1Wga7ym9s77UhnLf
	40f67JEAxI37sVe7Su8ydaEh4cV9EZRT3GcvQgygXWsX4cDzVvCaWmWP
X-Gm-Gg: ATEYQzw+suOH+sAVhlijmYwEpED921zV2+ouqIwWq6WyDHX7oDbq/Cuk9eedrocu5s4
	G9/TzGtA5gIbwN3O+b8m1c3zFPKpKoloi3jyGpoXQ9Bgg2ZQpQhKgfNg7sjHzqZQMHoZgBTEc9g
	3RzI1jGaAf/7WJxgdvETfodt65aur3Mgw/IO1PTwwzmpHVjWlVrMdhovbxPY4TjMYfD6TmCTvOM
	b4exSV6rRHO5G48C/XOoLoLQ4VSBxb3e3RySinnBZtadmxOUFyP2xPl/CqD91VOPV3/OmBjvfBl
	zeTHA3eQnT02rHcpnOgb7gGYWVl99g7UZ0n321qUhw8EU7iJOdcK7rAmbYx4zCunErrmMr1z8T5
	7DJTCfP7p0tom1bDQv+rLE6++MXSIZAU5SgdIqGmlqpLzDa1s1IO0Op0YkXVDF1bgIUD0OW8SYr
	PB6xSPR1j+zbZnQQA=
X-Received: by 2002:a05:600c:45ce:b0:486:fc61:541d with SMTP id 5b1f17b1804b1-48715fae515mr68921135e9.2.1774519366722;
        Thu, 26 Mar 2026 03:02:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722ca344dsm17253865e9.12.2026.03.26.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:02:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:02:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] net: dsa: ks8995: Post-move fixes
Message-ID: <20260326100243.rxxmbiscjrbe3643@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA7C33336B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:31AM +0100, Linus Walleij wrote:
> This fixes some glearing issues in the Micrel KS8995 driver
> pointed out by Vladimir.
> 
> This patch series implements some required functionality
> and strips the driver down to just KS8995 deeming the other
> "micrel" variants to be actually handled by the Microchip
> KSZ driver.
> 
> If the KS8995 should actually *also* be managed by the Microchip
> driver and this driver deleted remains to be seen. It is clearly
> the origin chip for that hardware: it is very close to the
> "KSZ8 family" but there are differences.
> 
> It definitely has a different custom tag format for proper DSA
> tagging, but I have implemented that: I now have to figure out
> whether to do that on top of this driver or the KSZ driver before
> continuing.
> 
> In the meantime, this patch series makes the situation better.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v4:
> - Drop the final "port isolation" (should be better named "port separation")
>   patch, due to lack of time to revise the patch. Let's keep this one
>   for later.
> - Hope we can merge this first round of fixups so the driver is in some
>   reasonable state.
> - Link to v3: https://lore.kernel.org/r/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org
> 
> Changes in v3:
> - Re-tag the series for net since they are fixes.
> - Implement mutual exclusion between .remove() and .shutdown()
>   as found by the AI reviewer.
> - Fix a typo in the patch dropping the KSZ chips support, 8955->8995,
>   found by the AI reviewer.
> - Add fallback compatibles for the deleted chips to the KSZ
>   SPI driver.
> - Implement port isolation.
> - Link to v2: https://lore.kernel.org/r/20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org
> 
> Changes in v2:
> - Do port_bitmask in another way and fix a bug where BIT(port_bitmask)
>   was used instead of just port_bitmask.
> - Link to v1: https://lore.kernel.org/r/20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org
> 
> ---
> Linus Walleij (4):
>       net: dsa: ks8995: Add shutdown callback
>       net: dsa: microchip: Add fallback Micrel compatibles
>       net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
>       net: dsa: ks8995: Add stub bridge join/leave
> 
>  drivers/net/dsa/ks8995.c            | 198 ++++++++++++------------------------
>  drivers/net/dsa/microchip/ksz_spi.c |  15 +++
>  2 files changed, 81 insertions(+), 132 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260118-ks8995-fixups-84f25ac3f407
> 
> Best regards,
> -- 
> Linus Walleij <linusw@kernel.org>
> 

Bastien, would you mind also taking a look at this?

