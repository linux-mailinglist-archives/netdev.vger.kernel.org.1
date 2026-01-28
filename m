Return-Path: <netdev+bounces-254412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ADUISBaemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7DA7E1B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99C2F301F9D6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D284E313520;
	Wed, 28 Jan 2026 18:49:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FE224AF0
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626141; cv=none; b=sGO4CKze1o5+Y6VhbDhI1v73JHj578Ghgl48GAZIomgFa5MhLVmo+CAuXyM6xzT0UqbC6zHZP4YQgLTpJFQqBBZdM6w4vpsapJp/UQUR/r6UWzMr2+je0mBNFx+EIZamYMlUcQYPMmfnairvxmsEoSAJGn+seNTFKJ54DZyUyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626141; c=relaxed/simple;
	bh=P8xj2BK8FjGDivD9OkfHZ4E3MGOAuE4ULGgWdPW5pgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOwHeJh/cixyTMYRaXwsVEkwHbgGxVZGIpjXXH+k3scYGteAlY944OZ2Ux2NzsrElVCmkegREzto4uZEzhXgYW17ADne3UVDLi44ey/ORu96ccF1IRgj+NXbQ2TFcnid+eeTDLKfINDG6Miq2lS2+DC9uUdEuhVtfB2/0V6cl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c6af798a83so25423085a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626136; x=1770230936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t6SLqjvsNW00Dj2Hjf4deNPVV8qylbppXyHu+3S3LI=;
        b=Pig4TJqCceabQ465pvIWFAbchgSwnglzTRBqOWrwbxJDWsexeU23Pg5ygzCJiO2mJT
         0axiCM3KQmQGCRPb4BM8eaH4bvlhY7AKHm6KAWU+mLsqDynyo0C7JTN77TM4dPE/GyJZ
         XDkbE+aCSkEZ+NIWH/SL8d5mFFQKcX+UtCMTXaNK2NY3wqqsYPt6jnVjWtnVTeifuen+
         pTsQCbjs0s3pvu7giis2IMBGe5HdG+fcH1mg2239sx9QawXSk2tMhxw5zogkdNLLzp3e
         IXzPxZQBasNyZXWdCYxSC6wqvPh2o1W7KO7VeNruCRYoS+we3CpaCV9TQ2gIZ+wQGAVp
         jINg==
X-Forwarded-Encrypted: i=1; AJvYcCU8jbG1Ccgwtz6DBKlZAWEIpoqTAR30+6WCd/ZRKog8GKiHNkHDue+ziaZf8Cmc/BItiO8/Aos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2gWEn7gyAQLGzUS7OA/coFUjcRiTkAY9JYCpwdLh9KHVfgGO
	fkrMBq2STg7EqeJEwuF623gFy3T4OO6RvP0LRaM74FTeZ6CGYfJEWLyGidoyJ48X
X-Gm-Gg: AZuq6aJYuX+ulnEo0s0LkDhRP9WoYAU7+Yic9/ZX7i4cxT7ERm8pgwiVmmJA2gLRwJY
	qPRqqR9HliQfJeCRawdJz7OmLIftl/EYje6vMfCP7qIMX7Lw2+cjt0BYVnHpXYVs7nwGWJORSu+
	im8THBf+ctIXC22TRoAH8CL31IHZbrT7ONPuIX7eBc21ZCt2UeNorDNLDo539ZMkCaOtJwZAQT2
	bugkQea2GLJXbYi2r0n+8GOANWRBCWsug0bHMBDubafnqnAueutIIZbW8rUNmxi7hkbegPy/1Z8
	ZH0n7s6xLgrnbdqwOjv/r7vgWw9OD23osr3dJWnRG/lf4xH7cExt+mYrlO3Nk6mT8RCV3RoDzN8
	3a17jifQKQGZ/5U3U62ze3zLyWXj4a7oNzzZ/EmLCmqOVFAsYgxobKCQw9dmJedzGi4Cp2292Wk
	1Rb/Z0Qws1icYOASZb+g5Dm95psxd+nM7arHPG+xlFC8WBaXPjTJ4c
X-Received: by 2002:a05:620a:c47:b0:8c7:b0d:df23 with SMTP id af79cd13be357-8c70b90a75bmr860606285a.79.1769626135799;
        Wed, 28 Jan 2026 10:48:55 -0800 (PST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d61c6fsm233602585a.47.2026.01.28.10.48.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:48:55 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c7146b0854so21435185a.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:48:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ79kkiM7xcY1nxzqjpZjc4eMadcfj9stD+YAFkl0U3zrS6XHAPMlSuJMrUCIrDAEXKsCAYdE=@vger.kernel.org
X-Received: by 2002:a05:6102:948:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5f72378e7a1mr2207053137.28.1769625713444; Wed, 28 Jan 2026
 10:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Jan 2026 19:41:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgnVcwo3b=zQx0wVcH53dm6kBz3nQ5T0DZat4KxastuQ@mail.gmail.com>
X-Gm-Features: AZwV_QggK5aoCgxDwMwUamFclvyMAvDW7y1KAlSqyJcViMQkB2_vluWrOqhRb1Y
Message-ID: <CAMuHMdUgnVcwo3b=zQx0wVcH53dm6kBz3nQ5T0DZat4KxastuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/8] Add support for Renesas RZ/G3L GBETH
To: Biju <biju.das.au@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254412-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,foss.st.com,bp.renesas.com,st.com,synopsys.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DCB7DA7E1B
X-Rspamd-Action: no action

Hi Biju,

On Wed, 28 Jan 2026 at 13:58, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The Renesas RZ/G3L GBETH IP uses Synopsys DesignWare MAC version 5.30
> compared to other Renesas SoC such as RZ/V2H that use MAC version 5.20.
>
> The RZ/G3L GBETH requires an extra clock compared to RZ/G3E and has pps
> interrupts. Document the Renesas RZ/G3L GBETH IP in bindings and enable
> the Gigabit Ethernet Interface (GBETH0) populated on the RZ/G3L SMARC
> EVK. The eth1, pincontrol definitions and hotplug support will be added
> later.
>
> Biju Das (8):
>   dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
>   net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
>   clk: renesas: rzg2l: Drop a check in rzg3s_cpg_pll_clk_recalc_rate()
>   clk: renesas: rzg2l: Add support for enabling PLLs
>   clk: renesas: r8a08g046: Add support for PLL6 clk
>   clk: renesas: r9a08g046: Add clock and reset signals for the GBETH IPs
>   arm64: dts: renesas: r9a08g046: Add GBETH nodes
>   arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH) interface

Thanks for your series!

Please don't include "net-next" tags in patches that are not meant
to be applied to the net-next tree.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

