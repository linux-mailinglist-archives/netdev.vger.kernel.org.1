Return-Path: <netdev+bounces-306036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id da7lM8AiT2oxbAIAu9opvQ
	(envelope-from <netdev+bounces-306036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 06:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9AE72C8D2
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 06:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=WG4Y8eiA;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306036-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306036-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFB8300D690
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 04:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFB39902D;
	Thu,  9 Jul 2026 04:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6639903B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 04:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571133; cv=none; b=T0xnMFIm3Wa4Db5qYSOgJd8c+EANcNdXGHuh7kYz8Ydn07TRSbW3wm6bolsj0sKb0wjeT7njrHpadCt+4JPtm5R8zccsATQX6umk2OvO6b5rZ/h+L2ZwswihqpernctuMbRsJODCuyROuTAU9/PkepNxLCDnCmSYr2ykGapEmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571133; c=relaxed/simple;
	bh=xZKnhQblP3BHH5SX8uYqxA4p5EpO+KIM/Pnv+fHu64U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk2c6g8D2vtF2SetdE02bkU5OYABMbxVW0W2XWZgU5j1Coic30YltTMYtjW8Q6hRAi9LEihm4i5mbbANjGv+SkWRF5EJhB+koRRvPqSpe7hU371DkhkdUiaOxKKA865VfF7IUfr7jcDEmk1dAghZtA/b+rjUH6de1r2OMU3/DOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WG4Y8eiA; arc=none smtp.client-ip=209.85.214.226
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2caed617615so14090665ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 21:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783571131; x=1784175931;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBg2C3iQTJWKqghxgKRLAW/FcpyP8fOO66U6741n360=;
        b=ZhHdwoaskaXsfNq8zrshWYV3E8MPxsL7Jc3z0MEO/z4nff/eisua+RlXZm4KJmgXAD
         gOue/I/odrvVBQ2ergI5ka9PPggk5+/Z4GdDlokNLrPxfGw9yivm+jYl0rjo+g9MBazX
         hJVBRCi5rskQtRiD2UvVta8uQ0/mIvZTIF7C4aO0tAddUruEAe69kSI9UBR+PVynKebV
         yXI++ViW48h1A+JSigCLBiKsO1dW0kBX/DT5vTmCQw3vrdqZa7VjsWfORcDG03yKiSfD
         uLkmW5z+qmqVd9Ssja0ysiLrtdTCTrgO17+b7REyJzNz4KbxP5t5lsViMiJQRsyGjbV1
         eyKw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+KG7V0ldfuV8F7VY6Owr3B/c97A8pAoUq3xfR+NQ+fb517FRo+QS7BTohQI9FKDh8885lr0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZJNaMQl2A6Vjxy4zgJuD8cOkWgOUBbsYeHnhdFXRM1vIidX1
	wzRyk5wS80Dpm00lrR+z3iywz966uNBhubyvnFWxU/ZKMpmi9c2xMDDl8TuqCTIHuPGDZXyvOn3
	jFuc63zCcDrSz6dhkoJiB9i2zD9Vt1qbMIjCRf7HMngL7eSQZWyNp/gQk6L0RIn49dCKWsdYEAB
	Oh+8A+tJwURDt9VVGxMYwT1XweEaq+R/3YUwoOGG8B2GIBUVoAIBeNN8m5uK7aiSsq/uUHho1pH
	yf8+ADPEpI=
X-Gm-Gg: AfdE7ckl3jYO6gQur+Clj5NjotHUgTPAbnZscHJQ8NNT284sCW6oPVbIY4EVH1GuRAY
	BwoFQ3f9jd8dF3Zl/a+1ADzbLQrlM9en1WPvf/BxdsSuwIHwP8IOBUYT1yfNVagdrKTFJoThMvn
	IBGfgAVn4caiBINztW0GyCmgbUt0+q4f2n6NCj8gBdA0bvFcN97inmwFKbXEvdsiTHvmHvi7MnQ
	IKT6D3KzzeOCirIoy4U89QbDrYX1ItsdThidgFezZZiHpuUyC5ilAakQQTYPvr+evN7UogoNrQ5
	Cd8INEuvc0eTOW5Hz76Q1MZlFlQa1fGpxW7HRhr/YP0Qnorq1NMw7/eN9VM4+d0AVaVQN1t3Ly3
	BWrI8t0BCqkFemsdW8W6Qe0VmJ+YxbcQj9Z1DBPRBu797Ym7eegyEWvg3OG9F9px0aMBxHESaEn
	34y00wj9v/aYUD+L33cDHAKfSNs0jDAvL6EhZzET5586tyqw==
X-Received: by 2002:a17:902:e950:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2ccea384155mr57256155ad.4.1783571131194;
        Wed, 08 Jul 2026 21:25:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9cdac4csm6881385ad.36.2026.07.08.21.25.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2026 21:25:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847ad67cc51so1747958b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783571129; x=1784175929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBg2C3iQTJWKqghxgKRLAW/FcpyP8fOO66U6741n360=;
        b=WG4Y8eiA46bfOAuPTL8LjrHLt7rt0kl18cN/kRH1U7Z2/js547Bs5loRFjiyzYpUb8
         c/7rh2OXQMZehDmZyJDUQNPwkvySDG1jSsn19BkaPJFT4Fku5L8ARMrNPjSYmQ4Fg9PR
         w7YACDDMl7rTQYJkh2sl3MSO3WSMgp66rO8qA=
X-Forwarded-Encrypted: i=1; AHgh+RrArjalkYugWTPUmtpmDJCSlNy++ZDpTVvqp6sW3k9einJ+0NE2Ggg2Jby4Ninp8l3gjhUGkvE=@vger.kernel.org
X-Received: by 2002:a05:6a00:4292:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-84842ee30eamr5516408b3a.25.1783571129523;
        Wed, 08 Jul 2026 21:25:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:4292:b0:847:99a7:c751 with SMTP id
 d2e1a72fcca58-84842ee30eamr5516395b3a.25.1783571129063; Wed, 08 Jul 2026
 21:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708143401.3167477-1-ruoyuw560@gmail.com>
In-Reply-To: <20260708143401.3167477-1-ruoyuw560@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 9 Jul 2026 09:55:16 +0530
X-Gm-Features: AVVi8CfwKOrL2uvN16435Gh5XgxRMt5THkff8HRRlSEjf_lGU5FrCb9JNIND4Vw
Message-ID: <CALs4sv2t+zGG-_uQE+vkcsopu6YB8+v4c0YeU1pmMeToqKGfRA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Handle partially initialized auxiliary devices
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jacob.e.keller@intel.com, andrew.gospodarek@broadcom.com, 
	vikas.gupta@broadcom.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a1af910656260393"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew.gospodarek@broadcom.com,m:vikas.gupta@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306036-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D9AE72C8D2

--000000000000a1af910656260393
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 8:04=E2=80=AFPM Ruoyu Wang <ruoyuw560@gmail.com> wro=
te:
>
> bnxt_aux_devices_init() calls auxiliary_device_init() before allocating
> and attaching the bnxt_en_dev and ULP table.  After
> auxiliary_device_init() succeeds, the auxiliary bus owns the embedded
> device lifetime and the driver must unwind later errors with
> auxiliary_device_uninit(), which runs bnxt_aux_dev_release().
>
> The release callback currently assumes that aux_priv->id, aux_priv->edev
> and edev->net were all populated.  If the bnxt_en_dev allocation fails,
> release dereferences aux_priv->edev while it is still NULL.  If a later
> failure happens before aux_priv->id is assigned, release uses the zeroed
> id field and can clear the wrong auxiliary-device slot while unwinding a
> partially initialized device.
>
> Set aux_priv->id before auxiliary_device_init() so the release path can
> identify the slot, make release tolerate missing partial state, and clear
> bp->aux_priv[idx] on the unwind path where release cannot derive bp from
> an edev.
>
> This issue was found by a static analysis checker and confirmed by manual
> source review.
>
> Fixes: 194fad5b2781 ("bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit =
functions")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_ulp.c
> index 5c751933da6a9..e85d1b6c9fb1f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -472,12 +472,17 @@ static void bnxt_aux_dev_release(struct device *dev=
)
>  {
>         struct bnxt_aux_priv *aux_priv =3D
>                 container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
> -       struct bnxt *bp =3D netdev_priv(aux_priv->edev->net);
> +       struct bnxt_en_dev *edev =3D aux_priv->edev;
> +       struct bnxt *bp =3D edev && edev->net ? netdev_priv(edev->net) : =
NULL;
>
> -       kfree(aux_priv->edev->ulp_tbl);
> -       bp->edev[aux_priv->id] =3D NULL;
> -       kfree(aux_priv->edev);
> -       bp->aux_priv[aux_priv->id] =3D NULL;
> +       if (edev) {

Instead of these checks, just allocate the memory for edev and ulp
before calling auxiliary_device_init().
That would be much cleaner.

> +               kfree(edev->ulp_tbl);
> +               if (bp)
> +                       bp->edev[aux_priv->id] =3D NULL;
> +               kfree(edev);
> +       }
> +       if (bp)
> +               bp->aux_priv[aux_priv->id] =3D NULL;
>         kfree(aux_priv);
>  }
>
> @@ -571,6 +576,7 @@ void bnxt_aux_devices_init(struct bnxt *bp)
>                 aux_dev->name =3D bnxt_aux_devices[idx].name;
>                 aux_dev->dev.parent =3D &bp->pdev->dev;
>                 aux_dev->dev.release =3D bnxt_aux_dev_release;
> +               aux_priv->id =3D idx;
>
>                 rc =3D auxiliary_device_init(aux_dev);
>                 if (rc) {
> @@ -598,12 +604,12 @@ void bnxt_aux_devices_init(struct bnxt *bp)
>                 bp->edev[idx] =3D edev;
>                 if (idx =3D=3D BNXT_AUXDEV_RDMA)
>                         bp->ulp_num_msix_want =3D bnxt_set_dflt_ulp_msix(=
bp);
> -               aux_priv->id =3D idx;
>                 bnxt_auxdev_set_state(bp, idx, BNXT_ADEV_STATE_INIT);
>
>                 continue;
>  aux_dev_uninit:
>                 auxiliary_device_uninit(aux_dev);
> +               bp->aux_priv[idx] =3D NULL;
>  next_auxdev:
>                 if (idx =3D=3D BNXT_AUXDEV_RDMA)
>                         bp->flags &=3D ~BNXT_FLAG_ROCE_CAP;
> --
> 2.51.0

--000000000000a1af910656260393
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDGYQNc
B3vEWg/hRR0ttZ/lYpI1Fx4xbPqoBwu25CeRKjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MDkwNDI1MjlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBgO4Cngr7fFGo/LUUJdYXRG5Otaj+5fNEpScPIQund
ir4yFfgDnlykj2EW9gIgeQ7CyH4zGKkZ3rwSlgYYg8uBABsgScyj3q8uxaNcEdyMO7iOTyV8Zd1/
av1T4LqHikh1n3SO6B1SPv1tYE6wv+uwuE8xpif0Q9Ipcm4GRXBkC5e1e7aD2NY5PEGDYsHuHrvb
XAe/b281a0YOGQyqceEmnpsyvF9e5m3AiGksy+DvSZCGPPKmAS6x5j4RAK3QlrgMGb/fkxpMkb2I
xnSQ5LUCEw7VnWrDSMRg4f6vYGEQujzbvXGf4p5G7kz3eZ5IehHKKt/IWALPMVnDDcqnHYdw
--000000000000a1af910656260393--

