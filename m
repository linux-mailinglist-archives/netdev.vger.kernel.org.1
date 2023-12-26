Return-Path: <netdev+bounces-60254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C423A81E61D
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 10:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3709B21D5E
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D14CE11;
	Tue, 26 Dec 2023 09:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466734CE12
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VzHBP8l_1703581317;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzHBP8l_1703581317)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 17:01:58 +0800
Message-ID: <1703581225.0317998-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/6] virtio_net: introduce device stats feature and structures
Date: Tue, 26 Dec 2023 17:00:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
 <20231222033021.20649-2-xuanzhuo@linux.alibaba.com>
 <f6cea3db-aef6-43a9-96a9-04fe42e6a1f3@linux.dev>
 <1703571463.67622-2-xuanzhuo@linux.alibaba.com>
 <20231226035811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231226035811-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 26 Dec 2023 03:58:37 -0500, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Tue, Dec 26, 2023 at 02:17:43PM +0800, Xuan Zhuo wrote:
> > On Mon, 25 Dec 2023 16:01:39 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> > > =E5=9C=A8 2023/12/22 11:30, Xuan Zhuo =E5=86=99=E9=81=93:
> > > > The virtio-net device stats spec:
> > > >
> > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f=
95bbbd243291ab0064f82
> > > >
> > > > This commit introduces the relative feature and structures.
> > >
> > > Hi, Xuan
> > >
> > > After applying this patch series, withe ethtool version 6.5,
> > > I got the following NIC statistics. But I do not find the statistics
> > > mentioned in this patch series.
> > > Do I miss something?
> >
> > This needs the new virtio-net feature VIRTIO_NET_F_DEVICE_STATS.
> > You need to update the hypervisor. But the qemu may not support this.
> >
> > Thanks.
>
> Why not? Can you add this to QEMU?


Yes. It is in my list.

But in my plan, I want the kernel to support this firstly.

Thanks.


>
>
> >
> >
> > >
> > > "
> > > NIC statistics:
> > >       rx_packets: 3434812669
> > >       rx_bytes: 5168475253690
> > >       rx_drops: 0
> > >       rx_xdp_packets: 0
> > >       rx_xdp_tx: 0
> > >       rx_xdp_redirects: 0
> > >       rx_xdp_drops: 0
> > >       rx_kicks: 57179891
> > >       tx_packets: 187694230
> > >       tx_bytes: 12423799040
> > >       tx_xdp_tx: 0
> > >       tx_xdp_tx_drops: 0
> > >       tx_kicks: 187694230
> > >       tx_timeouts: 0
> > >       rx_queue_0_packets: 866027381
> > >       rx_queue_0_bytes: 1302726908150
> > >       rx_queue_0_drops: 0
> > >       rx_queue_0_xdp_packets: 0
> > >       rx_queue_0_xdp_tx: 0
> > >       rx_queue_0_xdp_redirects: 0
> > >       rx_queue_0_xdp_drops: 0
> > >       rx_queue_0_kicks: 14567691
> > >       rx_queue_1_packets: 856758801
> > >       rx_queue_1_bytes: 1289899049042
> > >       rx_queue_1_drops: 0
> > >       rx_queue_1_xdp_packets: 0
> > >       rx_queue_1_xdp_tx: 0
> > >       rx_queue_1_xdp_redirects: 0
> > >       rx_queue_1_xdp_drops: 0
> > >       rx_queue_1_kicks: 14265201
> > >       rx_queue_2_packets: 839291053
> > >       rx_queue_2_bytes: 1261620863886
> > >       rx_queue_2_drops: 0
> > >       rx_queue_2_xdp_packets: 0
> > >       rx_queue_2_xdp_tx: 0
> > >       rx_queue_2_xdp_redirects: 0
> > >       rx_queue_2_xdp_drops: 0
> > >       rx_queue_2_kicks: 13857653
> > >       rx_queue_3_packets: 872735434
> > >       rx_queue_3_bytes: 1314228432612
> > >       rx_queue_3_drops: 0
> > >       rx_queue_3_xdp_packets: 0
> > >       rx_queue_3_xdp_tx: 0
> > >       rx_queue_3_xdp_redirects: 0
> > >       rx_queue_3_xdp_drops: 0
> > >       rx_queue_3_kicks: 14489346
> > >       tx_queue_0_packets: 75723
> > >       tx_queue_0_bytes: 4999030
> > >       tx_queue_0_xdp_tx: 0
> > >       tx_queue_0_xdp_tx_drops: 0
> > >       tx_queue_0_kicks: 75723
> > >       tx_queue_0_timeouts: 0
> > >       tx_queue_1_packets: 62262921
> > >       tx_queue_1_bytes: 4134803914
> > >       tx_queue_1_xdp_tx: 0
> > >       tx_queue_1_xdp_tx_drops: 0
> > >       tx_queue_1_kicks: 62262921
> > >       tx_queue_1_timeouts: 0
> > >       tx_queue_2_packets: 83
> > >       tx_queue_2_bytes: 5478
> > >       tx_queue_2_xdp_tx: 0
> > >       tx_queue_2_xdp_tx_drops: 0
> > >       tx_queue_2_kicks: 83
> > >       tx_queue_2_timeouts: 0
> > >       tx_queue_3_packets: 125355503
> > >       tx_queue_3_bytes: 8283990618
> > >       tx_queue_3_xdp_tx: 0
> > >       tx_queue_3_xdp_tx_drops: 0
> > >       tx_queue_3_kicks: 125355503
> > >       tx_queue_3_timeouts: 0
> > > "
> > >
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >   include/uapi/linux/virtio_net.h | 137 +++++++++++++++++++++++++++=
+++++
> > > >   1 file changed, 137 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/v=
irtio_net.h
> > > > index cc65ef0f3c3e..129e0871d28f 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -56,6 +56,7 @@
> > > >   #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
> > > >   					 * Steering */
> > > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > > > +#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-=
level statistics. */
> > > >   #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue=
 notification coalescing */
