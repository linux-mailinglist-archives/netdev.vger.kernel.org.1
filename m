Return-Path: <netdev+bounces-255061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIbVLGFtfGkSMgIAu9opvQ
	(envelope-from <netdev+bounces-255061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:35:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185EB872A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2972230166C4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 08:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7632ED48;
	Fri, 30 Jan 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZX9sz9gG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B43090D5
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762133; cv=pass; b=G0fYoOr6LGR1zbidWcU252RrRBoNppT8oa6iWKmLWymvx/KUDDMlVkZE3hTb29wr0Dz2Xzvzwzh8jOlu5mTOPrswfN7vrEMGH6MgBLG0KeuaGdwbMQH8zAbuDIEuLc3tnF6dHbGKLodf9gmoYIhbuj753tiM8V8BIPg0EEkSmEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762133; c=relaxed/simple;
	bh=BHpgJVfg5Wfjbrobgp2f9MgtKXpBppPi/NULdxTG2fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0cG1dTjkXYv5zeSlVUzge71Le7c2gnKYuu6Wm4d1hIcxJ1F1eezeK3kYSA5AKxpRRK0GzG2rc2xpmGG8aNaHPEVVgUehmDkE+hUud0iNuXMiYPy2le5vjM4j3uvD6svzchrFg+H5thPvtNzn1cGCeTay5zzNvnmGm8MnZogFTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZX9sz9gG; arc=pass smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1123976a12.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762131; x=1770366931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llcsUE6WB1p8tjA4ubDYnSSoUidNp1XShPOa9ryqmlo=;
        b=e6ISONx+FGjkK3LK8e462Uu7GWyxzfMZFxzXbAWWitVQA9tJRPLJF2LQyXrCpeLsn8
         /tE7ej0TOX0MQdhNZyspJwrYqqPNW6cj8RCn1N0zaE2IOhMtbJRVxsI2uLE1n4L0gyPo
         9Ei32TbjtcFbyfre4B2iHMloKk08UFlCx8Dj4LiGlhe7FS6qYv5GUNs8clk/Zmdiofvx
         O61xnue1FqteMfP6jD/GGrXvchAayTZif7RzrKvWAF+Fd1yRp2eLKOrqH10LdwNmnP5k
         IkksXioJL0V4wBvo/UhqHuhr15rpjsB8FVbPbHTzbmtMP3DyyigJ80Si5ZWGW6VrEbIG
         91mg==
X-Forwarded-Encrypted: i=2; AJvYcCXLj2oOQbnNs1jVOY95tQu0CnHj4L7/wkfMNlGyMaTeQqI/lZrkCgmPtW5vX+wVVMv+/TUYQTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsag6RgOiKGa6D4Q2NM3irRfgzChpkQapK61mRMnzxFmoZMMoe
	PBObuYiACxY8ZzUTflgdr0qKYzdUJCkY6mBjuOh3ZEepuaMGAGqkqluM0gbYWvT7SrX36HnZ7l+
	Ab5zyBPqiVbcvrM0NfdBz6OQIdjU8iHlBn7R3teErDCgbjLlwSeyd7SMQv4r/0UsejeypVQD3/r
	47lkfcZhIKlFobc8cryT0iEBKG2DvEnLXZLl/cbDBoqGkVLPo/bY5ZirD0b4necFGe2qOH45bF2
	+TajnAJjg==
X-Gm-Gg: AZuq6aLX7eH/GG7noanbV+/Fu3Z/vf2C2avTWyjPLDUTTEpKu5ULxyH/bFbhzSiPbjN
	2Bxk3YtqgtDYBLlggjS6TCfuz5uw4OqLGuExSThmSHfGDMIhuUVCvjPSXI7jlrIlBl9Dx9s8RPO
	hMw2WMhCBAmw7NFSD0cz2eAEYjmcbCgp8/tLByZMe7Pksd9UT/V9ha+5dXyreU86X8FLGVT7trL
	3c83EpqDGw8IvqzVWzFSSjFMlPlPfq9GWMJgfwwwx/pTFPmTQT+RoTAMeZBvlUvj95mdfKRowwb
	ygkQY4eYqQwjnVjbeByACNGO8rL/+rFV0NpAxL6osM8WDQCJ8O/vNiHEc+TXty4sdVbu+3hj/bR
	oXkvXZDQqjkYsnWyElWTRFqV1nda/SU/NeN14twdOmPqlzpc4HHCMn4Jspc3W7oxuOIy4FsUQ+Y
	iBc6p7nsSnZeGscr5XT3+yEnLJNakkHbfdDpg948tnfO8=
X-Received: by 2002:a05:6300:8002:b0:392:e5ab:3125 with SMTP id adf61e73a8af0-392e5ab649bmr1239660637.66.1769762131080;
        Fri, 30 Jan 2026 00:35:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b414c66sm9126345ad.22.2026.01.30.00.35.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2026 00:35:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94834f7a238so2122575241.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:35:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769762130; cv=none;
        d=google.com; s=arc-20240605;
        b=imoSYgvoLHr6vv3JWatjhKU6SbYWT3k/Nn1ova4kWiK1NdajE0f8LrIXyAnJYfRr+L
         TSIk8EaYaxFKpfpSwwLABUZH6nt0B/AHoh16Xo/lkgLRgwNqoSAKzJai15xH+wvYm1Kh
         c+9VIWFXsuQXalHlW/aJERVTKXOXUCdqx52Hm2nVxVgtkX5ooDtSokSlPL27au3GhTgo
         Mp1eve6xusevRIZBS/y4FikidMg+D244Z8d+8dmBHtby9ZQLwk+ImbcOu2ymj2GADmaZ
         QUZASbOE7Oobpe0y6OIPm02TFWdDTdUGaTnfqQeUR7N1vbf1McIpueC3xvExdEqqUOya
         cZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=llcsUE6WB1p8tjA4ubDYnSSoUidNp1XShPOa9ryqmlo=;
        fh=xWmWUYbK27j9l1cTkJABbO/j6HUsFoP21LCZd1rliXg=;
        b=iJIibMZlt+VuJnKHncj2jdy32m1NsfNTYpF/Wddzier7n3hT4nQFT8hpviPuUxpwRe
         /lkKjI8czIFw+tPLDNhvWg9B3MWuxN5pTEo6gXQY0HSOMA1EBEwcdxo+WTV5/XtY5XzY
         iW7n3cQuYA+lsxvg1tYUurUnSp2z4xJ8679TBSUPX+NkgLDqIxLlTaAFp0HMUPqf0ZYc
         s55eJY8Smj7cDyUsWSCU3rUjX0FWl496bBVbx1uZO3c0D4Vr5qnNIuaRcXqacagJadBs
         HMcDrCO5nHSw8Gw8BLg9NnA/b6oVzLimTLtkLaKwVW+p9cefGtGLb3y03p8f+5JURFxL
         o/mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769762130; x=1770366930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=llcsUE6WB1p8tjA4ubDYnSSoUidNp1XShPOa9ryqmlo=;
        b=ZX9sz9gGb9bDsXy6ldOu6Lzdz6Vc1llkYcpjXCLU5b1IBIpHr8pFr/kB+r8j2yLJec
         5CePuxx9uZZDsRvDlTyxMPGiCnTQT0ysya43+p9XLA1fr/jhxwGIbAti0zTV9b+pLU1V
         7ufpJnABzDOribNklekHE7sxMmD/lFvjYkOH4=
X-Forwarded-Encrypted: i=1; AJvYcCVGjfx9nLS/cEUUzbYLVl/VmIOMrp/8RRHqYxOWj8eZd6H9pzuUHospRKu6iFTj+/SDxuOSCZQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0f:b0:5e1:866c:4f8e with SMTP id ada2fe7eead31-5f8e26b8e65mr579104137.39.1769762130070;
        Fri, 30 Jan 2026 00:35:30 -0800 (PST)
X-Received: by 2002:a05:6102:3a0f:b0:5e1:866c:4f8e with SMTP id
 ada2fe7eead31-5f8e26b8e65mr579098137.39.1769762129747; Fri, 30 Jan 2026
 00:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 30 Jan 2026 14:05:18 +0530
X-Gm-Features: AZwV_QjgCSskp4EOXQIOFfgtx9_cBUDpPzNF7v7LYdtJT23fzQo74dnVPDgG3ys
Message-ID: <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for generic
 firmware version
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001e543e064996db1e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255061-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 2185EB872A
X-Rspamd-Action: no action

--0000000000001e543e064996db1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 1:01=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> The devlink info_get handler incorrectly reports "roce firmware" when
> populating the generic firmware version field.
>
> Update the error message to correctly describe the failing operation.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/=
net/ethernet/broadcom/bnge/bnge_devlink.c
> index a987afebd64d..57db3caabcfb 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devl=
ink,
>                               DEVLINK_INFO_VERSION_GENERIC_FW, buf);
>         if (rc) {
>                 NL_SET_ERR_MSG_MOD(extack,
> -                                  "Failed to set roce firmware version")=
;
> +                                  "Failed to set generic firmware versio=
n");

Thanks for fixing. I believe instead of generic, "Failed to set
firmware version"  is enough.

>                 return rc;
>         }
>
> --
> 2.50.1
>

--0000000000001e543e064996db1e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGCzl2DKqQT4
m+XoKUT7cyGug1yaoOYtYlmzIg1SJOceMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDEzMDA4MzUzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBANPy0Vi3eIaEjlB26SOBLBIFuORSk/uWhJOoj4Nx8KCuIabt
/A1CZqqDQCfTDxg036k6dycP1lYDOwxCEpSEhLa0K5L/Pvh/Ua6cvOov/YN37WJqKIobFK58q5BN
MhrIs8MLN+dOZGa4+K/YrRLAYhBfC3cRiojLdawp91tkbcagPAeldpVZaqKjl0unKc6BcQzlQDBQ
64+PMwSs/jlOVXPxE1Gk/lDKdMxW/rZJT4Vq7/+HTKMX8oElinn2yUMiOD3RnIcpfDP+B0xH1F0x
zFHqfBfKWvds/3VwW2xC+1JNx8VXt0tcgQBIPtKuKBaroPTg3nLvPGUmtTltYv8pVYc=
--0000000000001e543e064996db1e--

