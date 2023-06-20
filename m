Return-Path: <netdev+bounces-12289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB2736FEF
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8D11C20C56
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C7174C0;
	Tue, 20 Jun 2023 15:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40037168CA
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:13:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD5139
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687273983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIHjNkxkimsgCBMvM6HkxzQRXw0ocJYlxEDBNvgOzO8=;
	b=FvhLQa0t6gttxGwBErqAFAwF+V019aNTIFSgvxHbq3dY/uqqEovRfD8aV6r4CG/GYf0ySa
	UkktabY+UIJl4kdMOOD+7W3OLbDvcD5bqpVAhsOhItbPDUQxf0J6gwUEHRakVz7s6uFv/X
	g/b3WGnGeOIVlX3SNp8mHu6Z7qBUkhg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-wKoCK6U2MtuW5Ptsqqa4Rw-1; Tue, 20 Jun 2023 11:12:55 -0400
X-MC-Unique: wKoCK6U2MtuW5Ptsqqa4Rw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b448b13faaso37133871fa.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687273965; x=1689865965;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIHjNkxkimsgCBMvM6HkxzQRXw0ocJYlxEDBNvgOzO8=;
        b=BipJ38PUj+weqoZQefqe4FxoBPk+tnaMB3ots2qyyHztgAGeC5oh0OIXzKx+dmkLIQ
         PitDnBBn7eojdjEpeaVRfrkAq6xUFIGqti3u82ZP/lAyVScMo81fCBFExkRZz7m4qOrl
         PxVA9yblhEPGhK+qLVfxqXU35Sjg12kIrssBSUhAmLVLX8gtiHDSaWUi37S6S/Dvd9PY
         wv2bFPjH1znyh7W4dn1aKygcoWxk8dAl3eFEQgFhAZIlRndF0B/ScChHKR+3DwJ/8u70
         MTCyW19El8j8tikkgar0jQZokm21rmGgw+Cr6OfvbIswxGjTFKwhmpHWGPvzaDVNolJi
         Bhuw==
X-Gm-Message-State: AC+VfDxmzWCNP7dP2Vq0j1OzZYaVa2gnPz/yOB8F+AN672UUw9p25z0/
	5BulBofcQPIj8JV29Lo4+1QCcKjwk+ipjjXpqd7DGWFVceY6r6Vbr2sPWWEndIIrlDLVEDvuOqb
	lT7MkgBTbGDc/QdjA
X-Received: by 2002:a05:651c:14e:b0:2b4:7559:f240 with SMTP id c14-20020a05651c014e00b002b47559f240mr4078149ljd.6.1687273964879;
        Tue, 20 Jun 2023 08:12:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Lo7qb4XkZPXjkccx/HyjXuRTo3yLp1oLQpdeobTRT2dgjfvEI4TXJ3K+ZZv10qb5gfg8RjQ==
X-Received: by 2002:a05:651c:14e:b0:2b4:7559:f240 with SMTP id c14-20020a05651c014e00b002b47559f240mr4078127ljd.6.1687273964526;
        Tue, 20 Jun 2023 08:12:44 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170906ae4400b0098822e05eddsm1565730ejb.100.2023.06.20.08.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:12:43 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6909d28b-0ffc-a02a-235b-7bdce594965d@redhat.com>
Date: Tue, 20 Jun 2023 17:12:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Eric Dumazet <edumazet@google.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
 <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org>
 <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org>
 <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
 <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
 <72ccf224-7b45-76c5-5ca9-83e25112c9c6@redhat.com>
 <20230616122140.6e889357@kernel.org>
 <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org>
In-Reply-To: <20230619110705.106ec599@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 19/06/2023 20.07, Jakub Kicinski wrote:
> On Fri, 16 Jun 2023 22:42:35 +0200 Jesper Dangaard Brouer wrote:
>>> Former is better for huge pages, latter is better for IO mem
>>> (peer-to-peer DMA). I wonder if you have different use case which
>>> requires a different model :(
>>
>> I want for the network stack SKBs (and XDP) to support different memory
>> types for the "head" frame and "data-frags". Eric have described this
>> idea before, that hardware will do header-split, and we/he can get TCP
>> data part is another page/frag, making it faster for TCP-streams, but
>> this can be used for much more.
>>
>> My proposed use-cases involves more that TCP.  We can easily imagine
>> NVMe protocol header-split, and the data-frag could be a mem_type that
>> actually belongs to the harddisk (maybe CPU cannot even read this).  The
>> same scenario goes for GPU memory, which is for the AI use-case.  IIRC
>> then Jonathan have previously send patches for the GPU use-case.
>>
>> I really hope we can work in this direction together,
> 
> Perfect, that's also the use case I had in mind. The huge page thing
> was just a quick thing to implement as a PoC (although useful in its
> own right, one day I'll find the time to finish it, sigh).
> 
> That said I couldn't convince myself that for a peer-to-peer setup we
> have enough space in struct page to store all the information we need.
> Or that we'd get a struct page at all, and not just a region of memory
> with no struct page * allocated :S

Good with big ideas, but I think we should start smaller and evolve.

> 
> That'd require serious surgery on the page pool's fast paths to work
> around.
> 
> I haven't dug into the details, tho. If you think we can use page pool
> as a frontend for iouring and/or p2p memory that'd be awesome!
> 

Hmm... I don't like the sound of this.
My point is that we should create a more plug-able memory system for
netstack.  And NOT try to extend page_pool to cover all use-cases.

> The workaround solution I had in mind would be to create a narrower API
> for just data pages. Since we'd need to sprinkle ifs anyway, pull them
> up close to the call site. Allowing to switch page pool for a
> completely different implementation, like the one Jonathan coded up for
> iouring. Basically
> 
> $name_alloc_page(queue)
> {
> 	if (queue->pp)
> 		return page_pool_dev_alloc_pages(queue->pp);
> 	else if (queue->iouring..)
> 		...
> }

Yes, this is more the direction I'm thinking.
In many cases, you don't need this if-statement helper in the driver, as
driver RX side code will know the API used upfront.

The TX completion side will need this kind of multiplexing return
helper, to return the pages to the correct memory allocator type (e.g.
page_pool being one).  See concept in [1] __xdp_return().

Performance wise, function pointers are slow due to RETPOLINE, but
switch-case statements (below certain size) becomes a jump table, which
is fast.  See[1].

[1] https://elixir.bootlin.com/linux/v6.4-rc7/source/net/core/xdp.c#L377

Regarding room in "struct page", notice that page->pp_magic will have
plenty room for e.g. storing xdp_mem_type or even xdp_mem_info (which
also contains an ID).

--Jesper


