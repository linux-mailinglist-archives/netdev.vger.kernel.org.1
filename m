Return-Path: <netdev+bounces-21746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CB764940
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D071C214CA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77CC2F5;
	Thu, 27 Jul 2023 07:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B11C154
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 07:48:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826130D7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690444111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
	b=BAfH3eZZvfwnJ81BopGYpP+k8GjtSQzt79eEbkVEr2cVjPdLpQmwhB4yTswajYRZ6B+NFY
	fnfDIP4z5sl/B+tKOj4oqLqDwYTAdYRIMFU4jI42pyT3K469KCFzWOCfcsqF3klvqX6pqw
	hW/6iJzApCwFccZ6IjdClK7JPKCvBdw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-2fZ9vUSEMPiv7qjej-F36A-1; Thu, 27 Jul 2023 03:48:30 -0400
X-MC-Unique: 2fZ9vUSEMPiv7qjej-F36A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bc8f1290eso35662566b.3
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 00:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690444109; x=1691048909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1sGpcCh25quOAjflnOwlUM9P1X98CB5H9u91wgYUjs=;
        b=VV4Rlxgr8Q5//j0OHWz5FK3E8TeofUzS9GljYtROvEHmlvDxJDqRF3GnAq9I/Jv/0i
         WebdtpkKU0vwt2HFfLeV1oEuswN7fC/ZXZ+Wr/JSB7ZX8Jj+acY1t+luyas26ew+XIF5
         DOiW2nD7HdzBY1BaymHG8RH5QvgTVM/yzwWp9QjsOOtQkjN6cO39JpzHh/b77ykEPXz3
         ZIkqyc3CjtqQUfiP0YSeSYqddoEofUuAeplDbeD1fr+zQSIWYUNzU3+xu2yB/Ml7WRMu
         eto89XQaeMScR17cYybUM7wrCJsKW9L8pfGlnUFifry3oesNg10kVVG+EwpObbhftpKn
         Ze7w==
X-Gm-Message-State: ABy/qLYTcn+c9TDZTAPG+MHpxSophXbkrTlkbmQNydjnX2xKYu9i0yi+
	3yGVtp8bc+cv23ZLlD+DSWoImnR3tp3IMCCBb28m10l1V54ycupo2rL7xuhZMjv1g3okWNc2RrX
	KYwLWgBGunWu3/pWK
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id ia8-20020a170907a06800b0098931480e9amr1273086ejc.41.1690444108916;
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE55JyhKwJyB8qUe+lq1MkQNb4GdgSPTG/st46k7wZpyOLVvAygT9RNqVELeE+FBejRoktCsg==
X-Received: by 2002:a17:907:a068:b0:989:3148:e9a with SMTP id ia8-20020a170907a06800b0098931480e9amr1273068ejc.41.1690444108579;
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.102])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906075000b00993a9a951fasm467215ejb.11.2023.07.27.00.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:48:28 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:48:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Simon Horman <simon.horman@corigine.com>, Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <tpwk67lij7t7hquduogxzyox5wvq73yriv7vqiizqoxxtxvfwq@jzkcmq4kv3b4>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
 <20230726143736-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230726143736-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:38:08PM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
>> This commit adds a feature bit for virtio vsock to support datagrams.
>>
>> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> ---
>>  include/uapi/linux/virtio_vsock.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 331be28b1d30..27b4b2b8bf13 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -40,6 +40,7 @@
>>
>>  /* The feature bitmap for virtio vsock */
>>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>>
>>  struct virtio_vsock_config {
>>  	__le64 guest_cid;
>
>pls do not add interface without first getting it accepted in the
>virtio spec.

Yep, fortunatelly this series is still RFC.
I think by now we've seen that the implementation is doable, so we
should discuss the changes to the specification ASAP. Then we can
merge the series.

@Bobby can you start the discussion about spec changes?

Thanks,
Stefano


