Return-Path: <netdev+bounces-43634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA37D4079
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D7A280EBF
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5322EF3;
	Mon, 23 Oct 2023 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E722EE7;
	Mon, 23 Oct 2023 19:51:21 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4ECC;
	Mon, 23 Oct 2023 12:51:19 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1dd8304b980so2664771fac.2;
        Mon, 23 Oct 2023 12:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090679; x=1698695479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vjD1f+rFhGA5r6jcU9xMAYyC64I0UzKZmWUemtBFUg=;
        b=gaIz0DysIA3OZZ+mTGW+uTJ1bthiGLG3wdMCbPmbZHsINPwV4X5VjCECpqm4QeXzNC
         di1Ct6D2J45yv4PpMENqJTucTtjjCrOOaDbOLSDm1JXVrPVRoPXPxDjYV1Pwk84watzx
         Cm9dX8TeVSJs4nI/FWm7kdbhCdMlflxDbmCk37t6GJTwP7LFJsJNaMFStWnJ7gXkP2XM
         UDoBpUSCAQvs8zxs6W3wZk/6skvBFej/siOGqCRcVbmI6UTLFcKkwld3nGTBVDKbOOuw
         /StPdZZDJcnX5i2USFTRxDHegSQBfCOhY/dyuNvVr7jfYDiGddo8/53mngEVX4KiCIls
         slqw==
X-Gm-Message-State: AOJu0YzYkq/2AsO9pHA+QQe+6ORufHJ7C3cwC7sZx+a5gWOXsqBwE8tT
	2xkZHuVv7/c3msGa6+q6iA==
X-Google-Smtp-Source: AGHT+IFhi6ZqyvDvCA6CWgo1N1QDIFMUMDjrI6tPelmOqhdN9ITWcsn+2LifjCcBuTGT+UvvD2LgNA==
X-Received: by 2002:a05:6870:3b8e:b0:1e9:bfe7:e842 with SMTP id gi14-20020a0568703b8e00b001e9bfe7e842mr13548512oab.32.1698090679086;
        Mon, 23 Oct 2023 12:51:19 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l17-20020a05683016d100b006cd093a0ea0sm1528340otr.5.2023.10.23.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:51:18 -0700 (PDT)
Received: (nullmailer pid 1155530 invoked by uid 1000);
	Mon, 23 Oct 2023 19:51:17 -0000
Date: Mon, 23 Oct 2023 14:51:17 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Eric Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v5 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <169809067593.1155444.5818396584956468396.robh@kernel.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
 <20231023-marvell-88e6152-wan-led-v5-6-0e82952015a7@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-6-0e82952015a7@linaro.org>


On Mon, 23 Oct 2023 09:18:57 +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 330 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 -------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 331 insertions(+), 110 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


