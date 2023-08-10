Return-Path: <netdev+bounces-26303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3BF77770C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E084282019
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0831F94C;
	Thu, 10 Aug 2023 11:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6E1DDF0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:32:12 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075810E7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:32:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564cd28d48dso544841a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1691667130; x=1692271930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C42cycCL5b1KjEaCe4Yw+mwNG6B5VgsAbMoDMhY9xjU=;
        b=GQKh8IlHBfHgvED6GLpu4WrkcT7shZ9dyylWT2XSozNR4iYFfVC3JqA6GTRqfHphw/
         5zKl5WP4tatyy5fFnjZQ0Z55waKUhcAccZasqPqGUMU8Udl/LD1jrYHhOsson9fgaoTF
         E1JFM/KsHfuMFWKPlDy6JHw6YvJJgSL2uWA+Bt8IeCaCYhG08NfRNv7J2eFBicToA0T2
         t1NJKXeRxpl3+a/OQoXq2uoUr2gwEbzYMglV0dIm8b9TWEbujP47a3hqiQkwsKvm3Qmm
         tHaprashov0kZ+uSpSGZqmJRk/uyRpHa4A60/NYz/En2fdL4eMmj3vxb82nTYjGeEWts
         FHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667130; x=1692271930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C42cycCL5b1KjEaCe4Yw+mwNG6B5VgsAbMoDMhY9xjU=;
        b=UCODDhDqg+u7D/p1FBVQ6D2M2kb6slkdwpe7CfnbU3c0wybjonzKCJ/Ww+Ebr0ncGE
         aWFJM5hWNBG5eFW4vpxaA/4sceQ+gEnMR8rP3kAgTa4r0lMWPJtHmr4H4+0jeOZHs7Z9
         CodxOv2vpj4uj+xJ1lA4lPz8nIZ9V5GXgTrw+jxw4MWmPdVoAhuXxylIzmc4aROtFJYK
         RbIjkG4TO6yuVFZ027X95HqEk+982R2ib1z23Dy4pGqwP0zd+i9WRqCqzv2Y8z0OBOBs
         3LsZORloXH1aWORO3QL1rrJSuUxvb24qPoikuUURAkeWm4QoGhjzOzNq+whLMxsJSivj
         jnLw==
X-Gm-Message-State: AOJu0Yx171DxOiQHFYo22ygNvthnRDlilJH5Jhz6jm+OODeu6kTfEVJw
	IUy0szQUV/GmgBSJjd2UpWoGHd9pBrLuztLuLw0t8A==
X-Google-Smtp-Source: AGHT+IGA04V8jAaFcjuH0Jicj5IhH1v6BEAOean6djo4D6WUkU+unA4wwFdOFfNJDH1L/YTqBnnfBXKGqCFVs51F3x4=
X-Received: by 2002:a17:90a:760c:b0:269:25a8:66c with SMTP id
 s12-20020a17090a760c00b0026925a8066cmr1535423pjk.45.1691667130293; Thu, 10
 Aug 2023 04:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810102309.223183-1-robert.marko@sartura.hr> <169166649202.64563.6248344012653953343.robh@kernel.org>
In-Reply-To: <169166649202.64563.6248344012653953343.robh@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 10 Aug 2023 13:31:59 +0200
Message-ID: <CA+HBbNE6H4WWW=+etRysPZr0bAXKaAq_0-oB0SnhUb5quQtivw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
To: Rob Herring <robh@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, conor+dt@kernel.org, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, luka.perkov@sartura.hr, 
	hkallweit1@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 1:21=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> > Add a new PSGMII mode which is similar to QSGMII with the difference be=
ing
> > that it combines 5 SGMII lines into a single link compared to 4 on QSGM=
II.
> >
> > It is commonly used by Qualcomm on their QCA807x PHY series.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
>
>
> doc reference errors (make refcheckdocs):

I am not getting any errors, nor there are any listed here as well.
Is this a bot issue maybe?

Regards
Robert
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202308=
10102309.223183-1-robert.marko@sartura.hr
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

