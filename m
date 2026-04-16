Return-Path: <netdev+bounces-278925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKV7EUdy4GlkgwAAu9opvQ
	(envelope-from <netdev+bounces-278925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FC40A5A4
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CDE7302417C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB446366575;
	Thu, 16 Apr 2026 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cg/Mt7bo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738083603E9
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316994; cv=pass; b=bCmGiqJd9u4qxPh4Ib0JxV4H6ObnETEuxU5gLo2As3uGsUhA6ch44NcWKgUeY1WEi6IvvM17BzmlGYrZ+36Ij8ZJXhrde3BJs5PeAGAWMM22QjnUOu/BedqLHVkmHJJ602d3Igxf5fhAnkz5oGLp1RXR1fdlQY/RRLNGmAXbkNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316994; c=relaxed/simple;
	bh=sDVhNT7OKGtHwiIOde4ndP7EVYLFokKx5m2v7t1jmZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhn1DND2qB+Wft/D2g7GfTAD9jl3B0sw7zJjLTqzvI8EfM/n/t/iL8yCOWxTAdC29ioYe/FuQuCF/umLoZQQH+Vzjhe0LgT15Ibwj2HtgHATJ61y3SBhdG7cXMXyWFdjzwwrcNOe9ell81oIWuxlRAOzVbB29/B1hnvufjNLCRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cg/Mt7bo; arc=pass smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso62557447b3.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316992; x=1776921792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIlaVSa7L3bGMX3tY3q10xkDNt+hi1z5g+MYBYUgVYg=;
        b=MDmTX/UF9YXGNsTKW5aNtFA4ko9zmFRr2ZcMuKxRdE0VeWNGu5OIDch2gLkA6Wpied
         NCXITKQJOB71ldZLfmnjO1HGolrsfaDnxL/55hSl0R7AeT+vI+7E5zeJMtnopwOIJxxd
         fNE6hIZ5ZIUtDMjOITBTH3I9W97sISq0xJ8GODkneZdRxLgLLDmuSNXHh0oiIoxOqh4U
         H6mvjohmrggXqjruhJnfUEI/AYjNSccNefOI6TU6+KDOO3U00oP7/vDFUB1R7k+PhB3/
         Z4QHCAgahlVwenDVf8950jeXgXy5eaei+d4uQIcrb0l4BeToZVUFyvEV0nMRg+hwT1tF
         rODw==
X-Forwarded-Encrypted: i=2; AFNElJ/6b3Rgj+1mH7jqy7WCDienIJpWtS2LRkFuJSBSJxdQToh/3GQED9gBnbURlvdFixFUwel1Xqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3daMzAu4DgaCrLbKE1Ruah68qCeUlvEpzN8Aga5HiOE2bSxlj
	1wen7PIj3KETs4T2JnrjWYWsorRlTgb61C3hyq/Gk83gAZSlrW0JZ9fI4FsGl5X+JXqNdjOLyNh
	pYKYk2f/gUnd9KBIebKbIrGp7Atw0fBOC9kEcOv09Xbsp0a+t3XlMUlW0b/vAgXJTMUy4AoCGDy
	f09r8LZqw30yhKCpKKuORwGb7QkcV0P9x3ADZTp/6uElxU8rs/UBnZrwNSn8ULTiezNGe89IydM
	eB1pjDl4A==
X-Gm-Gg: AeBDieuMfUR3YSd65aIVxvvZ4MXlpw+fpQgvowQ62Ns1E66iHHYauLogqa8V0jQOpzB
	iFaR2177IMzHle5DroO6I7sIBd7QgVjd3WgpSSNft65o5cL8YY1TV+tINLFhSK4ohEzoWKDEYd3
	v/FCKCsPS32vttroplNuBNFxn1sJY1CMyF9wRRXu8mcMPsIRrlmODSElDdiweJmmC6btQPVqSw3
	BqsJ5WUHiN4KLHN+qyMzl6ecbvCOHR+fJecE51xk/N4wdX1AAxoAwdjDIQhc4gvRhiFm0sUzIGU
	/EZ9ZPUuFNFSFlKrPFh4zD7DbwVM8GIpP/lkchlEvVn//LtjqKZfR603p9W9iX2DirH5IolP+Aw
	sNv2KNRWOKfsVj612xsLMWs7nP6xn9GUxav4crhaXFrwApc/orf5pDXaxr36jqXHjbM7lWU1gU2
	evpwG6uTtUhOU3LCmTjaCXoC0rVBoswhcBQrgaAiYXE6+1TjAvc33AvVghrw==
X-Received: by 2002:a05:690c:8:b0:7b2:6b19:df2b with SMTP id 00721157ae682-7b26b19ec84mr174064277b3.17.1776316992014;
        Wed, 15 Apr 2026 22:23:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7b769317364sm2875937b3.24.2026.04.15.22.23.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 22:23:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-612d26038fbso2101562137.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776316991; cv=none;
        d=google.com; s=arc-20240605;
        b=hqdO1HXo77pOYMUd+RQV7S5aQe+t/xdyx3I6E0V0cOeMZAuPPyVTe4kErXJE0gyhz+
         AX98/7KXdJtZh1ugZ+bTxVg738QaZYKL47k0Dt99/mTStqD7e34R1npkI2NaegRyutDo
         xBlLIxUa7mMx8BD/rBbPrRuDFSK30CtbH77QWFVERtNKGRCdEjzHsaCziQFdbdR/X1nV
         8vYroXYc1aumwyTmzphsfuv3TbccOQpLd8rFu/MwHjFXSC7pj4zeuK5RQrrjS+mvmj/5
         anFDiRvfjWRiMaWuvz+q0mit3FRN0geGU0IHRJwPX5cSRRtlzMDTHxhUk9aUD+X7Ns+e
         Q4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mIlaVSa7L3bGMX3tY3q10xkDNt+hi1z5g+MYBYUgVYg=;
        fh=k48inkomjrngtZW8VQ6I57DF6NPvxrmDaVcMAiskkcU=;
        b=ASLoEbJhzKnmCRSckglx2Qwc6R6cSj5OFMHbmLTvwS2hyiBekVRcmCRC/njpsAaAJx
         9dRtKWboooVjsCrDRRYKlJLfQjRAPTo5QHSTeCRwte9oIYhXUNGqoTea3ZuKgfZJ2szG
         7m6pxfTZZFduEJ6Ms3gZa1Tvs1baJmHwV4qQailsZ3mfvQcfQiLHc5f1uh+jLDw9ywFG
         QSgAMryHHJgLMs7jmGJSmkRScpdD5JuLDAryL99l5AOs4e5qXBtW4PpM+ZzQvSOCk6H6
         RERum4KtNcBovLznUS5Y8b99AoFAwEjrojNXDvDNGLb7nLNMvgTBmgw0FS68yqLsloG8
         vTcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776316991; x=1776921791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mIlaVSa7L3bGMX3tY3q10xkDNt+hi1z5g+MYBYUgVYg=;
        b=cg/Mt7boqpMJomGrUPfaIxwVhWJIJQ2JQNyHkbqvX0zpK0tuBtHeLjeamRbJxpnU/W
         1b11AjElycF9e4tQoGAF5/J8TIYqqf9vH9q4Ui4A2dn7bzFjutsxuEvBfYeCb1mOXgBB
         NNjtQsd2oX6XYSR/Esh0fTJt1kJxPRuv5ZVLs=
X-Forwarded-Encrypted: i=1; AFNElJ+AsqruNgeC8Cngtd/Q3bq8IPT09FQmOjurBCe87vf4SOEuIzZlr3l4KJKfcaCbCBsFUUvHoVw=@vger.kernel.org
X-Received: by 2002:a05:6102:2c87:b0:605:42a8:940f with SMTP id ada2fe7eead31-60a01ea7a65mr13154540137.31.1776316991398;
        Wed, 15 Apr 2026 22:23:11 -0700 (PDT)
X-Received: by 2002:a05:6102:2c87:b0:605:42a8:940f with SMTP id
 ada2fe7eead31-60a01ea7a65mr13154524137.31.1776316990886; Wed, 15 Apr 2026
 22:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415151621.1104956-1-vikas.gupta@broadcom.com>
 <20260415151621.1104956-3-vikas.gupta@broadcom.com> <b2735cbf-34ac-4ad8-b524-2aa0f57511f8@intel.com>
In-Reply-To: <b2735cbf-34ac-4ad8-b524-2aa0f57511f8@intel.com>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Thu, 16 Apr 2026 10:52:56 +0530
X-Gm-Features: AQROBzAs_uU_khp17s-d3bKcvsSamwYwsynJXX-0v5QvTPAeLloQVzkc3Nw1Te8
Message-ID: <CAHLZf_uAWk9J4p-4GhWPtdTyxi_P+FpK-ZO5R2qDtjUAdU9cBQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] bnge: remove unsupported backing store type
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: dharmender.garg@broadcom.com, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, linux-kernel@vger.kernel.org, 
	vsrama-krishna.nemani@broadcom.com, bhargava.marreddy@broadcom.com, 
	rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d756f064f8d07df"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-278925-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C82FC40A5A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000004d756f064f8d07df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 9:24=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 4/15/26 17:16, Vikas Gupta wrote:
