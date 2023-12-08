Return-Path: <netdev+bounces-55469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC380AF97
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482DEB20AE4
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4859166;
	Fri,  8 Dec 2023 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoRPaflp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AA910E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:19:40 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso2610838276.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702073979; x=1702678779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dpzaxYa9/xVydZN8tEZRHvtPge98K9VjwqfEOdNyRk=;
        b=SoRPaflpLSYI7IAse9VzzYtmcH23xrx7aeUa5AFYlboeE51H6PmzaXDJLuBQeVJzfs
         OohAj5iOSy1SB7coW5qkodK593tbdGgltEH8fyeG2JJ/I0CQqPbzHK7lJ09HEgr9vF3N
         42K1qg46SO6qCIqgdrubn7Tb62cwehF4QPEAerpCPinTIlDVtSUHYrpkVytqOzreeb/k
         dOdgggEexvRtP+p+V0tpXbW0CFJaWBoQFlAxM/oRfZEO955MhgN4JEOWNhSlbayc49iT
         +/O9CwzzjflX4gDVmnKCfLqIZb4JIwD7e9CS09JIzFkcz1dt0S6cJxgyc9QykAeMArnx
         Fdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073979; x=1702678779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dpzaxYa9/xVydZN8tEZRHvtPge98K9VjwqfEOdNyRk=;
        b=KDEXyepnrUwnHWBAtMIRPiRg/vW8wxkKXbJMW/r4KFs/VeXVf6+n18jFrfgN4H9j7h
         Aliogvx8hzSnhqdmDPnk1Q1aRUG5XCnIUqSpHhoQWEhp+mrYKw0Db0kidVpfGgrVVtjz
         j3XBhuNgEqv0sSVni6JIqH8yqHf26Ci+E9ENoLKqA8TDM13LIbOBFwxllxQGHQIX6k1E
         w94aO2kTHCtFO8OcjAhQTkkLSW79+JBerc2V9xP7/QdKnbHYJm4BPXw8a56QKlQ6e1Yx
         +eVpsrMtASFswDs+vGC/ZpMUFbXIaJRVixHqnRlAty9oVOYuQszjeoaVoGv003zv0QYT
         NHxA==
X-Gm-Message-State: AOJu0YwbvfdSqk+ybdntjcuPw3JzyFsMXLEVZAVoLzzz4Ad4Vh5SKEaE
	eLrVRZqYZrQ4NV5I+P2AxYoAa9vw9ojB+AGfxI+p6A==
X-Google-Smtp-Source: AGHT+IGXKHZJ5sb0CUPN56uA6EcI3vMlqo0NF9w88Fj16/xmx+q4TaRyqNlvuYp5WzlOaDVHJmjj6O8vY1xmL6Wt4b8=
X-Received: by 2002:a25:bed2:0:b0:da0:81da:e4ed with SMTP id
 k18-20020a25bed2000000b00da081dae4edmr637142ybm.40.1702073979499; Fri, 08 Dec
 2023 14:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com> <20231208193518.2018114-3-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-3-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Dec 2023 23:19:28 +0100
Message-ID: <CACRpkdY3863-a5GgG4W_=KTBYh3RPPb75u-JuRtrN=DQ=k-J9w@mail.gmail.com>
Subject: Re: [PATCH net 2/4] docs: net: dsa: update platform_data documentation
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Madhuri Sripada <madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, 
	Tobias Waldekranz <tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:36=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:

> We were documenting a bunch of stuff which was removed in commit
> 93e86b3bc842 ("net: dsa: Remove legacy probing support"). There's some
> further cleanup to do in struct dsa_chip_data, so rather than describing
> every possible field (when maybe we should be switching to kerneldoc
> format), just say what's important about it.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
(...)
> +  ``ds->dev->platform_data`` pointer at ``dsa_register_switch()`` time. =
It is
> +  populated by board-specific code. The hardware switch driver may also =
have

I tend to avoid talking about "board-specific" since that has an embedded
tone to it, and rather say "system-specific". But DSA switches are certainl=
y
in 99% of the cases embedded so it's definitely no big deal.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

