Return-Path: <netdev+bounces-53204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3A8019EF
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC01F2112C
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898B612C;
	Sat,  2 Dec 2023 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtdFlrut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF158D48
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 18:14:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfd76c5f03so72415ad.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 18:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701483284; x=1702088084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad+Vuli4r0v/oI1SJRzXP2ROeHQLNvp0j2+cttkMcqQ=;
        b=FtdFlruttw192Q/zCdROSDKzg0Dq8LkYWkvPPwNeBvg58Dcv7FfDZEpBTS5lqiEZoX
         yXZEWiGnIpXEfu3dfaQWSiHAGfjyES1UnxdVuIS05JxY+y/PEZWreEkRod161fnwE1dR
         o/viSPUtsXRLabTzw2BeRy1k+XQG/4udu54mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701483284; x=1702088084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad+Vuli4r0v/oI1SJRzXP2ROeHQLNvp0j2+cttkMcqQ=;
        b=rp275EGtqpQtqm3EnXlb5emPlDxYlEnpN5hV2TgYHCtZd6meG7dzu3tQOOqXqpFoA6
         GxEypXm9n0dEiYk5NnycQWZgTJDgH/bjlsHoZwfdht+o2y+tE9VfyA46EDz1VtGf5Waz
         pW8z1z0HweeXdhmlxroDuGK4pVTF4NsjFz9zp5W8cF0daalvikQJkI3zwn1L8owkFrOT
         p4TOamy2vVFP6XO7GhVhs8zbquK1h34ZlX7IA3Zi+n1SpCo2U/2y0KFmLGrdEEGTDqKU
         7fwn4CUDrO+QTXuWEVhXznwjLxwDTUBH79wubKQXsur1r/Fqdg1SbGKaToU7OtTZjNbk
         Zu+w==
X-Gm-Message-State: AOJu0YyyM5F9akU9UjHZ+18UL/Iy9RcMRjPitzQHB93s37Rmkw30B70S
	l2s56RoQ4cyhDfQjh0B1zKPXH3gDwuB5s3oIIA6JXA==
X-Google-Smtp-Source: AGHT+IEKqrjLQGf+i8EsRzjviHVepWE5Uj0zYxDLLxLkaXMlqS9mdTsc6E+b/+JqSoxPrT76bM7ZX7LyQ7abgOoFHik=
X-Received: by 2002:a17:903:25d5:b0:1c9:e48c:726d with SMTP id
 jc21-20020a17090325d500b001c9e48c726dmr371666plb.4.1701483281482; Fri, 01 Dec
 2023 18:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201183113.343256-1-dianders@chromium.org> <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
In-Reply-To: <20231201102946.v2.1.I7ea0dd55ee2acdb48b0e6d28c1a704ab2c29206f@changeid>
From: Grant Grundler <grundler@chromium.org>
Date: Fri, 1 Dec 2023 18:14:29 -0800
Message-ID: <CANEJEGu2fe6MEFxd3cofeP1QQU=7kLW7EixxJ3CQmsrzsPjWPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: core: Don't force USB generic_subclass
 drivers to define probe()
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grant Grundler <grundler@chromium.org>, Hayes Wang <hayeswang@realtek.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:31=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> There's no real reason that subclassed USB drivers _need_ to define
> probe() since they might want to subclass for some other reason. Make
> it optional to define probe() if we're a generic_subclass.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

Thanks for pursuing this Doug!

cheers,
grant

> ---
>
> Changes in v2:
> - ("Don't force USB generic_subclass drivers to define ...") new for v2.
>
>  drivers/usb/core/driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f58a0299fb3b..1dc0c0413043 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -290,7 +290,10 @@ static int usb_probe_device(struct device *dev)
>          * specialised device drivers prior to setting the
>          * use_generic_driver bit.
>          */
> -       error =3D udriver->probe(udev);
> +       if (udriver->probe)
> +               error =3D udriver->probe(udev);
> +       else if (!udriver->generic_subclass)
> +               error =3D -EINVAL;
>         if (error =3D=3D -ENODEV && udriver !=3D &usb_generic_driver &&
>             (udriver->id_table || udriver->match)) {
>                 udev->use_generic_driver =3D 1;
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

