Return-Path: <netdev+bounces-272336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK64DabnxWlTDQUAu9opvQ
	(envelope-from <netdev+bounces-272336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:12:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259333E1BE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5767030152CB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECF329367;
	Fri, 27 Mar 2026 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e/rrFI6/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23F328B62
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577564; cv=pass; b=MCQLHyU+J6s01y8YePlnqMDv/Vqp3n40wwBSpM0cKB7x8pnjpdiivhKWO/3/gVRaDmkRneVJr8if0KA93KsmLqQXAtKRgUVjyjheJzZuslEnM+QGjZIHBBb5W3B7VsLHwbTGULLGQ7nSymz+1M1R1rIpYfb798sOUBAEfw0E8mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577564; c=relaxed/simple;
	bh=P/44B+5NFXEJAE+utB4QxUpTAQWkbkxRb1tTKD8qZUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3A4fCm85P6Wr6olWCPoG3m/Y7B29smorWlB06xFy8Xvkwff6vmmZ2Z+NijOtF/hoViJ2ZXjX3xQ4PssVjLbBZ81Y6NTw1e99PZQgN2gPPJdXCbQ5Ok9Djqkyo15Nn1oHjsLs9r+QJorSk622A7bAmvz6+5M8t3UW/WM3kjpaos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e/rrFI6/; arc=pass smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56b7043c97eso703526e0c.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774577561; x=1775182361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz+f97yNsE848EC4aW/uxVKB5lNuTci10YWu7rTR0SY=;
        b=g6Gm9EHFhNt/6ijzYIvou4u9IrpTSZt6kQtyoOAM/monUBqL7WWk/NQMxMaagro96C
         jLn0ZoQELelfEl9PXvoyrfiFJcm+KroUXPkcYZXziHptWcilCXQQ1LcQXoXfhSe4U7FY
         tuRlZ00FWfSsJfO+7kCFLP2onQtCyRfNx1R4cM4g00k+2c+N+Scq+Fp0cApqJBxjFuSS
         5dah2suf8hyAn7gFZQMs+3hZukqdzuLP6aI8vUfcqfDW5w40qIb8IllYie199HuThYYM
         OKRD1FiyYwyvrEAUBQEJ8RaQRy1R/gdxgNo4kaJZqn6CJr584bFaRpQLivg57rqBh7/c
         LWXA==
X-Forwarded-Encrypted: i=2; AJvYcCW2buDO4m0yLFNo7pTY3F/L6S79hV1EFG1bDwo8wAqX9wx22mVV5yvKRM+vntWBZcVsyalhSJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOcacvc7K3maF9IzAYqA3eGWhfLdMAg2fW9F71tVqXkyrPUb6
	e7hwUzKNNxD5C3f3H7UImR6n0thNkknABGJcFf6ot9Lrtii5nK+cxV8uD4fbQ6UoZbei4LjSUdg
	t8UheTiKytOyGwzdJJ/0PwSBS/ndG3ORtgYER8ZcU/dQhPtXMxqr+KkctyeWWiE2mRfvGlQpj25
	9fkb7i0CxnoajKbbBBHeo9WoBkDbrZx5VdQuSrHx47v5C5qQhCPwYILwPOjwr6yVtTuOxj0hoM5
	QHVw9Q1iBs=
X-Gm-Gg: ATEYQzzHDXbiu5C3mw/UBxGw65PEHxMT7SJ57dT7W5F6fxAEP6WMCm1dftCH4KI2NtZ
	de4jQ/N6dBwfmeMAtLhCG0WR2KmnrZwXvzOVw1exKkmQ/Lewk8lhZ9l/McNHcrpeKdbsVU8j4Wu
	41zODvig0SbzXW+17GWJoXO1gXOCA81k/DW6SVcSHcBnKD2EL2heU3z+sdPyXQeM5aW8UZrUaa0
	1wX1kNm9hvM0nYjDCazh7uh5M08epjqQkbmuzpN3WOCdeCUuRhWOcQhNQ8Yt8yS5SMMkwi12sOd
	fNxtQyhvzTrK7yX9Jp0cDuanmfnJhnnrb3Y1NXR+JvePSa9wNqa+LmaJoVWbtYjx4hj0z27f20w
	jv1h17mjYXxKTmOzLsHg3LLobc/TbaZtrgA0KsSssu9QC0qIwZT8QR5ysSGCRAJPdmSAJMYxRFz
	cq3PB7xfFv3386MvjEVA3XfjRSi4y6q7WfUceQ2gA/MoacvMPEvoVIAnk1
X-Received: by 2002:a05:6122:54f:b0:56c:d623:8967 with SMTP id 71dfb90a1353d-56d4a65e5c7mr249232e0c.15.1774577561419;
        Thu, 26 Mar 2026 19:12:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56d318ffbdbsm861003e0c.0.2026.03.26.19.12.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2026 19:12:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-668c932088fso2354147a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774577560; cv=none;
        d=google.com; s=arc-20240605;
        b=Qzq1ZbU+AjYA6E4t0r5XSY8BhWvc0NsJeV4Yv4CKjzWS4h/cxmEUYvl8iS39iKiqZ9
         IMnhmnyGkUEE6WJMkM/eY1uRs+GrYskRsfUCe8w/rjx+PK4b52rDIlDYlw3XLOQEOAwq
         l+zP0SjCpz2veqQ0vDo0Sya4KKvJK2gw6NmoypqlsBEkwZtPCoUypFLQ/E1yb4A1G6o3
         NJUoG5cETQfHRC67upp8DK85avFbFZNccTae32fpSYlkdHmcJm9bWd9ofDPTo6TTXF4w
         Se7TFVxEI5D9JSqL8aIJBvpcWwW4fKPayDEHUs8nmcB5Vc7BQyG2T6866FikBFj3j+6H
         Vl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dz+f97yNsE848EC4aW/uxVKB5lNuTci10YWu7rTR0SY=;
        fh=auCuE5Q0Oj/iTB1g+Zqz4J38yEHAPcL/5b8k3yt2L9g=;
        b=gPcvy804vwWbFVzfxopm6sL9dDLHFqE+q3wxxzUYQZay11AV+MF1B//yB6Oja+hghs
         IcoI1yGTmuJQiOcuXCC3SpKZgbwADVy8+JaK6HzvhON51/gxc8ac6mXG8Y3zTmOa/cXh
         6RgUUl66FLngQNV9rKZ1ro46kh6MOzio+ZquOIMwHmPZQBylCDEpN2p3iHQKGKnM0f/b
         /upBlBFi122se2OUiIlUWQO0oM/KzxbFxIrlvP3O+ycLAD9nJthNckX+zUrJWnSwamcn
         74ogCU4mNCNVWdkyxVt5vHTsYa66T4sM6uizZVsPr3+7KBG4qM5fLlWvgJjY/GDDryMP
         ZpCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774577560; x=1775182360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz+f97yNsE848EC4aW/uxVKB5lNuTci10YWu7rTR0SY=;
        b=e/rrFI6/fBbSxJAaujTzip1YjrcW9b5vCX0NSOv8fqZForVZUiXDhsAy7By13b2Ow+
         WIUvEm2lrbMMr/oXmQKDCEb7nCuHFNKg1KP5eX0LWj4zJqttXjbqQN1JKCGzRkfrWnDq
         wDlM+mQDuZWQjHnm7m1kFX0STu/1iPoZ7GP0w=
X-Forwarded-Encrypted: i=1; AJvYcCWxMETnTq7dDJFNnxSNAxjBTDrVovIql++9ycus9PlEKbUrxtXxhWnvKwE5/1Kavdx0PwqvepU=@vger.kernel.org
X-Received: by 2002:a05:6402:52d3:b0:669:cc12:9beb with SMTP id 4fb4d7f45d1cf-66b28b559d1mr264680a12.15.1774577559910;
        Thu, 26 Mar 2026 19:12:39 -0700 (PDT)
X-Received: by 2002:a05:6402:52d3:b0:669:cc12:9beb with SMTP id
 4fb4d7f45d1cf-66b28b559d1mr264676a12.15.1774577559451; Thu, 26 Mar 2026
 19:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327010235.42668-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260327010235.42668-1-pengpeng@iscas.ac.cn>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 26 Mar 2026 19:12:27 -0700
X-Gm-Features: AQROBzBwtR1gWvWCQFlPj3CVge78NXf05L7zAzLdN4As7yLxCr3Y4o9g42PEtSU
Message-ID: <CACKFLi=W_CV3aNonyU8oOuzr42WpvRw_vjNLACjEVgxKEke3pQ@mail.gmail.com>
Subject: Re: [PATCH net v5] bnxt_en: validate firmware backing store types
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001ab511064df809c3"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272336-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 6259333E1BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001ab511064df809c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:03=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:

> @@ -8692,15 +8692,18 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(=
struct bnxt *bp)
>                 u8 init_val, init_off, i;
>                 u32 max_entries;
>                 u16 entry_size;
> +               u16 req_type;
>                 __le32 *p;
> +               u16 next_type;
>                 u32 flags;
>
> -               req->type =3D cpu_to_le16(type);
> +               req_type =3D type;
> +               req->type =3D cpu_to_le16(req_type);
>                 rc =3D hwrm_req_send(bp, req);
>                 if (rc)
>                         goto ctx_done;
>                 flags =3D le32_to_cpu(resp->flags);
> -               type =3D le16_to_cpu(resp->next_valid_type);

I think a simpler fix is to assign ctxm->type =3D type here if the
concern is that FW can return a bogus resp->type.

ctxm->type is fixed and is equal to the array index of ctx->ctx_arr so
it can be set up early.  You can optionally validate resp->type for
sanity but it will not be used.  After that, type can advance to the
next valid type.

> +               next_type =3D le16_to_cpu(resp->next_valid_type);
>                 if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
>                         bnxt_free_one_ctx_mem(bp, ctxm, true);
>                         continue;

--0000000000001ab511064df809c3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCfQqSb
rXw+e9T95458n63pA5WoZ++LSmHGv0PDlHimADAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjcwMjEyNDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCY0VVglyZOlJIIyEdsYtA2LW4YNoT5K7ob+aJVw9Jw
dKuRn6jvbAzcsvPH9BKwYrWOfPa1lZJabeBoIRofJeOLI/54PrsWV3vOHG6VgrebOVkQGF0qHJZb
uPDlUERJdlBrQo/vbVM3yugjpGe8DO8nhJX2oMNdMzJjSudPzMnjf6T9POFXlppdgQdVPit2zKf3
sTQ96dv1hXrJp7lljCu+ctDqeLH504HxHJeie+w6e67448ls0o8NqhwU6fFQV2cLRPCb6KQnkDvR
eO1h8Cw6MyEdnNyCZD+gtN+QIKxa2FQyOYkKf6IObfMcC86TPwdMMJxwV5ULi2Ldkf7oByM+
--0000000000001ab511064df809c3--

