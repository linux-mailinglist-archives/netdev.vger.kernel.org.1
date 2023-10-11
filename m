Return-Path: <netdev+bounces-39976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F857C5466
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AD01C20CF1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371B1DA3E;
	Wed, 11 Oct 2023 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P06NKT9+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719A107AA
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:54:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945E9D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697028886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+7ZEoe9gqs3ohA/tE8e5TAOHw5GEtQ2AHlZY+ECy20=;
	b=P06NKT9+8xTwhGwQJsHTMj+tm0+zENZSQFcUjdy1dyQbpNis3tELo2s0EcCqG1N1sWfJ+a
	BJVOWzc8bbAA/AKGM4iFBVebASBpIK9NqccAaGThiSGSrU6dZT2hOOnMOwm5qLTYoBDnen
	m10r5bGiHohHP9paPBjd84L0/BaDvig=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-XiFpTWZLPiWpNpyhUpabDA-1; Wed, 11 Oct 2023 08:54:40 -0400
X-MC-Unique: XiFpTWZLPiWpNpyhUpabDA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7742bab9c0cso714965885a.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028879; x=1697633679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+7ZEoe9gqs3ohA/tE8e5TAOHw5GEtQ2AHlZY+ECy20=;
        b=HR/R/yyLhyQwKLKFTq7boOzasrINh2GghPbdfxDzQfEY+CTIXkizWYBe1reCvlP8Oq
         HRXiO6hzGghHYJ3+TJmBVMA5l9xI1nmLHVDdBhkvuSk7JrWiYXdVbJrxphnG78CVita4
         TpCSb0v+WnDpPbMEVA1kSxLSmAjOAP9jZZX1D3dYd3+gEtHYxw5e5ETdkAWT+J+CwwYK
         Dqej2Mkij8Ir/Zicu8IACXN7jv3rmGh7PAI8whaqNNRflVR3ruY/xYwEHzF/Y4ri3zzt
         jiNUGTZhwAFJk5A3P/YREL/m/ibKw9s+nbR2a7x9j1XvlGU77FiA/f+3knEc9JuvdC6T
         4F7A==
X-Gm-Message-State: AOJu0Yx6frCk5zq1OAuZ591VjebmCEAGXzRBmnDw0tpns7aRphTsSMbK
	1NmTwpNfFIXOdbgg6ek2mxH5oCP4SMISlIakTGvSjVKz/HFqwWwptdAJpyFmvJwwlLJKR/vzl8n
	eygeLuckO75G0SbV8
X-Received: by 2002:a05:620a:288c:b0:775:cf6d:a468 with SMTP id j12-20020a05620a288c00b00775cf6da468mr20569732qkp.49.1697028879727;
        Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9V91LsLeBU3VLmajHUFBGtvS1V1JObKngcrNenQu9Dow0QDj9KmJu20EfpX9LZg4A5flqNw==
X-Received: by 2002:a05:620a:288c:b0:775:cf6d:a468 with SMTP id j12-20020a05620a288c00b00775cf6da468mr20569709qkp.49.1697028879396;
        Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it. [79.46.200.251])
        by smtp.gmail.com with ESMTPSA id oo23-20020a05620a531700b00774652483b7sm5210995qkn.33.2023.10.11.05.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:54:38 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:54:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v4 02/12] vsock: read from socket's error queue
Message-ID: <w3r22qa6ydaxa5ke34v6v6lruxyvxrpx2jo7dnakyyvaoqu52j@ohocxsyqpxj7>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
 <20231010191524.1694217-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231010191524.1694217-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:15:14PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place new defines for userspace to the existing file 'vm_sockets.h'
>    instead of creating new one.
> v2 -> v3:
>  * Add comments to describe 'SOL_VSOCK' and 'VSOCK_RECVERR' in the file
>    'vm_sockets.h'.
>  * Reorder includes in 'af_vsock.c' in alphabetical order.
> v3 -> v4:
>  * Update comments for 'SOL_VSOCK' and 'VSOCK_RECVERR' by adding more
>    details.
>
> include/linux/socket.h          |  1 +
> include/uapi/linux/vm_sockets.h | 17 +++++++++++++++++
> net/vmw_vsock/af_vsock.c        |  6 ++++++
> 3 files changed, 24 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


