Return-Path: <netdev+bounces-304457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mx6KHid8R2rfZAAAu9opvQ
	(envelope-from <netdev+bounces-304457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E470074D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=ZAFJNew2;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304457-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304457-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40CF3047070
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E0386C15;
	Fri,  3 Jul 2026 09:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18423385D7F
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069210; cv=none; b=Rupm/L/cJV1cfAFB5AzVX1wgJUwCuM961tjF2TpWTe9g9HNcQg0KpUSfUtsH1XOk/+0ErZaoDHBVO2zjUaZTZvqfc/FQ1Zg5mPdipJ8eX/Kxuc+ctEmQDICZrtdtG6/Hv+bShOB+3a2jPdh+KjCPhRQBMYhWsNu+qsLfyb5Tqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069210; c=relaxed/simple;
	bh=eXe4u2nWGWPWspHlZwuy2O0vyvCsP+Iil5lA2V2aW9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sy3wOOooFSfDB6akOvkxbeNtp2+vD5KpZZihyV6gmyKyv+d2K3fTnbuCB795N8HnxFiRTyfc4L/Y2Kqrlk5UkyKApad2+uQElghheMdaCSEnpTEdYvrVDcV1jW1SVWNJ8RNEoybm/4rhSLwLUY7veyZqHqwxVmhsbNqZe6vwML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZAFJNew2; arc=none smtp.client-ip=209.85.216.100
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-37defb2f231so221351a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783069208; x=1783674008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2fhv28b1VlpaVMlDlkj2rhU5C8+fGSI5/2ijQLrkpU=;
        b=sDkzFXYttpor0c37fnUZ9KwBwlnpUk6UJEsNLrTGrEANOHzirSGgpWldcmQCxknQqv
         xshKuD1Kd6gG1+7g2VAREGZcrtyRmD9iwewfJArcLNpsTuun+v6ErqJ3c6napQi9xXYU
         wxscfQ7DSDBlL7mjtdOb/o0WoLRStvMtfTljBb9qCCU1M+ycgCh0TyTUW2k8FDpEqO0Z
         8hDNUiN2m3cRqWWwoLhpt7i6efj65Dhgs7t8LRRXf92RcBr77mEPandzPdIClse0CxGw
         Xr4+gzSLNiScdttg5E9cnzeuLhstkf4FW18IrmmDQYzWECcUdCmSPF1da0eGBUgCO0P7
         3+Ww==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Y2G9pexSof63cUGIBkb2oEH32aOtz/nGhDwVLFmEBpziPWX3d9FzfLIH6Um9FGopYr3hxVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQCnEg8kbOJDeRB1Av94xhYVmCiJTNla3YRbog4lqRUak+ffP
	S48mffv9RYn8IjR8EfLD7/D305d/j4BGRKBdw+aCmpRfJdAxiX7YJ4NBZxjtspy8VOsvzLyeK6q
	f9LW1v/pGpHyps5+x1CkPsZWSaHiXW9wkIoEqAXtP8S8MbY7zrNT094qjFJ0paqW7f4LPdeed9X
	L2HuvHXIpjbF2KKshyt8vj0UWz+9phIF0+IrFSPM/tnONJ6XAEgZ5W4ZRWU6xwLZlQ1qBbv9QMB
	DbGeN7MMQ==
X-Gm-Gg: AfdE7cnpWo3oKIXstxifpiR/20NINxJjiqbb4GWeVQb6/PBAPBeNvjqnW32ETWldBXO
	3OBUbtBdqh8p9OSlPPryuyILeRpaqa6keT9w7LigdKavMHp7JMms7lhX0Piz9vckWQfMvaealw+
	TU5z3J91xJwMoILChsWyf4logJRvEX4JH1sBvsIbzAFxEPEGpxYkBvvnQfA4VPcOo0mjngtkKlL
	IBDDx5WMeu0Xn2Jgcv6F1qzb9GP/+CuMvPfOwV1SrzReYl1O8RW+dTE/ZhBrQdPrX3vSbiY5JL5
	3+zHSTCN8xYVaBgY2LKpU2U/QuXvHBMRSB5DbRxSaLO/2r08KKtlc2E3RyWTuy5z2ZvoNco4O7I
	PYKXM8PA1HCGVi63bjFmau9JKZRgHiIjP2ucnmlE+hbu0GxocOtmFEk3LomospyDU3OiTjpTZZz
	4al4AiYU08vIxytnLA1VX4g3IChtduJaUXhePaz/msAODqgx4=
X-Received: by 2002:a17:90b:1f92:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-380aa1f5166mr9351542a91.23.1783069207837;
        Fri, 03 Jul 2026 02:00:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-30f0b8a47fbsm278404eec.6.2026.07.03.02.00.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2026 02:00:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5a787be4ee9so594023e0c.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783069206; x=1783674006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2fhv28b1VlpaVMlDlkj2rhU5C8+fGSI5/2ijQLrkpU=;
        b=ZAFJNew2C9ngbdwx1tENdH6pufMxYFoMRzoR4Srsrsjm8r1QXoIRVerEHNYwtaWgDH
         fmX9jA+yAgFzhyqsp7azVaP7/8TMKg4TMpBW/i5AFI4V2x2PRFOIDyH4BZlW8PqlCVz4
         hEmTOed13Blf0UryRjd/fkEJNVu0BK3Jqqtkc=
X-Forwarded-Encrypted: i=1; AHgh+Ro0/FxYFGnRZcNlO8HOGA+3VdVopVTJKYTLZ7gVNPURR0nkydSpbEQcOODq2yLfQnonvKRPRW4=@vger.kernel.org
X-Received: by 2002:a05:6122:e462:b0:5a4:7e8b:3171 with SMTP id 71dfb90a1353d-5bddf699ab8mr4349067e0c.11.1783069206352;
        Fri, 03 Jul 2026 02:00:06 -0700 (PDT)
X-Received: by 2002:a05:6122:e462:b0:5a4:7e8b:3171 with SMTP id
 71dfb90a1353d-5bddf699ab8mr4349048e0c.11.1783069205960; Fri, 03 Jul 2026
 02:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630101554.1221733-1-vikas.gupta@broadcom.com> <55e4bc6f-f393-4e76-9220-a818b28c585b@redhat.com>
In-Reply-To: <55e4bc6f-f393-4e76-9220-a818b28c585b@redhat.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Fri, 3 Jul 2026 14:29:52 +0530
X-Gm-Features: AVVi8CedWHZoxPQBN0lfsCJdzjIVNoeB-2rsuYd1aCZTu-TMqUAyHaKel-cQvGY
Message-ID: <CAHLZf_stJfmKRyu07um+7fgGev1UjhYRPeL3-gK0LTcx5TEokA@mail.gmail.com>
Subject: Re: [PATCH net] bnge/bng_re: fix ring ID widths
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, leonro@nvidia.com, 
	jgg@nvidia.com, bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	ajit.khaparde@broadcom.com, Siva Reddy Kallam <siva.kallam@broadcom.com>, 
	Dharmender Garg <dharmender.garg@broadcom.com>, 
	Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac67b50655b126da"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.76 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304457-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,sashiko.dev:url,broadcom.com:from_mime,broadcom.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA5E470074D

--000000000000ac67b50655b126da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 1:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/30/26 12:15 PM, Vikas Gupta wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_rmem.h
> > index 341c7f81ed09..bb0c79a1ee60 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
> > @@ -184,7 +184,7 @@ struct bnge_ctx_mem_info {
> >  struct bnge_ring_struct {
> >       struct bnge_ring_mem_info       ring_mem;
> >
> > -     u16                     fw_ring_id;
> > +     u32                     fw_ring_id;
>
> Sashiko gemini has a few concerns about the id size increases:
>
> https://sashiko.dev/#/patchset/20260630101554.1221733-1-vikas.gupta%40bro=
adcom.com
>
> please have a look.
Sashiko's concern about backward compatibility is valid, however, the
driver is not expected to work with older firmware because the Thor
Ultra device has not been deployed yet.

The concern about overlapping bits is also valid, but the firmware
uses a ring ID with a maximum width of 18 bits, so no overlap occurs.
Nevertheless, I will add a mask for xid to improve code clarity and
readability.

Thanks,
Vikas


>
>
> /P
>

--000000000000ac67b50655b126da
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBYF0nEqqAPJ
5/ga0jVGTlOXGYBYjUZ2iwTuPErKm8OPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDcwMzA5MDAwNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAGe5ji+gr9Te1Xh5KgwbhIyAVXTJVXf+Gf4ZVkNZbUWCUi6w
/+jswYX22q1466fdfr00yPpbOrQS8qka42TvetMRj6dz1ytJKtwh0Qt9pylDbup8IyRS0Ambi5kf
wVqLsKY7h8AawDD8QYzARhK/yZ8UVFwSd8nzO+clXuQID8zdJCtS2InZRSIDoH6Vez4FRjGWmZC7
Uo4n2dCA7gcCETaJQLgWzqBDB2ruhhM9TsxvrYwQ0TutBcC+4+MoRjiNoPr8dq0TEh9pjlhR41VJ
6YGLUKxoVebvZzsKlcFgEunJjs0IVRQRpX4XoGAH6yijCLsQlqkUNkluq3hC1f57070=
--000000000000ac67b50655b126da--

