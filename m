Return-Path: <netdev+bounces-28325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D177F0E5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535D01C212C0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3A138A;
	Thu, 17 Aug 2023 07:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94733137D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:08:44 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9D7272B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:08:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso11498610e87.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692256120; x=1692860920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mR9a4IgjdDbo1SXRlgmBio+4IH69pTj3MPL1XRMl63I=;
        b=ObVC3M5paqEs731vcDsTnWi6GH3XdZ1hGfGQjHod8/roeynrttoHo1ogieYtcJRfrn
         jW+mj6YTegdoBv3pndCpjkzGO77DrxO3okJ+8ojy7MOz8l2HoVQ5WAuZaylMIguwvtgP
         1nFpno9rax9Q95EsYgE/RuJAZF9jpwZuBSDzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692256120; x=1692860920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mR9a4IgjdDbo1SXRlgmBio+4IH69pTj3MPL1XRMl63I=;
        b=PUWYCkii4hcz4g+FQWIslxdCjzQW7kL+3Y/KzZ76oFcniKmHUswlyFXLpy6/o3rkOA
         eN9p8T0E/n8cCJ5ePimp/brf3H4/6/k07CsFANUE6R+5ky1/2Lpi+PoC4azbcOL4pQmg
         9IpmacRDJiDllPV/kYfVVDvTjg9ky2RJQFoi7KVoMdkA+QPkNricYyCYc/80auOXRsle
         fA5FR7UB605jRcZvf5Nm2Ko4g6qSda3yKdtKfKWA+57lUVrSpK2R+rIBYIa7bf2ItGpQ
         s74rD48vJ4vghsSzAlrBrvURd8omnk8pJxvX7+CJTeWKleSir6owmmFzd7pHfpbIhAJa
         L+sw==
X-Gm-Message-State: AOJu0YzQ5XwPyCO7+m9tCwioI2Vi0GvSNcD43fswrPpHi3mB2VB9WnIh
	A0MiCOhh8AMfoTlScFT75/zXpH5A+IxdGGpR1895IQ==
X-Google-Smtp-Source: AGHT+IH6UhHKLOHwfcB1tjkMP8tOOKNqBmFtrwYBRFvwY/j89e9ak2qcu9i1rfqwvc2Ug72Jz3VzFrDaseXNCL3FQDA=
X-Received: by 2002:a05:6512:36cb:b0:4fe:7e1f:b044 with SMTP id
 e11-20020a05651236cb00b004fe7e1fb044mr3360618lfs.15.1692256120290; Thu, 17
 Aug 2023 00:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMGffEm-OUf0UqeqCbcWM8j1q1EaSObEUGFPZqFsH4sKGkis8g@mail.gmail.com>
 <20230816200120.603cc65a@kernel.org>
In-Reply-To: <20230816200120.603cc65a@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 17 Aug 2023 00:08:28 -0700
Message-ID: <CACKFLinLofP3Ck03Vvs82_z4mhAfincF_qGFL=dKXKXOJTksdg@mail.gmail.com>
Subject: Re: [RFC] bnxt_en TX timeout detected, starting reset task, flapping
 link after
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, netdev <netdev@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f33d6906031914c4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000f33d6906031914c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 8:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Aug 2023 20:51:25 +0200 Jinpu Wang wrote:
> > Hi Michael, and folks on the list.
>
> It seems you meant to CC Michael.. adding him now.
> I don't recall anything like this. Could be a bad system...

I agree that it could be a bad NIC or a bad system.

>
> > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251006] bnxt_en
> > 0000:45:00.0 eth0: [0]: tx{fw_ring: 0 prod: 1e7 cons: 1e4}

TX ring 0 is timing out with prod ahead of cons.

> > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251015] bnxt_en
> > 0000:45:00.0 eth0: [2]: tx{fw_ring: 2 prod: af cons: 9b}

TX ring 2 is also timing out.

> > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251022] bnxt_en
> > 0000:45:00.0 eth0: [4]: tx{fw_ring: 4 prod: d4 cons: d2}

Same for TX ring 4.

> > kern.info: Aug 15 12:22:32 ps502b-104 kernel: [326009.251027] bnxt_en
> > 0000:45:00.0 eth0: [6]: tx{fw_ring: 6 prod: 63 cons: 120}

TX ring 6 is ahead by a lot.

> > kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.874938] bnxt_en
> > 0000:45:00.0 eth0: Resp cmpl intr err msg: 0x51
> > kern.err: Aug 15 12:23:33 ps502b-104 kernel: [326019.884991] bnxt_en
> > 0000:45:00.0 eth0: hwrm_ring_free type 1 failed. rc:fffffff0 err:0

This means that during reset, we're timing out when trying to free the
TX ring (type 1).  There are exactly 4 of these type 1 ring free
errors, probably matching the 4 TX rings that timed out.  There are
also 7 type 2 (RX ring) errors.  This makes some sense because by
default there are usually 2 RX rings sharing the same MSIX with 1 TX
ring.  So 7 out of 8 RX rings associated with the TX rings also failed
to be freed.

> >
> > I checked git history, but can't find any bugfix related to it. The
> > internet tells me it could be a
> > firmware bug, but I can't find firmware from Broadcom site or supermicr=
o site.
> >

I will have someone reach out to you to help with newer firmware.  Thanks.

--000000000000f33d6906031914c4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII+tl8yCkv5yDLC5ZC6twlkKRgkJslss
YfX+OhelCP2AMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgx
NzA3MDg0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBiEglLOsaYrYdcHkXi0zH3VNEXchMWjrQIOTOwbuFrH3cOI8mw
ChoOSwbxh5ATvisWjD8hgm6ts2mswYCwRWPaFuEoYYtQHoeaeUHe6/15Pscy5HS12JIjK/iheIie
3zv5JKfDo6vxTYIlOVAdzp7DX6nVhdiSEmX3tv0uZ42KNd9ID5fA5U5xVzd8QJ4M2fmVFixq5td8
PmwlSaRyVljii8UyCrjq/0eoWPzIfUOI/w2BoDHAg42FnMR0VnaGPFFmnUd0c8wKjqpc1fGMGAYH
FMWlcCkcsAlXG53KUDtW0ibi4ww3hgyw365WMw093kAmvvXzvtmepSoXBd27UywL
--000000000000f33d6906031914c4--

