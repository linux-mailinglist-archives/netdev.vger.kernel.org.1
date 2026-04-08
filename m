Return-Path: <netdev+bounces-276690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKC1BM6m1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:04:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70F3C2579
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D13D13044D3C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362063D9DD6;
	Wed,  8 Apr 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gnUIt9Rg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46A1A683C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674957; cv=none; b=jL00IvSBzDQNgGJqqaPoJL4Smr6nPZOgvt3iqgJF5UjFxKqE3toXODxMhz4NUmyomL64nWC9psWPc5ee5pGuSK9xUjxOySbR2pQWHEVbwM3nSx6aBf7JvS5IWMotCdhrjqJjvE0CR1b7LY4JlqUlU4VwBui1H0he+LEvByTu38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674957; c=relaxed/simple;
	bh=VmnTjKRGmksFKPf3Hw6G0ei3/YbOKtp6m+xOZwR/CXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbJZpV9Mdp07qtMWIR4LpQcbhMqd20nj+3aWNMWDkFjFrJ38rcxEO7xdY5BUCw5INLeKyVtyFGoaWrcG5u5Qy7TwnMG1uFmI2LikwQQMCxgBqdlGrVkMAXgmyixT2VOKzpFFk36fwGmx2cEmvbd6AoYH0gtNeKOHpkhnvnEHcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gnUIt9Rg; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79ee5037d44so1338007b3.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 12:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674955; x=1776279755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmnTjKRGmksFKPf3Hw6G0ei3/YbOKtp6m+xOZwR/CXE=;
        b=EsDT24qQD8rDf2c57A44DYGth79BkxnzHXdVjYlBn+b2x1OlE+2lH5sW62hoLZkCtM
         LnCatudTGrpt/kxYIbftT5eX4q/WW4+XdAb4BhhMa4gZA4TbG33voUdOvUjMdyYfaPmm
         MVy9yxOWzOUgRiIxw+JvOZuzqrDlhTQGDs5ZzZAWt2vrV+znS/xS4+j+LJRAmMFX8CjB
         zFzZfOdnFDZ4y2+EzA7GXzISWApS8w14Z/uxHjVoOA76AC/iYsyGh7XewCvPTmNQ90Xl
         FYEXNtshbyYuFEsSox6jO4N0w7Oc3Aanea3DrBG/qbJY1BqZKcwHUbDISkAFZsEksu1a
         GFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEjvDlL5/ZgjwXVne7So00pFNf77Vkeeb9fFYNciOe82tUW4g5tUgMw1THeLk0fZM8VpDmmM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0T+rQCckH292jYpwLCsPC4pwPVNcLDLNAVz1kdMlTY/ACdUaj
	biP3IEeozN8Vzq6hUoz1RmMw10HZ2od24iyy8Dx4VRKZdU2UuFe1v8cExsGHHHOS2LkPI6cpvo3
	1qHtIUhK0GzwGZowBo/l1FfK7zQVdfwgqtqUNY7r2e8qG/jaIctOHfJ5RAHzXqscxDwaELL43T1
	w/ayuBiHm5tUyDkk8/ENjoaT0dlXSKETmOTD5YenxXNFI1IQ3xCbH46gh70u1CCSajck3zlvXGK
	HXpZIRr6RK4YWMr0Q==
X-Gm-Gg: AeBDievJKaCkw0XJsbmDcB0BqiudXO1+KFM/ch9NJSGVr54QCoToOSV2xT7ZN2wjz7n
	7ZIHzcoDDhbn3uI9pGCsWVUZYq0WmBYin66xL6b1xrRpdYjkUyll+l12jJxN1jkpyO6u9dDX1ZF
	WxQ1D+6/1t/zLfGm6JZ4JgRNLJMmSh8ldFKmuX46JD9/yftzK4LR7yS1RAZ4MxbyYdWp6Oe3Xlv
	vaSi/IRmtr1cIIOC3nkeOwzZYSPlTLnaVNd0jtawZqjL60wnc8fJYlAczNX+A+k5jAEhvtdeJNR
	bQDu5xWBh787+emjgPpbbtB77OHcwYe3GsajvZhOGN+WiclkEkW3ZLN1MtX0qc7/5cbuvDM8vdd
	oDsrHjTqAsZLRU68w1sFwG4QvAKsUx6clbQfXAoAE703qvbqxO6E7sVUa5SPN+gTEnE2AN8bh0J
	ag5kJPXomsRJjXelmXcYS3MjDYVkV/7+NluE8lSuNRTt7IfLQgYmkppxm5q05qcLk=
