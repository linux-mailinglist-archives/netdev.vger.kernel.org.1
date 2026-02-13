Return-Path: <netdev+bounces-258558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMCBIwegjml1DQEAu9opvQ
	(envelope-from <netdev+bounces-258558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 384A8132C42
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EC063034F3D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DC23D288;
	Fri, 13 Feb 2026 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LOTUaDaO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5F81724
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954756; cv=pass; b=A129l3/5CnEFuhzLgWRHID9OpIUwpxUcxpp8dYyQ8V8AxuxdfSjS3wWJZXnevujc1I2EEN12C9BpDKxWNXNQWXZ3YKSyNBtH2MqO+lJQujszUtjfwv0NTUVSfD9raKvcdP6Q/zGypJeYdxS1Ck3mrvhePXaqYHVS5/zealekpms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954756; c=relaxed/simple;
	bh=14t+bEX8Px/lEln8O/pMcH7g7cG2QWrke9uj4TJDWR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBsBxbiBjH1pQBjFE1q5qQlhc3ofzmd6NZe+5vjfCBtrX6RuHl9Sd9ws0QT/YpcMtTusF19gXqv/5l0eEzwYvMHHvQabWrdn8Aum1sAmxdslB3epZxeoIAuMetV06y3fCYcBQSJ1VbbH6ajhReWDu1axc7wOtMSR6f5EJhKlbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LOTUaDaO; arc=pass smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ab47d8b33cso2965275ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 19:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770954754; x=1771559554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMjYiQc9+o3poosipLrDCl0Yu8SdGDENhHA5QKTYBpc=;
        b=mMpfVmBw7CqDFM3kwxzYGLfyNlpbpNmgQ8AQbbB4/VmgsLRPgC0jfxnHVcbWPxBQel
         a2eltgYEg3dW8pNxMVT32AFXB8dCtu54G6EJocl/bshKDpgTeUje8RPHMhL2eooEwwmo
         rWzPTPGj5fiw5YctB/nKoAq0k5B623UHhdB86/uDjdv6pzzk7rxTKnIPYY6KNbjMPJvp
         y7eaNukFckyvK26zFe/aoY/brGsws+gEajMDKAPh0pkP779GZHT8NKgLnJAdCsNxqXQV
         Xd3iumqsQekfRxLc8yoF2UnV6HqUjpXuavzlyrPRicpc2eh7Usrr73BWq+0dawLF2EAK
         mUcg==
X-Forwarded-Encrypted: i=2; AJvYcCVhPgN7/WLATTMX1gE+T3a4DXspb3uY8eU0gGrc1P7z4rPcn6S1Zs1NiyOdSjRU6XocC5j82hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ulCFxO3CSwMVk57xQ64tWeRWuf0k5RdEq0ZjekJSvB7FSJfi
	/dyS6D4bsbWfO4QkOiJHQPVMUG+iP2TW2a3RcL8LIwhBdUvr3muzVkbRs7UFd07fi2VprgeOaWs
	2BpWDFNPNc15PXmE7LGMGJudix9s6skyFYVRd71WH/HqUhbkXUYZpJqDLibAwN5bRD297edr81G
	WLj1M9XIw6hfj3HgGAfc5qEwKQqZ2b8jpUbWpwi30DwAmF5IQxNDHg5xz61a7EDMrIlQkU5lCT9
	S6GlXFcCF0=
X-Gm-Gg: AZuq6aKmQSZEcwJG5m9YOtX8Kang8wSl8aJVGBYAeN18j/HEKeQXidItKApKBCDJpMX
	j8f3JKFPlDFzAROBZrAealMwkxVRPsJfKgTFIaDIaQ2l97+3kzA2B9fO1epFQwnzt/rKJWnVS3V
	ARhDdb4GFYCN8qwD0SKsKopWeRSVms+KpQKIzGsMKQG4T61aUrfN/Iqx1kjVRH/18Uy9vk6oVTz
	aZc6qdxKhcGWIjPeYDOhAN73HkiZpPZ/NcOujWS9r75f1jyXZv3cwHDzk7Bh48ntI15njwXaV2T
	Z8ooYl8jVy43G2gmzISviF7sYa4pc750QRwzCdpe5TeICFrIHc7+chcrXYxIUUzKtJEExgR11dd
	pwgP72VWG1HXoZCr/sv3lhlQegL2El2G5efQwMt8ZG5Db9LwAL1WXJ/wEuthLpyAHt15CtF5iyg
	5ysHBJ0OJjn4oGyyGFSgLLaWn9UYU42eLgnqiwepUJqbKP8fpkucHGhJOv
X-Received: by 2002:a17:903:950:b0:2aa:d287:6949 with SMTP id d9443c01a7336-2ab504cabe2mr6169035ad.5.1770954753871;
        Thu, 12 Feb 2026 19:52:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-356a6a37e04sm43075a91.0.2026.02.12.19.52.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 19:52:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso428411a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 19:52:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770954752; cv=none;
        d=google.com; s=arc-20240605;
        b=N41fAo+1UoqrCCumA3zuI6rqqwSn0cAZxk3eRon1zSLI/wfE0MHf8xxFejPuzO2TDN
         QPAublFGPIPUtyDC8pm99hFvn0t7o7YOw7darwIu7uS3d8gNaLDfnQ6k9ZWnBfQRYrrC
         5lnrbs1EMxVG3nbt8bCmWNKMBVcwmGlBKtQKvmWkvy8zJFssxH8ZMU6K2NVR+OLDXANl
         0kBEtegEE9u5QWa2+cI4z66IsuyDuYz88Ya3YcIp+Hf4VOdh36b1mco+iXFJxb/gRurN
         L4k1lvqOKf3l1Inbl/SS7CtdPAs5Q+GEgjbQ3+n1XPF0bpf8M6K1CvzgbajelZQ6NxQM
         Su/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oMjYiQc9+o3poosipLrDCl0Yu8SdGDENhHA5QKTYBpc=;
        fh=9TMxQXk+l2iPJ2vAwI1sd79rAyuZE2/LGnr3dRoHZoY=;
        b=D1c2/F4ISGwUh3TGm1WdtccUScIA5oQW7jMKjaBRhCfJVpqZkyW6+AXgsyRFJ0chXy
         lFIC9XviSZoFZMpK2vDKWknNk6Pxj9sza2YjIh2m90RkIU3TG7j5VRtf+CyKEqW9EojR
         DmZsqJWh06j/Qdt7/aZZ98IgZyqg6kov7Uh6hmhF3G9KF7dRoYR9NBV3996VhGcFMva+
         /Z2YXOQ240SvEEaDQDB5QjhAmGfMaRlAx4Ze18VqecnutUV/t2kScIPaPLo99+lvq+8K
         4RNURNgAZlDqt9UfI+1P84cmgAtLsfeGOdsbC+nbs5q3N8H6js0LffPUdXK7GMNHjyM1
         GdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770954752; x=1771559552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMjYiQc9+o3poosipLrDCl0Yu8SdGDENhHA5QKTYBpc=;
        b=LOTUaDaON264SW6KpzWhzkPPmQunDYnXFl5MIpCVkuisOV825muoTCOrE3AlMrI9UF
         ZiN0e61NM2aO44xsINJa4jmpaczDFT/lP+1rHvnGKVb8hn6dTBf8B4yaK05AXk/dY4di
         pepbesu70DUD3Se0oZoLXQ5xPwPNkwdd2d6+0=
X-Forwarded-Encrypted: i=1; AJvYcCUkpP/eA4UF6FRQ3tobhyH7bulhr2gLMHuAVAnaYtSQ3TPDaOprl4zjmnTSLELKurQLTDUD2ac=@vger.kernel.org
X-Received: by 2002:a17:90b:5104:b0:356:2db3:120a with SMTP id 98e67ed59e1d1-356aabec277mr679832a91.13.1770954751702;
        Thu, 12 Feb 2026 19:52:31 -0800 (PST)
X-Received: by 2002:a17:90b:5104:b0:356:2db3:120a with SMTP id
 98e67ed59e1d1-356aabec277mr679824a91.13.1770954751290; Thu, 12 Feb 2026
 19:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211085822.184f85c2@kernel.org> <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
 <20260212175204.5b467f67@kernel.org>
In-Reply-To: <20260212175204.5b467f67@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 13 Feb 2026 09:22:19 +0530
X-Gm-Features: AZwV_QiiuMt_ctFiFfv5dr2Z0HdZpOx8u4aeDJXaXtxiNmK4vcFmLsHWt1WDXx8
Message-ID: <CALs4sv1edwxwfY=qptx4NQ_sBb=2b=qd1XSgrE-+62Qxgm4Uyw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx:
 test RSS contexts persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com, 
	bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com, 
	michael.chan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e96746064aac888e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[lunn.ch,broadcom.com,gmail.com,davemloft.net,google.com,vger.kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 384A8132C42
X-Rspamd-Action: no action

--000000000000e96746064aac888e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 7:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Feb 2026 00:12:50 -0800 Pavan Chebbi wrote:
> > +    if not pre_down:
> > +        ip(f"link set dev {cfg.ifname} down")
> > +    ifup.exec()
> > +
> > +    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
> > +        lambda x: x.strip() =3D=3D "1", deadline=3D20)
> > +
> > +    remote_addr =3D cfg.remote_addr_v[cfg.addr_ipver]
>
> I don't see anything wrong here :(
>
> The diff I shared to re-open the carrier file instead of using seek()
> doesn't make a difference?

No, it did not make any difference.

>
> If it doesn't please use the version you shared here, even if it's
> unstable right now. I'll try to find the time to investigate what's
> wrong with the test infra. Better that than accumulating workarounds.

Sounds good. Thanks for checking.

--000000000000e96746064aac888e
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDv2vi6
8/b6UqAMuhEgM/Q9iuaMJ3692WIJ1M2VBHp8fDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTMwMzUyMzJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcRXIAmisvoe7TNuTzYHyK1gJ3+LE4t4l9yHPkK3k0
J7OYt68QuM2DsBatSB1zA8+duGsRTG9vK+2UB00dIv+OTIfAig33tNloSW1HSHXhWRw6iV7XfpPG
mv9nLBGNpOq/X1lINYDz5jcnRn3W/g4Fjfbtl+PCYwMBa0K5S/D5c6R7n/6xCaCAAn4pFYv9oMFj
2KqNEej1Cra/67LCDvGvcziHYQUiliGS0Ekjxr8FqJ0RUyfcKe0MQvxGG45p8KO3ghLHIT2vo72w
7HccnbJA3stiVtxQnq5BeybgluDcUpf1KNTyDU575u7lJ+TLTZS9Vfevi0vXzXYBVsXQmKfW
--000000000000e96746064aac888e--

