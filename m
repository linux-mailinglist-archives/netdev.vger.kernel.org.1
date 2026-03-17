Return-Path: <netdev+bounces-268601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Kr5JBVTuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:11:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAAE2AA95E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80CA53011D75
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BBC3A5449;
	Tue, 17 Mar 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvOeYzVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABA3C1419
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752661; cv=pass; b=qdkOjfBbAaiH8kEBktxi1ebsA8i34I6ad67pKXacVPzAb2m5pHveiNLjtq+h1lzgLR0PwFLT+96bsTbv1qID/Lb+T9c+wxIMmF/Tb6YiCn8eQtQVFruWVSM6B1nSGIWbltvxo+RA+oLTkHvBqBPd4M0gKAhJ+ahpzlAzfWTgbCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752661; c=relaxed/simple;
	bh=p2NriXN8t9UCererd0tVBy0OBqYtEpeYdnd+MQjf4Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYeMN4CdiWlCU+d5k6HTyyoRVmGmg5yzY4cpYfwfIjRcTtgAwDP1WaDdbshATulVWWI6GTZA03nFfm5W4I9Hoolrw8q1ywk6eQoPKM928T10d7m4co5dCMrkKmC8dhAy4IsSL4SbC3SbBNBjK+g4/0SDaKS7p+iEORLTu0v87gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvOeYzVn; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ffd797184fso474236137.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773752659; cv=none;
        d=google.com; s=arc-20240605;
        b=gSBnDFw0IwdloWuiudkGfg0MvduDdZaTRlOEJY6lyhIqYwvpEdd5oz2mP7DZZVexzM
         job52AL/FgPyNOxAokZp4rQZp1yJz2F4EYGawGaKmNPzvgJ++zx/VvBchCQwPKaYAGOI
         AKtOIu9IlAYqbfTqG9oBHYZtEtIV2MOCmUYv8yaNY8bWj2biW9oOzoE+l//6UXXWI/om
         t0lkzl9ylz0QApOfiJjuH0Ii6qLflc5m7PiWaGZInrMz+oaHdlKbnCCaUldNVhcfXc1N
         87+yp5x0jcjFvk44dLL9vGtVHaF1Z1b2vQppjUDx26zmudT+vmTaxVF9imtBCUK73dj7
         wDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        fh=fgZ2zXiFa8TPfaKxQFaEq5VU+WtzDnCZ7z6/bzF9Mqw=;
        b=FqpV7c/fo7is2CqJ7YLoTE6d2cw5wN6T9MwPrA+HFzo4W5SnZyDjFRMa4IMtww9387
         An4hkFjORtqbS05FVjPC6s3HG4719YPSm5sL6WDzHS1YEAD4ru7gT0SEDsJ7JLhPhf44
         qFo7d9D3JlgNZ+jTRYLRvEuEOmboxRIkHEyb5m/UlBrTaEjgAgksq5D8Ll7bfdIE/COS
         Q9usKgz/mSciJc6ajdiJkR56wbblAMsJcIIGdGozRtGlH4VsjH2Ks/om2Woy2a9ijWAi
         CPyoDwx/3UxUzatcK8CzKwecxdBOxw9/hULFcxZqOy84Fj/le5WXKj4S5SDMSwKy59xJ
         iAYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752659; x=1774357459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        b=bvOeYzVnTqJppmVTjfHAmCWZ4z9Qd4m7dsWTTm6+61gCF5C+tFJvNcF/tOMf49TARa
         ddbE6TM5qChX0V0rKjEr2T+fqZoj9RP8FdV701Y82jChIhmwJeTmbt1r1EaUCRrCbQSj
         TJWBTuTJiV0O36lYgCbVjuyO956Jl3KkwE/5WxLoAPUefww4eFnGbsTqprg16el4ew66
         0o4wkRIxURijgjgXuOJGBOzpIngnTPkRK0S5uUL18ZLqaFzYLlv9La3KpeAznlT9EmqD
         RVdTe1K/GgGQJdr4sbWbumChE9MuYkSUb0s5BDpCDXVRovk9PXqtpEhswr2LOHwquPVN
         NqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752659; x=1774357459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xn6ze0oE0cD+lz/jwl85dV+3isrvgPJIHKnPoDqqSx4=;
        b=fCXh//wg9A4aW/RBiAp10y6Jxcu2vho8TOXBb+yqBIodSENfkALn6t4UQYDBTroPwg
         reG3eQqQ4+xuN8IjPwze0Uvcwg0hTz4XJPAN7/gSgpQO8pPGjw1OuhDMYuU3lEwJ/Wx0
         s6LhpQCy2ziUdJ9AFC2Efysg10ngvZ/0LkDD2L8UngsGTrFZcHGT6ajX16oV+svgaa1Y
         155yIjsiJxEaOyz8Tx5YA+9KLBzgar5S8TQuq0GYzwxUrr1jqBPo/mLw+KlISakJb9fx
         1pD2MOkwfwttx6tbd0B9ITG8vMbXa+xa2Wt+4hry/43woHoGsiFy02hrICjsR4RalRtm
         U2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWavVmLN4/W5IbTp6VpJi52eGfAygYWxm/2rrRj6/vYt4tHDlnzpI8YtE5g/ugPdX8y5RMAc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMui7keqi1ymIu6Ku5iUPQVK2AzLffMV9bBq0jxTnu6KNxPDN
	2fmzjQWgK8rnuvvxctFpirGV9Wu0lVGqesNz7W6+xsuash1z5urqHizhI22/Q5oMsQ5f50S68Vx
	moTPzPOThgtLmU0+YcfQtoeFC9uAq4go=
