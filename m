Return-Path: <netdev+bounces-15854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8381974A29E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1841C20DF3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F4BA30;
	Thu,  6 Jul 2023 16:55:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8691BA23
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 16:55:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC0171D
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688662530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pOCS7eTE+RzvcUp/IElOID7dnpR7b6985yidue+c0zc=;
	b=iuyoa+VzxkfbfDABiSz96nQzeP4lfQlIMKpIiI9wB3FD/Dy7avmXZcFsgk3lS9ocwrmEIl
	u8Xs8ELENFEmcCnSD27ne6Hnlg79amfsegZS4xQHaZRRKx7gVBGybXEqI8OFq4hW8tPK2G
	ixodnlTQ81shOIVhDYb6FkrrOXTVgJU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-DEXSiqBHPTmNo16Vud1_PA-1; Thu, 06 Jul 2023 12:55:29 -0400
X-MC-Unique: DEXSiqBHPTmNo16Vud1_PA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9877da14901so66079966b.1
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662528; x=1691254528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOCS7eTE+RzvcUp/IElOID7dnpR7b6985yidue+c0zc=;
        b=RCqFdISO+RKU+tsYkWUIURt4G04G4AwVj2T1/wQCMZ+E8hVXe2hoUXleudqmjNBIay
         FtGR45YxOjL4T8Yyn3suhDcVMqQyQgjuZVZ/hw1gREamLcFtEF5I373GiAjMjUdnspym
         x2pWdP+Pg2HzRw1K6VwAMrIBxt3qir+/wT2hID7pPffrKHaaT/AVEth/CHodPVR4U5ce
         ytbPNwNwANvt6JqRi86w0vi/S2fP9wxSVfLZfWUDwHXrJcoVHWNHX7rKywDHVzK4Y7pi
         XCRxC8TmzVk45kFElMOE51ZxOdaDZ2OCMipUcsy6abVQNETItApMnRIoPSQ2WU0j42QL
         wqSg==
X-Gm-Message-State: ABy/qLabiq26r4Kzuvb2A2mJf4mAiFgUE8PFUpaIFSR8LDGsNvNOxBuU
	b18JSJIUgyLPGe0lhALxIse9lBRtZtdO1tpq17KH+G7G5yk3fdRaARtYfkWjjbrvGCZVFcRNp1U
	nwCrHlhpME5/wBiDg
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id m25-20020a17090672d900b009786e73e837mr1868723ejl.4.1688662527917;
        Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvgZQm6ryvcWo+UUSqeryd0MPNi4F0BgqwURSiTTNmtxQQXekVmYt8i1lFjJmIZa8T3HBYkg==
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id m25-20020a17090672d900b009786e73e837mr1868706ejl.4.1688662527647;
        Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090617d400b009829d2e892csm1060449eje.15.2023.07.06.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:55:27 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v5 10/17] vhost/vsock: support MSG_ZEROCOPY for
 transport
Message-ID: <3y3emmciqa5ymphc3n5nw3infyiuty65ia7i4movyfmq7rodqb@cethro3rcyf6>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-11-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-11-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 01, 2023 at 09:39:40AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for vhost transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index cb00e0e059e4..3fd0ab0c0edc 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -398,6 +398,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
>@@ -431,6 +436,8 @@ static struct virtio_transport vhost_transport = {
> 		.seqpacket_allow          = vhost_transport_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>


