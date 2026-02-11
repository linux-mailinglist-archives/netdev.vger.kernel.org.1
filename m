Return-Path: <netdev+bounces-258182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBeFO4H+i2kgegAAu9opvQ
	(envelope-from <netdev+bounces-258182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:58:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3012119F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859F8302DA3F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7F350297;
	Wed, 11 Feb 2026 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XP/2H0vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA131B124
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782317; cv=pass; b=AkvQpzppyDDTo6ishEy67FC/2Vjwjl1luFuRBFTdBLUlUITm6UVvdsmtX75pzeXZs2oWjDGpoDd3e4cmA2VjRRbWKOTGpt77FjTqcbXfPq8LQIp98UNw5n0cdC8kchlLDpZku7TvNYEc/Z8NAk88mcvGdv2/+ElddzfbZ8GzjoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782317; c=relaxed/simple;
	bh=2vmLmt3atI7xX2VjQpOfyfGgOZKhhLu2f4djNGAdkWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8JqTiawdfquq10Rcr5od4l7vIZzfwAyu6FCX9cIRiOimQtQD62C5bZhXYogKgXHLvfuo7Cl2kVAJ8XdJobPv2o9SfIxj7ujR1CzDgHWDy09+Ds5ZuLPQqbWZ53wlzo+JZujQrdQxC3QS064b9n5RZsK/CpcEayYxxGphJshZK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XP/2H0vx; arc=pass smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-82491fbf02cso471735b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 19:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770782316; x=1771387116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAvoeQ7lQ72svWiJCFJZA2dEQjex6J1oTQrPCQHqhEc=;
        b=uUU90gjQTx3rn+GA2LDE+45hoJk7uGMOM8nJ8ikJ09RjDeAnMGs3TsUmYolQHuY8Ta
         j2peaf7bsAmy/Trw/DreX5q1X0aV002B73jeGF0z/jm16jBM9Ch/KIKOqqtzyyRMpJPn
         1m8jSPCr/moomhlzkA5WZ0lX0jKad/arLORzjJwLkBqTkoohk5nW7BA159r2OvUHknje
         Gg+DlIOzW+uwwbZj2bE/FV+dpTI+/Mv1R99SjSTp8Jb4jiD6GA/N4DEhmZgXAEZGDsnD
         Nv5y5XNL9ImPLN+EgzcMlp8OykIOrW3WHHUrQioadEL6lS14gDCvw0tDqw8QII7whFLs
         CX3Q==
X-Forwarded-Encrypted: i=2; AJvYcCXf9HJKIEloH5hE/QAz6b8cCTf8UMS8oITlHOeMQRFjbzke+ORp9cdnwGoUrHYE4JOobFhXvbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2z3Q6z06QqU4RnGxIbdK8Il7wj8JC4sH7zoSRm5S19b8hVVX
	uNhNgcEu/me0clI3VNumN/JW03y1PVytJhCRB7CVWn1Sy6ctKCXzkzPZWgzZeIzYpAGkM6aUOj4
	BbV1oeXrWQnY7NJ8iUGo10YBwfoA2h9mZR6vrY4b1KSp3luKb36zb4bdlytU46p4ZJXAliU6qYg
	hDI/xUsnKlV33j9iQpaxqmwRfWyf6senbPNXVeNbMzojpkJvbkenO/MkY0/AERHPHwazxw4TjcQ
	Fer0w2rpeE=
X-Gm-Gg: AZuq6aI2eBgV5Gm2nUVLjmPgnWz/4ZOAxHgELqtubD6lOSXP+EPlY0S/A5zAQI4GPMK
	VfSyngz9aogjEnATOc9hiec75V+MtoJS02wvuvFWlgYEVxogS1f9rxF63aCQA3xOQFhsmZandTQ
	CiyUsLSd+i5F9puwf0XXppkgryOY9a54ohJOkBj68dmIdoGPjbORI+dn+wOzSTFiSRrsI1M55LW
	AGwFzlpUJKj4jl4SdYLNzJ4v9ZfLqG2QuCQSnP43oakZununkQJ9SEriJOCqpGCBoamaGvFviAb
	6mEM9Ce6SYnn4SbK5XsxeSkcvze32s7QnLX2VRWFeHA4izQdgitrLbC+TRdxXaNlDLMAjk/hY+B
	BromgPqhWoaTXTHlAXY9zLRZZeRjP7PFvdE2GSvQAFDSBd7rPsabFXxCjjxroYZEfb9hEEweGgz
	fmo8kXZdIkOcuu5CXk9cbvwz9hUbeEnxuJVSrfw2+b6bLgy2ynHjXjFmXX1Us=
X-Received: by 2002:a05:6a20:e282:b0:341:6c8a:5218 with SMTP id adf61e73a8af0-3942e6999c2mr1315989637.56.1770782315728;
        Tue, 10 Feb 2026 19:58:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6e195750cbsm94114a12.0.2026.02.10.19.58.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 19:58:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3366437a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 19:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770782314; cv=none;
        d=google.com; s=arc-20240605;
        b=Yfqh7jMZnXY6zrGgscu7Vp+G63UBHUAZUbl6iaGN9HxnNpKmhTxmXlvwjXiYsM+KLm
         GZ3EdDG+mxMvyItpHLMGOOFE+MkioSqB8K8cB82qGBBYliH+hMpftY6Ggr/5AHwUXFTO
         Ypshzr7Aq/uCBF6n5r6yC8V/KnFuLV1/0a6tHrooQhHm8EjeS+6OPikjOPInlq50QoSL
         DQAcC608B+SLXqSYsgs8YjM/eaGI7iaJTiJnjQwePS8lWUWeFZJpwCIqayJ0v9mbHjeS
         r1ChawqZtSYgZJolXYSl/7y4cuw2uv18ZsiZIBQzW5/tAK6BW9bnvfpvT7kUgaaBaWJF
         YgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QAvoeQ7lQ72svWiJCFJZA2dEQjex6J1oTQrPCQHqhEc=;
        fh=pRYFeyD62UGO2TStcrnHG3ZYum1JQt1kK9Y5yJIYejU=;
        b=ZN1/aDE89XAMKS1p31qEcKz/OkDSuLl9kKSBza29xoCMQ0OdyPoyXWjXnlk4Bx87q6
         kKpwrVTPhCnJLxzcR5wzyB589tDU6g347ZETl2MiSQ7lUB5twr8O8DFa9Rs9dkgaUqbG
         IFtGFKdSeE/iAP6Atvo0YHJUO88WHKzJAQALLnb6Ca02ulypOTQSnSySL0aqVqf3qwpE
         TTxHj+aja2oHwWnN4MmvMdRpLIqStANcf05FGx/G2uxYXxQWlMAGtm7G53fFen9gxj9t
         8WtvTpR0Rh9D8XIuby4ObBKHXYM9DT+PnEfWbWkHMgelAVC6WRoUofSCRcQ4t8I2jeDj
         wIiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770782314; x=1771387114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAvoeQ7lQ72svWiJCFJZA2dEQjex6J1oTQrPCQHqhEc=;
        b=XP/2H0vxKhZ+ejAmQ9DWi6QrOHflqLmFjvS0ESaPdnbFY7+CrXHamSCKzUZ0qoaIWs
         2rPrpzHNb7CVJ3AaZYlaVoIXkPPMvis0kmDecnSJEFQm1FGI6S/I48HuNy4Nk21+/6uA
         kDBaHo0KztYUE4F7br1m16OVMiy5hjJh1ggyI=
X-Forwarded-Encrypted: i=1; AJvYcCVGorwrLSzDQxCqOfBdkhS6goI3JhGA7z19l+LWPiTWnDMOPYM5POXfMJLjc2E9V03oCSa9J9E=@vger.kernel.org
X-Received: by 2002:a17:90b:270a:b0:356:3ba2:1233 with SMTP id 98e67ed59e1d1-3567b0796ffmr1165798a91.22.1770782313891;
        Tue, 10 Feb 2026 19:58:33 -0800 (PST)
X-Received: by 2002:a17:90b:270a:b0:356:3ba2:1233 with SMTP id
 98e67ed59e1d1-3567b0796ffmr1165788a91.22.1770782313536; Tue, 10 Feb 2026
 19:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
 <20260206052930.1882740-5-michael.chan@broadcom.com> <aYY2sak4adKOGRSv@devvm11784.nha0.facebook.com>
 <CALs4sv1Z+oWNT5myaEr=LyZsLCGUYfOKAet_bc+fmw7g8PbaxA@mail.gmail.com> <20260210174627.2360a03c@kernel.org>
In-Reply-To: <20260210174627.2360a03c@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 11 Feb 2026 09:28:22 +0530
X-Gm-Features: AZwV_QghN0fXaaEg6eYclLFy_ArAzfZvvZ335Bq0_0tSJK2MI9bCL_zIdaxZZao
Message-ID: <CALs4sv3hca2N=+w9A81ZLMz9QCHqA7OzGFOzKGswd2sy+9zt7w@mail.gmail.com>
Subject: Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Michael Chan <michael.chan@broadcom.com>, 
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d0acf5064a84627d"
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
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-258182-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 5EC3012119F
X-Rspamd-Action: no action

--000000000000d0acf5064a84627d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 7:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 8 Feb 2026 21:56:39 +0530 Pavan Chebbi wrote:
> > > > +
> > > > +    import subprocess
> > > > +    max_wait =3D 10
> > > > +    ping_success =3D False
> > > > +    remote_addr =3D cfg.remote_addr_v[cfg.addr_ipver]
> > > > +    for attempt in range(max_wait):
> > > > +        try:
> > > > +            result =3D subprocess.run(['ping', '-c', '1', '-W', '1=
', remote_addr],
> > > > +                                  capture_output=3DTrue, timeout=
=3D2)
> > > > +            if result.returncode =3D=3D 0:
> > > > +                ping_success =3D True
> > > > +                break
> > >
> > > This might be wanting to use utils.py's cmd()?
> >
> > I checked and tried using the cmd() and it indeed eliminates a lot of
> > lines here. But the test itself becomes a little unreliable.
> > I often see TimeoutError: [Errno Wait for file contents failed]
> > /sys/class/net/ens2f0np0/carrier from the wait_file (Jakub asked me to
> > use wait_file)
>
> Does the link take more than the default 5 sec to come up?
> wait_file() has a deadline param that should let us wait longer

I did try with increased deadline. But I don't think it's helping.
>
> > Also, even when the test succeeds, after the suite exits, I cannot
> > ping the remote host for a long time. In contrast, my manual loop
> > worked 100pc of the times I tested.
> > I am using the command like below:
> >
> >    for _ in range(10):
> >         if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=3DFalse, timeout=
=3D2).ret =3D=3D 0:
> >             break
> >         time.sleep(1)
> >     else:
> >         raise KsftSkipEx("Cannot reach remote host after interface up")
> >
> > I am not a py expert so is there something I am missing?
>
> I don't think there's anything Python related here :(

What I wanted to check was that if the cmd() invokes some shell and
has some kind overhead that could affect timing..

> Is it possible that NIC reports carrier before it can actually send
> packets? Maybe the wait_file() gives ping has a higher chance of failing
> with carrier up which makes the neighbor resolution failure more sticky?

I am not sure. I am willing to send the manual ping loop version as I
have high confidence on that.
If you or Bobby insist I must use cmd() then I can spend more time on that.=
.

--000000000000d0acf5064a84627d
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCuWyC0
wWvzr/vCorL2r+BAIYyHz/yYQbs8j/3mIu770DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTEwMzU4MzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCP4IAdaISZsgGktTtK69wetrbCwBVcTxVYK6xs0ghL
H5ZXWGvK6nkfGc6q4soOX78OgoOBIhTxBvP32jtuedXpU8ymOqXnoSh1G+z/o0t3wEwQ1ISr0/RK
81kkM057qBtamYX1xKotOWvvIlcsNQhy22kUpr+Lkt/X4SQ3vo3GPZ7DqDcTEvxwSIgEH4Q2Jyfv
zmz3OEHP8Vx+IQAkqfykIi+VZ0N1ohDExtE5pcdxcks8/ZR7CYM5YTXpoOrRe04xfgwgNX/5vKkd
vTyS4USLrEM0ZswoIQKo/WV5lEtRuKgIWREJ7sEdI/8Gd3yNdZ5BoWxleUs2PkWzm4DkPmaO
--000000000000d0acf5064a84627d--

