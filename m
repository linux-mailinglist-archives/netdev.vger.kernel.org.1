Return-Path: <netdev+bounces-284609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZSI1CAaG+mlCPgMAu9opvQ
	(envelope-from <netdev+bounces-284609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1214D4E11
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF41F3030753
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71EB40DFAB;
	Wed,  6 May 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww/0+EVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A8191
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025985; cv=pass; b=q7w2Wg4JwmioANZ3O4nqm4PIi1Wpq0jIUt8+4Nw9QFYJcBgk1LO3sBVLIa4QV0w210FhTYnBajVJaw+tMTlM5xjBMUU6YDWJgRgx+6gf8K+lucCokMF1tr4wkLdvEztmRs+hDcUaqf4rb1OrtvcDXgE4OfA/4kdh3hleMTliBak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025985; c=relaxed/simple;
	bh=jJFV7gISVLnwI1o8I+G/vM591i5R7XvOSd0NwHqxk48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPBRy9gTzYZ1GvF/rU3jkvOhI5sgSf2sDfimCyCgBhvbr7RxzyIh37yAsQ8D8P28Mw2l+IZQiEfM5nxG/mRW7hCOqXwcSQaZRmHXmtqwkkX1112ex93bLAOMNo+n+8In8205/pXDNbfyVgWr6gvHQDBxoFpMI/wGEi9jgVGx1HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ww/0+EVl; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dbbf1e1058so902919a34.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 17:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778025983; cv=none;
        d=google.com; s=arc-20240605;
        b=KbrpF27PbDnW31F77JDF2qtvR5YOGQLSTmiHQDMX8R+TPcXN9HCedjV09JDRgF+W1K
         lb/kEzzxcvyvigY49UonkDiECQur8Pb6tL1t70Dnngbq15VqsRCBc/AQBCgsHHBiLvz2
         +dmzv4Oq5h4vba14X0xlKGX80ytRFTTbtHsi1O/qMp13RKFEQcZTne+uF4LR8N1VTm2N
         vvDhYK6Fg9zgPEs0O+KKsQoMw6vPmTBE5dAEwO8jwg+B2K9zpueLgOZtZHnPwmuNmU53
         OFN04BXzFPxHSbu2NiTESHZRdAw7YYV4g3Z1w18Jg3klWVV4w8mUh8hpQ1Hz+rfnN99F
         /vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3I5jQfOhWB0uFpNtzYf3auDroditYNnhwisk4NEQ+8w=;
        fh=xrPkI+UW/L/BnRuxOshTaPP3rweM3fEZqvOksB5ZbNY=;
        b=bbrzFs2RAts3ggrcihOlpFlKicX0C3wGHVMhd7OqgSnUrnuoTNF9XHuvfca/LYOBt6
         /HVDYecpiDUioaSF0840/clxlb0XK0609K8rPMa4ub36m9JTAaIDfwuXCf018UgctGgh
         Bt6eYzs9TnxZJc3r93AZTIkmkzFnMahupI5SgNkr+Wew8pwxIvXxxR6LcAR3cJ3q2B+w
         hRHZ0qHzQCQ6J3eCZoyGBNKfexW4QX32GXB9k3zF+Wi+jlxQ/6Pq50ML2q6FY3mwylH6
         sWh7Vq9RPp/A1aYmQPG3daw1zBBmItsKCRJVx540up9yk823/RMj+lQezMlkjEwLdlpn
         qrTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778025983; x=1778630783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I5jQfOhWB0uFpNtzYf3auDroditYNnhwisk4NEQ+8w=;
        b=Ww/0+EVl51W0dqlCRuIxsbb4gqsBcD8rL0PKc2901NVUB7Je3ENIvZsZy5ed1vM+wc
         WltFkxg6i5XpBbzTF0LSmlt8R3r5MPZmOMIBXOR2TwOV1+c7UFJknn2DktV1PG7j1eLl
         pTdv2qK/j93TJTSBPG/c2oCsM6o9zVjbCMHmPLiBXQmx2cY6Btoui3wFrWRsEF6tjtOx
         HQwodHul+cc7/zM1Fz2qcMppqNhs76i+w+7/r5x7IrNgimdyVheeeQv5Y5k084DDmKFN
         ocGJEozasXnlncsv/uPkDCNsL0S1jQvF8siPHIEwL/Vmmv8E4fD1Pv5aHdZ33W6woOHo
         aCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025983; x=1778630783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3I5jQfOhWB0uFpNtzYf3auDroditYNnhwisk4NEQ+8w=;
        b=sHkg7ong64uehjoHRkXHyOyNuy6dy6Z0EIgXtYcyYn0NxnCCfbad+j8AguXQPGJYfR
         CgxDKzTD8jL9yniWgJx1rTa/tUuhKjuodKnJgtujPMJt3BiKJI9O1jtYMM+zs3lqPKlc
         AQbwu84v8n/hLBTrUNSko+MBtWWWzIhMTmZWSFmxnlSfpfeXS7jx2lc/D5dtmO0GmLCq
         aty0kzgFbj4qCYXcZ8UCMMQFgaEQwAC4PESwnQO0s2hLKFeuiFkqupA/BqKrK44kUrQ8
         LSGE/aOfczP8V2m2LJOo9DRISJBZ3FRHGrg3zErnutGOhVzg3i5fx1uPpfZFeIt3WgWa
         MR9A==
X-Gm-Message-State: AOJu0Yw+NO3lpAXN65TuAeYiZ19fJtvS3UXeqromqBQqv2YcnpZA5gJY
	ACU6ypQZZ1+pr5dcmt9k4zermt6S/1FDjS5euXfMIRjyY/EXrBdRGzUS8G1deW9Lnd5TWe6V1jk
	yHVEjgJLJuyZ7C6P6JsBrG/0wsXM+6k0=
X-Gm-Gg: AeBDietv4xFtz2Ph3574qZubOT5Mwr1+vB5DW7AWtw70fCV617lBs8cz8V3aq1xqXAG
	wnlpUHR6aTjQboNmrPXjHQcn7LbJJ7a+EZyw3k1Wm3Jg9FDQiT3yoRWFta1ILJUBwyuPAyclmiq
	4RALsFiMUB+/N/4Nyjk5wQkj8MPeUFKBm6WqZhe4LZrbSbhrU0TYQgjNlHoJIhOHDjxkETvCEC0
	30kzLpzrG92CajvcwZ3UmPPZODGGPuK19FswVfXqzNuVt3WK1NAiW46gZI3m8SwnYN7Us/0NWud
	nMbmGoW1La36UoVHw2l0yMih9eqKK6Y=
X-Received: by 2002:a05:6808:6f8f:b0:47b:c703:423f with SMTP id
 5614622812f47-48044a75b2cmr368163b6e.0.1778025983380; Tue, 05 May 2026
 17:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504230056.917415-1-weibunny.kernel@gmail.com>
 <20260504230056.917415-3-weibunny.kernel@gmail.com> <12f11785-0bd5-400e-8acc-f47b92271e33@gmail.com>
In-Reply-To: <12f11785-0bd5-400e-8acc-f47b92271e33@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 5 May 2026 17:06:12 -0700
X-Gm-Features: AVHnY4JJ5RGn_SuGjHxsx2Axz2OrzMDaMf_ZS5v6FDtlRC6QTAsq5FZnBHPs0Ds
Message-ID: <CAGqc4nU2fOycS7hg0SzqP6p30doBScGPXRspnbL_4JKcE8CJcA@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7D1214D4E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284609-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 7:07=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 5/4/26 7:00 PM, Wei Wang wrote:
> > @@ -281,6 +318,34 @@ operations:
> >           post: psp-device-unlock
> >         dump:
> >           reply: *stats-all
> > +    -
> > +      name: dev-assoc
> > +      doc: Associate a network device with a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
> > +    -
> > +      name: dev-disassoc
> > +      doc: Disassociate a network device from a PSP device.
> > +      attribute-set: dev
> > +      do:
> > +        request:
> > +          attributes:
> > +            - id
> > +            - ifindex
> > +            - nsid
> > +        reply:
> > +          attributes: []
> > +        pre: psp-device-get-locked
> > +        post: psp-device-unlock
>
>
> Should these require flags: [admin-perm] and/or psp-device-get-locked-adm=
in?
>

It might be worth adding admin-perm so only admin users can do
dev-assoc and dev-disassoc in its own netns.
But it should use psp-device-get-locked because this allows callers
within its own netns to do assoc/disassoc with the PSD in the
different netns.

I will add admin-perm in the next version.

>

