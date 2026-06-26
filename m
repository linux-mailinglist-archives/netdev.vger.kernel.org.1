Return-Path: <netdev+bounces-302130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvJiK75DPmo1CQkAu9opvQ
	(envelope-from <netdev+bounces-302130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6056CBA2E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:17:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tGB3MSqK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302130-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302130-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 911E93007CB9
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CF3E4C7B;
	Fri, 26 Jun 2026 09:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AF317143
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:13:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465186; cv=pass; b=gZTskHeQOKxn/646sJHwzt4sV9SKt8wXyWfVXmXHF5yoFn1Z6cVeQNfEiGaCWuVYgMHuGVU+Ai++P6S6YTNlu22hTXTPe8EUKxam5ZfpXTtb1SGRlU2zQSNp97B7zfqpxws2dJUADnSN8wFX3tyEETy6Q5p3iibhk08hFCChsS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465186; c=relaxed/simple;
	bh=PCvsQ4pcSrkWx8FvlvUtZzqatxnS0N4KXKPVi7rYRho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTknZzZfmQWJjsiXk3Rj8VoJ1LiBeExWSM1AiLnoyK47uGr6txa89dICO7DxEakBe8ghs1CdwDp4xp956tJvUaExXwHpIhriOHxlzxG4qXCAmWFfRrBIxFqxTi5Ftx/fcERvA1fq/O1fg3nJ99IYwQwG6GRMBCvqzPBvASrkZk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGB3MSqK; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aea5e76497so2901e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465183; cv=none;
        d=google.com; s=arc-20260327;
        b=ihiUayOWiH7WRAd3QcCbjZ5YiwXDbvl8sN9KkiB1nMS19vbf84RWT269s+UmKnH0bM
         WUmVKp104/BJQSCYWM355oYRCj9YWOpzquL57vQP51xdXFZmr6RMe5lusVs1qcN1Ga17
         xMGyKTbSsG4FQQ+4/Ah4jzEoi1MyX2CooAZP2VTU068pG7gRaLEq2lOXj52QLP4mlqL6
         bnCc7JRTDR9CfmhLd7fr+jnoPuTt+SbSVVuc1GMsZSGzZxcfHkcblkLptY+0b9yqJ7Ce
         e2QFwuTNpE04MzC0O9CRE3QQglG/f7V/VJgqxMaL4inWQ/EahgCHco4UCWtJAfKBxGhB
         4Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M/j5D6cqum2kgyTxFVqUpI0agKGBs2AMdJ/g/Uvjpto=;
        fh=05FF679UJD7+QdX5EfBjwq6y16zfMYQw7xJzeMK2/BE=;
        b=kz1RBg9Jeuuw4f8IgUltFoJme5ONs0WZoCr+jJa4CCBiFrIPTSSKOSbndUx62LGtSv
         Fv9S35f/wg+nQxBzeEiyW4LAhd9vTxs9LZ4/czhG+WfDk13c86+BQw8e78iHCg/3OBxZ
         y71NUb2TdzPHeHVkafx+0DOj2au5Xs3GJw1A1nPe1PZ7cVY5l2iq1jHwIF1Gf4Zk1Oo6
         Yf2P4ukMXBup6rJH0QqYP2hIJ5DAaqw8pyXy0Mo+vv/giBl/f6C56hXuutxaIebgyFy+
         Ly/Sjo9w4poHN14n/GuCVZ+2UJxtZcwPMBKj4rD8OXtfGWEJxIZj1aFTjJDlYiLQMDED
         6zAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782465183; x=1783069983; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/j5D6cqum2kgyTxFVqUpI0agKGBs2AMdJ/g/Uvjpto=;
        b=tGB3MSqKdxszB8EffETlcC+DrjYoXQmm7ELjw8/S/i9cGYsA99WKA6g2Lkzri+lbNp
         p2kfLJTHo0S5YQOcUhXGzX5ox0Z772YNDe3A1z5J6msw9b/DSG52tPy3+3cJmBXV7Tjf
         gjWDDtwUbGThKsGAOvKzxOWPyo0ekKVqSexTICRuBjvYNvNKGJ43D9+hhcY8DOF1CG4Y
         PL1rmgAyklHGjrHNmKuOaqco4THN4BXtj4gycWZeQduWdojQk8z9MDjI/J5LXyNUhlwl
         G1g6OtAWQyqIqBSL62523CsvQ11d2CvrmID1abfIUf5hYoapMJH62XQpvjODaRWT88IQ
         8gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465183; x=1783069983;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/j5D6cqum2kgyTxFVqUpI0agKGBs2AMdJ/g/Uvjpto=;
        b=CqeU6XW1iUDFLHVsfERWIa5hcecKsgtmDgSV6epa+1FbCLhRfk+Jj1Lwo27CWVn9a0
         3iHFkGrq+pYUBX+CtRA5ZnJilbJFHGGvwWFKLPOpl2nDpzpWNl5YLZ3dzoXzDv3De0vD
         pjkQ5PjMnSH8a9lg4J9cmf0IkqddX8jbLzcoI8u40JEPiM3Tw9YNkEF0C1uqaNbLFpDX
         WfytzMz5WeBqDRLJs3+HNpD/aASNMbPSNbzRJ702pMDwCoUVY8muqD55rIVpBbJt+IHG
         t2Po8KKRR1vq2APjK1cKWhcZb+b3y9OQYaa862CLb/ZeLkNXWWy6BkDfnvSyUXq8r84P
         luyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro56CAJQzmytNH7mDEi8gMiYj6nmJ7stltzlo9QY7bSYF1EQvFyveWwhuk0zPUX1hVVLIyUnDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDf2Cy1iP9JrXxVQA+xBxh4OK0/lvs6hLQUoQEEAn69JSo9yQj
	H4DrrdOUOe7MQImTlZrVL3QyX8kBU5noTGpZzEjMD49+akITyHKZDnD2XBTwLBDdF3u6sR1O7Hq
	boanavZx/RJ+yyYOvCUrJ2IcOmt7ksl5rY8fLRpsS
X-Gm-Gg: AfdE7ckZUu8StHTxxt0j5uul4m1u/0691OCC5QC3hPi4dcNnp2yOrlE+PEvWE61V5bc
	sSifMsvoyyks096BMsIvVkSlJKhz8VikHLcGshZ/PS6RUxnIoSfymMbn2asJUCQkqk2HeHQ/kXu
	XaFCzEkBOL1cZ9mcS+8dC+nvZwiv6UOXry8omWKYRCGvBs+oal6caXLjfPluLpbJ5A3guS0ycIJ
	smNhxu40595NrXpmOV4I6c4Z6frDzT8+uq0lm9Gj72gh5aOYgWSdkWzESRcc+0sAJwS0Uuc4GPK
	JLVhMCi4rcKQ0p4d2GVSuZy3d374
X-Received: by 2002:ac2:456a:0:b0:5a4:ec:53d9 with SMTP id 2adb3069b0e04-5aea5fe7a9emr88981e87.1.1782465182286;
 Fri, 26 Jun 2026 02:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624084130.2382335-1-clecigne@google.com> <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
In-Reply-To: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
From: Clement Lecigne <clecigne@google.com>
Date: Fri, 26 Jun 2026 11:12:49 +0200
X-Gm-Features: AVVi8Cea6r6zGHHUj0FyCIL0dgSbuA9BG8cFc9PHIMcnT5nR3UChhQNNMDxDSpU
Message-ID: <CAHuCGdms7oynvu1zk=5Qbw+rHEyHaFYx6Bi5tuQYZ0Nc7Pchdw@mail.gmail.com>
Subject: Re: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, sdf@fomichev.me, 
	horms@kernel.org, john.fastabend@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000013782d06552484df"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[clecigne@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:sdf@fomichev.me,m:horms@kernel.org,m:john.fastabend@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clecigne@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,fomichev.me,gmail.com,iogearbox.net];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D6056CBA2E

--00000000000013782d06552484df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Olek!

I submitted a v2 of the patch directly as a reply to this thread by
mistake, do you still want me to post this new version separately?

On Thu, Jun 25, 2026 at 5:14=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Clement Lecigne <clecigne@google.com>
> Date: Wed, 24 Jun 2026 08:41:28 +0000
>
> > From: Cl=C3=A9ment Lecigne <clecigne@google.com>
> >
> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion"=
)
> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-=
copy
> > frames.
> >
> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
> > reachable from the drivers/net/ethernet/intel/ice driver.
>
> idpf uses this, too (every driver based on libeth_xdp in general,
> currently these two).

