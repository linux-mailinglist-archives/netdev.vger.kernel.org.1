Return-Path: <netdev+bounces-48774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2C87EF77D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709EFB20A56
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1866D2F8;
	Fri, 17 Nov 2023 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q8jIC8bW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001FB0
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 10:32:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso3379845a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700245932; x=1700850732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5djxJ7lim0htZrHNsrHBFJdIw4dz6vbdkQejIznm99I=;
        b=Q8jIC8bWxJuGY6cvRj+z+udGXYFlPwhAdBt9bgkJrbRNgA2abNqtEf1Z3c6eoK+2Uy
         kz5SVS9y2GSge2+UYooRDtFMMUHFWMR/1ZIhc6DvrpMW+3sijnYLpOnLjpdRm3hSyvwz
         n20buRMaJtYwxPbkHPC+CuQGErTjVs+L4HnE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700245932; x=1700850732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5djxJ7lim0htZrHNsrHBFJdIw4dz6vbdkQejIznm99I=;
        b=VQaaNnPVF3EuOsU/8hzElxwGoiWmRpCdzis2/pkOQ3Y0cs2GZXcy3LBBz9Tk5/xaYc
         krZqisFfH3wQH/tTDr5wXsunJvxZqQ7TjMMmvjYsES9MgQdRckuNoDCEiB11hXVKOU0J
         mJG0ureOVE3I+l5EIue6/2056wPK3E1Wk0TSP4OMjh6cIDXSkqRkswnD4lCp+YDMFWLK
         h0eAk6AVGrVaRMDWTkFBvXpJbPSUI9dNQyJz4WfnhvzSP0f8C4ZzXUrz0o2y53s8doFV
         wcj1O4OQEi1ITYXne1KNTV/SlJPQPymQh3Dap3oL7QBr2G9jP84L9W/Cg6wC85TwHqDJ
         3Vnw==
X-Gm-Message-State: AOJu0Yw/mCMGXkbIU6QMWYCdAzuLg1jXMRskMeDWhoZOvIDezglQICvq
	4x3+XNOBPrvsNUEz4Rq1fiSRtkDEQMuYsnoJ+a6HoQ==
X-Google-Smtp-Source: AGHT+IHpf+WL9j8czRkCqBT007keMPEoF5vUiynZjb8yGwqDoN2YhTagJdj7pnJ6BdQnrVhrgkH3Zib8QpD7jCqf0Dk=
X-Received: by 2002:a50:ba8d:0:b0:543:5f7a:9e27 with SMTP id
 x13-20020a50ba8d000000b005435f7a9e27mr32784ede.12.1700245932168; Fri, 17 Nov
 2023 10:32:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
 <20231116151822.281-1-thinhtr@linux.vnet.ibm.com> <CACKFLik9h4pOPWtyaOutRwnwE+KEyO+50Cf+dMknvR2ybONTzQ@mail.gmail.com>
 <cf143e97-5303-42e3-8a27-3226a6bf7c9b@linux.vnet.ibm.com>
In-Reply-To: <cf143e97-5303-42e3-8a27-3226a6bf7c9b@linux.vnet.ibm.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 17 Nov 2023 10:31:59 -0800
Message-ID: <CACKFLimqMzw4wHT7BLY3v9VYtX0Ax=Xj2efd0hnXKf4A6bouZg@mail.gmail.com>
Subject: Re: [PATCH v3] net/tg3: fix race condition in tg3_reset_task()
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: mchan@broadcom.com, pavan.chebbi@broadcom.com, netdev@vger.kernel.org, 
	prashant@broadcom.com, siva.kallam@broadcom.com, drc@linux.vnet.ibm.com, 
	venkata.sai.duggi@ibm.com, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d8ebc4060a5d5a0d"

--000000000000d8ebc4060a5d5a0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 8:19=E2=80=AFAM Thinh Tran <thinhtr@linux.vnet.ibm.=
com> wrote:
>
>
> On 11/16/2023 3:34 PM, Michael Chan wrote:
> >
> > I think it will be better to add these 2 checks in tg3_reset_task().
> > We are already doing a similar check there for tp->pcierr_recovery so
> > it is better to centralize all the related checks in the same place.
> > I don't think tg3_dump_state() below will cause any problems.  We'll
> > probably read 0xffffffff for all registers and it will actually
> > confirm that the registers are not readable.
> >
>
> I'm concerned that race conditions could still occur during the handling
> of Partitionable Endpoint (PE) reset by the EEH driver. The issue lies
> in the dependency on the lower-level FW reset procedure. When the driver
> executes tg3_dump_state(), and then follows it with tg3_reset_task(),
> the EEH driver possibility changes in the PCI devices' state, but the
> MMIO and DMA reset procedures may not have completed yet. Leading to a
> crash in tg3_reset_task().  This patch tries to prevent that scenario.

It seems fragile if you are relying on such timing.  TG3_TX_TIMEOUT is
5 seconds but the actual time tg3_tx_timeout() is called varies
depending on when the TX queue is stopped.  So tg3_tx_timeout() will
be called 5 seconds or more after EEH if there are uncompleted TX
packets but we don't know precisely when.

>
> While tg3_dump_state() is helpful, it also poses issues as it takes a
> considerable amount of time, approximately 1 or 2 seconds per device.
> Given our 4-port adapter, this could extend to more than 10 seconds to
> write to the dmesg buffer. With the default size, the dmesg buffer may
> be over-written and not retain all useful information.
>

If tg3_dump_state() is not useful and fills the dmesg log with useless
data, we can add the same check in tg3_dump_state() and skip it.
tg3_dump_state() is also called by tg3_process_error() so we can avoid
dumping useless data if we hit tg3_process_error() during EEH or AER.

Thanks.

--000000000000d8ebc4060a5d5a0d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILydaLrq5DPcMSr+/FHEL08eXYpiSKrh
x+AkzYp2HP6qMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEx
NzE4MzIxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCYO12ZI2F2rAJgbamLZY4teu6RhdsPMaTG5bokUV9xU6odiF77
PpFvxrEg0oQp2AJJtpyK1GSOdjKCNO5DS3KzorhjRS7huT+XJVehG8weSUbcIy2GZfpGKQjAI1W1
EHx8rokio9PG1O8o4/pgoek6te45TNNfjIsT9xoSKyjpcD3PgocycXWk0hts+mLtdomziymIJwXK
bLjDSaE0RESvERJD+6t7L5hwFq4qbqo3zXjUGVr43so+4NcsmNmm3MYLFrippBxXVWBDVQJ0sE8+
nxyyDng4gobn0QWRhtIidzzaVYKJutu4OYYyxEggsb3Wwaw9SJQm+SRXHc6WZARQ
--000000000000d8ebc4060a5d5a0d--

