Return-Path: <netdev+bounces-43246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A67D1DA4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 16:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505912821F4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8209D12E5C;
	Sat, 21 Oct 2023 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LbExNEax"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52A6125
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 14:52:51 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD70D71
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:52:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9b70b9671so83815ad.1
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697899965; x=1698504765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HsFB5tlx9FQRvIXi6ryYvjnX1UG/8hzi6eFKlM5SgY=;
        b=LbExNEax0RbR/RB6vlWzYAzyWLKDtTpdayRjZQ24DPrIjQHtHx2CbqIiIlDOVCuPr+
         Vop6VHLWqCvg/ECCh7yzbQAQhTDCq/EQys13IslhETuAitq9YHbASsECoM3HJmVZ82UP
         1HnLsKBprvitDk0GRp2OCI6nfnvsxIXWjpToY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899965; x=1698504765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HsFB5tlx9FQRvIXi6ryYvjnX1UG/8hzi6eFKlM5SgY=;
        b=Xk0mRXVufVc4Q53PsWcxxxTrVvV+/6uOMJ0gQTu/V0nqscc6uhigFGkC9NIuEvYWoF
         Wir94aL60POYq8IQpExppV/lNKA2VWmPCMKZPL2GBdsSXu1Xysq3TpSAf+QJaIfW8Irn
         um0B3ZVxhGYlnCaSkb7VJWEHqkIMDqDLGV5SPrEYXjoVcJr3Qp+ii9ay/O8Fyf0jn9NV
         FpUvcDpZMcORpC3T+qbYuWIGuQ/X+Htb9ljzNG/ot45oNKxl4ZFGXXWeynkoaKo9tAAv
         DU8R33mdBZoHa40b3XJr54rXqXBU2f5t0ckAEnlStfUlqxdajj4cGHTEWOVR2ksudPpK
         kRQw==
X-Gm-Message-State: AOJu0YyjddVEp8tkh3DWHR5qm7SAATt3hGiNMcWxsJ/oWRwA3rfWHEVp
	j+cFKzgSw38lZDUzASIcFxGDE6l9BK/+ed5l03twWg==
X-Google-Smtp-Source: AGHT+IHubZ+DRcpnIydaHeTMIC0WTzLW0aG0Ilm3AeFdLRSeiPMxSatpnwZZ4BjeimzRga4YfBDoS6n13h4SC3fNUAk=
X-Received: by 2002:a17:902:f70d:b0:1c9:c480:1797 with SMTP id
 h13-20020a170902f70d00b001c9c4801797mr383011plo.11.1697899964770; Sat, 21 Oct
 2023 07:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
In-Reply-To: <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
From: Grant Grundler <grundler@chromium.org>
Date: Sat, 21 Oct 2023 07:52:33 -0700
Message-ID: <CANEJEGsdm5XokPmYgMm4NXFx0eoLdYAfgx+W88jeox337cNRbg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] r8152: Cancel hw_phy_work if we have an error in probe
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
> The error handling in rtl8152_probe() is missing a call to cancel the
> hw_phy_work. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().

Sounds like there is a future opportunity for someone (not Doug) to
refactor code.

> Fixes: a028a9e003f2 ("r8152: move the settings of PHY to a work queue")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> Changes in v5:
> - ("Cancel hw_phy_work if we have an error in probe") new for v5.
>
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 201c688e3e3f..d10b0886b652 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -9783,6 +9783,7 @@ static int rtl8152_probe(struct usb_interface *intf=
,
>
>  out1:
>         tasklet_kill(&tp->tx_tl);
> +       cancel_delayed_work_sync(&tp->hw_phy_work);
>         if (tp->rtl_ops.unload)
>                 tp->rtl_ops.unload(tp);
>         usb_set_intfdata(intf, NULL);
> --
> 2.42.0.758.gaed0368e0e-goog
>

