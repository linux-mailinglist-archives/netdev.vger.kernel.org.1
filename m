Return-Path: <netdev+bounces-58712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C6A817E38
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF32284824
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07129760A7;
	Mon, 18 Dec 2023 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tC+U3HQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CF1D685
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbcfd620827so2912321276.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702942931; x=1703547731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5B2rG8UlTjYSIDdwa9Flj/3/Od5g1E/zZOKfuiIR4k=;
        b=tC+U3HQdyb6tZvDohfFx+TKFhHYZ+8MTM2Pp5UPZXnTwpvES998wQhnW9+bN+Eclho
         H9aumlUAyKDCJc0b5cdMKP71cLkwcSYsn5CodKJr67Tlv56Ym2QcXtS9StKfA1rbhWKJ
         lMsEZaJrSUKwfuJAfmL/rPpsVbQfpfivTXvjFc1VcLpt2y4m82kUyxpQSyObANgtf8G6
         DDCNgIdB+q++byEwMUgqahIDtFAKHmY/O7H3ZPVChGE4N2oze6o97F4rxDMnaa+hzhW2
         cvEanztEZKN4cVaU6RoyL6fiAsUE6OFui8hZzMoLH1fFfE1f2VudcHX9++WXpPKy3t94
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702942931; x=1703547731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5B2rG8UlTjYSIDdwa9Flj/3/Od5g1E/zZOKfuiIR4k=;
        b=HMzIfWHegaIvjtDs6Pl93Z09lklR6QbmzKAglffGmUM5PqwXS3CcQ4GLy9hnzXDBdC
         dqZLC5BOxhjVMVsQO935MevKCy9UkdYqxtwEAOT+J8TrNtDfbeME74o2AHYqME1Vtq1+
         lI7L/j8f5CKCloJlSzaM1At68wj4GW/E+TLpx1ogmaU6sbHObIV0p77LillKpzQUuS8A
         iRtErwDcpFdUrrZoM4+fyMMI4N6dcKrNAkedjwPYol+yEmmLB75Gi9iIYv7Gg+vt5cII
         WmAfPXmB/M3GobglUY24F90xjChSWSGWaGxmBEf4NZwI0zSNvydMVbSC7IXljIH8ahrV
         7/aA==
X-Gm-Message-State: AOJu0YwQKJ2yeOELUzBXgIGqzP8wUlGeY9fLXpmQ4sIigHmbGRp8MTJA
	9gVaigg7yC3VZxexA/pxmtFWVE+5KAQJwSjAZLA6qw==
X-Google-Smtp-Source: AGHT+IHwGiZ+60OFD/fyGvAo5o66BgBPvrFJm0eQuSXUQRECf1OGaLxAlU5Oi1ZiDtLqM/Q76zO+m89lLHuaqm8/VNA=
X-Received: by 2002:a5b:9c8:0:b0:dbc:af68:44cd with SMTP id
 y8-20020a5b09c8000000b00dbcaf6844cdmr8291515ybq.108.1702942931347; Mon, 18
 Dec 2023 15:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
 <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org> <CANn89iLu_vE_S++5Q6Re4c6DZOD7GD-pLFC61VjYGcjFnKDWCw@mail.gmail.com>
In-Reply-To: <CANn89iLu_vE_S++5Q6Re4c6DZOD7GD-pLFC61VjYGcjFnKDWCw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Dec 2023 00:41:59 +0100
Message-ID: <CACRpkdbq=X485QuFvdd8Q=pPE0Hy4CduBbRZH7mdqag=mQw0ag@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> On Sat, Dec 16, 2023 at 8:36=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:

> > +       /* Dig out the the ethertype actually in the buffer and not wha=
t the
> > +        * protocol claims to be. This is the raw data that the checksu=
mming
> > +        * offload engine will have to deal with.
> > +        */
> > +       p =3D (__be16 *)(skb->data + 2 * ETH_ALEN);
> > +       ethertype =3D ntohs(*p);
> > +       if (ethertype =3D=3D ETH_P_8021Q) {
> > +               p +=3D 2; /* +2 sizeof(__be16) */
> > +               ethertype =3D ntohs(*p);
> > +       }
>
> Presumably all you need is to call vlan_get_protocol() ?

Sadly no. As the comment says: we want the ethertype that is actually in th=
e
skb, not what is in skb->protocol, and the code in vlan_get_protocol() just
trusts skb->protocol to be the ethertype in the frame, especially if vlan
is not used.

This is often what we want: DSA switches will "wash" custom ethertypes
before they go out, but in this case the custom ethertype upsets the
ethernet checksum engine used as conduit interface toward the DSA
switch.

Yours,
Linus Walleij

