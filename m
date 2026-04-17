Return-Path: <netdev+bounces-279235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDK1DkbR4WnQyQAAu9opvQ
	(envelope-from <netdev+bounces-279235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF974175AC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88541302EED2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BCF1BD9D0;
	Fri, 17 Apr 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MxuG8X0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34E34DCC7
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406585; cv=none; b=hHmnvYcI+uBxI+zvkDDxXMS+SO/ruqQ6n+ZqddLCMANwD8Pc93O5UNVU/pp0WqfEFHnzOj/h/xwJE4izRhGmixVXKapq5Op0URaPEVZk6Kl0ya4F95ch8TDkxFyGMWxXSFCrty4lL0a6+NJ94bo0QzWkQzBAZlTWUiXmiZ9aP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406585; c=relaxed/simple;
	bh=rD8croMS6Vi5o9Op74/hGoEnR8mqruLYN/cMIh3cyfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0/Gy1fDIPs/mUtcVCgKpMlqvSdRVgVg2rTVQUzXFlSdTdwZSR4ymesDAMwDStE4koZ+XC5TU4zj7f0gMFAsPrtXY/PDMlq4SZRV1XI+rA4cN4jSN3G4MBoQIiY35Qfco/SPkZpvlLOxB5iki/jOpAM/KZHVm2Jxcm5tnekxmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MxuG8X0k; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so309536fac.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 23:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406583; x=1777011383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEUNnjj7FEF44/ZUliK+9PRDgxKDw1bmVwX64JeQz8o=;
        b=n3wy2V+bXh0lZl1Wea3vhVm7IuivWYG7V700x4/84FI0tBUsV9OJtmwCKaUKgbCAap
         hohaURLbAG6cvv8N7wTrRhOZpIitwD254ECZiXyoX54BKcoIkfUYV2+CP5pNJQU4QIS7
         1TC1ftfcmslPFAiYFRipjixboe7JACgl0U+u27FXzTprW2htxMNIg9Od5vspMn5OOtte
         +suYwOTq/ZNbIcpZaQfSoU9DFg9uVtss54XacALgmjfsyd+KHQ4TDSPsy5h3ea3VOwcd
         SULTKgy03aovPHQmSd6ElVYod9dKjI3q+8UhRexjVfhYpErtkG146ipm9bKy+YB4N8Ol
         +zaw==
X-Forwarded-Encrypted: i=1; AFNElJ/3KS1RAEuZVE2wiU0PjoXRg7v+66UEI5QfMiVYp2qzvkiUsMH0Dhd+9x41PgKumTgfsZKnivw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+OKxDG1q/O6YvPsUK1+NRPGy1cQE1skw1EKmEZh7x7NlsPUv
	cZecOkr8FokhMJ4vpvXuHbB3Wu6qDbRxjqvfPWdBk3QQ72MYvDKKoFY9BaO5miSEhjU//gBsaKe
	uEjMq7Ua5LT4e90Wz4p/W6GPWnoFi7Ex+W862Wctt8vivxhkapIoL1sRGodajUljpmaUaWOeryy
	AJXw1mzSLh/wgA6L4NEaA2Y63s/ynM69tnWzblMvdFvRMl7QuA3ttZJFiLxoMVGlkfkN3CwMDU7
	ijV+40Pqw==
X-Gm-Gg: AeBDievQTuYehfTZZQM9xs1YxrzPQjlTX18cI0Daf+YUPMWWgPFK+sW6o1/hLsH5086
	nG6CNXVJx3u8S45QSS452xfvm1eqk4yeDQxvE5gcZfjyYNXWu3NvQLKudTtbBZ5qrn5EW7i/FKd
	TBNeEHgWqTgpsefuUr4iIVYtlMl2WLS8BXchxLo3lTQ6IryzmYXQiyWrHrxwLNeuZ7BlMxkrOm0
	g5Or3Qf6WQof139IgHgx1OnI2j9LzdieotxUYjMi/5P0M5uU6yn5wnAQiepdPpBddL9HeqGd8B6
	geO3TVFm57sUKSDvkiDUhC7r1U7v0SPuBe5F5ouGqvESSsI255EJ5wGKmOSQHhzTwKnfAYyNpY9
	H8dKBxLDzyCklkRzBLVTwFlmmnpNAOnBm2gSkfkM+dn31qrvJxeos8nrlclAoAEkCQRg1L5sr25
	bxFP3aBqpsIODYCMWnk1awTG4Brsc7H9iDI/PBurSDS8EJjRYYE2JDxAzKIDU4vutXGA==
X-Received: by 2002:a05:6870:be89:b0:417:6bc7:1e21 with SMTP id 586e51a60fabf-42adee1f0d2mr718678fac.38.1776406583090;
        Thu, 16 Apr 2026 23:16:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-42b9304b25esm39892fac.1.2026.04.16.23.16.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2026 23:16:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56eecfd79e7so886255e0c.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776406582; x=1777011382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AEUNnjj7FEF44/ZUliK+9PRDgxKDw1bmVwX64JeQz8o=;
        b=MxuG8X0kDPJ4iO4mZ/2u+/ETzYA0HsKmVvfZ/S/yan11U9C420G4M8jzGODUcmmYV8
         Pj76LkgzsldcV+Kij5195W9OniIhy0/3uASyJfZykC4e2ipPkn2I4b6ZHTv5uw1JViBw
         /M8DrbYmRNnAQNcT76d8NnaAb3FMezJ+p+zaI=
X-Forwarded-Encrypted: i=1; AFNElJ89PSedIdUlRb9+e4kPpMdNCNAexVdslXpUq1IVUAEMOaKK1cbBGAd1Wci6+Ogcs56yzZzz0XE=@vger.kernel.org
X-Received: by 2002:a05:6102:5987:b0:602:86a6:9877 with SMTP id ada2fe7eead31-616f68d3997mr559755137.19.1776406582026;
        Thu, 16 Apr 2026 23:16:22 -0700 (PDT)
X-Received: by 2002:a05:6102:5987:b0:602:86a6:9877 with SMTP id
 ada2fe7eead31-616f68d3997mr559748137.19.1776406581596; Thu, 16 Apr 2026
 23:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415151621.1104956-2-vikas.gupta@broadcom.com> <20260417022201.1807745-1-kuba@kernel.org>
In-Reply-To: <20260417022201.1807745-1-kuba@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 17 Apr 2026 11:46:08 +0530
X-Gm-Features: AQROBzCwuob1jVSNj49U1P4zWyMf5An3pfXSDHKk7HHVU3kNRUn4ZkDL2xV-wxc
Message-ID: <CAHLZf_voEPTrfkuO6pJcchaQaOqJin8m7j-+hwMrjJcGFmJv0A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] bnge: fix initial HWRM sequence
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com, 
	ajit.khaparde@broadcom.com, dharmender.garg@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000050ed36064fa1e3a5"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: BCF974175AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000050ed36064fa1e3a5