Done.

>
> >
> > When building an skb, xdp_build_skb_from_zc() uses the chunk size
> > (xdp->frame_sz) for the allocation. However, napi_build_skb() automatic=
ally
> > reserves space at the end of the allocation for the skb_shared_info
> > structure.
> >
> > Most high performance UMEM applications use 4K chunks, where the
> > corruption cannot happen. However, if the UMEM is configured with 2KB
> > chunks (a very common configuration to maximize packet density in memor=
y),
> > a standard 1500 MTU packet will trigger the corruption because the requ=
ired
> > space exceeds the 2048 byte chunk size:
> >
> > Headroom (256) + Packet (1514) + skb_shared_info (320) =3D 2090 bytes
> >
> > Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
> > checking, the memcpy() writes past the available linear data area and
> > corrupts the skb_shared_info structure. This can lead to arbitrary code
> > execution if pointers like destructor_arg are overwritten.
> >
> > Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
> > strictly to the fragment size (len), but the subsequent memcpy() uses
> > LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
> > up to 7 bytes, which triggers KASAN warnings and is unsafe despite typi=
cal
> > page pool allocator padding.
> >
> > Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
> > calculating the exact truesize required: the sum of the headroom, the
> > packet length, and the skb_shared_info overhead, properly aligned via
> > SKB_DATA_ALIGN.
> >
> > Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
> > the allocation request using LARGEST_ALIGN(len) to match the copy
> > operation.
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion"=
)
> > CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> > CC: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
> > ---
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba..f36d1fb875ab 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -699,7 +699,7 @@ static noinline bool xdp_copy_frags_from_zc(struct =
sk_buff *skb,
> >       for (u32 i =3D 0; i < nr_frags; i++) {
> >               const skb_frag_t *frag =3D &xinfo->frags[i];
> >               u32 len =3D skb_frag_size(frag);
> > -             u32 offset, truesize =3D len;
> > +             u32 offset, truesize =3D LARGEST_ALIGN(len);
>
> I think you need to re-sort this to keep RCT, now that the truesize
> initialization is way longer than it was.

Done.

>
>                 const skb_frag_t *frag =3D &xinfo->frags[i];
>                 u32 offset, len =3D skb_frag_size(frag);
>                 u32 truesize =3D LARGEST_ALIGN(len);
>                 struct page *page;
>
> >               struct page *page;
> >
> >               page =3D page_pool_dev_alloc(pp, &offset, &truesize);
>
> BTW usually LARGEST_ALIGN() aligns to 16, I've never seen a bigger one.
> IIRC Page Pool never returns a truesize aligned to a smaller value. But
> if you're really able to trigger this, it probably does?
>
> > @@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
> >  {
> >       const struct xdp_rxq_info *rxq =3D xdp->rxq;
> >       u32 len =3D xdp->data_end - xdp->data_meta;
> > -     u32 truesize =3D xdp->frame_sz;
> > +     u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
> > +     u32 truesize =3D SKB_DATA_ALIGN(headroom + len) +
> > +                    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> Ah now I get it: xdp->frame_sz doesn't account the shinfo for
> single-buffer frames, only for multi-buffer ones. The fix looks correct,
> but I'd use SKB_HEAD_ALIGN() since it does exactly what you're
> open-coding here and sort the declarations:

Good idea, done.


>
> {
>         u32 hr =3D xdp->data_meta - xdp->data_hard_start;
>         const struct xdp_rxq_info *rxq =3D xdp->rxq;
>         u32 len =3D xdp->data_end - xdp->data_meta;
>         u32 truesize =3D SKB_HEAD_ALIGN(hr + len);
>         struct sk_buff *skb =3D NULL;
>         struct page_pool *pp;
>         int metalen;
>         void *data;
>
>         if (!IS_ENABLED(CONFIG_PAGE_POOL))
>                 return NULL;
>
>         ...
>
> >       struct sk_buff *skb =3D NULL;
> >       struct page_pool *pp;
> >       int metalen;
> > @@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
> >       }
> >
> >       skb_mark_for_recycle(skb);
> > -     skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > +     skb_reserve(skb, headroom);
> >
> >       memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
>
> Thanks,
> Olek

Thanks,
-clem

--00000000000013782d06552484df
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
8hR5AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNjbGVjaWduZUBnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCP+vH1KZhNM
AUDfE/ufrYigVK2rMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQCI
BpunU2TNkKMYJMUbxxxbZw282GTtrDVlZUatr2Uv7TUhqokrMdAv1gQZ0wqIAQs6xp7uUHj2klvk
tsZ2D9AiWvxSeAUbfcVHrnX5uVL4twUWycFEEi1kEWXGiuci/kgiXeUB/kLppu5vkbm9NBiGjpkr
t4Lz+Z7+Q4KMrs0H5dCLxU3RldQXVKgleU6yVVGN/6iBXr28NOrMTDYLOWQ2Qz+Szc3huy3T5Nes
ZyoocXn88QLRXn3Zq0pLl/0qEc4QFYykUWu55Lk8YpDQGsyKQlKkExNtRFp3oDPTV1F5MCstoaJ6
Nx5RIs+afbDZANnqxkOotDAmLKbZO2WmQJ/7PbD2d0jQmhbK59MiBBz67EeRYPhlIYyhEastC9Az
Dkr1ZbVTS1XIV4NaSbcmcnedl4Nf92bOmAzlz63C7FVpDwg8pHAo+trmtxQPaVFRrJRiIs/YYsGk
aKIMmqfg42WRtv94LJihfyxBMWitfpryCeEDojvdUYJ5XCt6tKI7RUY76MAlsXS0Aa+S1/d/EsnL
uWwrPVxn6LgBhJ1OegCVYpM58nWlQMxM/KDZuvuOYqRlRVlo6sdDuSouGWAaQFdu8szWZXp9HCYm
hNN36RQsOA5pqj8TBkCmvDnJbZFrR6i8pwwRs1eJOcLnOs8caLbqJRjfV0RxJgOzKsTJxe49hDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQASjYzFGxUNLLe8gAaQkl
iTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQglB4+KQiF37oCfoig7R3OovUT7+Uf
s1Cmrzv1Uj07DrYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
NjI2MDkxMzAzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAL2kNFURkUzWDBrESMXuCd9XRkYLKU2CyKvJiKiUrCVnJGkbBJ9Xb/vpPFknHUNSq
d8jwytagSgyDXfYx1KFLZuIMMoBzadc2TsvPg4linPyAdHBpgPcJEnORU8AYSVr88UrjmD16Z7rS
JLr2L1qvUISHyYtalCEoSnlt7nBAAnDq6vRIEinLOvPIXOkiyh9wJURTiM1FFugFVJSSGs1fcu8U
upVzEhM02nQE7okc5oU/UYur8xU19Rv4eyIleooyHf5cvfqeJGc8aj+6W1dAAOw7V0yDOj0a0Kab
eLBa9onAqEpcjVTpsc1sMo4pcYgiFnpXwIiQTP8W9Yi8YrlX6A==
--00000000000013782d06552484df--

