Return-Path: <netdev+bounces-60165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022C81DEF9
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6091F21E1A
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E61847;
	Mon, 25 Dec 2023 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uFYR3r8O"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261815AF
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6cea3db-aef6-43a9-96a9-04fe42e6a1f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703491306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27COKKbl8lKkw/RUrBiHtSV6Z6kbls3FJ3K8W2HBwPY=;
	b=uFYR3r8O4WM+TUzJTBO/7vrNkR0Illmy2D/bY3YNGjihEpeYy/nvws/mMpcNKNISmbbVgF
	b5/PO4sPVjTg4o9g5nam3O/Hl/D6mf93K31xViobtlfFQlWKJ+4HMRLAbvLQyBMbFPyuuN
	rWDj+ec5HkJRPz8VAQiGyuvGx6xA9O8=
Date: Mon, 25 Dec 2023 16:01:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/6] virtio_net: introduce device stats feature
 and structures
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
 <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/22 11:30, Xuan Zhuo 写道:
> The virtio-net device stats spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> This commit introduces the relative feature and structures.

Hi, Xuan

After applying this patch series, withe ethtool version 6.5,
I got the following NIC statistics. But I do not find the statistics 
mentioned in this patch series.
Do I miss something?

"
NIC statistics:
      rx_packets: 3434812669
      rx_bytes: 5168475253690
      rx_drops: 0
      rx_xdp_packets: 0
      rx_xdp_tx: 0
      rx_xdp_redirects: 0
      rx_xdp_drops: 0
      rx_kicks: 57179891
      tx_packets: 187694230
      tx_bytes: 12423799040
      tx_xdp_tx: 0
      tx_xdp_tx_drops: 0
      tx_kicks: 187694230
      tx_timeouts: 0
      rx_queue_0_packets: 866027381
      rx_queue_0_bytes: 1302726908150
      rx_queue_0_drops: 0
      rx_queue_0_xdp_packets: 0
      rx_queue_0_xdp_tx: 0
      rx_queue_0_xdp_redirects: 0
      rx_queue_0_xdp_drops: 0
      rx_queue_0_kicks: 14567691
      rx_queue_1_packets: 856758801
      rx_queue_1_bytes: 1289899049042
      rx_queue_1_drops: 0
      rx_queue_1_xdp_packets: 0
      rx_queue_1_xdp_tx: 0
      rx_queue_1_xdp_redirects: 0
      rx_queue_1_xdp_drops: 0
      rx_queue_1_kicks: 14265201
      rx_queue_2_packets: 839291053
      rx_queue_2_bytes: 1261620863886
      rx_queue_2_drops: 0
      rx_queue_2_xdp_packets: 0
      rx_queue_2_xdp_tx: 0
      rx_queue_2_xdp_redirects: 0
      rx_queue_2_xdp_drops: 0
      rx_queue_2_kicks: 13857653
      rx_queue_3_packets: 872735434
      rx_queue_3_bytes: 1314228432612
      rx_queue_3_drops: 0
      rx_queue_3_xdp_packets: 0
      rx_queue_3_xdp_tx: 0
      rx_queue_3_xdp_redirects: 0
      rx_queue_3_xdp_drops: 0
      rx_queue_3_kicks: 14489346
      tx_queue_0_packets: 75723
      tx_queue_0_bytes: 4999030
      tx_queue_0_xdp_tx: 0
      tx_queue_0_xdp_tx_drops: 0
      tx_queue_0_kicks: 75723
      tx_queue_0_timeouts: 0
      tx_queue_1_packets: 62262921
      tx_queue_1_bytes: 4134803914
      tx_queue_1_xdp_tx: 0
      tx_queue_1_xdp_tx_drops: 0
      tx_queue_1_kicks: 62262921
      tx_queue_1_timeouts: 0
      tx_queue_2_packets: 83
      tx_queue_2_bytes: 5478
      tx_queue_2_xdp_tx: 0
      tx_queue_2_xdp_tx_drops: 0
      tx_queue_2_kicks: 83
      tx_queue_2_timeouts: 0
      tx_queue_3_packets: 125355503
      tx_queue_3_bytes: 8283990618
      tx_queue_3_xdp_tx: 0
      tx_queue_3_xdp_tx_drops: 0
      tx_queue_3_kicks: 125355503
      tx_queue_3_timeouts: 0
"

> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   include/uapi/linux/virtio_net.h | 137 ++++++++++++++++++++++++++++++++
>   1 file changed, 137 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index cc65ef0f3c3e..129e0871d28f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
>   #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>   #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>   #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> @@ -406,4 +407,140 @@ struct  virtio_net_ctrl_coal_vq {
>   	struct virtio_net_ctrl_coal coal;
>   };
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
> +#define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
> +
> +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1 << 3)
> +
> +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 16)
> +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 17)
> +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 18)
> +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1 << 19)
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
> +	u8 type;
> +	u8 reserved;
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
>   #endif /* _UAPI_LINUX_VIRTIO_NET_H */


