Return-Path: <netdev+bounces-293007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPvhBeo3GWrzswgAu9opvQ
	(envelope-from <netdev+bounces-293007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:53:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D05FE34A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FC303007AF2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6503AB293;
	Fri, 29 May 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="fi8lL5Pl"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478D3A960F;
	Fri, 29 May 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037249; cv=none; b=Fz0LDODY7+pGgn5pk8f0WadkrqPYBRQR3D6kd5Xd2+OC488B8uEfs7alALFKx7Aqf23+GeLai0enoLriZXwbQLSwO/bGYHRUjFNq+60uuptkbcFlK43UVrxh1xt80ahtGU+geCwMJh5A5Goxumt8u1ymYrSemGrg567/CLdukWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037249; c=relaxed/simple;
	bh=yLDj1VECj+L66hLUBRdYJeEtBFffUak/yvEsHx7FHsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cs2s/GlBFwmrF7U7vWUzE8U8KbR03N7IG+xLDn3MmiiyHWc7DTZ9N+SMdoTKm4PHF9lJpUtDu0xniUhOLAmF4R8hat+pj2XOC4qTafnaaVQU6HI1Lp4Dfqm4a9DoPOzaTPKtPZ7XyB8gRVw2Kts/puvqFtOxhzYLOs616Ew16bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=fi8lL5Pl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T6l0Hy93935051, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780037221;
	bh=+o05B5+4koPa+Y5p5M8qVCF1IP0kbOJZhpYf149ypcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fi8lL5Pl+SizFUYyKh+0sI9gs3/4sAnTzLZG/oO6NvDPxRnXkmZuy+YC5c7ARzx4R
	 FMx0sYj9t0Mzxdu0HlZ8NUkY826k7MwD2N7ADN7OMssafzU7S8/7dOrRGaXl1LpmLZ
	 h3uZIDuwBDQGiEE/9rj51meTCK89Hoj+gTOTmJ5wcKudYCaSUYynNlscB2cVn9MZ7E
	 SNMzRqZbw9BMfOou6u219RxBU+xr54nQVVTiZu5zR1VfqQ6B0CCVaLreqbjq5pDiBC
	 RB3V3b26goDoO++P5IbA8b1cxAfiNdxGAWtzapVRC6oWfTS8YZCaG1z+so1kXOzKRv
	 U+yVqkcLXXSoQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T6l0Hy93935051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 May 2026 14:47:01 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 14:47:00 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 29 May 2026 14:47:00 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Jakub Kicinski <kuba@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch net-next v6 2/7] r8169: add support for multi rx queues
Thread-Topic: [Patch net-next v6 2/7] r8169: add support for multi rx queues
Thread-Index: AQHc7Oc8RJ5vHMWvDkeTfX1t71AiUbYjrkwAgADkx/A=
Date: Fri, 29 May 2026 06:47:00 +0000
Message-ID: <fe97b63208af41fc811ad37db94bc705@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-3-javen_xu@realsil.com.cn>
 <20260528180432.4652dcfa@kernel.org>
In-Reply-To: <20260528180432.4652dcfa@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293007-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 765D05FE34A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>On Tue, 26 May 2026 16:11:12 +0800 javen wrote:
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index 22e843baffc7..62bf77aa1ec8 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -74,9 +74,13 @@
>>  #define NUM_TX_DESC  256     /* Number of Tx descriptor registers */
>>  #define NUM_RX_DESC  256     /* Number of Rx descriptor registers */
>>  #define R8169_TX_RING_BYTES  (NUM_TX_DESC * sizeof(struct TxDesc))
>> -#define R8169_RX_RING_BYTES  (NUM_RX_DESC * sizeof(struct RxDesc))
>> +#define R8169_RX_RING_BYTES  ((NUM_RX_DESC + 1) * sizeof(struct
>> +RxDesc))
>
>AI bots are asking why the "+ 1"?

This + 1 is a workaround for the hardware DMA prefetcher. The H/W might agg=
ressively fetch one more descriptor even after hitting the RingEnd mark. We=
 allocated this extra dummy space as padding to prevent out-of-bounds acces=
