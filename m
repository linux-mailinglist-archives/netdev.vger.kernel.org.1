Return-Path: <netdev+bounces-263647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEhbH3Xsp2mWlwAAu9opvQ
	(envelope-from <netdev+bounces-263647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EE1FC8E9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B04300DF6E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E1390239;
	Wed,  4 Mar 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M6iuMYtn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468038756E
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612609; cv=pass; b=RSibGewXCWgAwJ6RpuPDx3XxUiRe+hnK7go+mqs1kSCU8P3hBfixntcURR0KRk5ENdwGu+l0mEg/1WOsM8gnrkHAi9NvmEL/ljJHjhOAGCwwPJeeo5LPCxth5cgM6+b0j4Ekj6YmPdyN7IZFSaFvul3N99/fRY7CqG9sSlMLdew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612609; c=relaxed/simple;
	bh=MgzP4fu/ByA155ydv9FMILXnKlZLTNVXk2ixSP2oyxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjRjDqhpCUkXedOC1tdvrJ5y+RmEc37HlaxBDMLfAUbpTExAftfEs4QfIemWksV2AsmIgr5SE2BjsdG/+vPcbtGk9a+w4YQnYzSzQ8octWIcnPNXufRBXrY8BTkFe8KqMU6kr70GwJP/zvRiqE811BViX0BTau9C7pwH9Mh6+EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M6iuMYtn; arc=pass smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-12713e56abdso4044547c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612607; x=1773217407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeYYG+J/B5SgpKmiKgGIENCQmZTn0nKlp1M1B5yty0Y=;
        b=VH+zU5ULanwYyb7izFD6U+Q0w2FIFllAx0SSgEWvf4Fx1uucvTZkq9T1Usp8ifmtD4
         Xvda9ti+uVn/I3V1oSC3To7WFCvy6oEjdD8mJjDqegjKAh69rHIRRlNx0dJv9QXDHVem
         i0w0Ed01k2oqYGhLqiKpZyLTp3n/5prDzB5wz2ebpaFOxu5JfeBfWkCCgjux/eke+epn
         SePEMgFlLvLpV83rIGL6mKOPI3wQVrChTtwKBQNzscpFGG9JwdXeVb8SP+G3vuPhU7cI
         cz22Y3R2Q1D+1zsyJOWG/GBL5KqIeJz+F5tSmngHVm4q1sWNAxRvM7w+M1a8ygxVqi4E
         IuAg==
X-Forwarded-Encrypted: i=2; AJvYcCXChdjdJzZOEasznkp8X7zRNEFPlavTHJYjjDyP9q6LxfdfzzvG/7CD32xtnsM03qWjzwEiqh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfNP4INWe0m4R/LYmZl91w5IFYdD0oRWDODgK8yzp6dVD41Ms
	Y57UnT99P0t1sZxLeDOjAFA6mx9szD30uaaJo+9Uhom+r6st+3PrM8OtVRpK8DxoHvikgTWjgPu
	9qyhSGXrrtdAnCzQriz1U7uJB7eAijOvkOWyn3KI2bEHQ3IZkZcnyaHtfd6NF1UKoIJiG2NOKVR
	u+A62ZK8Rg7WFk+ssPthoI4778gtZzzFnVkWUX432PxUIdbq6BJSFnNd3CKHMmPrwMY0teWCisT
	WjBh8/p8jY=
X-Gm-Gg: ATEYQzw3J5Zt5jwkCdJmDxSRIffHuuCGap6Ja6A7Osp3cRoD1P4GkMA35N2sxNCL2sw
	Apm2mymXYjoOjJMUp0JvmLhNR6jKgm55hk7crLjWj8zq2MUtdYQsMfmuGQhcKhgH4VGv8dLTPyw
	TuNWTH7cBJONoPis6kZUhGigwg4seer3RkXxUIWaXFTpD9Apv2gZyDesR2WBKyfZleHdehywMci
	2c/XkjBgvJfgwi24VBWKY4BViTyCkRvEHV6Yp1wmJqUF4srpw9EwXBFTR4AcLtyWk4EOHI6c+YS
	0R8MqqDOGw6GqrdVlwYVs3K44DJ6r+nLC6VXksoUB2nBSxCd7I/vrFrZ4i6yIL5SToA5A5WuR3z
	xO1z/u59gW9U95Y1cZ3bepJ9rPm2qBKr22p3IKAOHL4U81Gd4eXu5ZUNuARN6bSPCQzExgu77ZN
	9giz1rqLlYNEYVdbR5UcayZW7tV4aOzKbqZOq3AM/BXNRka5KHVCuq1TibhBI=
X-Received: by 2002:a05:7022:221f:b0:127:5c3e:3ed6 with SMTP id a92af1059eb24-128b6fd9548mr345530c88.12.1772612606391;
        Wed, 04 Mar 2026 00:23:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12789a3074bsm2829553c88.8.2026.03.04.00.23.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:23:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae50386da7so19014045ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772612605; cv=none;
        d=google.com; s=arc-20240605;
        b=HxovqTZUpg0yM0zMTLgefORtZeXUknv1KitgInA+Z4BAEB86iXVOBSFCDZLmvYU9SU
         c3UJ78K7d5oezo+C0kdH9m4DvZ8fKAMNre+a7KoEb9T16WnZQgK4UorFt7rNTpcQ2YBZ
         OBJoNxFjkFbcGSYD1182pmRDf+obpvGg1vX+ON2IADZqmnIJjQsYDgjsbK6Km1gJEww3
         vRVD8oaGkkvANEAUiEDXyg0BgVHoqfCxOwkhOatnCgH7PWQkI7G2mBgmFJg+HuMvdQri
         WvpsTj5r8yJYlkpBXAC+vX2GG8TzZJyxixpmqgxMIPKQHWagAXma0fxLUJQLft3XNnIi
         izKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PeYYG+J/B5SgpKmiKgGIENCQmZTn0nKlp1M1B5yty0Y=;
        fh=Ko0sIm8TouBdlTNi0/tOS0IvsLmY2Q2khq49Po3WKhg=;
        b=ihVVDyZrCVO4hbNpG8PoEOMYWGyxt1wlq78OfCf/jZDa0Ga4XbDef2YOV65aaTHhYk
         ds10AZlQ3Bj8Q9kvo1HX4f/rDljEAV9QwmaUnmzjqWSnNKRZPlIKzSh65n1+dutXlT6+
         nlK1GaRpi4BSwkq58+7UvorVT7NCFuRSKVIeQAUvfyiFoiP7FJfKsrl/naGS3npObGe/
         mQk/uFlOorMGRCO5I0Wv977jZeVWj/8zhY1joDRWpZLvnp0nyNXoDUYZq6KJg1zZClX+
         +Sv4TuANBnOCk0qLO3zxirRLg7okQpbAP/jvfDOGkrdcAMoAjPuly4oF0Dul1ORT6bIw
         Qisg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772612605; x=1773217405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PeYYG+J/B5SgpKmiKgGIENCQmZTn0nKlp1M1B5yty0Y=;
        b=M6iuMYtn9Ts/UCZepc/vRgJpJPA8cjSj413VXz24HQhGETZrF5oPGh3Ol/DeYIoC83
         ct97cEG8qdmB0xIf3cfSFJgugXxX8IOWKEdORW7Y8BRA84W2seCYkB5w7gcsvRbY5Z33
         jRqN9ayR4bU0AWxjUOASIqYhDi85jBaRhhhlQ=
X-Forwarded-Encrypted: i=1; AJvYcCWyQjF/xBT1ftnFOBVe1W6EUuLmtFs4q9yAGdiKdMq8FAdwAznKIUmUc2nz143fYDut83rRik8=@vger.kernel.org
X-Received: by 2002:a17:902:fc8f:b0:2ae:478f:2ef with SMTP id d9443c01a7336-2ae6af3ca00mr11423675ad.28.1772612604789;
        Wed, 04 Mar 2026 00:23:24 -0800 (PST)
X-Received: by 2002:a17:902:fc8f:b0:2ae:478f:2ef with SMTP id
 d9443c01a7336-2ae6af3ca00mr11423405ad.28.1772612604339; Wed, 04 Mar 2026
 00:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303181535.2671734-1-bjorn@kernel.org>
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 4 Mar 2026 13:53:12 +0530
X-Gm-Features: AaiRm52xhRFeluJa04ipSYZlAEEXkV2lyi_Fzn6dEMW4S-pykDswd5iE369Bj08
Message-ID: <CALs4sv3kt-yrL7MP1mPtMx_ktRRVXANRo9ZQPfA-yDeGM4_Ghw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] ethtool: Dynamic RSS context indirection
 table resizing
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a6ea93064c2e8890"
X-Rspamd-Queue-Id: D67EE1FC8E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263647-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

