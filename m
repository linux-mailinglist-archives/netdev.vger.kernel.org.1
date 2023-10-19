Return-Path: <netdev+bounces-42639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85747CFACB
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B1B1F2327F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104F27443;
	Thu, 19 Oct 2023 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW2EdFx3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877F2375D;
	Thu, 19 Oct 2023 13:21:30 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C498;
	Thu, 19 Oct 2023 06:21:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so13380204a12.3;
        Thu, 19 Oct 2023 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721687; x=1698326487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgxKa8AO9ndn9A10MY0AzoFh3nJur0uCTmMfy39Eot8=;
        b=JW2EdFx3QJ/7jxW2xpcnJYEN8HSXL8Vk0zF8lEfzK/9PRouUWJlGlxxsZmpJnGeKOG
         aurGBoh6Hzgij4mF6vE2LWAOYSlCkY8DILHKy7sOkAHbLp0OiBOhyhkMg7u5xhWKkTJ2
         vaTVMlU+CYEqwV4pvBY4GkooueLy3YBtVFVa1HQEaIQq8oivV8r1XO19dgM823JSdPTj
         jN8BWKD850e0enJAlOL+uGa1zwjI4vLUDvBGpZ5iiQOoiDS+IlejRBmJ/czHTPc/Zxbo
         S3kYOCd+k7/Q6956nQACvFcZ5Ts1BXAnnV2BBffHZIbjHZqJNliFtS3jTAM+qkFJUxJp
         rkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721687; x=1698326487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgxKa8AO9ndn9A10MY0AzoFh3nJur0uCTmMfy39Eot8=;
        b=PYRG5xKuPtldafesFA0iAVmMVnITS3mvFck700f5NeSgSM85+ysDtMyZQA7BEF8wwY
         kRvIvC+yrI0Lx+N7FNBEFUdZ7wEJ3m2F0l651+/x4PnPc34HQzONKpPAYRi9pxrzd2Sw
         l6hWc0oaXHfcXWRvDJwGC8WQUtWVVwd47Iq6ITvk8m1O1d5mpfoJj7ZM/UDs7U+yekPa
         ugNAcH5SfM4huCNaFxqQfBbTGF0zVmrozE9NQFFVaEwd1jVb5fE++fzteTmjvZ43TDZ8
         gCHASE4Bk0y3RUOj/HkSCc7XrzKuB+gPXk0/D0SXr4+SkwbKcPEmeW8EZONWoaIRTQGM
         qvEA==
X-Gm-Message-State: AOJu0YymFGuuwOoLHaS/Js/d5XeiLBZBVVVoJia6OOnx3Db8fGYkkebj
	6sTTWai3dbzh8gFqEtmjvTM=
X-Google-Smtp-Source: AGHT+IGPYVxFFY4V5wJ9ZKXaFEG0/Ul9BCX45nfhQeyJcBnICEDGph1b8CwndVzz+OMYm+48TScO8w==
X-Received: by 2002:a05:6402:2813:b0:53d:f358:202c with SMTP id h19-20020a056402281300b0053df358202cmr1823338ede.5.1697721687185;
        Thu, 19 Oct 2023 06:21:27 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id s10-20020a508dca000000b005340d9d042bsm4358136edh.40.2023.10.19.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:21:26 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:21:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?utf-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: dsa/switch: Make
 'ethernet-port' node addresses hex
Message-ID: <20231019132123.3jcyky3ruxfgstoi@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>

On Mon, Oct 16, 2023 at 04:44:22PM -0500, Rob Herring wrote:
> 'ethernet-port' node unit-addresses should be in hexadecimal. Some
> instances have it correct, but fix the ones that don't.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

