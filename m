Return-Path: <netdev+bounces-307762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FZ1qOkWLV2qAWgAAu9opvQ
	(envelope-from <netdev+bounces-307762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:29:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B875EAE2
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:29:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=gqXzYput;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307762-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB1E73106DAB
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9D435AAB;
	Wed, 15 Jul 2026 13:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8E40EB98
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784121836; cv=none; b=ZBWwnYEUAIXvAN+joVHNcZRMM32X2uMNRlPi4G09sN2Ua+7Qg+LzXY690Eu2MKhm7GR+TG96jpeleDKjMDbHkSvKnMqdLs6Az5XGZ9lt7KiMNWqMidRqlH12bENhuiTYC7TjS4sIec0aWXS+i4qtRHS2odEYBgme57YK9kkvw/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784121836; c=relaxed/simple;
	bh=z94vYiCWJsCpE51Ld9e0KMG2WhHZ/LQoO/A/z0yptoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDxLCg5tBUX0ZXoBCoiuuuFBYyzfFtbChyaf+LEWH6+PYxckJBXO4Cpce82LZzMYOxvKrOXI2sHAZJ9OkIi0fUOxTUzJ9SWnM+CiteCAB+Eh6tJDtE9mDWcUtZ9Cp2t6IScxUITSkWgTmR41DYLy6p1JsRwC/V9ZjfG1fcAk7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gqXzYput; arc=none smtp.client-ip=74.125.224.100
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6662551100bso6192073d50.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784121834; x=1784726634;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlj2yyIYZQvOQ+9gXa3zB5uIZdF945nYgwvVmyQmbA4=;
        b=Tz9fk+2aNPMinyA2Fa6NTMZo6RmAgdUjy+OL18QZEfxfAAgBisGhuNUpdx/EKTSOcP
         1Wt2LLoeUApjnoJoJiTTB9A0xOW1+5GamyvAaYuk9LSgA2mVeZsEgZZVYQsyFMiN3cW6
         BTZTWriE8gyVtw5mrEmgbkjPAONNdFRPGfvyrY+7A3ypxpuIlC0KJLarJP4FoVKfbgIn
         K9Rxh7zGMG84UO2AUSUvVuppJQm13b/uWj3WWveNa3SevZRm1Vu23i06BR38pjg/rB3Q
         WPqt01ZWdrcrqmlHgWQeutBrrK/TV88fINC/mU8u0aB+IN3o7HNg3PcL8W4cXNRTRkkM
         FSBQ==
X-Gm-Message-State: AOJu0Yy/2b0d0BHKOdIo4ZvVyb0VIze1PzVnDf1FxvltglitIun1cepX
	xrcWc5Tl+kvQUWfbqFiZHhu9rVTYAqOSQMfbH8CFD27mTLFRKjXxn8QmrBGfABHSBSg3SOg5g13
	ZlF8fdcxRSLH5qrWtdBbsPNPOPWn9FtzhDcddw+ZTzDMmcHelA97crFr3TYqM2uXbEnxuYF9X2r
	vM5HZERCsB+zz4vYe79HMlW+iIt8KFy+zhrktr5Ag6yhvX/uqzKqH69+VRYGK1K6kd4ubar/wWD
	jeUxlhp0fQ=
X-Gm-Gg: AfdE7cnw8mATT1/jed7GqYXp5hxR5Lvl0QlIFmrAqS6trcpLQyH6lUP9V3l0stI6xeA
	ah6BkB5/IosUWDoT12J8z6TO42xOOOSkS1nFZ6YcrCiqlAdGkn8hv+nlRi/MwpEpKehvpnyo1ev
	zKub1XuneTTwmNVeihkHnwKnnC4bPT9VaW63iW0kJVdYRh3PgLKuY7K12GzaUUHa0A/wF6XrZUW
	CqcV4WOspwPNqovGmRW/jX/VuDNp3Yx2R/cBr4apc1s4p0Nn7AwAXo95V89F16eJtC/UcHyPe2c
	Ge+jed47BD6MWIi67SzWbP6puTt2KGHdi8wdHcUU1kf0tHfKttPZOylx0d8T911HzSc/EhAQGQV
	jGf/0T+J5IwujXAVGngHLCORVnDeGVsGwxXEtoDGQgdlGNSTuY0MwvOxaxnF1xaYNkvHlJffKF9
	4ekN1Z0l77HfUTnFM7c/sOGRdY1qAbwLCrodrgt3C+vkEj8Xzi
X-Received: by 2002:a53:d009:0:b0:667:95f9:bcda with SMTP id 956f58d0204a3-668078c2546mr3352787d50.100.1784121833601;
        Wed, 15 Jul 2026 06:23:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6681fd7b5c9sm22422d50.18.2026.07.15.06.23.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:23:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c167e032f03so79525666b.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784121832; x=1784726632; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlj2yyIYZQvOQ+9gXa3zB5uIZdF945nYgwvVmyQmbA4=;
        b=gqXzYputsTeGAx+2STHI1GWbkc+RAO4Lp6mXT0q3NaBAelTcy/SYx3avUdS0rt9PH+
         OAojYXhKTdFfD7L+10iSWsaRj0ZHRQck8lluB5p7v90FixOCSKezpRus+rUKv3vmDi9j
         xCSGnGv6Z469w6ntwqJARmnZWx7O0zzLGPc5M=
X-Received: by 2002:a17:907:3909:b0:c16:12ff:dc86 with SMTP id a640c23a62f3a-c1679447aaamr192202166b.36.1784121831893;
        Wed, 15 Jul 2026 06:23:51 -0700 (PDT)
X-Received: by 2002:a17:907:3909:b0:c16:12ff:dc86 with SMTP id
 a640c23a62f3a-c1679447aaamr192198966b.36.1784121831382; Wed, 15 Jul 2026
 06:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714210745.1785625-1-nikhil.rao@amd.com>
In-Reply-To: <20260714210745.1785625-1-nikhil.rao@amd.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 15 Jul 2026 18:53:36 +0530
X-Gm-Features: AUfX_mwfsXrAno7FzTXbmBwZpB0WMy5JBr8Si3rDWb5KbzehZPFpo4J3dG7DSyo
Message-ID: <CALs4sv1dBCLDtWBrYLizmKH=E4+ZNgNCmyubqd46Yk9OHodrbw@mail.gmail.com>
Subject: Re: [PATCH net] pds_core: fix auxiliary device add/del races
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com, 
	eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000d42550656a63c0a"
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307762-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,amd.com:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E9B875EAE2
X-Rspamd-Action: no action

--0000000000000d42550656a63c0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:38=E2=80=AFAM Nikhil P. Rao <nikhil.rao@amd.com> =
wrote:
>
> Two paths add or delete the same slot (pf->vfs[vf_id].padev): a VF's
> pdsc_reset_done() and the PF's devlink enable_vnet/disable_vnet handler.
> They serialize on config_lock, but neither guards the slot under it
> correctly.
>
> add() registers and stores a new auxiliary device without first checking
> the slot, so a second add of an already-populated slot leaks the first
> device. del() makes that check outside config_lock, so two concurrent
> dels can both pass it; the first clears the slot, and the second
> dereferences a NULL pointer.
>
> Check and update the slot under config_lock in both paths.
>
> Fixes: b699bdc720c0 ("pds_core: specify auxiliary_device to be created")
> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/eth=
ernet/amd/pds_core/auxbus.c
> index 73b3481220b1..3acafe10a6d5 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -177,17 +177,21 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pd=
sc *pf,
>  {
>         struct pds_auxiliary_dev *padev;
>
> -       if (!*pd_ptr)
> -               return;
> -
>         mutex_lock(&pf->config_lock);
>
> +       /* A concurrent del may have already torn this device down and
> +        * cleared it.
> +        */
>         padev =3D *pd_ptr;
> +       if (!padev)
> +               goto out_unlock;
> +
>         pds_client_unregister(pf, padev->client_id);
>         auxiliary_device_delete(&padev->aux_dev);
>         auxiliary_device_uninit(&padev->aux_dev);
>         *pd_ptr =3D NULL;
>
> +out_unlock:
>         mutex_unlock(&pf->config_lock);
>  }
>
> @@ -210,6 +214,13 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc=
 *pf,
>
>         mutex_lock(&pf->config_lock);
>
> +       /* Nothing to do if the aux device is already present.  This also
> +        * guards against a second add overwriting *pd_ptr and leaking th=
e
> +        * first, symmetric with the check in pdsc_auxbus_dev_del().
> +        */

Are these AI-generated-appearing comments really necessary?
Anyway, it is your driver.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> +       if (*pd_ptr)
> +               goto out_unlock;
> +
>         mask =3D BIT_ULL(PDSC_S_FW_DEAD) |
>                BIT_ULL(PDSC_S_STOPPING_DRIVER);
>         if (cf->state & mask) {
> --
> 2.43.0
>
>

--0000000000000d42550656a63c0a
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDFj28T
B13k375+eVG9LEga/PEsYwkCQlzrWi98BV1g0zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MTUxMzIzNTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB74nkgq9ljUsmI45A9XoXanJ/W/wjAp9tqe/dGU4rq
XkwZoWSeex9Sbn+OtNKKzNy1V6Wu3lQPvUvyaimIQXPz49gn0l8LdH+cmFoyjMscSqKOGYxzR0+h
d96odOCbGfg/CGhqVBgOQlxKe0J03CvlZ7l9vw6e8G+RjaluI4TH5O7TOw4wEXFZBoL+DW9apE4r
ATX8pXTj5Js/K09hw+bxzjkaNKS5uCT47YkedBnonVZkesciDp8tol1DuWOg23fAPvWEssnto2Hv
OzfUjtbwpYaoixJvf2cK0eCfOer/BOpCaxCT4zCCP7dhOhZGqDD3hlVfpuBDUQHWmtkxKpyA
--0000000000000d42550656a63c0a--

