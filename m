Return-Path: <netdev+bounces-284714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIg0Btvg+mmGTgMAu9opvQ
	(envelope-from <netdev+bounces-284714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D04D69FA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0184B3040CA8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BD330DEA6;
	Wed,  6 May 2026 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJEg7msS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E030B50A
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049240; cv=pass; b=cHQsK531w3LQt12HuA5t6X3WmLmwmXznWnn8E2FoxU9iRhvVrGA91gTtpjBogt0+RzjsD0tdcCdDH3dC8jOhRw85gHtZwYU8Aw9yNBflmBTWTM2xv2Ma65Acoq3I8m2R42J+p2LkEfAArpuvPgYqnun1ga12gqJ3315Gqa7CtsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049240; c=relaxed/simple;
	bh=XUvk/D4ICQVVUEWLzbiEIEVsBbSF+YP+BclNFl3UgkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtl2swYkMnm98c5n0ZsnJMaT9Q4O1OXkh9RHCJy+7ZTRRz8yJTax613npXQntKAvDSxP7ek0TuchcXuYQ+1EfJiSO0yQzqCFS/gsAfjK4Pn0HjM+OyRWKQSq6SR0tKu6CfM1CcOgDesWhU23hvVT0WmWHgFKtOiSENpcCww+pws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJEg7msS; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95d04f205beso2171982241.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 23:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778049237; cv=none;
        d=google.com; s=arc-20240605;
        b=OrRRRYiQEuTDFXBQmcB5PiIRdC8iqMeuQsX6ujf3Zznc00YIrSj+RTKmNLK94FS4Sp
         cPNR5k7lLqvcop/4PXp9or1YYqUo587Ap5IK8OFobXzq9XofAZ1oajBPI4UhudbISLBy
         Us2ckoX9IP+FS0zmhvYMZZ5NqcZGttckFCjz4FVKYvYd+Tk7cPBkVESl7QI6YL/uWmzj
         bxQcH9X/xDGarNgFST8Z7/mX5tNgsOquBHcr3LDitv09ft7T7DRAt7RUNCr+2/aVUjGi
         73aD7GT6yxpDWlp1zUaaK6gDGPBC2TKBh81Z+L2leUOyDbSL0znr4/rrtQ3VQYbp8MEy
         LeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbKnM/iLzddpSWIhLA0pq33cwEjcHOFeZdKhomP20Zc=;
        fh=wv3SGhqV2gEahoHXFgiRnaX8OYmXKqxMnvEYelLMNAs=;
        b=Q4JrJ6j9sVgB3Dc4VFs+gB3xbw2NCBbcBxa/gHVJnaNUDmis8fyMvHFCx+GdYMpzsb
         XlIXFAPq5VwBh6X+32NjeOwcNLaBdukc+M3DK2fBOfJlrCsIYhgVPi2tC6yhkkNRHayf
         brVH8fcfw0iNGJFxo42prJ6bUoMQGSdHjrL9v2Ug4HBU/KKXVz3o5JGyaWo3nLIc3Z1N
         KdFnDnJpnVkOFN8iIpIVG3OGyg501irsDyU/ekeafCZluJz9yagL+6Pt3x1Z19QLhciM
         9lwlwQ+QtcgTT3XCiAxI2OkDw64fe9RObxBBV4H1P1F4O8RF0rtwPw+2A471qzwz3Yvy
         ggyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778049237; x=1778654037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbKnM/iLzddpSWIhLA0pq33cwEjcHOFeZdKhomP20Zc=;
        b=BJEg7msSjsVROLi9Ggc2uqpYTiGjwdKOqi1cBHihje5GtWU4F9+I7SRxaNa6MuoFu2
         nR+3A8Q73Z+yxD0KGRRmtnp9klN2FsReL4g0YY0nc0AAZtuSF3MtsGq8TNZ86PlnbIov
         8hDFqtsf71nDt7w/7cCmKCDG+1dpk4F9ItTdWq1cP4zuP/9/EVjuFT4qHYeSG9IZl5Nc
         8X7iexHDU2MdrpA4Bx4s8DZh2Ci/NxcRtuShstkzjR5xPaNJh0wC7bnRLsLAygHqZRDM
         fOVMLVauDmVgBdYNOtF7plYA4Ennw0NVFeZDokuO+q0Lm901QSdq8qC6sCqb1gUXwCn1
         RoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778049237; x=1778654037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbKnM/iLzddpSWIhLA0pq33cwEjcHOFeZdKhomP20Zc=;
        b=H1TRBlNa0qxb3voJkVZl5k33rnG7x3+Hhs9BW8Qf/Xieq7UjoMORBBal+x+vbYIzXE
         fNNesIxJBLL/8RLbU4kFtqkUcoRIY4L1UG95GMl3Ep80/9fRc3zGNzONpLG+mldX15wK
         LX9VshbiNPVeUb9dK4MrOSgN9jzDFWHBIUDssgskfSko0Cs32Yi92LkADzmV4S8U8zPG
         UxflNI/dZwDd3TuZO+j6HEyQ5q87w15FLHHs5/U+ZMKJB805jGX3tppmj5Ou5yXl4K7w
         ef1h9Sa0953xwE5/hjT3y5CxUy3Bb7KexFFd5WyzczSHFR+4A31yxKRkzeq/XsmaL+eS
         cvcw==
X-Forwarded-Encrypted: i=1; AFNElJ+v4rp8EXj+aqhH/Dkyv+m3WTuHoGMvhRXXfQFWdI6kVwDJT18jVwHMAGO5+B8aHAsqueYB3Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbS7K1eXq05eMCB2Oc6tVhO4o9HYQmSjfjQag4F/wtzWxZOPdd
	vEWjBcT7myctULHNmpldtdWxCdx3h3KeyCuP8ajbudvGRuI5C6KFzlHkttAjfrAFScYrD1JqSgG
	bOPvFUfdZsWAMGeBK5tKmrBRAM64rW5o=
X-Gm-Gg: AeBDiesmO9Zc5uZmvRu7P0FleQhs6uqdNoZbylED2eWLed3Qm5/vpRETFyct33Av1LR
	kPELmHKZi3yWbZr7GmMDoNyFNF1z+sQV2fKmY5OUzs28GPsE23SXsbjaGwL87NlpH4IUldYo78Z
	LZNWNy50EkwJ1doMJI3aggy8GJdjhObp4AICpEsSTRFmrPU4n2YZEbT2yNQARJBQ6hoX/TpwHkX
	AM1FwQD2GLR9r71mj6swU5j7CnD5rsYUQcNkht70bUccLJ9Hl3h3UyqcTKdTJ0XxOmcNmgqX/Az
	a8j97/qY0KDeor9S2P9sEL3Z/CyLE7e9eXM34sQ=
X-Received: by 2002:a05:6102:418a:b0:60f:f543:232a with SMTP id
 ada2fe7eead31-630f8e78525mr773014137.2.1778049237029; Tue, 05 May 2026
 23:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777923646.git.zylzyl2333@gmail.com> <8c304d9250d947b94cebc1cb1f85c73aa2bf0414.1777923646.git.zylzyl2333@gmail.com>
 <afm18k8_CKGOl0oT@gondor.apana.org.au>
In-Reply-To: <afm18k8_CKGOl0oT@gondor.apana.org.au>
From: Orion Zhu <zylzyl2333@gmail.com>
Date: Tue, 5 May 2026 23:33:45 -0700
X-Gm-Features: AVHnY4KwSZzARIjZdrm-nR76rmOiMNRbKYDIRyVEyqI1ytX-Uvb-Wq8s_R_iWLc
Message-ID: <CAAAOPT9Jw_TKnuqyQ_5es_ot0SNLprU2fSJwtEORj3OLf_QECA@mail.gmail.com>
Subject: Re: [v2 PATCH] xfrm: ipcomp: Free destination pages on acomp errors
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 861D04D69FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,secunet.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zylzyl2333@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,mail.gmail.com:mid]

