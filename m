Return-Path: <netdev+bounces-56540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297CD80F4BD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F49281366
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6D7D8A5;
	Tue, 12 Dec 2023 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="Uahcjca7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD412B7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:39:27 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1faecf57bedso4297752fac.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702402767; x=1703007567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUNcmTOafhUTvYQgQCAZ2J3XidKSJdEQq/nWiWeUEgE=;
        b=Uahcjca7Pm5sO1adSdHjqXTnJtThnJjHeBLrMAimlYmIVG+2c27XbPPYX5mKWdj7cR
         G8+CliuYp+mTllA7GyLcztbWkHeufOcDajzRhMGxc/M2AyrGeIcs1NOHzUPjdygumhPM
         R2u9e82H4++WVPFS9rxxg5D9b8+7ocMoORY1UI0Bf17X8EChcUiBfjnQ2b2CLcrBdk2G
         BMCkjU5l1LEFKDmjlk3JC9IZu+T+JicfqJkv5DKdvIuUcipqV9UNYblCfeDkZc0zjWlC
         E1kKDeylDS8YfBNaK+W6S6ByxuMg7wJlJ5S0y96Ryfk+xkJ+6hxE9HvbThLnkZluZ8G7
         h85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402767; x=1703007567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUNcmTOafhUTvYQgQCAZ2J3XidKSJdEQq/nWiWeUEgE=;
        b=Y7IWhoSJGxxdghfo3d0K68UEoIF3PtR2rnaLdT7bmPv9R1VvUi+0uC5493q8TcGYTL
         CT/k5hyH3wOCauOXYOXN7ue5hxrENd6D0Svxfhtg5whqkqLOb4yUIEhslWxEQ1HdMeT9
         qbElsgKR6eTB2LXiTj36b3yN73KnByc/SCYpvZ16uSKcyf2mYyitfmntLBlM1Hi0kYS8
         Z6NUYiwHJkaSNGh7EcPOIjHWqCeZGwzcYRlcyu4QqAapHXip3aNqLA0BF7ixy2RTXUh4
         R0hOavNmxelbUhsYjYJMHvdERxQOYjYshFWpDKw970w3Gz69LxBqdfpc5CD/rGFQBYAr
         itxg==
X-Gm-Message-State: AOJu0Yz5yMEQ19LnoSDlBJTloVbHWf/LR8sSOiCml34jaOK5+zG43WAm
	cQpbo+Tzd8L4nuzjLRXbNe2+p0nX1dnr+uw4DBhqKg==
X-Google-Smtp-Source: AGHT+IH8FppDOJz1c2vNZhu2IoyiV03XlApPbOHQwSfNyieubu2559mIvdKWWArZPTLxB5xikCyyW94EFosm8JLdBec=
X-Received: by 2002:a05:6870:659e:b0:1fb:3741:4dc5 with SMTP id
 fp30-20020a056870659e00b001fb37414dc5mr8515512oab.34.1702402766687; Tue, 12
 Dec 2023 09:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212141200.62579-1-eichest@gmail.com> <20231212170704.74565969@device.home>
In-Reply-To: <20231212170704.74565969@device.home>
From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 12 Dec 2023 18:39:14 +0100
Message-ID: <CAPv3WKfY2ATjPPV=yFQNUE=dV4wpyV3d0cQNBGOuSPb+id=mvw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Stefan Eichenberger <eichest@gmail.com>, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

wt., 12 gru 2023 o 17:07 Maxime Chevallier
<maxime.chevallier@bootlin.com> napisa=C5=82(a):
>
> Hi Stefan,
>
> On Tue, 12 Dec 2023 15:12:00 +0100
> Stefan Eichenberger <eichest@gmail.com> wrote:
>
> > Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> > The description in Marvell's functional specification seems to be wrong=
.
> > To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMI=
I
> > we need to clear it. This is also how U-Boot handles it.
> >
> > Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

LGTM, as well.
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin

