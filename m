Return-Path: <netdev+bounces-45258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EB7DBBD4
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE26C1C209AD
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34B10783;
	Mon, 30 Oct 2023 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wq/n0IPK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135C182AB
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:32:23 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD99F
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:32:22 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7e5dc8573so41439447b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698676342; x=1699281142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q3e+9Dye+AbU45RL0bBxhWInqMv+UlfyAdFx9gSTY4=;
        b=wq/n0IPKN1XEu8WUz0E95SxTT/HjjRfSP13HJeL5dm9Tmj/1kSfIvfd4ObgBkaRYgD
         dxXCaNL05ZszXRxTup4OL+ZC7EITkb+k7Bvif07LKQIH4lANBCFRt7gWB26KlimwLoPd
         5wCU42syIAU7IKoXHfrRDGMbR8+HgYICHf4oSC0ZFKeLKIpN3lzvRahpfttfCIkbFwJG
         8+uzdwtZkGjoskZGR37wYTeVXyUTSH83DZz30udwYvDlsGPSgaY6VWzB66UBqxm6uWa+
         YPP4wslu9qr9Roy+TJltDjfdf+VIy6T3X2dGYgSY7yfaHdYNlnOEqVtenmPy1EHVTdMT
         AiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676342; x=1699281142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q3e+9Dye+AbU45RL0bBxhWInqMv+UlfyAdFx9gSTY4=;
        b=u2cTkuPXmcoB6rdy8XQGeO+TSX18wK4ohauj+/IijAnXpBySLAJ79tKB4/QbHH9HTQ
         cXxeEtTQdykG4LW1t5vKTJ1JyKfI5jXFCYCZwX8v1eifrzLwC4ETeNItH/upL78TYX68
         Z7hYuS0ttoyfh/0k2F8W9r99hmJaf9yP67us6/uS3h16+kyJlPbeTqRh9cCryBO5jPwI
         9CuvrPMqMC0zxWCmALb8BjtY66JlmLY0N0Yln0HMK62UiSILpBhiOKjokcfpmHOdwVet
         khWSgNbUqWZ+3G5KoAPy9d6W55qXJzbQxyqiK/r9xJUBpL83NgozZpEEhz6+k9pSq3zJ
         I9cg==
X-Gm-Message-State: AOJu0Yx9HDAEDt4nL8/IO+DQsKgQCDThcjqEIYVuw/i5k0iCIGsLKIOB
	7gK630+EnRp2J4eyl3vb8PIP10AGQ5AsYELbWjCQ3w==
X-Google-Smtp-Source: AGHT+IGGUFqvROhVczCBsZ3DEHkZmAKcY5HklYbQOIM2nTvmWRXWxYgD2BD1eG3iwGE3XPhZanE0YzIvw4FuzOIO+2A=
X-Received: by 2002:a81:ac46:0:b0:5a7:c8a9:79e8 with SMTP id
 z6-20020a81ac46000000b005a7c8a979e8mr9600015ywj.4.1698676341819; Mon, 30 Oct
 2023 07:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com> <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
 <20231030125127.xccqwct3jgg6o2rl@skbuf>
In-Reply-To: <20231030125127.xccqwct3jgg6o2rl@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Oct 2023 15:32:10 +0100
Message-ID: <CACRpkdbx2FGNPHa01O842MxH-LNfnKxRJN16a8oNm7zd1b65wg@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>, DENG Qingfang <dqfext@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deng,

do you have some comments on the below, pertaining to
commit 9eb8bc593a5eed167dac2029abef343854c5ba75
"net: dsa: tag_rtl4_a: fix egress tags"?

I plan to test without the ZLEN padding and see what happens.
IIRC it wasn't working without that, but I may just misremember
the whole thing so let's rehash this.

On Mon, Oct 30, 2023 at 1:51=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> What you are missing is that the existing padding done by rtl4a_tag_xmit(=
)
> shouldn't be normally needed except for exceptional cases.
>
> Socket buffers smaller than ETH_ZLEN can be passed to any network
> device, and it is expected that either the driver or the hardware pads
> up to ETH_ZLEN automatically. Thus, the conduit driver should already
> know that it needs to pad packets to ETH_ZLEN.
>
> The exceptional cases are:
> - This is a tail tag (not the case here), which by definition needs to
>   be located at the end of the skb. If you first put the tag then let
>   the conduit interface pad, then the tail tag is no longer at the tail.
>   So in that case, DSA pads first in generic code - dsa_user_xmit().
> - The switch must handle the case where, after stripping the DSA tag
>   from a ETH_ZLEN sized packet coming from the CPU port, it re-pads the
>   packet on user port egress. Some switches don't handle that properly,
>   and thus, we have isolated __skb_put_padto() calls within certain
>   tagging protocols which address just that case.
>
> So, what Florian was asking is whether the conduit interface is not
> doing its expected job properly. You clarified that the problem is big
> rather than small packets, but we still need an explanation for the
> existing __skb_put_padto() call, given that it seems that it was placed
> there due to a misunderstanding rather than due to an explicit need for
> an exceptional case.

Yours,
Linus Walleij

