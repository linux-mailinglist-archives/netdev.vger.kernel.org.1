Return-Path: <netdev+bounces-274359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGezB+fpzWkLjAYAu9opvQ
	(envelope-from <netdev+bounces-274359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:00:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5638354A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E7453032DF4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C207358369;
	Thu,  2 Apr 2026 04:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSfl4gve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A030EF91
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102436; cv=pass; b=J3oo1Kcisf2CGjg+zyZQwvHAS2Lx0ZdqyeEFKVmq+7FUdn9MGLPmDLtOHSWriuSEQe+JwLAmuJK/XzQYipS1aMJmA0yp8AcHQjRUtzRu/H/yeVkKFR9mxsEZETu036OstoMfIZNLsPi3cCYe1I+OkGhxSWH38n9hKLbXGgSpvbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102436; c=relaxed/simple;
	bh=O0TeM9i6/qLaqsg5LKpb+enuqkHhDe0EN+gXCLG6dNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMmXdopXbFC48ZB+9xSetGCnSHyH+JD4kE+u96P2fL3AEXRlmB4e4sxv008v7nQ8C4MI27X4yv1ShVVQ8ntaKJB++kxaqFx170J11ZzRPx+CDHTtK00peXUWiGp8MMHaznriHp1QKRKxXlNE9gIHmRwf1rDPEb+moj0FDiisCdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSfl4gve; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso544123a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 21:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775102433; cv=none;
        d=google.com; s=arc-20240605;
        b=W0g7fEiaUNtIfTaje9kCT+fE56SyZ4C/YyNvTA3iagS7Xajm2dyv0m0YaycKZTSnFr
         JnWtUzXWOjqSsw6s2sX//DU5sR8mGToh+pnnuiBE1wtNRcgnC5g1QON5coqw7AjSyBpK
         340Zo3YzQ+UDd4J39aUMf6dDX+xMV6Hl7XQ53Ey93lQ8OREbwlIDprrPsNiSwLmPFJ4Z
         +RWl/u0uxHMjzSj4aBJwCiDXnhA50ZgCF6Q2WjosdpyUhj+UEFR+7MKhQ7sQyWW/oTBP
         jph5fTDHE8qHHP/lqX17v6lZhGUZXDuuqTVahDpE2enA0Smnn1HXKpvxSowPxSojx+AD
         1wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7y3866J1tJ66KhyO+k9tSAiEoA/N5hgTWOhMGCYWu/o=;
        fh=2onbhbR9iz2HMiNmE82Hz6b7dE8+E+eGBXfql99aYdg=;
        b=EZGycHxEGxi5ZG/yEhTlaUI8mSwFoOOlahyUIx7vLV/YDXCGEYX3A6jA1Qw9FJU47/
         0zyS+uaN8WA3oQCIJ23g/B7aY1eodLaC0ZWccgFFZ6HrdZL/VEcJmEw7mcBlRD7k/m8n
         rc3foWcpL7btFOowLEcxwZRq0T5aIseGrEnwWNOO7Hx8znZxCfaJ4Z8sluEbQQ3Eb8F2
         aTwVmvJikttBY7aHzL8l1vllT7aZS9JBeO85AroceVLjhOoRZdUTnWCTKUWLZ8n+jIYY
         nR/wTAflj8m7nsm9Q9nN431NNrexhxHfslPFciEvuiO2FPTRg26SAa4x4bCos54JLEcB
         IHag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775102433; x=1775707233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7y3866J1tJ66KhyO+k9tSAiEoA/N5hgTWOhMGCYWu/o=;
        b=JSfl4gveALYHWLgMtsz0NjGGE11nwxq3wtZjmo6h6xG2v11ZZHiSUO39MUhn0w7YIS
         pszuQ/J007ZHFJC9JqlvtC7pPtDEp9ujhnYOmKsPTU4DL1LhTJrC+y4q/RKg3f7soR/y
         Vs1OlNiEuZp1exms9kt1MnfaFJ3r2s94gfazd/wDS9bc2bNzRPe6JBtw3utHdjRS4afw
         eVs9RhqAZULSSRWmKHDK3oeMz0a1/52uT2MrYMKnRZomiyChSiTyfn6eNOTdVo31OrlZ
         uJkuqOIM1hZegf1kuRkkk026CGl40pxUqS/Ma/lExaNuTmHHe8g8l9f/6inYYkgdQC+g
         GSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775102433; x=1775707233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y3866J1tJ66KhyO+k9tSAiEoA/N5hgTWOhMGCYWu/o=;
        b=XIJDw7O+qA+isjM8lJZ4/pF+d7ElMK39ttKCmal3y/pDx3p0hTbY69ft6Gc8J9AqKF
         H1s516y5ryPe1p2QBdKV0ZzyNVVGzz9ZtS1RTWglny5rMlXhwz29TJ2u8soAWh5Ny7Yy
         tCWtJgnH/Z1TDBvqINNz1V9YfcKmr1DJ1OHJD/AjEiP7kpFthKTyBocNRoyP0WzaMQwO
         W2zpTrPn9qZSc8L/EiyV7pWyYjw8e1Rz4P/FzECVJgFtQ9WBkzSKW5EyKrghciYMmZjA
         1dO2f3zAW6DoaqGurf0bkw9STCBzPVsPJKD/23eDXRFmx+/Y9PY7fvtkwD0cIkhoEtVt
         31Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUmsQHfRJ6lKn/sWogOERklI5PYX1wR86dLImF0ULIem1jjclj3ZuGaVyWJP+O6IoFmqK03eQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSURV44X4LCK3Drpk09pOPdi7cMDvNcdejiULf+Qe3NUtGOTt
	T4jLrEGkWl+PPO55SstP4xUzmwsG5va05iOkdRe9vo+JT9ldPaSUclv2P3XDMcftMHQKTRwyK3C
	pNYr7YqDewuiqCQS9GlxgYolA++q7UEY=
X-Gm-Gg: ATEYQzyTLPWIdG4+Zu+6NEZrcOQb/LEht0OOdFNFTJkMo4oUYju1mrpegLOn0G37vGj
	fNNMyw1Gz36p3GOhwtHLDerYexuI6Ym3H/AHgwSo88Z8CCm/srh5MdJQV3JnsRuI0GW3fDHHZ1/
	mW3yCwVFXP/iLsyThhDSpdQnObxOyslozrmJ2/hpnNkPiQjiYvClNrEYn3/ZPLKW5GwatKPyUYV
	OTKo9DXmHaYKrUBMpofMNSQ1N6a2tyYLOy+mWlTXMttr99lLW0qQ8AaDs5/Jrm8hWJPTOLhkhwx
	nKYIQnslyQOocaVoqWwVxU6NeCvhMHDn/SBk
X-Received: by 2002:a05:6402:51d2:b0:66e:4cc:e64f with SMTP id
 4fb4d7f45d1cf-66e04cce8b7mr708130a12.8.1775102433074; Wed, 01 Apr 2026
 21:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-4-44fb63033b7e@gmail.com> <acx_1dOF3EjvGt4B@yury>
In-Reply-To: <acx_1dOF3EjvGt4B@yury>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 2 Apr 2026 01:00:20 -0300
X-Gm-Features: AQROBzABb5pvk5bmnPEOdq_w_fxW8ZfaZbthLnZDHgJAtqph6gIpQ_iS2r50Bg4
Message-ID: <CAJq09z7+cA9_1fWzkrJebutJD0b1BGhrC1sUyoqqb=ddKCAXcw@mail.gmail.com>
Subject: Re: [net-next PATCH 04/10] bitfield.h: add FIELD_WIDTH()
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274359-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 85D5638354A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +/**
> > + * FIELD_WIDTH() - return the width of a bitfield
> > + * @_mask: shifted mask defining the field's length and position
> > + *
> > + * Returns the number of contiguous bits covered by @_mask.
> > + * This corresponds to the bit width of FIELD_MAX(@_mask).
> > + */
> > +#define FIELD_WIDTH(_mask)                                           \
>
> Please no underscored names unless necessary.

I used _mask to maintain consistency with the existing public macros
in this file, such as FIELD_GET, FIELD_PREP, FIELD_MAX, and FIELD_FIT.
All of them use the underscore prefix for parameters. Should I diverge
from them?

> > +     ({                                                              \
> > +             __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_WIDTH: ");   \
> > +             __bf_shf(~FIELD_MAX(_mask));                            \
> > +     })
>
> I believe, this should be:
>
>   #define FIELD_WIDTH(mask) ({                                  \
>         __BF_FIELD_CHECK_MASK(mask, 0ULL, "FIELD_WIDTH: ");     \
>         HWEIGHT(mask);                                          \
>   })

HWEIGHT() is indeed much cleaner. However, to keep bitfield.h
self-contained and avoid adding more includes, I'll try
__builtin_popcountll() in a similar way __builtin_ffsll is already
used.

I also noticed the suggestion to use __BF_FIELD_CHECK_MASK instead of
__BF_FIELD_CHECK. Both FIELD_MAX and FIELD_FIT currently use the full
__BF_FIELD_CHECK with 0ULL as a dummy register to ensure the mask fits
within the header's supported limits. If __BF_FIELD_CHECK_MASK is
preferred for FIELD_WIDTH, I can certainly use it, but should we also
update FIELD_MAX and FIELD_FIT for consistency?

I intend to send a v2 with the following implementation:

#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+#define __bf_hweight(x) __builtin_popcountll(x)

#define __scalar_type_to_unsigned_cases(type)                          \
               unsigned type:  (unsigned type)0,                       \
@@ -111,6 +112,19 @@
               (typeof(_mask))((_mask) >> __bf_shf(_mask));            \
       })

+/**
+ * FIELD_WIDTH() - return the width of a bitfield
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * Returns the number of contiguous bits covered by @_mask.
+ * This corresponds to the bit width of FIELD_MAX(@_mask).
+ */
+#define FIELD_WIDTH(_mask)                                             \
+       ({                                                              \
+               __BF_FIELD_CHECK_MASK(_mask, 0ULL, "FIELD_WIDTH: ");   \
+               (typeof(_mask))__bf_hweight(_mask);                     \
+       })
+

Regards,

Luiz