On Tue, 5 May 2026 at 02:19, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, May 05, 2026 at 04:52:59PM +0800, Ren Wei wrote:
> > From: Yilin Zhu <zylzyl2333@gmail.com>
> >
> > ipcomp_setup_req() allocates destination pages for the acomp output
> > scatterlist. On successful completion, ipcomp_post_acomp() attaches the
> > used pages to the skb and frees any unused pages.
> >
> > On an acomp error, ipcomp_post_acomp() skips directly to freeing the
> > request. acomp_request_free() only releases the request itself, so the
> > caller-allocated destination pages are left allocated.
> >
> > Track the number of destination pages allocated for the request and free
> > them on the error path before releasing the request.
> >
> > Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> > Cc: stable@kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> > Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> > Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/xfrm/xfrm_ipcomp.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
>
> Thanks for the patch! How about just moving the out_free_req label:
>
> ---8<---
> Move the out_free_req label up by a couple of lines so that the
> allocated dst SG list gets freed on error as well as success.
>
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> index 5f38dff16177..2947321b043d 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -51,11 +51,12 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
>         struct scatterlist *dsg;
>         int len, dlen;
>
> +       extra = acomp_request_extra(req);
> +       dsg = extra->sg;
> +
>         if (unlikely(err))
>                 goto out_free_req;
>
> -       extra = acomp_request_extra(req);
> -       dsg = extra->sg;
>         dlen = req->dlen;
>
>         pskb_trim_unique(skb, 0);
> @@ -84,10 +85,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
>                 skb_shinfo(skb)->nr_frags++;
>         } while ((dlen -= len));
>
> +out_free_req:
>         for (; dsg; dsg = sg_next(dsg))
>                 __free_page(sg_page(dsg));
>
> -out_free_req:
>         acomp_request_free(req);
>         return err;
>  }
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks, but I think moving the label is not safe for all paths reaching
ipcomp_post_acomp().

ipcomp_post_acomp() is also called when ipcomp_setup_req() returns an
ERR_PTR. In particular, acomp_request_alloc_extra() can fail after
ipcomp_cb(skb)->req is set to NULL, so moving acomp_request_extra(req)
before the error check would dereference NULL.

There are also setup failures after the request is allocated but before
the destination SG list contains any allocated pages. skb_to_sgvec() can
fail before sg_init_table(dsg, dnfrags), and alloc_page() can fail before
the first destination page is installed. In those cases walking extra->sg
with sg_next() and freeing sg_page(dsg) would operate on an uninitialized
or empty destination SG list, potentially freeing NULL or non-owned pages.

That is why the patch tracks the number of destination pages actually
allocated and frees exactly that count on the acomp error path.

Best regards,
Yilin Zhu

