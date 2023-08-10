Return-Path: <netdev+bounces-26223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF677734E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E301C21154
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF641D311;
	Thu, 10 Aug 2023 08:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC83C3C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:49:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3592103
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691657392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
	b=a1511v8SNLPuL58gWvumAvDQwwKjEPfC0mRgaj2ZEbSXSr72N4+rF781G4nYNcRdy+iYxK
	FDzIPUuTS5jVp1NT+MWJnMV+VdVBAzy06F7hwSTpxEoaSLW0K9ID0YMCGalJWGi049VMIe
	LOWoslnha94Gebw6XCRsEUm5kGkKl+A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-spNA8H6GPi6CLzpTQPT91g-1; Thu, 10 Aug 2023 04:49:50 -0400
X-MC-Unique: spNA8H6GPi6CLzpTQPT91g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe1bef4223so4204205e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657389; x=1692262189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr5wgmKh2lO7n8excjkJqlp64FQQtsDJMCPcsqi5jJ4=;
        b=Rlce7AE48KnjBKHTNDoe5vXAEhQ3WtDkFT6kfIcucTup5dxdJg/JkaDAcHAiZRgdsk
         KJ69brGIv7WP1gweUsZmF7VGdqkwQy9yktIBRK98G3jICgcjWZSsG9Sjfr8Tqdkfe4Vs
         diLQuentwt3KeijOpDmPs9AuFNSwe5CrlEXj4FiEnxMexcTlxmBgeshvRzdtcQwOeArq
         nUPxV8yCUBaWwG0Mo/siNcd5DD8Q/tTQxqAC3AKFEwGEHtsKwvc+lFVNcPSiMOfrPtUF
         xouaoiiR5ZK0A5Tcv261TGn2AbsG0y3jSS9pFsAiShCSvfQNUh+xvVZ63TI8gGia7ebt
         STng==
X-Gm-Message-State: AOJu0YwPVfvf342uPWQilFcEVFhmYZUFL/IUepZedRhFc5CWyNnlYXed
	ea5ZxIwQHpm0wLIopDUJ7ZVikk10PFqwPT88bjCEh1LX/a+u8StwHv8sEj9JxsrXwYT2BTtfm4A
	6M/m/pUAyBhAXiQ/r
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id x19-20020a05600c2a5300b003fa96db7b7cmr1355745wme.35.1691657389737;
        Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9G1uTIpyiFvUarklkAwC6rr28NspOp66gkgdxQBV3p3OYye0b+YHH4y0QncONpY4KIjuasg==
X-Received: by 2002:a05:600c:2a53:b0:3fa:96db:7b7c with SMTP id x19-20020a05600c2a5300b003fa96db7b7cmr1355731wme.35.1691657389380;
        Thu, 10 Aug 2023 01:49:49 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fbb0c01d4bsm1439523wmi.16.2023.08.10.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:49:48 -0700 (PDT)
Date: Thu, 10 Aug 2023 04:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	eperezma@redhat.com, 18801353760@163.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Message-ID: <20230810044935-mutt-send-email-mst@kernel.org>
References: <20230810031557.135557-1-yin31149@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:15:57AM +0800, Hawkins Jiawei wrote:
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
> 
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> 
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
> 
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> 
> TestStep
> ========
> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
> feature on, command line like:
>       -netdev tap,vhost=off,...
>       -device virtio-net-pci,mq=on,hash=on,...
> 
> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
> line like:
> 	ethtool -K eth0 rxhash on
> 
> Without this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 1 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 1,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
> With this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 0 in gdb like below:
> 
> 	pwndbg> p vi->ctrl->rss
> 	$1 = {
> 	  hash_types = 63,
> 	  indirection_table_mask = 0,
> 	  unclassified_queue = 0,
> 	  indirection_table = {0 <repeats 128 times>},
> 	  max_tx_vq = 0,
> 	  hash_key_length = 40 '(',
> 	  ...
> 	}
> 
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes tag pls?

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>  		vi->ctrl->rss.indirection_table[i] = indir_val;
>  	}
>  
> -	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
> +	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
>  	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
>  
>  	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> -- 
> 2.34.1


