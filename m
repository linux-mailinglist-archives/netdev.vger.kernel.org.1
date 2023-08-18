Return-Path: <netdev+bounces-28957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4140781404
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E18D2815D4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15BB1BEF9;
	Fri, 18 Aug 2023 19:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478E1BB47
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:59:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAB2135
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692388784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDzn3k92wD7tVS9/ZELLkye6tMNMfjvBj5wC8V1KJdU=;
	b=Vpp1NvI4vaczrGuFJ8WHFFPWb+VPe/Uo7xvwU01gcgusnm8klrADsQ+tIFtiODJHRwa9Ur
	PfSGrjr9ljzvz4Re6HrLOR/58l9OZ7+7g43GWhXpwV4wdzhWwJA/rf5sptXSEmPz3QkRbi
	GwW1qE40LalKoQ9DEE/qVpjLoEwgRb8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-oIooTtXnMTW189zaSGNMMw-1; Fri, 18 Aug 2023 15:59:42 -0400
X-MC-Unique: oIooTtXnMTW189zaSGNMMw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c01c680beso75175766b.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388781; x=1692993581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDzn3k92wD7tVS9/ZELLkye6tMNMfjvBj5wC8V1KJdU=;
        b=irUKT0esSWx2hhdhjkdYFJIhdPz/0/ylOc2jwjxXueHmkfB6oELh/2/Jz5C7nribP8
         az6Fo8AVIE99A4DCoN6YBxcbzQnfnkq3inKMzn1Uv9Oa3BlrXvndf6/Am6kFf9COlqMq
         9yJLdVGuYo7lrkeCG2efV40xxsc6Nn/2L+rCEHHqM56w7M7G9c76FfIx8BkCgfCEMleU
         b0eVR0p1J3M8sEb0/RJbCCEpdD+yV0AaTAz+WmgncItxj3tWNa6FFoK/BN7d82x6N5hy
         mq32PpFYlM9s86KjcWzCZVbHIB18ft2+CKnQUg2092rMsQ70m1aeqEN4IkLoyt1CWupk
         XoPA==
X-Gm-Message-State: AOJu0Yz2s+AbQHxjXAJftYxd6vk8bArhOUQ40rW5ydF5UAvWHXLJtY6k
	BLueIo+BSoZwhUvx2Iz6aN9ORhCZvFGzArCX+VdwFz/JhzuxQ7wueNBmt9MdwHlt4T542ZTLooQ
	aNVIXE0y0wt8AL4OE
X-Received: by 2002:a17:906:51c9:b0:99c:7300:94ad with SMTP id v9-20020a17090651c900b0099c730094admr162968ejk.44.1692388781275;
        Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIccxfZOGL6e5pkivkiiiO2SnrCMikooEtc41rwabO4FV7f1T8ekLyMprc4aw0DW83vGQqzQ==
X-Received: by 2002:a17:906:51c9:b0:99c:7300:94ad with SMTP id v9-20020a17090651c900b0099c730094admr162957ejk.44.1692388781026;
        Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id qq12-20020a17090720cc00b0099d0c0bb92bsm1538009ejb.80.2023.08.18.12.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 12:59:40 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <107f67de-da5a-766b-1cb9-b107f407831b@redhat.com>
Date: Fri, 18 Aug 2023 21:59:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, vbabka@suse.cz,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Christoph Lameter <cl@linux.com>,
 roman.gushchin@linux.dev, dsterba@suse.com
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
 <20230818092612.74025dc7@kernel.org>
Content-Language: en-US
In-Reply-To: <20230818092612.74025dc7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 18/08/2023 18.26, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:17:36 +0200 Jesper Dangaard Brouer wrote:
>> Subject: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache
> 
> Has this been a problem "forever"?
> We're getting late in the release cycle for non-regression & non-crash
> changes, even if small regression potential..
> 

This patch is not dangerous ;-)

SKB slab/kmem_cache is already almost always "no_merge" (due to the
flags it uses), but certain kernel .config combinations can cause it to
be merged (with other 256 bytes slabs).  I happen to hit this config
combination in my testlab, and noticed the problem slight performance
impact.  If anything this patch makes it more consistent.

--Jesper


