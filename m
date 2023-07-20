Return-Path: <netdev+bounces-19632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3E75B7EF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B68281F8A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A61BB56;
	Thu, 20 Jul 2023 19:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783319BD0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:25:45 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65919171D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:25:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9cf7e6ab2so945845a34.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689881143; x=1690485943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAQyrdEhvsiS2R1Xx2rcZGY3e8qP6qEuY1+LKv5tz+A=;
        b=ehA/kC0QSIFAeXHxRnlSfa6uGMtT3D9qXfjnwMdBvSmQciW1wwWutz6XfUTP1RXWY6
         7IIzIGJ3l/gFqQO2WTI0Ek0NVNzIOuLYp2iPlKGgVUm9YrpE02gpnIp8QZXgroC6RMz2
         QpNrdjic08cKSDPWbc1Ei7mJLl1COpzyv99ANmoj78MFHLzXfUv6DxD4beS69IC+raUf
         ID/Y2LO28HS3iJns9WDOXW7Nj2URTmVD0IFNK/e65rH4z/i5QSCUPTvouCrSH/Lcc7nK
         k9hOuuY3IqUjRucrLSRIA4wOPdWe1giSUKTw4Y84kH0yrRxxN+e+qQ8X4l+JG0X/wQKz
         iCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881143; x=1690485943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAQyrdEhvsiS2R1Xx2rcZGY3e8qP6qEuY1+LKv5tz+A=;
        b=Ll7uZBu9lCdHJHEjcjchnOX5Sb8cL3+AJIsIOXw3tB5VqxQzNr0aSX5nvh8FosLG/b
         RHdBTJv/RHtstLXR8mTYdiv3ZDFcNGQc2mncU9sSPH019bdQNyoJ5jgPhXTYfF+Zo51o
         ABcvwNDuRH4C3v2/ZxUYDBc1Wxgb/Anct8EIA+JhcrIDtul78EyNENzZF9ToEDdlcTRW
         76YepEv/e7qNPVzyYINwOxoAb0uqz+KKyYnXWvUQQJvzED6R3byib/mabKYw7qX/Hvc6
         yZr0RMh3HJYXt2VCS8XbJH8t0JP16J7P5DcNVmQC8kuqexyzdw+c9FSxORXsHZWnQAAK
         0ZNQ==
X-Gm-Message-State: ABy/qLbhbO2vb0qNggrtZT0UC3MHdT0st/0S8l9K5VAeZ4fyO4B9biZT
	3ozScr/IjM9FOLwwWFwKa8j5me1yNNktTJTmV3EaMA==
X-Google-Smtp-Source: APBJJlHrl322zhUTS4E8ekDobmG3vr4lmJX7pcYJyess5H8vaWCHscXLoY9qJztZNFzfwLbcuw66YlSe2go8Rn5W+Sg=
X-Received: by 2002:a05:6830:1e81:b0:6b9:b8fe:bf46 with SMTP id
 n1-20020a0568301e8100b006b9b8febf46mr4003118otr.38.1689881143774; Thu, 20 Jul
 2023 12:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712022250.2319557-1-colin.foster@in-advantage.com> <20230712022250.2319557-2-colin.foster@in-advantage.com>
In-Reply-To: <20230712022250.2319557-2-colin.foster@in-advantage.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Jul 2023 21:25:32 +0200
Message-ID: <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add
 activity and blink functionality
To: Colin Foster <colin.foster@in-advantage.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	UNGLinuxDriver@microchip.com, Daniel Machon <daniel.machon@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 4:23=E2=80=AFAM Colin Foster
<colin.foster@in-advantage.com> wrote:

> Add additional functions - two blink and two activity, for each SGPIO
> output.
>
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>

Could Lars or Horatiu review this patch? You guys know the driver
best.

Yours,
Linus Walleij

