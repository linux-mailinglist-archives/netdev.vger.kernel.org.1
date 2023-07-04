Return-Path: <netdev+bounces-15423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CB7478A4
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 21:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1641C20A70
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FF7496;
	Tue,  4 Jul 2023 19:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694016128
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 19:22:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50010E3
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688498561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFBR9aLLd+UbaMyLdyzrVxs4N2kaUNBTqCwcKCV+cF4=;
	b=F0J8e9rEAa/Nw2FcpcaP1fJgqY8CCyrF+8xKkcDXU/Fjl95NYf/64RmSDsbkzkQtSECdbN
	puOgu+W5cyoAMe9Ow3XlxdZp4+qxMVgui3eIn9CYzi+rsOBxsZ0NAwIspZs9WZn6MMvCUD
	SJszzxAn4yeIjpNREkMcD16hzeEv8VM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-bNqzE_xcOrKocHm-YoH1Eg-1; Tue, 04 Jul 2023 15:22:38 -0400
X-MC-Unique: bNqzE_xcOrKocHm-YoH1Eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C620D800159;
	Tue,  4 Jul 2023 19:22:37 +0000 (UTC)
Received: from [10.39.208.32] (unknown [10.39.208.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7DDF641E;
	Tue,  4 Jul 2023 19:22:35 +0000 (UTC)
Message-ID: <1f4ac369-75f8-f65d-6f31-9c4a5a2a357f@redhat.com>
Date: Tue, 4 Jul 2023 21:22:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xieyongji@bytedance.com, jasowang@redhat.com, david.marchand@redhat.com,
 lulu@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
 <20230704164045.39119-4-maxime.coquelin@redhat.com>
 <20230704124245-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230704124245-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/4/23 18:43, Michael S. Tsirkin wrote:
> On Tue, Jul 04, 2023 at 06:40:45PM +0200, Maxime Coquelin wrote:
>> Virtio-net driver control queue implementation is not safe
>> when used with VDUSE. If the VDUSE application does not
>> reply to control queue messages, it currently ends up
>> hanging the kernel thread sending this command.
>>
>> Some work is on-going to make the control queue
>> implementation robust with VDUSE. Until it is completed,
>> let's disable control virtqueue and features that depend on
>> it.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 1271c9796517..04367a53802b 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
>>   
>>   ATTRIBUTE_GROUPS(vduse_dev);
>>   
>> +static void vduse_dev_features_fixup(struct vduse_dev_config *config)
>> +{
>> +	if (config->device_id == VIRTIO_ID_NET) {
>> +		/*
>> +		 * Temporarily disable control virtqueue and features that
>> +		 * depend on it while CVQ is being made more robust for VDUSE.
>> +		 */
>> +		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_RX) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
>> +				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
>> +				(1ULL << VIRTIO_NET_F_MQ) |
>> +				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
>> +				(1ULL << VIRTIO_NET_F_RSS) |
>> +				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
>> +				(1ULL << VIRTIO_NET_F_NOTF_COAL));
>> +	}
>> +}
>> +
> 
> 
> This will never be exhaustive, we are adding new features.
> Please add an allowlist with just legal ones instead.

Ok, got it!
I'll post a new revision.

Thanks,
Maxime

> 
> 
>>   static int vduse_create_dev(struct vduse_dev_config *config,
>>   			    void *config_buf, u64 api_version)
>>   {
>> @@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>>   	if (!dev)
>>   		goto err;
>>   
>> +	vduse_dev_features_fixup(config);
>> +
>>   	dev->api_version = api_version;
>>   	dev->device_features = config->features;
>>   	dev->device_id = config->device_id;
>> -- 
>> 2.41.0
> 


