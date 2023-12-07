Return-Path: <netdev+bounces-54789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04680836F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 09:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397682839AA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424E134AF;
	Thu,  7 Dec 2023 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAUzGHB+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0E1AD
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701938734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm6L75ZYUtSIBUEJVs/M0f9Bq72gbApPuHksEfrv+cQ=;
	b=YAUzGHB+9t+GfH+6bi7B7igMf2vfzmM1+MH/9zzO8D9QAIFXF54THasnpkAGuxB+V4S0CI
	HLw7fwyhSVIQy+KSwkHatEoxpe6qRFBlceSg6AGumykxJ+vlLcgpUbwt/CvWDMtfFLilxg
	kv12NkKFpW+a2RDIfr+GW6V0PwBM99w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-5ub16-m8O2aRR4U5RoPF4g-1; Thu, 07 Dec 2023 03:45:32 -0500
X-MC-Unique: 5ub16-m8O2aRR4U5RoPF4g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9f0a2f6deso3465991fa.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 00:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938731; x=1702543531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm6L75ZYUtSIBUEJVs/M0f9Bq72gbApPuHksEfrv+cQ=;
        b=c772lBAaVIK/7bMVmq9QziFlKMMcUwGGqIEOUiEDILBdeoWEabBIChlWqXtCe+p947
         Q63ZsYQRHm/t93TdUmOmYLGT82AfBpvQicTnkAn7UKbdoZvMVeV7btivlPmFWGEU9Q/x
         BvsXjaEU9zp28moWICIKTnyKzUNEWyqlQiw97lIgS4QW39ovAJ2JN49VQLiIPaeaIHFx
         yhD15MMGjDg2gRgGJV7xZT4nEHs89h8FlAK1Arcj8sBfd+PWKaAFlndek10Ia9QRKgeM
         /7Vvy3Hz0uijca4HWq+ANirvdDYf6FPFHC9V7sG3VYMGt+5UbXZZzatF9s88fm9ewKso
         UvvA==
X-Gm-Message-State: AOJu0Yx0v9AcpFBNgPChunmgV/hFhoPNcRc6ehNqYXc32fa0cxXTuWVn
	krdCg+fgb2fH+IaZcPWf+sUNyt3Sk3d/6mPMTEQNOpQCmA7OJY85RgTuKI8JkfYGWfNEUscH1Xz
	9j0MZz0dyjtOMY8ciJqx2HO6eSG8wpuVI
X-Received: by 2002:a05:6512:3b5:b0:50b:f724:8f87 with SMTP id v21-20020a05651203b500b0050bf7248f87mr1028516lfp.74.1701938731547;
        Thu, 07 Dec 2023 00:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLjnpf+13CTzR83DOtoFZ35srDsGFdV7klkXJYOwEr3ONEBKAKlKMSpQz3BG/YoNgBs6vnaFNTqR5n1VDDNU=
X-Received: by 2002:a05:6512:3b5:b0:50b:f724:8f87 with SMTP id
 v21-20020a05651203b500b0050bf7248f87mr1028438lfp.74.1701938726450; Thu, 07
 Dec 2023 00:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207074936.2597889-1-srasheed@marvell.com>
In-Reply-To: <20231207074936.2597889-1-srasheed@marvell.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 7 Dec 2023 09:45:15 +0100
Message-ID: <CADEbmW1qF7UvGr0rZ0NUMiP0Lybgz3CHLB3JVBn_Na-8md-tgQ@mail.gmail.com>
Subject: Re: [PATCH net v2] octeon_ep: explicitly test for firmware ready value
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Abhijit Ayarekar <aayarekar@marvell.com>, 
	Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 8:50=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
>
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V2:
>   - Fixed redundant logic
>
> V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell=
.com/
>
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..b8ae269f6f97 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pde=
v)
>
>                 pci_read_config_byte(pdev, (pos + 8), &status);
>                 dev_info(&pdev->dev, "Firmware ready status =3D %u\n", st=
atus);
> -               return status;
> +#define FW_STATUS_READY 1ULL
> +               return (status =3D=3D FW_STATUS_READY);

The parentheses are not necessary, but if you find it better readable
this way, so be it.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

>         }
>         return false;
>  }
> --
> 2.25.1
>


