Return-Path: <netdev+bounces-55471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD2680AF9C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046741F211CC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904258AD8;
	Fri,  8 Dec 2023 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuQsde6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3A1710
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:22:36 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da819902678so2573739276.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702074156; x=1702678956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1oyoKhZ3pN+VVFTQr/HUcnmwBWIE4Yw79fKK2FVDGI=;
        b=EuQsde6kr7fiHZD0p1drOQIlOuR7c1OXOfbIWfQRz7Qp2YQchRKtlJrpGAv0hRWsbA
         DExn2L09ZOKK/dqQFCXBW9eJa2HZ1vp+NamneTUzYJYD//df8AKzJWTXwS73bYZj2iMh
         ucBJtH1TOw9kfUKHIcSrXyFilJZSlXLgBYLyRtJFlptoLhORHSvrjlz1REcubA2f+rIo
         kwUdVoQZDqSqsqCTjsdckwlWCjpgqs+nek+GMvAeGKyrT8ZByeNqf5BoMUJ/tEGiqoyV
         QA6e0rJk5WVB27QS1btFBuumKasQUq50+R8ocUd9LxADBjgbmGGCyoBsF8tGFhksBZvz
         1/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074156; x=1702678956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1oyoKhZ3pN+VVFTQr/HUcnmwBWIE4Yw79fKK2FVDGI=;
        b=T/tBY2pC+36UsjsvJ1gR5zyS5ZeSBHv0+w+Gf8KwoqM61nMs70KqTqf4cOuq2fPi2S
         MwXHYMN/rMrzv8QC33p9RmfMybZXs8QCqzrsDhIHtRW8vNJ463l8k69+QLwXtatVBBQm
         1BsU6nnErevP+BblAk4q+/ezAlAEnoTdFf5lUpVn9yzRS2zKSDok6JpO5UEjkmk1K7Vw
         q+o3bfs+Y9dLizKZOjGpoQuTdSetPSMVF4XjxBVp4s1/WbhN9OsFWjqorC5SUVI2qrBi
         Ho5xKStkYZbHMQFZG6mDxP2ihF2rvWlMTx2dAgxI8Z2fq+1g9o3lH1S/rN9dVyxzFUNa
         G8xg==
X-Gm-Message-State: AOJu0YyccHCBhpVoghBrjXamqNln/Ld09rbXLfd3R5OVWSCk1O/xxOoy
	W/74aqL+6K0SzBNRBA3hw0dC3aS/polcBeud/zAGAg==
X-Google-Smtp-Source: AGHT+IEw3jNO7y3zxv4w9ZJqqIRLkOJj7gF9JNxULwxuy9GzSCsBLiIajKZ7dLnHneIt+VXanDvOvfrG6yMZB/dYXlk=
X-Received: by 2002:a81:4fc1:0:b0:5d7:3748:9a1e with SMTP id
 d184-20020a814fc1000000b005d737489a1emr699879ywb.4.1702074156089; Fri, 08 Dec
 2023 14:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com> <20231208193518.2018114-4-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-4-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Dec 2023 23:22:25 +0100
Message-ID: <CACRpkdbsejk=ZxCk0_2cW7ZTvxxm-mosDmS_wj4pYNX90kxRGA@mail.gmail.com>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus documentation
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

> There are people who are trying to push the ds->user_mii_bus feature
> past its sell-by date. I think part of the problem is the fact that the
> documentation presents it as this great functionality.
>
> Adapt it to 2023, where we have phy-handle to render it useless, at
> least with OF.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

