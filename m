Return-Path: <netdev+bounces-262649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIzeHCWNpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:14:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 755E01D993F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F2123015EC1
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C33E0C51;
	Mon,  2 Mar 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpD9VVJ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69035AC2B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457224; cv=pass; b=qfKL/RXsC46TCdqwpjUFUXFxqv2hePHBsMZcrw7m5aW08g3Sr9dVC72mQlYHYjmo32FA1rVEFkAHGQK7OdANf89MWN9bqWbDU2KJjSia5VZjaI1f5LDK+Wv0O6GWxWWVf/u6sdNoMx15pJHw+gjg6rJgt0ll9VD8mrYLMhp+oDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457224; c=relaxed/simple;
	bh=/xyQj50DpqxvizZBsCNSCIK6AmmQzK7MlnNIxtbk2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlICWyREvG1PZMs2R26wBiyvQrNmZhkidFlJf0C3fKwM0gXpBSZ99nV6tn2ymhOjM34ayssOA7xBN6knEHkuUKLWCCp/Erfa7Bdp2+dwTYZjjkJYqpFfbPO3Y6h9ze0IS43Od3VJFXPBmEBna3qq8vQ3irRsTo8GGH93a8Jay4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpD9VVJ/; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so968990241.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:13:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772457222; cv=none;
        d=google.com; s=arc-20240605;
        b=PrYP7dtfe0t888p1DcI5Mt3AA3mML6TB5qLgA0HgS2RZb1V7JbHzTMxfqdhMwopToI
         uqKkurVnOxS3WtQkQ6bQlIZxziftN9gwm0/X0isA5TOSAvvlVv6TH63QRgHb1PKNRqqb
         czJk4yNDYoIcHgJvOm22BbfNC+dgVkC4mVVXhpkx8unsKLhIxtH0vFVOaJjuFLQZuE/i
         BVj1NPKkXSE8on8JX34jv+RSVdpZd6+XRXs/y0Vd8DVPGgnqj6Frc53VraBOFT4b40IY
         boSmDo+hx98YU1cPlobVExedK35YMeL5/ybLnrA+SgtEHq/uPoNXb4RHTjYrY3PhzSQC
         LZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        fh=S64tf382uzwdt8V84p3eYWEBFVj4NZ67VhKEY3/vO24=;
        b=ZCSmqIaKFoT8HjGJBs56PkrNu8uwemLw4qUfsScdXVvF9b7MkkYHodpJew4i50o6cE
         eZPbQIPg0tAakCEgKSuxROg59eEffdti+MnWadUG2AUptSNxp/yYY3ECwa8nrDDUpAbn
         FFppBwjPvSlS/LsVPhj8TWSsxYM3xpp3z8YWS0nBmKUDHd5Us9KqIqiJHi7wqK0cZ9BC
         FRWaEfqjsn8qddjbSFzSyucQeTw97Cum9LJzL75Oo8qThVG/FAYjoLVXADkY28ArwCVO
         brxSKbvYkDit4JuZVCGsLUeO8b8jTeWU0qdNF1WvOOmrmltCo8E/KobKO7neIurSFY8q
         GnXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772457222; x=1773062022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        b=UpD9VVJ/t6QUSUbAIxlAqMGt3A3Qoj0V6hAFkKGn3Cs6IlCIVfST0Q2ByFWVKIfR6D
         3LyaTophT9pQiUtKVvjMAGLvJ1LJCfRZjRfEBRCrNJ79LH10GJb36EbTHhNaZFapRolq
         GulPdr/ORxIjrX9+m1RuHeRtDhaZPt/NgdzMFMY6lSQzFL+8SS1ffHK+RCBG0trvo++R
         ICJVHg4A1msFDVlDMYadaMBIJWc86V6l8NAWapQeq3fSQY4xDIYwovKgrVZnkvmRXjPZ
         ZTZ44ZK+ouLysp4sCq3N9DgWYZW/NkHcKA9VDheNM3WHFIM8tfxtvLDUUbGwxuq3k2QZ
         fbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457222; x=1773062022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5SW+u+DtecVJFoKUfzmKBIG1+8jq8Ae+IcGpfHwxLw=;
        b=Ouz5o7tlG16MeZQuXmY4P46gLJY15nVTjjo4yyF4Um3QFpjOdw4busTFaJmQP1NPOe
         dnsgxBh9nBA4gWPbBew6Zhb4gdGapKKY8a/4Rsejx7oIR37opa93y2umpRgBOmB+qwkr
         5txvqJzank5BgGhDOKlNDcbokiDOZxFe2je4XFj7CqiDlQhRurh1BA2RWbn0HsJrccHI
         UP4p2tUGs/IFrIDxu/E1gODgLp41DiYAmaoXyIswGWuoZJ7YdDtSidcqNHNFVYMdW0QU
         KRYtfw/mYmUO36t5A1Pjdf3yYpl4KBoWy/v95sO9oo0TNjXdFClq68swmmtUOAQkjZvV
         F7SA==
