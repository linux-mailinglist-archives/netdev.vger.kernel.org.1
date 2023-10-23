Return-Path: <netdev+bounces-43526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79947D3BD6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C34BB20C80
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B81CABA;
	Mon, 23 Oct 2023 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlnzEa6u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762F1CA80
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:10:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869F10C
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698077447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
	b=HlnzEa6u3mpQrQ+VFzSzl4A64TV9KEmBUxv9eN/egzpVH8AsPkpOVejXXfk6MPN/z1OndN
	h3GHxW9Y6NVXzd1hIgwarLNPAMZiwWRYKEkSrJ1XDcuz+AgAqf//zRc4h04c+2ag7+jo4w
	Ejin5QuAjjT23VIOYKl+maFkIdvjaeM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-SsX7N0r6N_iZW9VNLSX2VQ-1; Mon, 23 Oct 2023 12:10:35 -0400
X-MC-Unique: SsX7N0r6N_iZW9VNLSX2VQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66ac99ce80eso43891036d6.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 09:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077434; x=1698682234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6IGtTXgNreBRSdHRcyHDWS2q1BSGKyDG55d0zg7uE=;
        b=uI0GayY62BNI7lzFS33SE5EsiNqF4J4qqDGqhQwtf0ceVjPvEFpl76y4HuMtHzyrpH
         rnxlUE2QPnjP7gXu6845gOxNMqJi6G21UBa2MSqjvpBVlcNA6PHKO5s29trom5AhcWiO
         oUDYCUXLt633S0U90M8ApesesDf4zShSdZgdTBdcGqTOhQtei95zMsm1MW6f8aws566t
         vwvMMcc5jQA1chCmrl/9K1X7rcNgVksDCmYBI2DCjgV008jAdsVfmrNhZQTZuaZj+C3y
         x9H0olU03nJD87xw/3Y1WoMHXUsCQDAF+aRDZrZFbPuN/so2Tdzhyr7AgnIton4+FAow
         R+vA==
X-Gm-Message-State: AOJu0YxM5sS/GT9k7VdpdLdQBXIEQgaZVcjOb030sAW5xrKG0pPTEEwR
	BywiObbhx1ar/6gnIghi/7/zsZE0U7E+5Ps/f4vDpkXYR6Kf/I7c0H7TWrQ2uisRdq3yOkW8Svi
	ZVXVzyIpBmdiMGLOO
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id a10-20020a0562140c2a00b0066d818fa483mr10587095qvd.32.1698077434690;
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXvJRhDKCA/YN/pdkU/PNM0UdgNdRiMmQ0LK/XFZjxqjKVtJ/tiIKHk5iR/BGmtnOfa3u01A==
X-Received: by 2002:a05:6214:c2a:b0:66d:818f:a483 with SMTP id a10-20020a0562140c2a00b0066d818fa483mr10587070qvd.32.1698077434403;
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id bz18-20020ad44c12000000b0065b29403540sm2960253qvb.127.2023.10.23.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:10:34 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:10:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mihai Petrisor <mihai.petrisor@uipath.com>, Viorel Canja <viorel.canja@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <jyjfsjvfmmr7ucf53v6p57scdxah64bgvd2lj7l4hbjwiyd2ct@lj3ejlseqvog>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
 <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
 <0624137c-85cf-4086-8256-af2b8405f434@uipath.com>
 <632465d0-e04c-4e10-abb9-a740d6e3dc30@uipath.com>
 <dynlbzmgtr35byn5etbar33ufhweii6gk2pct5wpqxpqubchce@cltop4aar7r6>
 <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01ad7d00-9a53-445b-8916-3342047112a0@uipath.com>

On Mon, Oct 23, 2023 at 06:36:21PM +0300, Alexandru Matei wrote:
>On 10/23/2023 6:13 PM, Stefano Garzarella wrote:
>> On Mon, Oct 23, 2023 at 05:59:45PM +0300, Alexandru Matei wrote:
>>> On 10/23/2023 5:52 PM, Alexandru Matei wrote:
>>>> On 10/23/2023 5:29 PM, Stefano Garzarella wrote:
>>>>> On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>>>>>> Once VQs are filled with empty buffers and we kick the host,
>>>>>> it can send connection requests.  If 'the_virtio_vsock' is not
>>>>>> initialized before, replies are silently dropped and do not reach the host.
>>>>>>
>>>>>> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>>>>>> Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>>>>>>  the_virtio_vsock initialization after vqs_init
>>>>>>
>>>>>> net/vmw_vsock/virtio_transport.c | 9 +++++++--
>>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>>>>> index e95df847176b..92738d1697c1 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport.c
>>>>>> @@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>>>>>     vsock->tx_run = true;
>>>>>>     mutex_unlock(&vsock->tx_lock);
>>>>>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>>>>>
>>>>> What about renaming this function in virtio_vsock_vqs_start() and move also the setting of `tx_run` here?
>>>>
>>>> It works but in this case we also need to move rcu_assign_pointer in virtio_vsock_vqs_start(),
>>>> the assignment needs to be right after setting tx_run to true and before filling the VQs.
>>
>> Why?
>>
>> If `rx_run` is false, we shouldn't need to send replies to the host IIUC.
>>
>> If we need this instead, please add a comment in the code, but also in the commit, because it's not clear why.
>>
>
>We need rcu_assign_pointer after setting tx_run to true for connections 
>that are initiated from the guest -> host.
>virtio_transport_connect() calls virtio_transport_send_pkt().  Once 
>'the_virtio_vsock' is initialized, virtio_transport_send_pkt() will 
>queue the packet,
>but virtio_transport_send_pkt_work() will exit if tx_run is false.

Okay, but in this case we could safely queue &vsock->send_pkt_work after 
finishing initialization to send those packets queued earlier.

In the meantime I'll try to see if we can leave the initialization of 
`the_virtio_vsock` as the ulitmate step and maybe go out first in the 
workers if it's not set.

That way just queue all the workers after everything is done and we 
should be fine.

>
>>>>
>>>
>>> And if we move rcu_assign_pointer then there is no need to split the function in two,
>>> We can move rcu_assign_pointer() directly inside virtio_vsock_vqs_init() after setting tx_run.
>>
>> Yep, this could be another option, but we need to change the name of that function in this case.
>>
>
>OK, how does virtio_vsock_vqs_setup() sound?

Or virtio_vsock_start() (without vqs)

Stefano

>
>> Stefano
>>
>>>
>>>>>
>>>>> Thanks,
>>>>> Stefano
>>>>>
>>>>>> +{
>>>>>>     mutex_lock(&vsock->rx_lock);
>>>>>>     virtio_vsock_rx_fill(vsock);
>>>>>>     vsock->rx_run = true;
>>>>>> @@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>>>>>     virtio_vsock_event_fill(vsock);
>>>>>>     vsock->event_run = true;
>>>>>>     mutex_unlock(&vsock->event_lock);
>>>>>> -
>>>>>> -    return 0;
>>>>>> }
>>>>>>
>>>>>> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>>>> @@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>>>>>>         goto out;
>>>>>>
>>>>>>     rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +    virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>>     mutex_unlock(&the_virtio_vsock_mutex);
>>>>>>
>>>>>> @@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
>>>>>>         goto out;
>>>>>>
>>>>>>     rcu_assign_pointer(the_virtio_vsock, vsock);
>>>>>> +    virtio_vsock_vqs_fill(vsock);
>>>>>>
>>>>>> out:
>>>>>>     mutex_unlock(&the_virtio_vsock_mutex);
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>
>>
>


