Return-Path: <netdev+bounces-274639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDHhFqKozmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:34:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3538C92D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D59302A051
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FD3C9424;
	Thu,  2 Apr 2026 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hO3rbtE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D43285C9F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151031; cv=pass; b=qd8zn3afCizn+5D7Rnnu4pQZI/MsQEtttQcx6tDfnBw1C/EA86w2ianxeOR/yHtgn0WCtLs685i/7wQPPTVkjGWqYkemB1L/vN3j+hPw5HUOTHG5y2RGEGXHH6anKZj0tf4ZJE5FCTu1U3Sgec3TS91v2zxzQXQXrhc7N6nxEAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151031; c=relaxed/simple;
	bh=NU/xljKgKBcG8zbsUQaL8/4syoa6FeovfZFI4J0W5rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=A+X6OzcSfFfLlrSD63tnmpmr490IoTqS275vZk9EAjrMOgxfjOEx6QDammuHHucQV/nQYf+10+y15Gcoz8UbXW+vWdBOTiBt81w4Xm0NoTZyutp9UTWPLeKWT+/E4p23GQozorSpduxT72xtpQQEHJpRyqG/NqSQI8yaj2/b3ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hO3rbtE1; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a6cf8242so10265471cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775151029; cv=none;
        d=google.com; s=arc-20240605;
        b=AHDate65hqudjLHN3AP4v/LgzxYjSP6WeuKuxDQE6uvrdcL/vXcrH/Rv2Fxom/B95g
         O8uFKoSKioYeeIwLBhIWQuQsNwefG07p6CkTxbSMfRIrrmMhnhtxAD3KZQQdQDNgCvrn
         S+QCAsWr5pmBBa78t4wqw2AqNMP1RqKFPux/9RgBvXJfzWGVWL0Ss3LcQifMG7EsSFdw
         MDG0QJ2e6QXzTmzMKOTRHcYkWVOxgpE5RTGeEI3EUk3NuQxZq+goT50qHMae2rzq6qg0
         yjj2uX/SV3dvq71WLGo7Cy6BvXHcGHI+CACtKmnKhM6Vx/O4Ol3QHI2/tYpOKZunQtSc
         zCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3p/7U3f/G21oB/wpnR5mCv7h3ynfQYKx/n+u1DPuI/U=;
        fh=a46ePJsgetLvQ6ahPDcPkf2MglkBMwDaBJkOz+nRUiQ=;
        b=gVHtQGAX038bb3cNZQ82F9zSms6WhOj7+COE4MPwSN4Pk4kERO+63WeHIS6xaxbvaJ
         qIMbIdXldBPFv2La0Fa1NnsCfZ2LOHpvb2Lc+3g67oqzjun09Yg6uq77edCyudCqXDcx
         Ro2q7Wr+MzBzUAqDa7I/187i0siIQxcksxkY6SxbbTSi/3fz7GzLK+D9nay49FLqQeFa
         J1aLc55OnjRRB1ar711p4G7QmEHF9MSlOa658qnbhXX4m4xlbt4FZQgaTKfKyb96HvW7
         BJe6lj3plARPjnoSCUoemKEtBqlLnbVazpsyqVHzIUYCqRuAvjPPLeJCk+pwnB8Gwv1O
         +z+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151029; x=1775755829; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p/7U3f/G21oB/wpnR5mCv7h3ynfQYKx/n+u1DPuI/U=;
        b=hO3rbtE1laM5RLsb4W7IMinOiqVKbC5pI8daHQpXmT2yQB7GiY+flwrsaM7ko4Z3lg
         CVbhu7XmDsxfUOZBwMrGDkO0ywwieMmgjl2ED+TJcxQLIwkgupypS7nZcECeRj8RC6LO
         8m1DGsNZLEPl+ZLcX1QcT8tFT82IN4b79C43Cu3LruP8WG4J7eAqwJbd15S5iz8oGUDI
         2tk0duHOy2LraBfK9XrD9dv0kaWfIF36nvInnYDfXMUX2vJhWPmlR7068DBsLxFbBixN
         eHlLO+m9qRwYjMCnulZiaNzz9R6la8pb9929xWi9ZDN4X5NnWQeuf3AbMYctVh8GA3BM
         zzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151029; x=1775755829;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3p/7U3f/G21oB/wpnR5mCv7h3ynfQYKx/n+u1DPuI/U=;
        b=At/mQif4tWC+ZuOG9isMImMEjhR5L1HfS9StQiqcBWVZcINpQEqrIb8ClqlowBA9nN
         eAheKnRoNGvvcQ424ZCdNtHnLhXMyUyvnfSvJnysDMhqg9JgspgS6phM/HcXovNAjUCa
         iJKJwEA8eJulU4NDmlkK2T1G59qVYw0FMd8jQ0dFF2TJkB/BxjFv/EYhhPEGuL481+S0
         gSCoVTn66d+ByrfuXTYem10RqMdJ1hmT1WurDy2UPUpp3m4RYqYeylPFsssYAjYBdELt
         97Y8//Ri6UZT66nBmWYrXG0leieejSZsONdAaSukMABdXTtL2ijU1fLoKhVEl4xSKHCb
         xlng==
