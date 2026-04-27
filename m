Return-Path: <netdev+bounces-281234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNd7G0MF72ma3wAAu9opvQ
	(envelope-from <netdev+bounces-281234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E459B46DBA6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 874B230160F0
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67237C0F9;
	Mon, 27 Apr 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="vl8vrrCR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF713793BA;
	Mon, 27 Apr 2026 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272104; cv=none; b=gfPz5OO+H7zPFgmd8LV0Xb1t5SNvjD9OhBG9hU9PEBTW3aLgkSffw4hUZuXv4LqCHN1uHN1sjOjN5Y0dbYMrU70XgJj44ViFF3FJS8jjfeOYsKjtpAZBRLuurbooFEaeBlBpJLugao4zT7DnGTh77cMogXGJBxmJdokqSda41S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272104; c=relaxed/simple;
	bh=2HrRCGh+P1+bo4/1ljxHPKMYn4zbM2SAvUxzgsF7iS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gazx87k8COxuWvlaAlzEsJecutc8KMLs7N9h4Ivp2JT9ZPI7pQdtgUG02NinNjzCQX6e20JjAbzAmx/67CZO5W9AhLr063HDXx+RcCFYv5LnLnGglgJY/T2l7CpAkS/9zqiwMi0qzzB+ySUhG7JxTu2DqR3LEpswbpvlTedalyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vl8vrrCR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63R6fMPX13559341, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777272083;
	bh=vvqDh64ryEr+gKZJ9YMR5EKNjg4QbqY1SgbkP2Uakrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vl8vrrCRNbxypdK1ten45ESHuefNtPQXLwUloGoPzc9tl8HFcLQpgl1UQDDRVZMC0
	 3hcNzTlrJ80kS0OgHeIVmAq7IvL3EQ2tnXy8mBbZ+K7sGDRuzwSyzKuM9++NquWTV0
	 d5Bn08SMZS7/axVt4OCrHKBp0xEz8oyRauDF5hcjnJXODM5Vf4j2Bo4TWU9SlvFKAA
	 d86wuH3lDrWL6W8Oct946u0FnDZevcr3oWGJ2YIyIlvztg4MKzhaXQTu9cEkwJqJAd
	 dt9olAEYGPET3KqzngRStfcF8n/NHyIikiCIdzMatIpjJ9+p5odPZ6rQhSDrez7cHh
	 63JLVFB5qLd8g==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63R6fMPX13559341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 14:41:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Apr 2026 14:41:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 27 Apr 2026 14:41:22 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Thread-Topic: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Thread-Index: AQHc0Gw4tWkzOwhnMkm4f1L7ADrw6bXv3/oAgAKP7SA=
Date: Mon, 27 Apr 2026 06:41:22 +0000
Message-ID: <335ace172e20415ead8e56ae117b0fce@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
 <546ff9b7-68b0-46ff-9db4-5fcde421f7df@gmail.com>
In-Reply-To: <546ff9b7-68b0-46ff-9db4-5fcde421f7df@gmail.com>
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
X-Rspamd-Queue-Id: E459B46DBA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281234-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

>On 20.04.2026 04:19, javen wrote:
>> From: Javen Xu <javen_xu@realsil.com.cn>
>>
>> To support rss, this patch adds some macro definitions and register
>> definitions.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 75
>> +++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index 791277e750ba..0fbec27e4a0d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -77,6 +77,23 @@
>>  #define R8169_RX_RING_BYTES  (NUM_RX_DESC * sizeof(struct RxDesc))
>>  #define R8169_TX_STOP_THRS   (MAX_SKB_FRAGS + 1)
>>  #define R8169_TX_START_THRS  (2 * R8169_TX_STOP_THRS)
>> +#define R8169_MAX_RX_QUEUES  8
>> +#define R8169_MAX_TX_QUEUES  1
>> +#define R8169_MAX_MSIX_VEC   32
>> +#define R8127_MAX_TX_QUEUES  1
>
>Then why multi tx queue support?
>
>> +#define R8127_MAX_RX_QUEUES  8
>> +#define R8127_MAX_IRQ                32
>> +#define R8127_MIN_IRQ                30
>
>This isn't self-explanatory. What do min and max refer to here?

The hardware actually reserves a 64-bit interrupt status space for the new =
mapping in RTL8127. Although I don't think it is reasonable, its hardware d=
esign.
- Vector 0-7 (from reg 0x0d04): Rx queues
- Vector 8-15 (from reg 0x0d04): Tx queues
- Vector 29 (from reg 0x0d06): Link Status Change (LSC)
As the Link Status Change interrupt is fixed at vector index 29, we are for=
ced to request a minimum of 30 MSI-X vectors from the PCI core.

>
>> +#define RTL8127_RSS_KEY_SIZE 40
>> +#define RSS_CPU_NUM_OFFSET   16
>> +#define RSS_MASK_BITS_OFFSET 8
>> +#define RTL8127_MAX_INDIRECTION_TABLE_ENTRIES 128 #define
>> +RXS_8125B_RSS_UDP_V4 BIT(27) #define RXS_8125_RSS_IPV4_V4 BIT(28)
>> +#define RXS_8125_RSS_IPV6_V4 BIT(29) #define RXS_8125_RSS_TCP_V4
>> +BIT(30) #define RTL8127_RXS_RSS_L3_TYPE_MASK_V4
>(RXS_8125_RSS_IPV4_V4
>> +| RXS_8125_RSS_IPV6_V4) #define RTL8127_RXS_RSS_L4_TYPE_MASK_V4
>> +(RXS_8125_RSS_TCP_V4 | RXS_8125B_RSS_UDP_V4)
>>
>>  #define OCP_STD_PHY_BASE     0xa400
>>
>> @@ -435,6 +452,8 @@ enum rtl8125_registers {
>>  #define INT_CFG0_CLKREQEN            BIT(3)
>>       IntrMask_8125           =3D 0x38,
>>       IntrStatus_8125         =3D 0x3c,
>> +     IntrMask1_8125          =3D 0x800,
>> +     IntrStatus1_8125        =3D 0x802,
>>       INT_CFG1_8125           =3D 0x7a,
>>       LEDSEL2                 =3D 0x84,
>>       LEDSEL1                 =3D 0x86,
>> @@ -444,6 +463,36 @@ enum rtl8125_registers {
>>       RSS_CTRL_8125           =3D 0x4500,
>>       Q_NUM_CTRL_8125         =3D 0x4800,
>>       EEE_TXIDLE_TIMER_8125   =3D 0x6048,
>> +     TNPDS_Q1_LOW            =3D 0x2100,
>> +     RDSAR_Q1_LOW            =3D 0x4000,
>> +     IMR_V2_SET_REG_8125     =3D 0x0d0c,
>> +     IMR_V2_CLEAR_REG_8125   =3D 0x0d00,
>> +     IMR_V4_L2_CLEAR_REG_8125 =3D 0x0d10,
>> +     ISR_V2_8125             =3D 0x0d04,
>> +     ISR_V4_L2_8125          =3D 0x0d14,
>> +};
>> +
>> +enum rtl8127_msix_id {
>> +     MSIX_ID_V4_LINKCHG      =3D 29,
>> +};
>> +
>> +enum rtl8127_rss_register_content {
>> +     RSS_CTRL_TCP_IPV4_SUPP          =3D (1 << 0),
>> +     RSS_CTRL_IPV4_SUPP              =3D (1 << 1),
>> +     RSS_CTRL_TCP_IPV6_SUPP          =3D (1 << 2),
>> +     RSS_CTRL_IPV6_SUPP              =3D (1 << 3),
>> +     RSS_CTRL_IPV6_EXT_SUPP          =3D (1 << 4),
>> +     RSS_CTRL_TCP_IPV6_EXT_SUPP      =3D (1 << 5),
>> +     RSS_CTRL_UDP_IPV4_SUPP          =3D (1 << 11),
>> +     RSS_CTRL_UDP_IPV6_SUPP          =3D (1 << 12),
>> +     RSS_CTRL_UDP_IPV6_EXT_SUPP      =3D (1 << 13),
>> +     RSS_INDIRECTION_TBL_8125_V2     =3D 0x4700,
>> +     RSS_KEY_8125                    =3D 0x4600,
>> +};
>> +
>> +enum rtl8127_rss_flag {
>> +     RTL_8125_RSS_FLAG_HASH_UDP_IPV4  =3D (1 << 0),
>> +     RTL_8125_RSS_FLAG_HASH_UDP_IPV6  =3D (1 << 1),
>>  };
>>
>>  #define LEDSEL_MASK_8125     0x23f
>> @@ -474,6 +523,10 @@ enum rtl_register_content {
>>       RxRUNT  =3D (1 << 20),
>>       RxCRC   =3D (1 << 19),
>>
>> +     RxRES_RSS       =3D (1 << 22),
>> +     RxRUNT_RSS      =3D (1 << 21),
>> +     RxCRC_RSS       =3D (1 << 20),
>> +
>>       /* ChipCmdBits */
>>       StopReq         =3D 0x80,
>>       CmdReset        =3D 0x10,
>> @@ -576,6 +629,9 @@ enum rtl_register_content {
>>
>>       /* magic enable v2 */
>>       MagicPacket_v2  =3D (1 << 16),    /* Wake up when receives a Magic=
 Packet
>*/
>> +     ISRIMR_V6_LINKCHG       =3D (1 << 29),
>> +     ISRIMR_V6_TOK_Q0        =3D (1 << 8),
>> +     ISRIMR_V6_ROK_Q0        =3D (1 << 0),
>>  };
>>
>>  enum rtl_desc_bit {
>> @@ -633,6 +689,11 @@ enum rtl_rx_desc_bit {
>>  #define RxProtoIP    (PID1 | PID0)
>>  #define RxProtoMask  RxProtoIP
>>
>> +     RxUDPT_v4       =3D (1 << 19),
>> +     RxTCPT_v4       =3D (1 << 18),
>> +     RxUDPF_v4       =3D (1 << 16), /* UDP/IP checksum failed */
>> +     RxTCPF_v4       =3D (1 << 15), /* TCP/IP checksum failed */
>> +
>>       IPFail          =3D (1 << 16), /* IP checksum failed */
>>       UDPFail         =3D (1 << 15), /* UDP/IP checksum failed */
>>       TCPFail         =3D (1 << 14), /* TCP/IP checksum failed */
>> @@ -659,6 +720,11 @@ struct RxDesc {
>>       __le64 addr;
>>  };
>>
>> +enum features {
>> +     RTL_FEATURE_MSI         =3D (1 << 1),
>> +     RTL_FEATURE_MSIX        =3D (1 << 2),
>> +};
>> +
>>  struct ring_info {
>>       struct sk_buff  *skb;
>>       u32             len;
>> @@ -728,6 +794,13 @@ enum rtl_dash_type {
>>       RTL_DASH_25_BP,
>>  };
>>
>> +enum rx_desc_ring_type {
>> +     RX_DESC_RING_TYPE_UNKNOWN =3D 0,
>> +     RX_DESC_RING_TYPE_DEAFULT,
>> +     RX_DESC_RING_TYPE_RSS,
>> +     RX_DESC_RING_TYPE_MAX
>> +};
>> +
>>  struct rtl8169_private {
>>       void __iomem *mmio_addr;        /* memory map physical address */
>>       struct pci_dev *pci_dev;
>> @@ -763,6 +836,8 @@ struct rtl8169_private {
>>       unsigned aspm_manageable:1;
>>       unsigned dash_enabled:1;
>>       bool sfp_mode:1;
>> +     bool rss_support:1;
>> +     bool rss_enable:1;
>>       dma_addr_t counters_phys_addr;
>>       struct rtl8169_counters *counters;
>>       struct rtl8169_tc_offsets tc_offset;


