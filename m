Return-Path: <netdev+bounces-25440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDC9773FAB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FDF2811D0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9331B7F4;
	Tue,  8 Aug 2023 16:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310831B7C3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:50:55 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9217BAA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:50:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so68347531fa.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691513445; x=1692118245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKnU9SGNhRXh7JQMi9LxA4Fhq6dBeuKxy6dhRmxZasE=;
        b=LwCzqZWchRRLWqzaOh9V1OX4A5SbwUDozTitjIAIIwPfA6xfsRk4WDRPydmj8CfjAx
         H9EAuy9zd07GkrRPYXKfwagPyWJNTXdqhMvH4N+Fw/U/kmSB6W31xwU+G1EQHgAlMu2c
         n0i1bu79W2zNaQTehJ8ubX2a7B7O2vkgnrSCGXeiQqvo/9KTqLt8ISJv3xFWxWoVP6rT
         BbE7d7H1GvbmHFhqdX9FVGlKZfKCElt76I8PgOMKMgcJHugA5QQXipJyZYdypeOb2Vxp
         3FmJztSrng7y6blkSQpKUj1gZSBrk+YsDX4L5u6JrcOlpKoym78cTvvoveyufyYGiPQ7
         nNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513445; x=1692118245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKnU9SGNhRXh7JQMi9LxA4Fhq6dBeuKxy6dhRmxZasE=;
        b=fiVU5befStBdwKWzg9+gZ/c3Bfd9aT/zx3eAK8kqw5IKfi34jitk4/k7qBgeRxcpgp
         T6ITEvrrDAAtWiurfJF5TkpFlnNfBWpXmlUT3ehP/afZnUj4mc9KqySQPQRbYClhmTRe
         6wOJcIqKa3pRyjDZODJIJ0y250gaNd9Xp1d9RMOt5efUr9ZBYheyr8954c8HrO8ueX8v
         zSUTg3VWVb6z4YB7it4Ps8JgeTYIFcxi/igizgLvdM39sMaI78qeP9s18EAVhfJ5yZkv
         MB4MFCJ1fb7WeKWR7WkYdDCy0VxN3KBiPn6KjXwwpwKh7PzEggGd83P77JkjNNWY+yOV
         DWSg==
X-Gm-Message-State: AOJu0YxBzTnnSEAcuz3FtmhdxmiIvOubpKzVH/DQGVDQWDIEb6w0WCqn
	VMiZfg4c8+MVt3By9NkUnjHWxduW1JOlE2ukZWIevI4cm/wBGIiTgSbRqQ==
X-Google-Smtp-Source: AGHT+IElsjRa0J9HS7/2fBL75dvvl+iEtaAG/dD+slb4YkABigiWTNAI/wFojzqI+f99ltDUHAchU06wTWaLFbBWBQc=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:b066:66a4 with SMTP id
 f12-20020a2ea0cc000000b002b9b06666a4mr9299821ljm.4.1691497023708; Tue, 08 Aug
 2023 05:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807193507.6488-1-brgl@bgdev.pl> <20230807193507.6488-6-brgl@bgdev.pl>
 <siqiyihftz3musfjulpcqunhgi7npftumrfwfyh2pqnlx6zeb7@rrpwmkvjshfb>
 <da679b5e-6712-4849-b29c-6aa42022abc4@lunn.ch> <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
In-Reply-To: <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Aug 2023 14:16:50 +0200
Message-ID: <CAMRc=MdLky5sUbdFGFc+as906kr-J_XDmKmYtBBCHvETvqtAQA@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios
 property of the PHY
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 12:27=E2=80=AFAM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Mon, Aug 07, 2023 at 11:51:40PM +0200, Andrew Lunn wrote:
> > > > I have proposed a solution for this problem in 2020 but it never go=
t
> > > > upstream. Now we have a workaround in place which allows us to hard=
-code
> > > > the PHY id in the compatible property, thus skipping the ID scannin=
g).
> > >
> > > nitpicky, but I think that already existed at that time :D
> >
> > Yes, it has been there are long long time. It is however only in the
> > last 5 years of so has it been seen as a solution to the chicken egg
> > problem.
> >
> > > >           sgmii_phy: phy@8 {
> > > > +                 compatible =3D "ethernet-phy-id0141.0dd4";
> > > >                   reg =3D <0x8>;
> > > >                   device_type =3D "ethernet-phy";
> > > > +                 reset-gpios =3D <&pmm8654au_2_gpios 8 GPIO_ACTIVE=
_LOW>;
> > > > +                 reset-deassert-us =3D <70000>;
> > >
> > > Doesn't this need reset-assert-us?
> >
> > If i remember correctly, there is a default value if DT does not
> > provide one.
> >
>
> I've been trying to make sure I view devicetree properties as an OS
> agnostic ABI lately, with that in mind...
>
> The dt-binding says this for ethernet-phy:
>
>   reset-assert-us:
>     description:
>       Delay after the reset was asserted in microseconds. If this
>       property is missing the delay will be skipped.
>
> If the hardware needs a delay I think we should encode it based on that
> description, else we risk it starting to look like a unit impulse!
>

Please note that the mdio-level delay properties are not the same as
the ones on the PHY levels.

reset-delay-us - this is the delay BEFORE *DEASSERTING* the reset line
reset-post-delay-us - this is the delay AFTER *DEASSERTING* the reset line

On PHY level we have:

reset-assert-us - AFTER *ASSERTING*
reset-deassert-us - AFTER *DEASSERTING*

There never has been any reset-assert delay on that line before. It
doesn't look like we need a delay BEFORE deasserting the line, do we?

Bart