X-Forwarded-Encrypted: i=1; AJvYcCWsXLhuJ/BMnIKYXrM1iASpqqZjIXwFCrcU4J2HrG1WIFo3d2pHrW3t8FSvavLeJKI94ESFbhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhvSk3wVDHkbRJ48nZh0ynGilmq1AR4/jsKH5daxf54b5tbgx
	+pSWyZVr8KxbaW0syMk07RL5OoSlVLacqmM/PnjJ9hSxDTgKJqQGD8tlaDxuwr8LKi/4UF2ckWb
	C3rasg/5RGavLspPek9cVwIxpP5KMAwU=
X-Gm-Gg: ATEYQzw28YmfTGW9xbIYJqT+K2foJ5lebo2LEp5O7okGeA1o/YmS/ZzKFRRaRc7+q0L
	dr4EJRpWsLJqn43IL4erHWLE7STvzxljpJQkZAPk3dvknPOhQNZkueaPo8UclKUGPh4QxEVI09j
	nyxvxTNneeAKllilOoCmahEekFEB7ZhbqcP3PTTX4Uc5+0rXhQBO4UdfCXxDO9RKA/93+rRnr6n
	th57f5e0yKAYVjWM6Vy+DSWbRmoLzeWKEy7WzpAA6VbErXC0BSVj5TbNkMS68da8Aw6cXkGQkBV
	DkV9/w==
X-Received: by 2002:a05:6102:3ed1:b0:5f5:459f:9860 with SMTP id
 ada2fe7eead31-5ff325564cbmr5513365137.28.1772457221779; Mon, 02 Mar 2026
 05:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228180821.811683-1-seanwascoding@gmail.com>
 <20260228180821.811683-2-seanwascoding@gmail.com> <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
In-Reply-To: <CAMuHMdUvynCH_eqNWr6EWusCWc7z6s-0b6gwQ1B_=mDkkxMd4w@mail.gmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Mon, 2 Mar 2026 21:13:30 +0800
X-Gm-Features: AaiRm53B8vuxeY9WjpFdgtYM3uOj2HCAC2e6TQ_Q4wTQ-Ml1BLpjkVYWpye9UfE
Message-ID: <CAAb=EJVvkyGHE7RfPaQOLLYuFdXGJMUaAzyVrREcKYSBQ3iKMg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd
 build error
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, nicolas.ferre@microchip.com, 
	claudiu.beznea@tuxon.dev, trond.myklebust@hammerspace.com, anna@kernel.org, 
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 755E01D993F
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 5:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> This should have been fixed alteady, cfr.
> "Re: [PATCH v3 0/3] sunrpc: Fix `make W=3D1` build issues"?
> https://lore.kernel.org/177024270291.126397.9981743455921781902.b4-ty@ora=
cle.com
>

Hi Geert,
Thanks for the feedback. Regarding the patch you mentioned, I've
actually addressed this in the v6 series sent yesterday [1].

My v6 approach is cleaner for a few reasons:
1. Compiler Optimization: In v6, we don't need explicit
IS_ENABLED(CONFIG_SUNRPC_DEBUG) checks in files like
fs/nfsd/nfsfh.c. With -O2, the compiler already proves these branches
are unreachable and optimizes them away automatically.

2. Eliminating Redundancy: In include/linux/sunrpc/debug.h, the patch
you cited adds no_printk inside an else branch of ifdebug, which is
redundant. Since no_printk already performs type checking via
##__VA_ARGS__, simply refactoring the macro is sufficient:
-# define dfprintk(fac, fmt, ...)  do {} while (0)
+# define dfprintk(fac, ...)       no_printk(__VA_ARGS__)

3. Reducing Stubs: This also avoids the need for extra stub functions
when CONFIG_SUNRPC_DEBUG is disabled, as seen in fs/lockd/svclock.c.

This v6 series has already been reviewed by Andrew Lunn. I would
appreciate it if you could take a look at the updated logic there.

[1] https://lore.kernel.org/all/20260301161709.1365975-1-seanwascoding@gmai=
l.com/T/#u

Best Regards,
Sean

