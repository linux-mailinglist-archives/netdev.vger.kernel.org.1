Return-Path: <netdev+bounces-277528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFU3EaFT2WmooQgAu9opvQ
	(envelope-from <netdev+bounces-277528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:46:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F23DC197
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D8630063B7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BC37B40A;
	Fri, 10 Apr 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="glXWuMMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AAD33ADBA
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850347; cv=none; b=nXS0rFdGJJmZf/p29dFeP0JjSgT/O4qyNl37PeYFKWuWds7l/Mo9dTJmyyH7y20IjqPieRUYjIBVojElOPWq3bweLIks3EQf1KrLMqfvUUyKeh/cCHY7k686zOnGbfGBcONZovFHoyMips0KO19ILPGSSIkrJRi2FhYZjgRaH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850347; c=relaxed/simple;
	bh=OwOfqY+aeBrA/faygxaJxdmy0WVIeMBdvIeiNLKmWGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9rPV9EDOI/IAdtYAu1tyl8mRgarf7n9izRRpO63XKPbqUGLKPk08lMWkBGTG/lsNxPjiCIk5vKgmTJjYg055/SFYla+wF4OGvCkevD1MZMG56EroetqOsW/0i/tbECLMq0aVT36MGpEo54Ts1iWG23nEC+L2ukHgsrs4RM4ZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=glXWuMMR; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-4042905015cso1504416fac.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850345; x=1776455145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZPwCa73uUoWxphk/esFKxSR5B6A9bkf4Eve5vm6SXg=;
        b=ISVqmOztIWehe/Ip99GuBI0CenAm6dQKNVEQIH0kuEWi22nkbBUph+NG7jLZofuKzQ
         ZOPnBDcPBQzMRMJuPecbQYDFPIB5EshNP2eO9++bO6MdQ7O8A1wW8ctcqff12X8wz7Wa
         kC/kmuUPtMcyItlXiqjpzlEdocTSasroFcO/cTW03QDHuOQSXw6KGwvydxO4hQNUeVgd
         T5v1SirnOGff4H/hpkDNz4421EFHfh70xjorXxbjIM5mYZzb0lmIOjvnoI2ksXxFagJX
         pxu2o+eavQYcqw6TKhJ3zkSccpXiF6AybO+e+mk10Z+V2Z1sKgYALt3fE7KK+lKk0RVs
         k0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCULftySpwGlWVjTG5mk9wWKK7SaTcvC3w+v7E1UGszscdxjbz06mXgW5mydwXrXfPaJEcAiEkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Kanp1xuCBBV6VS8GkcyEq3YsmYHTu5sTHPOYcaiV7ngnyV2W
	+ORGA74LtFuXS0TCMAXGXDUpwDS5wKNCHdQeSQ8gyMcCdJn40Wxl7ZvD4bB9PSx8szyacNv15xH
	6OB+zrV8jlsLopr/s9vO8Y6UWO0bDNRyeODspDzlIcESjILL2YBAVdmwpvwHKIsb2S3ttAmr3R1
	w964YP4bUAN/4xw7eXWY6+Wa+7Pm1Ouxq21D0OTcI95FmAJ8rTpMocybsOvsIPBknfqC+9ru5vR
	WnpBqG2eohC8Tc0cQ==
X-Gm-Gg: AeBDietiqyDiOQkJt1xs0A9GvP4z8waZe8oE7FBkkvuJj0bpZZaIxg4XQ4H9LxDo9e5
	MG/BxF/vfwKErD6fx8bGk6uQPl4KYKIWegIhUIiihjTRJx5T3VwX3AgBeL0zcJ1aIE8p1gr3mXZ
	fS5+CLlqNdT2QCc0fzlzk2RS+fRRKvHulh3Rv+1jzkJk/PC1i2x+YkAZDP3zbo/t/yP7wdkXZ3P
	CXn5wJpNPx4Q8PD1V3WikGI31MdaHRlHzfumiGL9K/W76UtwtKHaYrWjozVSKuSUoorAenx4hHW
	5MHG6p0KU7oVu9aU9STDkYzzlw8jmTiARQOkC+6QfGoA2zwGt8UOPgeM4E0XGyZOyS2YuuzRtba
	8AQckfQyuYxElerEu+eyhiQyIV/UnP2BCChjfMT5jsK7S4DJy9OvD/JiJbRenCSovB8d989SKQc
	lzbYCsGkAZJwmsThPldMspN+9giJNEuJcEg5hTHfuovz57ww2uSxIPC7CBtH6CizE=
X-Received: by 2002:a05:6870:220e:b0:417:3421:13ff with SMTP id 586e51a60fabf-423e113c6afmr2675132fac.29.1775850344732;
        Fri, 10 Apr 2026 12:45:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423dd788a6fsm456773fac.7.2026.04.10.12.45.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:45:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7987861595eso70117097b3.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775850344; x=1776455144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZPwCa73uUoWxphk/esFKxSR5B6A9bkf4Eve5vm6SXg=;
        b=glXWuMMRDd1tmppJSfhgiJHdavq7WnJzkCAQvudASfY+lEFzn4y3IqRmDmFw+Zd+Mu
         d9pf6qA+c7fPkyTyIdc4oDBsU4fKevvv4DPo+n4hxWp7ZEmLwYpc0eQ9eXze7jBy+1+7
         YFoF9E6rZHO81mCUJRu3rQmhz4J1hlmBDtz3Q=
X-Forwarded-Encrypted: i=1; AJvYcCXDtlJVsKjyzPb5+OK4gtmixWfdMkqCHYxHj5uLF/PQB79Vl5yD+3bNu+R1HvalqyopOpdVhGM=@vger.kernel.org
X-Received: by 2002:a05:690c:388:b0:7a4:80ce:8275 with SMTP id 00721157ae682-7af71478e2fmr47718357b3.35.1775850343764;
        Fri, 10 Apr 2026 12:45:43 -0700 (PDT)
X-Received: by 2002:a05:690c:388:b0:7a4:80ce:8275 with SMTP id
 00721157ae682-7af71478e2fmr47717977b3.35.1775850343170; Fri, 10 Apr 2026
 12:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-3-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.2484afecaca4d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2484afecaca4d@gmail.com>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Sat, 11 Apr 2026 01:15:30 +0530
X-Gm-Features: AQROBzAohzoNuX0XuGB7EBBUwbHcyj2NuMCYxIwyYxJ1Pn9ZG4C8OyxMm1_GR18
Message-ID: <CANQF7iCn=ji4+54SJTrKBJ_ZUUDcNgO=voXK-quQkRLjsvRgmw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] netdevsim: psp: handle the new crypt-offset
 and spi-threshold get/set operations
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemb@google.com, daniel.zahka@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com, 
	ajit.khaparde@broadcom.com, kiran.kella@broadcom.com, 
	sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eefc6c064f2060e8"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,broadcom.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 9B0F23DC197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000eefc6c064f2060e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 3:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akhilesh Samineni wrote:
