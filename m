Return-Path: <netdev+bounces-307711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nkczMoJIV2peIgEAu9opvQ
	(envelope-from <netdev+bounces-307711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38175C01D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:44:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hDqK8SVC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307711-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 016123007AE2
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E93D093A;
	Wed, 15 Jul 2026 08:44:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49153D1712
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:44:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105083; cv=none; b=C0XeIUCm1Grq7/DGojihErfXnsNOXdSpTW6kEO8betbOd0R9Z4ATLiOG44QNX2sZVbZQcYZRZpWF1gnmDt/n6Lc80a2zXIFCN8N3BY7Y3txkDO5/e2wT0hz7qYQRLOshkDQCtbTN5TOnsOcXGW2KGwIvVHhdqv7Gk9pRE6SY9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105083; c=relaxed/simple;
	bh=N3wD4okQaCyl3GXAvOk7XCkD9tulNAH6mOxeuKKV4hg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okyLiv1bIrzStOi74fTNxyy3ohIlM+qaChOdap3CRqZbbpE3wW36q4IRFDX0rFJ62IfGk/s26qwfZzyNExNmcur0/EGFWqGb8+LuGbnnv0CmcgqdycuQ1Et3a/bne70QoXH4SSvY1geQvsce2N9dSApNcAt1I+nQTejCUgRnPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDqK8SVC; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so20047385e9.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105076; x=1784709876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hz7WPKd8nuv0g834JzI7w/vUzS6TIu2DOFmMdBw0Pc=;
        b=hDqK8SVCIWITNQGqRF/V2WYEiWU5oQglBAOoqU16mSqkwfNxZNko7n/9Ul0nFGnZ/B
         I5tyIIhhPaOTbTplQ3We+mp5+LivyBgPu9YPu37SMOOjwjD0BIQFm41qr68Q22Eg1Rln
         AUQZWJwBsBmacuCDbA4iSOc5z1X2WxRGfO8xw6bTgVb78rc7/41DmbTTXhtYRxeuA5eD
         Rtj4be5jBCwS8mngyizNerZaI+hiw+VOq3JD+b1AXzUKljgKXN2P5/5SbDd7FNBATOyQ
         WIZN9aASLXZauWpgcEVTJp/6mc6mpnQfYkjkrom34ThDXlUf3mGuwVBmAuNGYj9MWg5H
         SZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105076; x=1784709876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hz7WPKd8nuv0g834JzI7w/vUzS6TIu2DOFmMdBw0Pc=;
        b=Mie2oCEQsGQ2hLq8loVPZ3+pbFhYR04fGbWFgUVPBOvIyAnwkx0JAaffPTcGLgDhPg
         miObYitnaQISpPowfmJbXUNaBG1LPt4YCW/Tz7p331Abxrah0GAYLu24pSjHisSeStLd
         YDp4SFaHQ+suaGYa7hoH0euNnmCfr6ATVCKOgcBDTAMBhU1zcMepE/eb0DhVX6wF2EGc
         FZUCgJWc9OLYmlUe8jrZ5koekBQQeDOY/m5fIO7LAOyNRpi1CF6eiRQllLwOc8BpWqfK
         sCPintEMOAQAusiOgQ3y2hvqaiF9QkU+jR8hwsjAcw6NIYJcRnXp973BuxEYMbd0+o9i
         9/tQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2sOCH5S9T/xCy1gHrRfE57XosO9KUw6XFOQD335tVEkY+nJxe/6ujESYbeCydq31y9nRpgyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJHf3dQ7ziZsZfP7BdBg4aA0McugI5VVHUep2/wo37B1FyDQk
	Sg+mEegG92SG5zFBxFZ//APOeNEyhco6rwn3/t7tHO+If6BtPXbGIYH0
X-Gm-Gg: AfdE7cn8PpnQKQoZ+sCXTgfk7TCUJ9gvzD6y6/weYmavfkKxrLPcNN0Pw111prPzDrO
	C2Si4Llfm10gL1f6A5cf4TsLayLyehzgrZZzJG9OV5Z/E02ExZzLJppBoDL/FZj/0nWTeWjI/JO
	rfJ1Cg3TvENxO7Ix6IXySKgG18FtRVPbhYBJLSXkhXLd+uL8BwSlqOr+ME649HXIfDdsZCJdcJV
	5DnE6bszpjsHDiAOVdyV+92OVxl2R0X/7ZtW6yF3iI5tcNi5026wD3Au1SPIgGpZI7wC23Xv36P
	qYl/RxBet1mZnZJXAMfMxiNJQcw82aDGs5cj7tmyOCeYvoGqAjTQQ7WFYEaa+NlWWp7F0M74+03
	wz0jV8wn8yzlxPADK7EZ7VnYvxO2qg50cm1hD1EcBo7+/c7sEI87JSQi96K0L56oH+GA+xgukpw
	15iWaUbwsW145k09JcrwGx94/ecpqZ8CRRLpq7CBraiHc1
X-Received: by 2002:a7b:c38b:0:b0:493:c4e1:40a6 with SMTP id 5b1f17b1804b1-4953c28b6bdmr14477935e9.32.1784105076212;
        Wed, 15 Jul 2026 01:44:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-89-239.ip49.fastwebnet.it. [93.34.89.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953f643acdsm3214055e9.3.2026.07.15.01.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:44:35 -0700 (PDT)
Message-ID: <6a574873.3027643f.39eab0.b4c0@mx.google.com>
X-Google-Original-Message-ID: <aldIcfPxkeociXyX@Ansuel-XPS.>
Date: Wed, 15 Jul 2026 10:44:33 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org,
	heiko@sntech.de, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 01/10] net: stmmac: move XPCS lifetime management to
 platform drivers
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-2-coiaprant@gmail.com>
 <dc21b2fc-ae11-4fde-a5b9-09e2c6bee5c9@bootlin.com>
 <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALj3r0gWyfHHp0S4=71M1-TjgHKcgGax4Lr0DzPi37Q69-iCwA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:coiaprant@gmail.com,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307711-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,mx.google.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD38175C01D

On Wed, Jul 15, 2026 at 04:17:50PM +0800, Coia Prant wrote:
> Maxime Chevallier <maxime.chevallier@bootlin.com> 于2026年7月15日周三 15:31写道：
> >
> > Hi,
> >
> > +Christian
> >
> > On 7/14/26 21:08, Coia Prant wrote:
> > > The current XPCS creation logic in stmmac_pcs_setup() is problematic
> > > for several reasons.
> > >
> > > First, if a device tree specifies a "pcs-handle" but no select_pcs()
> > > callback is provided by the platform driver, the created XPCS is never
> > > used. The phylink framework requires select_pcs() to actually return
> > > the PCS to the core, so the pcs-handle property becomes effectively
> > > useless without the matching callback. This is confusing for developers
> > > who expect that specifying a pcs-handle in their device tree should be
> > > sufficient to enable the PCS.
> >
> > I think Christian's work on fwnode PCS would help a lot with that PCS
> > handling in stmmac:
> >
> > https://lore.kernel.org/netdev/20260618125752.1223-1-ansuelsmth@gmail.com/
> >
> > I don't know when Christian plans to iterate, it could be worth using
> > that new fwnode mechanism here ?
> >
> > Maxime
> 
> Hi Maxime,
> 
> Thanks for pointing me to Christian's work. This looks like a
> much-needed improvement.
> 
> I actually spent all night debugging call traces caused by the current
> stmmac PCS lifetime management, and it was not a pleasant experience.
> The code feels like accumulated technical debt that should be cleaned
> up.
>

Yes we also got a similar situation with an ipq50xx SoC where the
standalone PCS feature was implemented (I can add reference to OpenWrt
code) and we also had some ""magic"" code to implement PCS as it does use
the DWMAC plat. It seems for DWMAC PCS is very abstracted and have at least
3 different implementation aside from the common "select_pcs" one.
 
> Regarding timeline: since Christian's series is still in RFC with an
> uncertain merge date, I'd prefer to keep this series as-is for now, as
> it solves the problem for Rockchip and has already started receiving
> review feedback. Once Christian's fwnode PCS work lands in net-next,
> I'm happy to rebase and convert the Rockchip glue driver to the new
> interface.

The series in RFC just because i posted while net-next was closed but it's
not in RFC state. (sashiko is starting to hallucinate problems) I plan to
post v10 today but still low review aside from ""lovely"" bot.

> 
> One thing I'd really like to see: the ability to specify the logical
> MII port instance via something like:
> 
>     pcs-handle = <&pcs MII_PortX>;
> 
> That would make the DT binding much cleaner and more flexible for
> multi-port configurations.

That is exactly one of the main feature of this new implementation as is
already used downstream by Airoha SoC where a PCIe PCS expose 2 PCS from a
single provider. (the code use the simple consumer/provider pattern and the
driver have complete freedom of applying whatever logic is needed when
returning the correct cell)

I think the idea of Maxime is to test that series on most Scenario as
possible to verify for fragility or regression on it.

(but just for Maxime the feature is getting actively used on OpenWrt by 3
different SoC and no complain for now)

-- 
	Ansuel

