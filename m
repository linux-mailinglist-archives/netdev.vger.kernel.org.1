Return-Path: <netdev+bounces-44028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87B7D5DF7
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECFD2811B8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57663AC05;
	Tue, 24 Oct 2023 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzFho1Sj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479242D607
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CA128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:17:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a98517f3so6998871e87.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698185842; x=1698790642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7wtN/7l+1yaZQ0Bd0lSjIdfaYLO4Sp410rLcCD49dg=;
        b=GzFho1Sjob2LyooO5+vLGWlP0xmROISXzCLiduDtoXTMI1iIwG2aS0IkRZbgUQxcm4
         G81+hi6q3Cc7XfMjZzQHvVrzc0641depFlvZL5979i4b/nshwhP3VI+m1KgNM3cJmrRn
         fRJV+HHQoMR91LSlJfxVV9aoS0bQxVFyBoq5d3/ILu8rYRzkAgNMgrCrPIhJgVPpw0t7
         bDR82+OfhJgkmOkpSZbQ87K+qfBF8McJWx0lUW5GjUmcDjqHzFV2kUBUlzY72OEFbhjQ
         PJAiz1EBo9bQuxJhL3FBKHHypl1/vr/AuXrPC4Hb6I3QKH0Ucbws0vwUl71z3fG6WFWD
         S1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698185842; x=1698790642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7wtN/7l+1yaZQ0Bd0lSjIdfaYLO4Sp410rLcCD49dg=;
        b=gG+w08hHWi/z4LAsOgrQrj4G/j5wz7uX0KushwYDYOtzMSwr0febk/2KCipqjp0J/w
         z7Yg2bJ2mmVEDjrPA9vamkN3ISGaCtHWl9gztC/JdJEsxmqSJ9QQQPrTdlb1Nzj6+7fh
         l/poz8oX90hwY/lPgvA+zgmdSTXg2CLJ875MNfRnIV/3w8nlDVqbVd4PM6KxYhnn2px6
         MDCRhTe1n1nkhubfgnldA/tIEOamrKm9fq+EeaztjYTs33g1UveacSNiCfys+g804bwz
         u/VDfHnth+pTSINT5kkNYgeRKdrVKdUmrXZgwvncWHLjxX3FEG3+zlR0Wcmymb3yEihr
         Mw4Q==
X-Gm-Message-State: AOJu0YzNyyMG7e0K3atzVt7kErCmKPdI9yRqXhaXlBefU17kilapKaxs
	ouRnNv9ARr1+03q0d2FbsaVxUGuBsdiP+Wm90fI=
X-Google-Smtp-Source: AGHT+IFEjOH9EgTu99CgczvXklb5aIarIqFaJi7RsBUDWtL7Xc51Nc4uIe47FEy7zWFjyQ090MTnQJkgM6oFNf50nWw=
X-Received: by 2002:a19:504a:0:b0:500:7efe:313c with SMTP id
 z10-20020a19504a000000b005007efe313cmr10070485lfj.24.1698185842004; Tue, 24
 Oct 2023 15:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024205805.19314-1-luizluca@gmail.com>
In-Reply-To: <20231024205805.19314-1-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 24 Oct 2023 19:17:10 -0300
Message-ID: <CAJq09z4_m5T+bHZR=kPrn-6u-KMxpTE0YJ=gJXOHUkpqm7ZOqg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
To: linus.walleij@linaro.org
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, vivien.didelot@gmail.com, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

> -       /* TODO: if power is software controlled, set up any regulators here */
> +#ifdef CONFIG_RESET_CONTROLLER
> +       priv->reset_ctl = devm_reset_control_get(dev, "switch");
> +       if (IS_ERR(priv->reset_ctl)) {
> +               dev_err(dev, "failed to get switch reset control\n");
> +               return PTR_ERR(priv->reset_ctl);
> +       }
> +#endif

I'm dropping this TODO as I think it means something like this reset
control, right?

Regards,

Luiz

