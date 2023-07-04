Return-Path: <netdev+bounces-15362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F88747288
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BCA1C208C2
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D586123;
	Tue,  4 Jul 2023 13:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F35695
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:18:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB910EC
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688476649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRXNwgWnFU9ZqZTTaRpnSrUAwofFRUsqVGfrl1t654U=;
	b=BYBZ4BQGeRU2t4X2ysxArqpR/LK2PslYmj8v4YxvhrXj+8quiwBZQTXjj9U7TlfwtKKCLN
	9JP6s4ZwmHvQa5GMcCkdIB12lduX7sNCyKipiKNgVNvpbJuBeQjfACpH87VGJPyb4coxwa
	1xilRyjqiFoghxG1rORzJTqTpArFkDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-7jjORAkmPd25ysBKCGMs1Q-1; Tue, 04 Jul 2023 09:17:27 -0400
X-MC-Unique: 7jjORAkmPd25ysBKCGMs1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FAE41044594;
	Tue,  4 Jul 2023 13:17:27 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CC7140C2063;
	Tue,  4 Jul 2023 13:17:25 +0000 (UTC)
Message-ID: <8128857f-e292-2e41-cdb9-9c5d4a2f79c7@redhat.com>
Date: Tue, 4 Jul 2023 15:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
 david.marchand@redhat.com, lulu@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
 <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
 <20230704055840-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230704055840-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/4/23 11:59, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 10:43:07AM +0200, Maxime Coquelin wrote:
>>
>>
>> On 7/3/23 23:45, Michael S. Tsirkin wrote:
>>> On Mon, Jul 03, 2023 at 09:43:49AM +0200, Maxime Coquelin wrote:
>>>>
>>>> On 7/3/23 08:44, Jason Wang wrote:
>>>>> On Sun, Jul 2, 2023 at 9:37 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
>>>>>>> This small series enables virtio-net device type in VDUSE.
>>>>>>> With it, basic operation have been tested, both with
>>>>>>> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
>>>>>>> adding VDUSE support using split rings layout (merged in
>>>>>>> DPDK v23.07-rc1).
>>>>>>>
>>>>>>> Control queue support (and so multiqueue) has also been
>>>>>>> tested, but requires a Kernel series from Jason Wang
>>>>>>> relaxing control queue polling [1] to function reliably.
>>>>>>>
>>>>>>> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
>>>>>>
>>>>>> Jason promised to post a new version of that patch.
>>>>>> Right Jason?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> For now let's make sure CVQ feature flag is off?
>>>>>
>>>>> We can do that and relax on top of my patch.
>>>>
>>>> I agree? Do you prefer a features negotiation, or failing init (like
>>>> done for VERSION_1) if the VDUSE application advertises CVQ?
>>>>
>>>> Thanks,
>>>> Maxime
>>>
>>> Unfortunately guests fail probe if feature set is inconsistent.
>>> So I don't think passing through features is a good idea,
>>> you need a list of legal bits. And when doing this,
>>> clear CVQ and everything that depends on it.
>>
>> Since this is temporary, while cvq is made more robust, I think it is
>> better to fail VDUSE device creation if CVQ feature is advertised by the
>> VDUSE application, instead of ensuring features depending on CVQ are
>> also cleared.
>>
>> Jason seems to think likewise, would that work for you?
>>
>> Thanks,
>> Maxime
> 
> Nothing is more permanent than temporary solutions.
> My concern would be that hardware devices then start masking CVQ
> intentionally just to avoid the pain of broken software.

Got it, I'll add a patch on top that filters out CVQ feature and all the
features that depend on it.

Thanks,
Maxime

> 
>>>
>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>>> RFC -> v1 changes:
>>>>>>> ==================
>>>>>>> - Fail device init if it does not support VERSION_1 (Jason)
>>>>>>>
>>>>>>> Maxime Coquelin (2):
>>>>>>>      vduse: validate block features only with block devices
>>>>>>>      vduse: enable Virtio-net device type
>>>>>>>
>>>>>>>     drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>>>>>>>     1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> 2.41.0
>>>>>>
>>>>>
>>>
> 


