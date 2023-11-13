Return-Path: <netdev+bounces-47295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8687E97C0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC31C20321
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752B171D8;
	Mon, 13 Nov 2023 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD2DceTf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D915AE3
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:32:13 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31F10FF
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:32:10 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c08c47c055so26077837b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699864330; x=1700469130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5RhQuqUMzfDx7JDb+rvZDUKhjMs57hmakWUyLzhVB0=;
        b=aD2DceTfirlKCdZsENDFV6jt1H0sEqP29XGB4VQTebLGj+bJ+xkBscVtbYG9YFZCS0
         7kxJ2u1pBERZczyI2wzKHbYcNy7KHGZJ/1NoqCM9Ra6X8YwU0NbJGmO2mZg/4Mgn5l69
         DLDXd49YZxi8F2ECJsjCKzbZYyPyaa2IBXQrcGaX/SVZN9u8OYKacBh9ZuLQyJG1eh8y
         Utuc4/CJPJDIiWGLwbnec37/Or8w3iL+Js2rmjGZkurHjp2ja6T1BteEZct/ZHHWtV/5
         hn37Zdjx8hjPwqVQuNXJAPf92cPuw5iyxKX5fFyd1SprDkihdwrG4eiSma982Dz1GSuu
         vNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699864330; x=1700469130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5RhQuqUMzfDx7JDb+rvZDUKhjMs57hmakWUyLzhVB0=;
        b=kp+IcPbkG7pt0ThpjwXUGH1ZERKwWRmW/di/wz94aX3O93YEFbY1vKZwSF86/h4uq4
         a5nw1mmb1k3kFYLquKu2DbAHz94s/3aEbJ2FhgmUFXPccOfwh4xp7e4KvPBG/UXNmVlF
         GKr99cyRh076LIUI9tjP8DgjbfrSTE98O9S80E30NOV7IKcqs07X02jEd5lERj1JPWNp
         n+wwj+nQ6askcBGCrBXccUZKqU7SIw4F0pkN+pfx1z/92uap/jgMFyAnkoj2iMQgLgvT
         MVFxKzq1riEfcMPc0KbZAMESOxBd6sLheHHkkFdQbtLRwBFpUDahuy1PW49mQ/C7BSMm
         JbZA==
X-Gm-Message-State: AOJu0YyFnZZEpolBKx+4ZwfBRhDt6XQEAINy73AiH8z/cfRuQLJx2tfR
	JKgghFnE3/plfavhvrudro39hYa+yVrs29HkKtdZICD6fj4hUqP6lGk=
X-Google-Smtp-Source: AGHT+IFoOMPln2PbxNGJR4jftpO3cO7ILtAVxAKMv9fBem0QbXXgFc4MSP+utlwiERVh1o0wSF5x19EyD282k1ysA08=
X-Received: by 2002:a25:c048:0:b0:d9a:401d:f5da with SMTP id
 c69-20020a25c048000000b00d9a401df5damr4989938ybf.51.1699864329851; Mon, 13
 Nov 2023 00:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-3-luizluca@gmail.com>
In-Reply-To: <20231111215647.4966-3-luizluca@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Nov 2023 09:31:58 +0100
Message-ID: <CACRpkdZ3a2EGYe5DtHg2xO2o33vOOozU-wH-0_PZU0yrBjb41g@mail.gmail.com>
Subject: Re: [RFC net-next 2/5] dt-bindings: net: dsa: realtek: add reset controller
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 10:57=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Realtek switches can use a reset controller instead of reset-gpios.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> Acked-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

