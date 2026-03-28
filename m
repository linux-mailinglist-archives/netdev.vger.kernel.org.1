Return-Path: <netdev+bounces-272789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBW0E+AayGn3gwUAu9opvQ
	(envelope-from <netdev+bounces-272789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E241934F7CD
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 468A9303011B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6453A451F;
	Sat, 28 Mar 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MaYDclE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025E3E47B
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774721752; cv=pass; b=i5aCPffwmt8/BpzNx+9kZoUu7lkjKQA2uR4o7dUn9QTjBYpXgYMp5NVDJEblL85nqHgDagwec5SVWeQmGywO8RsBB3TOJMEc9rmqNMGyOGxiWsAq4HfCnlr6dF3lAnTiVamwAqGst4cR3tP78CFQ7/2WWsU1IBerGaPDbsdGzCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774721752; c=relaxed/simple;
	bh=4MNEIWLatmfdBO0pHow1bgEvB6z1ujsrTy7tUNHg1x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHhwcbsx3Z/alvxYoAnmVunwh5nUL9w0Qsk/zkReOuWcDha4atftbF6DTbZ12RZjfHfYn6b/xzQmAOUacuSBh6Ij7vMWja3sdQNv11bbkFiNOcqbILxaeDo/PVTDBUnfnPehEJBNiT46nTzB3EHXqKjzUUTMKDY/7BId6zzgB9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MaYDclE9; arc=pass smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-953ac1602f8so172424241.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774721750; x=1775326550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFfuLhkYbuvF14b2wbQw/3qyg992jJ/aCTalRpcXoH8=;
        b=eY2R1X6e4bF8cuRcDNQB86M6RKFjJG+6nPi5bABOYmMnNPS8LuxsYOx4QNw9wSMfwe
         9FX5/ZoREwfh6XwXYUnM9Vx+mxM3jYTKEExbbtaY0SpBCJjU4yuQ5m5xmJk6l58Nh0fP
         fkZ436q2uGVRx6ub0hyeBAJEbLtxRhVsiMFyJ9x2Htiw68CrxCHw2oa4Jomu0698tLej
         z6LiH41v0wJWtbb+bnYtppk0LNW4s14GklEXMeailKfywfD6FQtMKH42JCxdg2aRu+aA
         UDS9x7GHQL4l7S08kx5MoZjQ3o+2ib4+6LLn324SCVDMCY3oqnlFnTL16rQl2xrSufE8
         +4Fw==
X-Forwarded-Encrypted: i=2; AJvYcCWPGPo3ulOXpFVpYCavCUTWBdzEHh9QyxL3h0vNHyAku6VuoasrqnY/90rchd42CoOZr7l8lz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCmSUInC7s/q6o68v8hdxEuK4rfRo479O2UXm8isYxRaQDE26
	B7iWBw+Km/YLPfZv2IowStkIww9dNX8c4zUKr4AU2JEyOslV429QZc3OOHwwbM75rWEVE1QNDbF
	zdnlwSz7p1EwdWVs80C/OXBHZGsPxG2gAKXNSJ3v/LTXVpYz2HzOyd0moew/Nr6k67r2lCrYVqs
	eluv4iQVGlwyC4DVkDrwxVR96Qbv66IIIm9hFGUy6Hl2hAhg/gEci9E918kgi6qd8I4NMXTacwk
	vxzP2i6iVM=
X-Gm-Gg: ATEYQzyPgu/Bbj7GxFrXACMIyJZGi6RCB+RPb+53PP6eqf5bOyueJz9/YJVFIWgGxeZ
	vIR5THdq/U44q5C5B+4Zy4hY6Wt7iwzjYO7kPOfOPmfg1uYVmhFwW6BETgG6dgI+siIstl2coB2
	sBsi8Rw1MZiJJnQXZ/HFY7qUpr3fl2Y3S2RmqyZCC8c3yfwtkihme3cyJ8gu3OsisZJWP7S6rz+
	7bKD5G0yxU6FxbMntSeEVVe1lS3hAKLdQ4s+s3uc0QFSz7Zwftq4WsjX1T5QwTtM3Ii5X809Phl
	lNMyS11bKU5N73IdFzgjuqEvB06PYT+a88sMvOGL17XKD8ioQHR23JtJyq3crx7P6S3834PD/Ai
	BnMIUYHgNTFwl1v+HXMt9KE8ciOLXDV9VuTiTEQbsSnN/R97ezu3FtSnLInavpqTdYTjupCicfT
	Bdy9gI
X-Received: by 2002:a05:6102:580d:b0:5ff:fac2:836e with SMTP id ada2fe7eead31-604e4961ec0mr3930973137.4.1774721750027;
        Sat, 28 Mar 2026 11:15:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9539dff7c59sm134534241.0.2026.03.28.11.15.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 11:15:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-668c932088fso3939081a12.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774721747; cv=none;
        d=google.com; s=arc-20240605;
        b=dGVorlLP/KQoHBAboR86T1rMUfWDWpOp6nH/eyvsImVvOp8ijcx66nVSnSJj37vm9b
         FQpnTBoC5Wf/AQMCgzAjC65Q7/Co0BhVM56SIMF6O2dvtrZDWg+yh7RI7xuJ/nVeaSVL
         qR7g7ilL3pZYaq+hWJ+H6uC4tih50LOSnzRRwav7FZmCc451DsisIDZL7WFNiKipvd6H
         WsYz/ZV9HhYvBhPMDNMji0rBQ4af6odlP1l89VQ/7OhT52U0pTuiIOczDbd7aww/jqOH
         PAeP2tiK3nUR+UYz38Wbd4hdfisEAK/JN3Df50YEkDYDAJRJI+P2z2sizfEiED4Fo4CI
         68CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tFfuLhkYbuvF14b2wbQw/3qyg992jJ/aCTalRpcXoH8=;
        fh=FMDSZ6qiTPwvsnkN5vl3IqKDtavRWGF6dnls98C73PA=;
        b=F/NWISTm9i08Pg3AoriFGXrWNrOoNZqvPOivVGjQR4xrXU7433NdRxj7Xh/e193UjG
         8qA0MnZBz9iyNxO0noJkozRSss+riBf/CBMkETxrpQP/t2SqdBh3WqvNVYJriMIYaDcd
         ET8byczcTYqIKzL05ykm0Jho13wyISSUTWZIc6/arI49E2bhwtNBmbbeMpUSMS0n8i+/
         93zoT1nSwq+phvWKsmtHw/Pmm8XCrxeAfoTj2GshGIg775ZQuxCq921AN1Euh705ewir
         bP4SahF2lM9kCPN8fXe4U2oO59ZMam8w/RHww35YGk9tK7x7X0WDLJf7OSLEoh/U1x/v
         l7eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774721747; x=1775326547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFfuLhkYbuvF14b2wbQw/3qyg992jJ/aCTalRpcXoH8=;
        b=MaYDclE9sEysee04eyceB6+nmxcTNMQLXLikqy1KTgzR3MGLHV7mVlZq+4fh2KINse
         SgLHujQc0BgRQu53KAK71nHVECIsR+ja0veGrhOA9LCy8aXES4azDl7kUXDHJSSeKO0S
         Ah9VikIE9n+dQG9P0SAfFpjqMlK4ONf5ukYvg=
X-Forwarded-Encrypted: i=1; AJvYcCWdPRGemNWCtMGNkcLQ3RT+OxcQo1i6vEeIEzHBAC6gCfw53duUIRBU5b3igRl+o/cg3ICIIHk=@vger.kernel.org
X-Received: by 2002:a05:6402:46db:b0:66a:199d:138 with SMTP id 4fb4d7f45d1cf-66b28c66cbemr3074871a12.20.1774721747355;
        Sat, 28 Mar 2026 11:15:47 -0700 (PDT)
X-Received: by 2002:a05:6402:46db:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-66b28c66cbemr3074859a12.20.1774721746880; Sat, 28 Mar 2026
 11:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328060824.8383-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260328060824.8383-1-pengpeng@iscas.ac.cn>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 28 Mar 2026 11:15:35 -0700
X-Gm-Features: AQROBzALbNiwDk_w0UkzDsRPPkr2nri38ZEWqYSrp4Jmpk4BhUVboPf9oIeksJw
Message-ID: <CACKFLikYnL1HHxamNEcHb+edAB7Swgy46zF5UTm0HOZicwSxYQ@mail.gmail.com>
Subject: Re: [PATCH net v6] bnxt_en: validate firmware backing store types
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000059dafd064e199b17"
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
	TAGGED_FROM(0.00)[bounces-272789-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E241934F7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000059dafd064e199b17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:08=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> bnxt_hwrm_func_backing_store_qcaps_v2() stores resp->type from the
> firmware response in ctxm->type and later uses that value to index
> fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[].
>
> ctxm->type is fixed by the current backing-store query type and matches
> the array index of ctx->ctx_arr. Avoid depending on resp->type and assign
> ctxm->type from the current loop variable instead. Keep next_valid_type i=
n
> a dedicated variable so loop control stays clear for non-valid or
> unchanged entries.

Please change the title of the commit since you are not validating the
type in the FW response anymore.

> @@ -8700,22 +8701,24 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(=
struct bnxt *bp)
>                 if (rc)
>                         goto ctx_done;
>                 flags =3D le32_to_cpu(resp->flags);
> -               type =3D le16_to_cpu(resp->next_valid_type);
> +               next_type =3D le16_to_cpu(resp->next_valid_type);
>                 if (!(flags & BNXT_CTX_MEM_TYPE_VALID)) {
>                         bnxt_free_one_ctx_mem(bp, ctxm, true);
> +                       type =3D next_type;

You can just update type =3D next_type in the for loop statement instead
of updating it in 3 different places:

for (type =3D 0; type < BNXT_CTX_V2_MAX; type =3D next_type)

--00000000000059dafd064e199b17
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCKA9fq
m1gB7239hY0DGZ2yrNO5G/K+BBIjEMXK3YL+xzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjgxODE1NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCNEIPnEt4QiMm87u7PQcakJwhb8OALh2fi4KQ7uh5V
P8JucNh6eIM50cy2kiU2MkY9Z44UX2l6tOOoeGlXXH35ajJx04vc8PdTV3Z5qtKhsV4cUZTWa2co
MslN2AGBVXfyHwGyZiATjUZ6bNnrMe8SOz/kAC/BWHapmimmNf0ndNyRsJaT8plhb0PMnA7cbdic
uYv9M2Nx/hVJop65f0USYL3egLcxSTxcQj1ZwbPIpMOCVQp/X1yIaKx+OSzodeCpm7T+LBs8xScd
PLdOl8tmKcbnhZcHtCPV6YAFPKroxMDEwxG8PdVXxR43Qwy8/O/crk44Wa91hVaXSspdPcGT
--00000000000059dafd064e199b17--

