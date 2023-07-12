Return-Path: <netdev+bounces-17273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0223C750FB8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5F8281A6F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E420F98;
	Wed, 12 Jul 2023 17:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E320F95
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:34:30 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7D1FD2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:34:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso303411fa.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689183267; x=1691775267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT8r/UmjyiV4Mg80v9aMCsPu5X2SzHMkE39zee8yF1M=;
        b=CoRZfqI5+Ojs2K4mfukJbVoE0BjZCTjMaSlrU8mQ4EdO+67NSTRtK3xWH0nHC43nXp
         euuL+t/OQcAVBrHuUVXlBo4vtldRc1UymEwMS/vNlljCo+9HMl0fOlVLPsZg+WcCZQmR
         IyAuwzgWdqV1l6+din2C5Pm1J8LR51nDtOe0xvMxlSvTiCjGDKqiBL4rf9C1L8EypJAz
         LBlEq0RCpgaOC7nPxJFQlkOxrw7f8+uVCHk0G3OpyOkPwOJ38lH0PKrj611s1A4cFXlE
         3WySIS/LsYEub/OKfEtzmeL76FA7wBLOX4hmM8ciOEsT+EHjuefK4ncqq2s5TEAlTwtG
         hTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183267; x=1691775267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HT8r/UmjyiV4Mg80v9aMCsPu5X2SzHMkE39zee8yF1M=;
        b=We0895hcrGUphxb6B7JsoqSYYPapegkDdTJhO9i7eoR4CaY0LprKrUm8uveHD1jhG8
         UoA/Nn28/NPaLc1fkuSrA0KxxxyINIjQ1Zl7WJVrZAu9R26FTPH9n7KxoLy0y7Z0Ko5O
         e0qQD4ad4dE+VvPwPWclN7BwjW4c3sMJeeMh7ebHk1VTEWSU9Vl/ypRDhJ233lp385Sa
         Qr8t8R2kWCxgJ/NmyFlRns8WnTPQpLFXzJK++NkpY/eQS813tcpKWsAVAjuARbaqqzJH
         DaWx9vWZV23XWmFVplfhA9VbKYU9rVYKg4cR4RNI7rxSYGXrUYbf6LjTzrTIo2YmfUQN
         5pkQ==
X-Gm-Message-State: ABy/qLZbScTOCYztcKOWL1IGHIZtkGLLMGS2iwc7BkNTQrfE7Qu0nqKJ
	WHI7MojiHS/XXTgakw+1GdZkmykxFOGToZG3unEVrA==
X-Google-Smtp-Source: APBJJlGKRtWIKYFd9l6dVbzYKtlr4dgG9la2quqkLfXgUoiM7QU4QOmqaXf35MMSaKUb+r8Mo83FFJrwM91ICm+w4uI=
X-Received: by 2002:a2e:b045:0:b0:2b6:e618:b597 with SMTP id
 d5-20020a2eb045000000b002b6e618b597mr19138758ljl.28.1689183267182; Wed, 12
 Jul 2023 10:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706081554.1616839-1-alex@shruggie.ro> <8c188fbd-eaa4-4063-9153-d7b8c2772f8b@lunn.ch>
In-Reply-To: <8c188fbd-eaa4-4063-9153-d7b8c2772f8b@lunn.ch>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Wed, 12 Jul 2023 20:34:15 +0300
Message-ID: <CAH3L5Qrbrq0eAV762tQr_WWOS7G2Lxk3Yvz8egK=0FZNBE3NfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: phy: mscc: add support for CLKOUT ctrl reg for
 VSC8531 and similar
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 8, 2023 at 9:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 06, 2023 at 11:15:53AM +0300, Alexandru Ardelean wrote:
> > The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
> > have a CLKOUT pin on the chip that can be controlled by register (13G i=
n
> > the General Purpose Registers page) that can be configured to output a
> > frequency of 25, 50 or 125 Mhz.
> >
> > This is useful when wanting to provide a clock source for the MAC in so=
me
> > board designs.
> >
> > Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
>
> Please take a look at
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> The patch subject should indicate which tree this is for,
> net-next.

ack
will mark it as such on V2


>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