> > > >   #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notification=
s coalescing */
> > > >   #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. =
*/
> > > > @@ -406,4 +407,140 @@ struct  virtio_net_ctrl_coal_vq {
> > > >   	struct virtio_net_ctrl_coal coal;
> > > >   };
> > > >
> > > > +/*
> > > > + * Device Statistics
> > > > + */
> > > > +#define VIRTIO_NET_CTRL_STATS         8
> > > > +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> > > > +#define VIRTIO_NET_CTRL_STATS_GET     1
> > > > +
> > > > +struct virtio_net_stats_capabilities {
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_CVQ       (1L << 32)
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1 << 0)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1 << 1)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1 << 2)
> > > > +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1 << 3)
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1 << 16)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1 << 17)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1 << 18)
> > > > +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1 << 19)
> > > > +
> > > > +	__le64 supported_stats_types[1];
> > > > +};
> > > > +
> > > > +struct virtio_net_ctrl_queue_stats {
> > > > +	struct {
> > > > +		__le16 vq_index;
> > > > +		__le16 reserved[3];
> > > > +		__le64 types_bitmap[1];
> > > > +	} stats[1];
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_reply_hdr {
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
> > > > +
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
> > > > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
> > > > +	u8 type;
> > > > +	u8 reserved;
> > > > +	__le16 vq_index;
> > > > +	__le16 reserved1;
> > > > +	__le16 size;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_cvq {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 command_num;
> > > > +	__le64 ok_num;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_basic {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 rx_notifications;
> > > > +
> > > > +	__le64 rx_packets;
> > > > +	__le64 rx_bytes;
> > > > +
> > > > +	__le64 rx_interrupts;
> > > > +
> > > > +	__le64 rx_drops;
> > > > +	__le64 rx_drop_overruns;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_basic {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 tx_notifications;
> > > > +
> > > > +	__le64 tx_packets;
> > > > +	__le64 tx_bytes;
> > > > +
> > > > +	__le64 tx_interrupts;
> > > > +
> > > > +	__le64 tx_drops;
> > > > +	__le64 tx_drop_malformed;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_csum {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 rx_csum_valid;
> > > > +	__le64 rx_needs_csum;
> > > > +	__le64 rx_csum_none;
> > > > +	__le64 rx_csum_bad;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_csum {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 tx_csum_none;
> > > > +	__le64 tx_needs_csum;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_gso {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 rx_gso_packets;
> > > > +	__le64 rx_gso_bytes;
> > > > +	__le64 rx_gso_packets_coalesced;
> > > > +	__le64 rx_gso_bytes_coalesced;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_gso {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 tx_gso_packets;
> > > > +	__le64 tx_gso_bytes;
> > > > +	__le64 tx_gso_segments;
> > > > +	__le64 tx_gso_segments_bytes;
> > > > +	__le64 tx_gso_packets_noseg;
> > > > +	__le64 tx_gso_bytes_noseg;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_rx_speed {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 rx_packets_allowance_exceeded;
> > > > +	__le64 rx_bytes_allowance_exceeded;
> > > > +};
> > > > +
> > > > +struct virtio_net_stats_tx_speed {
> > > > +	struct virtio_net_stats_reply_hdr hdr;
> > > > +
> > > > +	__le64 tx_packets_allowance_exceeded;
> > > > +	__le64 tx_bytes_allowance_exceeded;
> > > > +};
> > > > +
> > > >   #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> > >
>
>

