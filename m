Return-Path: <netdev+bounces-45532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF87DDFAC
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEDF2812D6
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC07C79E3;
	Wed,  1 Nov 2023 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuZA4VTz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7223DC
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 10:44:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B61A3
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698835463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM+KVWhTEC+q6McYK/U8CnEcwO0FYAak05UnunuNB8s=;
	b=IuZA4VTzAHfPOWmxWdc8Vy4u/6orP2x3Y5C8dPUeJ3ZoNCUbmS4bLCh5Ft+vuqxW3CyF/Y
	tZh4JqSlOEhqahqaHKpDOIm5wPPOxjfB7L6CdYl9MTy/s55tEz31Q42ZBL/b/KYt7EhIlH
	MVRg5mrK0Ug3YZNeqw0QYmlh266RM0I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-5rZtQsR3Ph-KEvEJ9Ei5oQ-1; Wed, 01 Nov 2023 06:44:22 -0400
X-MC-Unique: 5rZtQsR3Ph-KEvEJ9Ei5oQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b2cf504e3aso464962966b.2
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 03:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698835461; x=1699440261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM+KVWhTEC+q6McYK/U8CnEcwO0FYAak05UnunuNB8s=;
        b=Bqh7eOHAJWsVxyUUbFubhHUscnxh86MNmgA0Lg4Sh23EHtd9jypg1zM3wc35FIR5iG
         ow+tiOcK6WVksFecEODZxVFqYtQQR0FYK36TrMNilVl+THc7RDR3Aw36Oru/o4TFSNZO
         pCtoiHDyIw1nLLxhKDeVr0E9CY205nfDugTYHgU9q8fyY1mk//fTst8WfhZ08GL9mapa
         R3proVEljrzj0F6wTMhPK+PLtHI6v6E2nSSy+d7dtjFTI7VmXAEommhiqmGSzdUa2OB1
         gJL2IdSDOZkOMIHYj4reqpOFgtPMccOVRh+uKF09UevB2eK4AuisoYSf5GVwDhHsh+1C
         1/+g==
X-Gm-Message-State: AOJu0Yx1g2R9+TOVmn+7hOvClPsLMeC34MMdgnJdw5fbtNNpEx4STcuQ
	fE9bnQ7jUy/4rlHl85bKa9hJxbpwE0+DeHNgAfADn0IV7HeCaN8k/Lur7gbga73MVcBs8zYo8ST
	TKynIBX+iD4xharml
X-Received: by 2002:a50:d603:0:b0:53e:4762:9373 with SMTP id x3-20020a50d603000000b0053e47629373mr12119357edi.18.1698835460847;
        Wed, 01 Nov 2023 03:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJ18E3fuGGGw1XNgF2qYD2m7aCnyPEpflL1I2fxO2j1Rbq+/UI47tJgllwGtn9ne4qZUYIw==
X-Received: by 2002:a50:d603:0:b0:53e:4762:9373 with SMTP id x3-20020a50d603000000b0053e47629373mr12119342edi.18.1698835460477;
        Wed, 01 Nov 2023 03:44:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
        by smtp.gmail.com with ESMTPSA id x17-20020a05640226d100b00542da55a716sm884668edd.90.2023.11.01.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 03:44:19 -0700 (PDT)
Date: Wed, 1 Nov 2023 06:44:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
Message-ID: <20231101064348-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <20231025014821-mutt-send-email-mst@kernel.org>
 <707be7fa-3bb7-46c5-bb34-ef2900fe473f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <707be7fa-3bb7-46c5-bb34-ef2900fe473f@linux.alibaba.com>

On Wed, Nov 01, 2023 at 05:40:30PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/10/25 下午1:49, Michael S. Tsirkin 写道:
> > On Thu, Oct 12, 2023 at 03:44:04PM +0800, Heng Qi wrote:
> > > Now, virtio-net already supports per-queue moderation parameter
> > > setting. Based on this, we use the netdim library of linux to support
> > > dynamic coalescing moderation for virtio-net.
> > > 
> > > Due to hardware scheduling issues, we only tested rx dim.
> > So patches 1 to 4 look ok but patch 5 is untested - we should
> > probably wait until it's tested properly.
> 
> Hi, Michael.
> 
> For a few reasons (reply to Jason's thread), I won't be trying to push tx
> dim any more in the short term.
> 
> Please review the remaining patches.
> 
> Thanks a lot!


You got a bunch of comments from Jason - want to address them
in a new version then, and I'll review that?

> > 
> > 
> > > @Test env
> > > rxq0 has affinity to cpu0.
> > > 
> > > @Test cmd
> > > client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
> > > server: taskset -c 0 sockperf sr --tcp
> > > 
> > > @Test res
> > > The second column is the ratio of the result returned by client
> > > when rx dim is enabled to the result returned by client when
> > > rx dim is disabled.
> > > 	--------------------------------------
> > > 	| msg_size |  rx_dim=on / rx_dim=off |
> > > 	--------------------------------------
> > > 	|   14B    |         + 3%            |
> > > 	--------------------------------------
> > > 	|   100B   |         + 16%           |
> > > 	--------------------------------------
> > > 	|   500B   |         + 25%           |
> > > 	--------------------------------------
> > > 	|   1400B  |         + 28%           |
> > > 	--------------------------------------
> > > 	|   2048B  |         + 22%           |
> > > 	--------------------------------------
> > > 	|   4096B  |         + 5%            |
> > > 	--------------------------------------
> > > 
> > > ---
> > > This patch set was part of the previous netdim patch set[1].
> > > [1] was split into a merged bugfix set[2] and the current set.
> > > The previous relevant commentators have been Cced.
> > > 
> > > [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
> > > [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
> > > 
> > > Heng Qi (5):
> > >    virtio-net: returns whether napi is complete
> > >    virtio-net: separate rx/tx coalescing moderation cmds
> > >    virtio-net: extract virtqueue coalescig cmd for reuse
> > >    virtio-net: support rx netdim
> > >    virtio-net: support tx netdim
> > > 
> > >   drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
> > >   1 file changed, 322 insertions(+), 72 deletions(-)
> > > 
> > > -- 
> > > 2.19.1.6.gb485710b


