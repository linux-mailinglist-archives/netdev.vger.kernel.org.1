Return-Path: <netdev+bounces-44629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13B7D8D40
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F6C1C20F5D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42164A;
	Fri, 27 Oct 2023 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087B257B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:50:40 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645FCA;
	Thu, 26 Oct 2023 19:50:38 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28002031f06so918909a91.1;
        Thu, 26 Oct 2023 19:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375037; x=1698979837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEDdFhBEWomx2nDAs3Hi04Zp62KEgFzJ+9IawEdcmP0=;
        b=oAUH0o8gcWwSEgI4OQVhfx9DyNkYVhdG8pQqtJUVDrWEJ3C9h+nCL17YMEUhNikKlz
         JfTtUyCQFcdJjBzJuaN+qTYK6ThaHY3HX3nathISLENTv48BcWx7dqt8k6TNHxdr/IDy
         UGmygk3r5OjsBF65dmSxvnRR/QVYyFYGC1wPh3bfiJf6QcnKENRNHj2fetvZtL+R6MK/
         uCZJhN9Bahoj+sAndAmgtt3Qvo0xqupNIwkjsCaoHuyATWu/YI8aOylOU7mjWLREo1Gx
         N0lJU+CmxWBDoxEL9wNJ52vtbp22u14IcKZBsGIYci4FhOO8kHemzQT0Is9NRmaYBbBY
         RZUQ==
X-Gm-Message-State: AOJu0YyUqozF2VDs9gztRXT1JTkVFY8gEHv4SRMSOaHxtixsL8+Gqqlm
	OdsMV4jxTgn12QvIeKIdKInLk2GBZB+C8W7gvLM=
X-Google-Smtp-Source: AGHT+IE0303h2zVQIQ9mlZ4ab36TLNB2HCr6BvgRl3C6IGiFI0Mtp6Hf3yYr7BQuEv/hd8yyOriwlxxSsgcKt4hxc5c=
X-Received: by 2002:a17:90a:1a50:b0:280:9:8d0c with SMTP id
 16-20020a17090a1a5000b0028000098d0cmr1220448pjl.33.1698375037441; Thu, 26 Oct
 2023 19:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
 <20231025173300.1776832-5-florian.fainelli@broadcom.com> <CAMZ6RqJJXK5EyyOwXXbdA-bDTY=_JQ+xfKpoCHDJZqv+rNnASQ@mail.gmail.com>
 <CAMZ6Rq+iBazJ+fM5yd5Tfa8==DEGV93iD-XojU=f1m3ScSGEww@mail.gmail.com> <e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
In-Reply-To: <e6bd1a85-0bcf-457c-8fa8-33e68d818547@broadcom.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Fri, 27 Oct 2023 11:50:25 +0900
Message-ID: <CAMZ6Rq+HK8Ps2QZsqi1C5Dgjn=EDhT5hWks=T02x5AMqzXkNhw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] net: phy: broadcom: Add support for WAKE_FILTER
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	Daniil Tatianin <d-tatianin@yandex-team.ru>, Simon Horman <horms@kernel.org>, 
	Justin Chen <justin.chen@broadcom.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Joe Damato <jdamato@fastly.com>, Jiri Pirko <jiri@resnulli.us>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri. 27 Oct. 2023 at 02:55, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> Hi Vincent,
>
> On 10/25/23 19:13, Vincent MAILHOL wrote:
> [snip]
> >>
> >> This looks like an endianness conversion (I can not tell if this is
> >> big to little or the opposite)...
> >
> > Oopsy! On second look, this is an open coded cpu to big endian
> > conversion. So the question I should have asked is:
> >
> >    why not use the put_unaligned_be16() helper here?
>
> Because this is consistent with the existing code, though I will keep
> that suggestion in mind as a subsequent patch. I personally find it
> clearer expressed that way, but can update.

Fair enough. I agree that this is not something to be fixed in this series.

For your future consideration, I would have done it as:

        __be16 da[ETH_ALEN / sizeof(__be16)];
        /* ... */
        da[i] = cpu_to_be16(~ret);

da[] can eventually be casted back to u8 * once populated.

(...)

