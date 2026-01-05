Return-Path: <netdev+bounces-247148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30761CF50D9
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A243102521
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF5329E5D;
	Mon,  5 Jan 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XWAawLfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E4320A0E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634821; cv=none; b=fyzqPb32YA/WJ4HXqshsowCrm0bvqPqpDoRaX7/0CdsbR+lfJQMKuUaJHYg41ei3RqxImRRpJ+WB5ch9QWfqGMe1+qvca3efQubb64gRijPjDP+ZOmryjHLaGbKoPutz59tFLkuWVzTRd6dvEVcsUL9f12PViNYpNfmGq10t+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634821; c=relaxed/simple;
	bh=89xqpNnMH+E91cIRYqPSjAmKaVRDBjVjmUtXY+acvO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Obpg3njV0NAO6NXg6GMSrqr/bRuvxGDfzXzoAob4IRmCjy6S6+qcwuvr5SHvv6AeHVLeAUutr1HeR55mPcletjN5ioQ5ndFSEls05JwseCBY/QLOfQf6CWjgV2ZtO/2iLUWpdv6atdDFW7i3VqJjNqzxgjSPwbH6c0MjR63rSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XWAawLfN; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a099233e8dso1370555ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634819; x=1768239619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvoMYdf1VhjYHleW86RyBmXA0pc3VXqNF+I8y0NEGZc=;
        b=DFneDmtjy4EoeIPTo/fp/VL4zOEzua4oqDKqVt4jq6XklbqBXz315QCCM+vRclAs5s
         7Xw8yWpBA7eV81LBxGrglvFnFJRWzOFHyvgK0W76oVIopULa8xKJafpDrP8QBwJ5/aoB
         iWFFBQjwMETv+la9nPcHP1yGZOYgRtmoVWYu/Wp3CwCFkoxNgsntME8U7zVInUDPHGxv
         9zft7USTE7ZeUqJv48YMTmMjEs0t9SbgSoUaDhY2STugb1/vPLSD62w0HpKDtmd4wolk
         /ZCblxoCvl2k2tg4daNg/ajSFFTkIek6Wv5/buUp6l0DPSnssLv4bYFefRnvrqCKxy0y
         oQwg==
X-Forwarded-Encrypted: i=1; AJvYcCUtiFL59T2pPV24u62YfI9ruASCIl23UOdegrUN8Ea4MCRTFvgnB9wWHrnSmY6kGN9qXVOiTkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxY1CHyI4pRZVook8mwBzT4prYZLYqgcxnAjQMcR15aqy0i8qx
	Tggiq+7jtCERluB+zU9lLO3iYK7Anw9YkHhdpsWnrCJ5DYpWG4DqgDd3Mv8aCffph0TFou1OAaQ
	6I6SCYmrfyBsH7loS/cRyDbWxwk8fTJ3kFMEoQc4MZ1WCL4Zy4UUFsEw6XAwKUASljmWMP19urq
	pqIcaAhycI3FSncC+66osSle/TWGsRL6pYDlf6+wbde4dvR2QvKO2X1bW4fdXKkNZk4jGK2sGRW
	RdM0fl7ADU=
X-Gm-Gg: AY/fxX5foXsSIK44b0m9vpeSm33xgFB8KIhZkMMHz6guYZU3AYSrS0NTo8TAcTnq252
	dGxQ4LFLofS6QiiQ6Cywc2fhK8dGYCBdhQsX9EJc7YnwPNI5g1F1TBmNuRGYz4b8yDVA6m69+Yd
	IdBtm5SSCWbMnecHd7JZF12QfMom3NJuMiimxl/F9ZoqGPFb7JI1ACc+dgdq2laa2AD4F7sU+1K
	0VPe6kiz6e14vXZtULh5fFhql2nqnG4tThjP9LZFTLq7txyYscp6Kuds9vzxjTPUsoIAJL8MBzG
	3IfQjbglRJwRog/lyOTbg3ujNvEIR+/4XJyvyewbPb/E6cuTNroB4YmuN3IWhrMu75FWYdlJypo
	CnrWRzLmCmdUD+L6/ytQ0wvXUDYuHvGZlav4taJp1WP3tlKYTEAUNyGlaFVx0heanexD06E4BGS
	oTeMPDnxUUfJR2kZH6MEIT60wD2urwPnTDj16xxQGvbQ==