> > Implement the crypt-offset and spi-threshold get/set in netdevsim PSP.
> >
> > Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> > ---
> >  drivers/net/netdevsim/netdevsim.h | 2 ++
> >  drivers/net/netdevsim/psp.c       | 6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/=
netdevsim.h
> > index c904e14f6b3f..3ad7d42391c0 100644
> > --- a/drivers/net/netdevsim/netdevsim.h
> > +++ b/drivers/net/netdevsim/netdevsim.h
> > @@ -117,6 +117,8 @@ struct netdevsim {
> >               struct psp_dev *dev;
> >               u32 spi;
> >               u32 assoc_cnt;
> > +             u8  crypt_offset;
>
> Minor: variable names are already not aligned. No need for two spaces.
>

Ack
> > +             u32 spi_threshold;
> >       } psp;
> >
> >       struct nsim_bus_dev *nsim_bus_dev;
> > diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> > index 0b4d717253b0..9098edf00c5c 100644
> > --- a/drivers/net/netdevsim/psp.c
> > +++ b/drivers/net/netdevsim/psp.c
> > @@ -122,6 +122,11 @@ static int
> >  nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
> >                   struct netlink_ext_ack *extack)
> >  {
> > +     struct netdevsim *ns =3D psd->drv_priv;
> > +
> > +     ns->psp.crypt_offset =3D conf->crypt_offset;
> > +     ns->psp.spi_threshold =3D conf->spi_threshold;
> > +
> >       return 0;
> >  }
> >
> > @@ -249,6 +254,7 @@ int nsim_psp_init(struct netdevsim *ns)
> >       if (err)
> >               return err;
> >
> > +     ns->psp.spi_threshold =3D PSP_SPI_THRESHOLD_DEFAULT;
> >       debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_=
fops);
> >       return 0;
> >  }
> > --
> > 2.45.4
> >
>
>

--000000000000eefc6c064f2060e8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbwYJKoZIhvcNAQcCoIIQYDCCEFwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOrzG5lI4u3g
7N/qIc0zzZrM1cowC60SRTeyCuBUfbk6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxMDE5NDU0NFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAK/O4Iz/6m8Glw8PBuyAb3UVyQNAJZTtS5qSZkQ3PMaxdbhn
ypPAUcUo3Fp98v2y1T9qNEA06FBz7bLqmQnfpInc1Tob47cywkhGBbXYQu1xL5DqfnTypJyPdnNj
zE6uBYhuc/oIFGjusrn6lLW++Pv9r8IEXva9U8NOgUD22Y3K28sRLwBsGjSCRGAE35nzE2sX51Ux
6F7qyiQdcRm/AMYS+evej7iaSpUAp0ZhxjqvdhgK6J8vZOZyq8nwdtBoWZcwlgZY2aZofNZyKKlG
c+YRQkxPuZron+bphxzwUD67FldY0dVNAQCK3LA7lza5Td02m9a0EEeMponbwpTTtVw=
--000000000000eefc6c064f2060e8--

