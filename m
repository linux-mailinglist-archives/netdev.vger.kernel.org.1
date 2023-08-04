Return-Path: <netdev+bounces-24442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC3770335
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D06280D14
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854EBE4F;
	Fri,  4 Aug 2023 14:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE25AD48
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:36:35 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FA46B1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:36:33 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7658430eb5dso181945985a.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159793; x=1691764593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjsasxtWX0U6FKq8GnM9P0/48MMwKj/QP4W+SisUEfA=;
        b=h0Oeb4M5BTbGD0ehMQCF8+FJrGI7PJmWKngdTGFgcl0qRoyE59vBDBI2lWtEN4E2Ag
         s5mUTCAx1Xi+Su/M2p9pe10fFcenpxbG7gmDDvDunGhHgABaIohPkJxHTcOMX8UZKbex
         Oz5G6ighS4OY4dANPy7vCYSSYH7Ir6gRGLOlc6VphqA9tU/AGn+QyHImonldsPni+gSR
         YJFhq+6FV0Z8zRi8B7wEPv0vsKzFSpbKCbL9VelC76u7iTA+B/KzHTrLnILW12DkIP3t
         L+EI6X4SCVEWvjH/cn3I2AUQEg6ZauRRujf5eIVtZulTvIXij7dddK/B0+tDCK3WhPM1
         zsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159793; x=1691764593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjsasxtWX0U6FKq8GnM9P0/48MMwKj/QP4W+SisUEfA=;
        b=YbaEmywdgpZsWAhb5RO1yrgxDJi3ekQUiltoeTheXkdpkCf3EiZ0nn+ZjFn9RMGy/O
         FyrdCg7Xm6+l+IreLpHwAMzQYjpzLBnzGutMcoC7GAyx6KcinOzsqD4vu87WRPVjDkIB
         LlDnE7sgg3uIQ9KWVUflsjerH+nkjc931E5Yop/+DZc0X2pzUuK9jGlhdvGFmyD5xxIs
         4eQVJQI3m0sMZpZvYp9DM1AMB5kpIK4rnOkB0ZKHeoHVWyaVjHONOQc/Cn56AHFX16Wj
         nbDVHAP7Gj+4wOisZHA/EpuOI/kZlI5EqyNxtQCpDcGoNZHLv0PhueHmwRfA73/ZAuHO
         VS3w==
X-Gm-Message-State: AOJu0YwtVf4a6hG4Z0f0QzeBiBbS+zGLGx4F001h+dECpm5vFnZ6KuMl
	IrpWL2gQWeSd7xEqfhCfhbwH+OL5uFHj9w==
X-Google-Smtp-Source: AGHT+IH2kF9dynKoVDE8G3eg4zpo+GhaB1urkGgHlrDqH+9ov7QP/S1DzuNFCJfy2CIwcQ3vw6QUwQ==
X-Received: by 2002:a05:620a:3913:b0:76c:b479:1ad8 with SMTP id qr19-20020a05620a391300b0076cb4791ad8mr2578729qkn.1.1691159792922;
        Fri, 04 Aug 2023 07:36:32 -0700 (PDT)
Received: from luigi.stachecki.net (pool-98-113-30-64.nycmny.fios.verizon.net. [98.113.30.64])
        by smtp.gmail.com with ESMTPSA id a17-20020a05620a103100b00767d8e12ce3sm688242qkk.49.2023.08.04.07.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:36:32 -0700 (PDT)
Date: Fri, 4 Aug 2023 10:36:29 -0400
From: Tyler Stachecki <stachecki.tyler@gmail.com>
To: edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, Martin Habets <habetsm.xilinx@gmail.com>
Subject: Re: [RFC PATCH net] net-gro: restore check for NULL skb in
 napi_gro_frags
Message-ID: <ZM0M7UgvMPFmDfie@luigi.stachecki.net>
References: <20230802092340.9640-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802092340.9640-1-edward.cree@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 10:23:40AM +0100, edward.cree@amd.com wrote:
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
> ---
>  net/core/gro.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 0759277dc14e..0159972038da 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -731,6 +731,9 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
>  	gro_result_t ret;
>  	struct sk_buff *skb = napi_frags_skb(napi);
>  
> +	if (!skb)
> +		return GRO_CONSUMED;
> +
>  	trace_napi_gro_frags_entry(skb);
>  
>  	ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));

Given that this case is rarely hit, and given that there are some performance
concerns raised wrt this change, it may be beneficial to hint that this
branch is unlikely.

