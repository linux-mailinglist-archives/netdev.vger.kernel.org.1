Return-Path: <netdev+bounces-20972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77076206A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DA71C20F3A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5F2592A;
	Tue, 25 Jul 2023 17:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AB25140
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:44:54 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149C1B8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:44:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9e9765f2cso30406265ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690307092; x=1690911892;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B59pjqUqoLv5eR+alBSWwxoWyuJwcimZEAnDNC7SrgM=;
        b=h4yrpp1ziP1V/lGwZHWFnYUKZTeKO/5Wf8zQVnu1G3UjsNrHqP8/mfxtNErUXYQGTY
         bxOYckEytR7hMuGinCnZxHiCyg7G7/CH7PLBi70BWepBQfOEmX2UFi6H2NNLK9+6S4DN
         5EXmzq/7t8nVzKKvrjQEn4hE/phUxBtGOjfd/nGy1o1micSVyXaUR7cixXGJcI1cJW3a
         R/CJGdD94dNxLpFRa2EZEXpS/zW1u91yUNdLPNe/jtwiMzFTekPt0F7RZHxEfhncK8Ch
         hUrf0srXJhycktrGb4HTTvK/xtr6JGRC8I/2uTqHrc4yKqZyTXV6iQHaAxqFawkZXK8N
         fOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690307092; x=1690911892;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B59pjqUqoLv5eR+alBSWwxoWyuJwcimZEAnDNC7SrgM=;
        b=L5sY2rrXyUgFlFafW3jo83u3dSjpwZP+j1xuofew8HCzvyWSwU3LInU4AAbVYML6Mp
         9UNhgMSkIAhIhgC6ODYQI6CWrEvBbz0jGKzoSnhF8JZPCyvB/SBpUcxq+Pv7hQxw47hB
         XeRkUckaILCYdestfSA7AYTmbdWuV0H8YUDyYeG2MvB1vrAm1APszu622DAz4/pROJ7L
         o97nBAtW0LXRwWbH1qIh7nEPnX3TLgVbmI16ADSj0oNae3WOkVTiCd18WQW3uC94Ndn9
         A9qLU/5w104beCjy73TGwJM+0swNr/GSlViVf20JegsNcQxubiqok/DEIH8DMhfDYFq0
         OZaA==
X-Gm-Message-State: ABy/qLYqp8B8xtmCOvpCIjLwpm0snYjY+98MQVaZeh3EUXNczGqKdfEU
	0DwgsPpSrCtmkYJxKhpRciYwHNJgEGY=
X-Google-Smtp-Source: APBJJlHd+ErsVOyCiC1NmXqwPjPpr9Jkl/5LOfWqRs6eANJ6fOtYoZMVrOWkpxEhY8RHpwez6KtZkQ==
X-Received: by 2002:a17:902:ec8c:b0:1b9:dea2:800f with SMTP id x12-20020a170902ec8c00b001b9dea2800fmr12752872plg.8.1690307092295;
        Tue, 25 Jul 2023 10:44:52 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id a12-20020a170902eccc00b001bbc9bd51a8sm118678plh.229.2023.07.25.10.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:44:51 -0700 (PDT)
Message-ID: <50201d64ba71669422c9bc2900179887d11a974e.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] net: ipv4: fix return value check in
 esp_remove_trailer()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>, dsahern@kernel.org
Cc: herbert@gondor.apana.org.au, netdev@vger.kernel.org, 
	steffen.klassert@secunet.com
Date: Tue, 25 Jul 2023 10:44:50 -0700
In-Reply-To: <20230725064031.4472-1-ruc_gongyuanjun@163.com>
References: <f6831ace-df6c-f0bd-188e-a2b23a75c1a8@kernel.org>
	 <20230725064031.4472-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-07-25 at 14:40 +0800, Yuanjun Gong wrote:
> return an error number if an unexpected result is returned by
> pskb_tirm() in esp_remove_trailer().
>=20
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  net/ipv4/esp4.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index ba06ed42e428..b435e3fe4dc6 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -732,7 +732,9 @@ static inline int esp_remove_trailer(struct sk_buff *=
skb)
>  		skb->csum =3D csum_block_sub(skb->csum, csumdiff,
>  					   skb->len - trimlen);
>  	}
> -	pskb_trim(skb, skb->len - trimlen);
> +	ret =3D pskb_trim(skb, skb->len - trimlen);
> +	if (ret)
> +		goto out;
> =20
>  	ret =3D nexthdr[1];
> =20

In what case would you encounter this error? From what I can tell it
looks like there are checks in the callers, specifically the call to
pskb_may_pull() at the start of esp_input() that will go through and
automatically eliminate all the potential reasons for this to fail. So
I am not sure what the point is in adding exception handling for an
exception that is already handled.

