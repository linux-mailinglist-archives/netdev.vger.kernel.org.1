Return-Path: <netdev+bounces-14001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23873E51B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5205C280E2F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF692C156;
	Mon, 26 Jun 2023 16:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33A125AA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 16:30:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174FD3
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687797029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
	b=X9oAWOZCz8os93rlgMj6aA7gdoQ4mc1dxhx9Nq/J0Qum04slbtjXL1KLxDYxnIyp21h9IO
	MjA4nyn87Hk2CKS4DdjPc+w9wpKK4AuqHOXwI+Cc4/Qx//2yapVnlFwdEz6wAA84J1j/Fw
	HvLadTQ8EEyQQeAcyomxH8mkmwfIw/I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-g6owQAvVPNSjjp7zx8YN4A-1; Mon, 26 Jun 2023 12:30:28 -0400
X-MC-Unique: g6owQAvVPNSjjp7zx8YN4A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6355b301c9dso19977976d6.3
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797028; x=1690389028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
        b=Muti1vClw6ymmDzjlMAGhve7axKNekAAEii+x8vqBIiMxwhf9XF9yY376UjbIM/0uZ
         dk+Kt/yeq+r3uFoKNgALMB7bTxsXJgt/WTsWgWlB2MbM8zdTNyW7s+Mc5PmWPcTg3ScP
         YGu2zXuJGL1EfJRCVi5F4q1P/eM+eLONyCfoSdzGjPOxxV5E6LosJIaiwsps/5gV4EsN
         9kKJOqUucfTG20K3WpU1Vhtr1mP/PNHMRPPOWmXPA2IsAmxJdUf8x02G/m2/zcZFAhIr
         r2p5Bm9HBC12mqJ+CFHavAkMslE0pL1WFQI8R33qhi72SAUi35zQcJZRVudiKJXRrOJK
         MUnA==
X-Gm-Message-State: AC+VfDxaW481Z6IfchAOkw+zGflrvvbctWEBPgRwBtL6PrEu2FrqadK7
	x1iXdS3+E4U8Ns8rX89YFdN7re3S8KYqAqCa/4abp+grEQusueOKNRHTFjU7WMfMkRjWntNMCZv
	2WFwAIIBIAU85IX+u
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id g5-20020a0562141cc500b0062de8a24d36mr34309504qvd.61.1687797028065;
        Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uBH00Gk/fKeQLrvD/GY47XvG7v3BCuca4UyzNoimZCXIfrb0LXztvOgJ/KifRuXdADW4Jbg==
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id g5-20020a0562141cc500b0062de8a24d36mr34309488qvd.61.1687797027844;
        Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id nd14-20020a056214420e00b006215d0bdf37sm3351810qvb.16.2023.06.26.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:30:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 0/4] virtio/vsock: some updates for MSG_PEEK flag
Message-ID: <tmcj34lrgk7rxlnp4qvkpljwovowlz3wnosqboxssv6f6enr6u@qnf422n6lu6j>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 18, 2023 at 09:24:47AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>This patchset does several things around MSG_PEEK flag support. In
>general words it reworks MSG_PEEK test and adds support for this flag
>in SOCK_SEQPACKET logic. Here is per-patch description:
>
>1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>   1) I think there is no need of "safe" mode walk here as there is no
>      "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>      queue).
>   2) Nested while loop is removed: in case of MSG_PEEK we just walk
>      over skbs and copy data from each one. I guess this nested loop
>      even didn't behave as loop - it always executed just for single
>      iteration.
>
>2) This adds MSG_PEEK support for SOCK_SEQPACKET. It could be implemented
>   be reworking MSG_PEEK callback for SOCK_STREAM to support SOCK_SEQPACKET
>   also, but I think it will be more simple and clear from potential
>   bugs to implemented it as separate function thus not mixing logics
>   for both types of socket. So I've added it as dedicated function.
>
>3) This is reworked MSG_PEEK test for SOCK_STREAM. Previous version just
>   sent single byte, then tried to read it with MSG_PEEK flag, then read
>   it in normal way. New version is more complex: now sender uses buffer
>   instead of single byte and this buffer is initialized with random
>   values. Receiver tests several things:
>   1) Read empty socket with MSG_PEEK flag.
>   2) Read part of buffer with MSG_PEEK flag.
>   3) Read whole buffer with MSG_PEEK flag, then checks that it is same
>      as buffer from 2) (limited by size of buffer from 2) of course).
>   4) Read whole buffer without any flags, then checks that is is same
>      as buffer from 3).
>
>4) This is MSG_PEEK test for SOCK_SEQPACKET. It works in the same way
>   as for SOCK_STREAM, except it also checks combination of MSG_TRUNC
>   and MSG_PEEK.
>
>Head is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d20dd0ea14072e8a90ff864b2c1603bd68920b4b

Nice cleanup, LGTM, but I'd like a comment from Bobby.

Thanks,
Stefano


