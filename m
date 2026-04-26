Return-Path: <netdev+bounces-281177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDMuCrlU7mmOsQAAu9opvQ
	(envelope-from <netdev+bounces-281177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D646AB99
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62BE03001873
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED7282F3C;
	Sun, 26 Apr 2026 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HcGvrLBY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E226AC3;
	Sun, 26 Apr 2026 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777226930; cv=none; b=ofqkoAqXs9FVpxfkmo15RHYfbAZ4kZdkdpw76ETV+kxyFjwYuPuCwMVCf65rSA8jMN2xTDm1Yw7hyTmnTc95e+KlS4SaVNylHovoH5uN1rkDBRH2nCuhc7BtPaGxgvqVUb8HYu5rcEWaf+Rj8qSgeBlfbEmKEui3D55Miy5VMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777226930; c=relaxed/simple;
	bh=4J+qsBSPaKy3NZSauAGXCjlNIlVE9Rx3dS4xhq26CDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBv5o5dY1Othd/ghBpYG5YM85qJvuFVuir/OuzwCpo+09OIEYYj1WL4SpJyv44cKJlF7q1KFMBLSYHcpzAKawJ9pkPuv8TYwhiP4wnL3c0e5l5d3AV0aFXoU3IEMqCBXHS9a+2cHV1WPwcgot3VtHo9oGDTQmnLcd7g7/O1d+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HcGvrLBY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QEEG772399519;
	Sun, 26 Apr 2026 11:08:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=1kOHuBdvnulMDjDL83SJuMa2A
	0DzOUtFe3RtzPxrojA=; b=HcGvrLBYHAOqTU6OuIsqmpydEgnV+sXbUZBC8DOfP
	wbfEG+uXUS2zStBgj8hdE3VOTOeUjBkd3obMi7fUkrwhOGPQq62hiDJAAAJUanrN
	1YWfzYks6SiUpi9DSbr50ePQYr4QG8hVrYcOZVwPRhgHhYhLibu58YQtqd/Qp0Xg
	Q80VairhEthfdf6ON1D1yTtogva85ifrOZrMom5mI1fJ9OkdXq0ou7kwb4G00Lo0
	Kxh8dHXV8IKBeJeSWfOXD58RJf/30rVkl6BDCo2kBLuafd55tEgkZ28xotHn4ZOs
	CV4KHSXUvysDxL9VZrg4NGU6BSN0ZaNqlzln7uwygBVMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4drtypa3cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 11:08:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 11:08:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 11:08:33 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 374733F703F;
	Sun, 26 Apr 2026 11:08:29 -0700 (PDT)
Date: Sun, 26 Apr 2026 23:38:29 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: javen <javen_xu@realsil.com.cn>
CC: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
Message-ID: <20260426180829.GB791856@kernel-ep2>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260420021957.1756-2-javen_xu@realsil.com.cn>
X-Proofpoint-GUID: l72h3dSEMjnyKv27tVoO0A4vpvCHw4t7
X-Authority-Analysis: v=2.4 cv=UfJhjqSN c=1 sm=1 tr=0 ts=69ee54a2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=YYF7fsvRAAAA:8
 a=gykGYSUolajar4F4hnIA:9 a=CjuIK1q_8ugA:10 a=A1P4WKtVarNJ2X4oDzNE:22
X-Proofpoint-ORIG-GUID: l72h3dSEMjnyKv27tVoO0A4vpvCHw4t7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDIwMCBTYWx0ZWRfX1uSp1XVj8AHt
 UzlKxLeoVkdS0f7B510tueft3xcOLLrZ2LoTT5UgU/jkI6x5iRG/OK0iHBYJiAf5FAJr01iwFBT
 kWEqLupmXhsfd6MckmNtNI8pSoD5Dh9yjGiDvZhsKo8RD7wny8lGg58lQJdIDErHTCr3vIMJN7I
 b/mPBQoieREpjXy527Rsa8wIJ+8Xsiu3+7T2lxCOwGT0jW1c0XgmJ1a1OK7KP91TQKIGvNRTOVB
 blQPIZaCE1V4gkp73KLl6xVQhXpB4bqsUIotBeJ6H8aX7eDBAKMdBz6F2V9t0W/xd0+49xy/Tvq
 B6QESlSn7tEB3oqhnAWJGaQAKi8BDBLjuXp71qBvsdOoEaYi+REqUla5HrI8Y4JCraxrz5emMfx
 H8tyPUQ6f/fvbNEFO5merFuUd6sEA8eelAEBEHNxZqNUpYzLGEVKpkSAlnYd3BEeifSVWrGU/Ss
 KVF8VwdN9YRO11Wir6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_06,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 181D646AB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:dkim,realsil.com.cn:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281177-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-20 at 07:49:49, javen (javen_xu@realsil.com.cn) wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support rss, this patch adds some macro definitions and register
> definitions.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 75 +++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 791277e750ba..0fbec27e4a0d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -77,6 +77,23 @@
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_MAX_TX_QUEUES	1
> +#define R8169_MAX_MSIX_VEC	32
> +#define R8127_MAX_TX_QUEUES	1
> +#define R8127_MAX_RX_QUEUES	8
> +#define R8127_MAX_IRQ		32
> +#define R8127_MIN_IRQ		30
> +#define RTL8127_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_OFFSET	16
> +#define RSS_MASK_BITS_OFFSET	8
> +#define RTL8127_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_8125B_RSS_UDP_V4 BIT(27)
> +#define RXS_8125_RSS_IPV4_V4 BIT(28)
> +#define RXS_8125_RSS_IPV6_V4 BIT(29)
> +#define RXS_8125_RSS_TCP_V4 BIT(30)
> +#define RTL8127_RXS_RSS_L3_TYPE_MASK_V4 (RXS_8125_RSS_IPV4_V4 | RXS_8125_RSS_IPV6_V4)
> +#define RTL8127_RXS_RSS_L4_TYPE_MASK_V4 (RXS_8125_RSS_TCP_V4 | RXS_8125B_RSS_UDP_V4)
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -435,6 +452,8 @@ enum rtl8125_registers {
>  #define INT_CFG0_CLKREQEN		BIT(3)
>  	IntrMask_8125		= 0x38,
>  	IntrStatus_8125		= 0x3c,
> +	IntrMask1_8125		= 0x800,
> +	IntrStatus1_8125	= 0x802,
>  	INT_CFG1_8125		= 0x7a,
>  	LEDSEL2			= 0x84,
>  	LEDSEL1			= 0x86,
> @@ -444,6 +463,36 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	TNPDS_Q1_LOW		= 0x2100,
> +	RDSAR_Q1_LOW		= 0x4000,
> +	IMR_V2_SET_REG_8125	= 0x0d0c,
> +	IMR_V2_CLEAR_REG_8125	= 0x0d00,
> +	IMR_V4_L2_CLEAR_REG_8125 = 0x0d10,
> +	ISR_V2_8125		= 0x0d04,
> +	ISR_V4_L2_8125		= 0x0d14,
> +};
> +
> +enum rtl8127_msix_id {
> +	MSIX_ID_V4_LINKCHG	= 29,
> +};
> +
> +enum rtl8127_rss_register_content {
> +	RSS_CTRL_TCP_IPV4_SUPP		= (1 << 0),
> +	RSS_CTRL_IPV4_SUPP		= (1 << 1),
> +	RSS_CTRL_TCP_IPV6_SUPP		= (1 << 2),
> +	RSS_CTRL_IPV6_SUPP		= (1 << 3),
> +	RSS_CTRL_IPV6_EXT_SUPP		= (1 << 4),
> +	RSS_CTRL_TCP_IPV6_EXT_SUPP	= (1 << 5),
> +	RSS_CTRL_UDP_IPV4_SUPP		= (1 << 11),
> +	RSS_CTRL_UDP_IPV6_SUPP		= (1 << 12),
> +	RSS_CTRL_UDP_IPV6_EXT_SUPP	= (1 << 13),
> +	RSS_INDIRECTION_TBL_8125_V2	= 0x4700,
> +	RSS_KEY_8125			= 0x4600,
> +};
> +
> +enum rtl8127_rss_flag {
> +	RTL_8125_RSS_FLAG_HASH_UDP_IPV4  = (1 << 0),
> +	RTL_8125_RSS_FLAG_HASH_UDP_IPV6  = (1 << 1),
>  };
>  
>  #define LEDSEL_MASK_8125	0x23f
> @@ -474,6 +523,10 @@ enum rtl_register_content {
>  	RxRUNT	= (1 << 20),
>  	RxCRC	= (1 << 19),
>  
> +	RxRES_RSS	= (1 << 22),
> +	RxRUNT_RSS	= (1 << 21),
> +	RxCRC_RSS	= (1 << 20),
> +
>  	/* ChipCmdBits */
>  	StopReq		= 0x80,
>  	CmdReset	= 0x10,
> @@ -576,6 +629,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +	ISRIMR_V6_LINKCHG	= (1 << 29),
> +	ISRIMR_V6_TOK_Q0	= (1 << 8),
> +	ISRIMR_V6_ROK_Q0	= (1 << 0),
>  };
>  
>  enum rtl_desc_bit {
> @@ -633,6 +689,11 @@ enum rtl_rx_desc_bit {
>  #define RxProtoIP	(PID1 | PID0)
>  #define RxProtoMask	RxProtoIP
>  
> +	RxUDPT_v4	= (1 << 19),
> +	RxTCPT_v4	= (1 << 18),
> +	RxUDPF_v4	= (1 << 16), /* UDP/IP checksum failed */
> +	RxTCPF_v4	= (1 << 15), /* TCP/IP checksum failed */
> +
>  	IPFail		= (1 << 16), /* IP checksum failed */
>  	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
>  	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
> @@ -659,6 +720,11 @@ struct RxDesc {
>  	__le64 addr;
>  };
>  
> +enum features {
> +	RTL_FEATURE_MSI		= (1 << 1),
> +	RTL_FEATURE_MSIX	= (1 << 2),
> +};
> +
>  struct ring_info {
>  	struct sk_buff	*skb;
>  	u32		len;
> @@ -728,6 +794,13 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_UNKNOWN = 0,
> +	RX_DESC_RING_TYPE_DEAFULT,
typo DEFAULT

Thanks,
Sundeep

> +	RX_DESC_RING_TYPE_RSS,
> +	RX_DESC_RING_TYPE_MAX
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -763,6 +836,8 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool rss_support:1;
> +	bool rss_enable:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> -- 
> 2.43.0
> 

