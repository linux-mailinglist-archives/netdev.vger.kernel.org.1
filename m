Return-Path: <netdev+bounces-292202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JMNCqqyFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760185E1752
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6185F3008224
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6D3E3C74;
	Wed, 27 May 2026 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abSVkwtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA63E3C76
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872106; cv=pass; b=noTUt9m3cirNNuQ3CY2coSSJjL+ODFc4IpHHrmBSU5P6UmH4rpALJMxzBgsp5GOxThRCiXCwp5DK5qBpNz2jvXJvuphLqeHrXuEAVLDXFD21Cs5+Xz8H9zGJUUxDgDvuavPSlj05CzAEeh3fhtFB1NnObGjvN/gRSz6RHth7ULU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872106; c=relaxed/simple;
	bh=k/rf0sprghjpMIgMuOwadzixiyngqMOQ9ESziPobPSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocvuhDsUNwwVFd+inuRwSZqwHkWicuOlLi4kQX8pgwjF6bEonJYTe0F8VYtdG5/RQ19B6bpeTcZEUWZzB1+00CzVscru/XLbyzVlZtE5lKdbktlqBro2vtPgdY1MoXu3rliETPUs6rdWXNZwfakO8eRpA05NXA1L+KVDWCI0AaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abSVkwtP; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f30a4601bbso11719226eec.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779872102; cv=none;
        d=google.com; s=arc-20240605;
        b=CTCisor3PsWlala1R49742aPBvecR0OqepqcHePay9cJFA7HO0ZJRcE+9qy6r8XSeo
         zBpNAqtgJUky8qIK9AtdCbtiyKz3bDesqGLRcK5h/8F5HsNDxgfqjyNnSRlbi4Nn1iEY
         m3AgA2tazBh7OQoki9GoTkEnOcUFd0Lj5XLAwddrl9TQ3dMKZJU4cTbsWXkRUXwy/lyl
         ShaCbiRdGR0BQAu/f+tT8Vj3aEfvA4o1QkmW5nHxOtQfxdwpSUJa47UVtw4VVW9ViaH9
         lzSgCZLL1P4fDd+EYpHDqPC6R/xgii+1VrsAw5LADogWUOQhUhzNFGehzFbe8Ir4znRY
         ZPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6QWsDCHfCMtM5YM23243b0CJRuPJzWBKJSsV9LUzw/c=;
        fh=0iXihvq7y77SyWas4tUXU88ZNLDMUwnw2MJyKGTee4A=;
        b=OSQK+LWPb9eF/9B0XNp340pYFoze+RwAFgzLVG9Im7ZZtBH2m+KFVDyrxL8TWZ5uFv
         euGw8DFuFFyghsuMw/vVyodt8Q3UY6XveT7WfOepAAG0Ft9YhnFR3YFouPY9Rrm+6B/Q
         D4oev+hNeb8lQyAJEkiIDdqktl1CSciQzxbRXO++L14fhh7LDfyn4cJeQZuiPROqXxSq
         uZeJNnp+P4cZLntNc+1sXe6zRMKMXfps4Q4nBW6sUaVs7ri392Rk7x75bx4WgDVBUaBI
         eW9IFBHMCMQYtOEuc8ImeQzJyf6yIawJhw4OyknoYo9E+ZXrBD5HF4f5c5hrgrDBIU0l
         Qajg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779872102; x=1780476902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QWsDCHfCMtM5YM23243b0CJRuPJzWBKJSsV9LUzw/c=;
        b=abSVkwtP9wfSyoCEFQTaTLLXaJuBuxo0YqIZ8bg78Xkb/MSaQ3RvlSj/uG4OmLNnBp
         1qtrzlAhk7T6vrl5F4KBnooy3QUt5VzMaTPn7wEKWcxgyIw2kinnlSxSek7cmZhCHa5d
         M5Ut2V121RytsTy/joiG6E2tyE732AwsyMaR8C/l/M9OukLXesPNd//ANFOCZxjOsybf
         VMyi0pVgtiMPaPjoAITpYYcQbWOYVShdWAs0Fzm0/rbErKpPDQrw6udpgBBTqOD345RR
         H0zZ9Og3dKHUZJji49HqMo4xPF3+G/r0ONojOvpaNWqtDTmpjipGrDGskJdx9swiDoUq
         y9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872102; x=1780476902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QWsDCHfCMtM5YM23243b0CJRuPJzWBKJSsV9LUzw/c=;
        b=mIzuVCXafHNfd9B17QBHGuvMFHVv5zSdzYTAwVFpr7BVYGenF/xMR8REAZF427Krtt
         sOkv/A2gWDv6HbAXT8rle1u8Rp3B8u+FktQRUGtYOmuEbHlA7F0mBeITGutOfK8B//Do
         FAzfOk+U0LhW7RgQLKjJXKM9YDr7s5AvlGcYh3rOmRukt1nfbJ/IvNARvKy9rnkB5qTG
         /hKlbM0YTjRELOHObXDVtWGIEkC1HMK6dN6Io46BiOKXiUszjGf6tAN+p4fw1hjpdHSH
         nYVvt7BpBBN5Rf0uzl2Lh07teqAXzOyNEZEKA43ckdN+Iw6++IA30j4SV5ewSsVcEkyO
         uBbg==
