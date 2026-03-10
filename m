Return-Path: <netdev+bounces-265889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD9/JNecr2kTbAIAu9opvQ
	(envelope-from <netdev+bounces-265889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 05:23:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4C2453DE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 05:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A8F6302B184
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3A3B8D69;
	Tue, 10 Mar 2026 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WAnveEDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC651F9F70
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116630; cv=pass; b=gtUeuZ6hVfRexcR742tPid5rcHlIoA7zgg4FneeF0CZdSY6TXwOUeWuIJw5ozVdKDgiUuW59XAnFIL4psfD4/hRUZlDhBI5HyzT8xZdM8oTFFQGhZ4y9Nl/o/q2W49nCy6/vcI8LKlO0igmrAwPoXXhihqMmp0FrpUQJ8D5qPFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116630; c=relaxed/simple;
	bh=CCbVSiZDwIaSL+KkXOwpi3juM3LcguRcKVgsio+WpVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G56ej6z3F4DAjo5SsgCWqfQpO2itRm8qVX9thfUusJ5BVTWocmgf2RfiYAskQRmcyxga5Eq2fI734Jh5OXsw9Y28Jw8jN2IiJo+oj2MUVMdBBL03/+02Cw+OzUMS3OXCfQ6pKcoIw2N2nc4XwcIu1jiBMGcLG+4yd6JZPfSlLvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WAnveEDd; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2aae146b604so89468865ad.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 21:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773116627; x=1773721427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J28K3y97+71QGASZ7jtAVp++XirIoMU2V05Xzlr6h0E=;
        b=QUb2Pt7u6ED8BY3XOTipfYITB3BLP031tEpoM7Xm2ZwzcmeH8NExkJzRLmE4ZcdVkV
         QmlF48TgngKBad8Wdwa0ND+5j3NDDNQ12+JmiC45fFuRv+G/G0Um+8qYPik5vLWVB2la
         tp34qH4ag4sGiq+Hcf1VjPg7+vd6ZNLX5XuMu9ETvP4mKcVHsh9pxb7ocP9mEL/2+wc9
         KdJHtjtCLmQfa6NduAG3IlFozTdvcqNb8XJbw64x5Dp75I1CBysDyvjVmkNJ/UccpbAB
         bxUMiIKHHGRAxb0uu0sHgcGG3TK1l8ji24e0tqai3ZxZ9gwKM2YyG68axMWUspovL1rp
         pOPQ==
X-Forwarded-Encrypted: i=2; AJvYcCXq5JP7y5LP4v/95yQAE+P3QMUxIv9VNm4qyH+yLaDUxkPH30W4HDM2Ytc+VL2cDsnUo1cadZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylISaYJt8zYcXi12LMBkiT1RwQPC9E6wd717p1ESCOdmcEkWsw
	aZA5kXzcd8UH4T16BAK0UE7/rhkn6eJVIzn+rJ8jCuQHXFna3v2IdX0Th1Zrd+FwYT3O9o/Lj/l
	b65huy9OpJV3oOwoRfffq/2nmjMX20b0vqPuW7zIzeuYq1B1sdDqtrIDojoS43OQvdb3h69AE1N
	Lq8dDIXcwXsfC0PHauCWT7iIvvkN5Dx6JhPox/fmVO98JLdpXjVt36A1mTOjR09lX9XWLmzKqpk
	W2Q7s8e0KU=
X-Gm-Gg: ATEYQzw4i80YUi7EKdugvqHY7YY72l83owyMEXaHKMqhyn0jj6Ad8HwJ4WnRX0Nvy19
	U5bvQF674AYoG7BbV7eWUZR/+DJRCRn1QNSiL5G81MsMYiCuuBL8GTWmdO7KpTQ5+LfI6Au4Dl/
	Sd4YEKIjBw5dtP0rKJBpsMpS4z+fIhGsiOBtw7HV27l83bqSe9VDMkEjFNDAMlh0heYIy851UcP
	mi8HNKvBCaY2g53aXn1s/uUa4nAnHFEC/MQz/+o5P+lDHGg1HI7AVmyxsGldDv/tasAohaMng36
	b0deCsE9BrOl64T8nTTG28OGLRIjt6rXtPVKiS++SJmNC8TKidLbPJADAd/rdi/fMF4CG2reB7i
	frcA4FE1Ch5dn69g7qzklaCN53Mk2knSFECDKnaFmk5hDZ4bRQ4FWxwMqbQk/XP3o4v8GqIggd/
	3EQ3AvJzJ8ldn3Wabv7XPh7NPNxNp9ooLgbCzVaeAjmmkv9zDIpPUDMzqr
X-Received: by 2002:a17:903:faf:b0:2ae:7f7e:93a8 with SMTP id d9443c01a7336-2ae8248ab08mr137723775ad.51.1773116626968;
        Mon, 09 Mar 2026 21:23:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c739e170327sm880409a12.8.2026.03.09.21.23.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 21:23:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c73781252edso21045162a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 21:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773116625; cv=none;
        d=google.com; s=arc-20240605;
        b=RoI7nJ2UgMMpwpK2wvBObE5FyJ6icK+VAADXyLjdNGfmHZjhqt3+rCISbZ/iYohNx8
         NJKb7d17Md+UvawfA0v1IbJ7cYEJmUj+E1N/AkJCMiYKEogqQ7aFC03gg+URytTuTW4e
         m3JF3h9GauwJo66pHM4TCZL6h/6wD+PBnfwMR4ZxWlzi/Nc/vOkGSYdKZLjzfTrCqeZe
         2518uw0OGAg2sUbGGGTiFaKNtDcsFVIpyYSL6xik5VBY41qK17imTjGsohon/J4xCIaB
         egSf9jb8r/IkmC8BvUMnTW8GRVsA4QBAXo3T8cIoleKBX+1rxfb7IEd8kYqHVBoA5kao
         pU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J28K3y97+71QGASZ7jtAVp++XirIoMU2V05Xzlr6h0E=;
        fh=fHdYXvdIzlduJSMkNQzp1iRSyr0F8knDY/JybaD1HYI=;
        b=jG8URf6D8SjHOShpxnP3kT8LkC1LxMLZBEniF0fnYznkqnmMDhpzSvFis8rl4DqMKA
         GC6Vp93RQK4Geqe9PRjmqkrMr6hO6bDXJge8mW15EXV/Djcf+F9GJurKlj3LpO7gPttO
         V7dyYxSuvBqnqlMU5pNDWq1FFEsuAJK8R8rJbVlUe7o/UTreLqk6nP3upaH6b+62s+P+
         hsT4UinUH8Frzgek8qgh3zYLnIPH7Fq/pp4rj3RfA5KLF1RlUKka8A5jSyxExuyUSsdi
         l2l4nKY3yfA2XffWllkaghjjaGBMmmoBT9Rdm6jH7U9EnH9Vw5cm5fyxkgtiI2YtdnIt
         Tq5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773116625; x=1773721425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J28K3y97+71QGASZ7jtAVp++XirIoMU2V05Xzlr6h0E=;
        b=WAnveEDdsIgqUHepmm13nEPiQ/1SdowU7ZibVzcM64OUNcwHIetZVrYsppIJcRer86
         02yhbt6gJx/7GxK/omVIuT/b3oo0CpriYrJMno2vORnL9dJqGkdwO5noaTzh3DSnHQ+A
         mMvZmZRZXfRbUKJp+9sSqhd2hyTy3RmJiYWcc=
X-Forwarded-Encrypted: i=1; AJvYcCXvFVJRW6FRCAuPELRpblAJaNXLMn+YIcvkLeUZRBZTbcak4oqYJ0cbL/B1LzWWY+fO9fC+Fx4=@vger.kernel.org
X-Received: by 2002:a05:6a00:3d98:b0:823:998:95b0 with SMTP id d2e1a72fcca58-829a2eaed3cmr9703340b3a.35.1773116625124;
        Mon, 09 Mar 2026 21:23:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d98:b0:823:998:95b0 with SMTP id
 d2e1a72fcca58-829a2eaed3cmr9703314b3a.35.1773116624708; Mon, 09 Mar 2026
 21:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309204215.2110486-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260309204215.2110486-1-dimitri.daskalakis1@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 10 Mar 2026 09:53:33 +0530
X-Gm-Features: AaiRm52FYCIyREK6MESWfjDO3-RMjQbILdCDgd1YRxseZc-VMmCMM3-Kz6DIc-A
Message-ID: <CALs4sv2ZPHvmBcwitb0NRVxtbnQtf7742QH2nOOjowYWTF2eZA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: rss: Add retries to
 test_rss_key_indir to reduce flakes
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nimrod Oren <noren@nvidia.com>, Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009af09c064ca3e214"
X-Rspamd-Queue-Id: 21F4C2453DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

--0000000000009af09c064ca3e214
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:12=E2=80=AFAM Dimitri Daskalakis
<dimitri.daskalakis1@gmail.com> wrote:
>
> The test generates 16 flows, and verifies that traffic is distributed
> across two queues via the NICs RSS indirection table. The likelihood of t=
he
> flows skewing to a single queue is high, so we retry sending traffic up t=
o
> 3 times.
>
> Alternatively, we could increase the number of generated flows. But
> debug kernels may struggle to ramp this many flows.
>
> During manual testing, the test passed for 10,000 consecutive runs.
>
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/rss_ctx.py       | 29 +++++++++++++++----
>  1 file changed, 23 insertions(+), 6 deletions(-)
>

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/te=
sting/selftests/drivers/net/hw/rss_ctx.py
> index d7cb30306368..51f4e7bc3e5d 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -166,9 +166,17 @@ def test_rss_key_indir(cfg):
>      ksft_eq(1, max(data['rss-indirection-table']))
>
>      # Check we only get traffic on the first 2 queues
> -    cnts =3D _get_rx_cnts(cfg)
> -    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> -    cnts =3D _get_rx_cnts(cfg, prev=3Dcnts)
> +
> +    # Retry a few times in case the flows skew to a single queue.
> +    attempts =3D 3
> +    for attempt in range(attempts):
> +        cnts =3D _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +        cnts =3D _get_rx_cnts(cfg, prev=3Dcnts)
> +        if cnts[0] >=3D 5000 and cnts[1] >=3D 5000:
> +            break
> +        ksft_pr(f"Skewed queue distribution, attempt {attempt + 1}/{atte=
mpts}: " + str(cnts))
> +
>      # 2 queues, 20k packets, must be at least 5k per queue
>      ksft_ge(cnts[0], 5000, "traffic on main context (1/2): " + str(cnts)=
)
>      ksft_ge(cnts[1], 5000, "traffic on main context (2/2): " + str(cnts)=
)
> @@ -178,9 +186,18 @@ def test_rss_key_indir(cfg):
>      # Restore, and check traffic gets spread again
>      reset_indir.exec()
>
> -    cnts =3D _get_rx_cnts(cfg)
> -    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> -    cnts =3D _get_rx_cnts(cfg, prev=3Dcnts)
> +    for attempt in range(attempts):
> +        cnts =3D _get_rx_cnts(cfg)
> +        GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> +        cnts =3D _get_rx_cnts(cfg, prev=3Dcnts)
> +        if qcnt > 4:
> +            if sum(cnts[:2]) < sum(cnts[2:]):
> +                break
> +        else:
> +            if cnts[2] >=3D 3500:
> +                break
> +        ksft_pr(f"Skewed queue distribution, attempt {attempt + 1}/{atte=
mpts}: " + str(cnts))
> +
>      if qcnt > 4:
>          # First two queues get less traffic than all the rest
>          ksft_lt(sum(cnts[:2]), sum(cnts[2:]),
> --
> 2.52.0
>

--0000000000009af09c064ca3e214
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDqJ11L
ZMpczRHmDGCoHumh/0Pq8w7nV4zwIz0hj1Vf4TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTAwNDIzNDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJyWsMDkcDtm/MLGpk14n+VjnVvNh8ZKfOkJdFJ9Tj
4STY8sI/1eKHmvNmGALNW52HayZDfqSVqe/9n+FVHF17ESFGOBUCWrimOd06HhmNJrgUxql+/Tv8
5UXAtPD00ApAW+bSPX0aksHUYoHjf54NlF1aoePVMrEb3qDl4uGfils7mwMlcJ37dl6NNyAzo5t+
1m+/bHUfn9w+AZKBt0jY2cY5ImqaUhVHQxMnAjuuwBKjGQWYrXgt89FeI98FuUCkfvqWpW08yAad
O89A7tOCGEY75okJBN4yyCbToSoYJEnEX/JhJve38vfl2xFl3mgaR3w1DK0/coUoyc+D405K
--0000000000009af09c064ca3e214--

