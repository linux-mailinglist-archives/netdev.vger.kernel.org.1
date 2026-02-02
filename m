Return-Path: <netdev+bounces-255710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLvGN28+gGkY5QIAu9opvQ
	(envelope-from <netdev+bounces-255710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:04:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A2C872D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8669F3007AE8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5685280335;
	Mon,  2 Feb 2026 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bzv7pVjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724B1A58D
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012268; cv=pass; b=C5LLUPpSxkGSWRaeOnXFMQyUlpwg40wlPvF2PMbxDNLdl9ujubHW+21mRaOSHaClSxU6Mq8mwV4DgULGvsXuw9BI/lQjPzY5CSLFYbG23WAukXXID+Ktc7oJqh3Lz07cp70ifZIxRdP3YOSv9hkf2H+iS879gouAdulbI2WVRyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012268; c=relaxed/simple;
	bh=xVv4+fdo1eB+y3thj8uBIIbUGy/ehHwhQ6+4S5e98+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdUZNanMKji0gokBehy9iXtCzEasRJS4KXvG7R4RZPESa917fK9RbqzeOL2/YRLgSQnq+fCWRj+rHjp3e4vK7p0xIPd+DHmmgwhhvlX3px9/m4w31ksZM9PkOhAIREW9Ny97dOrm8u1tGexGA0OBtqtIUYXfxOcw3mIptwiikDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bzv7pVjB; arc=pass smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7cfd6f321b5so2622232a34.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 22:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770012266; x=1770617066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4TqFnwrMhI5bbsoUS2+WcwqsH0FudAjdXGFAnIl1AQ=;
        b=jmKXgd+FDKua79yg/n9mJ6nVdcJFo+KL1CDg4HkkedZoE/tIFvLJxitXOlClFFuTNX
         pGEgB64tGpBjcvxG1El0dHCpu+vBTesj3jCFzAWxtel0JxwQA0G+n7PeuAYY+mna4XEv
         dOSDuZjUfANt6o28cDzr4rWtO5Hn4iDkQQIPDkPw0CbuCfdEEHdEWRxRLR54ymCPzJ9p
         c3tiK6SAkGZKpvoZeYyVdcrWT0m/e2OY7FdvA9Jfob8dRt0oseN1Iu0svVCuzVuJEuuR
         ie5V/CzP3N6i17NNXLsMU4b6FwegZLiew7HWIYS8TQFywimnv69i5OG1QnsDvFiaUipN
         jE1A==
X-Forwarded-Encrypted: i=2; AJvYcCXNZ4+4xmhuhSiYT6RUDr27XcPS8/4slr8YpUgmdDtKcI87UbeOxjBZBMm9OhxeOSY79LqXtR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UqHJ+boksZ8rBXj3oBgCtJYnXSm/EWdSpWxpz/35sYUjapAb
	maG/HXHW5KGiuVsu7zlxa1idwpHvKSSC5Jr823DdMlkXAdOawMJVoFXkfXtnmpeqpKXI1tSm6Pz
	8fHeg/HxDiaAR7XItUAAARAaDgtDrXCx0U9zn51m80SzdjXhfo69zChidZiVNu9mBKZWmy+sS/F
	U1lpWonOBg2exyBg4nrNO4Md6EknQsAZvh9ZrZ3usetiZ4JqFHGHouvUcKa4EgVNw2T5dMHgput
	KtnwXPneQ==
X-Gm-Gg: AZuq6aJzbhSbonZ/DjQE8TBiYWqMIgEEBQz7FqDYOD8dHmhnvWPrAYSsZ0YSatxXrUD
	DqGXscab008s79sCf6zi6EOFVuJFH7zk4r7rQGLj8SMD7s5lPPKGOb0yB81D700jmu3SHOQMdUF
	W+Fsxg8MJERL7n7CvVfUD60MmmLqTZeJU8qb9h1HF7PO4/LJhivbsTOCUnLhAW/dZSuZ1KMiu93
	Vn7UOGpmmDwnwBokFNz0SvOCSVH/3XoVBTBoWQlPgk7UmSK4hH9yntx3Mcw0818JWYKJzXrvC46
	BL+yewoKl/lCaws6ZEy0jswtKJT9apUSFc4iRWQ90tgokZy7R4rOIDiAPF90qdbasJ0zNCNgRoh
	6PQ2s0JrDGvZAb42Nbgl5yk/lhuZqtUpiJpyJQ9NZyk8/aHtOzleZ7z/oG742hJUHK3O7QOJfWa
	CmUi9BtpUbpCPyjYb+I6bjQ6ZJtCt1kYgfMF317Ig1
X-Received: by 2002:a05:6830:3814:b0:7cf:cef1:50f7 with SMTP id 46e09a7af769-7d1a531cc21mr5960845a34.27.1770012266227;
        Sun, 01 Feb 2026 22:04:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d18c4f08d1sm2473401a34.0.2026.02.01.22.04.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2026 22:04:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94838cc73bdso6260959241.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 22:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770012265; cv=none;
        d=google.com; s=arc-20240605;
        b=M6RDimiTc3upF1YgdJkt5a0EdmVCpMHg1lCT5dRNicke9ypb/eEj3ZuwZsJZPhgTPe
         4hr62eRI/SFpMLziy6WUTm4xjPkyTfUFrDUHr7ffBX76zdqQ6x6ongBCFN29Vq+u9Nri
         Vyhc+ZUmPsC/r/leJdFyJak7uGK5DgpBT+axee9HIDBmkMEvprVRR7BKSqkfZtAvEfvC
         fKbEC5KomO5lFdzbZwskz+ZGE3EL0ezpGUHPfNXcHyta2q3Z6v2S6TUyJxfEX5A7LKgy
         sMIprRt28n0ENhdPVjX8T67D3Tw/Fpb6haFvsoZ9RpRX1YB5iemAiRU1Jvg2H+mQ711M
         Uh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V4TqFnwrMhI5bbsoUS2+WcwqsH0FudAjdXGFAnIl1AQ=;
        fh=PeI4F13qCV1ZKRqOfujzlrMnliQDT+VuYgpsKujMNU4=;
        b=Na6RaxIW73ix9pdQmMZTk6/7Vd6hFx+rMv+nwLug75VtWnEfVV06lkVL1oOOR20/Eg
         7ggcU6FgJ5l46G/x+vZWg70UT3wecfLdsKKQdsHMwz8QNatlNQawu3ctd7Fkz3r7V7f9
         MR0nBo3FVdQS6oiB2YszPeWlm0GkVJaU/nP3+bL0rZ5SgVvD0WBnry1kixYcQmWCN85R
         iCFFGXGvBZjtcmgT2MWfGunsCQzn6BYHGHKNK2a/dX7wrOf6oDc07C1+tJJmn0hAas+H
         ImCOW/vn/5+S3DZWKOROcEvGQFl1Sw3zbX2L2MsxyHH2XiVNpMJmrc/WUUIXAGE+kaiN
         Vozg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770012265; x=1770617065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4TqFnwrMhI5bbsoUS2+WcwqsH0FudAjdXGFAnIl1AQ=;
        b=Bzv7pVjBalAgWPN4NmuK1YU5CkWzJhlHlz7fA4Nf7twfJ7XnyPwNXU3cVYG0024DpT
         WQxmXnGqrJmX0DFF4Z9rLUmxiAMarcme+l1RZ/rQunHsP1eIILWIUVcPg+YkUnhayyoN
         89pUcOH6+EacGr96MmSVSrI/38uGtMCSU/kRM=
X-Forwarded-Encrypted: i=1; AJvYcCUdcUlxeO3tYCVcuJyROGTCRcFLXOM1DyVv3RxkPUQgnJf2FJmaG19iEryqRfacWBu4rpYpup8=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac7:b0:5f5:3638:776f with SMTP id ada2fe7eead31-5f8e25cafafmr2884024137.25.1770012265189;
        Sun, 01 Feb 2026 22:04:25 -0800 (PST)
X-Received: by 2002:a05:6102:2ac7:b0:5f5:3638:776f with SMTP id
 ada2fe7eead31-5f8e25cafafmr2884019137.25.1770012264842; Sun, 01 Feb 2026
 22:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202033848.22993-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260202033848.22993-1-alok.a.tiwari@oracle.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Mon, 2 Feb 2026 11:34:13 +0530
X-Gm-Features: AZwV_QjaeNepCPsesftItIwmnxySkWsh2dGtGQ-MQwSMhsPs-3ks7li2avpZSwc
Message-ID: <CAHLZf_t1LwePfUtkgZjQyxpf1_kRfjp7r-Xjq49zr1fpJopVTg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] bng_en: fix misleading error message for
 generic firmware version
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000557fc00649d11868"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255710-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 304A2C872D
X-Rspamd-Action: no action

