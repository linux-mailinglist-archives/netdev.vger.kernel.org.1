Return-Path: <netdev+bounces-261779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOk7GllioWnIsQQAu9opvQ
	(envelope-from <netdev+bounces-261779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:22:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56B1B53A4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 788B1302F717
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4D301465;
	Fri, 27 Feb 2026 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ArdrZUkt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673428150F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183883; cv=pass; b=J/HhMEcy7MNwLfn0bSu6pRtFwPxJm9gFsvyXpz1F8+H+9RIuKFQFJi5faGiCZWaXPhsrDki5TRU6tsmRRxroRNo6BKIFH0Nr0xU1OroODBZwh/iyLxhGgABEPADExLYQqISp8VnQT21JCsF3aTTYLidxiWSQv5LWapPPRf6ZzAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183883; c=relaxed/simple;
	bh=7tGk/Euku4WwM0m7wFt+7TuuDlpSHfcRgVwtLhxg2dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoLTWax6f7cbPtJjzNPP/SWFo2Jj4btEFXQL1Xef99Qm2fKzSrjT5yF6HUG4NQ+NC7AdrBJYS74EoMn0LuCmCGdLyiU63/ibar9pNTyRqHVbGbvkKrqmXrQiaKL4lgbQKxSmSJVIWZf93H8LrrekzrwEF9eIwYdRMrDkQFvWmPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ArdrZUkt; arc=pass smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-464bba2db1aso415393b6e.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183880; x=1772788680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6ER5MBfR8G3EasG6aJ7s7iBdwcdlvVZf9J8F6r7bTg=;
        b=qtvA8XHlMep9Uqr3gXPYE4w6phrYWQyD1A+l0ry59Dib0wV9WPOxIjIaG86APkegVF
         gQ/aPdUmccEu3M+nXwY8KNzppH5zcdVIYS3l+KsIGWZ6XFTvNp/MrNEyTu77WwJqXUFG
         5jOrBK0Cyf10DHat1hOCnnI/dSC08vn/nKe3BB3eaFAHBvzYIojF7tNsEqgIVvpSUJRN
         QJ7SJj99V67yUoVxRCJRXOOsXY1rRJX/059ht/7CI670MNMwWITcrKegjA0utSmxx+iZ
         weK4E+k5tTzgJTofALPiNzjtNVMxjoae3AMXVYpdKqHfazd8Usn0lpaHGGZh0MlszUko
         CAnA==
X-Forwarded-Encrypted: i=2; AJvYcCVLNlul3ISY2KpBH/4IqC1sf02UONotN1TWIzMLaU+j8jcI0S0bSGx+ixHZ1ar3Q03LVUdsbJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqKvD6Ln246KMVgh/PKgXU61fK1ML1z5uvKfQOMLTIjI3TKbZ
	+lNjkm/Mt1/pBPhMKADe/i3/tJ8VmQxQ7UXT2k5vUhdLyhoXxtvDRNQEJ2qvXs0pZdlZ2d1nZX7
	ecnqRvEHH9QLd0NXu5z8gPQeCFnwjmwWda8H/s7uF/eEEqn65cnUthmYaZU+eALrnYfOVQTaqiI
	znwuIRA+SVC80GDtp8yD3e8t1+mFIbhEmxAD2yErnen4FDL6omSrXMrxMvAIzX053ROSO73y/R8
	IPrlZd45A==
X-Gm-Gg: ATEYQzwItSEXUDihilwA8wfcNVjDc6DFaVYt09ZvE15pUQBtbdGUQaSOPNnSHwAH4Zv
	TBCLlz4ANHH9ZqI17v1l4n0c/HCG5wP0D/TMy4zKeDGfRxqSX7GSEXtEwIRQY1g4jNsRBH5nTc0
	D740Bf2ywLKcZGQ6y6LLWK9pOR1I1FcM3TV78LrhTadqYrdLbZKfD4CPXwLWOCGz4y04FldfgKY
	m881ZLVhZbRxmL87gzffIqrDTUMfWmVFm1F5TXkp/hBvfUzOvL1Hh/11YDbwIlsNIUz0F7CaPxE
	taCXXffwZEiQFsEI8hdmpqSjQgITaDxiWdFRinlt/id3alJ8UgUGZyoldzhooI9pTKu9mGkjCud
	vE1FuoRaw9Bha7YnyLXVRi6ZQRszq6J9/qe/NsDwGl0ymZHqP6rjnQhrbk1IbvstVlUJO2UY2OG
	irvP2zvWdBHedFiXHk0XeeJDQseSMvVMPp1bLfrikWTBU+eI6Gsyqlpb2JcA==
X-Received: by 2002:a05:6820:201c:b0:662:f74d:69f5 with SMTP id 006d021491bc7-679fae7d3dfmr1288889eaf.31.1772183879513;
        Fri, 27 Feb 2026 01:17:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-679f2bee7c6sm482212eaf.1.2026.02.27.01.17.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 01:17:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5f934f736d4so2192648137.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772183878; cv=none;
        d=google.com; s=arc-20240605;
        b=LL/WWgtxRGDbLA7BjeWKZH50QRVz7uYtkUk3zQw3NoyN8YpiIPZNTyH5GPw+x8SfcN
         XpB+Nzd9fmsaPEtfOjFVWX0lwJSuFX1EoJvE5SKSMK2zODM7RaVYCHvyb2+ln64LJlQv
         aNpKdf8SpROOh4U1xcvecp0BNc+U6+cx1vOPQQsPS74vvhZg1PgZ8COK/wrqbLmEZmL7
         +VzYmqtivr8GTRpDg6Hu2s637ahJXNIIw1zYEP/bw595/BJ2XwzvSVPy2nEAHn5C6349
         N3zyRN/u5ztinBTWuJOLkdCUHrNrL8syFraVITz/NBkKnKXooE1MBDEfcCmFJgkVK7Dz
         zPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J6ER5MBfR8G3EasG6aJ7s7iBdwcdlvVZf9J8F6r7bTg=;
        fh=DYUFzyLZXtcgCS+JNHYw1q7BIaViyqFewmDfCMVP7mI=;
        b=WA5ayysuEeJk9aSyVgPzWmKJT/a+anM7oxjdjuMY1A44L0sqk+wlhATVtYg76VbU5k
         OfJ++p+40G025ruMDGhQ92Avq3NX56PZKXgK9iWCyZg5YR08FuMXzgCe95cbLx+GN56g
         vTkGeI7dqWWEmQxDlPrKtNizzs5/EDqIB8PnlUGbQu2LyKGPIRruwQt9TOR8kbawI/E1
         CpXBRiE3bQs0tAqds1yWTNSuIzJT6OX4sHi+3tnnBZGqexJzj6a/AwaOIZDlKU6rvebn
         SdLwAvSdCNFZEX+4vRAM8ljsZSOMGW1sbOHwSX60mvEGDzQYruA5WSSj2RtPOUik6PhD
         +uCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772183878; x=1772788678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6ER5MBfR8G3EasG6aJ7s7iBdwcdlvVZf9J8F6r7bTg=;
        b=ArdrZUktkrRoMyP7mbfE0bsJ8PemBckk1qUQo9X8JgaclwgF5BXGmCVx6BKYQ0LAQ0
         Z99zTWN2QGVp31IUMS4Jddk4KGh6TlIx8+KhFObmlqNqDRsN9n65YRKIfX6d565IMYP3
         G/bfBn2SjEt37mnVF7IX8k/44N0l0GevdYUTY=
X-Forwarded-Encrypted: i=1; AJvYcCX83quEAJUO6xujOlQUOnB/L9RNwRjwdM95hqTuBdcqH6ygTHapBMP0zfti+nDX9Zt81G5jk3w=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad3:b0:5ff:1cc2:aa8e with SMTP id ada2fe7eead31-5ff3253454amr969160137.30.1772183878390;
        Fri, 27 Feb 2026 01:17:58 -0800 (PST)
X-Received: by 2002:a05:6102:2ad3:b0:5ff:1cc2:aa8e with SMTP id
 ada2fe7eead31-5ff3253454amr969153137.30.1772183877892; Fri, 27 Feb 2026
 01:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226121458.4177513-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260226121458.4177513-1-alok.a.tiwari@oracle.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 27 Feb 2026 14:47:45 +0530
X-Gm-Features: AaiRm53VikzNkEPLUs7BL6mgvM3Z-zxsuGFyCFzr59BtiPgdwqOPoGNvGs-fVIM
Message-ID: <CAHLZf_sCzu9WGQyD9sj1oBoJVcv7ha7PzhK_gWfqFaJF5eP9HA@mail.gmail.com>
Subject: Re: [query] about max_hw_ring_grps override in bnge_hwrm_func_resc_qcaps()
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: bhargava.marreddy@broadcom.com, netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009189f5064bcab6b6"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261779-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BE56B1B53A4
X-Rspamd-Action: no action

--0000000000009189f5064bcab6b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 5:45=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> Hi,
>
> In bnge_hwrm_func_resc_qcaps() we read the firmware-reported value:
>
> hw_resc->max_hw_ring_grps =3D
>         le16_to_cpu(resp->max_hw_ring_grps);
>
> but later overwrite it with:
>
> hw_resc->max_hw_ring_grps =3D hw_resc->max_rx_rings;
>
> This effectively discards the firmware capability and assumes
> max_hw_ring_grps =3D=3D max_rx_rings.
>
> Is this intentional?

Thanks for pointing this out.
Yes, this is intentional.
max_hw_ring_grps should be equal to max_rx_rings only.
We can remove hw_resc->max_hw_ring_grps =3D le16_to_cpu(resp->max_hw_ring_g=
rps).
Older firmware versions used the max_hw_ring_grps field, but it is not
applicable for resource allocation
in the newer firmware versions, and this driver is not meant for older vers=
ions.

Thanks,
Vikas
>
> Thanks,
> Alok
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers=
/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index c46da3413417..9ba72c6b4604 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -565,7 +565,6 @@ int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd)
>         hw_resc->max_stat_ctxs =3D le16_to_cpu(resp->max_stat_ctx);
>
>         hw_resc->max_nqs =3D le16_to_cpu(resp->max_msix);
> -       hw_resc->max_hw_ring_grps =3D hw_resc->max_rx_rings;
>
>  hwrm_func_resc_qcaps_exit:
>         bnge_hwrm_req_drop(bd, req);
> --
> 2.50.1
>

--0000000000009189f5064bcab6b6
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAM8FEwuX8ab
0VG7t2n8dZot64ESGBLjMZezEhM/SyVtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDIyNzA5MTc1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAcsnyZw9XmH0ZgdBYIqwQPwAGDvwAOevlWtysmV2ii2slV0
B3MhjSgxTuTM5jTajRDKZ5UZqfwF5ZAT1IrU1aZLQJBdFefSKYojyweMgADji8hrO3tE7NnA9Of3
DKvu1Q5aoKSHvHU9p3GpOlvRNhBqMKZpVhpDlQddRgDCEfinWjxbqRhHLTp8uBj6x1Z/BVDRoIsi
tfmnrCEncnSh3BHBiuB+Y01uqrKKAokDT0bcd9LQ70crcNzLjbfbbmR4aZWETaLvE79OdH4Jv6WP
kLvH6TORpdBvJin6PZJ9Fjqi3PKyKKfe9xI6XsO+ntVnUDQCJ02mu5WpeQuiCJIgI9Q=
--0000000000009189f5064bcab6b6--

