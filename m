Return-Path: <netdev+bounces-55570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA980B692
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 22:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CA1F2101E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752E1CF9A;
	Sat,  9 Dec 2023 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrJx5BlB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB49103
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 13:49:32 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da819902678so3100153276.1
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702158572; x=1702763372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dwry9NVZtUpZ2aQWNzuUc/5vuY29TMZfbznT5sQY7vQ=;
        b=zrJx5BlBYrRl5D25z6GWC7fg0lV9w2aQzhAeHFGIoztAfa8qKncyG4of9wxJIdFdca
         eojocH8AXy4b9KnV6XHSp93pjpgg4uiT2DD4PBQVlW/XjtnpWmmF/O3c6MBTJ2B+tLPL
         PL6iA7iPd/1PJQX+9xkgAZ+HWyWplsk+aclQ70+8L4kBJ7ILvBxo/tXsl+Nqmbq7rLGX
         iBuvMzUDvzTfEooXxIBGWy9cnjMqg9ZF7r5k8BiVH4TgydR+crjWgEudObAt9lyvKLk+
         L6NxRBOu5NODAZ0FxaM/VhKmLNReyw5In1LjpjlB20F4BY9bmNOGPF6aps02/nZfQeP+
         KqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702158572; x=1702763372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dwry9NVZtUpZ2aQWNzuUc/5vuY29TMZfbznT5sQY7vQ=;
        b=O9TkwlnlCAWJPQbIrq40KXrVL8ccxVkWKD7v1srYVH7138Z68FBQLrG5O9+Ts9ltmG
         S8pndP8ARes+0JiflzlPPTY3Q/ruY8cK6oR1uB7wu9RvgN8o8cwte7qR4+5F4hwsq/ft
         6AgNrjIfFqXR6CmTvnY2QbJXSP2CVGc5vEfTupZpjxGN/iEomWWtWOs2Xj3taRgqrGOW
         Uy9tvMhwO0CT+yyQ6+sNhPu++sxo2kHUwjcidDDuSQYgvePqe2GkhCrGcFuC6/nWunKz
         wWyrGhvJr7mOjW0LmueQiv9iJvLH5524y9FX8ib3Qs15/JS2qVsPhyLdlUJboe9nK499
         E4Lg==
X-Gm-Message-State: AOJu0YxwGbmSVwiHWgKSegPymwCnbVBB2iv1+vrmYZ+2v0/oQJIh81zY
	ITPfLjzqPr7y0kazF2RXrPKVo+dAUsOnyA197L3Nbg==
X-Google-Smtp-Source: AGHT+IHBYYmrmHv7AWxMVVqg9N46L6k3xbzk7soK/PzMBh6yRkdGjQU6hikNxyLIw7NOk82+NrhM1TNritkh+CqW0CM=
X-Received: by 2002:a05:6902:1b87:b0:db9:92a6:4310 with SMTP id
 ei7-20020a0569021b8700b00db992a64310mr1734828ybb.10.1702158571763; Sat, 09
 Dec 2023 13:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com> <f4e08518-290d-492f-89ea-31fea9974abe@gmail.com>
 <20231209012202.tiawvab6qkbxosou@skbuf>
In-Reply-To: <20231209012202.tiawvab6qkbxosou@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 9 Dec 2023 22:49:19 +0100
Message-ID: <CACRpkdZ0LTg2TFD3_gDHPnM60zkzRycXiCFsD6S760FjLmbBqg@mail.gmail.com>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus documentation
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?B?QWx2aW4g4pS8w6FpcHJhZ2E=?= <alsi@bang-olufsen.dk>, 
	Madhuri Sripada <madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, 
	Tobias Waldekranz <tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 2:22=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:

> How about replacing it with this?
>
> Typically, the user MDIO bus accesses internal PHYs indirectly, by
> reading and writing to the MDIO controller registers located in the
> switch address space. Sometimes, especially if the switch is controlled
> over MDIO by the host, its internal PHYs may also be accessible on the
> same MDIO bus as the switch IP, but at a different MDIO address. In that
> case, a direct access method for the internal PHYs is to implement the
> MDIO access operations as diversions towards the parent MDIO bus of the
> switch, at different MDIO addresses.
>
> Conceivably, the direct access method could be extended to also target
> external PHYs situated on the same MDIO bus as the switch, or on a
> different MDIO bus entirely, referenced through ``platform_data``.

This is clear and simple to understand, go with it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

