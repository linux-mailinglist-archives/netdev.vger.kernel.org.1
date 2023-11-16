Return-Path: <netdev+bounces-48430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E87EE523
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16803B20B06
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7958E36AE9;
	Thu, 16 Nov 2023 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159D189;
	Thu, 16 Nov 2023 08:25:54 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1ef9f1640a5so486998fac.3;
        Thu, 16 Nov 2023 08:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700151953; x=1700756753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdF0221BVqkPNWgSqhec2EXy65Py3/xwAFMQEwbUdnE=;
        b=PYbFPSU5n1qJOAY+2hOs8hA039Myq/nAa52ERVDbh3i9vc4vXolQAvyk06h5EHhRx5
         xISIQCVrNFKPNApYgHaEuugAIAo3/S4BWCMq5tiPNRz1CogdtB7krXVVOos345G9Ng0w
         lWo3w0s+/Gebsgwxm6uz5TW4ZVv+0qUxC5eaFFpWLbFZmXFRADusxq4S2zaeXrbblFGu
         3Zn5eAdgM8LDBLQ7eGS9WgDIa3uyBN5sEI+Vg4dEirHkfTQDuR+9aYrP6hU4OGjcKFqI
         pxcK4OsbsQyuA47TYO6zNi0pq4wE29BixllczP4oCqURP76MuUH/jkRm50Ru65AVJaD3
         sLvQ==
X-Gm-Message-State: AOJu0YzJc3LsXNGcWxJxqBCVrcGMZC5PZUFyB0x1s42ll5FgpcWS0XID
	q6tW4IVoXpkdx7Jr9x2hcg==
X-Google-Smtp-Source: AGHT+IFsQ6G8Hs/gkiT6P18hdAozMHVcByhgRdiwKxciKv0SxS5pWE0upGxpEiMbTbEFLfhoIRdTmg==
X-Received: by 2002:a05:6870:239b:b0:1f4:8d16:ea08 with SMTP id e27-20020a056870239b00b001f48d16ea08mr19820721oap.14.1700151953227;
        Thu, 16 Nov 2023 08:25:53 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dd13-20020a056871c80d00b001ead209f185sm2168835oac.20.2023.11.16.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:25:52 -0800 (PST)
Received: (nullmailer pid 2434756 invoked by uid 1000);
	Thu, 16 Nov 2023 16:25:50 -0000
Date: Thu, 16 Nov 2023 10:25:50 -0600
From: Rob Herring <robh@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: arinc.unal@arinc9.com, davem@davemloft.net, vivien.didelot@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, alsi@bang-olufsen.dk, netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com, kuba@kernel.org
Subject: Re: [RFC net-next 2/5] dt-bindings: net: dsa: realtek: add reset
 controller
Message-ID: <170015195016.2434701.9542548877901507767.robh@kernel.org>
References: <20231111215647.4966-1-luizluca@gmail.com>
 <20231111215647.4966-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111215647.4966-3-luizluca@gmail.com>


On Sat, 11 Nov 2023 18:51:05 -0300, Luiz Angelo Daros de Luca wrote:
> Realtek switches can use a reset controller instead of reset-gpios.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


