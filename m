Return-Path: <netdev+bounces-34573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED87A4BE7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224701C20E23
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A161D6A0;
	Mon, 18 Sep 2023 15:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237451CF9A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7512A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695050425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcTISZgyQz7Bvk45tsdOeOYi0IZTcEbOF6L8io0wv6s=;
	b=cp2Mz3U24Ggcuo9FNS9C3MJiMzIwDFP/K+wN9PzWveuI5Hem808RtgQKlLRdcnk7jIN0IJ
	oQJg/+v+YVz01P7+HCZ+DZMoNFBJyMMfWz2ynXll0M024iFuv5bUMpEUrb6B3Xy4dx805r
	H1d/TVR9z4idxJhM4/6Jr3d6iDCo1MY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-6VYCMr79NBu8NNKyWWlIXg-1; Mon, 18 Sep 2023 10:50:10 -0400
X-MC-Unique: 6VYCMr79NBu8NNKyWWlIXg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32153a4533eso589581f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695048610; x=1695653410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcTISZgyQz7Bvk45tsdOeOYi0IZTcEbOF6L8io0wv6s=;
        b=aGLkbbb7knR7w3+z/ck/M0Pzf5tTTOEaKRihTtr6Jk6Sg4tatx9Q98y0AQsHdH37gk
         5lnlzZWA1OysF/clmeYWBze5Mhwg73CPL4J/Oiz58zlre1vpuoBA8V66zvBlpXNBMjut
         NR5ziWH6XGB53d7IRaY4AQafCnY52JqL+/sXhCf3C/nw700HqE74XtKyKhv12eKnMoff
         3Gbt9MFpdXLyElriwlTyKZLeLwabSX3/2TJi5f2dB2ul0Q7HBF7C66BSo1BbWw65qj/I
         x/4nJdscDKSidvmOkx8CvPYraRkQQ/zmDvjEpK/aGYl+xZnnmsgBUfT+H8VpD+FOIJQt
         Yo5A==
X-Gm-Message-State: AOJu0YxrzJS4pgv0y+8xMusfeetAjxT+XVdyWnoCJKNLgeODNCqNuaeZ
	VDDSW0OHs4Ea17QyTu90IVAex3E9Lgmtk4r3EqSIlpNVbD1VcI0alJznr/WLTlKstVW/atSQ4ip
	7YtBsjmPFnaOJ4Fl9
X-Received: by 2002:a5d:4941:0:b0:319:72f8:7249 with SMTP id r1-20020a5d4941000000b0031972f87249mr7183139wrs.66.1695048609814;
        Mon, 18 Sep 2023 07:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMpvQ2Hg0cP8tmtAOT3D6mlDBNWBlCvpd7g68aXHEpraHiZGH8Wu30Hj0RA2msYaZmefhIrA==
X-Received: by 2002:a5d:4941:0:b0:319:72f8:7249 with SMTP id r1-20020a5d4941000000b0031972f87249mr7183112wrs.66.1695048609417;
        Mon, 18 Sep 2023 07:50:09 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.42.69])
        by smtp.gmail.com with ESMTPSA id m6-20020adfe946000000b0031980783d78sm12772049wrn.54.2023.09.18.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:50:08 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:50:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <fwv4zdqjfhtwqookpvqqlckoqnxgyiinzhs5mq5pevl7ucefrt@hgd67phghec6>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <20230916130918.4105122-5-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230916130918.4105122-5-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 04:09:18PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ZEROCOPY flag on transmission path:
>
>1) If this flag is set and zerocopy transmission is possible (enabled
>   in socket options and transport allows zerocopy), then non-linear
>   skb will be created and filled with the pages of user's buffer.
>   Pages of user's buffer are locked in memory by 'get_user_pages()'.
>2) Replaces way of skb owning: instead of 'skb_set_owner_sk_safe()' it
>   calls 'skb_set_owner_w()'. Reason of this change is that
>   '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc' of socket, so
>   to decrease this field correctly, proper skb destructor is needed:
>   'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>3) Adds new callback to 'struct virtio_transport': 'can_msgzerocopy'.
>   If this callback is set, then transport needs extra check to be able
>   to send provided number of buffers in zerocopy mode. Currently, the
>   only transport that needs this callback set is virtio, because this
>   transport adds new buffers to the virtio queue and we need to check,
>   that number of these buffers is less than size of the queue (it is
>   required by virtio spec). vhost and loopback transports don't need
>   this check.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Refactorings of 'if' conditions.
>  * Remove extra blank line.
>  * Remove 'frag_off' field unneeded init.
>  * Add function 'virtio_transport_fill_skb()' which fills both linear
>    and non-linear skb with provided data.
> v1 -> v2:
>  * Use original order of last four arguments in 'virtio_transport_alloc_skb()'.
> v2 -> v3:
>  * Add new transport callback: 'msgzerocopy_check_iov'. It checks that
>    provided 'iov_iter' with data could be sent in a zerocopy mode.
>    If this callback is not set in transport - transport allows to send
>    any 'iov_iter' in zerocopy mode. Otherwise - if callback returns 'true'
>    then zerocopy is allowed. Reason of this callback is that in case of
>    G2H transmission we insert whole skb to the tx virtio queue and such
>    skb must fit to the size of the virtio queue to be sent in a single
>    iteration (may be tx logic in 'virtio_transport.c' could be reworked
>    as in vhost to support partial send of current skb). This callback
>    will be enabled only for G2H path. For details pls see comment
>    'Check that tx queue...' below.
> v3 -> v4:
>  * 'msgzerocopy_check_iov' moved from 'struct vsock_transport' to
>    'struct virtio_transport' as it is virtio specific callback and
>    never needed in other transports.
> v4 -> v5:
>  * 'msgzerocopy_check_iov' renamed to 'can_msgzerocopy' and now it
>    uses number of buffers to send as input argument. I think there is
>    no need to pass iov to this callback (at least today, it is used only
>    by guest side of virtio transport), because the only thing that this
>    callback does is comparison of number of buffers to be inserted to
>    the tx queue and size of this queue.
>  * Remove any checks for type of current 'iov_iter' with payload (is it
>    'iovec' or 'ubuf'). These checks left from the earlier versions where I
>    didn't use already implemented kernel API which handles every type of
>    'iov_iter'.
> v5 -> v6:
>  * Refactor 'virtio_transport_fill_skb()'.
>  * Add 'WARN_ON_ONCE()' and comment on invalid combination of destination
>    socket and payload in 'virtio_transport_alloc_skb()'.
> v7 -> v8:
>  * Move '+1' addition from 'can_msgzerocopy' callback body to the caller.
>    This addition means packet header.
>  * In 'virtio_transport_can_zcopy()' rename 'max_to_send' argument to
>    'pkt_len'.
>  * Update commit message by adding details about new 'can_msgzerocopy'
>    callback.
>  * In 'virtio_transport_init_hdr()' move 'len' argument directly after
>    'info'.
>  * Add comment about processing last skb in tx loop.
>  * Update comment for 'can_msgzerocopy' callback for more details.
> v8 -> v9:
>  * Return and update comment for 'virtio_transport_alloc_skb()'.
>  * Pass pointer to transport ops to 'virtio_transport_can_zcopy()',
>    this allows to use it directly without calling virtio_transport_get_ops()'.
>  * Remove redundant call for 'msg_data_left()' in 'virtio_transport_fill_skb()'.
>  * Do not pass 'struct vsock_sock*' to 'virtio_transport_alloc_skb()',
>    use same pointer from already passed 'struct virtio_vsock_pkt_info*'.
>  * Fix setting 'end of message' bit for SOCK_SEQPACKET (add call for
>    'msg_data_left()' == 0).
>  * Add 'zcopy' parameter to packet allocation trace event.

Thanks for addressing the comments!
>
> include/linux/virtio_vsock.h                  |   9 +
> .../events/vsock_virtio_transport_common.h    |  12 +-
> net/vmw_vsock/virtio_transport.c              |  32 +++
> net/vmw_vsock/virtio_transport_common.c       | 250 ++++++++++++++----
> 4 files changed, 241 insertions(+), 62 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