X-Forwarded-Encrypted: i=1; AJvYcCVsAONI6laq1ZdT/T4rq86PSkXfieWqc7VxSl5bTbSIg2WqyVqDxQME1glVWM7PpvpFLPBj+b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLGGiV81aqns4LuNBCv5dCEUD3WU7fYJdVdNqgm2yWpizcCgV
	Geork5sEVLYBfQCUTf8d6PPIeiEpDF2VKzkRheGIYE6FEYFL6+zGIVU0JJ/GnlpZ2hoEcNXBmr+
	xqiRWIiNP4w8p9lvZ/OSNzgctXR1IkV5Luj8xVC5r+oVUgi9ohUcF8D/W
X-Gm-Gg: ATEYQzxfVHW+FCVCF7miUGBYxt1JKBDiGKlwlFHAzjqxPvpNUJ934NHHy8OSjLS3c+q
	vswjpfdefjmFM/mw9mbedt6JqcHMGx/Ve3Pzb1UAWJuVQP5RsUkTDTQZ5zUkgHK9OteCSwkWsNc
	deLGK311EGVqsWt5IRcvzZnmB2Gy/UvJkKpEJDENVk+F7zHTN3quMaNIMIuA9ILJ56djc8t8/rO
	qvvmOplc6ROe0lUdLwQjZ2yTilkS/PpexU1YPQwqII87moIbGGPrXaOgvhu4tyigSPb7zMYjGzR
	xI4vRpE=
X-Received: by 2002:a05:622a:5916:b0:50b:4eb9:a988 with SMTP id
 d75a77b69052e-50d62b3d880mr2356201cf.56.1775151028009; Thu, 02 Apr 2026
 10:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401233745.2333858-1-joe@dama.to> <20260401233745.2333858-8-joe@dama.to>
 <CANn89i+dWeUvZW-sLU5ozZM5rHgDY1mXKOXM=EjdhJanumqVsw@mail.gmail.com> <ac6dQa1HRrfcpBhX@devvm20253.cco0.facebook.com>
In-Reply-To: <ac6dQa1HRrfcpBhX@devvm20253.cco0.facebook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 10:30:16 -0700
X-Gm-Features: AQROBzABYsDCk5bUyjikF_Y2Cm2DQFOMjo8Xpq6KL416fBLsEvJX17yIZzEV-jo
Message-ID: <CANn89iLOT23BffBrCYeDQqNFY7cfz7kEkWARym060Zu6FycBjA@mail.gmail.com>
Subject: Re: [net-next v7 07/10] net: bnxt: Implement software USO
To: Joe Damato <joe@dama.to>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, horms@kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274639-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1E3538C92D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 9:45=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Wed, Apr 01, 2026 at 05:35:14PM -0700, Eric Dumazet wrote:
> > On Wed, Apr 1, 2026 at 4:38=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
> > >
>
> [...]
>
> > > +       /* Zero the csum fields so tso_build_hdr will propagate zeroe=
s into
> > > +        * every segment header. HW csum offload will recompute from =
scratch.
> > > +        */
> >
> > We might need a call to skb_cow_head(skb, 0) before changing ->check
> > (or anything in skb->head)
> >
> > Alternative would be to perform the clears after each tso_build_hdr()
> > and leave skb->head untouched.
>
> Thanks for the careful review; I appreciate your time and energy.

Sure thing, very nice work BTW !

>
> I'll remove the existing clears you pointed and perform the clear after e=
ach
> tso_build_hdr() as you suggested with something like:
>
> @@ -103,6 +96,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>                 unsigned int offset;
>                 dma_addr_t dma_addr;
>                 struct tx_bd *txbd;
> +               struct udphdr *uh;
>                 void *this_hdr;
>                 int bd_count;
>                 __le32 csum;
> @@ -116,6 +110,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
>
>                 tso_build_hdr(skb, this_hdr, &tso, seg_payload, last);
>
> +               /* Zero stale csum fields copied from the original skb;
> +                * HW offload recomputes from scratch.
> +                */
> +               uh =3D this_hdr + skb_transport_offset(skb);
> +               uh->check =3D 0;
> +               if (!tso.ipv6) {
> +                       struct iphdr *iph =3D this_hdr + skb_network_offs=
et(skb);
> +
> +                       iph->check =3D 0;
> +               }

This looks good to me, thanks.

