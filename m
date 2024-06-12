Return-Path: <netdev+bounces-102789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE323904A1C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 06:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC4C1C2371E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4723765;
	Wed, 12 Jun 2024 04:39:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7C22092;
	Wed, 12 Jun 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167145; cv=none; b=ErT+rhbFCtWI9IQbt9hEQQ5vrDBZdbf5WtoHwism/Z62jvsbpnXH/ZmnVrT2fhi6jBB+1eOp83IIdLBRPQoXe2mP4vQI4n2dWczdhSgnqgAYPyPHMhJImpubAZ/hgM9w4jhe7ywNVwzQMh5oN2B8psWQCa4ysJide6TeFZ34ZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167145; c=relaxed/simple;
	bh=Z5h8icvoYedo6hC0W2Y8CNHVP99oxEKoJFR4miV1V3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mR3pGYoHOxb+8Yortk2QM/tjgF2KC+6Etstd9yvuemfdepeOhGhKTqH3d/cHRWzVs71JGElnXcy43B6Do3c8NHVM/UH4hLGH28YW6q7vjVlETv/pbw7Go8eNZ0Tvhe6cwxm8Un+hcAHSTQ9GHRxMkKUXRTuEsgyh22RJNtAhglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C4ZFx34888267, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C4ZFx34888267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 12:35:15 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 12:35:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 12:35:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 12:35:13 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Hariprasad Kelam <hkelam@marvell.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHauLdmYuDGRjyaP0maBwRhxExTNLG7e7UAgAgWH6A=
Date: Wed, 12 Jun 2024 04:35:13 +0000
Message-ID: <89c92725271a4fa28dbf1e37f3fd5e99@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
 <PH0PR18MB44745E2CFEA3CC1D9ADC5AC0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB44745E2CFEA3CC1D9ADC5AC0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> > Implement .ndo_start_xmit function to fill the information of the
> > packet to be transmitted into the tx descriptor, and then the hardware
> > will transmit the packet using the information in the tx descriptor.
> > In addition, we also implemented the tx_handler function to enable the
> > tx descriptor to be reused.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 285 ++++++++++++++++++
> >  1 file changed, 285 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 23406c195cff..6bdb4edbfbc1 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union
> > rtase_rx_desc *desc, u32 rx_buf_sz)
> >                  cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));  }
> >
> > +static u32 rtase_tx_avail(struct rtase_ring *ring) {
> > +     return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> > +            READ_ONCE(ring->cur_idx); }
> > +
> > +static int tx_handler(struct rtase_ring *ring, int budget) {
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     struct net_device *dev =3D tp->dev;
> > +     u32 dirty_tx, tx_left;
> > +     u32 bytes_compl =3D 0;
> > +     u32 pkts_compl =3D 0;
> > +     int workdone =3D 0;
> > +
> > +     dirty_tx =3D ring->dirty_idx;
> > +     tx_left =3D READ_ONCE(ring->cur_idx) - dirty_tx;
> > +
> > +     while (tx_left > 0) {
> > +             u32 entry =3D dirty_tx % RTASE_NUM_DESC;
> > +             struct rtase_tx_desc *desc =3D ring->desc +
> > +                                    sizeof(struct rtase_tx_desc) *
> entry;
> > +             u32 status;
> > +
> > +             status =3D le32_to_cpu(desc->opts1);
> > +
> > +             if (status & RTASE_DESC_OWN)
> > +                     break;
> > +
> > +             rtase_unmap_tx_skb(tp->pdev, ring->mis.len[entry], desc);
> > +             ring->mis.len[entry] =3D 0;
> > +             if (ring->skbuff[entry]) {
> > +                     pkts_compl++;
> > +                     bytes_compl +=3D ring->skbuff[entry]->len;
> > +                     napi_consume_skb(ring->skbuff[entry], budget);
> > +                     ring->skbuff[entry] =3D NULL;
> > +             }
> > +
> > +             dirty_tx++;
> > +             tx_left--;
> > +             workdone++;
> > +
> > +             if (workdone =3D=3D RTASE_TX_BUDGET_DEFAULT)
> > +                     break;
> > +     }
> > +
> > +     if (ring->dirty_idx !=3D dirty_tx) {
> > +             dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
> > +             WRITE_ONCE(ring->dirty_idx, dirty_tx);
> > +
> > +             netif_subqueue_completed_wake(dev, ring->index,
> > pkts_compl,
> > +                                           bytes_compl,
> > +                                           rtase_tx_avail(ring),
> > +
> RTASE_TX_START_THRS);
> > +
> > +             if (ring->cur_idx !=3D dirty_tx)
> > +                     rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)  {
> >       struct rtase_ring *ring =3D &tp->tx_ring[idx]; @@ -1014,6
> > +1076,228 @@ static int rtase_close(struct net_device *dev)
> >       return 0;
> >  }
> >
> > +static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
> > +                          const struct sk_buff *skb) {
> > +     return (skb_vlan_tag_present(skb)) ?
> > +             (RTASE_TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) :
> > 0x00; }
> > +
>                Vlan protocol can be either 0x8100 or 0x88A8, how does
> hardware know which header to insert?
> Thanks,
> Hariprasad k

