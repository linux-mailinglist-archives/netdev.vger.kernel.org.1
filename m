Return-Path: <netdev+bounces-15033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF637455CC
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBE51C2083D
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 07:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5224819;
	Mon,  3 Jul 2023 07:15:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B8803
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:15:21 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B4E51
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 00:15:19 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso3812294fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688368518; x=1690960518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IAZeTOZazbGFZSDmndWdfTDNm2nB8DtY7mHI7XdQ7lk=;
        b=fwrYNJNQGr2V0i3pfa9Vg8VYK7yIzXp54Mx+sp9Ejgte1Va2hgY8F+rZDIsw+Y9Q6a
         nRp4ePOT5h7wKwqbVlcJXN9hTKgM7oyd4UeQO07XFij25ieux3InxE0J+r17kKtg+SOw
         +KXyXKR5Ml/hsgMppG7m5Hwz9fpFa2difABUqtcE3OrYMVi1I0n2V/1/1h1l5rS9iFGB
         5oKBkl4Fe8eFguqnOmUgoV8tPNUCW81H57jVYbBJKY+sKxUH7u5iki0WF4DTDw4yxJ6v
         r7nRIsXBx7VZ8Ul6LRsU7Ac6dILJQPncwm9o5+FgSpMkcd1FJA/yplKZ6q8fbIuqrHw4
         FPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368518; x=1690960518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAZeTOZazbGFZSDmndWdfTDNm2nB8DtY7mHI7XdQ7lk=;
        b=cTYZelwQCRYPbY9KpoSd+xt/QrD1ire0tZ2cT3SZGkuVzJX6I5vh25MbeAklqmy7LL
         CASNbV7dW3qP/n5Y6uTfusy6pfvozHRZ7gGYv/rJV1ZO1doyOtwON3dUL795zfqx1yG6
         Jsh/ga/TRrQS44uypIEw/DF9JxlFKq3WhhPEJ8TGckumh/ORFoRLfKaIW6/XfJaRMRoe
         Csy185Zetrtp4Rl05PhFdrint0dlbViYy816n0A3oW83Px3tOAMO7MykqgyK5ohnPzMl
         zCTAMK3ti95A17I7zmyPmFKDLaB9E5dL4CBJPQUoNfNYbBuihQbxm2eozm+WSzt6R351
         6Q4g==
X-Gm-Message-State: ABy/qLaByP+udbGcZU3KgwFcivrmbGKecoVQr/qUcWvLQYJv3K7YNQCq
	/KmtBOqUO+x9EMq2Qzk1IxJfMXTxb+zZvgTMPjLf7g==
X-Google-Smtp-Source: APBJJlFl1y1DD9smdIG3z9ZwGyRcMYA2S0C03PiyGo2Yyt6cyslQgtkKycE8R19wvHB6Fw36fGyu2SOkeqKm2IpNDeM=
X-Received: by 2002:a05:6870:6c1c:b0:188:1195:5ec5 with SMTP id
 na28-20020a0568706c1c00b0018811955ec5mr10062907oab.39.1688368518367; Mon, 03
 Jul 2023 00:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703053048.275709-1-matt@codeconstruct.com.au> <20230703053048.275709-2-matt@codeconstruct.com.au>
In-Reply-To: <20230703053048.275709-2-matt@codeconstruct.com.au>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 3 Jul 2023 09:15:06 +0200
Message-ID: <CAGE=qrrqE3Vj1Bs+cC51gKPDmsqMTyHEAJhsrGCyS_jYKf42Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: i3c: Add mctp-controller property
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 3 Jul 2023 at 07:31, Matt Johnston <matt@codeconstruct.com.au> wrote:
>
> This property is used to describe a I3C bus with attached MCTP I3C
> target devices.
>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/i3c/i3c.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
> index fdb4212149e7..08731e2484f2 100644
> --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> @@ -55,6 +55,10 @@ properties:
>
>        May not be supported by all controllers.
>
> +  mctp-controller:
> +    description: |
> +      Indicates that this bus hosts MCTP-over-I3C target devices.

I have doubts you actually tested it - there is no type/ref. Also,
your description is a bit different than existing from dtschema. Why?
Aren't these the same things?

Best regards,
Krzysztof

