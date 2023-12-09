Return-Path: <netdev+bounces-55534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E719580B360
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA71F2123F
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA7A10A3B;
	Sat,  9 Dec 2023 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii2ukTAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798FC10D9
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 01:08:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so3709238a12.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 01:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702112893; x=1702717693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3f87JsAhO2n3/DBQNwmnk8srQcnzeNI7BpSQms8kT8Q=;
        b=Ii2ukTArMmQTP1u4uGYKw9d8P2m/quiuuVf+woygAc1nNQd42+ANFNJUxy47V/bLkV
         NPGpkma61wDPhrPm+j/x27YInZv0m0RgXwb9gdlNgMyXufCGbRsNZnvtdAfEkTEt6PGf
         z4yZ6tY/bQLxtYckfj2P5S3fnCFcPrHn6xcIsNCUIglMhiRS9e/kSauuPSWRIgcNa41S
         VOkaQNc0qDLiRx5AwufTapWPMNWf1Ja4t/IKh1XG6yzAiR2VHDMWditvWqp1secYDxic
         MXA1Um3zgMkk21FejteO5dPhZpR1b3pTNQUVlBPdE93CYR5Qit83jvpGt0Q504qKZVOw
         iGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702112893; x=1702717693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3f87JsAhO2n3/DBQNwmnk8srQcnzeNI7BpSQms8kT8Q=;
        b=Id5AcJ4fqPLOx1ehy/ynGEVzi5e4jx8dDGxjQLl67ci/mkLyhR+mNE5P5yyX8SPuk9
         ZvwKBdb45V2kN8vygDraGrmG8/vlkqta+iR/PaY81168vnLP0fQ4ozOmaDBafvwXmUnJ
         uLy0JOPbzxVZLNQZ/zwLV7IioCvT680uNxGp9X2bTtqqyDTGDM0TNNR3+qQTXlfII67u
         7uSkkdegccez9z8Y76EamAI4+rJ6mbTDUlodkXzHexnExuj37FldiE0f57NxU2mMsIRn
         4pR4/EVIiG4XYi5xr12RgqqLiKdqUPMc5uHpIyq/Bm95R/MrvxsYgr6tKz/7MpWKqdUN
         3Kfg==
X-Gm-Message-State: AOJu0YyW3GEdFPoPJcq3sRJ7RTynMtNptXzM1w2w7966tmSBvMFHWIOO
	rxkOA8mq4OaEIAtHr/CJ8WLlpdWPgGHkuJHGxaA=
X-Google-Smtp-Source: AGHT+IHXU8fRDi+VW/OFs+0loVu37FiTxE/Qu9vffPqAeRkdUImOkte700EGhZl10A+/vKgaP+Rh4VQ9ouRXftNz9+g=
X-Received: by 2002:a17:906:46:b0:a0f:44c6:8eb5 with SMTP id
 6-20020a170906004600b00a0f44c68eb5mr580040ejg.22.1702112892672; Sat, 09 Dec
 2023 01:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207183648.2819987-1-anthony.l.nguyen@intel.com> <20231208172001.55550653@kernel.org>
In-Reply-To: <20231208172001.55550653@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 9 Dec 2023 17:07:35 +0800
Message-ID: <CAL+tcoAsC6s9DgsY+1_1R-Ut9AQz9rSzY0==774Gr9URZR9LKw@mail.gmail.com>
Subject: Re: [PATCH net-next] i40e: remove fake support of rx-frames-irq
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 9:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  7 Dec 2023 10:36:47 -0800 Tony Nguyen wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since we never support this feature for I40E driver, we don't have to
> > display the value when using 'ethtool -c eth0'.
> >
> > Before this patch applied, the rx-frames-irq is 256 which is consistent
> > with tx-frames-irq. Apparently it could mislead users.
>
[...]
> IIUC now the rx-frames-irq will be 0 / not set, so you should also:
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net=
/ethernet/intel/i40e/i40e_ethtool.c
> index a0b10230268d..611996a35943 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5786,7 +5786,7 @@ static const struct ethtool_ops i40e_ethtool_recove=
ry_mode_ops =3D {
>
>  static const struct ethtool_ops i40e_ethtool_ops =3D {
>         .supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
> -                                    ETHTOOL_COALESCE_MAX_FRAMES_IRQ |
> +                                    ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE |
>                                      ETHTOOL_COALESCE_RX_USECS_HIGH |
>                                      ETHTOOL_COALESCE_TX_USECS_HIGH,
> --

Thanks for the review, I will add this part into my V2 patch.

Jason

> pw-bot: cr
>

