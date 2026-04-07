Return-Path: <netdev+bounces-276059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIlsF+Im1WnB1gcAu9opvQ
	(envelope-from <netdev+bounces-276059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB243B13E7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3185318C622
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A253C2784;
	Tue,  7 Apr 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/o8BTIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8D3C6A53
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576409; cv=none; b=cdwuNTws7/vlQrU7srrFi6DFY5po+o17gfDTh1LLziwPBf4paWXSulUlQsZdDTH0ekNvB03xc62EahPO3ojvg140h2jD9BXlsgktjKAewkPnqBhzEfb08AXNBpeFH0eQZpSbifXYJyJzGVCruTtdlhSx3ROCOdSZ2Got5UEDd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576409; c=relaxed/simple;
	bh=5INEMDXdCFLDJ3FBN60nOVhiNd0csNX8PuQj/pRFVx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CReXD0BB0jtY4T7DhMnErjjhGIvvwUiV5icmVNqDslci41h7HzYfwlnilZDMUZrppzdudbyBZDLIGcLl5CnygYuJHU/qqZ+40tboGFB0ut0T11BzPPH1fOEJ+AM8brJtMx3WnwsQ+256DTN6vh+FPDAGNrtoyimAX8NLu555gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/o8BTIX; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-66f3e7d9eccso2975688eaf.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576400; x=1776181200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq/HkbUoMBYydsE4rQ5BYAjhX6cmgeXcTvPoSDEpdmY=;
        b=STBB2S557HoDiusb3ytgs2faTO2KNuQb4CqafoXA9Djrti5Xca6g5zeKIkSMHi43p0
         EwnXVyQozvjQvI9llzeYZ7K3oHfedMet0DyweQkr77MhsOrTF6ZGd4qp0abCJXvYJqC+
         Zgww+GxE3GD4mLx42mVhfwBCljS0SetjEOEu2ZcRJ9Arfr6nbLRxQpp+7bcZfO8DaCya
         VEnMSpeEKkrv3/slX2xXJPVQH7C8hiY7kXeOSK0mF2GL7BSr7Aum4TNok2JtrnPU2BzL
         JLLXRZFHKX8EM74YLGrZrT8L1EuOmFGg82bFwCGBMkatT0yHz/KEuysfSjZtRXbYD8/n
         vN0w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0tDPJFGdK/RKff5H51B0W7e9ylq7U0LkjHEfaM+gYRU0LDWc+RUE1T0qRxnuIwXm6mxvJr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2l6KCyytYll2Dc+fzneljlmPNhexIpXYMmaW/zWHqkMoyTeeW
	tgMDFY4TnoWJbgDV73Q6/kvlitqjKdMF6OLbcvIDw38a4iFMffcPv+UQGk/8troYSsOlCW70/Hv
	45YGEEGp7tuELyZp/oGqdNdAymmJMgh7Pkp5anPsVYa/3RPFh2g1u5rYPgKWoVV9qZ+re2+7CBD
	renOALXAlTM6/Aqn4pin4BwFjj9/F+bOA4HpjlkAqpGxNv3U24/8c8i7e7E2efUqSjJ7xGtUTtV
	3EdmT700GfRwQi7bk2W
X-Gm-Gg: AeBDies2uLBxdRDvEOeoCh3TgIjr9l372X5k1RASoY0efBJglCej+/6f/gtNsoOub5/
	d25UWio8wWTWcBX2ICeaYMBDYvaT15EXMXqMmJkASSomvlX5Qo5aED9qW4cEuY91P9yz7aNUe6V
	tkfSCeU6wjWmg0qTjv9ac/dbubKoYd7zHAsufwnys7yHIp2lk2cG+0/uvuKz/cGq7ouTSWhZfXK
	E826IATYuBIXLFp/n1BwekM9poMY7Cis85noDrRtxzZ4kxFkPD0qklU1KSJppTaLdLtcA29AaGJ
	qSgG2iQaV0054tJM6KZWRnJk4FMu4pCSziuZ7oszrwLCnZIslUEQNPM1MZPDBWXHNp0rtHrd94W
	84vGRAbidsruLkZmG2P/wL+/OlqannTVXHBxX+9Wzge8GlPLzM0b+Sjxf/ji7HeG6vNirb98HGi
	OdF7CtahBF1iUGZP0Hz8yN42jAqN6N0X4/ye5jBF8peZfSimWnMNnGhG+AgyRnsDQ=
X-Received: by 2002:a05:6820:a0c:b0:681:aa84:8c5f with SMTP id 006d021491bc7-68220a4d48bmr9091871eaf.63.1775576400333;
        Tue, 07 Apr 2026 08:40:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-680a5cdeab2sm870818eaf.12.2026.04.07.08.40.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:40:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7986c067508so118881197b3.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775576399; x=1776181199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq/HkbUoMBYydsE4rQ5BYAjhX6cmgeXcTvPoSDEpdmY=;
        b=H/o8BTIXZgI4tO+EaJu0PT3l+Dsa2mbXFvLbu+6x9pL2A/E5/TgOp5sz77J1J45W+T
         tR05ZKX8THTeGR/Ckl948M5qlgH9mdGhK+F0C0QLN52YuoyenesdzIThzI6pjlfKI0NH
         qBxvoM8yI0RjGEDp2CV0d01uLp2C+eH/32mLI=
X-Forwarded-Encrypted: i=1; AJvYcCWS8xO9af9tmFkOg8BlGQpqAutOsfp5FBLiEjbgrfShWb2shH/kOe5EXB0ImZDDcIrQpnwIOlA=@vger.kernel.org
X-Received: by 2002:a05:690c:e0c5:10b0:79a:b440:5c9d with SMTP id 00721157ae682-7a4d536b573mr119789407b3.28.1775576399368;
        Tue, 07 Apr 2026 08:39:59 -0700 (PDT)
X-Received: by 2002:a05:690c:e0c5:10b0:79a:b440:5c9d with SMTP id
 00721157ae682-7a4d536b573mr119789187b3.28.1775576398909; Tue, 07 Apr 2026
 08:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com> <20260406181445.1fb8308e@kernel.org>
In-Reply-To: <20260406181445.1fb8308e@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Tue, 7 Apr 2026 21:09:38 +0530
X-Gm-Features: AQROBzBafqr1H_w7JYMsLXnBTRDgSRtNEPmbHEN3RwW-8s9iD3cVPSzWhm1qF9A
Message-ID: <CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com, 
	daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000093cde3064ee09871"
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276059-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: ACB243B13E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000093cde3064ee09871
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 6:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  6 Apr 2026 15:23:02 -0700 Akhilesh Samineni wrote:
> > This series introduces two new configurable per-device attributes to
> > the PSP (PSP Security Protocol) subsystem: crypt-offset and spi-thresho=
ld.
>
> Please read this document:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> --

Thank you for the link. I have reviewed the netdev process documentation.
I=E2=80=99ve ensured my patches pass checkpatch and include the correct mai=
ntainers.

> pw-bot: cr

--00000000000093cde3064ee09871
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP6Kmqm3Tu6l
TtiZHTY45QtiqvIS2PUQy2G2KmDya6xcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQwNzE1Mzk1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFwSFhzvp2mZV8dE4PwDKBY6oqaBmjM0UQ0iZDiiHsEnBY+l
+TKp93su2VSnPyQYN65DFBj7nW/bH/uEwexh79sUZgnNWZeSev3FstcogXgrDFAFWyKmIWukobqo
sjkTXpXymNCpL4rj5s+1RL9wF8mphJGlWbv0wGOwG5a9u8Fd7X3ce10axeLzCVou72a9jaq2snVL
HMFOAUDcelBWtH9U0e7g5ptVbhe6fDuETcbVijn7ETt65OvvDUqYiZ616N0T3AXWJzRo+4PaOIKX
W5CZM6Pl3vEXr+w1E60PkD2N/AFwKZnixEX7WyEzgkiWk/Yw+ycCVrjGaU0Rrzj31tU=
--00000000000093cde3064ee09871--

