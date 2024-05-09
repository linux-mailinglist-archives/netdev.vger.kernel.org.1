Return-Path: <netdev+bounces-94830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387058C0CF8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644BD1C20F16
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92C14A0A3;
	Thu,  9 May 2024 08:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31412149C6C;
	Thu,  9 May 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245153; cv=none; b=PDzDOm4mzJ7Ej5PtIveBC6dcTc4cctA5T0nyVlN/1AsZHWVCwj6tucouvFPBBIMzsMPyK751hNshCQy/Jcob+PLJFZU3rdBo4ILKW/3B+EMFR5dRuhZeb4KHoVZtvjkeojINBGKRGnFwV/91msbo/eGYAhGUGZN/0Mn8rDXIKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245153; c=relaxed/simple;
	bh=koXkkXyo2fXKNsIgVU44WH/LgBvHigRvyRRFKn2RO50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJOIgogxdo0FqaP7LILKsPJIUEjPPmmdaOTB2a0KpgBmkbffypc3whxIwHARDZB4OOMaLI/RwR8pJpR7dbUM78tCqyu3zPRDZInQWiFF0j9EdkL33LuNqIhJNkRUQjpeGB6mn+o4aaLUgonjUlc2uz3D7Y/Ojf61oILIwjcrPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4498wcfA71418763, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4498wcfA71418763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 16:58:38 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:58:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:58:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 9 May 2024 16:58:37 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v18 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHaoUT5RWh4TO7cuUeh1vkT8i8o3LGN87+AgACfZIA=
Date: Thu, 9 May 2024 08:58:37 +0000
Message-ID: <9267c5002e444000bb21e8eef4d4dc07@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
 <20240508123945.201524-3-justinlai0215@realtek.com>
 <20240509065747.GB1077013@maili.marvell.com>
In-Reply-To: <20240509065747.GB1077013@maili.marvell.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

