Return-Path: <netdev+bounces-198701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CAADD11F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF223AB9AC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D502E972B;
	Tue, 17 Jun 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StrN1Zw5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA712E88B1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173114; cv=none; b=l1hIWR7dYZs8VjFAE4AC2ZbEgHKVmYEOGDkTZTsnf2n6/55CrshiwlHU5UGlivenxbQ3/E1oL4urZHNCj7D2Ap81ekYGsReePNP8lszcTEiELeKXp/Qi48xqULsEbPZEq+WwUV6vtrZQVColh1ItBH2af7QAptt0ROX1uHYFleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173114; c=relaxed/simple;
	bh=yBk/hB/A5C/xZQ12ojP/bpDCKY6cbtGBKyb6z7Jwi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMqJFYy25+1T5EOvOqKE8HAGG76s/kqsZqZDAcRFG0h6DWvRPyIe/a1Fu438Q1YSfJx4u+1yY/83AMfYeZeWAy73jt2/to9D84ASHQWZSZvZy1Tg37605Xcf/5j1WjELJNGYxfbjjO833fhl9c0UVoFxF2bumbh1ouEQNP/Mjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StrN1Zw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C210C4CEE7;
	Tue, 17 Jun 2025 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750173114;
	bh=yBk/hB/A5C/xZQ12ojP/bpDCKY6cbtGBKyb6z7Jwi18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=StrN1Zw54qnx1043U4Gfec7pDpcFX/XahuRp3+OObA/iYqJOIyaidua5Dpe0osMXj
	 oMU67ZkYZGfa23xgZ+SYU7t7o9SW5Ku9yqJQh4z5U1Y4kD+fvTvBJwffrjcE8w+Llw
	 5YTk+HukuxM8YqXaFEUYAoV1dbhFwR0AjVkF3GSmQGU5ASP1cctzCuvByjVULflj+L
	 oJk6Rgb/3Zds8/BmmLCpxLiWmgNnPkwLyyZoe4/XPSaT02TepHOGj1GR9qoCCi3YGZ
	 yTOI/qTxPyqiRCCIUFox45NYrOcARf7LlQl6mMpdqb9ad6J/tNccF056rxSzVHgyok
	 7ZPPfTdHBg7EA==
Date: Tue, 17 Jun 2025 16:11:50 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com, jiawenwu@net-swift.com
Subject: Re: [PATCH net-next 03/12] net: libwx: add wangxun vf common api
Message-ID: <20250617151150.GL5000@horms.kernel.org>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
 <20250611083559.14175-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611083559.14175-4-mengyuanlou@net-swift.com>

On Wed, Jun 11, 2025 at 04:35:50PM +0800, Mengyuan Lou wrote:
> Add common wx_configure_vf and wx_set_mac_vf for
> ngbevf and txgbevf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h

...

> +#define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
> +#define WX_VXMRQC_PSR_MASK       GENMASK(5, 1)
> +#define WX_VXMRQC_PSR_L4HDR      BIT(0)
> +#define WX_VXMRQC_PSR_L3HDR      BIT(1)
> +#define WX_VXMRQC_PSR_L2HDR      BIT(2)
> +#define WX_VXMRQC_PSR_TUNHDR     BIT(3)
> +#define WX_VXMRQC_PSR_TUNMAC     BIT(4)

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c

...

> +/**
> + * wx_configure_tx_ring_vf - Configure Tx ring after Reset
> + * @wx: board private structure
> + * @ring: structure containing ring specific data
> + *
> + * Configure the Tx descriptor ring after a reset.
> + **/
> +static void wx_configure_tx_ring_vf(struct wx *wx, struct wx_ring *ring)
> +{
> +	u8 reg_idx = ring->reg_idx;
> +	u64 tdba = ring->dma;
> +	u32 txdctl = 0;
> +	int ret;
> +
> +	/* disable queue to avoid issues while updating state */
> +	wr32(wx, WX_VXTXDCTL(reg_idx), WX_VXTXDCTL_FLUSH);
> +	wr32(wx, WX_VXTDBAL(reg_idx), tdba & DMA_BIT_MASK(32));
> +	wr32(wx, WX_VXTDBAH(reg_idx), tdba >> 32);
> +
> +	/* enable relaxed ordering */
> +	pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
> +					   0, PCI_EXP_DEVCTL_RELAX_EN);
> +
> +	/* reset head and tail pointers */
> +	wr32(wx, WX_VXTDH(reg_idx), 0);
> +	wr32(wx, WX_VXTDT(reg_idx), 0);
> +	ring->tail = wx->hw_addr + WX_VXTDT(reg_idx);
> +
> +	/* reset ntu and ntc to place SW in sync with hardwdare */

nit: hardware

> +	ring->next_to_clean = 0;
> +	ring->next_to_use = 0;
> +
> +	txdctl |= WX_VXTXDCTL_BUFLEN(wx_buf_len(ring->count));
> +	txdctl |= WX_VXTXDCTL_ENABLE;
> +
> +	/* set WTHRESH to encourage burst writeback, it should not be set
> +	 * higher than 1 when ITR is 0 as it could cause false TX hangs
> +	 *
> +	 * In order to avoid issues WTHRESH + PTHRESH should always be equal
> +	 * to or less than the number of on chip descriptors, which is
> +	 * currently 40.
> +	 */
> +	/* reinitialize tx_buffer_info */
> +	memset(ring->tx_buffer_info, 0,
> +	       sizeof(struct wx_tx_buffer) * ring->count);
> +
> +	wr32(wx, WX_VXTXDCTL(reg_idx), txdctl);
> +	/* poll to verify queue is enabled */
> +	ret = read_poll_timeout(rd32, txdctl, txdctl & WX_VXTXDCTL_ENABLE,
> +				1000, 10000, true, wx, WX_VXTXDCTL(reg_idx));
> +	if (ret == -ETIMEDOUT)
> +		wx_err(wx, "Could not enable Tx Queue %d\n", reg_idx);
> +}

