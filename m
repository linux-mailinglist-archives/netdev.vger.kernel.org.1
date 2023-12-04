Return-Path: <netdev+bounces-53606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4302803E2A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B621F21278
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98477315A2;
	Mon,  4 Dec 2023 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JHu6JDMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315DAD5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:14:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso5938802a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701717267; x=1702322067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAGEg+1MtsJeikYXru3jBloIqDmw6EXMRvByj+/0ews=;
        b=JHu6JDMa3D58sjntqcmo5NlQ0M6rK5Bq9Rc+XnSlrswgfNMORqDDIFNjDewOvjikG6
         wJVdiSSILg7kg+lN+REKsgoJxtfVV/qONWbWlQKkeyJv9qFunBF6i7REB0+02LzS4Xrx
         3CtAf7sH9QjW+CCjVqNjtdbRueHyJmIIL6nDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717267; x=1702322067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAGEg+1MtsJeikYXru3jBloIqDmw6EXMRvByj+/0ews=;
        b=Qx9fycP69YvTaeTpCgOs5ML3i6mxKdOSFeeag687DYjJhJcyEJxfuNHhR0+GW562T+
         90jnekVsEHE0XCuXB/RGIq4kgrNTNdqcdNWrJeUVpg9LrRLiW8//OaUfHmBA/aNifGds
         ZvxS3EtmHuobDfxc/Y60y9T2sjP/zkk6NirmDzO2RoEbGHOjTKMnz5zEPm6ottJR7Xrh
         S4Chqpnhceuowjvs8SGexvwvJPNmX/zpEpwxV1/OhdFMNU4r1KJYsgmSx11y30CFmOm3
         CdkUjp//rdtOz4Te3TqYLfLrdQKDc3YekjdySGaj8q626Uw7kXiNPiDy7q3zSXEd45kP
         t4oQ==
X-Gm-Message-State: AOJu0YzsD8QbClX4jaE1UdU02AtEelRanv69LSvUiz5YDeRaXjeXiq2o
	oFu2kZPmvRRhLB3UYWgNheeHIyw/JKyEI/mRZxyapA==
X-Google-Smtp-Source: AGHT+IGZD9UmggrPHLfHvDinlSC3L7uITJEwCpdlkN1/oFNYkLKUi94zpX+9SnfgNpSzRWYNciQHWxx46aMtPFE+H30=
X-Received: by 2002:a50:d645:0:b0:54c:1fc:7574 with SMTP id
 c5-20020a50d645000000b0054c01fc7574mr4270308edj.29.1701717267229; Mon, 04 Dec
 2023 11:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204024004.8245-1-dinghao.liu@zju.edu.cn> <CALs4sv1cB6a5jKOgh7JWFLYz8pxfxOuszk3MAYc5xWY9HqYX0g@mail.gmail.com>
In-Reply-To: <CALs4sv1cB6a5jKOgh7JWFLYz8pxfxOuszk3MAYc5xWY9HqYX0g@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 4 Dec 2023 11:14:15 -0800
Message-ID: <CACKFLimhHCAqs1APuhX9CWd5c9OQTV=RnA-Aague4SgQufE+_A@mail.gmail.com>
Subject: Re: [PATCH] net: bnxt: fix a potential use-after-free in bnxt_init_tc
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004404f3060bb3ed5d"

--0000000000004404f3060bb3ed5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:56=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> On Mon, Dec 4, 2023 at 8:11=E2=80=AFAM Dinghao Liu <dinghao.liu@zju.edu.c=
n> wrote:
> >
> > When flow_indr_dev_register() fails, bnxt_init_tc will free
> > bp->tc_info through kfree(). However, the caller function
> > bnxt_init_one() will ignore this failure and call
> > bnxt_shutdown_tc() on failure of bnxt_dl_register(), where
> > a use-after-free happens. Fix this issue by setting
> > bp->tc_info to NULL after kfree().
> >
> > Fixes: 627c89d00fb9 ("bnxt_en: flow_offload: offload tunnel decap rules=
 via indirect callbacks")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net=
/ethernet/broadcom/bnxt/bnxt_tc.c
> > index 38d89d80b4a9..273c9ba48f09 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> > @@ -2075,6 +2075,7 @@ int bnxt_init_tc(struct bnxt *bp)
> >         rhashtable_destroy(&tc_info->flow_table);
> >  free_tc_info:
> >         kfree(tc_info);
> > +       bp->tc_info =3D NULL;
> >         return rc;
> >  }
>
> The other way could have been to assign bp->tc_info only after
> flow_indr_dev_register succeeds.
> But this one works too. Thanks.
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

I think this is the correct fix.  flow_indr_dev_register(), if
successful, may call the driver's call back function and so
bp->tc_info must be set up before the call.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000004404f3060bb3ed5d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILzul8P1C0v4hBV+kH5pDXFQ53AAUoGc
oouk3UEEi38rMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
NDE5MTQyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCBZ3pFJr6LrvcKLj7740HA/5ZQAtNARAoFFiM3q+Vcp5RzPQgE
Uxf5c+B41ZhbfX/KeHYyxHd0Xgpeeq1FC1G2zJRa8hfAdkoB7++vyH4mRvwefjECp/BXfxxKdH7Z
GxdTh64zie21kE75EIn800L7YEBN81RsxEathi57mbP4H1ORC2l2avG6LIaDf7TKpr9FVdzjJfhB
ESile42eu/eXhE7RQTQYQKKActzz2SL/uPr0/T3sGoYmk6+OR5plTJLC2MqmIbkI+6Tfg/Y511gl
4pBYZMQg9QMWgZgBg65NPkUlMpenPBAciHBWDjkP5rFQ4/pmGISaHmDxpLwJZMce
--0000000000004404f3060bb3ed5d--

