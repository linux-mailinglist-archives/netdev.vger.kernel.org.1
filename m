Return-Path: <netdev+bounces-29284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB078277C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54247280E74
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C574C9F;
	Mon, 21 Aug 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F94A28
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:00:23 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E4DB;
	Mon, 21 Aug 2023 04:00:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso4077385a12.0;
        Mon, 21 Aug 2023 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692615620; x=1693220420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGlPkN5vR6/cXafRltT2qDHXCkNMNiZanfUv1AGHWHA=;
        b=cX28qcpIpFYdPtU2I6lF4if5HSOmOSyw06W7Tg050kD8WyF6yNDeNL6Giqf5ThEeC6
         e+CybgtXogLy1uRbi3c2NTFpPb5+3FW9KLQrNffSu/E6SPRzwYDMuY8Fcl1jjelnB6hR
         DFLIIRXbErUnGoMwvNH+BRWPPrt5r9E6jM637DJfAtF+pSo1wfQjUyTd81EER2Kqzowt
         TA7gQR12TEiAhwSKfUZf+PY/xsazKqKfnuidzBMw5rdtX+ubvcts6oeOoiLv40ADR5w1
         8j4LyLq3ky5XjGj+mflB7wCBqjeEGJ+gL9SxRArHrORVqCi6+T+FsZz6eM8gLMUsgGzV
         bG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615620; x=1693220420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGlPkN5vR6/cXafRltT2qDHXCkNMNiZanfUv1AGHWHA=;
        b=TmKumA7K2KnXcypxvBwn0I7eQf9Ol93IaCbok9WkpeVssrezKCFHkH/W0l2BHKMHJV
         GACnAv9N0CuT7N+d2AZhwzP2fglIE/5bX982WZtFC6E3HGrOVZQnPRgKeJYC9+uRujEZ
         aihHuQ8bAT87abz/jSrce3H8x2fYAC9ef1qYSihUCkzzmCB2w52htYplM7Z6L97GZjsV
         +bzxZ7Qq8cOeB5JbTDoi/RDZAFUkKNgIcWIksvYZZw2/ObP0dvwp3tQEyHXgY+PeuA4k
         FzjxPOuZOBk6UOGNFIdp/K/ZMC1Rl4y1hcQ0khAYkZ1q0Izxz29DW7kOs+W2San+bOOx
         ck0Q==
X-Gm-Message-State: AOJu0YyUr2FA1HGJIhHk/2bAleSwJUj1WeCCciSJLpr9lEI4tTYiTx/O
	ielDl0YB8GSlilTvCux7bDgCXVjNoj7veFWJI98=
X-Google-Smtp-Source: AGHT+IG+XWmQXevDO4t9KhuUGEuXpHar0oV8iglmHHAb/6YvZIzsSvu2qUz631d6EAz7jMsg2rQMSqh3+Q8bPUyHvoE=
X-Received: by 2002:a17:906:1dd:b0:99b:dd1d:bc58 with SMTP id
 29-20020a17090601dd00b0099bdd1dbc58mr5612591ejj.41.1692615620275; Mon, 21 Aug
 2023 04:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-2-keguang.zhang@gmail.com> <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
In-Reply-To: <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Mon, 21 Aug 2023 19:00:03 +0800
Message-ID: <CAJhJPsXEf0Yuxasq24X=x_JtUJZrNC1aowfeuu9QM2kz+A=asQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 10:23=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/08/2023 13:13, Keguang Zhang wrote:
> > Add Loongson LS1B and LS1C compatibles for system controller.
>
> I asked not to use the same compatible for different blocks. Compatible
> is dwmac, but are you still going to use for other blocks? Please write
> proper description of the hardware.
>
Sorry. I didn't make myself clear.
The SoC only has one syscon with two registers.
And Each register contains settings for multiple devices.
Besides DWMAC, this syscon will be used for other devices.
Should I keep using loongson,ls1b-syscon/loongson,ls1c-syscon?


> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Make the syscon compatibles more specific
> >
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index 8103154bbb52..d701fff02abe 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -49,6 +49,8 @@ properties:
> >                - hisilicon,peri-subctrl
> >                - hpe,gxp-sysreg
> >                - intel,lgm-syscon
> > +              - loongson,ls1b-dwmac-syscon
> > +              - loongson,ls1c-dwmac-syscon
>
>
> Best regards,
> Krzysztof
>


--
Best regards,

Keguang Zhang