>=20
> On 2024-05-08 at 18:09:34, Justin Lai (justinlai0215@realtek.com) wrote:
> >
> > +static int rtase_alloc_desc(struct rtase_private *tp) {
> > +     struct pci_dev *pdev =3D tp->pdev;
> > +     u32 i;
> > +
> > +     /* rx and tx descriptors needs 256 bytes alignment.
> > +      * dma_alloc_coherent provides more.
> > +      */
> > +     for (i =3D 0; i < tp->func_tx_queue_num; i++) {
> > +             tp->tx_ring[i].desc =3D
> > +                             dma_alloc_coherent(&pdev->dev,
> > +
> RTASE_TX_RING_DESC_SIZE,
> > +
> &tp->tx_ring[i].phy_addr,
> > +                                                GFP_KERNEL);
> > +             if (!tp->tx_ring[i].desc)
> You have handled errors gracefully very where else. why not here ?

I would like to ask you, are you referring to other places where there are
error description messages, but not here?

> > +                     return -ENOMEM;
> > +     }
> > +
> > +     for (i =3D 0; i < tp->func_rx_queue_num; i++) {
> > +             tp->rx_ring[i].desc =3D
> > +                             dma_alloc_coherent(&pdev->dev,
> > +
> RTASE_RX_RING_DESC_SIZE,
> > +
> &tp->rx_ring[i].phy_addr,
> > +                                                GFP_KERNEL);
> > +             if (!tp->rx_ring[i].desc)
> > +                     return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void rtase_free_desc(struct rtase_private *tp) {
> > +     struct pci_dev *pdev =3D tp->pdev;
> > +     u32 i;
> > +
> > +     for (i =3D 0; i < tp->func_tx_queue_num; i++) {
> > +             if (!tp->tx_ring[i].desc)
> > +                     continue;
> > +
> > +             dma_free_coherent(&pdev->dev,
> RTASE_TX_RING_DESC_SIZE,
> > +                               tp->tx_ring[i].desc,
> > +                               tp->tx_ring[i].phy_addr);
> > +             tp->tx_ring[i].desc =3D NULL;
> > +     }
> > +
> > +     for (i =3D 0; i < tp->func_rx_queue_num; i++) {
> > +             if (!tp->rx_ring[i].desc)
> > +                     continue;
> > +
> > +             dma_free_coherent(&pdev->dev,
> RTASE_RX_RING_DESC_SIZE,
> > +                               tp->rx_ring[i].desc,
> > +                               tp->rx_ring[i].phy_addr);
> > +             tp->rx_ring[i].desc =3D NULL;
> > +     }
> > +}
> > +
> > +static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32
> > +rx_buf_sz) {
> > +     u32 eor =3D le32_to_cpu(desc->desc_cmd.opts1) & RTASE_RING_END;
> > +
> > +     desc->desc_status.opts2 =3D 0;
> desc->desc_cmd.addr to be written before desc->desc_status.opts2 ? Just
> desc->a question
> whether below dma_wmb() suffice for both ?

Thank you for your suggestion, this seems feasible,
I will modify it again.

> > +     /* force memory writes to complete before releasing descriptor */
> > +     dma_wmb();
> > +     WRITE_ONCE(desc->desc_cmd.opts1,
> > +                cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz)); }
> > +
> > +static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx) {
> > +     struct rtase_ring *ring =3D &tp->tx_ring[idx];
> > +     struct rtase_tx_desc *desc;
> > +     u32 i;
> > +
> > +     memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
> > +     memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
> > +     ring->cur_idx =3D 0;
> > +     ring->dirty_idx =3D 0;
> > +     ring->index =3D idx;
> > +
> > +     for (i =3D 0; i < RTASE_NUM_DESC; i++) {
> > +             ring->mis.len[i] =3D 0;
> > +             if ((RTASE_NUM_DESC - 1) =3D=3D i) {
> > +                     desc =3D ring->desc + sizeof(struct rtase_tx_desc=
) *
> i;
> > +                     desc->opts1 =3D cpu_to_le32(RTASE_RING_END);
> > +             }
> > +     }
> > +
> > +     ring->ring_handler =3D tx_handler;
> > +     if (idx < 4) {
> > +             ring->ivec =3D &tp->int_vector[idx];
> > +             list_add_tail(&ring->ring_entry,
> > +                           &tp->int_vector[idx].ring_list);
> > +     } else {
> > +             ring->ivec =3D &tp->int_vector[0];
> > +             list_add_tail(&ring->ring_entry,
> &tp->int_vector[0].ring_list);
> > +     }
> > +}
> > +
> > +static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t
> mapping,
> > +                           u32 rx_buf_sz) {
> > +     desc->desc_cmd.addr =3D cpu_to_le64(mapping);
> > +     /* make sure the physical address has been updated */
> > +     wmb();
> why not dma_wmb();

dma_wmb() is already done in rtase_mark_to_asic(), so I will remove wmb().

> > +     rtase_mark_to_asic(desc, rx_buf_sz); }
> > +
> > +static void rtase_make_unusable_by_asic(union rtase_rx_desc *desc) {
> > +     desc->desc_cmd.addr =3D cpu_to_le64(RTK_MAGIC_NUMBER);
> > +     desc->desc_cmd.opts1 &=3D ~cpu_to_le32(RTASE_DESC_OWN |
> > +RSVD_MASK); }
> > +
> > +static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
> > +                           struct sk_buff **p_sk_buff,
> > +                           union rtase_rx_desc *desc,
> > +                           dma_addr_t *rx_phy_addr, u8 in_intr) {
> > +     struct rtase_int_vector *ivec =3D ring->ivec;
> > +     const struct rtase_private *tp =3D ivec->tp;
> > +     struct sk_buff *skb =3D NULL;
> > +     dma_addr_t mapping;
> > +     struct page *page;
> > +     void *buf_addr;
> > +     int ret =3D 0;
> > +
> > +     page =3D page_pool_dev_alloc_pages(tp->page_pool);
> > +     if (!page) {
> > +             netdev_err(tp->dev, "failed to alloc page\n");
> > +             goto err_out;
> > +     }
> > +
> > +     buf_addr =3D page_address(page);
> > +     mapping =3D page_pool_get_dma_addr(page);
> > +
> > +     skb =3D build_skb(buf_addr, PAGE_SIZE);
> > +     if (!skb) {
> > +             page_pool_put_full_page(tp->page_pool, page, true);
> > +             netdev_err(tp->dev, "failed to build skb\n");
> > +             goto err_out;
> > +     }
> Did you mark the skb for recycle ? Hmm ... did i miss to find the code ?
>=20
We have done this part when using the skb and before finally releasing
the skb resource. Do you think it would be better to do this part of the
process when allocating the skb?

> > +
> > +     *p_sk_buff =3D skb;
> > +     *rx_phy_addr =3D mapping;
> > +     rtase_map_to_asic(desc, mapping, tp->rx_buf_sz);
> > +
> > +     return ret;
> > +
> > +err_out:
> > +     if (skb)
> > +             dev_kfree_skb(skb);
> > +
> > +     ret =3D -ENOMEM;
> > +     rtase_make_unusable_by_asic(desc);
> > +
> > +     return ret;
> > +}
> > +
> > +
> > +
> > +static int rtase_open(struct net_device *dev) {
> > +     struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct pci_dev *pdev =3D tp->pdev;
> > +     struct rtase_int_vector *ivec;
> > +     u16 i =3D 0, j;
> > +     int ret;
> > +
> > +     ivec =3D &tp->int_vector[0];
> > +     tp->rx_buf_sz =3D RTASE_RX_BUF_SIZE;
> > +
> > +     ret =3D rtase_alloc_desc(tp);
> > +     if (ret)
> > +             goto err_free_all_allocated_mem;
> > +
> > +     ret =3D rtase_init_ring(dev);
> > +     if (ret)
> > +             goto err_free_all_allocated_mem;
> > +
> > +     rtase_hw_config(dev);
> > +
> > +     if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
> > +             ret =3D request_irq(ivec->irq, rtase_interrupt, 0,
> > +                               dev->name, ivec);
> > +             if (ret)
> > +                     goto err_free_all_allocated_irq;
> > +
> > +             /* request other interrupts to handle multiqueue */
> > +             for (i =3D 1; i < tp->int_nums; i++) {
> > +                     ivec =3D &tp->int_vector[i];
> > +                     snprintf(ivec->name, sizeof(ivec->name),
> "%s_int%i",
> > +                              tp->dev->name, i);
> > +                     ret =3D request_irq(ivec->irq, rtase_q_interrupt,=
 0,
> > +                                       ivec->name, ivec);
> > +                     if (ret)
> > +                             goto err_free_all_allocated_irq;
> > +             }
> > +     } else {
> > +             ret =3D request_irq(pdev->irq, rtase_interrupt, 0, dev->n=
ame,
> > +                               ivec);
> > +             if (ret)
> > +                     goto err_free_all_allocated_mem;
> > +     }
> > +
> > +     rtase_hw_start(dev);
> > +
> > +     for (i =3D 0; i < tp->int_nums; i++) {
> > +             ivec =3D &tp->int_vector[i];
> > +             napi_enable(&ivec->napi);
> > +     }
> > +
> > +     netif_carrier_on(dev);
> > +     netif_wake_queue(dev);
> > +
> > +     return 0;
> > +
> > +err_free_all_allocated_irq:
> You are allocating from i =3D 1, but freeing from j =3D 0;

Hi Ratheesh,
I have done request_irq() once before the for loop,
so there should be no problem starting free from j=3D0 here.

> > +     for (j =3D 0; j < i; j++)
> > +             free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
> > +
> > +err_free_all_allocated_mem:
> > +     rtase_free_desc(tp);
> > +
> > +     return ret;
> > +}
> > +
> >

