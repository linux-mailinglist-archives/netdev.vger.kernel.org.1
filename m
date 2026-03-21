Return-Path: <netdev+bounces-270178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XdsoLhhJvmkFLwMAu9opvQ
	(envelope-from <netdev+bounces-270178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:30:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569E2E3F81
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5711301BDFD
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F32E6CC7;
	Sat, 21 Mar 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fRXF7YIP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82E253F13
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078230; cv=pass; b=Fc7Z6cGDZVjkk9pnhN4KufA/4bDhDwZIWDmakmBt1RdnQ4uIrF6Q1x6c5Q+8kCezNQj9QFKCeA8euEOw6dsIkDzkRGTq38spW0TUWLy19/oXPgzETOnuuKsYV18qMgDPbr+ejo9MDOTiGOkchoWI6gfwzaHqLlQdshGB6aEus8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078230; c=relaxed/simple;
	bh=0lTtfbvi4PEp0x1p++nSTxWIjnQl5lWHk3dUJ+zl9Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1L7jOQc9+P6nwoXU2WgeM9Skk0Vlr5nqvQRSI6+OFNpAKH9PghCEw0FUMhp3dH9xPQB+GALyA7Qav2wPN+yFI3XeUlb1DOQUarBrfM6JGHNE+ktWV2JigYOYnYjyUlHG9bxnQREWKtUPSdIfeCxxItudy9vNgfHdTaiSdMED/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fRXF7YIP; arc=pass smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2aecc6b0861so14996645ad.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078228; x=1774683028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8YvJYCZRNC9lzYE8hIuub+imfUKFVvPmTKlgK3x0Oo=;
        b=X24RNCiRnfMGetF1Gd4qhJmcHpb1ZeMbtFnSMc9FCU8v5bHQO1opPnwDmXZJZt+Nip
         I2Qkt01NBJfTGhDGqIEJHYntT3M1eVNZyTPCM0uPHAr+mV1P6fzLaferkL3E9DjgjsGR
         utrJWsOnJzhoUAO5ToL9Q4GWr7d1q0gbxZecpA8DGzow6P54ajT6HU+dhGhhelgidkfw
         f0rFUkly2Ryb2Sk2RigwbB+PpLoHe8qLTiVXgUaGwKf5SlPedGCm+cVHt1iQVdntif4D
         JJjeiTsdCpiIK/cYIMSkby4JptCQk5dZvauegJclEeEw64dv/2KOFNPTGbWPaR0unJuk
         b43g==
X-Gm-Message-State: AOJu0YwM0BgxtKRu4KeG2E6fHNOWBOqDFq8VQ4vpHzPdt4kFC3vBzcYY
	V1Lsjb5K+qfH1mF5hp/yA7G6wBPBKjKfJDz24d8g26ibTBIiYSIUF/WsbG3NsZldQs93T7ra6MR
	TWrx/ww+lmkX7KeawLi4ISXEZPIvGBCoGNRSNbnop4+h0+Mvuq5d6jxGOdvKHyD7PX+zZg23n9i
	aVuLJXxzReTyGX63FIDbrheEUJFkPS0tFaZWcrzrXFg8ZEzgMC4Q31LgIwF//do0nAG1J/LRud9
	v9eZ/4U8QM=
X-Gm-Gg: ATEYQzxdb6a6l1vIoVwOkYZODpL1HnJi4Sg64N9FG3BfOrgMDUnSiReL3DdTC/Po3T2
	uukuf6b2radhGNMasBnsA633084INXNL5LYR8JKjLZwaq3ajSsKnQY5qKu7npTehC+QdUWAJVnu
	9KWR0xw4CA/2rjXtNo8i5crk6mVHwdDYVRS8WAXmKJxhKj5YMVvyD9rB42Il1y1/CCTpB9QCl33
	cgyc8yDExZN0dpjM5AmxtHrwGBamY1K257CEQwnWXYX72mPG0mXxI2IkRhq0PM2oe5ubUEgsfb2
	807JPhCPl5g5Wd1t5Wi8nM55IWjuZp6WoH7uBpY3MUvWg305oIRdYadLfNAUhWfoLfzezcyMnES
	+1DBujSn1wU4VAnSbEdH/6VJfNIz5iwguAvlxX/+Usovzc0OBi/JVXSNtAAuKp+Yg2kokDUQMq7
	xJ606KbWVFhMPEZ++3rW97Vi4SrvwRj1/HQKEjRrdf8utPg/C7s3YQYxZZd9s=
X-Received: by 2002:a17:903:2f87:b0:2ae:4800:141a with SMTP id d9443c01a7336-2b0827d24c4mr51522265ad.32.1774078228259;
        Sat, 21 Mar 2026 00:30:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b08362625asm5651265ad.51.2026.03.21.00.30.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2026 00:30:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a855dc82aso1510446b3a.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774078226; cv=none;
        d=google.com; s=arc-20240605;
        b=DGE0QjzHrsNaTNiEvnPKLfPGo7TKcHwgx1JnJpCPElEs26MAOPcpKUd+b4lgGDgrkV
         GO7v4Z4WhLhtnEsLNbiq6xWdGwx1mlGrb9losobQxeoOI1maDqE8Mj67jCx32RzNaxxw
         86wTdYsttIBUUMwqlEdE6LiSjLfsX37ssmlMFJxSe+Zuvxax2lARjgFvDMJv4uBytOrE
         20SPiqAyN3HqFWkjABoP9p/ZL0aRa8OM0t/QYja5Ud02HQ4L+OHftNrnHbmBuuqGHobe
         0yjiAstgI7tbBu3wY78xXnm/ksLqqnArnzoT5S+58vMCTxcWo+KsADvIhXyotNT6cWIb
         rBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t8YvJYCZRNC9lzYE8hIuub+imfUKFVvPmTKlgK3x0Oo=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=CPNbe+yfnCUXVGuV5vVnfRzpnwb19Qfv63YymjyjFS/1mg3wEDA6+nIaqty6Yz6VLY
         hzxFZkUYAPHDZ9VTt+bfA/d+7QFmVpkY9WgYXoSHU+BNIPx/d44FpiW04X8Yxb6WcwuC
         bkb5xBh0QxXJY0OCrgNr8vRgWhNjJI4VntZkiTwq6fU/JKgFTp5VhyUucgTuUHAyeGg7
         hVok1kqS0zFrS5u6i95IaHhi+rS77zdtk2Cs6Q1AbTVHOrFUbpyZPtZzEeBDQ9BiUouH
         rOHMg4MzmwB+lFDQY/d+w27FwdLKEThBEQV31bCq7TJ0ZOkOql6mOerMYLrW+QPVa5T1
         MwmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774078226; x=1774683026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t8YvJYCZRNC9lzYE8hIuub+imfUKFVvPmTKlgK3x0Oo=;
        b=fRXF7YIPamSPyA0T/i8dQGG0MOeARCMICboVp0tPjaQHNT7gOfJi/ka55J2289bH7x
         IeaCDA4whryDwxa0uDz2I2WVBM1CBfdXLT/elxVBbsCyGuKJc67LPusvR488ra2eK4Nv
         lYlXVzE+XGQP/U9VtA6hjwY+A/tkmsNX75RN0=
X-Received: by 2002:a05:6a00:2d12:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82a8c39ed6bmr4870534b3a.52.1774078225844;
        Sat, 21 Mar 2026 00:30:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d12:b0:7fb:f87d:a0aa with SMTP id
 d2e1a72fcca58-82a8c39ed6bmr4870509b3a.52.1774078225380; Sat, 21 Mar 2026
 00:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320144141.260246-1-joe@dama.to> <20260320144141.260246-10-joe@dama.to>
In-Reply-To: <20260320144141.260246-10-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Sat, 21 Mar 2026 13:00:13 +0530
X-Gm-Features: AaiRm53ky_8ms3B6RW580M11oZqY5X55cCPwdWvTaW0hxlmn81-NM8jF63RF2so
Message-ID: <CALs4sv36Amr1vB0u--JUCQsdVBeo36UusO-uK6zwH7E_CigkEg@mail.gmail.com>
Subject: Re: [net-next v4 09/12] net: bnxt: Add SW GSO completion and teardown support
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007b9f1c064d83c644"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270178-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dama.to:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 9569E2E3F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000007b9f1c064d83c644
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:12=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
> segments:
>
> - MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
>   (the skb is shared across all segments and freed only once)
>
> - LAST segments: if the DMA IOVA path was used, use dma_iova_destroy to
>   tear down the contiguous mapping. On the fallback path, payload DMA
>   unmapping is handled by the existing per-BD dma_unmap_len walk.
>
> Both MID and LAST completions advance tx_inline_cons to release the
> segment's inline header slot back to the ring.
>
> is_sw_gso is initialized to zero, so the new code paths are not run.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  v3:
>    - completion paths updated to use DMA IOVA APIs to teardown mappings.
>
>  rfcv2:
>    - Update the shared header buffer consumer on TX completion.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
>  2 files changed, 91 insertions(+), 10 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000007b9f1c064d83c644
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAI1XJB
HkzrlAc5u3v2F1gfeeq3bjqjjhujYjAp3Jg9UjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjEwNzMwMjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDEhLToD0hItM7AohVPpZGs+OHD4m77swZ/rH/SmWgU
3CEZgeyuqpZrnnOh+qoXq88K1IyXsV5FKOLgcSiAsarz7US6tnmJdzD9En9zZIEeHuKs5EvAr6+O
KnbMSracFUMOqdmOpL8WN4GfK+jyHMe1+kP0uGjvs/dRTRfLh8qDeLxd/dC5wX0Wb0zLRL7jnoHw
mhgUhFPBhQLwLMCsPL0PRq1iVyqsNFWDgRUW0q0HdobtuCFqQSLhalS77/4xVC9BIsht+s80RWn0
Pwr/eggq/hZYKCQuJfaEG3RDzG+B3zVREkccgLlkA59iCSGFs+SpKgRj2uyiTROUSeJtK3RP
--0000000000007b9f1c064d83c644--

