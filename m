Return-Path: <netdev+bounces-21569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFDF763EA9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F1281F18
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826C7E1;
	Wed, 26 Jul 2023 18:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7E4CE65
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:38:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA111BCD
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690396701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
	b=Gd1WVwQbaN/VGn50S/B57tCUBRD3wgT4YRlyX2pY8dXA4gtvXw37RKFWiWvumHSEIKXmUx
	JkG+Hjd+4MIqF5bV0mS9pixOGOR5oQyIVJsmfudOC83xV8U6ZwGXmW4EffoIB84SSitr5p
	g+RwXqycY49xAKfB63CmmswfrCg72q4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-uI7kZzU5OEOmHUzUrLpEKA-1; Wed, 26 Jul 2023 14:38:17 -0400
X-MC-Unique: uI7kZzU5OEOmHUzUrLpEKA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe0d910b02so94535e87.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396696; x=1691001496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZkfxuuQUI6WS1OsCy4f4xk/TS/NLkS7ZKlAlhCGBD4=;
        b=dej2RetQdQWEfYX/ldAXK+9WTS8RQRECrvR3R6E7eDeYmlm26TpdF9VtzYFaGZNWYd
         F2KeqzbdglHvqunC/eYGK0E+oUJm9+O+NSDS7YQ00JMI6mclvO9GTWYppnp3JDHSx87R
         3ioDvIO1adWNCJMN/3q8RYidkG9aBIjjb22SWIhj3is08GPyjqpoZdTPRkfiD8AccaCP
         4CQRQVvpWxbqjaqtl6FwpxLAz2S4LdlLZdpSE0Ln0E4NWtDcc2ZW26GsrYgC265rMRnE
         aga/P7jAcOXrvT19VSZ8Orx42kpb9Iqs3Xj4EMACe7mrZGdDErtSo27FWiRek0WfWhev
         WQ9Q==
X-Gm-Message-State: ABy/qLbgVJqJQ8Qt9A45Gbzz3F7KE4lHA59nEjZHveljWgY8W05EpmD6
	W/4sN8Z46CApUGKrIIpbNx0pXVQWgxLsGvNOTLyzkT12MFuPwxEPu/ccM+VVVUzdOLWx+LWAEhv
	FWjJeYgtConnBclOZ
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id q10-20020a05651232aa00b004fe0d9e0a47mr2160166lfe.69.1690396696361;
        Wed, 26 Jul 2023 11:38:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrmEcx/kJue2Mk0wlq5n2w2uLYFHBteYJyc3Ij9fkV7DF4dbhcJqImI+mNTHeim2phb5ANfA==
X-Received: by 2002:a05:6512:32aa:b0:4fe:d9e:a47 with SMTP id q10-20020a05651232aa00b004fe0d9e0a47mr2160137lfe.69.1690396695997;
        Wed, 26 Jul 2023 11:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906380200b0099b6becb107sm8669173ejc.95.2023.07.26.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:38:14 -0700 (PDT)
Date: Wed, 26 Jul 2023 14:38:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org, Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230726143736-mutt-send-email-mst@kernel.org>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
 <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:50:14AM +0000, Bobby Eshleman wrote:
> This commit adds a feature bit for virtio vsock to support datagrams.
> 
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  include/uapi/linux/virtio_vsock.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 331be28b1d30..27b4b2b8bf13 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -40,6 +40,7 @@
>  
>  /* The feature bitmap for virtio vsock */
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
> +#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
>  
>  struct virtio_vsock_config {
>  	__le64 guest_cid;

pls do not add interface without first getting it accepted in the
virtio spec.

> -- 
> 2.30.2


