Return-Path: <netdev+bounces-48879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB37EFE41
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 08:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DFFB209D6
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA210F3;
	Sat, 18 Nov 2023 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNPKoSNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381F610C1
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 23:22:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso3984124e87.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 23:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700292119; x=1700896919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck4P2+ZKsmJo86GTwgisAYut3quxIggprqt+AHmxY3Q=;
        b=BNPKoSNcWHUbvE8qoFNll6YHOBwiJfNFjaZkYG2ogJICcuj8dL/62UZhA4TVgpJWQO
         4VI48CcBPuzK89sodsPR2BZ0O0IQ+ZtRLyNwMkSud6AYCWDh+0o3copqzNeNXoKoR82T
         c5++YTDmHyWgp0faxJNH7jZUK7jC/h3VNhr2WRj9wdrv6FSPqGRRqTXBfF4YgfmlFAm4
         LaEb87nzAeiCPiFzs9jXnzA6tOk63aaSOs/WEvVJGYi9kxPBrH3RfxvnropSz4RgY2hR
         cf5Xy08uzdmnQqyZPJxgCHmarwUfrbTdY6pdQ/YyHNLKkYvXeXhYpy7Rt986JT9OqiO7
         SSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700292119; x=1700896919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck4P2+ZKsmJo86GTwgisAYut3quxIggprqt+AHmxY3Q=;
        b=FnvFkKwq4FCexSlVXgcFHe3rkeNLVinGdMvpFPgyNQp/CO1ivRDYQSBYRZsMGNahIb
         elPducDJvcYJKaf2dwf2rP4FYs/pMIBwCLC3lDV9cqsRzmKU3A6VLKjMHOGKlJk0YPMo
         y1ifXsod2fe6scVel8m/Ev44OPUj961bP8sGAKiCjOYpvSKooIDBia4pkh3rISNC+mAO
         FH7A+/rBMqc74+mA3CkYyZ0PhBUrN3iqTidU4AGEoCX3y74EEc7mOWvRh78/l/0A1zmH
         egrE0y7q9e/LXZCSQGDtZHUbMV/dbpf9eHDtdxTCSH2CDfBbQQKPK59GcfZsLmHkkEb8
         unEA==
X-Gm-Message-State: AOJu0YwIo4SbLKfpMqRetiQ245sPDBBCb1Ha8FT7ANGvRUMGZju91bZb
	vHZ4163DIRNMPe+2SoDBb1T/1OcuuM3XbTHWNN2z/A==
X-Google-Smtp-Source: AGHT+IGmCsPW2DtD/iX2I0p/vAioavmL3nUdlFm9LTuiQ8hEFhSVfZynWt3wCr0Ylq+E12kfdVP2MQpjE5tjjXdAwZI=
X-Received: by 2002:a05:6512:23aa:b0:507:b15b:8b92 with SMTP id
 c42-20020a05651223aa00b00507b15b8b92mr1551640lfv.59.1700292119299; Fri, 17
 Nov 2023 23:21:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de> <20231117091655.872426-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231117091655.872426-4-u.kleine-koenig@pengutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:21:23 +0200
Message-ID: <CAC_iWj+5MskeWaqa242zFsGRrgAxMGuVPHL6kYm1DUtH_jkDTg@mail.gmail.com>
Subject: Re: [PATCH 3/7] net: ethernet: ti: cpsw-new: Don't error out in .remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Marek Majtyka <alardam@gmail.com>, 
	Gerhard Engleder <gerhard@engleder-embedded.com>, Rob Herring <robh@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Nov 2023 at 11:17, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Returning early from .remove() with an error code still results in the
> driver unbinding the device. So the driver core ignores the returned erro=
r
> code and the resources that were not freed are never catched up. In
> combination with devm this also often results in use-after-free bugs.
>
> If runtime resume fails, it's still important to free all resources, so
> don't return with an error code, but emit an error message and continue
> freeing acquired stuff.
>
> This prepares changing cpsw_remove() to return void.
>
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/ethernet/ti/cpsw_new.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index 0e4f526b1753..a6ce409f563c 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -2042,16 +2042,24 @@ static int cpsw_remove(struct platform_device *pd=
ev)
>         struct cpsw_common *cpsw =3D platform_get_drvdata(pdev);
>         int ret;
>
> -       ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +       ret =3D pm_runtime_get_sync(&pdev->dev);
>         if (ret < 0)
> -               return ret;
> +               /* There is no need to do something about that. The impor=
tant
> +                * thing is to not exit early, but do all cleanup that do=
esn't
> +                * requrie register access.
> +                */
> +               dev_err(&pdev->dev, "runtime resume failed (%pe)\n",
> +                       ERR_PTR(ret));
>
>         cpsw_unregister_notifiers(cpsw);
>         cpsw_unregister_devlink(cpsw);
>         cpsw_unregister_ports(cpsw);
>
> -       cpts_release(cpsw->cpts);
> -       cpdma_ctlr_destroy(cpsw->dma);
> +       if (ret >=3D 0) {
> +               cpts_release(cpsw->cpts);
> +               cpdma_ctlr_destroy(cpsw->dma);
> +       }
> +
>         cpsw_remove_dt(cpsw);
>         pm_runtime_put_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> --
> 2.42.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

