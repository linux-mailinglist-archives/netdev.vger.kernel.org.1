Return-Path: <netdev+bounces-60421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851EC81F227
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA54D1C2086F
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E8F482E1;
	Wed, 27 Dec 2023 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWYTyJkl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAC47F7B
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703711135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF/S+D5K01/bqRcx6g+CGCAqZJH/3JLjaO7ntZsv0rQ=;
	b=aWYTyJkl0ptsjyN9yAGkKHAF9EaJVdQ7nqobmHGIx/CaLUHqX+a50MjgXMtEhhJ3H2vJXM
	1ZEyKZxwPuyu0yxTk0lfub7KITOK3Lm5pq0ab3eLDs+p+h5kRXMhbjDgPQ5SeEdXEolOQ8
	hkgw2HuafEQnX+iyEBiuVCygdYIQzu0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-yWMeww1GNwaNcaVl5VMMZg-1; Wed, 27 Dec 2023 16:05:33 -0500
X-MC-Unique: yWMeww1GNwaNcaVl5VMMZg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d410cccfc2so19057765ad.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 13:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703711132; x=1704315932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF/S+D5K01/bqRcx6g+CGCAqZJH/3JLjaO7ntZsv0rQ=;
        b=SIUevwGE4MK662cbwc3DA0vOyQfGBE5+PLvaDNM4K4D0dcd3GTo9p6kfnnh6CuPRhJ
         DWyK0kEcAmtELBl3It91lmG6cLZOU7lWHoqLXCU+3FHzW6tBO3v4lfHGkckdjHBgVnd6
         HajtFAijsSCK1JUdHK85AwuYugUVbOWd+bLQAK2iC0iPtg/aIuivtrKNl/ygDuemCYjv
         qJUzUpElGvtKEoWH6IObLEG+DPl8nDsluKm8BJKzhc8B5DLn3rm9NvH6ITusvw0xBkO+
         wTIclkFTeR7uTRkqoZIilpgqD0vIdJVcumAuEZIEJ4rQ9/JQ3LzOywLMauIoKg8AvtPs
         ie/g==
X-Gm-Message-State: AOJu0YwrN+vYgLMxA7Pvh4OxTHo7pWKRE9cRsyVKYmA1fGUen0t6NjRv
	c34vU/vTj4/y59s+xxpB7GMaIP6RfVTKjIouYIenU8f9KoalHnGZFk7WL+ixcQAUj1ifZ2god0R
	38oeZPTmCAgXFfytfrP+zkU5h
X-Received: by 2002:a17:902:e5cc:b0:1d4:4e13:6b59 with SMTP id u12-20020a170902e5cc00b001d44e136b59mr2801495plf.45.1703711132729;
        Wed, 27 Dec 2023 13:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERyBVbQGfwp3S7sHZkjIOwzr0EqFlOXxWRhePvz66CMXVtnb/wHCrefB1KgiXOr58zLoXp2Q==
X-Received: by 2002:a17:902:e5cc:b0:1d4:4e13:6b59 with SMTP id u12-20020a170902e5cc00b001d44e136b59mr2801485plf.45.1703711132361;
        Wed, 27 Dec 2023 13:05:32 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001d3a9676973sm12431159plb.111.2023.12.27.13.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 13:05:31 -0800 (PST)
Date: Wed, 27 Dec 2023 16:05:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH net-next v1 1/6] virtio_net: introduce device stats
 feature and structures
Message-ID: <20231227160338-mutt-send-email-mst@kernel.org>
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
 <20231226073103.116153-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226073103.116153-2-xuanzhuo@linux.alibaba.com>

On Tue, Dec 26, 2023 at 03:30:58PM +0800, Xuan Zhuo wrote:
> The virtio-net device stats spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> This commit introduces the relative feature and structures.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/uapi/linux/virtio_net.h | 137 ++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index cc65ef0f3c3e..8fca4d1b7635 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>  #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> @@ -406,4 +407,140 @@ struct  virtio_net_ctrl_coal_vq {
>  	struct virtio_net_ctrl_coal coal;
>  };
>  
> +/*
> + * Device Statistics
> + */
> +#define VIRTIO_NET_CTRL_STATS         8
> +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> +#define VIRTIO_NET_CTRL_STATS_GET     1
> +
> +struct virtio_net_stats_capabilities {
> +
> +#define VIRTIO_NET_STATS_TYPE_CVQ       (1ULL << 32)
> +
> +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1ULL << 0)
> +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1ULL << 1)
> +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1ULL << 2)
> +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1ULL << 3)
> +
> +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1ULL << 16)
> +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1ULL << 17)
> +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1ULL << 18)
> +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1ULL << 19)
> +
> +	__le64 supported_stats_types[1];
> +};
> +
> +struct virtio_net_ctrl_queue_stats {
> +	struct {
> +		__le16 vq_index;
> +		__le16 reserved[3];
> +		__le64 types_bitmap[1];
> +	} stats[1];
> +};
> +
> +struct virtio_net_stats_reply_hdr {
> +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
> +
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
> +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
> +
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
> +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
> +	__u8 type;
> +	__u8 reserved;
> +	__le16 vq_index;
> +	__le16 reserved1;
> +	__le16 size;
> +};
> +
> +struct virtio_net_stats_cvq {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 command_num;
> +	__le64 ok_num;
> +};
> +
> +struct virtio_net_stats_rx_basic {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 rx_notifications;
> +
> +	__le64 rx_packets;
> +	__le64 rx_bytes;
> +
> +	__le64 rx_interrupts;
> +
> +	__le64 rx_drops;
> +	__le64 rx_drop_overruns;
> +};
> +
> +struct virtio_net_stats_tx_basic {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 tx_notifications;
> +
> +	__le64 tx_packets;
> +	__le64 tx_bytes;
> +
> +	__le64 tx_interrupts;
> +
> +	__le64 tx_drops;
> +	__le64 tx_drop_malformed;
> +};
> +
> +struct virtio_net_stats_rx_csum {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 rx_csum_valid;
> +	__le64 rx_needs_csum;
> +	__le64 rx_csum_none;
> +	__le64 rx_csum_bad;
> +};
> +
> +struct virtio_net_stats_tx_csum {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 tx_csum_none;
> +	__le64 tx_needs_csum;
> +};
> +
> +struct virtio_net_stats_rx_gso {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 rx_gso_packets;
> +	__le64 rx_gso_bytes;
> +	__le64 rx_gso_packets_coalesced;
> +	__le64 rx_gso_bytes_coalesced;
> +};
> +
> +struct virtio_net_stats_tx_gso {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 tx_gso_packets;
> +	__le64 tx_gso_bytes;
> +	__le64 tx_gso_segments;
> +	__le64 tx_gso_segments_bytes;
> +	__le64 tx_gso_packets_noseg;
> +	__le64 tx_gso_bytes_noseg;
> +};
> +
> +struct virtio_net_stats_rx_speed {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 rx_packets_allowance_exceeded;
> +	__le64 rx_bytes_allowance_exceeded;
> +};
> +
> +struct virtio_net_stats_tx_speed {
> +	struct virtio_net_stats_reply_hdr hdr;
> +
> +	__le64 tx_packets_allowance_exceeded;
> +	__le64 tx_bytes_allowance_exceeded;
> +};
> +

A ton of duplication here. E.g.  virtio_net_stats_rx_speed and
virtio_net_stats_tx_speed are exactly the same.





>  #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> -- 
> 2.32.0.3.g01195cf9f