Content-Type: text/plain; charset="UTF-8"

> > @@ -73,25 +73,35 @@ static int bnge_func_qcaps(struct bnge_dev *bd)
>
> [ ... ]
>
> >       return 0;
> > +
> > +err_free_ctx_mem:
> > +     bnge_free_ctx_mem(bd);
> > +     return rc;
> >  }
>
> Could this error path leave the firmware with active DMA pointers to freed
> memory?
>
> Looking at bnge_alloc_ctx_mem(), it configures the firmware with host DMA
> addresses for the backing store via bnge_backing_store_cfg(). If a
> subsequent step like bnge_hwrm_func_resc_qcaps() fails, this new error path
> directly frees the context memory.

HW does not access the context memory unless rings are active (traffic
is running).
Therefore, It is safe to free the memory on the host.

>
> Previously, errors in this sequence triggered bnge_fw_unregister_dev(),
> which safely unregistered the firmware before freeing the memory. There is
> even a comment in bnge_fw_unregister_dev() documenting this requirement:

bnge_fw_unregister_dev() is called in both success and failure scenarios.
Therefore, free context memory using bnge_free_ctx_mem() after
bnge_hwrm_func_drv_unrgtr() ensures that the context memory is invalidated
at the hardware level.

>
> static void bnge_fw_unregister_dev(struct bnge_dev *bd)
> {
>         /* ctx mem free after unrgtr only */
>         bnge_hwrm_func_drv_unrgtr(bd);
>         bnge_free_ctx_mem(bd);
> }
>
> Since the firmware isn't told to stop using the memory before it is freed
> here, is there a risk the hardware might DMA into the freed host pages?

There is no communication mechanism to inform the firmware to free the
context memory.

>
> > @@ -132,32 +142,25 @@ static int bnge_fw_register_dev(struct bnge_dev *bd)
>
> [ ... ]
>
> > -err_func_unrgtr:
> > -     bnge_fw_unregister_dev(bd);
> > +err_free_ctx_mem:
> > +     bnge_free_ctx_mem(bd);
> >       return rc;
> >  }
>
> This error path appears to have the same regression. If
> bnge_hwrm_func_drv_rgtr() fails after bnge_func_qcaps() has already
> configured the backing store, freeing the context memory directly without
> unregistering might allow the hardware to access freed memory.

Even if bnge_hwrm_func_drv_rgtr() fails, it is still safe to free the context
memory at the host because the driver unloads from this point.

AI reviews appear to ignore logic related to handling context memory
in the patch.
I see no valid comments on the patch.

Thanks,
Vikas

> --
> pw-bot: cr

--00000000000050ed36064fa1e3a5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEID2J6I7Msrdo
cw9iBniC2lGQx+87rzCoH9CqE+lgOR+TMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxNzA2MTYyMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAE1senYhF1ASN748vdjG2W0W7NA7X8pKetA3eiEZ6YdA13/L
0rLP79q6/ToiGKD0EsflLP1K0Kqfrvs2gpU+PhV638TdjXWT5I9Q7uR++oYLODFV1FhooYRa0sx3
lMns/B4t5C4vqZij/MEbX2iyLt3Kv4tbWZ/+jJuJIfpAuTaWDkOtO57S9Kl83V4BjPiCxatB14Ql
gjdOXiTEG5BL9ec/zm9/n0DX7mG68rMJ/Dp6MT6SwYjQ4MSMSEPNWuxG/fP/c0tU9Pu7Qx0IL5Jx
nEr+fJOb6pecAq8OhmHbKeLF/r88O78GJSNpxkYmRc9tA8TbJTJaoG7D5xuB10CcPiA=
--00000000000050ed36064fa1e3a5--

