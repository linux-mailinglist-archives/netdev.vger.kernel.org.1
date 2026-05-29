Return-Path: <netdev+bounces-292916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AzekKibmGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:04:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472EE5FBCCB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFF173010638
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922A34D3B5;
	Fri, 29 May 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyAJKjAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063622A1CF;
	Fri, 29 May 2026 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016675; cv=none; b=QT1DgcP0oOzo3MYQInH0W5pToVPhDlTfgs/mqrybYcvUoZYmrFXtNdZC+FQJxPfKm/DTF8a3CSS4wz4jkFGBH3gvsl57uDWPipNUlNw//vDe62PelSUJyKcfoecDE9qnZ0cheP+R7g/NF6S99h9i5wrvCnoSFYB1aoujxOejaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016675; c=relaxed/simple;
	bh=hJRm4RCDKJi1JsynDhNj/DYfUp856jZdDii5CBobBO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fke5UynjhJZ83wInwR7spvyOcV7XrixnnQ0othAUJvuKPhqnmIVmYvI/irvur43QWjbKtgOoEJWmSqOL+jIYB91bXa+iTISRkiLDXOpxZC0YWiax1Obpn5e0nZlIoJNEBxmJrcUOOsfvSWhf2rWaX8wSioVKhGZDAc9nbZhZQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyAJKjAk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D901F000E9;
	Fri, 29 May 2026 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780016673;
	bh=K4saZNOe2/RIi84HrgBLX3Cn6YUttN1ZK3cGL8Yp5kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lyAJKjAk3w08wH1HRKVnKG2f1ZdilmNnLLRK/WxRN8KUv76iKG+q+xpwE7rpRxEHs
	 RYn6eMcTDxUpbkTjiX2QV5Crm7SkIX6dRNDuHtH5XaCzk9qp6jI8aIsdpcn1ht9iMm
	 lSs1rAvBpgQMFDhm/Yfe8QYmpSd1qde2aOAKPPy4QD7VR4r9noZvRk1H8XJ19VyPEu
	 U8zOvIQMVsVN9wTrGvIOcO6sNdmc46V556TutN5V8k416Yy4ovUM9sWIxGFtbg/iNb
	 JIYbYs7xgGLLSJLKFWi14kVp6T4oaxBardm+X0McUZoG2x8lhCE8BWY9nNenGFHJOc
	 5HImxhXgsU77g==
Date: Thu, 28 May 2026 18:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch net-next v6 2/7] r8169: add support for multi rx queues
Message-ID: <20260528180432.4652dcfa@kernel.org>
In-Reply-To: <20260526081117.173-3-javen_xu@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
	<20260526081117.173-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292916-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 472EE5FBCCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 16:11:12 +0800 javen wrote:
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 22e843baffc7..62bf77aa1ec8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,9 +74,13 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> -#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
> +#define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))

AI bots are asking why the "+ 1"?

>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8127_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
> +#define R8169_MAX_TX_QUEUES	1
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -441,6 +445,7 @@ enum rtl8125_registers {
>  	TxPoll_8125		= 0x90,
>  	LEDSEL3			= 0x96,
>  	MAC0_BKP		= 0x19e0,
> +	RDSAR_Q1_LOW		= 0x4000,
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> @@ -728,6 +733,21 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rx_desc_ring_type {
> +	RX_DESC_RING_TYPE_DEFAULT,
> +	RX_DESC_RING_TYPE_RSS,
> +};
> +
> +struct rtl8169_rx_ring {
> +	u32 index;					/* Rx queue index */
> +	u32 cur_rx;					/* Index of next Rx pkt. */
> +	u32 dirty_rx;					/* Index for recycling. */
> +	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
> +	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
> +	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -735,20 +755,18 @@ struct rtl8169_private {
>  	struct phy_device *phydev;
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
> -	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>  	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>  	u32 dirty_tx;
>  	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
> -	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
>  	dma_addr_t TxPhyAddr;
> -	dma_addr_t RxPhyAddr;
> -	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
>  	struct napi_struct *rtl8169_napi;
> +	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
>  	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	unsigned int hw_supp_num_rx_queues;
>  	unsigned int irq_nvecs;
>  	struct clk *clk;
>  
> @@ -764,6 +782,7 @@ struct rtl8169_private {
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
>  	bool sfp_mode:1;
> +	bool recheck_desc_ownbit:1;

AI bots ask if this needs to be set for all chips or just some specific
version. Also, I think this workaround should be added in a dedicated
commit. For ease of review the introduction of struct rtl8169_rx_ring
should be a code-reshuffling type of commit, rather than a functional
change.

>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;

