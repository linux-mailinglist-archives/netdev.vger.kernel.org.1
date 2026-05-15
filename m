Return-Path: <netdev+bounces-288349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFkEM6hJB2rUwQIAu9opvQ
	(envelope-from <netdev+bounces-288349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC55533DF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4CA308B201
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCD3F86F1;
	Fri, 15 May 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gTqYRSVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com [209.85.222.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5173F86E0
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859793; cv=none; b=QRMlcIiSTveLWbGOq1ffocCVUTcxF7ZsCmiJEBR8BhPVCjoJmS+NpvRHk2tVAo6zbuTU5A4w7EBJ7nogVPDH84E81u9Rgz5ll5D/WBvXUXTrnpTTPIs5u8qg9om05YfqHeY/zLndeG6Gd2RVyCGrq2hCSUrnIs9Aved1cH4qCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859793; c=relaxed/simple;
	bh=tbXz/lzH6z3k6PGqjpnZJfaHRLvJP6rgXidT9grO6TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWEyTzr0hcxFnUPCdDqSZmHSAtGewE9oBYT3pizpeP0Mm6R4QRBTdmlNjMH6xadj5yV7EGLfWgLSVVQRP1yV+W7EH9Pb0LJz0lPhURkhCHpblU+QRLqm/LJ0MExm2GsCFt0pnUxG14QUirow2zLKD3uTH9KpYoAbXBqRSr33jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gTqYRSVU; arc=none smtp.client-ip=209.85.222.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f100.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so4987366241.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859789; x=1779464589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6gzxD5kgIq9g46EZ1vuJlw1O9O9Cl6K8iNSnqRp2g0=;
        b=XDrHrkOGdJw/ZNgS47rfvCCdJ5qLLUCo1FoYqAoM7DSsiZdBqzQZmmm1pBEVXnJvRi
         Xr9o+mVjHQ6mimdxu9x1by6VOUz2jMHfbMVOB0OwD/0NPkPtCpW+Fg7VUOnWjkKAVJMu
         ZIA2NHHV+PDLNtvWIm5y3QqJcghLebfQRzFCKun4XreAJvLYqYfZDVEYaprQpKC8O+ST
         ZkhBbuf/UFalgCGMHjMm+FneMRF6Td0ldwfL5fql5kAOqOm8xtibVK2nOZ+vd9P4odVf
         zmY5BLrrSnU0/QrsvmVfbdeWNJwIJSxCOyiAbWt96IoDAdrT5ADdjtYUnxRU9CpCIrvv
         Lhvg==
X-Forwarded-Encrypted: i=1; AFNElJ9rsnJUHEig5nXz8fFv4MJK1OBEXxL7Dnh3G2pe2YuEhs13+ADah5iu9LTiRtV0F69vTaDs6tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5mCe4H5ep+Yu3DN6feuKQ3kstI9naGdpFnSPc6mXDpWDXrfE
	89FZFe2jAj1SFMCVAgi6ddTlSz14OWHH/sG8EVh82tOVBNe8SgDtWfnd2uawXZAbIyuXHoTc3J6
	PbB+DyyROTx/8WSnCyf+woiT3L4I6eua46hcT5gocTqpjMw3kjTUnf93L1plozhK43CGSKppt6e
	g5aGL85nKOBlIMqxbniV/LVhoT3M8K23wvELGI6f1szXk91jaMsjpZeCSZK/fV03zLPbgpD+7pJ
	cksw2BR34A=
X-Gm-Gg: Acq92OGSnxMtz5IMgGjCsBFMb566mxk35q3lodPBLjou1RyEFz1EwDmtGFjFTGgOo3O
	fe8KfDL2IXcTmvjcwUvR9VUi2vriLveoosS0HhszQjlZFMTfqF+cG7l23lq0XI6dcPlAIUdwpgR
	9ZiWyO9NCSPIsGLfx+xYDfJFlxTesAgVBFmjTIFH2dvYvKQrAkkm2ElePwxj+CdlNsMrHuKKq39
	Ra7bgdvFLrIdC/Ww7qwQJoAtarmq7PImy0PfkDqrnCeJ95WpLcmseGXtGBMHjgaLubp+YrZWH4k
	8XP4D/XkunEGclb048VQpDmoIsNya30WbXuKefj+fDZZYOwwLvV6XxvNor2yKXd9JFlYgKKBBre
	UuzhUyi4bOf+br8fu70tKOPjGrF9Asy6dwT/iMRTuYQ+Z8EK3sY7ptDPjxJSNI7RH/gTt0x5LSV
	4dV0+OKB4Ac83doYjj/xw6qQQiXmCHJGIMP0WBqVBfFcUcGwSbwbE9tZE9
X-Received: by 2002:a05:6102:160c:b0:631:5ef5:8324 with SMTP id ada2fe7eead31-63a3f392a3fmr2651971137.23.1778859789398;
        Fri, 15 May 2026 08:43:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63cd19df5c7sm161204137.11.2026.05.15.08.43.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2026 08:43:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso6390123b3a.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778859788; x=1779464588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d6gzxD5kgIq9g46EZ1vuJlw1O9O9Cl6K8iNSnqRp2g0=;
        b=gTqYRSVUbC1j89jW14qxysG4vQi029bXrvfLJQXe3RzqJT9qzU/3ZA8vUbjhsT4i8t
         WuLM7ZSAvLM6Z54FlQdsyPq3DtsPU44F3xJ8G/JeXUKV83iIaf/39b2IQhRJRGlO0ext
         wLolDbRG3B+7h8XYDPCjKc9LP+MgbvnTs04W8=
X-Forwarded-Encrypted: i=1; AFNElJ9MevyYV4M5w79jjPDEDU0Df3vHInjfEsf89XzEV7DQ1x3QqAL3daXgJcSl1kR+CTU+SYio3xg=@vger.kernel.org
X-Received: by 2002:a05:6a00:21ca:b0:83e:c8fb:54dc with SMTP id d2e1a72fcca58-83f33b36821mr5052735b3a.19.1778859788167;
        Fri, 15 May 2026 08:43:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:21ca:b0:83e:c8fb:54dc with SMTP id
 d2e1a72fcca58-83f33b36821mr5052709b3a.19.1778859787701; Fri, 15 May 2026
 08:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
In-Reply-To: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 15 May 2026 21:12:55 +0530
X-Gm-Features: AVHnY4KWzDSJhZRQ_DdUKZmCuX68WTg_JydbbU0QF6uTKUCcMbCNNRgLpRaVYdA
Message-ID: <CALs4sv3XH1DEB+EXmSjKvPz8Av-53HOrJ+Dc_mjOv+3EnnuV9w@mail.gmail.com>
Subject: Re: [PATCH] tg3: guard napi_disable and pci_disable_device calls
To: Yury Murashka <yurypm@arista.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ccabd10651dd118d"
X-Rspamd-Queue-Id: 39FC55533DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288349-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arista.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Action: no action

--000000000000ccabd10651dd118d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 4:28=E2=80=AFPM Yury Murashka <yurypm@arista.com> w=
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

Calling napi_disable() in case of teardown due to error and in
ndo_stop is very common.
So I imagine many drivers will encounter this same situation. I am not
sure how real the NO_AER_DRIVER occurring situation is.
If yes, then we need to fix more drivers?

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

I believe the same argument is true here also..
P.S: patches containing fixes should mention 'net' and should contain fixes=
 tag

--000000000000ccabd10651dd118d
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBVLern
e9z9Zbh6+sEYiARVw6dHTzT/o+Q0PmufPaZWkzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA1MTUxNTQzMDhaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCQelXmA6+uJjiMifWA4WDAtbZ3Ar8MWbay31468v5u
0taf06D6Ihw9+vjcimfpfSFK4scYSunWX49WvAqUoPF2L7e5+8HYfHU69J68WWwXcjfivkhqVyIo
AkSBb6v+yhR50D/D+HuUMx7OVnJjJ5UxqO1A2W2ECrj4WqGV5EQdleaU5Gzgu7dikElRw7gt2OCv
7m3lwQy7VUUJmdRu0+az6VEzSpANIQeDyJAkiPZR33ptSkwSYWedBRsdDLImmdK10anPOOxbj67x
u2OHQKlC8Sx345e6eRkseqkKYa5J3ry5LTZjC5EgyQxtGS/nI6b0hfvGMRuBCGOvzR8967Ut
--000000000000ccabd10651dd118d--

