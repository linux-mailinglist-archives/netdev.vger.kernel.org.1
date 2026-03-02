Return-Path: <netdev+bounces-262650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I+nNquOpWmVDwYAu9opvQ
	(envelope-from <netdev+bounces-262650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:20:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C201D9A9B
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C299304A564
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90C63E5574;
	Mon,  2 Mar 2026 13:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397523E556D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457336; cv=none; b=r9s1zQEJ+WoeODkwetMYJuT3L9c874RdmABT1vmR8jDae329aqM1hAJK+b+jNfh5Ou8pGjJRm+Q/z14LYQe1EYVXiI8dfAEP9D+E14O7Hmj9Ihq1HzA+KQCqOKfcYTjFYIVY3+7HRr1jj1IvMlKEt24DNR119wc7/knHZA/2dV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457336; c=relaxed/simple;
	bh=3/tNQBlxAxPEnfAoowoCr4sgDFqwDGoKIoGPrU3zXtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsqJFt8czWwCix7HexgbcR9foPdx3Lxq8FSfE6P/M6ZgpsTaCNuyY+VLkW/nMWgDpksKqK2Sk2WQgSQ08knUOQqBXu4HZuvD1PlrkPLDS7fFxOnbzuDyI6rQFGxDFOPNoyN26+mmTp8ZKl1gaPBonEdCfS9Ck7lNF2YxUDwsVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso1488735e0c.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457330; x=1773062130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGMM6AwkrUzb9vYDMbSXuus6cNzIRf/v6/quBOI9l4g=;
        b=LBDSeigrmKv77RoIMn1RIfk3/wmaINneBuZtukKLXgNtbbkFZhMANEoe+nBmyK4ST2
         Xc1TaKXYJanKZob6t1iYccPhKDQ0rbSMYbFhizB3YfacMJIhko6Wgv5rJ2x+vvFC0pTk
         y9vfgiFOAAWlf4p3C+87Mntk4Sjj/3i9iP76J3oMkkphgHpL0RvQVajfJt4nsKqf10vV
         VNTUEO1VX8koh0eSbkOImmZqnrHKb3Z9vQO2cJ/1PwBwHLfk+2s0/n2hS1Ap90x0fZna
         fCFZJxUSdfW8VXXv1VGNVLpAIKLE5M77CU9bmYAnTGaImNyalTFobVBnapouR9zjcn/V
         BaEA==
X-Forwarded-Encrypted: i=1; AJvYcCWA1utKJRNM1R36j3E6qdzS1ZcS4yX/pY+oyFDbDmCCWgmMUW7Pcv5vOoVIgZIYI3LqK/xEPbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzJXCnQhlRGu+rXbxV8FYlPUVqCTtUK9ooxdr1yqVL7ll2PHG
	UaSdJC8Tyn++rP+2w0/apgrZr7Kwp6c1ujYDijRcKtR813OLNmomN5pE4V8u0+Ni
X-Gm-Gg: ATEYQzzoGZoadSmR+T8P4VEwtcpSzlNv1JfMNkj6s4UemuR2iCVji5PWPnR8kG94/Gs
	37lRFMWk0KomtWPbXp1+VRYfcyBRw53j7gt/EM3PxEPoAf6p7sLr9tTRFGIrh9+juj//0oLe9c8
	nqxcFAFwu3bKM9QTpBAsINiDpWpHsEm6D9HdvsRnFun8Goqi7DoOdz4Vtx4/ZKa/6qAErMUo7Li
	AHTZDqUApPjJvLNOJ0ohx1OTWYkP9T7p9f9xgtypRQL/Qy6kER6bSRWMHUWOTOu/I22mnsamBRj
	XVG/ZOQGnwnTPyMKr3W9iBgtGuuPtTSCrjRw86QaxDtKOxH6xUC5TXZanuVqBDHhIDHqPV0EyNf
	bvksyi/HHrEQXH55M11Fe3RtpB+6IbXhx3I1NEWKFd9hMAkU30W6ZXrcMHkjGBh7V1incpFYnCQ
	L2+Yji8CNr5AEKCBuWB48199zCUCa+Gq3R6ehbOJhZSvfEy/V/QQLoqI/7kzQ/syEH
X-Received: by 2002:a05:6122:4d11:b0:566:341b:4deb with SMTP id 71dfb90a1353d-56aa0a9e637mr5069992e0c.12.1772457329663;
        Mon, 02 Mar 2026 05:15:29 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65c4951sm11795982241.14.2026.03.02.05.15.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 05:15:28 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso1488713e0c.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:15:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhyLhEJyrTsdoXLrwtjQKuWlXUn0fnxcHR6RaQqbKRIGRQBh0+ob2FFX1pPEXpDe+NAnNXLlo=@vger.kernel.org
X-Received: by 2002:a05:6122:2a01:b0:559:67df:5889 with SMTP id
 71dfb90a1353d-56aa0a38ceemr5011229e0c.6.1772457327826; Mon, 02 Mar 2026
 05:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com>
 <20260228180821.811683-2-seanwascoding@gmail.com> <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
 <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
In-Reply-To: <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Mar 2026 14:15:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVG=QR2iV=fUmdCvyguyYqQ98qXo3sKdL2gHzmLABMDA@mail.gmail.com>
X-Gm-Features: AaiRm50L9GoWm8b9Xv6BlZtnfCsVOO5Ue2-h72ixnE32z7WEMc_ot1ZvfsgtTwo
Message-ID: <CAMuHMdVVG=QR2iV=fUmdCvyguyYqQ98qXo3sKdL2gHzmLABMDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Sean Chang <seanwascoding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-m68k.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.116];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C201D9A9B
X-Rspamd-Action: no action

CC Andy

On Mon, 2 Mar 2026 at 14:13, Sean Chang <seanwascoding@gmail.com> wrote:
> On Mon, Mar 2, 2026 at 5:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > This should have been fixed alteady, cfr.
> > "Re: [PATCH v3 0/3] sunrpc: Fix `make W=3D1` build issues"?
> > https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@o=
racle.com
> >
>
> Hi Geert,
> Thanks for the feedback. Regarding the patch you mentioned, I've
> actually addressed this in the v6 series sent yesterday [1].
>
> My v6 approach is cleaner for a few reasons:
> 1. Compiler Optimization: In v6, we don't need explicit
> IS_ENABLED(CONFIG_SUNRPC_DEBUG) checks in files like
> fs/nfsd/nfsfh.c. With -O2, the compiler already proves these branches
> are unreachable and optimizes them away automatically.
>
> 2. Eliminating Redundancy: In include/linux/sunrpc/debug.h, the patch
> you cited adds no_printk inside an else branch of ifdebug, which is
> redundant. Since no_printk already performs type checking via
> ##__VA_ARGS__, simply refactoring the macro is sufficient:
> -# define dfprintk(fac, fmt, ...)  do {} while (0)
> +# define dfprintk(fac, ...)       no_printk(__VA_ARGS__)
>
> 3. Reducing Stubs: This also avoids the need for extra stub functions
> when CONFIG_SUNRPC_DEBUG is disabled, as seen in fs/lockd/svclock.c.
>
> This v6 series has already been reviewed by Andrew Lunn. I would
> appreciate it if you could take a look at the updated logic there.
>
> [1] https://lore.kernel.org/all/20260301161709.1365975-1-seanwascoding@gm=
ail.com/T/#u
>
> Best Regards,
> Sean

