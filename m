Return-Path: <netdev+bounces-22655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE221768900
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 00:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250EC280F4F
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B914F9C;
	Sun, 30 Jul 2023 22:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890614F96
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 22:04:04 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD8610D0;
	Sun, 30 Jul 2023 15:04:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so16516865e9.0;
        Sun, 30 Jul 2023 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690754642; x=1691359442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pahPU3wSvsqJHIDLsqPi1ulLhJMWKZSO5rvQ5dMXskQ=;
        b=q0sSR9AXHGYYmyVNDr+xpag+Dw277dZX9Y4ekqdWpmmrFAk+IkylG9pts4k/utI7SB
         zHxzRfyKPebgYRJYkunUtLvj5sS8zxKQl/rhUk5cZJQIXFjNIZ/nNClC0D6BWdCUF1kr
         fzAyd0fX7gdRjXwXHsIBljOjfQ2Pkl9bdDOji8mRYkSKOyEo1mHn2Y/99CtOUV7UOkQe
         KxzfIg/nQMircpIV0T3thGF+3HJlvdO6sZVPjU2MIA6s6Go9vK32qNngksFxfQBf571Z
         60mN9fdB21OXpFV8KY3m4hJg5j4fWeOvu585h2Cu3kZsVc1XjPt+g2fNfR9rszK7il5D
         lU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690754642; x=1691359442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pahPU3wSvsqJHIDLsqPi1ulLhJMWKZSO5rvQ5dMXskQ=;
        b=JfyASavspLr+F6tT5nQJJ9En37T32BSp4JSxrM8Atan4oDdO+WPVy5Ny0gbGfjCmrM
         zcw3VrPS2SOi34sVjLTZklTq/2QKq6OgoGMuotip+O0yZ46QuAKvIcn9f9Kbuwv+xCt6
         4KvpXES1lcFpjc11Nqbe7DVtSf7J7sy2ZmW73FN0VrCmvdtAwdGeuGE3ZrntRmbf++n8
         3hHdnr/11XNz61TvoUC1GruCJqzBHDgnQtwNilw8odKLhrfhfg8iCeZEnYxAdYHTx31X
         fzPllNeRiT1j6XXY9jlem9M46XswnxTJpAjI1eXuckm0QW+VV24o2Zvf3HYOIALjNueT
         3arw==
X-Gm-Message-State: ABy/qLZeMP5S1jUVH5yQ5Lei6q6So4x7mFYTMYHzgn8wDTyW+D99thgQ
	eOp87KGQhwoyqm0g/qbvJH8=
X-Google-Smtp-Source: APBJJlEgMsbnQlEpC7AIysBE3EqDVlDLnNG1AaWLi6MDNW/FVVcuRxpaFON35Ui2Xu5tD4xU0RLM5A==
X-Received: by 2002:a05:6000:1289:b0:313:ecd3:7167 with SMTP id f9-20020a056000128900b00313ecd37167mr5545390wrx.42.1690754641719;
        Sun, 30 Jul 2023 15:04:01 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm11132401wrt.73.2023.07.30.15.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:04:01 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, John Watts <contact@jookia.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject:
 Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date: Mon, 31 Jul 2023 00:03:59 +0200
Message-ID: <5694691.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <ZLzwaQlS-l_KKpUX@titan>
References:
 <20230721221552.1973203-2-contact@jookia.org>
 <20230721221552.1973203-4-contact@jookia.org> <ZLzwaQlS-l_KKpUX@titan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne nedelja, 23. julij 2023 ob 11:18:33 CEST je John Watts napisal(a):
> On Sat, Jul 22, 2023 at 08:15:51AM +1000, John Watts wrote:
> > ...
> > +			/omit-if-no-ref/
> > +			can0_pins: can0-pins {
> > +				pins = "PB2", "PB3";
> > +				function = "can0";
> > +			};
> > ...
> > +		can0: can@2504000 {
> > +			compatible = "allwinner,sun20i-d1-can";
> > +			reg = <0x02504000 0x400>;
> > +			interrupts = <SOC_PERIPHERAL_IRQ(21) 
IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&ccu CLK_BUS_CAN0>;
> > +			resets = <&ccu RST_BUS_CAN0>;
> > +			status = "disabled";
> > +		};
> 
> Just a quick late night question to people with more knowledge than me:
> 
> These chips only have one pinctrl configuration for can0 and can1. Should
> the can nodes have this pre-set instead of the board dts doing this?

Yes, that's usually how it's done.

> 
> I see this happening in sun4i-a10.dtsi for instance, but it also seems like
> it could become a problem when it comes to re-using the dtsi for newer chip
> variants.

Properties can be either rewritten or deleted further down, so don't worry 
about that.

Best regards,
Jernej

> 
> John.





