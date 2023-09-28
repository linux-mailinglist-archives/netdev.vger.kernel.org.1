Return-Path: <netdev+bounces-36651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD87B10BE
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 04:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E59021C2091F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 02:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DC5220;
	Thu, 28 Sep 2023 02:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCF1872;
	Thu, 28 Sep 2023 02:29:18 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3AB7;
	Wed, 27 Sep 2023 19:29:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0ecb9a075so92794155ad.2;
        Wed, 27 Sep 2023 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695868156; x=1696472956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG7bj/7CYT96iOMQmtse7TOJSFKIa4UezWf2iE4PEvE=;
        b=JtZaJFatyFf9y1FreBzXZVERY5VEw+eu0u9vuzwEm9Wy6ubvE/rCZL95DJgC0YSEgk
         dbDLxbxcOreW7hvcOTS52lmOLZqt4Uvv6GMh2m8wB+ybwvxWjwdQrK6cA4Wg4LsXGIFa
         bVuZJnbzcxPkqImgQnJXJnAiNLWtPzqN33GH0MXDDeSBjEL6aIutM4L0ezxQ84ke+XeH
         4v+N3mIITA7h216C3dqyqp1MJK4MMarMUBsrs58eAUJqGJkxtPWowDmd7XNgUwd2sjfy
         XliMdYejaD+RGMFs3XDLl7ajXPLioBhinYjo3d9FbS5zXtskC5IpoGl04cXy1DZEzTq8
         5wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695868156; x=1696472956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG7bj/7CYT96iOMQmtse7TOJSFKIa4UezWf2iE4PEvE=;
        b=unAm0oB8wedhu5aoybDU+diGd183bYd892MYicAgHkLnZ2fy+bv77l0+a01KYfXtyY
         Jaxrqri54Jkhu2pAaySBwbYsnmBdCjED+qsYrkq+mBdjbZfe6lhGLrWnpSSDZj92KzvQ
         buZETO5zMAyRV1IunUZ7WQgI+4u3IL1ylg4AuS4l2rVRrueLuT2gu4nP6+X5uL33TtKc
         AllNGRAnKKrEl7+dfKu+uxy5sWgKyXTaG0BI8C9icsTdnSOKdULtSXpyhMlzpFseIMY8
         FKlAWPKnktgC02/vOIZpvuoHjS8Hf7epJF1/Z2vqnlHeVXG1ysF9wgArFLqMq/5CyB0M
         xwKQ==
X-Gm-Message-State: AOJu0Yy+6PvXvvnMY0m43/OlQ8wUBPvdqQb01Oo7X9IxGsuXwN/WxEwv
	tUlddvvwsP/6Bdn9sZYtmMxEmSA3DeC+TYqlHfwKmoNm
X-Google-Smtp-Source: AGHT+IHE+J9+PCCpTolKsXgabIXkyyjxEemfilvMDA9kojoN8aRInCiVaGad6KrsXMEhphmmI6D7ZB6fyXgrxFHASU0=
X-Received: by 2002:a17:90a:c256:b0:268:2543:723 with SMTP id
 d22-20020a17090ac25600b0026825430723mr3285091pjx.5.1695868155780; Wed, 27 Sep
 2023 19:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906095143.99806-1-aford173@gmail.com> <20230906095143.99806-2-aford173@gmail.com>
In-Reply-To: <20230906095143.99806-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 27 Sep 2023 21:29:04 -0500
Message-ID: <CAHCN7x+w-W8FPqSmM+SSVUAshjM4gRQrnYMj1h=GrzouO4EiDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: am3517: Configure ethernet alias
To: linux-omap@vger.kernel.org
Cc: aford@beaconembedded.com, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 4:52=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> The AM3517 has one ethernet controller called davinci_emac.
> Configuring the alias allows the MAC address to be passed
> from the bootloader to Linux.

Gentle nudge on this series

adam
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/arch/arm/boot/dts/ti/omap/am3517.dtsi b/arch/arm/boot/dts/ti=
/omap/am3517.dtsi
> index fbfc956f4e4d..77e58e686fb1 100644
> --- a/arch/arm/boot/dts/ti/omap/am3517.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/am3517.dtsi
> @@ -15,6 +15,7 @@ / {
>         aliases {
>                 serial3 =3D &uart4;
>                 can =3D &hecc;
> +               ethernet =3D &davinci_emac;
>         };
>
>         cpus {
> --
> 2.39.2
>