...

> +void wx_setup_psrtype_vf(struct wx *wx)
> +{
> +	/* PSRTYPE must be initialized */
> +	u32 psrtype = WX_VXMRQC_PSR_L2HDR |
> +		      WX_VXMRQC_PSR_L3HDR |
> +		      WX_VXMRQC_PSR_L4HDR |
> +		      WX_VXMRQC_PSR_TUNHDR |
> +		      WX_VXMRQC_PSR_TUNMAC;
> +
> +	if (wx->num_rx_queues > 1)
> +		psrtype |= BIT(14);

Here bit 14 of psrtype may be set (what is bit 14?).

> +
> +	wr32m(wx, WX_VXMRQC, WX_VXMRQC_PSR_MASK, WX_VXMRQC_PSR(psrtype));

But WX_VXMRQC_PSR() uses a mask that limits psrtype to 5 bits.

This is flagged by W=1 builds with gcc-8.5.0 on x86_64
(but curiously not gcc-15.1.0 builds). It is flagged like this:

  CC [M]  drivers/net/ethernet/wangxun/libwx/wx_vf_lib.o
In file included from <command-line>:
drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c: In function 'wx_setup_psrtype_vf':
././include/linux/compiler_types.h:568:38: error: call to '__compiletime_assert_1833' declared with attribute error: FIELD_PREP: value too large for the field
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
././include/linux/compiler_types.h:549:4: note: in definition of macro '__compiletime_assert'
    prefix ## suffix();    \
    ^~~~~~
././include/linux/compiler_types.h:568:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
   ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:115:3: note: in expansion of macro '__BF_FIELD_CHECK'
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
drivers/net/ethernet/wangxun/libwx/wx_vf.h:73:34: note: in expansion of macro 'FIELD_PREP'
 #define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
                                  ^~~~~~~~~~
drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c:195:43: note: in expansion of macro 'WX_VXMRQC_PSR'
  wr32m(wx, WX_VXMRQC, WX_VXMRQC_PSR_MASK, WX_VXMRQC_PSR(psrtype));
                                           ^~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:203:
drivers/net/ethernet/wangxun/libwx/wx_vf_lib.o] Error 1:

> +}

...

> +void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring)
> +{
> +	u8 reg_idx = ring->reg_idx;
> +	union wx_rx_desc *rx_desc;
> +	u64 rdba = ring->dma;
> +	u32 rxdctl;
> +
> +	/* disable queue to avoid issues while updating state */
> +	rxdctl = rd32(wx, WX_VXRXDCTL(reg_idx));
> +	wx_disable_rx_queue(wx, ring);
> +
> +	wr32(wx, WX_VXRDBAL(reg_idx), rdba & DMA_BIT_MASK(32));
> +	wr32(wx, WX_VXRDBAH(reg_idx), rdba >> 32);
> +
> +	/* enable relaxed ordering */
> +	pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
> +					   0, PCI_EXP_DEVCTL_RELAX_EN);
> +
> +	/* reset head and tail pointers */
> +	wr32(wx, WX_VXRDH(reg_idx), 0);
> +	wr32(wx, WX_VXRDT(reg_idx), 0);
> +	ring->tail = wx->hw_addr + WX_VXRDT(reg_idx);
> +
> +	/* initialize rx_buffer_info */
> +	memset(ring->rx_buffer_info, 0,
> +	       sizeof(struct wx_rx_buffer) * ring->count);
> +
> +	/* initialize Rx descriptor 0 */
> +	rx_desc = WX_RX_DESC(ring, 0);
> +	rx_desc->wb.upper.length = 0;
> +
> +	/* reset ntu and ntc to place SW in sync with hardwdare */

nit: hardware

> +	ring->next_to_clean = 0;
> +	ring->next_to_use = 0;
> +	ring->next_to_alloc = 0;
> +
> +	wx_configure_srrctl_vf(wx, ring, reg_idx);
> +
> +	/* allow any size packet since we can handle overflow */
> +	rxdctl &= ~WX_VXRXDCTL_BUFLEN_MASK;
> +	rxdctl |= WX_VXRXDCTL_BUFLEN(wx_buf_len(ring->count));
> +	rxdctl |= WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;
> +
> +	/* enable RSC */
> +	rxdctl &= ~WX_VXRXDCTL_RSCMAX_MASK;
> +	rxdctl |= WX_VXRXDCTL_RSCMAX(0);
> +	rxdctl |= WX_VXRXDCTL_RSCEN;
> +
> +	wr32(wx, WX_VXRXDCTL(reg_idx), rxdctl);
> +
> +	/* pf/vf reuse */
> +	wx_enable_rx_queue(wx, ring);
> +	wx_alloc_rx_buffers(ring, wx_desc_unused(ring));
> +}
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
> new file mode 100644
> index 000000000000..43ea126b79eb
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
> +
> +#ifndef _WX_VF_LIB_H_
> +#define _WX_VF_LIB_H_
> +
> +void wx_configure_msix_vf(struct wx *wx);
> +int wx_write_uc_addr_list_vf(struct net_device *netdev);
> +void wx_setup_psrtype_vf(struct wx *wx);
> +void wx_setup_vfmrqc_vf(struct wx *wx);
> +void wx_configure_tx_vf(struct wx *wx);
> +void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring);
> +
> +#endif /* _WX_VF_LIB_H_ */
> -- 
> 2.30.1
> 

