Return-Path: <netdev+bounces-46785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7D7E665F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70C0280EF0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251810A39;
	Thu,  9 Nov 2023 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8SWf5T5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717211192
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:14:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878626AF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699521283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
	b=g8SWf5T5KQhsMCNRpnKP337QbtoffTbXYNZ2hm897463pyLRVGy0vGnrokcH1/cgbk+RwW
	QcOVpdrHsnyg7Z2lWcOOMdFZROTsV9RTFxNAz7HSBb32vZ7ti7Nj96H4iM+49GaoltZXZG
	g2wSY5UgZcugITOr6chcsGGXrN7gf7A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-k-5VSDa4Mq-Zt8NiE-2Cmg-1; Thu, 09 Nov 2023 04:14:41 -0500
X-MC-Unique: k-5VSDa4Mq-Zt8NiE-2Cmg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9bfbc393c43so15948266b.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521280; x=1700126080;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rlxAh75JGCxuVSjk/DiobkLepAxu5g+JZPGhaCfgbCo=;
        b=lUWXJ4J4f4qzUWnJq8dYIfuJlx2WXDAMwgjW6VGhl8bRXH96Kanfqn9QB5+MKMCFGd
         L0h4aNvHfGY1++kyENdljCTnEkalWLc0ASRHKIvdslm98OAlSDpMLUuglam+4bekT+r+
         js1+CGWz6kbS0SyJsJh6//ZSWuM6bKz6ERdx18M4LK1EA+/v2/S+ZTmKvXHsfZl8OPc9
         vi6o7GGQzBhkrh3I/whBa8800REaGslSyU/3k/W1DbSuKts0H0EqQk5tXCdqwCuBTfIV
         fRTecAoJ8VibtieVWEH+TfmU8xYSnGfs1KPXzZcTt8Ov2PB551S+rxjCTW3M4qnpNni/
         3ddw==
X-Gm-Message-State: AOJu0Yyn6dSrj1ARzs8dukNFKPx5eMcTdov/t8Wcu/QZuMZ68WQnrejX
	uGelIADR/ne2F9LqtfGRcKKZHfQ85gJS4g+lDizZ2+UfP6nTxuR/VG98OdcePCc4mW/qIEjFCgK
	+ba1bvx0XBXv5wgYn
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052489ejf.0.1699521280330;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrN7rWZV1LJySiH/LlJHce45p7c2N1o4c7lFbPUX87ekT7bdY/faJ0o5ksbIAqMgIYGTojqQ==
X-Received: by 2002:a17:906:e84:b0:9e3:a1a9:3db3 with SMTP id p4-20020a1709060e8400b009e3a1a93db3mr3052473ejf.0.1699521280043;
        Thu, 09 Nov 2023 01:14:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id dv16-20020a170906b81000b009a1c05bd672sm2252071ejb.127.2023.11.09.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:14:39 -0800 (PST)
Message-ID: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Date: Thu, 09 Nov 2023 10:14:37 +0100
In-Reply-To: <20231106024413.2801438-9-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-9-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const skb_=
frag_t *frag)
>   */
>  static inline void __skb_frag_ref(skb_frag_t *frag)
>  {
> -	get_page(skb_frag_page(frag));
> +	page_pool_page_get_many(frag->bv_page, 1);

I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
skb_frag_is_page_pool_iov() check ?


Cheers,

Paolo