> > The backing store type, BNGE_CTX_MRAV, is not applicable in Thor Ultra
> > devices. Remove it from the backing store configuration, as the firmwar=
e
>
> I guess the removed code was needed for previous devices, what is the
> impact for them?

This driver does not support previous devices. Thor Ultra devices have
split MRAV
into two separate contexts, MR and AV. Support for them will be added
in a future
patch series.

>
> > will not populate entities in this backing store type, due to which the
> > driver load fails.
> >
> > Fixes: 29c5b358f385 ("bng_en: Add backing store support")
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 16 ----------------
> >   1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_rmem.c
> > index 94f15e08a88c..b066ee887a09 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
> > @@ -324,7 +324,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
> >       u32 l2_qps, qp1_qps, max_qps;
> >       u32 ena, entries_sp, entries;
> >       u32 srqs, max_srqs, min;
> > -     u32 num_mr, num_ah;
> >       u32 extra_srqs =3D 0;
> >       u32 extra_qps =3D 0;
> >       u32 fast_qpmd_qps;
> > @@ -390,21 +389,6 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
> >       if (!bnge_is_roce_en(bd))
> >               goto skip_rdma;
> >
> > -     ctxm =3D &ctx->ctx_arr[BNGE_CTX_MRAV];
> > -     /* 128K extra is needed to accommodate static AH context
> > -      * allocation by f/w.
> > -      */
> > -     num_mr =3D min_t(u32, ctxm->max_entries / 2, 1024 * 256);
> > -     num_ah =3D min_t(u32, num_mr, 1024 * 128);
> > -     ctxm->split_entry_cnt =3D BNGE_CTX_MRAV_AV_SPLIT_ENTRY + 1;
> > -     if (!ctxm->mrav_av_entries || ctxm->mrav_av_entries > num_ah)
> > -             ctxm->mrav_av_entries =3D num_ah;
> > -
> > -     rc =3D bnge_setup_ctxm_pg_tbls(bd, ctxm, num_mr + num_ah, 2);
> > -     if (rc)
> > -             return rc;
> > -     ena |=3D FUNC_BACKING_STORE_CFG_REQ_ENABLES_MRAV;
> > -
> >       ctxm =3D &ctx->ctx_arr[BNGE_CTX_TIM];
> >       rc =3D bnge_setup_ctxm_pg_tbls(bd, ctxm, l2_qps + qp1_qps + extra=
_qps, 1);
> >       if (rc)
>

--0000000000004d756f064f8d07df
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIA8VHOOSbpdK
FXV/4tb/8hCA0j1R0iP2xWd3MDnyBOKdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxNjA1MjMxMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHCd2c2UuozN81yJkTLWxP3PQrs3o5phKJDQyTzqEh8mendu
QPtEuBVdgKgQC1a3yudb5UB//yV0IUorGNGb9jEi6lKy+EgnMhV3h1MbZv8cPGm/KFH+yI3W+knU
G92/XY5nUca1HxrFT+RWPkjoXOJ+XOz8HzAYw34T3Wn9Yxu1OvNn9aOgeVcwgUZAMi17QluS7/a2
AX4vYre0WlXoZbldOq6jznKMLn2j1P4OAJPDlQ8K82M1quWMI+JPoONzYa7aBnmKcvEkCB73oVre
AnNzOvVha68BTAfVJWdLYlN5mLgzeV69RKV2F0h/61n2jBX4Lou5d2tYffTbaz403kY=
--0000000000004d756f064f8d07df--

