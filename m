Return-Path: <netdev+bounces-306996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id THgLMp5NVGpykQMAu9opvQ
	(envelope-from <netdev+bounces-306996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 04:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072574697C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 04:29:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=a06hPJfJ;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306996-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306996-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 989BF300C904
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 02:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691FA2EEE77;
	Mon, 13 Jul 2026 02:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1382EB5B8
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 02:29:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909786; cv=none; b=LNMzYzarKJpl8s8VhnxsossUcQe8d+S7gO7dMJhHdVGFTE+f8IUpkmwLpJyWu6xRe7oL1qyCmBQAcrqN9WdXDSFYdmx5QLZJaMoZNpc+OXhtGhbM/8z6EmqX1g1uUODLghQjbJVFGiCkUqp12fFymcIVWz1QJQTdi0erfbwdhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909786; c=relaxed/simple;
	bh=AnjhPkuxjOnXQ3Y4NeCHVlRumhFsAkQzfsnx5Weuw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtiCm/Iw2APqFi9rPCCcpA9ZqFjPlRE4VNRzVLUBpJDPaUDB+ZikOVHhPM2N3i2i8ahA5y3UFH9iD8ipA79FN2kpVVVkU0V2B9ePJSzLi1DIpf9p3fPsF5tSQAMiIsF6VTm7PULMkG6Golr6Ta5N8xq1EyhdMtcPSsgwx23o7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a06hPJfJ; arc=none smtp.client-ip=74.125.224.97
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6649ffb1d01so3478926d50.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783909784; x=1784514584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7dj4GcUl24dNWYeR8rWYKQejTxC7hkrLvJy/PmNK8ag=;
        b=MlnWVYzJagCSb+nQJT8hgtAqv3FkkHRLLmEFfmRzgONnZRWkdT1nOCtIbesV9gl+VE
         qle1Km/6NK5hw9iNuzxAYwlS44e9i0Zwd0XT9PtGhC0zq32pyyCBGGamq+W5GyXS1NOD
         +uiJ0TkAWEQ9JIOMGm/9mqc0kpv3w5R4lSQyQeAXzOKmZuLkK49NQu/ScOzeyc+/Wqc5
         8VW92RMNbHBCYodsFwYSlZOinPOcTqIYR9Nx8Ngh5XgmdF+l9ftj3y3cb8mm84VCG+ef
         o7QegnwPvO2HCz0llX7XAUvqbmogK/a2y7xuGJe+QmON12H2OdCiAOIatePbxaJ5zDNw
         da+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9je7aLIlthv1yiRrugFK6efbRYaPsgxIr9aU4PI5Yz78pXK0z8XmjPwMuAkeaa4P2tNIPz6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA14axZ5fBKB1ZPm7k0Ce9YSJ8uXCFjiJuWz0tcpQY+/Ix0reA
	v3mc7MHKojCxEXcZKa+JUH8A4w521aIUXO4eJKrZM6/KrruIfIpkMJF/UnTqC3NPlyV8KutGbOC
	W6Nrvr2ErvVuOp7jxXS8Bu2p3dT4vMYfqf9kkIFejYHer1nG+rprQXQTnPFUiAtb4BIxr0fyavN
	15wbpnW5TyU4eDhPMSebewjOSDBT0Yp6YSUyFjTQe9YJd9a0apn/Jszd9UCuEU7MQNSLFdRuazi
	wWSvEgWYZg=
X-Gm-Gg: AfdE7cmlDmtlsK6r27V6p/jKyBWV+BjU20QTAHoHPt9iYZVL8PhtyhE7dd6E/KnSCQf
	ClUA5RgWvReLCLStEIXX89UiX0/JHYEj4gv/fWB6E3QrIUqIED0ZeMAMfTX9XU/AnSn+sCu+/ge
	hWuUSJrhrjjN7selwX/+frveS25S5RmCjclflk6pkgn8/5EgP9s95T1FAO8Bm7/9Ts3CzYTX5tQ
	NUvDd/Ivkd9/fo1gBoGleC1Axk7AY8PFINd1GGkLLRT3+b22aObwzgmAtHpz/Bkmoi+rOHyYh9A
	IzPXIUAFzGnrG03FbbFDwrQmsA33ZFPYOMZZVTzUWBT/NHsd7X4N/O/TGoE6cXL0NUCJXumJYrR
	LKI1QeWXi98HSgB/3p9bm4fl/2eqU9/paWX4V+7JqinzrZoOX5ceudNgZBGXr0YXRLVXqs3Nt4J
	YgcahOiDLCxOBuvTE66sSeiVpgjKOOqxdvKt/J1kRLMvalDiC7
X-Received: by 2002:a05:690e:4088:b0:667:f1d9:b15a with SMTP id 956f58d0204a3-667f1d9bad3mr1459766d50.16.1783909783732;
        Sun, 12 Jul 2026 19:29:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66787772ad1sm872461d50.5.2026.07.12.19.29.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2026 19:29:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a3514f912so1060399b3a.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783909782; x=1784514582; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dj4GcUl24dNWYeR8rWYKQejTxC7hkrLvJy/PmNK8ag=;
        b=a06hPJfJjYEK+0Tjb1l+0KPe+l4a3I8jQ0wLJBTnVKtAB/+qJESHs64gf3ZGb3OLl4
         Sy6Fa1QiZ9Nh2JXgFrn/wvNJ30rVr5W2Ch1XaS9iEaI/54HqJRfZxnPHsCZLoocKjGBf
         1n3S1WK5vQXSzjk+mtCdeeXWuzOk7x2YdTVoY=
X-Forwarded-Encrypted: i=1; AHgh+RqrF+yb1b7FcjmYDEec5bAqhDimpm+NBLiC4SL2jwDB0VmPpJYxMReW6qTfoYrroSpQ+98i8rc=@vger.kernel.org
X-Received: by 2002:a05:6a00:13aa:b0:848:732b:6b33 with SMTP id d2e1a72fcca58-848897a75cemr6925279b3a.71.1783909781938;
        Sun, 12 Jul 2026 19:29:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:13aa:b0:848:732b:6b33 with SMTP id
 d2e1a72fcca58-848897a75cemr6925255b3a.71.1783909781536; Sun, 12 Jul 2026
 19:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711163716.3996929-1-ruoyuw560@gmail.com>
In-Reply-To: <20260711163716.3996929-1-ruoyuw560@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 13 Jul 2026 07:59:29 +0530
X-Gm-Features: AUfX_myxvKoNRpRvEJu7BKd4-yjQ9wcuicnPFqfGY4hoHx-4sydTnegoijwrJw4
Message-ID: <CALs4sv1UK95TULtK9NaQt_KNTdSO_22o_9WRx1iEehcDC6BJew@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Handle partially initialized auxiliary devices
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e40ef2065674dc6d"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew.gospodarek@broadcom.com,m:vikas.gupta@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306996-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1072574697C

--000000000000e40ef2065674dc6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 10:07=E2=80=AFPM Ruoyu Wang <ruoyuw560@gmail.com> w=
rote:
>
> bnxt_aux_devices_init() calls auxiliary_device_init() before all fields
> used by bnxt_aux_dev_release() are initialized.  After
> auxiliary_device_init() succeeds, later errors must unwind with
> auxiliary_device_uninit(), which invokes the release callback.
>
> The release callback assumes that aux_priv->id, aux_priv->edev,
> edev->net and edev->ulp_tbl are all populated.  If allocation fails
> after auxiliary_device_init(), the release path can otherwise dereference
> or clear partially initialized state.
>
> Allocate and attach the bnxt_en_dev and ULP table before calling
> auxiliary_device_init(), so the release callback only sees a fully
> initialized auxiliary private object.  If auxiliary_device_init() itself
> fails, free those allocations directly because device_initialize() has no=
t
> run and the release callback will not be invoked.
>
> This issue was found by a static analysis checker and confirmed by manual
> source review.
>
> Fixes: 194fad5b2781 ("bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit =
functions")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> v2:
> - Allocate edev and ulp before auxiliary_device_init(), as suggested by
>   Pavan Chebbi.
> v1: https://lore.kernel.org/netdev/20260708143401.3167477-1-ruoyuw560@gma=
il.com/
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 39 ++++++++++---------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thank you.

--000000000000e40ef2065674dc6d
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCvpIqA
Kxf2ElAGiDG5yuOz/vJ+Zsm+lzEOgTjTOF4rQDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA3MTMwMjI5NDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAiUmVA9RrIZx4rGA1whmCmbBPCF47E3oFXXKKZ5Kt4
svf+UC6zQeb4Ecly90JJbigut6OCm/6fQk/0NLZzFZXYbLTTe8rMi4i+Ui0aFeSTSz7fdbn+dvdU
0PN56TBStaBE3BWtvb6QyOx1z8QK5C67MF27Jsm7ZPr8H8NIsf0l/kfb2pA09VKdoP47YpQcr+ap
67VJaO40aLzkeTWLHHJWk1eLH7O8luHGFKT7tg6libsuxQn7F05z0ee57bgmffQd3LzV55BVdHYl
5Q+/d1wVHmTXmwIFJOC5wxufInCQ6wY0UFjXUQ4+NEfGqPB3COXCIkHsOVlTYMjGC7ZrHm1c
--000000000000e40ef2065674dc6d--

