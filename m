Return-Path: <netdev+bounces-45343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB27DC27F
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0986CB20DBF
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A63168CA;
	Mon, 30 Oct 2023 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHzBfcMj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2211DA2D;
	Mon, 30 Oct 2023 22:31:00 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8EE8;
	Mon, 30 Oct 2023 15:30:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50931355d48so300549e87.3;
        Mon, 30 Oct 2023 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698705057; x=1699309857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TB8r/SdZ5J8wZVmDWaMJ5xCqtTR3SHgzsbmCs77mgpc=;
        b=EHzBfcMjd2ryXNL9KsCeZ+bW6/PnFmaZp9/5oSVhNLQmsyx6nGpgK9vjOZWyPCsoln
         hf4rtrjfvE6/Iz5mfL488ntc+ZMPkCHaf9p+XK8G9XfwqWVbSWSuGL/OUJdNBueN2lQ1
         uKgzA6anCWBRg4Tszz8Dn6GJ67AUSLw4NvdphW/mir1S2CwBDwPB0/gbZIvI1FbVrfLB
         P7nhLRKkPZvjj2SVclZ3HnH9qv9qeOcPMS1aPI9BRywnmJC2+RiWh7TNNthbr6J9XjDb
         l525lp0TKfk0tXqvWKqQVsRjwtGjoGB2/oPqnMdoGFVghoX1kSZm/PWDlndT+B/6+nKJ
         hnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698705057; x=1699309857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TB8r/SdZ5J8wZVmDWaMJ5xCqtTR3SHgzsbmCs77mgpc=;
        b=ZobeSxaMXyBDAv+767AJzHxtTYq0hVZ8TewfX+BXJRIm4hFaF78c+8r8KDkIikDxrS
         F4HZ8FoIaFdFiuqNMA5NL0du2YAgLx8H8MpAVMI3Ds2nh0GYM8fnj2RGIqcnaiwVs1o3
         Fmq+US5eDDJ4QTlbNRYcpS1IP7viYKMeD4YL1AnO6YtCunvu+RiM3QpSA6ROAdGUtK5f
         dcQL21r/3Emrw3UKyNGw0pn6EpmFPQDQdpGmIjYw5/6rUMe8gq+VxBCnVlF6PwOR56w7
         I5abhoYIxKKhisRFLnzhaw286QdSCvjY6rQ6DMn8JQ0yNwp91FeHmyyqTcRR0Wf1VcEJ
         TsjQ==
X-Gm-Message-State: AOJu0Yz7zKspNn0zI9xrzKqEmZB+ui+A4x+RLo9Npd0weLzslUxWCA6v
	1pSdiHnzv3ejKEZwHkYq3n/gjMp883+OAXT+Wsk=
X-Google-Smtp-Source: AGHT+IGrwinIQ8yEEqopEv+9EL0QmlmPcr4E8zOJqdz5GZ/6OgIngxY/qm6YFuwLnQGT5nOiGM4r9Qc8IKBHjYjHgX0=
X-Received: by 2002:ac2:5147:0:b0:507:cd39:a005 with SMTP id
 q7-20020ac25147000000b00507cd39a005mr7610340lfd.39.1698705057112; Mon, 30 Oct
 2023 15:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-3-luizluca@gmail.com>
 <20231030131551.GA714112-robh@kernel.org>
In-Reply-To: <20231030131551.GA714112-robh@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 30 Oct 2023 19:30:45 -0300
Message-ID: <CAJq09z6wcj7NY_XqJ-80yN+6=Z+fOCZqpXH60pL29jcE+zTugg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: dsa: realtek: add reset controller
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Fri, Oct 27, 2023 at 04:00:56PM -0300, Luiz Angelo Daros de Luca wrote:
> > Realtek switches can use a reset controller instead of reset-gpios.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > ---
> >  .../devicetree/bindings/net/dsa/realtek.yaml  | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> > index 46e113df77c8..ef7b27c3b1a3 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> > @@ -59,6 +59,9 @@ properties:
> >      description: GPIO to be used to reset the whole device
> >      maxItems: 1
> >
> > +  resets:
> > +    maxItems: 1
> > +
> >    realtek,disable-leds:
> >      type: boolean
> >      description: |
> > @@ -385,3 +388,75 @@ examples:
> >                      };
> >              };
> >        };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    platform {
> > +            switch {
> > +                    compatible = "realtek,rtl8365mb";
> > +                    mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> > +                    mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> > +
> > +                    resets = <&rst 8>;
> > +
> > +                    ethernet-ports {
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            ethernet-port@0 {
> > +                                    reg = <0>;
> > +                                    label = "wan";
> > +                                    phy-handle = <&ethphy-0>;
> > +                            };
> > +                            ethernet-port@1 {
> > +                                    reg = <1>;
> > +                                    label = "lan1";
> > +                                    phy-handle = <&ethphy-1>;
> > +                            };
> > +                            ethernet-port@2 {
> > +                                    reg = <2>;
> > +                                    label = "lan2";
> > +                                    phy-handle = <&ethphy-2>;
> > +                            };
> > +                            ethernet-port@3 {
> > +                                    reg = <3>;
> > +                                    label = "lan3";
> > +                                    phy-handle = <&ethphy-3>;
> > +                            };
> > +                            ethernet-port@4 {
> > +                                    reg = <4>;
> > +                                    label = "lan4";
> > +                                    phy-handle = <&ethphy-4>;
> > +                            };
> > +                            ethernet-port@5 {
> > +                                    reg = <5>;
> > +                                    ethernet = <&eth0>;
> > +                                    phy-mode = "rgmii";
> > +                                    fixed-link {
> > +                                            speed = <1000>;
> > +                                            full-duplex;
> > +                                    };
> > +                            };
> > +                    };
> > +
> > +                    mdio {
> > +                            compatible = "realtek,smi-mdio";
> > +                            #address-cells = <1>;
> > +                            #size-cells = <0>;
> > +
> > +                            ethphy-0: ethernet-phy@0 {
>
> You didn't test your binding (make dt_binding_check).
>
> '-' is not valid in labels.
>

My bad. I (wrongly) fixed that in the realtek.example.dtb content,
which is derived from the realtek.yaml.
As it has a newer mtime, it was not updated with dt_binding_check.

>
> Why do we have a whole other example just for 'resets' instead of
> 'reset-gpios'? That's not really worth it.

However, as it is not worth it, I'll drop it.

> Rob

