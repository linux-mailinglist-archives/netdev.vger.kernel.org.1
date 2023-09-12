Return-Path: <netdev+bounces-32994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D964E79C216
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC2F1C209BA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FA8BFA;
	Tue, 12 Sep 2023 02:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69D1382
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:01:02 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C54C09C;
	Mon, 11 Sep 2023 19:00:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ad749473baso120914066b.1;
        Mon, 11 Sep 2023 19:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694484055; x=1695088855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgo1zR5ba8zxnSxQKk3+QRf81DN07ltnGADrPc7d11k=;
        b=gMogo4AhY+IghgAKv/dqSO6NzcmTrniqh9royi/TSzoiZJo28irlySLutp612E9tuK
         BBMwoLLnAS0zJvPtmy+c5WtUIIqgpTng079oW2K2+Bq524K4weTw2Oy2WKFOBtUIfbg4
         72GzayrUwnEJwfuqfDVodee9CDmbopyV8cLkOL8/ea8q8UfPnontCMgU3mzHRx6du0ja
         n5W63rz6OVjkCnxM3ywxTfiB3snu24pH5UbcJYv5CFbWukHm8HDKEv76QopydePgaLAd
         /eFaboKksX76TH9V0bN07wY8mVrmuDxyurBIKyddyRtDLgfTKp7v6hJtwoMk2HHCf7hj
         EWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484055; x=1695088855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgo1zR5ba8zxnSxQKk3+QRf81DN07ltnGADrPc7d11k=;
        b=qi8Nb8Pf8nWo+6BskQ0pGGo1TmxZsGNktOlZSjEL4EjqQFJxLTpT/lDudhJnaVU2p1
         vJkb1mctUd90YNNbWpkppHl/fYddCPX3RH06hr4NosPPj/+zdFz9OVcLAMHr99ChMN2L
         vuFCE9WODvvKrNtnvfm5j+mKzlRmwEhHExT5xkPJrGvprmKtr0mew54lgWzNYwOAvk6L
         uHVGxr6aQ0/jlarH+zhzBYc5qUiWFfUmLp59YLEZ1d4oHNtPF4unsQHgo29ReqG2DO8a
         ZrrVXbjH2a6VFNm3HGEf1EBGWkYrXBUGwa0rMH9FyY1pKZg1cIJP9Omm6VIfMlu3Dtr9
         kKrQ==
X-Gm-Message-State: AOJu0Yw3M4o8YIer2IcgPLiNxDvxc8xOehGhNHbyULE3amljpu3QMwRN
	3+s+Q14KYsz+R5L22YjAogJP53D6ABGHFc/Yg5pfHiQTw6q8pQ==
X-Google-Smtp-Source: AGHT+IGTFIR7+g6knPDfTeSAsGcvMkyK3tt/QZfxXD9gUYL7oSAg/sMWRQ3DYkmBemN57BvxqE1TJYvz0w+zW730aB4=
X-Received: by 2002:a17:906:769a:b0:9a5:d095:a8e3 with SMTP id
 o26-20020a170906769a00b009a5d095a8e3mr8810319ejm.13.1694484055049; Mon, 11
 Sep 2023 19:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-3-keguang.zhang@gmail.com> <5afdb9b9-e335-a774-fccb-d64382e02d07@linaro.org>
In-Reply-To: <5afdb9b9-e335-a774-fccb-d64382e02d07@linaro.org>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 12 Sep 2023 10:00:18 +0800
Message-ID: <CAJhJPsU9THio5efse2f+WB6oGPCvHcb8U4DvSdZ2fQ0SvvXAig@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: net: Add Loongson-1 Ethernet Controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 6:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 30/8/23 15:42, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 Ethernet controller.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > V3 -> V4: Add "|" to description part
> >            Amend "phy-mode" property
> > V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
> >            and loongson,ls1c-emac.yaml (suggested by Serge Semin)
> >            Change the compatibles to loongson,ls1b-gmac and loongson,ls=
1c-emac
> >            Rename loongson,dwmac-syscon to loongson,ls1-syscon
> >            Amend the title
> >            Add description
> >            Add Reviewed-by tag from Krzysztof Kozlowski(Sorry! I'm not =
sure)
> > V1 -> V2: Fix "clock-names" and "interrupt-names" property
> >            Rename the syscon property to "loongson,dwmac-syscon"
> >            Drop "phy-handle" and "phy-mode" requirement
> >            Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
> >            to snps,dwmac.yaml
> >
> >   .../bindings/net/loongson,ls1b-gmac.yaml      | 114 +++++++++++++++++=
+
> >   .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++++++++++
> >   2 files changed, 227 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1=
b-gmac.yaml
> >   create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1=
c-emac.yaml
>
> Squash:
>
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff1f273b4f36..2519d06b5aab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>   M:    Keguang Zhang <keguang.zhang@gmail.com>
>   L:    linux-mips@vger.kernel.org
>   S:    Maintained
> +F:     Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> +F:     Documentation/devicetree/bindings/net/loongson,ls1*.yaml
>   F:    arch/mips/include/asm/mach-loongson32/
>   F:    arch/mips/loongson32/
>   F:    drivers/*/*loongson1*
> ---

Will do.
Thanks!

--=20
Best regards,

Keguang Zhang

