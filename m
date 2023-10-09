Return-Path: <netdev+bounces-39185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFF7BE473
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21281C209EC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5A36AFD;
	Mon,  9 Oct 2023 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZDCVBSI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60E10A36
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:17:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF35A3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696864668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5JcXPIqedItIu+FW3AQTSKHWl8dmpt+dQk3rJLF9AU=;
	b=dZDCVBSIXJ6QpsutUjS0qbD3bHwnIrdHJOzSjqVdj5OTGOPT4TPzWyLOGL1JWaojrKq72X
	arQY1HTU/woLKpxROiy6tQcPdq/X1xD4HG4D99kEQAiY6wBA0GTLEuxMEfjc7ptItpRZru
	WTcfyHqcPbl+Lt1RLBs5CzFV3Kz+uPQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-hMXFTgLMPZKOLqnicTaCCg-1; Mon, 09 Oct 2023 11:17:39 -0400
X-MC-Unique: hMXFTgLMPZKOLqnicTaCCg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a62adedadbso126800966b.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864658; x=1697469458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5JcXPIqedItIu+FW3AQTSKHWl8dmpt+dQk3rJLF9AU=;
        b=md6pnGN44ql5zg/zzrWS/Smkh5dRePVUzDc0OSAU6bu5IQX22h9WCXwl63ZHos3evP
         Lbnjd1ma6y1GlVj7hBEkLk1lGPFb3aIb6OXIOFlel54/Q5dCQMahP8EbfP59zJ4qgj5B
         yMbpKn3l2QYegNtC9aB3g2PSb4hAqFIbVJ37Tr72N2paAO3RLuC6DSpnSBoGdXGeMWzD
         65r/FzFzEhk63wzus86nM2DtFCj6inwABUJX4uidUyGmOV3rPIOP+wygL9zYq8XqIFK7
         edA0WPUuEc0+z9tJTj/nzo+oQqW5mscvXIvnI+b8YhsV8QvPJh+xAFms8zcL94EgNUQP
         7eHA==
X-Gm-Message-State: AOJu0Yz0hNNK+7n2Pwa3owW0rO+pFFHrTI10oSU8HMOkarwdWtlRftP8
	HacX+LggkPQV/Lz8Bj1/OGQJE7r14/yii9NZKIseqCacY1B++1FGI0NMHlvzxYQy2jZose1SVW2
	YIuEQ5Eaulq+00e71
X-Received: by 2002:aa7:c991:0:b0:536:e5f7:b329 with SMTP id c17-20020aa7c991000000b00536e5f7b329mr13448865edt.33.1696864658547;
        Mon, 09 Oct 2023 08:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqaNdjOVR8GEVS7MrW8+be1z+py7ZOPR3ncwNWSeW3qxMntltB1eh7SSq1dhz3kONe9XqOGA==
X-Received: by 2002:aa7:c991:0:b0:536:e5f7:b329 with SMTP id c17-20020aa7c991000000b00536e5f7b329mr13448839edt.33.1696864658056;
        Mon, 09 Oct 2023 08:17:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id w24-20020a50fa98000000b00532bec5f768sm6197050edr.95.2023.10.09.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:17:37 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:17:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 11/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <afcyfpp6axca3d2ebtrp44o4wqxkutbn6eixv2gnpa2r3ievhr@yx2462i5p3e7>
References: <20231007172139.1338644-1-avkrasnov@salutedevices.com>
 <20231007172139.1338644-12-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231007172139.1338644-12-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 08:21:38PM +0300, Arseniy Krasnov wrote:
>To use this option pass '--zerocopy' parameter:
>
>./vsock_perf --zerocopy --sender <cid> ...
>
>With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Move 'SOL_VSOCK' and 'VSOCK_RECVERR' from 'util.c' to 'util.h'.
> v2 -> v3:
>  * Use 'msg_zerocopy_common.h' for MSG_ZEROCOPY related things.
>  * Rename '--zc' option to '--zerocopy'.
>  * Add detail in help that zerocopy mode is for sender mode only.
>
> tools/testing/vsock/vsock_perf.c | 80 ++++++++++++++++++++++++++++----
> 1 file changed, 71 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


