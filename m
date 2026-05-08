Return-Path: <netdev+bounces-285659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHUgKdt8/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B64F2376
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35612311F4DB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D64372ED6;
	Fri,  8 May 2026 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLkjhVod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F634DCD6
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219012; cv=pass; b=ih+xT0AwoHwmiOcj8HXdWuRYCFsWpBkdxVovyaMePe6lpYfV+RUiIrwfP9GPDUlDy8pu4CypiaxUyQq9ZaDYYWBNHbE9+eGu/JrFJo26Wm0dOZReiz29YydH4ZO415M7ijkqflRQz7lc1kAfQ1wgIwskcEMzNfLUXgimvxBOLrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219012; c=relaxed/simple;
	bh=uX8Bqh7YpeKp4fdj9isKZywI474/oU3ittXTncvIgFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kErHEK4GxiIUrqMx2fLanpJdfT9zLATi1f0IZVks/YMyDit/b/igWUejsqQAumqQlnibTIwS+fu8bRS6QyG493WVlx/VbJpwQncqDZw+OeUjVTa6nsYwDqy0MV2CxLJ4yVJw85K14v9Qhc6x2sLU4QLYkxd7IZO9j5Wi2/mxIms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLkjhVod; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso1333969e0c.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 22:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778219001; cv=none;
        d=google.com; s=arc-20240605;
        b=Kwen/WjiNNWgyNF27DMcA3RdpNzhNJ0CPpe7VGy328OGXQZU3YZw3ClvmMvTSR8f6j
         7KD3iAOQQaIEncgGk8xaVV5ezJnTY4Rpfey7XrNaY8gAeq3v9+LduWuHvPp09xopWynn
         qGr1/hzWdkTPMsKQ7frdp/9GapnHfqmHFvlp7LlW+L1NHR/UrFY+E+kRVdNUeHqrI+SR
         c8MT96bV+DuswvYKfAUIRDkdfbvQ9cB28oQhoTZ/Lrr9hoBeE8mvsJ7FnGj4YWuCzRZp
         bJh35vYkxx21yJ9qCCX+jYK04hsMamasl+1v1cM9xZyJq861fimHGbsWW1TTl1K3awrU
         gr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CDnhIRIXiY7h9ZbppX63ng5K5Ff78Y4tvS1lNHspaTA=;
        fh=dBksNAk7Uh7GgS7Yr4lmFCW8BDEgaFLrLsnUhhKZHu4=;
        b=JgBmEkQgW+dvVkDxJAbqRdR9RfntucxafMBNLu+crtY94uJS8FGpR4o6EcsJa5OU+T
         cGmFibZCI7+vOZadnkT2jUEAxwMXXMFx1l2G19yJgHmIlOT/wjXTiPuBA31P1+YnHAaX
         ac67g+7e1JREm3D9218RshGz9c4jlNPLoV5HvK0zykZvB9qDplISvfezxQPmRIlxZEi1
         mEXJQaKJxEFantiPF9DYfkdLYZtgnKgPzCmTWtxpcZcsM+pmmicqhBc1FLk31N/S1ryQ
         cMeg+NdBANx0zh5KZ0+yDjrNjDDenoXRbX66k4IfvnDc9tIYwms7uPRH7RT9KGocN8Db
         9oKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778219001; x=1778823801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDnhIRIXiY7h9ZbppX63ng5K5Ff78Y4tvS1lNHspaTA=;
        b=BLkjhVodQI8qRrx6yE9A13yJXyiaOsv7qUdkPncubVLAVr7kjGAn3V9UCx4NaQjym4
         eeN77Sl3YebkBjamlrQIhqd/oFByXCCmvK9jXil0eoECD9HRN58GQwhNb3bU7X0CEupK
         XtKkzQAxGFv/9id3hMVcW9AZoLYtdzFvbp6/zlpXKKvLk/TbkCuNNaxyAuZr4jLT8HaI
         ZAuL3P9kqPetB+mQ+geZtmK7/e6CXm56Ud76uOofilFrTz+oclzfk7HK0hXxm6QfzcOZ
         1eOnNhviJ794y0Nd+LkZgJsLc1VZVEYnwbkpmF7VA4IVN6s2XiwMdDosenmyvJy0JLpo
         jMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778219001; x=1778823801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDnhIRIXiY7h9ZbppX63ng5K5Ff78Y4tvS1lNHspaTA=;
        b=RP1xQn00G4c4V70dVVFdB+6f9TZPrsZk/cJ8DWCOg7OOl/GGFpCh1vUozIa0Z9Rcez
         dRNHx2gvtmLOl2l8uvbhwQXj73XCdIxs+hWdd4UGsnzWQ9vasYJ4eW8yBpPMqjnue2Gu
         Y++Yc9oZ1mz+NX3oarfkjewRErSMcel+mHhu8N6EvVZOprIAassl6oOCgJHTf5ZLUBJL
         Zsu/BNN/eBCIuFmSeId2RA5x14242RQNprDQVgizcZ9I+h9a+rZygA/nHpjmVg8ZqFzG
         abflC1WUIOFwG1uCBu1abFxatfz+wI6oN0Pan1hqP8XQyigloKXwVAscT4JGOBcTt2AI
         azig==
