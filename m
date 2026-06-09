Return-Path: <netdev+bounces-297021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WeseLuf3J2rW6QIAu9opvQ
	(envelope-from <netdev+bounces-297021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:24:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A579365F738
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:24:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="VYF/dd9s";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297021-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61194300FC8F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12D3FD13E;
	Tue,  9 Jun 2026 11:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31733FD14D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003611; cv=none; b=B6TmJKlqy+F2l5dJx8U+5cYE0d4evbIBh4vDYGUnjEVkLGWbWN+MInsmhhMF2/AqwGroNiqFJaiM2xFH8j7gjPmj508eQgE9WglkL8uSbMyOLpNSd6oPsk821+onsncW2VqdljjGWOxkypIGMWOBevhl6wg0rqXzxB+y4p7A/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003611; c=relaxed/simple;
	bh=ouNh14TYBwCREEsEiR68guasZnC1K1bCFOcICPuwNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGtWnBTkh06k+zbvz7s0yBXY8yD4XZyk4CfiZ0zyTqcI6owKxefZAIWHJCH14jcsSYpffGhqfzJBaLCbjQA/dEjorcFOcIYfj8uI0z5NR4Jh3Pld7oAl3TcCooZx9AB4O+3Eow8XfnxpU4bVVjWYEgpU3XLm5MT+9Q/AaxD7EMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYF/dd9s; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490a76757e5so35059865e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781003608; x=1781608408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFMjAZhUWTXQaO+yulTsj8OKBz24W905gLvHUSyY7n8=;
        b=VYF/dd9srMGHiIgdE3bFS6jhZ93uqofR7GTPhUD18otjpcfW/lK0tBylWBgeSrxhqs
         jtK7m0MDeA1VQBQKiq1Hm5B5b3qjXEV9bnSTP1jzPgBQK2tklIpnoHZL3Eajjx08CG4D
         Un+yb+lyImfttCwZ9w3K018xQZe/GGuR0GK6jtex1HchlBhaERp7+CAJ4Ts7gj9FvlEN
         AgUEDB+I6zWR8pT0Pl4sxLRy9rGc1OR9PYl4odGrhNQGRbRg9IjJKH3LleLg9JcqHWB4
         YFHbm8vWZfa1uWvQV2SsN62+k7JzHZBiPSvP5WHi8Jv8Zmg0OEWPAqQ6+nZ1GYCOxh+u
         tFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003608; x=1781608408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFMjAZhUWTXQaO+yulTsj8OKBz24W905gLvHUSyY7n8=;
        b=sCw5oeBY438teS3SU1UGZN1latVcHuOuA6SIj+sFdU8QWsJ74T9yfXd5ii3zcI62n9
         ZaNii8nPE5qShnFfqKL5a2SdnBcBSdJZuikbsgIvb9hiNy9jlHobNOJKcmDagO8qwmQR
         pnudk63Rm1/GOa5skVetc/8WBknohVpPq1kE7XhWEde0znE77l+zL32I2G9E/08RkROp
         cdAsw7qitWv9l5BwNO/6LqOyXXo8DU/6L7ZC2NlDVbrlx0/8WTs79yIDqQDaFHzRnY4+
         JaF/w8Y3OVHZn8V0Hd6YE4YLTsk7+Gmjj8hlmzbubkbhqHVLiFluoC1iBNQkt8VBgHfY
         y+iw==
X-Forwarded-Encrypted: i=1; AFNElJ9T13aWNdejK7o+RQfrt8vET+5yOJcmAjvKHZ8jGZof6ttF/EZb7NGiArQcogvBRulTXKYfPPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwztSwPEXdHDLxjO+Gz51ohgOuTJUxe3yyyw+kghXtIQ6p6tgS7
	LywgCH7iZ5f05/sk0poagZ5be1qjZ86KA/mLXg2pXwbZR8cxLD6SM6eS
X-Gm-Gg: Acq92OHBER7TDwaZdszrqjKJjK6SBuEqMxPjl1IhIrqBnnN+Zk3LKTMAgqBuEHJ49tF
	vCdRN1aBv62vL6NeU+zY83ffkPAE/3xXuQVmmMwbfnPUK2IJCEykykTUfS3PBl2T70zOeVNHYf5
	pGbroZCBibRhB8IORxYCL/8bBNbZwjHJLkmV1DOtzKB2AaaOhs+P52J/QOw2StsKkUQ0i5fGZsh
	6nl5JCuXFvNtdiCAWBO2/gVxVDQzP6JFRnZRI+wgajAi5s/+VRaK78bQYl7nvsEDMTXm0hJth0l
	yFQFoOInuZc1BkQPEB4eweMVwW5guX/lW3PsKtLGAVxk1qBZTT5G86i76/EhY5swsBxeHJIfSHU
	3lKXc0PHhrCuad0cLCvQo9vuDGSnjtWoc+IrUs0llNCLSBvbx9MnaLHphfKLqzUJAyueYrQZwbf
	5AlN7S+Q7i0iypGGa6aKFi9o4OE75nW3BhtbXqHsLf9GF0Ge0sxsZ6x5KYZ3FEG0OKIbmcPToP9
	DBWFb0UthxDiD3PrC0iPpnOdwg658801L2QD3pe+LnL9H0=
X-Received: by 2002:a05:600c:8285:b0:490:b1b8:95f5 with SMTP id 5b1f17b1804b1-490c25c2ae1mr335052495e9.15.1781003607911;
        Tue, 09 Jun 2026 04:13:27 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-1667-23af-a166-4689.ip6.access.telenet.be. [2a02:1810:cd14:9200:1667:23af:a166:4689])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm58920642f8f.16.2026.06.09.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:13:27 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:13:25 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v6 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <jrilirqhtwwuso7pzhh223g53whwyahtp3chwjrj3gf5o5vpvu@g3uwjlariagf>
