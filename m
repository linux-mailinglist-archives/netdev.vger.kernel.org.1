Return-Path: <netdev+bounces-260970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAMZJIIDn2mZYgQAu9opvQ
	(envelope-from <netdev+bounces-260970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:13:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE51988E0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 762A1300D0EE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A173D3335;
	Wed, 25 Feb 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK8x0FWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C880284B4F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028795; cv=pass; b=D/S80cYbRlABZO3lCKjmhMVZATOD+OYKN8GDt3mKv50Iy5TAHiu+xF34D2xIsuho03ikg80ZLrzrKBuYiaUaY7zyWRXbOFgLhOTMUbtV+3e50GwMhk9r5Qk+VEqhsoz2feABFN33a0kgVE1Gw8h8TeT5bsLsS0SzoZ6Pp5yj8jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028795; c=relaxed/simple;
	bh=7mu7t2CztkMODit8BuaEMgMJilepRincRc+FC1HvoqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhWuf/pZjwqaE0sV7f9cEBkKvkc/hmWZedMv0dm3gOxBUoCVMQ6OlTGt6DKlp6Gx1MA+ZVAIAIp1aXICNlCZzEi4O9ILNQxyhrbHhM3YdZJZKuYr0Zp6DAG5IKfAa471DSy6GqR4cNmNcnAcAnlK6aC7FFgk3QxvyOVW4LgkJ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK8x0FWd; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c68f0e47so4147708a34.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772028793; cv=none;
        d=google.com; s=arc-20240605;
        b=cZGhVw16zBj8bGIsnmxJAZoJsuXqyH65AtxDg4O0j1APA/sSyFrVGFEfLgR8ddyW/f
         +SDskbTk1vM31oGOSNBZnQj1S9QIZctM1V7j2cz0MC/mz+wwOrqbthISG1j8/0LJ8T7g
         GKU29ey/23ql6xYrhRuEMbFmJb96xeEq5AoRK9mSQgrOp5OHXyHFl2iGy3jDjkQILfHt
         p4G3CQJUKkmsKtpOgqvAd8rOmzzvV5gP1C8mBAMTg2y+mPjPRm0kjtbY2B01373V/1z4
         l5fbo1yGWBBj7HOdpTjQ2kpT14guyYuLj9d052t2iClg3FNC9QNvYxP3a/cavmy2Aa76
         nF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XItzA6Lc/0WBuQ8Z3wzzRgeYnC2OSX1yWQ79AdSwvlc=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=d27SfGGHcBietQbuDLnzSmJpNjmOGylOTXSFjoBR0ct6rXjUcCPsuZHLv+nm8Wz9Bn
         HDP2jHY5FPD1vhbxZSPq8/zWER6G5WLcqA/AMVJn5lGH5JMexYPA4A7iQpISkX/j2NWj
         sKz6aCQMjLfhCT1kvj08nh7yTVFG0wXzVuBvD9991bw6i1qEAW5KiclSp2ISGG/8KZ6P
         wlEDUnQJ3ihQEo+P5K0uDL0dKMuhSXXxDYqJ3eLn+7U+YIHF4g+I9S0ZxNtBj48D2flX
         JWwFMpa8kmlONEcH0jTwNNobRa/41di/4niFGQ24kGyvtOuI8fqnAB2AFFfHKfDI7RY5
         zyUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772028793; x=1772633593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XItzA6Lc/0WBuQ8Z3wzzRgeYnC2OSX1yWQ79AdSwvlc=;
        b=OK8x0FWdC+X44ijCHQipipeXkDkU4FdONykBVisV5sPBd8DAXZTtWqMaHIp6eUQ71V
         KU0cleORiYpkuvqWOX7gnZqOajz6C7YKYWQMpMaKMJlYgnRGJ6GRlVj0hZQvXypbrZsJ
         XS3b8dqIS01NcRa6JEagWsWoVmiLXADeGfhbPHn2Y3pKyjEdP8mrBNNwONGPRaUsMmz+
         F6fwgJbtSW+ESokoD7rQjb/CXNgwx5WH0XfajURQcReovJVArTt55WgfuHhKF5FdjdSv
         K6+kFiTYwBFMhxBcFh7z0hnraEATtFVNbSESw+A1ug1sONgbOsw49v4poAmTwPI/ij/z
         OMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772028793; x=1772633593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XItzA6Lc/0WBuQ8Z3wzzRgeYnC2OSX1yWQ79AdSwvlc=;
        b=L7e5URRE1/b1usnrJIsq4D7RMkP7pCTnaFGOCd3vV9L1FWuRfWMAqg6wrdTpZ8Ld9T
         K2x3BwBUPzXo9dAQnZ5psYdJm0Sc20Qm4nloVSRqaVHK5c1TlggUvBclFP+zk7dVAtvM
         dtdPWBDOKAertQvBhqozSR4tHSnyoTsawQkjIOTleTBzRBhO9MvGPL1+Mx6wF5pD2UHP
         hwhe4dKLTERrvbl5j3qFFvBUc9xXCrpHqeGcl77MhqWb9VsTvlMfpiD2qAAL6ZNSbuVH
         7wEJwlRxEgS/ps9caaq0bvE4FRmtSIkV7SXD9nVItLpWWiCmzHy02JsUhOke+SJWkoXH
         I/nA==
X-Gm-Message-State: AOJu0YwI0faYvHiMFr6ib56zJ6X9LnCTe5/7opqgIDWMRMOuS2Q+g9KC
	i5rSZLOnDMO+hBJP/gird7J4RbrezqOo1bm3g/bA1AFF1VuS/IThKizrjf7Cen8P8ed7GVDRuNT
	wyVyT2JJL39x4blmRgoSZFwy+40pXvPw=
X-Gm-Gg: ATEYQzwnjrwHvLzZOorOLp6o83JlbfeZa9lNSubxHPwMDeSBMtagMpXa5y7uMOzWw8K
	gK/UGgycpXo8JUTFzxtQ6PHJnzG51tTlJcNeQpleOiAK7P5DdFpzlH6Awsg+oMr7OEXX6zp1Ubj
	c2LYWxgLou44dDH9QvD0VuaPHqB9vcfUUqaMLzMhLqEufNkLpOXI4SsCHhcndWn6PoWAiehFm7z
	2LKmVxS4OIR2eJRzbUQPhV87JM3LUKvlRJthu7ysiXmBQKUvouEWhUsoH8vMEAS4n3LUkAs5eaq
	Azq8KT3cMC6WpItdQCwncC0FFlaFKvDB9NftSy/2Ng==
X-Received: by 2002:a05:6820:4b07:b0:66e:58f3:b500 with SMTP id
 006d021491bc7-679ef929cdfmr253415eaf.29.1772028793273; Wed, 25 Feb 2026
 06:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225090853.2021140-1-mmyangfl@gmail.com> <20260225090853.2021140-2-mmyangfl@gmail.com>
 <cb52e6e5-c047-4190-9e06-4f80a8bef051@lunn.ch>
In-Reply-To: <cb52e6e5-c047-4190-9e06-4f80a8bef051@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 25 Feb 2026 22:12:36 +0800
X-Gm-Features: AaiRm53Ezo9AQTV9YC9L8okSEaf6oJBhg_jMBc-q6l5KQU_0AhFpmsPlG7weDqw
Message-ID: <CAAXyoMOVdeScayuJbtNKmS+QVmWdH1_5EGTUsLH9Oc4bkwDoVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Refactor long register helpers
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260970-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: B3AE51988E0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 9:52=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -/* Some registers, like VLANn_CTRL, should always be written in 64-bit=
, even if
> > - * you are to write only the lower / upper 32 bits.
> > +/* Some registers, like VLANn_CTRL, should always be written in chunks=
, even if
> > + * you only want to write parts of 32 bits.
> >   *
> > - * There is no such restriction for reading, but we still provide 64-b=
it read
> > - * wrappers so that we always handle u64 values.
> > + * There is no such restriction for reading, but we still provide mult=
i-chunk
> > + * read wrappers so that we can handle them consistently.
> >   */
> >
> > -static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *v=
alp)
> > +static int
> > +yt921x_longreg_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
> > +                 unsigned int span)
>
> Just looking at this, it is not obvious what units span is. Many bulk
> read operations takes bytes, even if the underlying code works in
> words. I would probably rename span to something like num_u32.
>
> I would also keep yt921x_reg64_read, yt921x_reg64_write,
> yt921x_reg64_update_bits() and just makes them wrappers which call
> yt921x_longreg_read().
>

I don't think keeping reg64_* would make it better. There will be more
96-bit regs as subsequent series progressing. It would be more messy
to have three types of regs: u32, u64, and u32[].

