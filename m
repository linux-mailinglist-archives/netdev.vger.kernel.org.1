Return-Path: <netdev+bounces-29555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9133783C79
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804BE280FBB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309A8F52;
	Tue, 22 Aug 2023 09:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63D8F4F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:06:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BA1A5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692695194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zITVam9mib7MXNblWRDDnWwcdZNI0hXQ9sYLmaBnbrA=;
	b=ILamFl2T3GyEjtHRIhaikRx6J8hG/N4783z9KFzzRbWQgUy4X16zJNOJv6uh7WnKCq4L3z
	SpvO0pTKlPHYxU4qPGdju63usph1X7JjCw0CSozQ8HY4SJjAFnDKp8NATshAs9D2pMWIhI
	ySZbHMnDvVc8OpmJGVbV6Ja4pY5pWl4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-jjVR6yYENY2kuAhWLwJ58A-1; Tue, 22 Aug 2023 05:06:32 -0400
X-MC-Unique: jjVR6yYENY2kuAhWLwJ58A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-523464082ffso576383a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692695191; x=1693299991;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zITVam9mib7MXNblWRDDnWwcdZNI0hXQ9sYLmaBnbrA=;
        b=h3wmA75l4vvQKd1Z+3u2LLotYJgjLiuM7YCZ5Xswt9sj9jBr3mAXMottKmPUvMllrA
         inoV26DskwhDSFVJpTwA0erlY7oPSl4l9H0djq8F0KPP43/18RVnH0/4SzOQ8dzGxNhB
         RIfVmLn00TOeUxk5d6cYIqMUf6nRnGQZGZO3PSXIAyoRM4G10VNxramz/y+iHHIdCXAG
         1bd2MgxOm3GyKvR2ifZ5/6+GKgSyc++cSW/yOChfwm2DNfVYRbrFLwixFDnJs/+Ib8co
         ijRTo4b9bOywgne5abojWI4kQ8nCZPpklWWZz4sRLsYD+Nd8pFV8Cm/Sr608YNNLEpI1
         30hg==
X-Gm-Message-State: AOJu0YxBTp7o66iuSBy+k4uSFTtNUKe9E7IWYA0cSq1HSOXj44nW+MFX
	d1z0cRX+gfdI5D8lERA0NC+f9FZkkfKNcNXH9rrbqBZsgAloYSTCxayJ7+5MAUWBlotp0VAnZ3U
	swhTiS06Q/emFqLWT
X-Received: by 2002:a05:6402:1d4c:b0:51e:5dd8:fc59 with SMTP id dz12-20020a0564021d4c00b0051e5dd8fc59mr7217541edb.1.1692695191297;
        Tue, 22 Aug 2023 02:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfZmPyXgiJ/NkAWWGBQMgHJy5FIu7B+DH5lu1nGvadCAiFsyleJ/rv4GEtyfZ7KoxM594bRw==
X-Received: by 2002:a05:6402:1d4c:b0:51e:5dd8:fc59 with SMTP id dz12-20020a0564021d4c00b0051e5dd8fc59mr7217526edb.1.1692695191035;
        Tue, 22 Aug 2023 02:06:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id f4-20020a05640214c400b00528922bb53bsm675146edx.76.2023.08.22.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:06:30 -0700 (PDT)
Message-ID: <4e79fe7d5363e69ed116f440db162dcb41b54ecc.camel@redhat.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: net: Add IEP property in ICSSG DT
 binding
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>,  Roger Quadros <rogerq@kernel.org>, Simon Horman
 <simon.horman@corigine.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew
 Lunn <andrew@lunn.ch>, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Date: Tue, 22 Aug 2023 11:06:28 +0200
In-Reply-To: <20230817114527.1585631-3-danishanwar@ti.com>
References: <20230817114527.1585631-1-danishanwar@ti.com>
	 <20230817114527.1585631-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-17 at 17:15 +0530, MD Danish Anwar wrote:
> Add IEP node in ICSSG driver DT binding document.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b=
/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index 8ec30b3eb760..a736d1424ea4 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -52,6 +52,12 @@ properties:
>      description:
>        phandle to MII_RT module's syscon regmap
> =20
> +  ti,iep:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 2
> +    description:
> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver

It looks like the feedback given by Rob on v2:

https://lore.kernel.org/all/20230821160120.GA1734560-robh@kernel.org/

still applies here, I guess you need to address it.

Cheers,

Paolo

--
pw-bot: cr


