Return-Path: <netdev+bounces-45241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420277DBB10
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A60B20CF7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1218171B0;
	Mon, 30 Oct 2023 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KBLye+MI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D9EEDE
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:44:29 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2C97
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:44:27 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so1867398241.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698673467; x=1699278267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cp6Ha2d0GCuSdJFpoKLjTi78MtHF39hFwPYkdZYqy8I=;
        b=KBLye+MIZInY6uE33Z5g2IoC3DS/uCijaTNsztQaZq7GJeK1+EMkwfgb6eX4t0nOSc
         IqOSGfs2rBZGYPXxalEEnKO/KUixUprB01emf0ORaGjziMk7X3DI59C5Xev2I3ARoCmK
         sUtfxC3Bnb4RJqetc0GQl8u3ohy9eQ/mSkoPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673467; x=1699278267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cp6Ha2d0GCuSdJFpoKLjTi78MtHF39hFwPYkdZYqy8I=;
        b=DN2tca2iLnAAhHtC3fM4t4kqDouTGTnRbzkSBcyPKFxk5ih1TD+qCk7pP9q99Keoj6
         tiWdyVnyXBTxWyd5/Baa7ElhaRpP5NMh/fpAJKcVAeBbiiJNhCAc7rSSWe3GnyEBuCWV
         5yWcNF1DaYDQ11bN+NYr80Vhh23gicqrLMOfDK0Cq4nzFa76ArPPRgnzFnDIaY6LJMnl
         Drm1N2FyIBU0bfJneDAlBtGlSIE0MaObX+Eqk43oW4eyOI3a1Z9etUKO8LInlJr5aka0
         rUFOeJaLubOv6wXbHFVrV3RZTihiPTeBpXQ/FQFNN9dxMYXYKlpNR/4Qfl7ZHWkNzDyH
         bl2g==
X-Gm-Message-State: AOJu0YyOI8jlTMw2yozqPvpe2HQZGWl9jLJwKQitmAyS6yMjK/Tou1TA
	+20dhFUodOvyKKm7bKHJMPdmC50IsHYIJ7AGZbGobg==
X-Google-Smtp-Source: AGHT+IF76Y4/Jl+cJ+jAr3lR3LJmWONDC2kDd1Q9HJkH3tBOmPeuLAevDrk5Q4NF4sEGrAfQeGgyolVQTNdGSZIvrNc=
X-Received: by 2002:a67:e08e:0:b0:457:cca9:a922 with SMTP id
 f14-20020a67e08e000000b00457cca9a922mr8467004vsl.24.1698673466950; Mon, 30
 Oct 2023 06:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030091256.2915394-1-shaojijie@huawei.com> <ZT+cb4sO3PK1EbT5@nanopsycho>
In-Reply-To: <ZT+cb4sO3PK1EbT5@nanopsycho>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 30 Oct 2023 19:14:14 +0530
Message-ID: <CAOBf=mvvnfv6HcG7D5Oo9p3F9nr1k9rRdqMP_N1ZnRG9foGZxQ@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jijie Shao <shaojijie@huawei.com>, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	davem@davemloft.net, edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, 
	pabeni@redhat.com, jdamato@fastly.com, shenjian15@huawei.com, 
	wangjie125@huawei.com, liuyonglong@huawei.com, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009aaca30608ef3c27"

--0000000000009aaca30608ef3c27
Content-Type: multipart/alternative; boundary="00000000000096747d0608ef3c10"

--00000000000096747d0608ef3c10
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct, 2023, 18:02 Jiri Pirko, <jiri@resnulli.us> wrote:

> Mon, Oct 30, 2023 at 10:12:56AM CET, shaojijie@huawei.com wrote:
> >From: Jian Shen <shenjian15@huawei.com>
> >
> >When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> >is not called to free pool->recycle_stats, which may cause memory
> >leak.
>
> Would be nice to see the use of imperative mood in the patch description
> too, not only patch subject. Nevertheless, fix looks fine:
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
>
Reviewed-by: Somnath Kotur
>
<somnath.kotur@broadcom.com >

--00000000000096747d0608ef3c10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 30 Oct, 2023, 18:02 Jiri Pirko, &lt;<=
a href=3D"mailto:jiri@resnulli.us" target=3D"_blank" rel=3D"noreferrer">jir=
i@resnulli.us</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Mon, O=
ct 30, 2023 at 10:12:56AM CET, <a href=3D"mailto:shaojijie@huawei.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">shaojijie@huawei.com</a> wrote=
:<br>
&gt;From: Jian Shen &lt;<a href=3D"mailto:shenjian15@huawei.com" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">shenjian15@huawei.com</a>&gt;<br>
&gt;<br>
&gt;When ptr_ring_init() returns failure in page_pool_init(), free_percpu()=
<br>
&gt;is not called to free pool-&gt;recycle_stats, which may cause memory<br=
>
&gt;leak.<br>
<br>
Would be nice to see the use of imperative mood in the patch description<br=
>
too, not only patch subject. Nevertheless, fix looks fine:<br>
<br>
Reviewed-by: Jiri Pirko &lt;<a href=3D"mailto:jiri@nvidia.com" rel=3D"noref=
errer noreferrer" target=3D"_blank">jiri@nvidia.com</a>&gt;<br>
<br>
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"></blockquote></div><div dir=3D"=
auto"><br></div><div class=3D"gmail_quote" dir=3D"auto"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Reviewed-by: Somnath Kotur<br></blockquote></div><div dir=3D"=
auto">&lt;<a href=3D"mailto:somnath.kotur@broadcom.com">somnath.kotur@broad=
com.com</a> &gt;</div><div class=3D"gmail_quote" dir=3D"auto"></div></div>

--00000000000096747d0608ef3c10--

--0000000000009aaca30608ef3c27
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFETj3Wa0YMHefpgHazB/vpiaULm
w1P4KqbOGfoXXDoaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTAzMDEzNDQyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCTRKk7KFhRYzj1U7C4oEu/Q17eKAe9NyMRRDOvFzyEGPyq
/DNW8c8kPFJQisn5SwOvEC9Yf43cA8ssUfebQeUyz4VFovf4JuCNGvZP4VIJ09fUi0whLNyoLrsq
7DngW9SRSqiVCNQqQHTMzWJ/xX/Dd4D+6d5OpVn5vPoo2MZIaJqmRDUvRLgX5AcU0nD2fJQ7wafB
VHnnfmj73I7Bp7tjHODp0glulZoB3B925YXu5nNddoh5EGsloXI6negOe6BERYDBVO29GYIGhtT6
rP1Lr99Phxmi8bN2YFI8OjstSL2PmFzdP7FD7/94v2lgWAY4W7GsAtZX2ie5aEi0mlK7
--0000000000009aaca30608ef3c27--

