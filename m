Return-Path: <netdev+bounces-279359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDEJOltX4mm25AAAu9opvQ
	(envelope-from <netdev+bounces-279359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EEC41CD28
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 130B43056FCF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE733BBD0;
	Fri, 17 Apr 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RgbKxCbM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7B33BBAF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440859; cv=none; b=CTM3IMDtf6RvmiB2AadQAl5mqPsqTgox5CgGo4s1uYT4ENALqbRadqq/d9oTOCL34OZhPJ1qDZqxVvsyTz+ZSK6ahVxYo95oDx8Dg3gyLA94I0wmuXr44fvZUHyFKwVhyuYrjPVc8eRbZoJIcSEWNiiDuYSgzirfErcqaYbxlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440859; c=relaxed/simple;
	bh=EyHk7ZvLWCAWEecol4w7DwPhN06JabYrLN35BZdjg7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/OXCP2I6aINDi3AZA1SoaLRuunJ/VypBoMKoP/ChoFBqxv4e/L1ahHMteWUncaOCThBkdK+QFKPnsZXHG8O49zsGo8VJTLi70rOrvEcr6J9JBS9oKl+yIr8RupFjCDEPUHp2OCkySOsbfMzkWEIV7CEPi5uc4VQXadShVa32mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RgbKxCbM; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7dbccf6a23dso732276a34.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440857; x=1777045657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai+5p6+SmocCnx6uekW0xUvY2IcAKXMKsX/ZCrPXejk=;
        b=q/NR+72+VYdbZWTsPDaA5RSRH1uUnjOgBTNlIl0d2CyStqkNR+v3+6EM+7Kg6DJC78
         AjBSNKv1e+K9gpECz85J4D9avu0TcDv/b+5pCkeC56TB1uaD/s3cTQjjjdUU3zR9N/1G
         ywYsmmbl/nPujAd1iILqfzkTCF0bvvmmKrY7tScGkWWNrSLRtNwrO3bY7O5ELPZOUEUk
         /AEwrk1jqxSrxS1BqOW/R1hTikH+Hwq44hIkbbL1fjF3yuEM3z6CbZbDoC7KOMo3qaqy
         unLftU/Q9VqsLKSS8ss2EZho3qPUdY8jP81PcV+zot719plI33CnBxAGIdlsDuTOPGLS
         nhKw==
X-Forwarded-Encrypted: i=1; AFNElJ81G4HEoa8EFOlpkGxxd9Pe51VJy9+V7T/eSvxETbZkQe7e4jilUf9dGERp4773Y54Ba0mrZBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNWkdyJWaasbduttC0zwmhJGh+yFEZgrXebTCxxyr4lX4Prdp
	aO+SIanlfFIAJndO6MHeCmhcqXF1T8meuDab3lFVIE2Odh4+b5T103LitCXZNQmL+81/YupKbYP
	LCr7MmW1FiHPU9dn8qlbfF/eP9826WtRexyrMjsq6fJPJp7Lzmz3NC3opHKOXhndT+UJAbxuUiV
	uZ9roTe7ZOkeEXv2VUEf0itpxlC+aepoLSaUVoS5nLFMNN2Eaj/7nwm57fv4hENOGA5zJ8CBHfX
	TFIYqk7OA==
X-Gm-Gg: AeBDietZDCBHIJr2nplN9XUuNHsed8FlQJnb676vhT+dQSkxMuOuuyw3LHBkkzWFEXZ
	5kjEzaM0EAqSoFWvi+j0Eh+ubw6Yes4m8sHrPzcpf/Ydzf8eYF4XPacyAaaVhhU86Au+qRNAeUo
	BtcD2bPLagrySyhsL3fbxjd1rGsd2Sh/57dSIZjpU3XNzjlmC3obzndgGHnloELjF0LmVRevNgc
	oELi6eCSPlyzhu4adBWsP5u6fUWEW543eTWrwAKRHcJsUHzOSZsvV4Xii3d7+dzucMmlgg9lGM8
	8Jr0BeabASRqyEari59HQJ5YVTmpSdiBMGFg15YbRZvRZCuUJKJGkbNuyjPHs2307op8iK+f1fZ
	3G27+ajdH/eiF0wKRilGS79XgbtKtJh5WcCSvlpf+hMN00Q1JI2oC5bchXyf3/kvAXIQTOqISVd
	BRnI0oZ1/Y67NiAuW6QaeRDznyIdZ06bwqGjdMMoIpaHC0HiPIzNmZ6SczLIWPCSFo/A==
X-Received: by 2002:a05:6820:a04:b0:67e:1063:3811 with SMTP id 006d021491bc7-69462f3994cmr1734087eaf.51.1776440856936;
        Fri, 17 Apr 2026 08:47:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69465eddf25sm98567eaf.24.2026.04.17.08.47.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:47:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ffa1faa59dso580860137.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776440856; x=1777045656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ai+5p6+SmocCnx6uekW0xUvY2IcAKXMKsX/ZCrPXejk=;
        b=RgbKxCbMqQ44EZfx5LRLHjXVKjTVxQKtZUbBFvTOcC2XaTS5cdayE1rXWIUxZluXKT
         ztRtIJvCGrvHDilCr8ia6XhAQs82cwDU1SWJFYpaD31rJZsW6eRZm5JVjDiVq8dpR677
         J/KWk4MjyJ9h6eLFdvK1/CeLdoySSLoSmM15k=
X-Forwarded-Encrypted: i=1; AFNElJ+YXXQCWXN25//0ZH0cyOLbu4SKDDmwS/hN1miPDloIDnPq75QxzJkhxJQslqHK4ogxCNuSYrc=@vger.kernel.org
X-Received: by 2002:a05:6102:419f:b0:609:af4a:371 with SMTP id ada2fe7eead31-616f74062ecmr1563453137.23.1776440855929;
        Fri, 17 Apr 2026 08:47:35 -0700 (PDT)
X-Received: by 2002:a05:6102:419f:b0:609:af4a:371 with SMTP id
 ada2fe7eead31-616f74062ecmr1563439137.23.1776440855465; Fri, 17 Apr 2026
 08:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415151621.1104956-2-vikas.gupta@broadcom.com>
 <20260417022201.1807745-1-kuba@kernel.org> <CAHLZf_voEPTrfkuO6pJcchaQaOqJin8m7j-+hwMrjJcGFmJv0A@mail.gmail.com>
 <20260417074254.42f01fa7@kernel.org>
In-Reply-To: <20260417074254.42f01fa7@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 17 Apr 2026 21:17:23 +0530
X-Gm-Features: AQROBzCZsFxerkIx10h8HTccs0SfP4e-yhx4VirYANN-IVUGEUQJ_A9LO93wxkU
Message-ID: <CAHLZf_uARgZzoTPnnPjxRu5AGeHEOw3yyTEbNHYP3brfwuW0Sw@mail.gmail.com>
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
	boundary="000000000000350a32064fa9de65"
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
	TAGGED_FROM(0.00)[bounces-279359-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 69EEC41CD28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000350a32064fa9de65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Apr 2026 11:46:08 +0530 Vikas Gupta wrote:
> > > > -err_func_unrgtr:
> > > > -     bnge_fw_unregister_dev(bd);
> > > > +err_free_ctx_mem:
> > > > +     bnge_free_ctx_mem(bd);
> > > >       return rc;
> > > >  }
> > >
> > > This error path appears to have the same regression. If
> > > bnge_hwrm_func_drv_rgtr() fails after bnge_func_qcaps() has already
> > > configured the backing store, freeing the context memory directly wit=
hout
> > > unregistering might allow the hardware to access freed memory.
> >
> > Even if bnge_hwrm_func_drv_rgtr() fails, it is still safe to free the c=
ontext
> > memory at the host because the driver unloads from this point.
>
> Looking closer, indeed, the way bnge_hwrm_func_drv_unrgtr() is written
> the AI suggestion is pointless. Hopefully you're right cause debugging
> FW corrupting host memory after reboot on bnxt is not fun.
>
> > AI reviews appear to ignore logic related to handling context memory
> > in the patch.
> > I see no valid comments on the patch.
>
> Why is bnge_func_qcaps() allocating context mem? It may be the case
> that context mem has to be allocated but bnge_func_qcaps() doesn't
> sound like a function that'd perform such key part of init.
> Why not just move the alloc earlier in bnge_fw_register_dev() ?

I agree that bnge_func_qcaps(), which appears to be a query function,
should not allocate memory. I can refactor bnge_func_qcaps() and
move bnge_alloc_ctx_mem() to bnge_fw_register_dev() so that
bnge_func_qcaps() remains solely a query function.
I`ll make changes in v3.

Thanks,
Vikas

--000000000000350a32064fa9de65
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKIQJ3qDC2bb
SU4wwTJ9yMjho1AIwRpMUBkgGLuba5pNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxNzE1NDczNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAZfVqe3Jna3dicCjFf8WZ+H18jIGqJvXADy0n418H7ft+lu
KGgg9FMkp4zVXpDT8X08LVpgg/L9ZbmmLulu89LsVfaCGbF9GvMzSn016ou7tM8WTlBV5liQXNhA
SrOTf/QW6/qcr3OYVQygNMJhZFOJlXKH6Bh3qt2Uw9SuP9RO211wCWMWo8dWhpaIdECtg3qkmr7s
Rf2/5nt61QTg/oANKECuXmnzO/cD3MHv9hWaR0/GLvG1GKcWz2iU+nETsCLnh1oN0KnpCTYjBCj3
MoeR9sC6e5fKLvFUMO7fp7JA3RAzGWPGP6NJPrfgMI0JGefIAnt5kkl7/Gu3k1OzsxE=
--000000000000350a32064fa9de65--

