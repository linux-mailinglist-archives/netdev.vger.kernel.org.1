Return-Path: <netdev+bounces-274641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJI9FieqzmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:40:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2F38CA34
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 161FB3021401
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF783287503;
	Thu,  2 Apr 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VosoSq2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E12DEA64
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151588; cv=pass; b=boYQIBUWogjH4JfD117AebMOuyZMiWrNZ8kZ51O3kJsxpKWt/Iko7braLycJFf0rEgg+wTKQpVgH2MlZqVjHK/ggpSD4bkOyqQcmdLE2q9Wnw5FMNlsjZkEK1p5+maREcQDgeMK4O6JYwSuVCSCNPu/B5y4TtBCTgnUuFbEpKP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151588; c=relaxed/simple;
	bh=+uPvnhmls11jZMJXidvzLVFFEk2TWAWWR3yks90JsY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXSOCeyFj7b7Cn4y5f9ImTvvzaqAvqAr6vpsY5bogtPWURxngfBetV0pTXVfdWmbegefJOxlKTtcrSAj0rKxg6gio7s2oEj2nCce4okD8QR9WN6jby9Rro+zpntldmX1yfEiqHwAKa7vjul0rWhb8JUJ6dpgltFxOCJHlezQtug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VosoSq2S; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486ff201041so11568335e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775151586; cv=none;
        d=google.com; s=arc-20240605;
        b=ch8e9RpJxQq81sQpL9irkptNwFu/mvD+2v4AzQsR8Z299KDaLF38rTFxvu+6bYxMyQ
         6Xn5ZcI4nTOGFi1gEY4icRxeZcMMk/zYyyHLHcYMAZ0v8OEr4CArFseZKvicnGlxgl6b
         0JWSxIwcx6xLvVewXSbK7xjiFAZ1lhcWnTOVp8POvltpM6Hs68HBJ3dL0tfOkVXdgp6K
         RDRwRw7ZxqXWeyQbbPnb6Q+aF5lKK9pCVfX0ouvivhly3AQnoZHHg0XvHyKe7m6C4hPv
         3x5465TKXhdmUt3tEpQJsWaQ6cEGPTZBtresIQ7vSIrUYrmacJFZLD0nnhq422ujhrLp
         IRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uPvnhmls11jZMJXidvzLVFFEk2TWAWWR3yks90JsY8=;
        fh=hsNtefHwznXlMTIKJ/V1MpNE0uOs++Dck1nnD04NwGE=;
        b=QNK1sp/2RuGg97PNGFlRiMqYdqnOqsq7nWaEXnGDLD0knjZi9YdlPEDMsPy4c0IadT
         fU+n9zejFKGDVXvuHek93pLQrHF/+Pvh7tGMEeL+jHGlOo0nzCpz14Ni9X79oP1Jll8l
         TF40HJVOtVLG7fiL4F0vJpLba9x/ylU76u33VRLVQEEe2Fjf7Qn+rSOJ9oLQTyG6YYsY
         F8ysO0vFEFz/CpJzjz30uvs69cD7bJFf58yy1bKpanqHGdthBpUKDMwH0XAPw6o/5nPg
         N4AfK3LG2cP9X3YK9L9imW5M0DLJILjwR35GlKKMYRE66YQY1tBaR2a7oMYMWu/EnR38
         1cHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775151586; x=1775756386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uPvnhmls11jZMJXidvzLVFFEk2TWAWWR3yks90JsY8=;
        b=VosoSq2SwyFRhFLROv5ApLjh43j9uhhBr5eZ16KytWDmGh0o89V0hx+THPCNQsR2V0
         WhsAcig56pBW9NE8EFyJRR8BFP5hC9gk+Lhp5ohm2dbBCAQfa70dEyvRSfCqqDqL4Tsx
         wh5l4UjceCsczaN1JGtC2Ly6FRd/+uu6Xzg98kV2gPQdlV9c+ib3xE0mD1OPDQ8ReFQ8
         5y2rK62qjE28a8omNbCeF+9wQV59w0XvALReuAXl18Wx9/MvbKI+W9K0qBd5pRde2tju
         pzfutlt0xiX1DdfXjLjuol3wXsJUXgbKx9mruDG0zOtGjz0o9hGGlRykoIxUM1zG7YW6
         7YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151586; x=1775756386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uPvnhmls11jZMJXidvzLVFFEk2TWAWWR3yks90JsY8=;
        b=GIY20s5rh3A88WK5j5CVwVHwdUzKvyESYnH120pFTDhbuElQ+XV8TzSHe9N6U0mUA7
         uZAl41PxU16g+q3OTVkXG0HCtnYZ6lG/NH1rG3FAgRtpp/lPrSYb1Z4ZMpQx3mCXBR/w
         tJUXU9kWw19CWGgqnyeUKCDN6dSR38QFWkoDvXvhDvjmRTHqxxjPOgghU7ZO9dMBmdXT
         vc2e9fDQqpBS2nipD98lTu4x6MD/Tx8/wTbG0frkem5lSHPSzOR5HHUe9/WJNLr/Zm23
         wqp5HbSmEFetPzs0xSgTU5z8qHWSchpQLtXIv8z3q2+Xkpx4GaVSBhl8/yf8Ee59O1lp
         /tsg==
