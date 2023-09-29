Return-Path: <netdev+bounces-36997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F87B2EDB
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 11:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C4FCF284B19
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472E11725;
	Fri, 29 Sep 2023 09:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC911711
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 09:08:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FD94
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695978488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/1qYpfgB/Cr65fTbE/peTu216y26U+TzDcRaWm5JW8=;
	b=ccjm17hYVZ81ObU1H2GgwGNvsJtHhjiAmIhqQekR/g1MGWI4Ta4Ni8wfZueC8TfimvAY+l
	NQVOM8qeNK+6AOcwIyoIX57B9a5gnfJX1BCv4IXAZVoXpn4a+yXlyoB4YM1mX4LO9M1POH
	CSAOhk8sKFL9nE8lA5LaP9qM/0MJCWw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-f7TvbMDWMxSPff7skgH1QQ-1; Fri, 29 Sep 2023 05:08:06 -0400
X-MC-Unique: f7TvbMDWMxSPff7skgH1QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69881101A53B;
	Fri, 29 Sep 2023 09:08:05 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B84340C6EBF;
	Fri, 29 Sep 2023 09:08:03 +0000 (UTC)
Message-ID: <0af14066-6cc9-bfc6-2a4c-0503f9dd4a5c@redhat.com>
Date: Fri, 29 Sep 2023 11:08:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xieyongji@bytedance.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
 <CACLfguVRPV_8HOy3mQbKvpWRGpM_tnjmC=oQqrEbvEz6YkMi0w@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <CACLfguVRPV_8HOy3mQbKvpWRGpM_tnjmC=oQqrEbvEz6YkMi0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 06:15, Cindy Lu wrote:
> On Tue, Sep 12, 2023 at 3:39 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Tue, Sep 12, 2023 at 11:00 AM Cindy Lu <lulu@redhat.com> wrote:
>>>
>>> In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
>>> with reconnect info, After mapping the reconnect pages to userspace
>>> The userspace App will update the reconnect_time in
>>> struct vhost_reconnect_vring, If this is not 0 then it means this
>>> vq is reconnected and will update the last_avail_idx
>>>
>>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>>> ---
>>>   drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>>>   include/uapi/linux/vduse.h         |  6 ++++++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> index 2c69f4004a6e..680b23dbdde2 100644
>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> @@ -1221,6 +1221,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>>>                  struct vduse_vq_info vq_info;
>>>                  struct vduse_virtqueue *vq;
>>>                  u32 index;
>>> +               struct vdpa_reconnect_info *area;
>>> +               struct vhost_reconnect_vring *vq_reconnect;
>>>
>>>                  ret = -EFAULT;
>>>                  if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
>>> @@ -1252,6 +1254,17 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>>>
>>>                  vq_info.ready = vq->ready;
>>>
>>> +               area = &vq->reconnect_info;
>>> +
>>> +               vq_reconnect = (struct vhost_reconnect_vring *)area->vaddr;
>>> +               /*check if the vq is reconnect, if yes then update the last_avail_idx*/
>>> +               if ((vq_reconnect->last_avail_idx !=
>>> +                    vq_info.split.avail_index) &&
>>> +                   (vq_reconnect->reconnect_time != 0)) {
>>> +                       vq_info.split.avail_index =
>>> +                               vq_reconnect->last_avail_idx;
>>> +               }
>>> +
>>>                  ret = -EFAULT;
>>>                  if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
>>>                          break;
>>> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
>>> index 11bd48c72c6c..d585425803fd 100644
>>> --- a/include/uapi/linux/vduse.h
>>> +++ b/include/uapi/linux/vduse.h
>>> @@ -350,4 +350,10 @@ struct vduse_dev_response {
>>>          };
>>>   };
>>>
>>> +struct vhost_reconnect_vring {
>>> +       __u16 reconnect_time;
>>> +       __u16 last_avail_idx;
>>> +       _Bool avail_wrap_counter;
>>
>> Please add a comment for each field.
>>
> Sure will do
> 
>> And I never saw _Bool is used in uapi before, maybe it's better to
>> pack it with last_avail_idx into a __u32.
>>
> Thanks will fix this
>> Btw, do we need to track inflight descriptors as well?
>>
> I will check this

For existing networking implemenation, this is not necessary.
But it should be for block devices.

Maxime

> Thanks
> 
> cindy
>> Thanks
>>
>>> +};
>>> +
>>>   #endif /* _UAPI_VDUSE_H_ */
>>> --
>>> 2.34.3
>>>
>>
> 