X-Google-Smtp-Source: AGHT+IHQA4FAkpS/g/7z62L1Eme91z6hwSeQvHrGJyZUuggBB7339Eo5kM31tvYJXSgTFvcfyFYnK/C7Gg/z
X-Received: by 2002:a05:7022:45:b0:11b:803c:2cf5 with SMTP id a92af1059eb24-121f18e6492mr105360c88.33.1767634818765;
        Mon, 05 Jan 2026 09:40:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f115d13fsm87170c88.0.2026.01.05.09.40.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:40:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b771bfe9802so21359466b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767634817; x=1768239617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvoMYdf1VhjYHleW86RyBmXA0pc3VXqNF+I8y0NEGZc=;
        b=XWAawLfNvFZGmraG+VsKMrD64VYX0Tlg/JZVHTZlUqCpjyCX0YhTXVhMZdl7o1ttrV
         A/M3X8uRJYP9LHQvkSk5CeLceRgLRFh0y44GCAi766AOAl2bYCEASBj2PKYIq/sYZwtr
         5LEeFqavbWKGIBX/ePVIxZYGGQ4I6HGchjOoU=
X-Forwarded-Encrypted: i=1; AJvYcCXp5BEOtQ4E59sHjibbGj1KGLl8NBkIz6PYUFZNubDe+VTLAlTQp83IJE9lGhuYbKIS8YqLOXI=@vger.kernel.org
X-Received: by 2002:a17:907:7fa7:b0:b83:3294:979c with SMTP id a640c23a62f3a-b8426c1fd46mr61307566b.58.1767634816643;
        Mon, 05 Jan 2026 09:40:16 -0800 (PST)
X-Received: by 2002:a17:907:7fa7:b0:b83:3294:979c with SMTP id
 a640c23a62f3a-b8426c1fd46mr61305566b.58.1767634816239; Mon, 05 Jan 2026
 09:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org> <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
In-Reply-To: <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 5 Jan 2026 09:40:03 -0800
X-Gm-Features: AQt7F2oxTTAyuMJj_Ku_CWE58RXVPhYudT9UueEynJkMIEEysAk_tdHXFr-tAGc
Message-ID: <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Breno Leitao <leitao@debian.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005cb0720647a78d1f"

--0000000000005cb0720647a78d1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:51=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom.=
com> wrote:
>
> On Mon, Jan 5, 2026 at 6:59=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >

> > Second, __bnxt_hwrm_ptp_qcfg() calls bnxt_ptp_clear() if
> > bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp) is true or
> > hwrm_req_init() fails. Is it really possible that we have the PTP
> > clock registered when PTP isn't supported?
>
> Right, this check may not make much sense because we call
> __bnxt_hwrm_ptp_qcfg() only after we know PTP is supported.
> Michael may tell better but I think we could improve by removing that che=
ck.
>

Some older FW may advertise support for PTP using an older scheme that
the driver does not support.  The FW running on an older class of
chips may also advertise support for PTP and it's also not supported
by the driver.  In the former case, if FW is downgraded, the test may
become true.

--0000000000005cb0720647a78d1f
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAGhnsL
E6SR/rimW4TwDHV7YlwiTUhmrXg+CNW863OtMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDUxNzQwMTdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBz81OpLORfIKXbYAPXBFpRDNJlEmi3SxSOmjemOmGe
F9gkjZtWTihAw/kQwPg+LmRgOHhbexklDH5ruSUrm/EJ9mwHcl+uA7/5146R9Gx5mxtRnn7q4wv9
frumqQ7nemMKCLYJo0SEPARh2hMVtoBF9Q3TRRKT7tIBZC1Czrs5jNOCxpJ6U30evUV0apb21g2R
yX1VEaBO3cLLcB69K9G+B3X7WtogpO2cNJJ+4nM72NJxzS25OZSibwQTbiKTE5W3rVK8mw5rWATl
ieJyaFDy7T3YWESry5i0o3vNROOTkLHsU7QSJashFWvMNn5u1SgKHYhjZ+IpEO8KTgdLoV+5
--0000000000005cb0720647a78d1f--

