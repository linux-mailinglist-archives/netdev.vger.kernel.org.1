Return-Path: <netdev+bounces-45944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C403F7E078F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004A31C20F55
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61020B15;
	Fri,  3 Nov 2023 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOsHlqJQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2F20B06
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:37:38 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F8CD48
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:37:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so2337954276.2
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699033053; x=1699637853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I26ulcbLDe3WhA1EkDRprUU0Tpdfp/YXuJxBOsdRtxA=;
        b=YOsHlqJQ1FEln5KFNp1zoh58k5n/XY8MQMY2p2rJa6pZ6k6RC976wqAZPcuXqmnyBD
         dwvJaYQKyf4ask4l/7+wiWnnpt5YNx1FQaiUIkaDViBW5inBR8WfGa6e24DglIFMi7WY
         rgqpfE7f8m8HPN8jR1/8JBde4YhjLKqUwOoxD1VIbwSJy/WOYV8i7dHfvYgWkMhXRNlI
         HH3BvOpRtgwlkE2qvf/AItrWGHyzjauA3AbSUG/9cr2E8BbiKj4VgdylyuU06fVcMxyX
         F937f0eR7aNV+feJ5Vn50lVKl1lhgKGh4XxTVfqjoan7iYd12KZW5R3K80JrvDUKmU/R
         JjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699033053; x=1699637853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I26ulcbLDe3WhA1EkDRprUU0Tpdfp/YXuJxBOsdRtxA=;
        b=GnCuceiPLFY6HyFpeUNKvDI12ySQ/PrtDi6iBOwYKt1m21AUznqZwEFpGYJd1eDv+Z
         4/5l9ZktpLtS6wgHSNreGvECxUCkWZi+Hx6gqhBA1DRj6XMVLXwJfHvM/ekpwV8wqnum
         RAgA6F5xfeHK8Hu4X2+f+2rJM5NPaCQ1QYbBBnCqM21/Rjkw4tK8FiGDMtolE++DHtvD
         H/FIix3ZkAnX2HVS0agXRWyp7ljCdFXycHfi0WrGArB+7/SV/goI2Qw8vbxRgLsRRa2+
         kJJH553ZOsdr99pbQ89OdXN50wZObV8FmPRsAuEhc8zUrC69fzf/vksDnatuKAVw38FU
         6oWw==
X-Gm-Message-State: AOJu0YxHgrVImcGWV3pNRup0d0kJZ0r8XiPwga+pYAAQFsrQ+HxC5ONx
	ZpB4WN/BmipMVxi4iiMK7gM5k7bBNJ33BcX2uFszaQ==
X-Google-Smtp-Source: AGHT+IGWXXJinJ5y5zN2Aw3So+rUVESn7aKDb8FgdLpSEcHVQPzl2qaZ42KtwBwLoF+T/VeJzkWlQPSkyF8LAx6Uyug=
X-Received: by 2002:a25:d445:0:b0:da0:5f41:2e67 with SMTP id
 m66-20020a25d445000000b00da05f412e67mr21953229ybf.5.1699033053671; Fri, 03
 Nov 2023 10:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027190910.27044-1-luizluca@gmail.com> <20231027190910.27044-4-luizluca@gmail.com>
 <20231030205025.b4dryzqzuunrjils@skbuf> <CAJq09z6KV-Oz_8tt4QHKxMx1fjb_81C+XpvFRjLu5vXJHNWKOQ@mail.gmail.com>
 <CAJq09z6f3AA4t7t+FvdRg9wS9DftNbibu6pssUAPA3u4qih0rg@mail.gmail.com>
 <CACRpkdairxqm_YVshEuk_KbnZw9oH2sKiHapY_sTrgc85_+AmQ@mail.gmail.com> <20231102155521.2yo5qpugdhkjy22x@skbuf>
In-Reply-To: <20231102155521.2yo5qpugdhkjy22x@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 Nov 2023 18:37:22 +0100
Message-ID: <CACRpkda2SFMhd8+MHw6e0e2iYp21SdD7v8vw5detaWm0Qc4T_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 4:55=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:

> To be clear, something like this is what you mean, right?

Hey, it's 90% done already! :D
And we do away with all the hopeless IMPLY stuff.

> +realtek-interface-objs                 :=3D realtek-interface-common.o
> +ifdef CONFIG_NET_DSA_REALTEK_MDIO
> +realtek-interface-objs                 +=3D realtek-mdio.o
> +endif
> +ifdef CONFIG_NET_DSA_REALTEK_SMI
> +realtek-interface-objs                 +=3D realtek-smi.o
> +endif

I would try to do

realtek-interface-objs-y                :=3D realtek-interface-common.o
realtek-interface-objs-$(CONFIG_NET_DSA_REALTEK_MDIO) +=3D realtek-mdio.o
realtek-interface-objs-$(CONFIG_NET_DSA_REALTEK_SMI) +=3D realtek-smi.o
realtek-interface-objs :=3D $(realtek-interface-objs-y)

I think it's equivalent just more compact?

Other than that it looks like what I would have done myself.

Yours,
Linus Walleij

