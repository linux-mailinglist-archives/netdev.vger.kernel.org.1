Return-Path: <netdev+bounces-43247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416A7D1DC1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F7C2822A7
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136F15E9C;
	Sat, 21 Oct 2023 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bX8TV3Rl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18D137E
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 15:02:16 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDDA6
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 08:02:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c496c114so118115ad.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697900531; x=1698505331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v632NyyyfUP7uNKA1gCSbOgDbWOBBu1PYAKFjKlYN5A=;
        b=bX8TV3Rl+A5C2DLIwB/tLM+WmFc1DYz4fpr81UK3b4wKIXG4RIxbB8l8EfEB/OJAvU
         3Zm9SVugEYZF60FQEGz4wO1/31igGhLB3aUdhzaw+5Wgqm1H4kKp0d7QOylao9LbwCI/
         FFzzjRRNCSkj7XzHJ1/D3reXvlOWQvqR18Kcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900531; x=1698505331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v632NyyyfUP7uNKA1gCSbOgDbWOBBu1PYAKFjKlYN5A=;
        b=ggDhrqWXHwJsxEpTUSx7rxq7VRCMczi87h/w5KKIUXHpbgSVeazHHqgEiiGBuE7Uxp
         uNSWZiuoZ3qEPBoOJKwJjcqqpxo6Qp1sG3NcxENUR35+6npcsesy6ZFemQhZhZbFBXDV
         82cRl3WMWxuApOTxv2OxkFb13YH3MdwofAy8RrZfgt9D9QijN8aWaooXcwscrA8gV5dl
         CdpZR4oxX+nhpZVhGIA9nRi1d9nhlAxPk4a3znsDu+oxvUQlYOmTvxQoSS9/acVwYtKV
         X1GuLiQaaaMpuXsuLNdPx/64KLWZMGmHPypcq1u2eUqHAJPC1VsHsb1YxAIImbhH6iLr
         2Yvg==
X-Gm-Message-State: AOJu0Yz0cQXN5V4cfAFB4k3AJYOxwsfjeKrezKc5B9esHuKo1bgshG8z
	oPz4TGfXzWtwoAkHbpjAoV6ib/3Yrl/CtzK+VZEAqQ==
X-Google-Smtp-Source: AGHT+IGQEYY5fHfxWtQQzUCGwA0rZbif4bEKqr/BunucKyMALe/6gqi3yossh11tQ+2fyZqnOiYONpjQkLnUt3FtrUs=
X-Received: by 2002:a17:902:eb8f:b0:1b8:9551:de55 with SMTP id
 q15-20020a170902eb8f00b001b89551de55mr385745plg.26.1697900530966; Sat, 21 Oct
 2023 08:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
In-Reply-To: <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
From: Grant Grundler <grundler@chromium.org>
Date: Sat, 21 Oct 2023 08:01:59 -0700
Message-ID: <CANEJEGsFOy9urtoBtDQ8LEJo3uVROg27KKwaKb5fCPYO_nTfaA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] r8152: Release firmware if we have an error in probe
To: Douglas Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>, Edward Hill <ecgh@chromium.org>, 
	Laura Nao <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org, 
	Grant Grundler <grundler@chromium.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Prashant Malani <pmalani@chromium.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> The error handling in rtl8152_probe() is missing a call to release
> firmware. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().
>
> Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Release firmware if we have an error in probe") new for v5.
>
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index d10b0886b652..656fe90734fc 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9786,6 +9786,7 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>         cancel_delayed_work_sync(&tp->hw_phy_work);
>         if (tp->rtl_ops.unload)
>                 tp->rtl_ops.unload(tp);
> +       rtl8152_release_firmware(tp);
>         usb_set_intfdata(intf, NULL);
>  out:
>         free_netdev(netdev);
> --
> 2.42.0.758.gaed0368e0e-goog
>

