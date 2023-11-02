Return-Path: <netdev+bounces-45783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A2E7DF8B1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A63B211D7
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775C200B7;
	Thu,  2 Nov 2023 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IlLpq4q2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7C6FAE
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 17:27:46 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229A123
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:27:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso196477566b.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698946060; x=1699550860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAdEHo549a9UhaHA8u8MIvABqDPM8hD8NLbt41iBBY=;
        b=IlLpq4q2ia+v6klB605LJ6I5TVXnmI5qGSMjmnztZb4jGLLLwCShoOYTwmeqDhoZ1i
         v1xepNvy6Ac1f/HrdPeqOMGiBF/s+Sl7v30fZH6HVkgePuFM4xFs37n51zb7e8YrHGNb
         FvjftmzLBSaWe5WmJ/IehtwEarFc8k7GP/gwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946060; x=1699550860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VAdEHo549a9UhaHA8u8MIvABqDPM8hD8NLbt41iBBY=;
        b=GCDrb9mTJtUTZjFwHDLJdCUcuQXVPHQJBf0r9ZkzGIYRXL9vQsmcHT40EK32K+S8Mx
         d11RYainBuN7e/qhc24H3RzXxEGKTdp0IY2FGq7FRxq2IA2Qarw9jk7usz38ZtsoU6Uy
         60n1j8P09OIT0s4M3vACSSc96Ytr5B6xoTrTXgavqYHSYAX3Dw4TJjObllrDmxy1mV76
         UlinrqKLeTYsEYNn/IRUWAN/m4zrlK/3IJvQ+bQ8FEoqB3OPUOorM1XK27qMRF/VPQAz
         8avhlWXNU7OXiQOk9apSTEmUupJM0WAfyyOA7UFnN6CguOux3gtgPxaYAJ5wBkttuI75
         un/Q==
X-Gm-Message-State: AOJu0YzXOQ5eGeiQmH1T9XSIXMlFNBjM5PbT5X86a3aG2r5dUD+iWRsW
	ZTIlZAamZvpoXotadtUvmchPjtGAkhf/nh9VnJwHRw==
X-Google-Smtp-Source: AGHT+IH7GNAB6dQUBkWxSRo9t20RtcTVZ1UCivZ5MyBW3cdUGBbKTsNVa76mUIKX3o7CEH4nelLNITBdb5gG9ZwRlXU=
X-Received: by 2002:a17:907:9714:b0:9be:6395:6b12 with SMTP id
 jg20-20020a170907971400b009be63956b12mr6159750ejc.27.1698946060045; Thu, 02
 Nov 2023 10:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com> <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
In-Reply-To: <20231102161219.220-1-thinhtr@linux.vnet.ibm.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 2 Nov 2023 10:27:27 -0700
Message-ID: <CACKFLimX4Pjm89cneeTa36B519DN3mdXXo5FXfDFi6e0SBwUSA@mail.gmail.com>
Subject: Re: [PATCH v2] net/tg3: fix race condition in tg3_reset_task()
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com, 
	mchan@broadcom.com, pavan.chebbi@broadcom.com, drc@linux.vnet.ibm.com, 
	venkata.sai.duggi@ibm.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e1d2306092eb400"

--0000000000006e1d2306092eb400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:16=E2=80=AFAM Thinh Tran <thinhtr@linux.vnet.ibm.c=
om> wrote:
>
> When an EEH error is encountered by a PCI adapter, the EEH driver
> modifies the PCI channel's state as shown below:
>
>    enum {
>       /* I/O channel is in normal state */
>       pci_channel_io_normal =3D (__force pci_channel_state_t) 1,
>
>       /* I/O to channel is blocked */
>       pci_channel_io_frozen =3D (__force pci_channel_state_t) 2,
>
>       /* PCI card is dead */
>       pci_channel_io_perm_failure =3D (__force pci_channel_state_t) 3,
>    };
>
> If the same EEH error then causes the tg3 driver's transmit timeout
> logic to execute, the tg3_tx_timeout() function schedules a reset
> task via tg3_reset_task_schedule(), which may cause a race condition
> between the tg3 and EEH driver as both attempt to recover the HW via
> a reset action.
>
> EEH driver gets error event
> --> eeh_set_channel_state()
>     and set device to one of
>     error state above           scheduler: tg3_reset_task() get
>                                 returned error from tg3_init_hw()
>                              --> dev_close() shuts down the interface
>
> tg3_io_slot_reset() and
> tg3_io_resume() fail to
> reset/resume the device
>
>
> To resolve this issue, we avoid the race condition by checking the PCI
> channel state in the tg3_tx_timeout() function and skip the tg3 driver
> initiated reset when the PCI channel is not in the normal state.  (The
> driver has no access to tg3 device registers at this point and cannot
> even complete the reset task successfully without external assistance.)
> We'll leave the reset procedure to be managed by the EEH driver which
> calls the tg3_io_error_detected(), tg3_io_slot_reset() and
> tg3_io_resume() functions as appropriate.

This scenario can affect other drivers too, right?  Shouldn't this be
handled in a higher layer before calling ->ndo_tx_timeout() so we
don't have to add this logic to all the other drivers?  Thanks.

--0000000000006e1d2306092eb400
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIACNS9r+8vGXKZ8PbUYIipm8UCjvu3Wg
Zrs297ngBjqTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
MjE3Mjc0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCjV8+S3Fyj+/nzKDahDJS9QeKDTYizlkMmkunfyvhKB5Fc7m81
lFK3z+taxFyaWeUX1H9EmzkvGs7jymfJ/ICdzq5PfzaNLHG9HSkhd01kfFxwjtBehO2k5B+ZUA/j
pRf106Sy6fWDi5+6p8UYT1YF0IHdNgtIu+6sWwNWRuM6KbVvPicQP3Rj6VyRCv3fYNtI/KaaFNEt
7zbtuGU2wFwiVthUa3qQy2V47gQAShA0tNXRZSEOmVYzZfVWYM7MxhvgfQK2J0v7FHiZlNUyJf9R
cnjIql28HkU2PaSMKoMEQLfpg5KekW8Jqhdd7wKgZkRE/Bh/jDxhYsbpC4mUlTqZ
--0000000000006e1d2306092eb400--