--000000000000557fc00649d11868
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 9:09=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.co=
m> wrote:
>
> The devlink info_get handler incorrectly reports "roce firmware" when
> populating the generic firmware version field.
>
> Update the error message to correctly describe the failing operation.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

> ---
> v1 -> v2
> remove generic word in ERR_MSG
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/=
net/ethernet/broadcom/bnge/bnge_devlink.c
> index a987afebd64d..f3a984d4d5f1 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *devl=
ink,
>                               DEVLINK_INFO_VERSION_GENERIC_FW, buf);
>         if (rc) {
>                 NL_SET_ERR_MSG_MOD(extack,
> -                                  "Failed to set roce firmware version")=
;
> +                                  "Failed to set firmware version");
>                 return rc;
>         }
>
> --
> 2.50.1
>

--000000000000557fc00649d11868
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIFtPtT4Y35b
XsjHH+QQ47EbssTd4ICoQ2wFrRLw23S3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDIwMjA2MDQyNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAH3RBVip+xkwoz4FxVCDFuIqc+JXcXvL7sQK5ctFBxr37+ac
TDYjITjV3x4btlLa8j1pZtjkujyE67UxRb66s1kSU9LqSgRSFs9TwE+t5OZWSd02xx+tejorAce0
gMdOuyOfE4oNglivffCOFJqhGWzLAFZObzbcEC8AIL5tqWd/6Kxz2YOqSIgl+Tijs5BcRsJxuKMf
GQcB27CS5NRja76Ct4bdabWfTKrAI4IZAk5hK6IusS5SoAgV+rpVZyFOlfF1KWkhIINMmFaOE25Z
S0l6J8RxVTaYek3Y2tE9IrHd+gXHwgv0Lbsyhy50r0XdUxYf3oujIrfBB6CmSjvA93c=
--000000000000557fc00649d11868--

