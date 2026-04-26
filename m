Return-Path: <netdev+bounces-281192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE1cEqhx7mnctwAAu9opvQ
	(envelope-from <netdev+bounces-281192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 22:12:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76546B051
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B2973001FC8
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F138F659;
	Sun, 26 Apr 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTJ73IF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104F38C400
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234340; cv=none; b=soUgaZ63OAV5hipliyQbfWLN0mfM8ZME86wt9FqCDgAgSrTn8mEhOe2+PP/WIAXzNKgliTktXGLQWCDFdA8DXCq2NCJiAgkKiwlUACRudX2/rOYpWOrZKIYg3dnixRTgNCBjGeIEF6frlLH8HhzGHxFBfkyoXtW7GulQWoev1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234340; c=relaxed/simple;
	bh=vkMQFu6FUUpmKstotNUVJ8eCYCoYaG2bsECiRxWAdMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfiO+dsEbFElk/7b2BWtmtQdrxrHT+g2JPM0hvE+5CW7DVWW5PdDhcz75ZI3t1w5T54kii8tXUkXoD3d0Y6AE5Tcva0llub0tiRn5758n2cnCjzz8VA3syi2ALNfgKixOr8943AzKoNMNdvOCRTVry3CQgVgbS0wMbwEYTcjvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTJ73IF+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so159452975e9.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777234338; x=1777839138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9HvcIbqvDopKGoULJ5BTkr9f1UT1FsrXMYulVeBPd4=;
        b=CTJ73IF+Bapt58+DhccI96odHOCGCk1tQuEPsbwpBhqX7WTsG0svL7JgAU6tIUumWP
         2WiFvn851/sKnLH973XUL0pWUXAHOxNED0gUERlwSNhGIn/07uXQYZD6qfoZbgFgLuo0
         w8Tzc+1ZlpBbfEEaWKcyRnTUJyX3XC5hofhLAAnLfxiR9EIjoxKROypF5HGwdDfvcep1
         4Z/g4IZFCDnfvFZ8GZ56Ql6j/hH6gNhnN2bPIfZe7c6M5cg0RRFxVeUfl06j8riAd+A8
         0NDZ+codRt9CRSm/GgkJqX6DC8IY95U8/l2iVL0SR3nqScJAt3PNf1ogv4QZi+w+MDde
         GBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777234338; x=1777839138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9HvcIbqvDopKGoULJ5BTkr9f1UT1FsrXMYulVeBPd4=;
        b=NjGWe1rpb7nLO3fC24pItpUO94Y390FaAB4W4kxpsTD/LT5hB7eHzz2GuZqhlcG/Sx
         ucN7FmPCq3QURb8ekTryFtjes0Yd08Omm/+nyFFOt+Uc07g/afrwTvadUFOLFlh/WwzR
         k0xhuWni76gFibKS+bxU760pmDlfWJs7xl6DN8vsr1NULqAlMWmAYM95CrnPsUaOGI80
         Lg+YWlOoQNdK+epyPcD9I9Z9Hfwj+Lwu9aWvKRn5cd+D/caZdUgcZZZa3vuro72RLBic
         4mjRx5WVjVY2wWmjWGYMVqVD6Muk5nY6aEi+fxC6kTk2MbWHdi5vi48BQHLpu1354gGG
         vfEQ==
X-Gm-Message-State: AOJu0YyJ8SJiKUTLmH8TUo8I3ImkGeEAJxq+bZI8Mqsk2ffiXIjA56vn
	mf98tdLoUUuZCftxTZyz6mwm9qj4jXdiJbksmKenp+MnpBXoxejSemJ7
X-Gm-Gg: AeBDies29x7Z6tircDibPG2RW/OCwiuNr1I4eRsfMwfH4YkW3kIPZxZRJD0g0k8pKBv
	CXj0bT148MSpQinWAIsqxOGiFBsH7mvOG7l/9vOxBe5z6TFZ9jtmXK3/481uP70DvVKrQc+5Ntf
	Ul4anEpc6cKf1dTN6YOHBgPGgjLOgZN5SeaPDkSG/vR31ehn+o0gf+Fon08wLOeehM22jQtpyyX
	VT/N5fbPmC/c4QbOTL4BBzFpq4SfcIK/C2elbGEqwpKKuO1yAYUyNvRye5/4HjxCppmZS/ipthQ
	pAGQEBN8LVwbSDLIk44gf9CV+kVQopyJhC824wa+QGCh/0RYbXrVHFiOFzzb1vov2M4whgZn9oO
	LSQLLUxyFSU7WVPp6+B8MThcVcGG6dftPbGmRvrf+EQqHnhrirvhHaNVdRafYpmpMLHlMZOF0MJ
	7pl4FRHubRNP6H2UlflAhzsAi0f4w5xMps04vsCR+BlAL5n14Z2HioMLJnBzb4wYXGvQ4SLbHfr
	LdxvgbhcZBG5kr6uTT0853/is/PG+AmvPQQcJfoIyj4NmmKtLzmbfiq3wFJQWyHRuaKPiukjmR4
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id 5b1f17b1804b1-488fb742e7fmr339025565e9.7.1777234337351;
        Sun, 26 Apr 2026 13:12:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f05:5f00:78bd:435f:9d9e:b57a? (p200300ea8f055f0078bd435f9d9eb57a.dip0.t-ipconnect.de. [2003:ea:8f05:5f00:78bd:435f:9d9e:b57a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm711572495e9.0.2026.04.26.13.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 13:12:16 -0700 (PDT)
Message-ID: <59c06e34-2782-438e-bfd7-a8d475f34f95@gmail.com>
Date: Sun, 26 Apr 2026 22:12:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch net-next v1 1/9] r8169: add some register definitions
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
 <20260420021957.1756-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260420021957.1756-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD76546B051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281192-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realsil.com.cn:email]

On 20.04.2026 04:19, javen wrote:
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

Why do you need at least 30 irq vecs?

> +#define RTL8127_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_OFFSET	16
> +#define RSS_MASK_BITS_OFFSET	8
> +#define RTL8127_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_8125B_RSS_UDP_V4 BIT(27)

This register naming is unfortunate. What stands 8125B for, and what V4?
Does V4 stand for a global version of the Realtek RSS IP block?
Then the 8125B would be redundant.

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

The driver has camel case for historic reasons. Camel case shouldn't
be used for new constants. Checkpatch would have warned. There are
several other places in the series where checkpatch would complain.
Therefore, use checkpatch and fix all warnings/errors.

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

There are registers with at least V2, V4, V6.
And like in a previous comment: Which benefit has the
8125 here (at least if the versioning is global)?

> +};
> +
> +enum rtl8127_msix_id {
> +	MSIX_ID_V4_LINKCHG	= 29,
> +};
> +
> +enum rtl8127_rss_register_content {
> +	RSS_CTRL_TCP_IPV4_SUPP		= (1 << 0),

BIT() macro can be used. And any specific reasons (except historic ones)
why you define an enum that is never used instead of defines?

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


