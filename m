Return-Path: <netdev+bounces-43245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D97D1D97
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1DA1C20A38
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB212E46;
	Sat, 21 Oct 2023 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUvf0iY7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541112E45
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 14:50:35 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEBD52
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:50:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c145bb5bso85665ad.1
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697899828; x=1698504628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RTaQFru2BXnNI5/XK38SzM40CR4IpRF3a3oTCzLuEk=;
        b=FUvf0iY7Lm1OZCXXOiea3f+p2TKB6pFEpwhl8JB6xN9bObDQeOO0aLzQRqkMy8Xtth
         LmApkL7NTa0uScyPdoJxCwEYtFEPXj7rKR+ntf87QdDIEtrMvP8ymOAvt4/ispMEhGiK
         37uC0W6F1XYuz7aKdMGuOTmzUinDCeyJdIwFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899828; x=1698504628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RTaQFru2BXnNI5/XK38SzM40CR4IpRF3a3oTCzLuEk=;
        b=P4zx48HQKNiy+ePsCm5RUK6/beHOjSHD0Wl5bIDsrJhaFIK/HQ1nEbdL82yWFC1Slr
         o+KuCe+YR7C6BVZWQ6OI/kBB5F2DIgA2yfRoDsH9Mo2cmEORlDDO8g9tFOj2XGd3PtIl
         +oGE8+H90bBCnsjqg7d+EaCiLdBchD3mt64d9e6NSLZaBSbBN4uqrOZVy+8qT+n+Ugv2
         R4DuK2ngU69+26VjYtWxBrxqpHxENdgjgm+gxjsDd958IPYwoz1Ey1oNmLsE/dCGiYFX
         gbfxId/sGX89LbzNRqB8wc8FQGzNv81j3jN81m46KQf3xxBJ+DJ3jaWWKnMFuIbP+550
         nY0g==
X-Gm-Message-State: AOJu0YxdMCg2WTbTPbUEOImvEE+dDgDmu+PnmrIOzDv2dENqvnOBWWeD
	US4XvUlCQak6bZlQ+a/XlQVTNBsntgLp9FAF+PHslw==
X-Google-Smtp-Source: AGHT+IEX2WZAFC6EQRssPNVjVrlfo/Qdd0uJDbniOHsAZE0tEm5hboCT3HseYvSt42TNkzMA8u8aBr5Go1qR3mLjbic=
X-Received: by 2002:a17:903:13c7:b0:1bb:2c7b:6d67 with SMTP id
 kd7-20020a17090313c700b001bb2c7b6d67mr388698plb.11.1697899828346; Sat, 21 Oct
 2023 07:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.2.Ica8e16a84695e787d55e54e291fbf8a28e7f2f7b@changeid>
In-Reply-To: <20231020140655.v5.2.Ica8e16a84695e787d55e54e291fbf8a28e7f2f7b@changeid>
From: Grant Grundler <grundler@chromium.org>
Date: Sat, 21 Oct 2023 07:50:17 -0700
Message-ID: <CANEJEGtmFWRkaxzqCXZQC4yfwnYtAsMFHEOU8+SMOFdHqLT+3A@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] r8152: Run the unload routine if we have errors
 during probe
To: Douglas Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>, Edward Hill <ecgh@chromium.org>, 
	Laura Nao <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org, 
	Grant Grundler <grundler@chromium.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The rtl8152_probe() function lacks a call to the chip-specific
> unload() routine when it sees an error in probe. Add it in to match
> the cleanup code in rtl8152_disconnect().
>
> Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Run the unload routine if we have errors during probe") new for v5.
>
>  drivers/net/usb/r8152.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 482957beae66..201c688e3e3f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9783,6 +9783,8 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>
>  out1:
>         tasklet_kill(&tp->tx_tl);
> +       if (tp->rtl_ops.unload)
> +               tp->rtl_ops.unload(tp);
>         usb_set_intfdata(intf, NULL);
>  out:
>         free_netdev(netdev);
> --
> 2.42.0.758.gaed0368e0e-goog
>

