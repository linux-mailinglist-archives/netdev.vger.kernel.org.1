Return-Path: <netdev+bounces-301132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D4a9FDA9OWpBpAcAu9opvQ
	(envelope-from <netdev+bounces-301132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33D6B0002
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:48:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=dVtzqILR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301132-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301132-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1B83300B29B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC03AFCFB;
	Mon, 22 Jun 2026 13:48:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6863B388B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:48:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136100; cv=none; b=VugTOcCucTX1uzksapWN0X623wv/VYfuFDZPfTGKLmb1wUEEBWkxr9JRh+5sKE9lx2tnEdJkTKOanVa6AWhr//IVAaJcletghAPJ0u7/eqdOiqIlaxAEv4dqfJD/WfwGOK13kkJIcy5+EAj/sTmVYUqliDUMZb6XQWx/H+2nZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136100; c=relaxed/simple;
	bh=amOvE5NYqy9vKnwFj8n7gTIIVHh09bvmsnmHOzeJPlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE2MGQpcH91xwrO5tYI369lFvyzCnU9Bo5Q5aCNA7idvY5MwVxjsN/lIz1D1jOYY3k/HjqJpI6dBCO4WUojCThExkX3yQxX1RFGQmVdm+fEt/HQTr729cTd7a4ppxpmtfga+ePQ0CnPIkzrzS/jA5UzZCXDgBz1b5Bf/I6VKi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dVtzqILR; arc=none smtp.client-ip=74.125.224.98
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-6626b5ace23so5374690d50.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136098; x=1782740898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr0NiFKGrKH5JZX+QdQ0uDSs4SRCJudtgtLXR+ZCh6M=;
        b=SIjbKVamhlF90bYN8b30vvXP6zODnvKnVBn7WCcEtBJfKwtjGU8pwRTpKnR2jMskdC
         vIY3p1iAa3ETQxl6qDg30EeTB/rmsoBpFf0vEK+WOesI28XrNZ1c7lU7TY+2c5u9+Ets
         Bxv5sKg/0UTM5OxV5OISrVX4eY14yQi1vMM7Zrx8hl7WU0ImmWSkoVmCXWrRbh7D1d7v
         Ksvs5k30k+Dy8avauI7zz1HrrkzyLWL0buqOYrj7bbQpktSlfJfoLQmOJwDqpnkG4+zd
         YyliWQVjMp1QMJ/lCGVYjvO6mFPlXz/f85R5k5ac+EAGrcVDsDzeqy5UGlEA8s4esc5l
         NAYA==
X-Forwarded-Encrypted: i=1; AHgh+RrB8BmPzAG+VKtx6v+dRV6qmeBTMk3svZOhSHSorRNAE2PLg6a65B2f2nlmGTQALY1XHIuhnCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMWUFzdvSvT1AHjzt7vYJhUehEOT/9sL/NnTee7d52ON/FEvC
	nAAffQTFPxlKbHZP+BQwIL42tx2MmC2rwI4CA5Ys7S18ePPfgGxeSfBg9JDDCE9JadJxGdMJLRd
	nK+KVa4DBEucXiJGQ3uq04piOQ+Ikere33MHO5WwWUoiuO0IYXwGQtGZyEkMSszDbip4fEqCPU2
	fc/iTIAGdWIIEPupuGtNjd0l/cDO32B9l5JcAsMm71JaOeF/HuHSo07dIB4h6KxqEr4SLs6+xJj
	ziE6l0j2Xc=
X-Gm-Gg: AfdE7cl+Peiy+S5WmUeL5HNbN4+vAT24un3dqeWM5CTpV/vr2F7Vunk0hLkJty2foeK
	wt/ZCsF1fD0nw0kkpWt09CdaGKcr1xcWPLZlsn9M3YcurZQlI0nYXeTdQBu8bnXSPdvBly026w3
	vdrM8zyYMjpAiffzV9VbC1XBc71VGFyYn+o19dKLSN617RNWTMZwFY/DKxiQppfQdUsC2b6cyTt
	FcR49fI/6O5Mq77+8P9+XFTq1lWP/9tTtRN7LhKmGzUiFLGG2ZWn3s8e1zYbQBoHwLO5vHOoXHd
	8PV4PdLgOgYvEHAHwHgktHxy5t5yQlY0R9+0tl2pCMcv+6s4JYjQJLCFl9b+/T6bnAdANW7e9iu
	Z3j3vl9EPHyuaDKybh0QvxeT0jxJxmW8A2+q+NctCGxj0912JyCnlDGzc1hXbiDZ9s4CdqXxhz8
	zuDwehKPp0CIeojF5JVkxQrEpHEnILbYy2vzsLXCiAKzVvGQ==
X-Received: by 2002:a05:690e:c41:b0:662:c16e:c1ba with SMTP id 956f58d0204a3-662fec6dbb2mr10091784d50.0.1782136097731;
        Mon, 22 Jun 2026 06:48:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66314c4b121sm495802d50.16.2026.06.22.06.48.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:48:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69763cb0811so2604214a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782136096; x=1782740896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr0NiFKGrKH5JZX+QdQ0uDSs4SRCJudtgtLXR+ZCh6M=;
        b=dVtzqILRu9OxWx2JWyqXobL4osStSc11N7OVKjpq46ptY6JNuis4uXpUhY74VuYoqu
         z9VTPGbyrmitlPyLCaDgcWjAxGyVFYD33Li4ZgQLFj4FXrbI54wFnCnoxsBNTwFZk8Ze
         cObkOn2OSj9NC5l4rVmtcqX2xHKWkvdlGWXxo=
X-Forwarded-Encrypted: i=1; AFNElJ+lCdNTwF1hhKg8oK+HLLB74LXDrbLcO6wg3aYC9pK00HhSwWJA4Em8imLCkGWHCajkMFFcpM4=@vger.kernel.org
X-Received: by 2002:a05:6402:520d:b0:697:be4e:93a7 with SMTP id 4fb4d7f45d1cf-697be4e9562mr1336002a12.18.1782136096154;
        Mon, 22 Jun 2026 06:48:16 -0700 (PDT)
X-Received: by 2002:a05:6402:520d:b0:697:be4e:93a7 with SMTP id
 4fb4d7f45d1cf-697be4e9562mr1335970a12.18.1782136095617; Mon, 22 Jun 2026
 06:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622112925.624795-1-tariqt@nvidia.com> <20260622112925.624795-2-tariqt@nvidia.com>
In-Reply-To: <20260622112925.624795-2-tariqt@nvidia.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 22 Jun 2026 19:18:01 +0530
X-Gm-Features: AVVi8CcWh4KOXqckSMFYa38ijcJFbcPpp3jI4EFohpvxwX6bRKBYKWjgZ_JSd0E
Message-ID: <CALs4sv3sisO-4yvTpeFzVS5H7R+Z6YP8md2QZHZKYBGZ4F3+Dg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net/mlx5e: Report zero bandwidth for non-ETS
 traffic classes
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Lazar <alazar@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f888a10654d7e469"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
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
	TAGGED_FROM(0.00)[bounces-301132-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email,broadcom.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B33D6B0002

--000000000000f888a10654d7e469
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:00=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Alexei Lazar <alazar@nvidia.com>
>
> The IEEE 802.1Qaz standard defines that bandwidth allocation percentages
> only apply to Enhanced Transmission Selection (ETS) traffic classes.
> For STRICT and VENDOR transmission selection algorithms, bandwidth
> percentage values are not applicable.
>
> Currently for non-ETS 100 bandwidth is being reported for all traffic
> classes in the get operation due to hardware limitation, regardless of
> their TSA type.
>
> Fix this by reporting 0 for non-ETS traffic classes.
>
> Fixes: 820c2c5e773d ("net/mlx5e: Read ETS settings directly from firmware=
")
> Signed-off-by: Alexei Lazar <alazar@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

LGTM. Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000f888a10654d7e469
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDvwrPU
2jLmgBicO0RQoACb3k9et6zkJe3xMmwirb2pNTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MjIxMzQ4MTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA5rxuVXK612fBPYve4sHL0kkdVqy8nQ9nw/qjXnVrx
RUXPqAqGOs/3R4KFh0PP24GYleI7w9a3M4pvaK7k5TIdKP+viiVmr4awN7o+Maf8cbLIW5tUWREb
qQy2u0gA70p7dHPD3kPbTl4j9TD1gBJQj75ZDtjf6RZ9u72Are940CZb/AzSjJtCWwtdJ2V834SG
3jKyEpHhxboXkGxTRjTbxXKEAiP9bKgIygNRrGJfBHC2ZZQg5y3r7LYWpeogVbavdTyEym0p6HMC
q1UoMEzYVA9I1wH8Rnnm+vmIpN5ZK48wwvLhQpSlM79/OF+/wcTxmIKoWH3Vkj+qoqH1nl3t
--000000000000f888a10654d7e469--

