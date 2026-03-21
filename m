Return-Path: <netdev+bounces-270180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP+IA7JQvmnsMQMAu9opvQ
	(envelope-from <netdev+bounces-270180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:02:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DA2E41A2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7413051ABC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77A349AE0;
	Sat, 21 Mar 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aX7f2TxK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13ED28C87C
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774080106; cv=pass; b=MA+L0AJFHkkCn09FUV4KBZiCRCZlx43dst8vv7JjJ6GagKMKkSfCTFLI1UhoYe9H5fdFFmIiO0v7YDpK1BTKnJKzpZ3JkfFpcm7PI6FxevUZcZILT5lE9H1WzNK4+vRijb6Asp/qCWpEtkEtjHxXwLJ7lsOsm5QXdVlQrP9XaTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774080106; c=relaxed/simple;
	bh=cdgPQeNB+FV6KQG5XTnvUlHqrtHO3Cn/pZSSTwMWbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqmhG+uvlwA8z5q0sJNKoMiU5ogMUfAiq3BxbRtFEf+huLtuT+88D+BFfdlsLm6hG2VvsdIgzrCEZPGz0jev82KI4YOjk1SedkrOfO9zMBi1nQ8gbfNknw1HMrki5M7WB+lsgJPcpodGpCc/sIUL3GRMqoz0NzGM5/roZJM+uQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aX7f2TxK; arc=pass smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5fff77ff719so1598089137.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774080103; x=1774684903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqDOMZky8+GhcVt2h+vfnqu9MPrPPbI4u4vwxuBs1Iw=;
        b=m7oL+huqavzSFmmsjatm8YSHgPM1wXL2lelS3Kr7MsB3KuwnvC7XyD78EI3t2qcgAY
         ba/jTEbsWDyAsEMqIG1wySJP8AbDo2xKu4FreYtwe7Sj0qVd4PX8qi6nlrYOtdVcppQL
         aalnudpMfDRutrxCi6+d/jqMOAkzWPxRUEVV7FyNwIY935Qz82oyDJCQhwegjXsxetIb
         5YxurpmM5y2budTHC2h9tWc15hKrpggLK9nxqdcP1pCWoqiIGwK8qKx1kXApLARc4lUm
         p2HRiCBhuMj0HaWOJojNH5lh2Fdq7liTPoXTMsoEqvBhsb9ZshV9DXC/DX4pwTXgIsJQ
         wIXg==
X-Gm-Message-State: AOJu0YwOHcWOw2ZcCprkFr10TwuZ5d75fRbdhS1pwpc/gfqkeJTDqJIW
	nGEjMATtIYX0OiFwHpz1MYHkrf83MyygIg3aQAjdmyQFCJQavjqrqQ8/WbpSf/uC3hJK3twqduu
	7tXpYLacfOk3L2MgKa9krUeNjMHPC91FMKlrLDgn/WuTYiW5IjHdcJXlQXGSKN5lGJtf01xo/bM
	/B1F8cYouTR28sCyhswhBKVqWInpiG99oJjk8lYo3Qr1IW2WqnPHD5vV2shBw5VINy2OiGCAtPS
	A8dvKKI9Xo=
X-Gm-Gg: ATEYQzyK8N1Fr2m1SeYAYuFBmbnSGu+HELMkaS6qiv9NTNtr2Xku3UI/ADSk45U53uP
	JuuyYvLdE2YvHdQByaC3/8PK/0kE4jpij60v9Kyl2d9NTs9TJEKxPuBkyObHUvp0gsTOL8lKEVi
	agoL5nm9REshqIweWHH4aZJB2b6hzXHPqYFl6JF8HPCGkHVkpLFH+GasSW4ZdsakaxI6UcVgSZb
	YnpK6l5hD4b6MSEVTdMlIusYz553mvRlQFGGdeQpdUsszneJNGvdUpw69mlQ7pYyQiypzHTyCwd
	K6VqJQ1aZgqy9UqvGP5DcxjX1xDKwgdyFzWBckTlzxPltAXw02bKsumNU21/0bUvHL30y8tzeaB
	ZphRR4qNrRz/+N4ZfSJM/7kmjiXueVA3XxdYJeZJW7YXoRPD2Nqb340K0oU7uF9IsfG+rvX5ToF
	s0rDC567EQ+EpRZEuBEZBOycUAd0RGT3TRB44+BfvSlAA2OxXaSRW4+/4ilIM=
X-Received: by 2002:a05:6102:6b01:b0:5ff:1d91:a4bc with SMTP id ada2fe7eead31-602aeca1964mr3375684137.18.1774080103318;
        Sat, 21 Mar 2026 01:01:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-602afbc6727sm537873137.3.2026.03.21.01.01.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 01:01:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a5ee4a9acso1837032b3a.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774080102; cv=none;
        d=google.com; s=arc-20240605;
        b=R+6fvseIeV+h0gcMU/A+dpXRtcZ2vnoNn4P4vfNEKJZkPCyC4O7nFPvE1+BrQOWBTF
         pX1aHFCMdmffcBGVDsf0asmRf11grlA+RvTNzHcMMj+L0e9T4cFsqL1OjLz3JqQfnhSt
         05EAC5GKF/+jvNVhP2G+XhdP0qOKedL594/9JIntLlyMC3VqFJXxbX/C1IVlL3UBqLjp
         XBgnx+ExUJDZPEqSpMu3e/BSonWnOr+feNlnXW5YT5dpnBiSNWdKCUvJ+3VPKnBkrRGe
         oVSoNwBGEY5h6AGuWpuLZRiW9fukhIVT0PmN4nhrkbfzYqrGZ7RKdueCP9+0BjcQIzfd
         24tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vqDOMZky8+GhcVt2h+vfnqu9MPrPPbI4u4vwxuBs1Iw=;
        fh=LJjFplQUHAr+CvXD/eW2CifsxvdY6S5BlUAlPwxTQdo=;
        b=hK+7p651UJhiwKDYsgYXmYhwlec2qCpOqAgDqgM9qsqn+S7eUf4im+5LSgJJ5WRNZP
         +RUp7gVxdMKU+vPKnFibfkK5TJTmKRiJau/MsaRMuwJF+hHSsNEA1PvpI8ajIBmKHqCA
         50YKSaILza6jXsM/ys2H81NB5rsHrJ4BF9CCAaT9uHbiXZreHzg3YDCmc5grR/sNSzIm
         BSySZFRAbRgGt5eMkY71mqnJ2B+WfVIAeI8vHnDQq/mP9VQPwVFC5faUZCqowZvwrzzk
         eTbW9IfSHqaNku83SYSmI+61YD6T0iy1JNYDlXKEq4T+hFgBBW3cgjzu1qWBTTigsxaR
         v4qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774080102; x=1774684902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqDOMZky8+GhcVt2h+vfnqu9MPrPPbI4u4vwxuBs1Iw=;
        b=aX7f2TxKgH10YabLundio1KzoLpDt7xkq302xtQETDBA5p16vCVD4ev2T7o/jtfS/4
         JebpMzqp8e8mx9GkrzAGMGKLyJVOi4ytBg48+GL1DsCbrqrV7BhnkIM9dp9EQANshz4A
         Q1NfcdmlPzDodCRjh3BNBSRxDo5dZBsXq8xic=
X-Received: by 2002:a05:6a00:368b:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-82a8c35ddefmr4974965b3a.29.1774080101621;
        Sat, 21 Mar 2026 01:01:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:368b:b0:81f:17b:c70f with SMTP id
 d2e1a72fcca58-82a8c35ddefmr4974935b3a.29.1774080101121; Sat, 21 Mar 2026
 01:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-13-joe@dama.to>
In-Reply-To: <20260320144141.260246-13-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 13:31:29 +0530
X-Gm-Features: AaiRm51S_XlZZIGLgoOSpSAY9m1T-8iETPm7TxU4TZECq1lYTfDv2HgwSavZxbY
Message-ID: <CALs4sv3+Fs=rwhKBGGxAU0fc+Hi1x00-occLwObxq=sqxOFNJA@mail.gmail.com>
Subject: Re: [net-next v4 12/12] selftests: drv-net: Add USO test
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	horms@kernel.org, michael.chan@broadcom.com, linux-kernel@vger.kernel.org, 
	leon@kernel.org, linux-kselftest@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000048c766064d8436a7"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270180-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 642DA2E41A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000048c766064d8436a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Add a simple test for USO. Can be used with netdevsim or real hardware.
> Tests both ipv4 and ipv6 with several full segments and a partial
> segment.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  v4:
>    - Fix python linter issues (unused imports, docstring, etc).
>
>  rfcv2:
>    - new in rfcv2
>
>  tools/testing/selftests/drivers/net/Makefile |  1 +
>  tools/testing/selftests/drivers/net/uso.py   | 96 ++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/uso.py
>

LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--00000000000048c766064d8436a7
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBnqR+m
sH++0J27IsFUud/IBRgIIza5pkqaOosRtLSk/DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwODAxNDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAyim2+JVJUIfHnBB7p10+LKUaJqIUtBQcJ6xIOWjc6
fv0zzo8c7hTM5qacIsjWgp38n21s3mi+EpZFU9GdmKF/8Xah44LQui8zWQelo/dSpvPlle/Id4fg
RUY3gytYy3a6+pYyWxxQA+lgczo65ymgsntWMtmTSEdNHTC96m7Zzc03XLtQVCQqLl04Pqb35kpi
0saVmOdFyNFlsSzk+U6SGg/LcaCapYyB0ndcTsx2oVTjuGFBxs6KYWwoJkSLhL3VVzKcExeZ5sKc
BgPnO5aBYMjE2UdelcdDT0lvnAGI9ZwKxr9HjE30/DCrO1U5WNVEQpmpZ3OeDkUGcMv3K6x2
--00000000000048c766064d8436a7--

