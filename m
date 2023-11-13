Return-Path: <netdev+bounces-47294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C787E97B8
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02061C204D6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670611739;
	Mon, 13 Nov 2023 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUUb0S1Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D01A59A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:31:52 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D458810EC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:31:49 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82f176860so47820537b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699864309; x=1700469109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZWJLT+FmATC6Dn3e6/yFxDq3bmMEZ1shNqxAugejZQ=;
        b=TUUb0S1ZP7bpAtrOYFWZ5H6ozSeypmjTPS3u3pt4hjP+7feMzzLK45+lz5dPcGu3Le
         y34alKr5GuBXhkoLKBw5fg0LXE4YldPA1OvjK0CSAOGVM/rbvu+plzLILj5FFtMDHinT
         vtvr3H+vhF4Fhuh4kKyYsnl0FFVBgpAit3Uljtrvch43orT0hF2VF122nzcSx0NphtXL
         VgjTciIEsIcXKQrCltOwY2qLRIRh4gDf0gY3xg6lar1puYhjfQfgdRCCYJTOh8JoMNZQ
         NpSkiQSsMSI32TwY2C+1XmBARzK+ar3w2KVczJw6Xk4pzO5MLbxlW0Fn0EWas4uAi7XK
         KVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699864309; x=1700469109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZWJLT+FmATC6Dn3e6/yFxDq3bmMEZ1shNqxAugejZQ=;
        b=ePjqAog8bTAJk+4IezMtffqZnJ1J1QP/bgpL18eXpZakv7ctbQI1iGwQlypnFDfX/Q
         T6/WP+2Oa40Yj7hEFdtA1qxJIMqteLFcJfdyzufBvqG5pV48dPtTn21GoXtfeQFYHZ13
         D+1F16kZheq6ojmNqFUTa1E7P7zNBHJyDjDD5TomTXWsqRxiwpB6MoHAZqDyVGmN4ssB
         6l2fVSjZ4//TOnil0Xgi6MRLbB5h19jrnqvW9aVUhfBETAoeERskgKbFaBHHDjoLvoXO
         G93EBhHQtlHoZlnG+mjJHdUdDKwt0YKVNQW3IGBIF5UUeVqie/TsPi+0Glpzc24+aTu3
         3gXw==
X-Gm-Message-State: AOJu0Ywh0yFXg78S4YPrn/S4SVeP5EmBoJYWK0G5C4EbLhGRHchkDJDN
	gw4bMkaM3cJicrPqlkQFyTEj8IYD2XtcJtL9FJXwZA==
X-Google-Smtp-Source: AGHT+IG6qna+ij3rHcycFQVFjnQdjyYqM/eVCXJO5DVLm1KRTfujo8Eu/0aNWVNyRCqnx7KfnxU1iXt/wpNaD4TDMC8=
X-Received: by 2002:a81:5342:0:b0:5a1:e4bf:ee5a with SMTP id
 h63-20020a815342000000b005a1e4bfee5amr6053863ywb.41.1699864309046; Mon, 13
 Nov 2023 00:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-2-luizluca@gmail.com>
In-Reply-To: <20231111215647.4966-2-luizluca@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Nov 2023 09:31:37 +0100
Message-ID: <CACRpkdaUN4AVDJ_zTyxguiArrEd5w6UocZqQWTtfh42PE0ciog@mail.gmail.com>
Subject: Re: [RFC net-next 1/5] dt-bindings: net: dsa: realtek: reset-gpios is
 not required
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 10:57=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The 'reset-gpios' should not be mandatory. although they might be
> required for some devices if the switch reset was left asserted by a
> previous driver, such as the bootloader.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Cc: devicetree@vger.kernel.org
> Acked-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

