Return-Path: <netdev+bounces-31411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0578D69B
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17132810A4
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBC63DE;
	Wed, 30 Aug 2023 14:46:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7663AF
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:46:15 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F37198
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:46:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so209628666b.0
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693406772; x=1694011572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pBWaiAxt3c7UKiYBVmzRQWXUVgNPi+xoAwOSlkZgSg=;
        b=kcVQUuKkxP0F+OLs8erkthnGot2to+j+oP753j1esqtt6NZuqECeJaGiOlj0PmpEuC
         fprZg65jFt/ETMPc5ruZPFwhCLNHTVLFHoD+H8J9dv1LPdxIUdAKLszDC8EU+8Ev4IUy
         HE8qAJpbbshp+h144E9oLxqn3tZxyBF1R1+IpaNy2n84Q2kq0qFckOOfXfjzDlDzDYx6
         F8UxLEtSMC4cOYAOM1ODOD7fENfmnUyeLTpXeoYOEU7+NmKSp/FJZI/LUNbi6oe3hNju
         R2y4OeKUoSja3zyy2rSKyOPVZukNu0oeHDWyzF4zBISb3SYSML3Y1N4WCV+4ywrlDny0
         VNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693406772; x=1694011572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pBWaiAxt3c7UKiYBVmzRQWXUVgNPi+xoAwOSlkZgSg=;
        b=KzyuaPVE9V4Nbh7b/BOTl9ATrsx+E6Lc/tuguoM/IP6s9+7/RWCGPw2zreQyWf8s27
         h9g1C5bzpmWjUtOiBpUBvPAykCY2EsIUNUpumV3VncLZibtgChh/9dM8pj6ziSN6STr7
         4j7+FK8l9ugrnKpHXkmbqlJggKzp6SUFLc1pzXOD+dvKwsWuXPgw8OAJtvvGhfOtn8Qw
         26n2nhTgFEYwXNoieBZF4yxkT0DgpzDIS6uG+Y13puCKEy0X68qeDcY/+sYSSkciPNO7
         2GmgAEpZ7asSXepEt2OWP1npTyBk+hosuO8IcRyZv+Pq3l1X63EBIH703WpQ0gD1oc/8
         sFcw==
X-Gm-Message-State: AOJu0YzLHpP/+jhupEvcNMxRGvbTIBAXz3c8edbuyxiGOZYEFLfdJnvI
	ylnCC9L70+6KRy3iQylOKUrHFg==
X-Google-Smtp-Source: AGHT+IECBfom6bQT2ajlFb2yXCA1KjL8rdq1f4FAA8HWcZ+VnqFs+cy5NHaCNPbc9rBQ2bDMqwdkSA==
X-Received: by 2002:a17:907:c004:b0:99b:4210:cc76 with SMTP id ss4-20020a170907c00400b0099b4210cc76mr2530744ejc.28.1693406772113;
        Wed, 30 Aug 2023 07:46:12 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00999bb1e01dfsm7239237eja.52.2023.08.30.07.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:46:10 -0700 (PDT)
Message-ID: <25b44b0d-e958-ada3-3900-589224c1e37f@linaro.org>
Date: Wed, 30 Aug 2023 16:46:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add compatible for
 AM64x in ICSSG
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113724.1228624-1-danishanwar@ti.com>
 <20230830113724.1228624-2-danishanwar@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830113724.1228624-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/08/2023 13:37, MD Danish Anwar wrote:
> Add compatible for AM64x in icssg-prueth dt bindings. AM64x supports
> ICSSG similar to AM65x SR2.0.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 311c570165f9..13371159515a 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - ti,am654-icssg-prueth  # for AM65x SoC family
> +      - ti,am642-icssg-prueth  # for AM64x SoC family

Keep the list ordered, probably alphanumerically.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


