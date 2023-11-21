Return-Path: <netdev+bounces-49533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A447F2494
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD312812F0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2452154BF;
	Tue, 21 Nov 2023 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JJyuaxJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9419D8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:24:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc209561c3so106545ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700537048; x=1701141848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDrr9bM3PHykVHLDjRjYj0TBVb7iFAC/0d9okuu8lkw=;
        b=JJyuaxJDla0W/AjZ56GX5FUTJVItRL9szlqSURr9FCJyhNCO5G6Ivb17YZKUla4ZCJ
         sXTpFOn5CXpCHX040+aEoeVqnk/DBP0ySbWPdFmG9a7W0iisV68VhJlvTZi4gocLJO9y
         4x1/QWKY+ChXF0h2Y2D4TA8oMIHOGecy3pIjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700537048; x=1701141848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDrr9bM3PHykVHLDjRjYj0TBVb7iFAC/0d9okuu8lkw=;
        b=mb3KM1qb1b/W7ZaPTAqu/B3MVNF7XgOpEggoBqLtKFGjM7gi+OfvFK510eqURl5VMU
         9TPhuyymT3CnumkWDQPBFhKv5Y4YFx8XM7uaZfjXp8txYq63ViOpIZ+/e+9teliQIVrP
         zTsuVY3LiOvS2/13MceNHPomiTpUX14QpFdrkQusbD2iGF/HwhzxOi/O3O1nCFkbPI3J
         Ml/rjE6knPYb/UObokwkG5YRr6VT0sfOoAzHyYbJlpE04h2We38nCgnbnj4rbmn5LfYa
         uEEZwhBD9ihiwKRnfuaHvTAu28Dy1dIIuMMu9rXQm1uNfxMyYP+HNE1+d2usIdeik7J8
         5HOg==
X-Gm-Message-State: AOJu0Yw5iS+42PcaHHugCHcwArCmDUvGsEgBU+czKXhDPLrBSIwnPwXp
	H21D3hWmGGoDSQ4XaYx3YxAB7xs7S4y5arTWRbPcTw==
X-Google-Smtp-Source: AGHT+IGmXwcl0iff7b82hBAcY6GbR2Jq2e8T8hci0KzfvAbitbtU8DXqguQRn9YEsaDmHmGrmFuxm09UN61yDpmQZWk=
X-Received: by 2002:a17:902:ceca:b0:1cf:669b:6176 with SMTP id
 d10-20020a170902ceca00b001cf669b6176mr286868plg.16.1700537048028; Mon, 20 Nov
 2023 19:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
From: Grant Grundler <grundler@chromium.org>
Date: Mon, 20 Nov 2023 19:23:56 -0800
Message-ID: <CANEJEGtN0cT2xWLVgi3sN5BBGm8buPFj86cTZyoUAb8tzVy6Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
To: Douglas Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>, Grant Grundler <grundler@chromium.org>, 
	Simon Horman <horms@kernel.org>, Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org, 
	Laura Nao <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:10=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> As of commit d9962b0d4202 ("r8152: Block future register access if
> register access fails") there is a race condition that can happen
> between the USB device reset thread and napi_enable() (not) getting
> called during rtl8152_open(). Specifically:
> * While rtl8152_open() is running we get a register access error
>   that's _not_ -ENODEV and queue up a USB reset.
> * rtl8152_open() exits before calling napi_enable() due to any reason
>   (including usb_submit_urb() returning an error).
>
> In that case:
> * Since the USB reset is perform in a separate thread asynchronously,
>   it can run at anytime USB device lock is not held - even before
>   rtl8152_open() has exited with an error and caused __dev_open() to
>   clear the __LINK_STATE_START bit.
> * The rtl8152_pre_reset() will notice that the netif_running() returns
>   true (since __LINK_STATE_START wasn't cleared) so it won't exit
>   early.
> * rtl8152_pre_reset() will then hang in napi_disable() because
>   napi_enable() was never called.
>
> We can fix the race by making sure that the r8152 reset routines don't
> run at the same time as we're opening the device. Specifically we need
> the reset routines in their entirety rely on the return value of
> netif_running(). The only way to reliably depend on that is for them
> to hold the rntl_lock() mutex for the duration of reset.
>
> Grabbing the rntl_lock() mutex for the duration of reset seems like a
> long time, but reset is not expected to be common and the rtnl_lock()
> mutex is already held for long durations since the core grabs it
> around the open/close calls.
>
> Fixes: d9962b0d4202 ("r8152: Block future register access if register acc=
ess fails")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

BTW, for ChromeOS systems, the outcome of hang in napi_disable() is a
"hung task" panic after 120 seconds. Fortunately, the stack trace made
it relatively easy (compared to other hung tasks I've looked at) to
unravel.

Doug gets all the credit for figuring out this solution (using rtnl_lock())=
.

cheers,
grant

> ---
>
>  drivers/net/usb/r8152.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 2c5c1e91ded6..d6edf0254599 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8397,6 +8397,8 @@ static int rtl8152_pre_reset(struct usb_interface *=
intf)
>         struct r8152 *tp =3D usb_get_intfdata(intf);
>         struct net_device *netdev;
>
> +       rtnl_lock();
> +
>         if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
>                 return 0;
>
> @@ -8428,20 +8430,17 @@ static int rtl8152_post_reset(struct usb_interfac=
e *intf)
>         struct sockaddr sa;
>
>         if (!tp || !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
> -               return 0;
> +               goto exit;
>
>         rtl_set_accessible(tp);
>
>         /* reset the MAC address in case of policy change */
> -       if (determine_ethernet_addr(tp, &sa) >=3D 0) {
> -               rtnl_lock();
> +       if (determine_ethernet_addr(tp, &sa) >=3D 0)
>                 dev_set_mac_address (tp->netdev, &sa, NULL);
> -               rtnl_unlock();
> -       }
>
>         netdev =3D tp->netdev;
>         if (!netif_running(netdev))
> -               return 0;
> +               goto exit;
>
>         set_bit(WORK_ENABLE, &tp->flags);
>         if (netif_carrier_ok(netdev)) {
> @@ -8460,6 +8459,8 @@ static int rtl8152_post_reset(struct usb_interface =
*intf)
>         if (!list_empty(&tp->rx_done))
>                 napi_schedule(&tp->napi);
>
> +exit:
> +       rtnl_unlock();
>         return 0;
>  }
>
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>

