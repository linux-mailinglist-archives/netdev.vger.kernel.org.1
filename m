Return-Path: <netdev+bounces-45473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC87DD6A7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D71C20BB4
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DDA2231A;
	Tue, 31 Oct 2023 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9NkdNF4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5522318
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 19:27:37 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A2F4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:27:35 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a81ab75f21so59201417b3.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698780455; x=1699385255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgTgTKvE0/LmQ0UUACnDmBGwKLa/huixJLu9yRIa1F8=;
        b=Y9NkdNF4XAvRrtpq9suMkYZCI+J39LWfu7lo9Rjwak+6iDLPIrvffo9urFBXAaimTw
         qAQrrfi6pCuEqufuf4fRN37/19CwB5fDJHCgMg1Rk58S2VYlzhJ8i9yo8lMjognD6HJn
         A9gTOU6EobaCkKHVFSETnSvwOc405+ap1PfZ5WGQaCeQHvlM8oFOmtXBXQsfkie/jSoq
         qAJZq2PG/IseCZd88KiHoSkuv7HcpHG5+GxGuVGl9RYSwRgpI6vI96hgl09CEW+enMUf
         bDJaZ+Wj10d/W5aycrotQKOaTUJoQ+2zpn2dVwWWUNuL9PT6vmMH9pMYnNWnWWASl7nB
         KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698780455; x=1699385255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgTgTKvE0/LmQ0UUACnDmBGwKLa/huixJLu9yRIa1F8=;
        b=sn6zBhTnawwAVcv/ayRHZAw5W2IEeR8ta5d+/6uubInMJRWuTpNX5hktQnjG7turI8
         XL2fTRPDdj6tqMX1UzSiJ0BHuTYIm3aE09pJUO7M8cwmOikf3+BbplOSazDbHL6L/6VY
         bPgll3lcIcBtjv1fvs+DMKGWIaTfD3GqzAiGpbaONwMYUDr2W+N3n53WQtedbyAF4afI
         34HHfdMHMv806HlqVZ7YDCMTxO7zw1sYFVTSH+7zs6AMk6ZKBues7aYtOhqJYKvuCJnG
         htp/MiD9z/gLdHyD6TngKKIzOY0/76JiwK0F6bBNeruSpVlo7Rw/DYnEvyJHbZALdifU
         mTAQ==
X-Gm-Message-State: AOJu0Yx/j73sT9tpXSlR7fJDuEJZI8AsVl/HZJ1j4Sr/8AHMqMxEDOD4
	8wUbPl/HpVkfKqkm+LOMqeuqytJ1e1GTF3qORm/6bA==
X-Google-Smtp-Source: AGHT+IG66fduY86n48AWpX5L97lmRXb8vy/r6q2nf+6ervn5ys90qiYepzmZ5jvGaySDmnGn3l7ay7dvG7mhXw389RA=
X-Received: by 2002:a81:ed07:0:b0:5a7:ba09:e58b with SMTP id
 k7-20020a81ed07000000b005a7ba09e58bmr13510373ywm.14.1698780455136; Tue, 31
 Oct 2023 12:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
In-Reply-To: <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 20:27:23 +0100
Message-ID: <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:18=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > I don't have any other RTL8366RB systems than the D-Link DIR-685.
> >
> > I however have several systems with the same backing ethernet controlle=
r
> > connected directly to a PHY and they all work fine.
>
> Hi Linus,
>
> I ported TL-WR1043nd to DSA using RTL8366RB on OpenWrt main. Do you
> need some help testing the switch?

Yes!

> I just need to test ping with different sizes?

Yes try to ping the host from the router:

ping -s 1472 192.168.1.1 or so to send a 1500 byte ping packet,
which will be padded up to a 1518 byte ethernet frame and
1522 bytes from the conduit interface.

Then if it doesn't work, see if this patch solves the issue!

Yours,
Linus Walleij

