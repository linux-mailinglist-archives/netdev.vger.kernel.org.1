Return-Path: <netdev+bounces-54155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAFB8061E3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A1E2821EF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D33FB14;
	Tue,  5 Dec 2023 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFc4/UhR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3B196
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:43:32 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3644ca426so62375687b3.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701816212; x=1702421012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtSI3RVsMQQR7/2+elZAKcCJgIVnWTJ454GSVXMl11M=;
        b=CFc4/UhREjHsa1OWFquj1jT8qCrUfB1yffTGoDvxqrRll1bs7j0T0CjqcOD0zqcbE3
         cSse4Q5HSlT1E9T9c8YS+//f0C5FO/T/HOsEbb33nw0qXQOAeZWV3foB6clDsaRXsV4r
         84VWdDNNvnQKJLAIA6OurnRFC1lYkX23yY4qCYaOWdsJYKOV9Mew/GDjdZqiWevxVgRU
         ab+MyrxxK5JVcCMZ2r2bayBp61BQcFL6mR2J7zTnWHCcmmsM3dR/RsWre3jMI+i1TQyb
         nYsM2AvMVHEVAIu1GQQuU3LUJtYtz3PRY9bjsuwtEHC/6BlfG7riQVZwbF86UwyAQVjl
         oacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816212; x=1702421012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtSI3RVsMQQR7/2+elZAKcCJgIVnWTJ454GSVXMl11M=;
        b=bqatXwp7n2PJVfVKBDcC0sf9QZ6gC3YDPsx4Lx/WkUAg7ULAM0sko7GE2rnTDYHIwS
         NCTp60MScpK3zHVq9vGkTzYuGS+3nBYsYdbQVCtpzPiA9wcQ1+SR14V9htucpJ0IB1P1
         hiYr04J86AqsnFxmkpPgTGRI+feDG/dDl5oRIdb44EAQljHHI4G9YyYLx3UOngyZWDxo
         lfRJ0B8D1JZU7gveF4FKR3ydXDgmHncP/8PgrvPB1a4XbtEnkhNKATgFkOxr7cNP2hNr
         mX+J0GZLHbW5avWw9MnsmNJ0Lmf4vOez3/OJoK2nzYNYWeyVtBNn/n99Ydvc603nNlhi
         45tw==
X-Gm-Message-State: AOJu0Ywidf0FjFzQUV+WU/WwkKaDzMKIHEsHZIaoR9H3qGdyZomDOSOp
	/IydcfpZOgLARsWZkT9yS6H0LHgAHmGmP8qIqi0pfw==
X-Google-Smtp-Source: AGHT+IG0Sbxe2OeMoDP49Zqjj9phOqtnwOZgssc629Hv0fiAx8lYbuASp4gd5krF91atX7BoIAOHnkq5e/bFbLGU+Lw=
X-Received: by 2002:a05:690c:c02:b0:5d8:5eac:8971 with SMTP id
 cl2-20020a05690c0c0200b005d85eac8971mr3925911ywb.53.1701816211859; Tue, 05
 Dec 2023 14:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701713943.git.u.kleine-koenig@pengutronix.de> <b0488fa6181a47668e5737905ae7adc8d7cd055e.1701713943.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <b0488fa6181a47668e5737905ae7adc8d7cd055e.1701713943.git.u.kleine-koenig@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Dec 2023 23:43:19 +0100
Message-ID: <CACRpkdbszYnpuDYeUCKiMwJvV9tq8b4Yq8bmsTr7vK5g_b=Qng@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] net: wan/ixp4xx_hss: Convert to platform
 remove callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>, 
	Imre Kaloz <kaloz@openwrt.org>, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 7:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Link: https://lore.kernel.org/r/20231117095922.876489-8-u.kleine-koenig@p=
engutronix.de
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

