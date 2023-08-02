Return-Path: <netdev+bounces-23602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597576CABF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BA0281B2C
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925856AA1;
	Wed,  2 Aug 2023 10:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718B6FA1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:23:31 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC2270F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:23:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3493d0f785dso210565ab.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690971748; x=1691576548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zqvW6wr7BEPFq+3v8Hlc3C1SZaHqvL4mtdvNsi7qag=;
        b=pRjfbU+WjKYVi65kHXhSPKmI2JEZpFGFOh++GoIad6+ufhc6/BVSnfSAuARg+SE1h4
         S6T8vj5y35WJAep+ng1fllTlVllplUaxvpF8iVQAmYwEln7pKS6pK70wHSn+7rj+0cDP
         5pAeOS6MxHpCMQ1O3yE0TY8N5GjylijTJAuWWJHwzvTI4m/gapm+IUeHFPGXCYqm+b3K
         QHdz2vkz85e/hCluUFDW/gnvz9TuASTrAwEmFrgDQKY164o1MK0cP+kBCRMLOsna0gNc
         i+fSUh0zOLh4Skia/CHd0ucpyd0H88ZPVZSKTOB71Q25qFAsRatIEUQqIcxk300qvcIe
         2gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690971748; x=1691576548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zqvW6wr7BEPFq+3v8Hlc3C1SZaHqvL4mtdvNsi7qag=;
        b=UW+siN1quiRTItdH9xD9F8eYutnGVDEQ8qHNJ3EVld6FaGgfM9XCoahkLsDkKi3YLv
         8b5lgSHV8HWIFoqY6Csu6+R1jr8WWzr/Ba8hVXUlM/TETFHaVSQY1InNYbYCpH7BCbOn
         TQFp4T3E84D9RlgsZ8TtUuzB/xtqfMvhyfO4KQv1GI0AW8Qz9UmyexQkL9MP6VXbaeSp
         rDwV0uxaeVfaFP9CXYXQQil6WdYr8AN77d9UElWnNVcOzNLFzMtqTl9OJNmIklYjvujL
         LPwUsZiyEODdD7B2OzdXbQBr8T7ijUYTfGdFCz1K99wzmDCdQNXqkfiis03gqYNJ1MHB
         bfwg==
X-Gm-Message-State: ABy/qLYmMYOkkcVTxO7oUFTGZ6o/uLQX+NRlo3/DWAa8owQ435CpDH6b
	lOYy9xo8ZCrRpEjV4NhuKK3ky5CH/GA9vOnfelhJYlbh1I6wkg6FCuIH7Q==
X-Google-Smtp-Source: APBJJlHIQVJcnDsVtmr7eYAxK9guOERHKVL+k5fiUjBJrWU30nMVoXl9uCYDg85yhzXET0grHTtbfAgWh7S5MNcBbM4=
X-Received: by 2002:a05:6e02:1562:b0:346:64c0:7648 with SMTP id
 k2-20020a056e02156200b0034664c07648mr1075427ilu.19.1690971748169; Wed, 02 Aug
 2023 03:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802092340.9640-1-edward.cree@amd.com>
In-Reply-To: <20230802092340.9640-1-edward.cree@amd.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Aug 2023 12:22:16 +0200
Message-ID: <CANn89iK6MPMUiAoRQKo+qyKp4ia6q9oweMi5VSawYQHwv4+-ng@mail.gmail.com>
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in napi_gro_frags
To: edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, 
	Martin Habets <habetsm.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 11:42=E2=80=AFAM <edward.cree@amd.com> wrote:
>
> From: Edward Cree <ecree.xilinx@gmail.com>
>
> Cited commit removed the check on the grounds that napi_gro_frags must
>  not be called by drivers if napi_get_frags failed.  But skb can also
>  be NULL if napi_frags_skb fails to pull the ethernet header ("dropping
>  impossible skb" message).  In this case return GRO_CONSUMED, as
>  otherwise continuing on would cause a NULL dereference panic in
>  dev_gro_receive().
>
> Fixes: 1d11fa696733 ("net-gro: remove GRO_DROP")
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
> An sfc customer has encountered this panic in the wild; we're still
>  investigating exactly how it happened (we have a reproducer) but it
>  seems wise to have the core handle this check rather than requiring
>  it in every driver.

An ethernet driver feeding non-ethernet packets to the upper stacks
seems weird to me,
but given napi_frags_skb() does output a warning, I would say this
patch would be acceptable until the real bug is fixed :/

Note that eth_type_trans() does not double-check that at least
ETH_HLEN bytes are present in skb->data

skb_pull_inline(skb, ETH_HLEN);

So eth_type_trans() would definitely crash.
Not sure why a napi_gro_frags() enabled driver would be allowed to
cook arbitrary packets with length <  ETH_HLEN

Mixed feelings here, especially if for some reason the compiler would
not inline napi_frags_skb().