X-Forwarded-Encrypted: i=1; AJvYcCVJApJhMqRt08mUcdapYwXgUlmZG8Dp7R9E+Aw64AyNYweh9ddcige4T/P8QYxqGdMgjW6HyeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAqp8w83sUGyrG0YD8S2ZKSHDpSkvzqcSSO0pMZMdEJHHyDnU
	zSFGl7yA794zEH5NJUTIgR/u+4QuwT1bFg0sGGClIqxW7pnkGf5AF5zZoBK2/FjJTw7jlQXTGRH
	zG9xKT+IrnPC68eyQZsmYi4jrnku0gYc=
X-Gm-Gg: ATEYQzypnH2QcqCQHOcIYu+R2DltPL8KAKlaARn2FuQ0NGjEycyqOf59vHht58AvOqp
	LPuq2Ta/EiZdtSXzWWd1tQmep9MEoX5QdcSosRRCmdEidCOi/j+5kKOn0wqJVxNx8AFZJRMOhKX
	iBkbD1c9JGo9DAHPFp12oQXfmdIihCMKYXruNu1u1+icAwvgjw/qH3jAvaxjjqK/9jG1Oiw+PR+
	/hTheNCM8qIUduGbyhFe0/dEjLahTNjCKO4bE39qcg5vBOZ8gchVfTI3RT6Oc5C0gUFZTtTMPLJ
	YKwqd1CLqNJTE537sPSmMHZZXPrpYlHL2FM/yaz7
X-Received: by 2002:a05:600c:68a:b0:488:90ac:8f8d with SMTP id
 5b1f17b1804b1-48890ac90fcmr32178355e9.16.1775151585540; Thu, 02 Apr 2026
 10:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401041929.12392-1-CFSworks@gmail.com> <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
In-Reply-To: <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 2 Apr 2026 10:39:32 -0700
X-Gm-Features: AQROBzDUcpqQpe24gMH4zeWd5eqMpRIPwUS0ch-pgokIhwXtjepCY0luOnTMD-k
Message-ID: <CAH5Ym4g3pbU_bWzMwJMdhEFv4K2sp3pty3g04=0=9Z80_LzW1w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory pressure
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2F2F38CA34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 10:16=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> I've tested this on my Jetson Xavier platform. One of the issues I've
> had is that running iperf3 results in the receive side stalling because
> it runs out of descriptors. However, despite the receive ring
> eventually being re-filled and the hardware appropriately prodded, it
> steadfastly refuses to restart, despite the descriptors having been
> updated.

Hi Russell,

Just to make sure I understand correctly: before my patches, you've
been observing this problem on Xavier for a while (no interrupts, ring
goes dry); with my patches, the ring is refilled, but the dwmac5
doesn't resume DMA. (Ah, just saw your follow-up email.)

> Any ideas?

Off the top of my head, my hypothesis is that dwmac5 has an additional
tripwire when the receive DMA is exhausted, and the
stmmac_set_rx_tail_ptr()/stmmac_enable_dma_reception() at the end of
stmmac_rx_refill() aren't sufficient to wake it back up.

I think this is new to dwmac5, because my RK3588 (dwmac4.20 iirc)
happily resumes after the same condition.

You gave a lot of info; thanks! I'll try to scrape up some
documentation on dwmac5 to see if there's something more
stmmac_rx_refill() ought to be doing. I think I have a Xavier NX
around here somewhere, I'll see if I can repro the problem.

Cheers,
Sam

