Return-Path: <netdev+bounces-258467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pn9mAZrtjWlw8wAAu9opvQ
	(envelope-from <netdev+bounces-258467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A712EC68
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C8343012536
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415B35CB8B;
	Thu, 12 Feb 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GMJhOFA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF9B2E7635
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909077; cv=pass; b=Uv4BubfaSjny8qxJwBAjeyMeODGCljYnt2o1HVpz688qAQ2Q2S7X9zsQ2tgB0JcoTThpcNnEB+6ZvurcdHPnRo0n7w+ScJW6BNigG7QNZ/KmhQwaFImcLIEs2kZSbqtCnMOVUH6oDkUAR3DIBIdz5E9yJ0ibjcSh80SAbLjpo9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909077; c=relaxed/simple;
	bh=eTnq28pnZFHT/u3vrhgqb245QBCYLvNuJ42tcV6b1qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXOX1i8h+ufVZw0T+mraXYSRqPp/EQhgrKSNk0LV/qqc5LYOgfE12Lm9q9DA1GQFdZl8dU0RtRJkJ5mFTH496JRmZg8ONda0FIHm0TmGUfqGejOFNovTc+oA2zZsUBePKgPEoqD3t55uWdEUnWwpl1uQFQaMKNIUa1iFr84yrRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GMJhOFA+; arc=pass smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-501488a12cbso36792041cf.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770909075; x=1771513875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDJOZfrw5L+ku6A6fRm009F99QdaFfZWmxKfE8Gw7q4=;
        b=EEqiUJsmb5UvMpYvd7fGM4xhxrhECv8zmjNFC0E9xE+/WC3XJIx/sJ4LeJ4hKji6+4
         JeEJAo4EMiV6tDh0gbDHUsrxDjQeWvdBTFbPDknV81Axq/HDtqz3zWmKbpgKl/gfVZGv
         Z1Hlj4SmDCJswnhvYjmY23euqJPVpi3xD6/5IZl9U4d3F3cdmMaIz5FUHrAysGDbKWQE
         2UsMGpNdDvdVjlCqNX1n+N6Z7Jy7uz8hJAWl898xz1ZG82rWQZouGc/rR8Qk+JDwRPjn
         EBg9godP1HvRRZQBwScXIBgi7gAc8P1S0ZIrT77ovt82njIfTbDq7xyGyC8y2UC1fDd4
         BZRg==
X-Forwarded-Encrypted: i=2; AJvYcCU0cTa94jEDzOiHj1IVPuqZzoC74r6hzesdcz7DZVKveJMqtTNNe1s8CmjaW45al7zRoVK3RO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21A3ruUkA5dx39CFLPkP9QOh2/DOu2S3JRR19sXUSfxhugIX+
	EcVoyJPDtaa2dQotorfmVlNvh/IPEK7JQVC/XLk0OxLBhDieSWEd7EsWujTNtL+SDoofFf5uFYM
	AsXpcty0dAUZmJtXIGVjKZo7SI3beK4K0R4d5kYaI30Z8uKJjVkOZVjzAfqAO7UXtatnAA0bkBg
	w3XPs4J0ro7o7bcKDwAJ1K8HqFeM4Z27nU2L6HcxIaGavKAS+hxI3FxkaIH1gfjxcC21ExWl6Hz
	2c7huiY1w==
X-Gm-Gg: AZuq6aJHiq7vSEuob+EJqB19a2Es5UeuL6QWM8N2mhzfrYLCNp+lUx6gbCFiYbOuhcI
	o+NYlPduXM6J/nht3mOgoACtH5B0ReP9zbS2wW5zbA5RcwhZW7dcKXt6JnLcL84SGDV1eKNe/EU
	1V2S0M1xHwZCZQQBRy/mwE6/IzX8gm3tOxp5OeRE1zP3yCGB9fjTzq3kRcAbMb3M9/oSSIOtPiU
	7kUxFSxvWmlVb7yG7pFQ4UGlHHmq/vLa8M1NrXadNLZ0FkkyuFTkNztcLw8XvvprFT34GApANPd
	+ORw0xa6M+UXUGldz/agjlPdunCE3FKzEXRJCVJf9JH4EPToUGLRs0sPcq5SCaCYxMyP47Yml99
	JN+3o/8MY1UL+HvlRvX7Cr11nFlMCSKEDsFTdn1VeHC6e+y+5g5eq6tovVtviqA5WtXeNE6Wgpq
	AhKGgPpqGzKMsBoyS9vwXtlkfhiqJPllo5oo+LzGXg/pfmPwJCi7N/
X-Received: by 2002:ac8:7dc3:0:b0:4f4:de66:5901 with SMTP id d75a77b69052e-50694a970c6mr32598501cf.5.1770909075265;
        Thu, 12 Feb 2026 07:11:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971cc8f072sm6310876d6.11.2026.02.12.07.11.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:11:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5fcce5db266so7234647137.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:11:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770909074; cv=none;
        d=google.com; s=arc-20240605;
        b=Es5pwTHAjCSQz5qfUP/qzY5WCbJAeLKj16sQu5WfEM0l2VS0bvoymzWD8/Sr9ADiu6
         p6pODW7Pm+FFqjpaR8c9VbJXzqheLvCk1QbouF2DJPfTTG/4G7BaWjUhGNh9yn4mn4xU
         ajA0SjpcaOirAs/VeIgOaGAgrsoBFtvv8rjB+CLSPy791h/Zda2QimD+Azr1pKDASsw6
         K3p6cgvZ0TfvWXJPKRnR0es2XwU4laEn4qFG9IRC6XNUmK9yXxZ2VkvR9MhI8/7TqUcy
         njWUql8hge286JrUgf3V2apSCJSORM8sQBqF4XwLCt4b5ke7vY5eV09xGdkNp75+Qtxi
         JgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bDJOZfrw5L+ku6A6fRm009F99QdaFfZWmxKfE8Gw7q4=;
        fh=Cd0hZSdyBHnssUTHnxylxrm+JHKjHCtewD5M5DGK1HQ=;
        b=bIJvsMEzf1B+eCJ7z6OV1zxl7ByvwNl6SUZSdLvWe1eji2ePLbLZb2KfysVLDHtIVy
         J/8D5hOK6TkeGN7PCtPMM/quQlpkdNdRZZjitUCunxZpQ3k/pnY2bp5CZcV3B4fkFkNv
         zmBXGbQy+VF61JQVngAivelTybv+7ThdkAWDBULp9WjKulYXFJPFloWbppiMIwphE9xa
         ZP9kcpSPNKxH3UnrgL6Z8t3nqacG9pk7QFL6/9VqAWTImIfJEOegcfKJYxy2Hz4NK55g
         N+0fFgzsHT2TdcIPtYJpAlYrdLpviTuBMe59PYvNJDODlV8AyunJ9LqPi0alggLft1b8
         wFrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770909074; x=1771513874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDJOZfrw5L+ku6A6fRm009F99QdaFfZWmxKfE8Gw7q4=;
        b=GMJhOFA+fQx6Lq+ajlSJTh9KiHBwqqAEsHBhyIngu4O9U84VezkNjWaeoR5l0lkUJV
         hNsJwMwWgBvtPeiyt2bU8zTh+agAKfKj8Jq5tR95XSQUM0Am8fqdF/b1of4tdNwf6iuo
         Aoc4i/3UIqPZhDfheWZ9xCoL4Y4azI+WITGYA=
X-Forwarded-Encrypted: i=1; AJvYcCWcEdldC+daZJd6sA/y6lRz1gSaEVkPGYVMn3cbf8RSOWxKdXgv06bWrXnTTY0vZ8RlBfBGr04=@vger.kernel.org
X-Received: by 2002:a05:6102:dcc:b0:5dd:c3ec:b75 with SMTP id ada2fe7eead31-5fe00709058mr821068137.29.1770909074682;
        Thu, 12 Feb 2026 07:11:14 -0800 (PST)
X-Received: by 2002:a05:6102:dcc:b0:5dd:c3ec:b75 with SMTP id
 ada2fe7eead31-5fe00709058mr821053137.29.1770909074362; Thu, 12 Feb 2026
 07:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032021.2719742-1-nichen@iscas.ac.cn>
In-Reply-To: <20260211032021.2719742-1-nichen@iscas.ac.cn>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Thu, 12 Feb 2026 20:41:02 +0530
X-Gm-Features: AZwV_QiKVGTb5feEgJMoVBonLtS8l_rHo_pTjjDbaaIFVxYVIvNjasdsum1xaLk
Message-ID: <CAHLZf_uSEiJMV0m0XTgYZ9s2ePFdUOQjc6tAcdq5z847xS-hdw@mail.gmail.com>
Subject: Re: [net-next] bng_en: Remove duplicate include
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000581b2f064aa1e6f3"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-258467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 899A712EC68
X-Rspamd-Action: no action

--000000000000581b2f064aa1e6f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch looks good. Please consider merging it when net-next opens.

On Wed, Feb 11, 2026 at 8:51=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove duplicate inclusion of <net/netdev_queues.h>.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_netdev.c
> index 6ab317f1c16e..b8e258842c61 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -16,7 +16,6 @@
>  #include <linux/etherdevice.h>
>  #include <linux/if.h>
>  #include <net/ip.h>
> -#include <net/netdev_queues.h>
>  #include <linux/skbuff.h>
>  #include <net/page_pool/helpers.h>
>
> --
> 2.25.1
>

--000000000000581b2f064aa1e6f3
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJ3ou4WGRj3u
YfIJu7XD59lCfRE7sdpQJ62HW/TSkSB+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDIxMjE1MTExNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAG2OSwmWBh0Uyj4Bl8/MKSkJcCy0wy4w42oEUCm5jkjzAGNW
SZ6MAcx4A94gL/GAdYzm5/TCvnIXW4xxjkmFCE91+OoLJlrmYJFdhLxY8vKUTGLMwd8+h0VoaXdI
W1yMh5JGkCpG3eghbGKA2Z55fpW8NlKPW0zJWSGlG8LtrGOy4aKjaUrAFZG8v8zUDrgUrmCCJ6FU
ihwLZ44wf9cMAm8iLmwNvtqHzzU33xQQPPASYQjKzR+rQd3HnL6XlJXSjhjMpHBmsk+rNZGxD9P8
6x1pgTw4P74xQbaF+KUdMrv2ECybduZyMGmw2ADToBIkztLShL+fE+Z+caPUrCWd2rk=
--000000000000581b2f064aa1e6f3--

