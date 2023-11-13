Return-Path: <netdev+bounces-47296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2247E97D6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47027B2075D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932614276;
	Mon, 13 Nov 2023 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4ibRiTA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBF1172A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:35:38 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB8C7
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:35:37 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a82f176860so47853937b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699864536; x=1700469336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVl+zKz0UrtVfsUg3gIyCyukaH8Dc/0aEO2Bh+erPa0=;
        b=D4ibRiTA4WLHE/oiQ4CQpXKfTKONl8P+aG+ubkaI9vjYnCHG3hHmyuDOSBE3tRdNxJ
         Ds7lMVnYsF2PfR3d0wDcf+NDMWtHsJNjSPub+ykysJ/++gqF1eFBw3N6sJ/XqZIrOZe1
         iY9wGExp4idOicSOpaT7aeFOnRTpSTQo1CpXwKuVj9T0siAXB1BJ3mWCItbmNC7wSGmu
         HCeGZQ+Q5FkP0z7FpwdMva//OisYKpSDSVQb29jrHvpGXRL6GMhynMFuySMs+CA6YU5Q
         HIW3/drIXIKYkeArMK+2iIomv1LBeaAlTpds6jz24xkLWIcS9MXQZTH15aixVfHkm7k+
         tvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699864536; x=1700469336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVl+zKz0UrtVfsUg3gIyCyukaH8Dc/0aEO2Bh+erPa0=;
        b=qBYjqfcrGq4JyEmA2dteBT/4rO9hdltPgkD/cff327V8R+es5wEAP6ItHFd1mxZA8i
         e1Q5CS2f/7WKz9h/CFZGi2v5FCKwvg8dLEOnCu+ASmrQIRfoUrsUdPcS/tUeYQqwuXTL
         5Vo7TkJV1Bsp1/ZGRD/BhATboOhsXqYFuSKzVhu2A0aKekRVKoWeb7dCZYI5gABsy+69
         lVSB7GC/6Twx+xpaZPv9iqDUQ/n+x0r0bQk6qibASUWBUQOAMU3IRU3mQDj9q0HxHJPY
         ATd32W0ZoV3V9iEfkPNifs3I4JAqNiJWZbk2cTgtFkKQOn8jRtSaiyMepphe+nNa9xHM
         2mEg==
X-Gm-Message-State: AOJu0YzvP43KGe9M1Pvd6tp74HByoPQL/NvgCA9ssDvI+7r6i4BC7SSa
	jWgK9lpj7gqrjyN9NQQw26DfFpVj7G5CUhx/GAwn+g==
X-Google-Smtp-Source: AGHT+IHHdi1cxI2jpM88VtVdztpTncPM/4/MRuD2kAsxf41/iWtxCdx8E4m9Pr+UzT75SYuBFLK2FwvEed3eK5qyf4k=
X-Received: by 2002:a25:5883:0:b0:da0:3c0f:fe5b with SMTP id
 m125-20020a255883000000b00da03c0ffe5bmr4492577ybb.64.1699864536546; Mon, 13
 Nov 2023 00:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111215647.4966-1-luizluca@gmail.com> <20231111215647.4966-4-luizluca@gmail.com>
In-Reply-To: <20231111215647.4966-4-luizluca@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Nov 2023 09:35:23 +0100
Message-ID: <CACRpkdZShX2d8EJheuNEVpC=Tf3oP53Khs071XFccTskfY1b1A@mail.gmail.com>
Subject: Re: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzk+dt@kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 10:57=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Some code can be shared between both interface modules (MDIO and SMI)
> and amongst variants. For now, these interface functions are shared:
>
> - realtek_common_lock
> - realtek_common_unlock
> - realtek_common_probe
> - realtek_common_remove
>
> The reset during probe was moved to the last moment before a variant
> detects the switch. This way, we avoid a reset if anything else fails.
>
> The symbols from variants used in of_match_table are now in a single
> match table in realtek-common, used by both interfaces.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

As Krzysztof explained the dev_err_probe() call already prints
ret. With that fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

