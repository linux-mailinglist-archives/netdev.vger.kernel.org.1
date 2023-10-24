Return-Path: <netdev+bounces-43873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F417D50E6
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A2282BC5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7428E05;
	Tue, 24 Oct 2023 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561D1C20;
	Tue, 24 Oct 2023 13:04:56 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785230EC;
	Tue, 24 Oct 2023 06:02:36 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce291b5df9so2719691a34.2;
        Tue, 24 Oct 2023 06:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152553; x=1698757353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bojhTSTsuCl87qTSg9dwyC+AWPqf6CCiiKlFCn47SMA=;
        b=kiMsLZ6uTSQY9dTvtmYHcvap7T96lU3iTI8GBAILAO/8Bd1PHGuDj6bTPyd8DmNbxr
         rfIFK6rcYLdaMecqCTwSsmInFHDwI+FjjyDNPWIHAPX/XkFkIF+hM/bICbD1jalTO6kl
         XDTcoIfJ0hhfyEOxJP6rAI/kDTGo7tk99fioUa137P+4MfIfVsvinBNHMXG45Ms41+Tc
         1s8S+QntZRsG/uVFkuwTEPUzBsWTv/f1PJqS00AXlmAiJQRDy/t4uhIJc6rd6jzDEw0l
         O1MlzrrXyoykTIrn5I50gsdN9DOAem1BbruX4ef7dMTJcjnbxw2QxmEBwUdqk9rgj3nt
         C9gg==
X-Gm-Message-State: AOJu0YyuY2hdcVRzyxT1h77IHDzsPD0PIpss3zFyACC4tn6JuTiexU3J
	5uju+uBHXjit1oqswuOQaw==
X-Google-Smtp-Source: AGHT+IGUpCRFtAl12k2zrE5iNffwEtWXvGQyMLq+fmCsGVNgxRwFFaCEzK2YeigK5Qn5jprl1dXeEQ==
X-Received: by 2002:a05:6870:1b05:b0:1e9:ee04:d20 with SMTP id hl5-20020a0568701b0500b001e9ee040d20mr15371288oab.54.1698152553024;
        Tue, 24 Oct 2023 06:02:33 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c23-20020a9d6c97000000b006c619f17669sm1827322otr.74.2023.10.24.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:02:31 -0700 (PDT)
Received: (nullmailer pid 3469651 invoked by uid 1000);
	Tue, 24 Oct 2023 13:02:30 -0000
Date: Tue, 24 Oct 2023 08:02:30 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v6 7/7] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
Message-ID: <20231024130230.GA3465814-robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
 <20231024-marvell-88e6152-wan-led-v6-7-993ab0949344@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-marvell-88e6152-wan-led-v6-7-993ab0949344@linaro.org>

On Tue, Oct 24, 2023 at 11:24:59AM +0200, Linus Walleij wrote:
> The Marvell MV88E6060 is one of the oldest DSA switches from
> Marvell, and it has DT bindings used in the wild. Let's define
> them properly.
> 
> It is different enough from the rest of the MV88E6xxx switches
> that it deserves its own binding.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6060.yaml        | 88 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 89 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

