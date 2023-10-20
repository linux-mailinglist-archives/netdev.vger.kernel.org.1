Return-Path: <netdev+bounces-43001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19D7D0FA1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93312824A5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FE19BC3;
	Fri, 20 Oct 2023 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ScRoQw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDD1549A;
	Fri, 20 Oct 2023 12:27:31 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FB11B;
	Fri, 20 Oct 2023 05:27:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9be02fcf268so115235266b.3;
        Fri, 20 Oct 2023 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697804848; x=1698409648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKzUbAm0CD7VIaW1XEsEu4drZXTXz0teauAQXRdleN8=;
        b=B9ScRoQwiS38jUL1MK6XSaEVQcG1y0CfW0/WeNNjW7rfXsVI9zpXKSvsJVGXpWryh0
         ueH4LBQLtziWxBZRYEth8jFkp5PJgPgrFnwdro9ZIORI0UF+poMfMGflf8yN4zN1u9SB
         mmqyXmJbbH7pXYD6aMan2Qa3B+nWmGt08S4/zddlRceHB9m4UXel49iS55p0yXnQZFAM
         /MBikar/EKoSxIDcpjVuMkwD98/mIyKXbTMFplzCjI4dCeVT1EeOZ2dTbWZvvUeOm4+O
         sf1smE5P92X840eQy6SY/DsHct264Nerk4lH7OzDuxxq1cVE5X+TlGCKCdhjcOiK0f+8
         AyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804848; x=1698409648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKzUbAm0CD7VIaW1XEsEu4drZXTXz0teauAQXRdleN8=;
        b=ROH+MYZX2DXB7+zTZdyNHGWIhu0g7NkvKg6ZysLFlO1VrM9Ek/dhB2dq2nvcwOteh9
         oTDCEEiXNgXH0W4ZHY0qLFL61sUg/bI6fx6KID4ZziIRvx49jvzGxhhoyqRG/eryWw6L
         0FgKtWZyHNzDoaOjFkuceQ4l2vdm+8FLHgcwVELvPzig4UJcaG7xFOJLuq781A7UPCcG
         HPuRfvnLACCEYhDmpG4sOk1/B3XfJ+qBKJgAtHqPRIVI4++g19Po9rcRWTf/CzT9O6Bh
         tYF3PNeEYTQDujMYKkTDb3YeN7T1c0nBIO0fea3QNKHKDnB1AXas2ghfKGeCtTwrRdUc
         BJyg==
X-Gm-Message-State: AOJu0YxqkjIVJYDX77RjYq/V/5vBC2h/IDKtJqXDbVDTtCziI36HPb2E
	kj1uFHLbVoHlSYeQhxJ+MYI=
X-Google-Smtp-Source: AGHT+IEkaDt4p+jBPoM1BNqVVTJsTIgpikA/nhvf4/pah9cW8W7yFnCtrDIlmywp9daPxLcMJ1hJpQ==
X-Received: by 2002:a17:907:25c4:b0:9c1:bee1:b7eb with SMTP id ae4-20020a17090725c400b009c1bee1b7ebmr1311347ejc.37.1697804848144;
        Fri, 20 Oct 2023 05:27:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906089100b009c3f8f46c22sm1411263eje.77.2023.10.20.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:27:27 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:27:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231020122725.2fotbdwmmu575ndd@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org>
 <CACRpkdbKxmMk+-OcB6zgH7Nf_jL-AV7H_S4eEcjjjywK0xCJ4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbKxmMk+-OcB6zgH7Nf_jL-AV7H_S4eEcjjjywK0xCJ4Q@mail.gmail.com>

On Fri, Oct 20, 2023 at 01:41:22PM +0200, Linus Walleij wrote:
> I can't reproduce this, make dt_bindings_check in the mainline kernel
> does not yield this warning

You used the actual command that the bot posted, right? aka "make DT_CHECKER_FLAGS=-m dt_binding_check"?
I am also seeing the yamllint warning.

