Return-Path: <netdev+bounces-52990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBA80108F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8C1C20D78
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB74CB42;
	Fri,  1 Dec 2023 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gAZcSPrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4609133
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 08:51:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9bbb30c34so29613111fa.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701449460; x=1702054260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xSODv0MdwyNhhNSG6HLoVvQ0QgrHrRPEvnyWi3lxLKk=;
        b=gAZcSPrbxfsNuE+ejjfBxH3EzWg0z8H2vtzmSEWtxDvH8QNMMnJIc5sAkeWIkbRsXW
         LQcLvammv0V2BB3HdBz4wGOHuQ8q2MBgUszqHi3HjaiP2ZSJmVks5L71lR4EkA0Z7766
         sHtNJYGo0uEsAJX1F0q3sbxnMcrTTbf182Z8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449460; x=1702054260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSODv0MdwyNhhNSG6HLoVvQ0QgrHrRPEvnyWi3lxLKk=;
        b=UKv4AbCGGvLt7JFi0linK7e1IqPxjl+9H+JnYDGgMTiK4GcmfQZamw1kCTOpNeHBZw
         6YfUJCgEGEh98DJ54K2xBJ1yLbR+jeI3V0VUbceOlTpE7LYRUKYuNQ4Hp6g5uJ8oeklE
         RU7CyV7HCYAZU4ic19cfyteUvsVk5eFwDIYjigW33+fQa98c9m790kRFvNGpYIPMqOa9
         gS2lHNXr0kIsSsZdFUwVI5YU7B1j+TfkpeU65iFXrLl47lQ7D7huGYU9slfiwEbKGb9Y
         j78fszw0a2ez8H03Y6Kn7b3DiIorbODWH+UgA7W79U+0aydmuOu8U9alIVxLan7g2VId
         Os/A==
X-Gm-Message-State: AOJu0YzBkE91+X83kTLcgpZCnpLJgiV4Fjwt/81yWAbsmMfHg04zihI6
	5T8JT+CctWLAQy7uJLV9s/UR2HNlQaINHOWL1vUAUw==
X-Google-Smtp-Source: AGHT+IF9SxXNZ4p2VmkObse++BbngfHUGjeBQ5Yqe7u/wlIf9h60EETIQ9Fu1lbdmYAGpXOS5x2hl/cHwX16NvKYHT0=
X-Received: by 2002:a2e:8811:0:b0:2c9:b95e:8694 with SMTP id
 x17-20020a2e8811000000b002c9b95e8694mr1082297ljh.45.1701449459705; Fri, 01
 Dec 2023 08:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116151822.281-1-thinhtr@linux.vnet.ibm.com> <20231201001911.656-1-thinhtr@linux.vnet.ibm.com>
In-Reply-To: <20231201001911.656-1-thinhtr@linux.vnet.ibm.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 1 Dec 2023 08:50:47 -0800
Message-ID: <CACKFLimyFoPS4H9j+L+p26uiPXCuz1rY5ihVKmJ++SgCE8i4fg@mail.gmail.com>
Subject: Re: [PATCH v4] net/tg3: fix race condition in tg3_reset_task()
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: davem@davemloft.net, drc@linux.vnet.ibm.com, edumazet@google.com, 
	kuba@kernel.org, mchan@broadcom.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, prashant@broadcom.com, 
	siva.kallam@broadcom.com, Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ae582e060b7592cb"

--000000000000ae582e060b7592cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:19=E2=80=AFPM Thinh Tran <thinhtr@linux.vnet.ibm.=
com> wrote:
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
> tg3_io_slot_reset() and
> tg3_io_resume() fail to
> reset/resume the device
>
> To resolve this issue, we avoid the race condition by checking the PCI
> channel state in the tg3_reset_task() function and skip the tg3 driver
> initiated reset when the PCI channel is not in the normal state.  (The
> driver has no access to tg3 device registers at this point and cannot
> even complete the reset task successfully without external assistance.)
> We'll leave the reset procedure to be managed by the EEH driver which
> calls the tg3_io_error_detected(), tg3_io_slot_reset() and
> tg3_io_resume() functions as appropriate.
>
> Adding the same checking in tg3_dump_state() to avoid dumping all
> device registers when the PCI channel is not in the normal state.
>
>
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
> Reviewed-by: David Christensen <drc@linux.vnet.ibm.com>
>
>   v4: moving the PCI error checking to tg3_reset_task() and
>       tg3_dump_state()
>   v3: re-post the patch.
>   v2: checking PCI errors in tg3_tx_timeout()

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000ae582e060b7592cb
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFYwl2PusEUOMdzcs9pDbDCZ90j8nEIx
gqE+COVC06/WMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTE2NTEwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQClCVVUbTqjExOMuMchWnOCDKX7XPSFtIPZxJlr94QZRkWQY8WW
xLPz4jO/OYw0b710nqDxxi9EJGCA9jAM2UU5EF9MXu24svOYGZRdT4iMOi5J8Qnq6sZ7A6hE7UFo
Zdln+iiDCCAN+cnsFa7BWUs13OWMQHOsvFN1b4OmzBm0jb97X6D472YFVboe/7EnvIhihBOdrzRs
S+b0TpCNNoCm0s963u7i000ehSShcKdfuUXmMTkhFySFsnlAfhNgWC5HDnbhTAXR9Bh3/dtu78Zq
lR2UgYFzOxL0428EPvumLoKVMPrsy1VdkVF2ggVrW/OImSwZTOGTyBEdh9zd9Xej
--000000000000ae582e060b7592cb--