X-Received: by 2002:a05:690c:350d:b0:79a:cc5c:23d0 with SMTP id 00721157ae682-7adee35d5c4mr7367797b3.27.1775674954542;
        Wed, 08 Apr 2026 12:02:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7a370cf81a2sm14935157b3.25.2026.04.08.12.02.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:02:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7900fc7033bso1885617b3.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775674954; x=1776279754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VmnTjKRGmksFKPf3Hw6G0ei3/YbOKtp6m+xOZwR/CXE=;
        b=gnUIt9RgvDF7FKAoOWUTl7wuIsvoLpwAnMlhH/3YHxXiZiyKgN0PLr1tYs1WLhhjUV
         lvXAbsh+6o5xhXOMwUVlIiC0+eUxSPRp6mANxmD0tmQpbRRqoQ1rvp4d5v2OgphOL1TU
         awZp5y1FAdYAdsPX6Hi3Jn76B64laBjUq9k0g=
X-Forwarded-Encrypted: i=1; AJvYcCXNnxs2oy7fU/tkP0oqyR0MM60IRh/facTfIe47q8KpQ1Vr9so9/LQCdOt1FfYRS/5Q6G0mE2k=@vger.kernel.org
X-Received: by 2002:a05:690c:698b:b0:79d:fca8:f7ef with SMTP id 00721157ae682-7adede6ed39mr7065407b3.22.1775674953754;
        Wed, 08 Apr 2026 12:02:33 -0700 (PDT)
X-Received: by 2002:a05:690c:698b:b0:79d:fca8:f7ef with SMTP id
 00721157ae682-7adede6ed39mr7064977b3.22.1775674953339; Wed, 08 Apr 2026
 12:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406181445.1fb8308e@kernel.org> <CANQF7iAF6DAMQWv=VSu=nTmb1CyALvVtH8xT2k0CCY0rKk3ggQ@mail.gmail.com>
 <20260407180928.3ce5ddca@kernel.org>
In-Reply-To: <20260407180928.3ce5ddca@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Thu, 9 Apr 2026 00:32:20 +0530
X-Gm-Features: AQROBzDKc63zL_JDJHv4cypyQ6Nb0Lc7-aAtjCcxsjFIFT5GS4_js-mzDAj3eA8
Message-ID: <CANQF7iCX_i8_=5JJ63W_Ee68sWPGCorvBabocn0CKYLTJ-1wmg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] psp: add crypt-offset and spi-threshold attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com, 
	daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e23637064ef78abf"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276690-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 2B70F3C2579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000e23637064ef78abf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 7 Apr 2026 21:09:38 +0530 Akhilesh Samineni wrote:
> > > Please read this document:
> > > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> >
> > Thank you for the link. I have reviewed the netdev process documentatio=
n.
>
> It is one thing to make an unknowing mistake and another thing
> to ignore someone asking you to read the documentation.
> Please read the doc top to bottom and tell your entire team to read it.

Hi Jakub, Daniel,

My apologies. I missed the requirement in the documentation regarding
the necessity of a real driver implementation alongside netdevsim for
new APIs.

I will submit the next version of the patch after the PSP driver is upstrea=
med.

--000000000000e23637064ef78abf
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
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHBLpMjQlXPH
pB+18kA3unJ5n9w2BAf/zJOfglBrVlr/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQwODE5MDIzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHlVbMsk3xrtE7/uOpkGPgixP6XuM8okmEfpcqkQ43glPWLa
H3CGgUiQW+KsZHuqKRl4F+OSy44JcaM/2PoA5T6D3pUFA2TqNZ9u2TmdZ70ocfAE1MV2L8NMLlDh
xrxL8lbWiIaAlQFDMgynxMLmFNOOLQJMVoaI2QpjMcDpGpzjCExQEZGL7gtUKzidozO4D78K3BRp
5/ZAt+AcUvnI21lRBB+bTu1EFzo4dE85+JbgbipyGa8q/QI7yb3uDitJlb6JFiz5pCc5zx33Cmor
DPE6K100DaCqVPrZOavXs8UO20fcZiZfBj8H0Gw9ttK6dvbPElVOIDZzmsIn6HAtGM4=
--000000000000e23637064ef78abf--

