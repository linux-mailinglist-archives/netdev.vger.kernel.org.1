Return-Path: <netdev+bounces-291527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLlfGiEWFWpoSgcAu9opvQ
	(envelope-from <netdev+bounces-291527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D66455D0670
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3D96304860C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4F53BA249;
	Tue, 26 May 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pmk+3Lh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4243B2FE6
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766658; cv=none; b=fAvzgGGrSRLZdHgo4NRQYQWNsfBBufSZS64dMWaOCBXE1hXNUgjpJc8W8+J8cdL/tSJhzjvThXrJFmjFxQWK+aOjnWZBLAJMei0t/bGjL85gGPlNavH5qNXgenzmBxTDNzhhPRBchQPHBAilH1Nan9/rUwvhK0w8jdoYux6ySbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766658; c=relaxed/simple;
	bh=bGQlDNgGOSef7J/2LxJi7wjJWxPYlxKfnJzZN9PKnVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsPNWT7MGgqbjYzJnDaLSBE3cwOnUiR4aoPJfLL+ZyYoO+GJANYrWjYSpbz9IdIcOl6yK+Mt/LksSEs9w4MFxxlNAiPx94iU/cvXAyVPfqT0lPcrWrKvxmaCa9T9vMdCMPyfj2dXdtwkC/+c+04uHQ2f/9gn7jkGpfvE5WdOENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pmk+3Lh7; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-43bf95c1faaso394381fac.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779766656; x=1780371456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qa/waU9ZL+XF7EOKbLxT5xE9+7/fpaPEa1bGbzaWN7k=;
        b=dn7GD5hLUINleh+ZEzEO/Bflyd3Uy3Ni8qFzirP3RAtKYL57ewzfGySsiHRlFu13Gz
         2bMlc+ezMYWZikZyl0nmfxTKWiYvDVZXJ0Xl5OP4qYhZ0AjmP/KGIg3iCV3ZwAglZTq9
         PrN1l7cUIDZ7d0fDg8Plq+ZD/fncrcSbFLPcPwAY9Suuu7Ped/oG/YFD29ehyUPTnpUS
         wNgdF6Tvq+nqXcREZeWPBcg/3xnFNHw4iNBtQAP/h7lTZ+D70XvC8XZK0J5jWPATd6HZ
         89usGy+0H0AcOwsFMq0El1V9XSHO/sqbMUc0Ak8dB9hcGXOWg5I6a4XcSt8o8V2hYNWE
         Kr4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9RiUiz5zNDv+EjTLb+lKZGV79NuJEAQzeEvUUf5YLhvPwmpl3COyQAIHojb49dRIlHZf081M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEMB2LgovVL87T0uLb4tPdHotTxygL8K6EzrZ+v6176ac93U1
	tZtXefYX4IpucqQpD17kiMz5JoLl4tWHld6yly5Ga5YeSzNnnSTuUUsy8l3HpVWYRR6M03atMib
	kDtwGBvso6OA2XhhutaiCR1ZjKzXU1dmtfMHGBW5Vcwdn6vCfDPRc5t9ZpKP5ISswrPRq2jvjSZ
	Q/cfKI4u2HIERq7UoDYrDe5NQL/lDPPYoUkiJKUYzFzmilglTeXs7d3Z2GiyZC9gLwiodfFZaeG
	bUyaD6eSNHvDg==
X-Gm-Gg: Acq92OH/e3H5DuoNwwzabVkPe5WqGy4dwmyn6z+VcFz2NEs/PqxGxxX44VQICYlV+dA
	t2nUWLl2v6VZJZO07doBnoOePW4q7Fpv3Hfo3LMmrY19LunLy5IPxmQ3I5bdR+k/4byBWYMamIx
	a/FbYRJT8nTYA/SlmaMGlBp4n6A0c0qCztWDb2LybsaXr7XMuplk+r/QdSRSzOnHbMrUbwx5jys
	xNKF7DPH26hxdCsZVjWVo26H6eZBBd9ssjH0v5vMicqSOurnU4ddCxH0O1SoLJ12LT2/0cHqqpn
	L2qlpnePid3A6IkSJo2PjSaQEqmju6f4m0ZT7FkbnFNLRQxAs5SvV+NI4gZ6mmN9fssT+BDjsX/
	/PHmLEzwT1IGz+etZWz8kB/RXU2HGrCRf33PefOVTKji1V9UIfs1+Fu6rna1m1/7mQKSODUd72D
	7RM8QlIJZPKtd4GlopBsp/iJIXcLMyBbEbEyKlq5zOg/qcmfzH8N/IZpahq+Y=
X-Received: by 2002:a05:6871:339f:b0:433:d14c:2416 with SMTP id 586e51a60fabf-43b5aa375ecmr10119589fac.7.1779766655576;
        Mon, 25 May 2026 20:37:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-43b6362cf3fsm1509771fac.6.2026.05.25.20.37.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2026 20:37:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-be2ac42926dso31612166b.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779766654; x=1780371454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qa/waU9ZL+XF7EOKbLxT5xE9+7/fpaPEa1bGbzaWN7k=;
        b=Pmk+3Lh7i64GMTigjsZNCi7w8+Zb3nojQe0akM5i9sZGsCdAR2GWcHR7TGJE4QvBbY
         uUy52rNReREXqq94VzISWEYoezROMX/KJatbFgDiKo+0LBPOn+7gBe5++srdc44Xis2t
         HqiMKYsZxZCivDOaV0IkrlJwyEn7Og5YFlZ8Y=
X-Forwarded-Encrypted: i=1; AFNElJ/6+KIZBKXgQik4ZaU+nwG4ffGpp8APAheaWJpTq+BAInEVqxmNECrxY8tTBEfbMHjqfJNNUw4=@vger.kernel.org
X-Received: by 2002:a17:907:761b:b0:bb8:fdf7:e132 with SMTP id a640c23a62f3a-bdd25ced638mr733102166b.18.1779766653731;
        Mon, 25 May 2026 20:37:33 -0700 (PDT)
X-Received: by 2002:a17:907:761b:b0:bb8:fdf7:e132 with SMTP id
 a640c23a62f3a-bdd25ced638mr733100866b.18.1779766653162; Mon, 25 May 2026
 20:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
In-Reply-To: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 26 May 2026 09:07:19 +0530
X-Gm-Features: AVHnY4Kv5ooRoUDxWNyhaMdg5tHK_sbCGS1pwivVufGHCdiYtkUGFo9R1FsaXWw
Message-ID: <CALs4sv3D5n7pciO_1G+XjxNi-YSdM98t2hTHVM7b=c4Dpa06ng@mail.gmail.com>
Subject: Re: [PATCH net v3] net: tg3: guard napi_disable and
 pci_disable_device calls
To: Yury Murashka <yurypm@arista.com>
Cc: mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000330acd0652b0375b"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291527-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arista.com:email]
X-Rspamd-Queue-Id: D66455D0670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000330acd0652b0375b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:19=E2=80=AFPM Yury Murashka <yurypm@arista.com> w=
rote:
>
> During PCIe hot-plug events, uncorrectable errors can be reported and
> AER recovery for the tg3 device is initiated by the AER kernel driver.
> The tg3_io_error_detected function is the AER error recovery handler.
>
> From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
> will be called. But AER error recovery can fail. For example, when one
> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
> device is disabled and NAPI is disabled (pci_disable_device and
> napi_disable are called from tg3_io_error_detected). Then we can try to
> disable PCIe link and napi_disable will be called again:
>
>   napi_disable+0x1b/0x1b0
>   tg3_napi_disable+0x89/0xa0 [tg3]
>   tg3_netif_stop+0x37/0xe3 [tg3]
>   tg3_stop+0x30/0x160 [tg3]
>   tg3_close+0x2a/0x60 [tg3]
>   __dev_close_many+0xad/0x130
>   dev_close_many+0xb2/0x190
>   unregister_netdevice_many_notify+0x19d/0xa00
>   unregister_netdevice_queue+0xf8/0x140
>   unregister_netdev+0x1c/0x30
>   tg3_remove_one+0xaa/0x150 [tg3]
>   pci_device_remove+0x42/0xb0
>   device_release_driver_internal+0x19c/0x200
>   pci_stop_bus_device+0x85/0xb0
>   pci_stop_bus_device+0x2c/0xb0
>   pci_stop_bus_device+0x2c/0xb0
>   pci_stop_and_remove_bus_device+0x12/0x20
>   pciehp_unconfigure_device+0x9f/0x160
>   pciehp_disable_slot+0x67/0x100
>   pciehp_handle_presence_or_link_change+0x77/0x350
>
> This is not expected by napi_disable and a thread can be locked in
> napi_disable forever. We have pcierr_recovery to cover a similar issue,
> but for fatal errors. We cannot reuse this flag because it is reset in
> tg3_io_resume, but it is not called when AER recovery fails.
>
> Similarly, if an AER error is reported and tg3_io_error_detected calls
> pci_disable_device, a subsequent device removal via tg3_remove_one or
> tg3_shutdown will call pci_disable_device again for the already-disabled
> device.
>
> Add a napi_enabled flag to struct tg3 to track whether napi_enable has
> been called. Guard tg3_napi_disable() so it returns early if NAPI was
> not previously enabled. Also guard pci_disable_device() calls in
> tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
> disabling an already-disabled device.
>
> Fixes: b45aa2f6192e ("tg3: Add EEH support")
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
>  drivers/net/ethernet/broadcom/tg3.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
nit: The revision-change log for the patch is missing..

--000000000000330acd0652b0375b
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBWlg9x
Tb5KVAq5oS+d/yV1uim6C8IgL5btSn3g5MkGhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA1MjYwMzM3MzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB89rFufRTuROsB49HO9M1YD5Kb3YfgMZIZOCjoDJGZ
brpasEXqNrxkExEm2vXfTtblj2zgF4uqdu1KxjWM0bklsLIs+W26PUHrMfyyk5e/TLZA3+OSiRAo
2rDse+SbjS4CvgLuteDLX9rzDiwKv0oT8hgxr/E27MNt3kk2wvWyM4i7Ifg7Pp7oamtujHvUDN+B
uV1lWQtwXVsz6H/BXYj9jMCVjpOovUOJ4jL5P/nv+LefOItqeIkucePzJY0o9hmijFo61Rk9LDvd
UnhxFhSzyp079seBJZeK5p9kWnwT6H1c9B+vqQQ9hiq0Q0jsSv+FQdkLJoDQcFbynmUoCXan
--000000000000330acd0652b0375b--