References: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
 <20260604-net-next-mv88e6xxx-cbs-v6-2-b68c01142d1e@luminex.be>
 <455e779c-9d13-4f9d-9cf7-3b639e665743@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455e779c-9d13-4f9d-9cf7-3b639e665743@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:kabel@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,padl.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,g3uwjlariagf:mid,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A579365F738

O Tue, Jun 09, 2026 at 12:05:41PM +0200, Paolo Abeni wrote:
> On 6/4/26 3:44 PM, Cedric Jehasse via B4 Relay wrote:
> > @@ -5679,6 +5686,27 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
> >  	.tcam_ops = &mv88e6393_tcam_ops,
> >  };
> >  
> > +static const struct mv88e6xxx_qav_info mv88e6352_qav_info = {
> > +	.rate_unit = 32,
> > +	.rate_mask = GENMASK(14, 0),
> > +	.hilimit_mask = GENMASK(14, 0),
> > +	.queue_mask = GENMASK(3, 0),
> > +};
> > +
> > +static const struct mv88e6xxx_qav_info mv88e6341_qav_info = {
> > +	.rate_unit = 64,
> > +	.rate_mask = GENMASK(15, 0),
> > +	.hilimit_mask = GENMASK(14, 0),
> > +	.queue_mask = GENMASK(3, 0),
> > +};
> > +
> > +static const struct mv88e6xxx_qav_info mv88e6390_qav_info = {
> > +	.rate_unit = 64,
> > +	.rate_mask = GENMASK(15, 0),
> > +	.hilimit_mask = GENMASK(13, 0),
> > +	.queue_mask = GENMASK(7, 0),
> > +};
> 
> Sashiko mentions that the above masks are not consistent with the switch
> datasheet.
> 
> I'm quite surprised the LLM could check such fine grain detail, could
> you please double check if the comment makes sense:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e%40luminex.be
> 

The datasheet i have doesn't mention a QPriEn bit in the QPri Rate register,
that bit is marked as reserved in the datasheet. That comment doesn't seem
valid.
However, reviewing this i've spotted a mistake in the hilimit_mask for the 6341.
I will fix it.

Cedric

