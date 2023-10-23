Return-Path: <netdev+bounces-43561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB857D3E16
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DAC280F38
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94421112;
	Mon, 23 Oct 2023 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFE200BF;
	Mon, 23 Oct 2023 17:43:43 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B926FF;
	Mon, 23 Oct 2023 10:43:42 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-583552eafd3so1929325eaf.0;
        Mon, 23 Oct 2023 10:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083021; x=1698687821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7LX1REoaUHg4Ho2SH1SkZYL3w8GokVQSY2mKadQZME=;
        b=KE4NYb5CfVc9teXuBFUmlPzfbWSIAuTw9zodVj3Z3MNfJykKQZ3XQRD6j4SJjlHIcL
         RvTnEfEv6YGYlTndWkybxwyJbYuIGSBtqtT2/oSKSksCLCmFmrJi7q5igDbTvngjJVuJ
         2MGYFgtmt2ezxFbmftNfNCSP6qqt4oBMezrCJBqCb7GwU+5ihhPT2Rapg7rYzzVUrt3K
         pfkcX4aXbkyyzr+VuSaiaVLwkrtQsVbofCeEc6WvRd3632dG+lFHGycrwL2sWBcfmVMG
         sd5HeLWeE62zKT9/ib5kNOkY5k9gdWpWUtl+F68q8TVv8aryeaSqwJKMyVnxBFMIr3d4
         aNXw==
X-Gm-Message-State: AOJu0Yzt6JkD3BtAqpnopuduGdnW8eSVLCOq9HARYAkcAawa6YJ3CRsv
	arXt5CZoFvh/fdKKCpwq4w==
X-Google-Smtp-Source: AGHT+IH4CGn5BouhmBudMVEJ2xntrZh9i20oGkrxRttcAVrPeJoL+bhkvjPFJBIFu46oMns3TmYouA==
X-Received: by 2002:a4a:db89:0:b0:582:c8b4:d9df with SMTP id s9-20020a4adb89000000b00582c8b4d9dfmr9412997oou.1.1698083021376;
        Mon, 23 Oct 2023 10:43:41 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6e0:8169:8cd7:6070:de02:c079])
        by smtp.gmail.com with ESMTPSA id f22-20020a4ace96000000b0057bb406dc31sm1589980oos.2.2023.10.23.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:43:40 -0700 (PDT)
Received: (nullmailer pid 867812 invoked by uid 1000);
	Mon, 23 Oct 2023 17:43:35 -0000
Date: Mon, 23 Oct 2023 12:43:35 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231023174335.GA865777-robh@kernel.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
 <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
 <CACRpkdZ_o0pMXZEVWfGiu2tPjv=dLMagT6KF-d=kaZ6fJZqr0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ_o0pMXZEVWfGiu2tPjv=dLMagT6KF-d=kaZ6fJZqr0A@mail.gmail.com>

On Mon, Oct 23, 2023 at 09:51:00AM +0200, Linus Walleij wrote:
> On Mon, Oct 23, 2023 at 9:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > a DSA switch node need to have a ports or ethernet-ports
> > subnode, and that is actually required, so add requirements
> > using oneOf.
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> (...)
> > +  oneOf:
> > +    - required:
> > +      - ports
> > +    - required:
> > +      - ethernet-ports
> 
> Ooops I meant to drop the patch altogether because I just
> couldn't figure out how to test this.

Just move it up a level (no indent).

Rob