s and potential IOMMU faults.

>
>>  #define R8169_TX_STOP_THRS   (MAX_SKB_FRAGS + 1)
>>  #define R8169_TX_START_THRS  (2 * R8169_TX_STOP_THRS)
>> +#define R8169_MAX_RX_QUEUES  8
>> +#define R8127_MAX_RX_QUEUES  8
>> +#define R8169_DEFAULT_RX_QUEUES      1
>> +#define R8169_MAX_TX_QUEUES  1
>>
>>  #define OCP_STD_PHY_BASE     0xa400
>>
>> @@ -441,6 +445,7 @@ enum rtl8125_registers {
>>       TxPoll_8125             =3D 0x90,
>>       LEDSEL3                 =3D 0x96,
>>       MAC0_BKP                =3D 0x19e0,
>> +     RDSAR_Q1_LOW            =3D 0x4000,
>>       RSS_CTRL_8125           =3D 0x4500,
>>       Q_NUM_CTRL_8125         =3D 0x4800,
>>       EEE_TXIDLE_TIMER_8125   =3D 0x6048,
>> @@ -728,6 +733,21 @@ enum rtl_dash_type {
>>       RTL_DASH_25_BP,
>>  };
>>
>> +enum rx_desc_ring_type {
>> +     RX_DESC_RING_TYPE_DEFAULT,
>> +     RX_DESC_RING_TYPE_RSS,
>> +};
>> +
>> +struct rtl8169_rx_ring {
>> +     u32 index;                                      /* Rx queue index =
*/
>> +     u32 cur_rx;                                     /* Index of next R=
x pkt. */
>> +     u32 dirty_rx;                                   /* Index for recyc=
ling. */
>> +     struct RxDesc *rx_desc_array;                   /* array of Rx Des=
c*/
>> +     dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];       /* Rx data buffer
>physical dma address */
>> +     dma_addr_t rx_phy_addr;                         /* Rx desc physica=
l address */
>> +     struct page *rx_databuff[NUM_RX_DESC];          /* Rx data buffers=
 */
>> +};
>> +
>>  struct rtl8169_private {
>>       void __iomem *mmio_addr;        /* memory map physical address */
>>       struct pci_dev *pci_dev;
>> @@ -735,20 +755,18 @@ struct rtl8169_private {
>>       struct phy_device *phydev;
>>       enum mac_version mac_version;
>>       enum rtl_dash_type dash_type;
>> -     u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt.=
 */
>>       u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt.=
 */
>>       u32 dirty_tx;
>>       struct TxDesc *TxDescArray;     /* 256-aligned Tx descriptor ring =
*/
>> -     struct RxDesc *RxDescArray;     /* 256-aligned Rx descriptor ring =
*/
>>       dma_addr_t TxPhyAddr;
>> -     dma_addr_t RxPhyAddr;
>> -     struct page *Rx_databuff[NUM_RX_DESC];  /* Rx data buffers */
>>       struct ring_info tx_skb[NUM_TX_DESC];   /* Tx data buffers */
>>       struct napi_struct *rtl8169_napi;
>> +     struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>>       unsigned int num_rx_rings;
>>       u16 cp_cmd;
>>       u16 tx_lpi_timer;
>>       u32 irq_mask;
>> +     unsigned int hw_supp_num_rx_queues;
>>       unsigned int irq_nvecs;
>>       struct clk *clk;
>>
>> @@ -764,6 +782,7 @@ struct rtl8169_private {
>>       unsigned aspm_manageable:1;
>>       unsigned dash_enabled:1;
>>       bool sfp_mode:1;
>> +     bool recheck_desc_ownbit:1;
>
>AI bots ask if this needs to be set for all chips or just some specific ve=
rsion.
>Also, I think this workaround should be added in a dedicated commit. For
>ease of review the introduction of struct rtl8169_rx_ring should be a code=
-
>reshuffling type of commit, rather than a functional change.

I will remove it from this patch and add it in a dedicated commit.

>
>>       dma_addr_t counters_phys_addr;
>>       struct rtl8169_counters *counters;
>>       struct rtl8169_tc_offsets tc_offset;

