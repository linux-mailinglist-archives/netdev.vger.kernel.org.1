Return-Path: <netdev+bounces-29108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A6781A21
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C350281B4C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F64A16;
	Sat, 19 Aug 2023 14:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB334A0F
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:33:51 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9113C10
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:33:49 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d7485d37283so280199276.1
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692455629; x=1693060429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFVyJcG7VjoXmbWzRwKLX5v0Z6m+qJ6RfIWifPUhgDc=;
        b=PKHN5JCpBUno6/8uc1UHXr49bD0JiNARpbXYs8VUbvDNDkq0Z8tCowq/V6EGyAOGOQ
         TyXuLZSzXeBPcv4Lnj7tFRGzofx3JcploYA40BiUeZ/aPxE8WhRBugv02r9OEMi/Qql3
         e2tf7p2mtCgbzHhhUkKUC5GTf7jMT0HTbyv4R5+hk1ANKX9haLk8H7W3kMcuQCbqnoPp
         O3PcwynlBtsnxxMei2HYNciP+gAczGH1GoA3fI7C4MRXAdjYiuOweeHmcpGPZ3mBO2W4
         xsSMFtMzNhDtYdNlRisaHE9yNIniP3F7BexviNcOBe+ExDDC93CUdWBCsLIFg4JxUhal
         NhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692455629; x=1693060429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFVyJcG7VjoXmbWzRwKLX5v0Z6m+qJ6RfIWifPUhgDc=;
        b=gO5+zVSGBFqMrZCNKOljdph8UXrUrIAgaze2U5gmpWy7mto8JP9YAP+FIdmSnN4s+0
         b3MI9WN8gT0hr1HQk6zb3InFS+n0pOBmjK+u0/xGipuBZFY0cxcIGYy1WpMOyeFdaeQm
         y+FWGhQ8fWQ0NSUZyUYiiXp73KXTSHJaF3LcClTIHNoSkTYcG9HM+FHfX6eCgdSTe5m3
         Q8y8WWn25zZkyNZh5T00NTZ4ouK9D9QQuzad0P+xJfxQRsVrnC20CmS4ylmr38KNOaUF
         CqJJ3cCqHt/qCFa/Qm5SwL/y445fEzX7El2JWbkvokqi2Up/Tfx91/KU2gkg7yyuynm9
         cFRA==
X-Gm-Message-State: AOJu0Yz+9+D/KPsrK5P0PIV+P9MpnB7atG5p8dVX40Dsd583FHWPCFzf
	HiCLWagtIqamqJDSMPfPRgfVUgGIGiqdqmxcuvgezQ==
X-Google-Smtp-Source: AGHT+IE2moXgpoqFI5sFJ9IfH8ebeouITzyauQMCBYNuzUii8OjS7uo1YUkWN907Jm7R98eoIePdU3lBP0EVwvaxY70=
X-Received: by 2002:a25:81c5:0:b0:ba8:2e05:3e9c with SMTP id
 n5-20020a2581c5000000b00ba82e053e9cmr2493744ybm.24.1692455628833; Sat, 19 Aug
 2023 07:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qXJrG-005Oey-10@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 19 Aug 2023 16:33:37 +0200
Message-ID: <CACRpkdaeds3vP4JBFTcf6zjcNZBnmaCFUF6teYaHDZoJ5ALioA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: add phylink_get_caps implementation
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alvin __ipraga <alsi@bang-olufsen.dk>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 1:11=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> The user ports use RSGMII, but we don't have that, and DT doesn't
> specify a phy interface mode, so phylib defaults to GMII. These support
> 1G, 100M and 10M with flow control. It is unknown whether asymetric
> pause is supported at all speeds.
>
> The CPU port uses MII/GMII/RGMII/REVMII by hardware pin strapping,
> and support speeds specific to each, with full duplex only supported
> in some modes. Flow control may be supported again by hardware pin
> strapping, and theoretically is readable through a register but no
> information is given in the datasheet for that.
>
> So, we do a best efforts - and be lenient.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Looks good to me!
Also tested it with an additional patch in the earlier version.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