X-Forwarded-Encrypted: i=1; AFNElJ+cLrZ5/nl5KepXaOxu6aawXRLi1qgFNlg686HjvrAyX2CQaaU40DLKJA1ii7XpdYFW1d7u9vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwibxaspXXOeApvs1yox1iqDFgL7f6w7W5ZsZvYbx86loCTNtOD
	dLQtC1O9fYspzRxoDMCuoCXATpeN7tzn5rZRVwH0Zql2xiyfhlMt3uKkPsc62CJDgbLn7seGn41
	iX2Avlh2PP/kKKh2R9PAWlYHb8csF1dU=
X-Gm-Gg: Acq92OH0KSOobqt8WhIF9Mi0kdj0t3LxG5mSE3JDRKDhp6WNfzA8CCen4kCxWW3b6ql
	19R8xzV/pC0dgfZp4bY+t4itrwyxOJCUCwIaeEaRRpZxIluO//lAfz9/Y9v3D1oaAYVFTJxyC7Z
	77BMgZ7U1L4T/hLdzP7xKJy78PrpkYpaFC1o9LH9gOvQK34zo94MCtj9h4zsJL962FxDLgkQ0aM
	3rRZCbabpDrqK1tYNova9jMW1EbAmk5P39qj9tONBj8F0kBOPnUrvFYd39KWY+fd4O+GEerOgg4
	spUFo+Z3fDaT+ZSq1w==
X-Received: by 2002:a05:6122:915:b0:575:3b34:28bd with SMTP id
 71dfb90a1353d-575595653c4mr6840849e0c.8.1778219001028; Thu, 07 May 2026
 22:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAAOPT9Jw_TKnuqyQ_5es_ot0SNLprU2fSJwtEORj3OLf_QECA@mail.gmail.com>
 <aftA0Iwi2aX_4ORo@gondor.apana.org.au>
In-Reply-To: <aftA0Iwi2aX_4ORo@gondor.apana.org.au>
From: Yilin Zhu <zylzyl2333@gmail.com>
Date: Thu, 7 May 2026 22:43:10 -0700
X-Gm-Features: AVHnY4I2UmjcPPhXYzBwRo2_jYwaRcKF6yXje_bVTzJ29AOMPj3itzn_GbLLixI
Message-ID: <CAAAOPT9Mt8jw+2J+DGDztOo6ou=9CbsERRZSq19+DrBo0_+Qgg@mail.gmail.com>
Subject: Re: [v3 PATCH] xfrm: ipcomp: Free destination pages on acomp errors
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: n05ec@lzu.edu.cn, netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F25B64F2376
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285659-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,lzu.edu.cn:email]
X-Rspamd-Action: no action

On Wed, 6 May 2026 at 06:24, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Orion Zhu <zylzyl2333@gmail.com> wrote:
> >
> > Thanks, but I think moving the label is not safe for all paths reaching
> > ipcomp_post_acomp().
>
> Thanks for checking!
>
> We could fix this by checking whether req is NULL and whether
> sg_page(dsg) is NULL.
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
> index 5f38dff16177..671d48f8c937 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -51,11 +51,15 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
>         struct scatterlist *dsg;
>         int len, dlen;
>
> -       if (unlikely(err))
> -               goto out_free_req;
> +       if (unlikely(!req))
> +               return err;
>
>         extra = acomp_request_extra(req);
>         dsg = extra->sg;
> +
> +       if (unlikely(err))
> +               goto out_free_req;
> +
>         dlen = req->dlen;
>
>         pskb_trim_unique(skb, 0);
> @@ -84,10 +88,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
>                 skb_shinfo(skb)->nr_frags++;
>         } while ((dlen -= len));
>
> -       for (; dsg; dsg = sg_next(dsg))
> +out_free_req:
> +       for (; dsg && sg_page(dsg); dsg = sg_next(dsg))
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

Hi Herbert,

Thanks for the update.

I think this version looks reasonable to me. Checking req before
dereferencing it and stopping the SG walk at a NULL sg_page() should
cover the setup failure paths I was concerned about, while still freeing
the allocated destination pages on the acomp error path.

Could you please also add my Reported-by tag?

Reported-by: Yilin Zhu <zylzyl2333@gmail.com>

Thanks,
Yilin

