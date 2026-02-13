Return-Path: <netdev+bounces-258681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOhhAy6Qj2lGRgEAu9opvQ
	(envelope-from <netdev+bounces-258681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:57:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7AC13983F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6AEB30254DD
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26113271471;
	Fri, 13 Feb 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gL7pHGPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97025A357
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016233; cv=pass; b=RrPpcTh/JlVGzl2d/6DKFFBepPTR0fHI+q2DzWq+NJ+AQObvo34tUAHm+2W1KktOOROrrE+VYz8Ugv0Eq2oEOeLB1W26/Pit01rkKGxgxI4/3fcAgV4VTorGl3XAFVr0twTm8ybRbcAEz5ZxRyC4BqazJ6TsrkEpNXVhiRWzpO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016233; c=relaxed/simple;
	bh=ZCffmHNwVx0QDga6i8YWCfOK0f0R8e+LZigaNSO3/do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs8wtHDl7JncUdISbIBPErL/ZX0HBswO47yNBGbt7NH4uZK2ttneQj2w0UaGJwi2K0faeC41KflX0tEgjVLAQy2URrV6DxWlssWtKy2MLgmqNrkbAxI/MkzquzBqDGWGcIw2aPXV8VhOgw5nIpl4/XmvP8b4jMWwL3bpBI777qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gL7pHGPs; arc=pass smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7d15b8feca3so1408911a34.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016231; x=1771621031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb/6lj7XflRjM5grbK72FTkQGfMec0UgNgu94YHzYis=;
        b=up6CnECDB5QyImH51Eby39OoAafIT6Xih/CFAq7zEFrCs6dlCWcvWuHZOWKraOSmti
         3nmJH9oQMwT5Fc+3EpFUcmEmbw1rcA5A/xc21mYTnW60JoMO7yr+OgKfqg1G79TK5HeJ
         r7qVocuZP3cnfcsbBmb1B60c4eJZIGae5Kut7WLPYWg5BdsgVi5QSrY5+WtHtRZTB5Zp
         W4ch36TOgEkfqxuDHEMTS9GAHWY6ZZD7haGi8b9OLvBSLoK0iI/Jw5cOC/8PVunHaNsh
         toD/jJ5WuyXlIw9+rKHIT0z8rxvHaBAZ43gi7hVK11jr6x1R2lPIHqMhiPyz1gowA9e8
         1ogw==
X-Forwarded-Encrypted: i=2; AJvYcCW5aMAnuPV6j+ISRfmlmOYrkFROmc3RcVWdUEtQrn6y/Ha9jC0Tv6SwXwADHvSheG4KTFDxzDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+aGxYfeUzJYvtenn6QTl1KMBQp9Lvaonzjgp7oLcUoAT7zSU
	r4WYvjoA6hi58G5f0LWJLf91pgYAh3F254IC0nVG1mybFBPOJ0wWkqEk+lJXt6iq+TysHrUlHFy
	Uwtfu4ivp/8cP1zK61H7ifJkq2Qs7RyQCLd7c7EkHBdd/V4Dxsi8lmZgnoN3wvvkcW06pSlFWX9
	e0y5ylIDleCPLLdPQbLpXj9Gozb4ZbFvzHtMvb8PUwI3CUMGyDV4SQCVZ+PaLcJ7W/IOt+Ts8ff
	u0Fp8ult4w=
X-Gm-Gg: AZuq6aLARNXAe6A78GFW7G3FjZwIPTPLgglzrQ5o68CGhVFS8qiWXwRY3m36kCTjLJh
	5U1x7jtmPm4mCUvFpMDGT5OAPf0GwBIxI7SEZVZ+haw62XCvbW8dyPIokUEJ1oMdMfFdEKP2F+6
	mV27geJrQVEFBN11ocoKaSUii5fum93P9TdTFjhlKqvC5L9+sozaVel5IoIWQVy75KUh8HX8RIG
	GPCCjdThxR0G4vHIAqkAZTitlxWAHcU5pEFvXtHfOz7xmrPhbjZ3qwwmzHBcVl++Z0e8shNdbYD
	zG2tLJP+7bWOXoP1lTagoRHjleMEYYVH1kFCJL9V2+J2SDRQymAlv9yUL0k/1Cj4UXarL37GSoF
	NGvxPtNdJPXyV8i2ag+xladmJlMGwvpjhlWHsIL+nbaMD1Qf9uyfK9VPZrQr188+R36qV/AZ/qj
	0auTyGPqo67bjLX6ei1fN5x43yHVNiEe7ECjixWAwTF15+VUIKw9rMUeWk
X-Received: by 2002:a05:6830:67d9:b0:7d1:49a9:6b53 with SMTP id 46e09a7af769-7d4c4b2def7mr1834425a34.33.1771016230646;
        Fri, 13 Feb 2026 12:57:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4a75cf928sm1414927a34.5.2026.02.13.12.57.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2026 12:57:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-658150fd8f0so1327472a12.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771016229; cv=none;
        d=google.com; s=arc-20240605;
        b=HTgiuFxHBtJtC6NHexSNkkUnbGW5cqZNeU21IcN3FTZImmbvLZHaEfna4CBef4u5up
         VP0f+EO1xcBPmbsi3Qy4qKV5SiTkFwG/ULbE5cF1hdIlVuIZZQk/KRgg8FPGTTWjGIR9
         z7+3ccAwbhwxGxFxDe6TYPM2DPSOlt4IxNd409VmpFYzwt844pod9cOsRn4279q6B+oc
         YM4aN5xMu4m/Q0CNUHcQc/UYRa6KQBJX3GFGjEiYveUCqilhGeY+zFLklmhuvrrkT2BT
         OMwTuPIfHlivIdJ3ZdwTZ16voaKCdlGkLsilxYgDHCAaI9ROWxcSy1SN0W+FZ3CynzEO
         cZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Pb/6lj7XflRjM5grbK72FTkQGfMec0UgNgu94YHzYis=;
        fh=3hhN5pyO37co/dpwpaYaM4wDta9UcIOf4UwowEB+cjg=;
        b=ZwPRpEdlB8/8ybBjjHvf8icTt4RzBKOQK1mKimBuCud7MecXnvloaHAJg1KfVNVfYe
         dOWwlosh7YMsEkBH4ZYIKs2/nEYaaBG6l52jMX4sttW69a/UqNNI8PHcctbavTpsejZF
         lVXW4XPswqzwg69BqSnQkLt8Rw5z89osQVyQv99BSITch0JGRRpTTj1SZCIBYyZI46hp
         bhPRl6s99cmqjXnctRxA+9nuJce5AvSD6cTBEyvDwYy/c7wLzvT8k+GH7nM7YZTWeazT
         DaR4mOyiOxh/1tlfggbzyzRI+t49F6i2fUJ+H9Op/ReLSypEo7BB8mV3EKflcp4UqKVx
         sJAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771016229; x=1771621029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb/6lj7XflRjM5grbK72FTkQGfMec0UgNgu94YHzYis=;
        b=gL7pHGPsSur5inLdGHfEyG2aC9t6SBJYAp1qJIcIrgDSFi8e+nzWwQaouJQwzfL4Nx
         MWHFQBrJ8IP2Fk1Dm+JKH/RX2C6oaACf70vsI8bVANYeOdIGp0M6IOJwT4NOxG+P7K9g
         cNvxoWp7bhTYGw05eU5dM/J5cWgx6s/zIC2R0=
X-Forwarded-Encrypted: i=1; AJvYcCV2/lDse5KyQW8DY6ClBAn3UuMO/um4g5q/6ZnNKR3Bwyqi9DF6g7vlGD7FbQG+A/eHK9OT/R0=@vger.kernel.org
X-Received: by 2002:a05:6402:3647:b0:659:389c:a0fc with SMTP id 4fb4d7f45d1cf-65bb11963f3mr1060661a12.27.1771016228756;
        Fri, 13 Feb 2026 12:57:08 -0800 (PST)
X-Received: by 2002:a05:6402:3647:b0:659:389c:a0fc with SMTP id
 4fb4d7f45d1cf-65bb11963f3mr1060654a12.27.1771016228328; Fri, 13 Feb 2026
 12:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213074503.2302046-4-michael.chan@broadcom.com> <20260213160604.2515258-1-horms@kernel.org>
In-Reply-To: <20260213160604.2515258-1-horms@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 13 Feb 2026 12:56:56 -0800
X-Gm-Features: AZwV_QjVOWfXcsx9m4zY3mKdYR7rFY7JnlVEiLnzQLjs381rsy4FuVyLtEvphNo
Message-ID: <CACKFLim+0c8+8wqvhRqGML9qCV6EqwQ7jqmkyHP8NBrtcOtfTQ@mail.gmail.com>
Subject: Re: [net,v3,3/4] bnxt_en: Fix deleting of Ntuple filters
To: Simon Horman <horms@kernel.org>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, 
	andrew.gospodarek@broadcom.com, andrew+netdev@lunn.ch, kicinski@meta.com, 
	netdev@vger.kernel.org, pavan.chebbi@broadcom.com, davem@davemloft.net
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003b4cde064abad9ac"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258681-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6E7AC13983F
X-Rspamd-Action: no action

--0000000000003b4cde064abad9ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 8:06=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bnxt_en: Fix deleting of Ntuple filters
>
> This commit fixes an issue where ntuple filters deleted when the
> interface is down would cause FW errors. It saves a vnic pointer in the
> filter's base structure to check if the VNIC is already freed.
>
> Fixes: 8336a974f37d ("bnxt_en: Save user configured filters in a lookup l=
ist")
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 8fc15a8353fc..1f05ecf367fe 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>
> [ ... ]
>
> > @@ -6240,6 +6244,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt =
*bp,
> >       int rc;
> >
> >       set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
> > +     if (fltr->base.vnic->fw_vnic_id =3D=3D INVALID_HW_RING_ID)
> > +             return 0;
> > +
>
> Does this code dereference fltr->base.vnic without checking if it's NULL?

Yes, it's a valid issue.  We'll respin.  Thanks.

--0000000000003b4cde064abad9ac
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBd589+
MGa9yxswJ99lZhWr+OJkWPJmuZdVsZriFHGMCDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTMyMDU3MDlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/XrdY180PMbeszWdVnXts/H3haD6UEDf59Dmjo0K1
smwa+0gv6jHWecgZBqRQ/5AWoXcniMwQzNlgv8UkP15i8R+sVna16LJQNQ1UcXwzvssUdBp6x9Bc
hegbmxI6pCh9V0L8eBPQxqk0elEpDwG83P/FXgnUPFQpXas9p3KfA8KcEDyN3Vungf6gOyd8c+Kg
P8hbB4nMajXOeaE8Mgu8y0W4Y9j8RfZVeJ8sDI94dmCB4UctmkpR5B0vDT1Q0e5GeFljP6NvuT7a
bpm5OoVNM8qh7Czskgv8lHl2+9NBe1HxEX8tt2d4tq8HZKlDYsDUiFzZ4w4tvRrfIcfY6xhP
--0000000000003b4cde064abad9ac--