--000000000000a6ea93064c2e8890
Content-Type: text/plain; charset="UTF-8"

>
> Open items:
>
>  - Pre-existing bug in bnxt: the IFF_RXFH_CONFIGURED guard in
>    bnxt_set_channels() only protects context 0. If context 0 uses
>    defaults but non-default contexts exist, channel changes that
>    change the table size succeed without updating ctx->indir_size for
>    those contexts. The core's ethtool_check_max_channel() prevents
>    invalid queue references but not the size mismatch itself. This
>    series fixes it by resizing all contexts. Should a separate fix be
>    sent to net for the existing bug?

You are right. Our re-size requirement check should include checking
of presence of any additional contexts and fail the channel change.
So the net effect is that ring 0 would get included/overburdened for
the additional contexts and that's an issue for sure though its not
catastrophic.
So IMO we could have a fix for net..

--000000000000a6ea93064c2e8890
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCpU4bS
ijwwiGsjD46tzZ6wLead60l7GWjx3y/lyKJ/JTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMDQwODIzMjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBZe6GRB9d46IZr7eDY6QIpyndOVjX5ccamuXAiSnVw
pfIXOsYWI6Hbje8MNT2ePYBYijMINL8Nz7F3d4VaEZcjE5zFpx/YGk3ZiBy5UxAI5K6wZHCjjux8
ShvDplVwo3J1qmADR1DsOzjnmFnY/u6Ql65P6QB/06vc092KBC74xmd5Xfjxjs/Rnfny2LdotVgb
gENsI823zvS/sjiITQVWZpKsxzPxZn76s/tGiGt+W+iP4Gk9u9LCb13bW1nOka4AYAT6LmcDJS6o
1LASXJUkxUacTiKHKaxTj6Rt7om0HGiSqruSs9MqaPnGmSNfMYuYF3B9QOxRHzVDzkfkU4ok
--000000000000a6ea93064c2e8890--

