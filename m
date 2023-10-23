Return-Path: <netdev+bounces-43632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D77D4071
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104741C20873
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573722EE3;
	Mon, 23 Oct 2023 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CED14281;
	Mon, 23 Oct 2023 19:49:57 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FAD68;
	Mon, 23 Oct 2023 12:49:56 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ea05b3f228so2555147fac.1;
        Mon, 23 Oct 2023 12:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090595; x=1698695395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOml9Fs4hOzKuKFOJI/FHMdAz6TOVK13fas10eq0Vz0=;
        b=B765MXa7fctubcaEE21VzEXnHcB5m5TUsKOaib5KMu+46pMRpJ8E4FAUlK5UZkUea/
         igEe7wnLJYmY8Pt/srekMvowJmJN2zqrlYJcsqNhhrYTsYlw7HDuo/R/E0zEuND0ijX3
         ZXLrwl4pLV7BGZZk+Sdzit/Zijf0oxFCkcUdu2MIL4rHbal3mIj9yDBOEytAFrxP6n++
         fMwCJfhqPCzGIYG4gDniTPwyF8LyWabxES5bxBrHJD92d7j2jPFC08Tempaqe+lQh9RC
         jyX2FV+nONJU3CWRV3iTHSAoMuiU4T/GtPwfpGRKSRlUGkWU7o/LzBUzDuBFUVY7A1Hi
         rN0w==
X-Gm-Message-State: AOJu0Yy39mu1aNgX2KOKGH17mb9+WwsJ0iJ8t1LxTLzrQyzkGQc3Bzf0
	Btqv3Lkw6usO2CV7uKxVCVAq1rrHUw==
X-Google-Smtp-Source: AGHT+IEJfKNoziu5KT4LDPxSPtLQoQrQ8kjptNN1dvn6JmcValfIIekDzmvGdctgxlZDQz0WflaiCA==
X-Received: by 2002:a05:6870:610b:b0:1e9:8b78:899c with SMTP id s11-20020a056870610b00b001e98b78899cmr12307489oae.55.1698090595284;
        Mon, 23 Oct 2023 12:49:55 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy20-20020a056870c79400b001e1754b9fc1sm1772111oab.24.2023.10.23.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:49:54 -0700 (PDT)
Received: (nullmailer pid 1152555 invoked by uid 1000);
	Mon, 23 Oct 2023 19:49:53 -0000
Date: Mon, 23 Oct 2023 14:49:53 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vladimir Oltean <olteanv@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Message-ID: <169809057969.1149966.2296744128010096950.robh@kernel.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
 <20231023-marvell-88e6152-wan-led-v5-2-0e82952015a7@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-2-0e82952015a7@linaro.org>

On Mon, 23 Oct 2023 09:18:53 +0200, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