X-Gm-Gg: ATEYQzwJnkxlAZr91jxqpWHIIKNfFbfWAmYKTXtA80xDtweoE32fgFA+1Usd/nPwiEb
	UyZdlv+D2ebLi2LpG6CWe1gcWDWerqeNts5GaRqTBpzj2af9PO0GWvtJsdbB2rlFBuZl7ooitJR
	IQimPN+c+Z2BJ7BeMT8kJ2IZhxNO4Vx0jUqRJKZM0E1pfRBg+5bJqX+BtKFNJKqyl8sv1uy0r1P
	x09U8ngG/SPkhb2+EiI5z8dRMBf0S+ebfbjkfyLRUwd/d05QDqbxcCEHjqbY/z+moCn3GCAynJM
	xx/Zjug=
X-Received: by 2002:a05:6102:e0d:b0:5fd:f9fa:db61 with SMTP id
 ada2fe7eead31-60263d9e6demr1302152137.1.1773752658991; Tue, 17 Mar 2026
 06:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com> <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
In-Reply-To: <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com>
From: Sean Chang <seanwascoding@gmail.com>
Date: Tue, 17 Mar 2026 21:04:07 +0800
X-Gm-Features: AaiRm52nHo-oplJQXa4sR-xaQ7OqdfCP-csU4asnyo5VppV-q7OwRQAc8GJwHno
Message-ID: <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Chuck Lever <cel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8DAAE2AA95E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 12, 2026 at 11:54:15PM +0800, Sean Chang wrote:
> > On Thu, Mar 12, 2026 at 5:47=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Mar 03, 2026 at 10:07:25PM +0800, Sean Chang wrote:
> > > > Following David Laight's suggestion, simplify the macro definitions=
 by
> > > > removing the unnecessary 'fmt' argument and using no_printk(__VA_AR=
GS__)
> > > > directly.
> > > >
> > > > Verification with .lst files under -O2 confirms that the compiler
> > > > successfully performs "dead code elimination". Even when variables
> > > > (like char buf[] in nfsfh.c) or static helper functions (like
> > > > nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they a=
re
> > > > completely optimized out (no stack allocation, no symbol references=
 in
> > > > the final executable) as they are only referenced within no_printk(=
).
> > >
> > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> >
> > Regarding the LKP report:
> > I have reproduced the Sparse warning (void vs int mismatch) locally.
> > To resolve this, I'll use the do-while(0) form in v3 to ensure the macr=
o
> > always evaluates to void:
> > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__); } =
while (0)
> > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__); } =
while (0)
>
> Wouldn't be better to drop ({}) in nfs_error*() macros?
>

Hi Andy,
I understand that the ({}) wrapper might look redundant at first
glance. However,
even if I remove it, the return type remains an issue because no_printk() (=
which
dprintk() expands to) already contains its own ({}) statement expression.

To resolve this without refactoring errorf(), which hasn't been
touched in years,
I believe modifying dfprintk() is the better path.

One alternative is to explicitly force the return type to void like this:
({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })

While this ensures the return type remains void (consistent with the
behavior before
dprintk() was redefined), it is admittedly clunky. We could wrap
(void)0 in a macro like
#define nothing_to_do ((void)0), but that adds unnecessary complexity.

Therefore, I still prefer Option 1, as it restores the original
behavior from before the
recent commits and maintains the cleanest code structure for this subsystem=
.
What do you think?

On Fri, Mar 13, 2026 at 1:53=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
> >
> > Hi Chuck,
> > To make the review and merging process easier across different
> > subsystems, I will
> > send v3 as a 3-patch series:
> > [PATCH v3 1/3] sunrpc: Fix dprintk type mismatch using do-while(0)
> >     include/linux/sunrpc/debug.h
> > [PATCH v3 2/3] nfsd/lockd: Remove redundant debug checks
> >     fs/nfsd/nfsfh.c, fs/lockd/svclock.c
> > [PATCH v3 3/3] sunrpc/xprtrdma: Simplify variable declarations and debu=
g checks
> >     net/sunrpc/xprtrdma/svc_rdma_transport.c
>
> I can take all three of those, if that's what you'd like. Just let
> me know when the review is complete.
>

Hi Chuck,
That would be great, thank you! I will send out the v3 series once the
discussion with Andy is settled.

Best Regards,
Sean