X-Forwarded-Encrypted: i=1; AFNElJ+IGdv0NgNS0BiF5pfA0oX9id5DpAuIgtblnkNsDeasI/s7zFjpwmH+5WxX57d8bZ7k3/UVgUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2pb1iJGTrYdexD2ZMKjcAZqJ5NswtvR7kVj4bWLON2DqUUjf
	PZYn4djDah207D3+RPqeZRzkDcmPCtnf2vbxc1wRfwgSuh90uqsc91jzJH2G6UPPuAnk+p8YWeW
	Jj+anRUnUvPE9anWjba+KxV3l7NJAdhM=
X-Gm-Gg: Acq92OF1is7RBSgfhaxq5NqOhpJzJOBO3EXKj4gEXYaTTEi2005ItVjrrkLACsnDKi1
	kZAxI6++7qFXy/n8+f37NW3nj56kiBRk/5oDoi5lPs/8EoQTWX0XwVryXljdWgGwzPoCcOdxrPw
	BrQ+zCLGZNFG61iEoQvaPOV/ua5u9miIvckXxvl4AEOewsC8CNXgK1TUJCz8HK1hVxqzlktZAkb
	bIN70Cbdszwj6y27CC5ZKnW1Lmmux6TWyEG2N8H5nQ70YpaY1dj6tSliEf9f0krNO3I841J27ZY
	9k80DGEL1no/kVDnFzU=
X-Received: by 2002:a05:7301:d0f:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-304490f574fmr9265322eec.29.1779872102437; Wed, 27 May 2026
 01:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523084408.50346-1-clamor95@gmail.com> <20260523084408.50346-2-clamor95@gmail.com>
 <d28799ba-a4af-49b8-a437-3e7b54ed06b8@kernel.org>
In-Reply-To: <d28799ba-a4af-49b8-a437-3e7b54ed06b8@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 27 May 2026 11:54:51 +0300
X-Gm-Features: AVHnY4JaYaiHwPLUWc19UBdX6yuMZEQ5-2cdxAvjMlSZR4fbv5UKlVc_P1AsxYk
Message-ID: <CAPVz0n0wzSkMjbkgy3nveYobruuDnV_Dm1A4gRQ6XOm6dTOrNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: Document Infineon/Intel XMM6260 modem
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292202-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 760185E1752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
3 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 23/05/2026 10:44, Svyatoslav Ryhel wrote:
> > Describe the Infineon/Intel XMM6260, a 3G-focused, slim modem platform
> > designed for smartphones, data cards, and Machine-to-Machine (M2M)
> > applications.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  .../bindings/net/infineon,xmm6260.yaml        | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/infineon,xmm6=
260.yaml
>
> Considering that you just sent "power sequencing" device completely
> independent of this, I think my review tag should be dropped because
> this is incomplete. Basically you will be changing this and maybe even
> in backwards incompatible way, thus this should not be accepted in
> current form.
>
> Best regards,
> Krzysztof

Noted

