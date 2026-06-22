Return-Path: <netdev+bounces-300949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qnFDDWC1OGoVggcAu9opvQ
	(envelope-from <netdev+bounces-300949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D476AC736
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 06:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=L4Zo4wRI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300949-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A7E43006105
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007134F498;
	Mon, 22 Jun 2026 04:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2543385BC
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:08:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782101340; cv=none; b=JFmse+00WLC0wxMZTQ+bSBT222RVxVz/U7uFMA0lhclKGve1P4YvoYjzF0YTy7mWupG4Vpfa0MS5mS4g2+6p/abZQcv+7+Etvz47e36/8VQl/DjpD8eD5aWmSCJOn7ONoXruIGV4TauRSvSmrhr+NfeZe2cX5nF7ipyTb255XTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782101340; c=relaxed/simple;
	bh=DsUuzD9/c8ROiNOTvctW7+6voyZObqtsHfLvgpB7gKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz9FOmhAOQtmpQHV06rIQGcCEYiJA8NZmVMRnbEYgKGTRENOhln5KGc0Kd3GGI40V/pH6+pqzQ6/5rsIkrMtW7pfSpGWfdI5pCsJYIltUqlR0lev+5O81TfFXSpoYJZLeTdMxd7yjELU2yI+3J4OTNCaEQklMy/ekeVN5DWAB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L4Zo4wRI; arc=none smtp.client-ip=209.85.128.228
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7dfceeaf168so47317537b3.0
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782101338; x=1782706138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3kprDmDCBMbfOwgEz+D06WTYmyjXkkc6C3vD06cU0A=;
        b=MEpi5NRahR7YQCx6K4CPZtjbRYOFS+GpDV+MTw0c7F/NCnLEVG/aWcAk4XAa4M27Rs
         Pdxc/uMgZMy4VE+y/yV1pnv2J9JmsxqVQAHgbEXMRwOPwvzerUD8PRmWV/3cz+bpXKsX
         u2WHlHgSuLuHrOQR0CWY/cVVf0MGxET8QTkwI81SXTm1L86mElHrExM/R4tPa26KrgqB
         +MtfJAKt7MIZ4ABk1OjiYuOyBdj8B1wdPm0qNSzafkbFoxi9fpRv6MOWaD1FLiL59LhC
         RWRlivzjrJjlxw8DMo1ZK2MHcCh6r+wrdBM5gqHLXDOK4SK7I65oorj7KDwoQgJ2nhdt
         0mxg==
X-Gm-Message-State: AOJu0YxUt2wiGizolsM109D3zcFe0nDHRiEzTapRn1tlDxSXm832wkMa
	MRK3TiN9sdUcAR028rm4SDSE62WGR42+SeRs5z+s2Kf8vOypRzxK2kw7I5I/fWLNh1npJrsr5JQ
	TRsPakjfCp+xLd8BavGh+NdcUz8M47g9QvpTeEaZNMQYQ5B6SSBECf6XBYCAYrzarh9UON45jzs
	Te3+tSr/DgGoZoVjjJqcHAZ54qdnmlYTBPnF8t1w/dALii5KQi5DbNK0xvuOI+2XQq+Lwu+jne0
	J9B8WjH+1o=
X-Gm-Gg: AfdE7ck11OJ0JPUNla3AYl08nJ6S7mLpgeZihBrOtvfaOYelVPvfOOc0gWS451cxfay
	3sHi7rGc/Q6Z9sgbomzm2uFGGmSuCizI6OkaGebA3n6oFpi/I8ymmXlra7QMMS59pMSQzvD5mmJ
	MuzjnVr2r91WmFtAcmFP5LlHtgRC1VmlEvq7hJYNo7X8tbd77jnmtwvQMdwBoMs1ER0Kgfv+Ix8
	gj8BJc6eWJq0h/T5HB/5o0hj5ue5t63HRjc04CRw5UVDlEy+r7KKR9SJp6JvfjaQWxoaiMCaHV1
	WdWRuzbUzjRbtDy/ua+InO7LIrcWEgaiME5omK4YEr7e2/3STb+ULS2xBB/mS7eESNzCrf/zOXN
	txj1UJzgSv4R2HebC3j6dBS6exK0ICknK/Mohe5uoynR6Chmp5KGyizII4ZHmKVlXuY7CS/zcVr
	IRRIE/wVedCy+g2BryzgcgK6Q5zHO5v5iXK71TrRDRN3RMlKAC
X-Received: by 2002:a05:690c:4c06:b0:7ff:241f:5073 with SMTP id 00721157ae682-801759e31cemr121830317b3.6.1782101337762;
        Sun, 21 Jun 2026 21:08:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8025f7e06e8sm3509427b3.22.2026.06.21.21.08.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2026 21:08:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842208d5b0eso2703752b3a.3
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782101336; x=1782706136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3kprDmDCBMbfOwgEz+D06WTYmyjXkkc6C3vD06cU0A=;
        b=L4Zo4wRIRrLIrhxtoHnS3c74alEPUdh2pMkqb3WAxgXgpYYVnMu9IuOnXiOj72moif
         p7Y02bb9fdFOPdA9wJ1sCa5O07I+oBM7Y2qkx7mHqmOD3vBUnGhzLzXtUoA89M8Z0aD0
         Is4UL0mslM42TEQ1X/EXU0SkoWaRqg/93S9iQ=
X-Received: by 2002:a05:6a00:4f84:b0:845:3260:50d1 with SMTP id d2e1a72fcca58-845561132a0mr13735688b3a.27.1782101336432;
        Sun, 21 Jun 2026 21:08:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f84:b0:845:3260:50d1 with SMTP id
 d2e1a72fcca58-845561132a0mr13735648b3a.27.1782101335962; Sun, 21 Jun 2026
 21:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622021934.1415455-1-rosenp@gmail.com>
In-Reply-To: <20260622021934.1415455-1-rosenp@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 22 Jun 2026 09:38:42 +0530
X-Gm-Features: AVVi8CfCCZ76iDAcm8yPAT1nxpPgMofhmQ_H6yGCYDC25mTdykWTraBk7_ZK9mY
Message-ID: <CALs4sv0kXd4+UfWcbxuFuSB3Ez=YX++G6HaZxhEeQsduJ2QeLA@mail.gmail.com>
Subject: Re: [PATCH net] gianfar: fix memory leak in gfar_parse_group error paths
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>, open list <linux-kernel@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000021d6e30654cfcddc"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300949-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sandeep.Kumar@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D476AC736

--00000000000021d6e30654cfcddc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:49=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> In gfar_parse_group, if any allocation in the irqinfo[] loop fails,
> or if of_iomap fails, or if the IRQ parsing fails, the already-
> allocated irqinfo[] entries and mapped regs are not freed.  The
> caller's free_gfar_dev cannot clean them up because priv->num_grps
> is only incremented after a successful return.
>
> Fix by adding an err_out label that frees all successfully allocated
> irqinfo entries and unmaps regs if mapped.  Track the number of
> allocated entries with 'allocated' and propagate the correct error
> code.
>
> Fixes: 46ceb60ca80fa ("gianfar: Add Multiple group Support")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ether=
net/freescale/gianfar.c
> index 3271de5844f84..12ebb207be0be 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -502,17 +502,19 @@ static int gfar_parse_group(struct device_node *np,
>                             struct gfar_private *priv, const char *model)
>  {
>         struct gfar_priv_grp *grp =3D &priv->gfargrp[priv->num_grps];
> -       int i;
> +       int err =3D -ENOMEM;
> +       int i, allocated =3D 0;

Declarations should follow reverse xmas-tree fashion.
BTW, why num_grps cannot be incremented quicker? Not sure it can cause
any issues, since all this is happening probe(), it should be safe to
do that?
That way you could avoid cleaning up at two different places...

>
>         for (i =3D 0; i < GFAR_NUM_IRQS; i++) {
>                 grp->irqinfo[i] =3D kzalloc_obj(struct gfar_irqinfo);
>                 if (!grp->irqinfo[i])
> -                       return -ENOMEM;
> +                       goto err_out;
> +               allocated++;
>         }
>
>         grp->regs =3D of_iomap(np, 0);
>         if (!grp->regs)
> -               return -ENOMEM;
> +               goto err_out;
>
>         gfar_irq(grp, TX)->irq =3D irq_of_parse_and_map(np, 0);
>
> @@ -522,8 +524,10 @@ static int gfar_parse_group(struct device_node *np,
>                 gfar_irq(grp, ER)->irq =3D irq_of_parse_and_map(np, 2);
>                 if (!gfar_irq(grp, TX)->irq ||
>                     !gfar_irq(grp, RX)->irq ||
> -                   !gfar_irq(grp, ER)->irq)
> -                       return -EINVAL;
> +                   !gfar_irq(grp, ER)->irq) {
> +                       err =3D -EINVAL;
> +                       goto err_out;
> +               }
>         }
>
>         grp->priv =3D priv;
> @@ -567,6 +571,13 @@ static int gfar_parse_group(struct device_node *np,
>         priv->num_grps++;
>
>         return 0;
> +
> +err_out:
> +       for (i =3D 0; i < allocated; i++)
> +               kfree(grp->irqinfo[i]);
> +       if (grp->regs)
> +               iounmap(grp->regs);
> +       return err;
>  }
>
>  /* Reads the controller's registers to determine what interface
> --
> 2.54.0
>
>

--00000000000021d6e30654cfcddc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA5RipG
0eI1RQOkLRB3b4+xCJ/fZ7IiUHOxJuNfkSNVlzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MjIwNDA4NTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCE3bt22jjU6GfV/J89QFOsvI5XnEv23YBbqopzNwnN
4jBme5AiXlmS2u+Xglaldu1fKF+vlUJCkLgWOkErLFziuQtBum73Rh++FYgQjJ6DvExm9AM/Gzps
QEKHvHhZTH0yQPAzbYNfgk6vmFeRVdpdlQQpx4YekpmNIbrJUBEHg60n/6C26ApK+E0smnWGFZuK
NuImkwwcr1UP6KPfTCviocxi3YHXF5m5rqR7ilB9hx3HsFgX02OKtn2Sq7bslpDDqDQfVCLYMO+y
b9Pe3b4BO4InHeFCfo8321B0b+8DUP0U51Q1VArZXhPmlx6vS7034RnGO/kkhxA0PIM8SBHw
--00000000000021d6e30654cfcddc--

