Return-Path: <netdev+bounces-301129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XsSuHew5OWqLowcAu9opvQ
	(envelope-from <netdev+bounces-301129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:34:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE5C6AFE5E
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:34:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=DXX+LsNw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 049613040F80
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED83A9D99;
	Mon, 22 Jun 2026 13:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB93B4E8F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:32:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135143; cv=none; b=QPVdfblrSIeBLr4YllR/a2i5krAPT0epAQT7QDBvAT2znccah/E/26pqND2l8Yp8EO4aNqha2Lv1QWy4LxU+diR+JjzTJg5lp15ncR/1PT1NC/SC45ntUhEBTMNiab5H6mzHLGfomZR4etqgeC4cN2C85m6/sxyQoLizeZ1r5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135143; c=relaxed/simple;
	bh=0dPMTWSh3QcBAeoTAEWJv6fJuCFV0cUyVP60Sn/Odrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9hWb3K2fqK7D8n/yQApJct9d4KVbg+hPC4rdHvfSxnqw21+1JUv/ZN5shrx5rNp5zsPd2ZoDV/b1ebyhUbqNcH+CdAC4qDH7G8aBYvRi/GkP7tGfSZO0mnAJf5cvfg0/WUlq4AmbaTpkVfT8UazyCxZfIGLNDDR+cK3u/Cs29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DXX+LsNw; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-519ff1c8b8bso25987081cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135134; x=1782739934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvGxT1+m/TvyBu1unkvildlFuAaQVypG03jBPrRyz8I=;
        b=KbIbDB6/PH5MLTpgllXGLDLemkqECqkEA4wdCGSpCJ5/CZFsVrBEvJcbRgDaSeo1Pc
         32opaMEdyl15NtuX2qvyf8kkKPYPHl0esplWXqlPk8HBjMkeQ9yr0kOdBq7wfdcCEl+S
         D8E9ld6U2aVp4zj+cvr4aX56HNmDe2aekcA68+1QA88YAraQl2Rslq4y1okAnec1ffLH
         7IC9X+2vMj3lkVWbUuCRdMcqfjopz+24eyBshEjp4mQ3oR7QSn5x0+OG9zfSCwhMMU4a
         fwQeu4n7UdZZsAUv9UWm/Hw/7wEHVHeVtQyEvPR4eH/xAaB0bEhtkErZBbAZbGaz9p9b
         ThMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uoxhcR3tTcGrnUZNuA3IVqpM10qWMMOj5wfqIjzow3Tr5jt9Xit7rjNFd1tM/sh6ikn/Ixgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzCYZDAJGwP7Ke+K5sWEn2X4fqS6ihEsffsKMs6d2nY40cbTW
	Sg72WwFgxJnn853QbDkt936X4FyM1MDLeQ7m+IetLb5ZJqC2LcREoFw9d9hqWzF9amhbgf7fcwQ
	QN1rupAT6buiMSY47ucJkDNHniCjYVWbO1eO2lrJXE0AGsw2YGJ65Faaqu5Z7yUsbH/JP0t8D7X
	f1QXSi0kPIvpcVBA0RFrP8d2Zgkafcc9Ob0lWrmBKp7aP4qJzfg80WDhWEu0N+PsaZjv4zsqRby
	whSWVwNiB0=
X-Gm-Gg: AfdE7clrtXfSNGWu9zZ6BURQO8PxDrDh9PAOEL094DGSnPV+7TLlb2YPBiYG8b7R3yw
	3CuovoNZq5S8aFQfQVvwcuzS2bEw1c4xl/jgOantuRbg+ccO+iqO0kUnkjQegCJqfsJiIDUPksM
	wrLK+q7I89boPUMGGP6LtgLAWgkpR6d9etorSqe71Aon7uZtqPpcp5omS3wxOtSdSRvnC09O3Ki
	n+oWP09l/2MJdjNW5f+9IMz0zUUuOe5d+ghnVFkzUCyyhXKSJEtTZF53xQ9q/d4BxkLqkgCfGtg
	ESUY/PmnR+ZGoE9I3KbHFROaQP9I+lP9EZ5+D5PewGMgDVXPDL66iJ8H1alvZr9Irms1jkBoXEL
	wxVekf/KTHYT5SIMDFwsqhsnZ112N/3b+DkojsNq0oY5kJtmVpPtD2vovy5ywLr0PJPXHLFY+3q
	I27tTEbBrlaf5eqD1fuKcUThQxt4ox3lBCvw2Tn79i/3MoGg==
X-Received: by 2002:ac8:5790:0:b0:516:d781:589a with SMTP id d75a77b69052e-519e4a77316mr215785001cf.22.1782135133853;
        Mon, 22 Jun 2026 06:32:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51a0cfc1cd6sm1256561cf.18.2026.06.22.06.32.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 06:32:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-697560b83f4so3494585a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782135132; x=1782739932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QvGxT1+m/TvyBu1unkvildlFuAaQVypG03jBPrRyz8I=;
        b=DXX+LsNw2LA6+FaOEXYJf81qf1JxaxXQBkuZGze+01gz/SwU/KcVue2SNPY/z6eC/a
         6+2FFNFYM+zo9/O0NOB2zjHNEsfrOMUe79hwNLtwn20nfPGSXa0uJVqYVWwbz6dW6IUK
         TC1kagszgBOn+Cq/P5L5TZrKDTXZoySevQbDs=
X-Forwarded-Encrypted: i=1; AFNElJ+NBHNDTFC960zbVxEyov2a+8+mnxOlsmQsN6fFtT7GSGIZ8U8kiftQimTC07iD1tIHi4Nkv90=@vger.kernel.org
X-Received: by 2002:a05:6402:3492:b0:67e:9cd6:c68f with SMTP id 4fb4d7f45d1cf-6973bb7f98emr6040600a12.7.1782135132261;
        Mon, 22 Jun 2026 06:32:12 -0700 (PDT)
X-Received: by 2002:a05:6402:3492:b0:67e:9cd6:c68f with SMTP id
 4fb4d7f45d1cf-6973bb7f98emr6040554a12.7.1782135131491; Mon, 22 Jun 2026
 06:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622111825.88337-1-edumazet@google.com>
In-Reply-To: <20260622111825.88337-1-edumazet@google.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 22 Jun 2026 19:01:56 +0530
X-Gm-Features: AVVi8Cf3EqQoPzDMp2Y5rtewbgocsDtpV4wNLcJP6iKHuG6F5_Q353jInQIXE8o
Message-ID: <CALs4sv0zuPRD2gsnfB+z3eLVtdEojGSPg2dYagH2Y9MZET9a8Q@mail.gmail.com>
Subject: Re: [PATCH net] veth: fix NAPI leak in XDP enable error path
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Guenter Roeck <groeck@google.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008539900654d7aba4"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301129-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:groeck@google.com,m:bjorn.topel@intel.com,m:daniel@iogearbox.net,m:ilias.apalodimas@linaro.org,m:mst@redhat.com,m:tariqt@nvidia.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com,intel.com,iogearbox.net,linaro.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBE5C6AFE5E

--0000000000008539900654d7aba4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> During XDP enablement in veth, if xdp_rxq_info_reg() or
> xdp_rxq_info_reg_mem_model() fails, the driver rolls back the changes.
>
> However, the rollback loop:
>         for (i--; i >=3D start; i--) {
>
> decrements the loop index 'i' before the first iteration. This
> correctly skips unregistering the rxq for the failed index 'i' (as
> registration failed or was already cleaned up), but it also
> erroneously skips calling netif_napi_deli() for rq[i].xdp_napi.
>
> Since netif_napi_add() was already called for index 'i', this leaves
> a dangling napi_struct in the device's napi_list. When the veth
> device is later destroyed, the freed queue memory (which contains the
> leaked NAPI structure) can be reused.
>
> The subsequent device teardown iterates the NAPI list and
> corrupts the reallocated memory, leading to UAF.
>
> Fix this by explicitly deleting the NAPI association for the failed
> index 'i' before rolling back the successfully configured queues.
>
> Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
> Reported-by: Guenter Roeck <groeck@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/veth.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000008539900654d7aba4
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDLypFJ
CPpuSM58K2oKkskuFjtvd1th7dkTqFcpZrd6BTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MjIxMzMyMTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAp0ZaZoxhyFXDYsOwmTCXqFlKYB8bTqzQsqvT6pdzI
1B6xdgQJehiG7nVThDYMoOJkpV4HhBzf46HTFan/PzpZdr39wlK6RaOYjaQyHKrKqzmT3wY5/PGD
5g8rEV99VVJIlb37ehAZcgxtG6zs93By3QpJDndZpxHfHJef5Zz0Z9EupIZxYHl5jarg2eWKp9dk
L7MNvOGPwdQquUGKGZtJeKRcczr7HSu+Qc1LhfryDXgoPpn30au13GJoWYdQ+kY6W4UELrz8Gfka
jQAptAstnnO+UtbpPNJc7spP3OWSu8U95dcYadUDv+PHZ+i07+8bgNOuI4kEnYbr+tiFABwG
--0000000000008539900654d7aba4--