We only allow the hardware to add 0x8100, the VLAN must at least have
0x8100 to potentially have 0x88a8, skb_vlan_tag_present indicates that
VLAN exists, hence at least the 0x8100 VLAN would exist.
>=20
> > +static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device
> > +*dev) {
> > +     u32 csum_cmd =3D 0;
> > +     u8 ip_protocol;
> > +
> > +     switch (vlan_get_protocol(skb)) {
> > +     case htons(ETH_P_IP):
> > +             csum_cmd =3D RTASE_TX_IPCS_C;
> > +             ip_protocol =3D ip_hdr(skb)->protocol;
> > +             break;
> > +
> > +     case htons(ETH_P_IPV6):
> > +             csum_cmd =3D RTASE_TX_IPV6F_C;
> > +             ip_protocol =3D ipv6_hdr(skb)->nexthdr;
> > +             break;
> > +
> > +     default:
> > +             ip_protocol =3D IPPROTO_RAW;
> > +             break;
> > +     }
> > +
> > +     if (ip_protocol =3D=3D IPPROTO_TCP)
> > +             csum_cmd |=3D RTASE_TX_TCPCS_C;
> > +     else if (ip_protocol =3D=3D IPPROTO_UDP)
> > +             csum_cmd |=3D RTASE_TX_UDPCS_C;
> > +
> > +     csum_cmd |=3D u32_encode_bits(skb_transport_offset(skb),
> > +                                 RTASE_TCPHO_MASK);
> > +
> > +     return csum_cmd;
> > +}
> > +
> > +static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *s=
kb,
> > +                         u32 opts1, u32 opts2) {
> > +     const struct skb_shared_info *info =3D skb_shinfo(skb);
> > +     const struct rtase_private *tp =3D ring->ivec->tp;
> > +     const u8 nr_frags =3D info->nr_frags;
> > +     struct rtase_tx_desc *txd =3D NULL;
> > +     u32 cur_frag, entry;
> > +
> > +     entry =3D ring->cur_idx;
> > +     for (cur_frag =3D 0; cur_frag < nr_frags; cur_frag++) {
> > +             const skb_frag_t *frag =3D &info->frags[cur_frag];
> > +             dma_addr_t mapping;
> > +             u32 status, len;
> > +             void *addr;
> > +
> > +             entry =3D (entry + 1) % RTASE_NUM_DESC;
> > +
> > +             txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry=
;
> > +             len =3D skb_frag_size(frag);
> > +             addr =3D skb_frag_address(frag);
> > +             mapping =3D dma_map_single(&tp->pdev->dev, addr, len,
> > +                                      DMA_TO_DEVICE);
> > +
> > +             if (unlikely(dma_mapping_error(&tp->pdev->dev,
> > + mapping)))
> > {
> > +                     if (unlikely(net_ratelimit()))
> > +                             netdev_err(tp->dev,
> > +                                        "Failed to map TX
> fragments
> > DMA!\n");
> > +
> > +                     goto err_out;
> > +             }
> > +
> > +             if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > +                     status =3D (opts1 | len | RTASE_RING_END);
> > +             else
> > +                     status =3D opts1 | len;
> > +
> > +             if (cur_frag =3D=3D (nr_frags - 1)) {
> > +                     ring->skbuff[entry] =3D skb;
> > +                     status |=3D RTASE_TX_LAST_FRAG;
> > +             }
> > +
> > +             ring->mis.len[entry] =3D len;
> > +             txd->addr =3D cpu_to_le64(mapping);
> > +             txd->opts2 =3D cpu_to_le32(opts2);
> > +
> > +             /* make sure the operating fields have been updated */
> > +             dma_wmb();
> > +             txd->opts1 =3D cpu_to_le32(status);
> > +     }
> > +
> > +     return cur_frag;
> > +
> > +err_out:
> > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
> > +     return -EIO;
> > +}
> > +
> > +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
> > +                                 struct net_device *dev) {
> > +     struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     u32 q_idx, entry, len, opts1, opts2;
> > +     struct netdev_queue *tx_queue;
> > +     bool stop_queue, door_bell;
> > +     u32 mss =3D shinfo->gso_size;
> > +     struct rtase_tx_desc *txd;
> > +     struct rtase_ring *ring;
> > +     dma_addr_t mapping;
> > +     int frags;
> > +
> > +     /* multiqueues */
> > +     q_idx =3D skb_get_queue_mapping(skb);
> > +     ring =3D &tp->tx_ring[q_idx];
> > +     tx_queue =3D netdev_get_tx_queue(dev, q_idx);
> > +
> > +     if (unlikely(!rtase_tx_avail(ring))) {
> > +             if (net_ratelimit())
> > +                     netdev_err(dev, "BUG! Tx Ring full when queue
> > awake!\n");
> > +             goto err_stop;
> > +     }
> > +
> > +     entry =3D ring->cur_idx % RTASE_NUM_DESC;
> > +     txd =3D ring->desc + sizeof(struct rtase_tx_desc) * entry;
> > +
> > +     opts1 =3D RTASE_DESC_OWN;
> > +     opts2 =3D rtase_tx_vlan_tag(tp, skb);
> > +
> > +     /* tcp segmentation offload (or tcp large send) */
> > +     if (mss) {
> > +             if (shinfo->gso_type & SKB_GSO_TCPV4) {
> > +                     opts1 |=3D RTASE_GIANT_SEND_V4;
> > +             } else if (shinfo->gso_type & SKB_GSO_TCPV6) {
> > +                     if (skb_cow_head(skb, 0))
> > +                             goto err_dma_0;
> > +
> > +                     tcp_v6_gso_csum_prep(skb);
> > +                     opts1 |=3D RTASE_GIANT_SEND_V6;
> > +             } else {
> > +                     WARN_ON_ONCE(1);
> > +             }
> > +
> > +             opts1 |=3D u32_encode_bits(skb_transport_offset(skb),
> > +                                      RTASE_TCPHO_MASK);
> > +             opts2 |=3D u32_encode_bits(mss, RTASE_MSS_MASK);
> > +     } else if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +             opts2 |=3D rtase_tx_csum(skb, dev);
> > +     }
> > +
> > +     frags =3D rtase_xmit_frags(ring, skb, opts1, opts2);
> > +     if (unlikely(frags < 0))
> > +             goto err_dma_0;
> > +
> > +     if (frags) {
> > +             len =3D skb_headlen(skb);
> > +             opts1 |=3D RTASE_TX_FIRST_FRAG;
> > +     } else {
> > +             len =3D skb->len;
> > +             ring->skbuff[entry] =3D skb;
> > +             opts1 |=3D RTASE_TX_FIRST_FRAG | RTASE_TX_LAST_FRAG;
> > +     }
> > +
> > +     if (((entry + 1) % RTASE_NUM_DESC) =3D=3D 0)
> > +             opts1 |=3D (len | RTASE_RING_END);
> > +     else
> > +             opts1 |=3D len;
> > +
> > +     mapping =3D dma_map_single(&tp->pdev->dev, skb->data, len,
> > +                              DMA_TO_DEVICE);
> > +
> > +     if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> > +             if (unlikely(net_ratelimit()))
> > +                     netdev_err(dev, "Failed to map TX DMA!\n");
> > +
> > +             goto err_dma_1;
> > +     }
> > +
> > +     ring->mis.len[entry] =3D len;
> > +     txd->addr =3D cpu_to_le64(mapping);
> > +     txd->opts2 =3D cpu_to_le32(opts2);
> > +     txd->opts1 =3D cpu_to_le32(opts1 & ~RTASE_DESC_OWN);
> > +
> > +     /* make sure the operating fields have been updated */
> > +     dma_wmb();
> > +
> > +     door_bell =3D __netdev_tx_sent_queue(tx_queue, skb->len,
> > +                                        netdev_xmit_more());
> > +
> > +     txd->opts1 =3D cpu_to_le32(opts1);
> > +
> > +     skb_tx_timestamp(skb);
> > +
> > +     /* tx needs to see descriptor changes before updated cur_idx */
> > +     smp_wmb();
> > +
> > +     WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
> > +
> > +     stop_queue =3D !netif_subqueue_maybe_stop(dev, ring->index,
> > +                                             rtase_tx_avail(ring),
> > +
> RTASE_TX_STOP_THRS,
> > +
> RTASE_TX_START_THRS);
> > +
> > +     if (door_bell || stop_queue)
> > +             rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > +
> > +     return NETDEV_TX_OK;
> > +
> > +err_dma_1:
> > +     ring->skbuff[entry] =3D NULL;
> > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> > +
> > +err_dma_0:
> > +     dev->stats.tx_dropped++;
> > +     dev_kfree_skb_any(skb);
> > +     return NETDEV_TX_OK;
> > +
> > +err_stop:
> > +     netif_stop_queue(dev);
> > +     dev->stats.tx_dropped++;
> > +     return NETDEV_TX_BUSY;
> > +}
> > +
> >  static void rtase_enable_eem_write(const struct rtase_private *tp)  {
> >       u8 val;
> > @@ -1065,6 +1349,7 @@ static void rtase_netpoll(struct net_device
> > *dev) static const struct net_device_ops rtase_netdev_ops =3D {
> >       .ndo_open =3D rtase_open,
> >       .ndo_stop =3D rtase_close,
> > +     .ndo_start_xmit =3D rtase_start_xmit,
> >  #ifdef CONFIG_NET_POLL_CONTROLLER
> >       .ndo_poll_controller =3D rtase_netpoll,  #endif
> > --
> > 2.34.1
> >


