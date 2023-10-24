Return-Path: <netdev+bounces-43844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B14C7D5035
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189ACB20E44
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300B266BE;
	Tue, 24 Oct 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235533F1;
	Tue, 24 Oct 2023 12:48:42 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE311CC;
	Tue, 24 Oct 2023 05:48:41 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58441865ffaso1721340eaf.1;
        Tue, 24 Oct 2023 05:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151721; x=1698756521;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7IhxXRlskYcJ5lLaoUuwURziaHmVBMP8WH2znEzqGs=;
        b=Y1G1q7jMc74LjCLEaUd89MOJzvtgH/hCuk0gBlKSPZiBH/9khLZA19KdaebICO72dK
         36+CA5S54aH2hJtaraXaG8bpOWtldTTVaucUqMqKa6cUlB6LCc4C6xmvSY819timovrU
         8aYxXVAYaV9V2UxEd7xDUNq34qYfD2JyT0KCCfbJYUfIEifjesj9KSmlxtso954hZ2Nj
         8MQOZSULS4QCkrktF/EYgSZtduEjx3g2vBDAEqEPi6ssONhK82FHbipHn+Xwn/eJhiE3
         dxNwyxhchXkwf8YuAFHjJ0eiYHVWX5zJebiklKUkYJkfTcSuggvuCBdeBqMYzSz/d7JW
         brpg==
X-Gm-Message-State: AOJu0Yy22eGZP7B8TcvYu3ogQc4fsS1I1PbCeAWCPaaIBWxcYvA0hyvB
	DOK17dUqUJpfldawpntU+Cejd1poUg==
X-Google-Smtp-Source: AGHT+IERP02p8mG8jQwC1rb7eQXcVDY+PYIHSHNQTUPah9qW3w7GkcKnL2Mp8Z4hl+R+YXDXxBtwQg==
X-Received: by 2002:a05:6808:18a9:b0:3af:5fea:2f7b with SMTP id bi41-20020a05680818a900b003af5fea2f7bmr15719454oib.47.1698151720916;
        Tue, 24 Oct 2023 05:48:40 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj6-20020a056808198600b003adcaf28f61sm1924931oib.41.2023.10.24.05.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:48:40 -0700 (PDT)
Received: (nullmailer pid 3451039 invoked by uid 1000);
	Tue, 24 Oct 2023 12:48:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, Gregory Clement <gregory.clement@bootlin.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
 <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org>
Message-Id: <169815156038.3447619.17571704457000261488.robh@kernel.org>
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: dsa: Require ports
 or ethernet-ports
Date: Tue, 24 Oct 2023 07:48:34 -0500


On Tue, 24 Oct 2023 11:24:53 +0200, Linus Walleij wrote:
> Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> a DSA switch node need to have a ports or ethernet-ports
> subnode, and that is actually required, so add requirements
> using oneOf.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


