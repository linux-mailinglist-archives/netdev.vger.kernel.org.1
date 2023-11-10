Return-Path: <netdev+bounces-47143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDBD7E8391
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A631E280D3B
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F33B78E;
	Fri, 10 Nov 2023 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D33AC2C;
	Fri, 10 Nov 2023 20:15:12 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F1A9;
	Fri, 10 Nov 2023 12:15:11 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so1415637b6e.3;
        Fri, 10 Nov 2023 12:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647311; x=1700252111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQPaNqtA0VC0hVnwYelQKy0jI9tj6pJgT2JLADbDcD0=;
        b=lfjTBj58EXzelXXObfs/uA84eN7LRaoNtXKbrFQe6nqfFYMzgGjzDbctb5fTOc87bP
         SM4Ml5oL4raEP1CaPR/GEWWt42cQ74h2EV/tdxkv2C4V93bKWcm6jvwMzaE9+iW5OXP5
         rdk3ka63L5eHipaa6CYao2HtcFE83T16Nn+wCKuSXggQMKcVGElNy1IVDPh4ZeNZsBHJ
         howDrd5wGEdjtDTrK3WQ2Lvqnr6WQwzmGxFltrdYxfjeD58EyPLoOofb1is/6CyuSC7f
         Hb3pad+8lMRxceqGOUIajKACtYUOMLqhEL+z5ovg1ge+30JV+L1Syp0v05+JjioHYMNn
         QOXA==
X-Gm-Message-State: AOJu0YyF/gVkl3mJrotqDuyaGb5HqNB3cdRB5mz70vCjg2A2voejjTzU
	3zU52+omOBG0RNlTt2amgg==
X-Google-Smtp-Source: AGHT+IFKsjlOyPXC6YCPR71oosv3AThTLCctELXTyDnJUUQ7cwL2z6lu8u2ZpGFiF6866UnyNInR/g==
X-Received: by 2002:a05:6808:19a2:b0:3a1:e17a:b3fb with SMTP id bj34-20020a05680819a200b003a1e17ab3fbmr518472oib.1.1699647311070;
        Fri, 10 Nov 2023 12:15:11 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e23-20020aca1317000000b003af638fd8e4sm34328oii.55.2023.11.10.12.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 12:15:10 -0800 (PST)
Received: (nullmailer pid 355923 invoked by uid 1000);
	Fri, 10 Nov 2023 20:15:09 -0000
Date: Fri, 10 Nov 2023 14:15:09 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>, Robert Marko <robimarko@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [net-next RFC PATCH v6 4/4] dt-bindings: Document Marvell
 Aquantia PHY
Message-ID: <169964730814.355844.982448346272624402.robh@kernel.org>
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109123253.3933-4-ansuelsmth@gmail.com>


On Thu, 09 Nov 2023 13:32:53 +0100, Christian Marangi wrote:
> Document bindings for Marvell Aquantia PHY.
> 
> The Marvell Aquantia PHY require a firmware to work correctly and there
> at least 3 way to load this firmware.
> 
> Describe all the different way and document the binding "firmware-name"
> to load the PHY firmware from userspace.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes v6:
> - Add Reviewed-by tag
> - Drop comments in dts examples
> - Improve commit title
> - Fix wrong reg in example
> Changes v5:
> - Drop extra entry not related to HW description
> Changes v3:
> - Make DT description more OS agnostic
> - Use custom select to fix dtbs checks
> Changes v2:
> - Add DT patch
> 
>  .../bindings/net/marvell,aquantia.yaml        | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>


