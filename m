Return-Path: <netdev+bounces-58909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB38189A3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1841F21EF2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1D1A73C;
	Tue, 19 Dec 2023 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMmMQ3EF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D81B292
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5cd81e76164so37894857b3.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702995597; x=1703600397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udO5JdiwtE99JnEZ5ly9pAA3TWaydCoVrlitP8BJQG4=;
        b=zMmMQ3EFRQbba6WfrsJejz0W+ryy3XLjenI7zihuzFFJJhERbxrGu+H2phVdTiM6Kq
         JDjM6ntiHQx5sM134cGXoK2drEiCEOklX0e4tzKyLqNB2ARj4QUNUdYv7/5/7R3d2tvZ
         /SxpF0OxDHdYqq3Ot+wckg7tHilm/Tftm++2mh/qELSjVH0Wqr3To9TGmnZ6zXa0dybO
         OkIudwFxgwAzcxQczrFD3yue/qmLQ5/8CEEenAwwFXJAqDDo2ZfX4ryypZUv/TQdnnTq
         rJvnw3oT7tmpkw/9OYDWxu5UBHhkIU678+y1PAeDTTo68NtewrHV07clWpu5hBgUs35X
         BWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995597; x=1703600397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udO5JdiwtE99JnEZ5ly9pAA3TWaydCoVrlitP8BJQG4=;
        b=G5J7y0/nQtJbu97jexUzo/rhbVtC2SAdZDUuHqJOK7IKoKh0k1YhgnTlZDZlu2hWWo
         0aK8zysTNCZuMDckmQ0PBx/FoPVqsm8nuSpMioFJjZTrxnuTsHN88dNQCaoiR1AEh5LE
         SOV7gIQu7i1ijWPr1nRmTJRFIjGwgjjOwSSWhgCgipGN+Djx/DA3lSC35544jRxsSp3z
         fhMRIOmGkgrMjYtaM/bUKfL4dSfJbskSWjF81b4KP6VKL7X2IVEGqgLaGoLenh6APruP
         /HYIq4OQVdohxS6yoQeq67uQ9Q8IT+AwQ5yEKhKVCMGnMcXFDC8ylb2L29AlAJU6R2HU
         IEAA==
X-Gm-Message-State: AOJu0YwQ+/76lH4VCgvcxoLMRekBum7GiNmC9S/g+SICOtFNe1SoSmRD
	hHSSu7pe0VrbAXzsC+OebSSD0iKJD95t809F3iW4Sw==
X-Google-Smtp-Source: AGHT+IHaONPPt0yp11P4xWjwUfRR430BJRxfeWYtV2bqNtIe/9eVYDMx97tuw/H4MF1jSSyV3o2q+8Nyj6JP8FiXw+Y=
X-Received: by 2002:a25:230e:0:b0:dbd:5ccd:f197 with SMTP id
 j14-20020a25230e000000b00dbd5ccdf197mr357230ybj.121.1702995596901; Tue, 19
 Dec 2023 06:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com> <20231219122034.pg2djgrosa4irubh@skbuf>
 <20231219140754.7a7a8dbd@device-28.home>
In-Reply-To: <20231219140754.7a7a8dbd@device-28.home>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Dec 2023 15:19:45 +0100
Message-ID: <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sylvain Girard <sylvain.girard@se.com>, Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:07=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:

> So it looks like an acceptable solution would be something along the
> lines of what Linus is suggesting here :
>
> https://lore.kernel.org/netdev/20231216-new-gemini-ethernet-regression-v2=
-2-64c269413dfa@linaro.org/
>
> If so, maybe it's worth adding a new helper for that check ?

Yeah it's a bit annoying when skb->protocol is not =3D=3D ethertype of buff=
er.

I can certainly add a helper such as skb_eth_raw_ethertype()
to <linux/if_ether.h> that will inspect the actual ethertype in
skb->data.

It's the most straight-forward approach.

We could also add something like bool custom_ethertype; to
struct sk_buff and set that to true if the tagger adds a custom
ethertype. But I don't know how the network developers feel about
that.

Yours,
Linus Walleij

