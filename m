Return-Path: <netdev+bounces-16870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B474F1BD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AAE1C20F10
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB219BB2;
	Tue, 11 Jul 2023 14:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F318C1F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:21:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7301987
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689085223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NY9zvWPkMIRBdIzQwvp51bTldJwjnkTeVv0DGYO1saU=;
	b=EEZFmlF+yieTl6IKylqEc/8VXSb+4gW6rUG3hZGOiAwHlnXYrKX9YyTxGeVbQxzRwcX2Bk
	j8pMRS4HBRVNloECLsYVyc/fZ5OMegaQ+FjbvhZjS++tNpAmlrye2XTftAbMte/LzahpcD
	S2CG+/DeSCSluCDddv5ntgutNFeCDhY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-owKJyGXMPSOsyC8L1C253A-1; Tue, 11 Jul 2023 10:20:22 -0400
X-MC-Unique: owKJyGXMPSOsyC8L1C253A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52C1B28040B2;
	Tue, 11 Jul 2023 14:16:56 +0000 (UTC)
Received: from [10.39.208.24] (unknown [10.39.208.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6434B40C2070;
	Tue, 11 Jul 2023 14:16:54 +0000 (UTC)
Message-ID: <3a8073d5-dab4-ed13-2c53-84ed5093bacb@redhat.com>
Date: Tue, 11 Jul 2023 16:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 xieyongji@bytedance.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-2-lulu@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
In-Reply-To: <20230628065919.54042-2-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Cindy,

On 6/28/23 08:59, Cindy Lu wrote:
> From: Your Name <you@example.com>
> 
> this struct is to save the reconnect info struct, in this
> struct saved the page info that alloc to save the
> reconnect info
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 26b7e29cb900..f845dc46b1db 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -72,6 +72,12 @@ struct vduse_umem {
>   	struct page **pages;
>   	struct mm_struct *mm;
>   };
> +struct vdpa_reconnect_info {
> +	u32 index;
> +	phys_addr_t addr;
> +	unsigned long vaddr;
> +	phys_addr_t size;
> +};
>   
>   struct vduse_dev {
>   	struct vduse_vdpa *vdev;
> @@ -106,6 +112,7 @@ struct vduse_dev {
>   	u32 vq_align;
>   	struct vduse_umem *umem;
>   	struct mutex mem_lock;
> +	struct vdpa_reconnect_info reconnect_info[64];

Why 64?
Shouldn't it be part of struct vduse_virtqueue instead?

>   };
>   
>   struct vduse_dev_msg {


