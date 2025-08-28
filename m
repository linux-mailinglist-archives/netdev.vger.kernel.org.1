Return-Path: <netdev+bounces-217655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340FB39706
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DA418908AD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79292DE1FE;
	Thu, 28 Aug 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="CMRJJUQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDC27A927;
	Thu, 28 Aug 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369908; cv=none; b=p98QCBRYbOAIubvWgEV5Mi75Mw4MoSf+GtCTSC3Z+QbdP6A8+bLgt7aGfnCzZ76jDKfKLFFJuTocB9TagRmmJKUCemaZT5Vgu7wCgZ9GjvNjaGQKwj0bWtvRssT2v2kxhxjyzh7cZPoM4DrxN5qCsmrlcg4VRLK5PfvbXKxt5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369908; c=relaxed/simple;
	bh=OH+tiuZhRc7zBGjnfTEQrtm5HNLz2ea/O1IUH/tbp4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjFufEbfDh2ZwTPoaaMUSdPhNaETeZGqMVrn9P/ButxzEF1IXlJ7pR+53QdRAjUlbLtKyS9JcCww/ajQnZkgVsDlvgvjkeJf4LSfoHaWF2VZbOO0TgQ31wyvQLTIPff4xR8/TVCgjkJD+VuPd2cUDZpBamfVHDVtH8IxppdvWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=CMRJJUQ3; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756369896;
	bh=31kdvkUcjKbhPvlFzt+kjJ6mau02w/DFORYHNaO+fTQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=CMRJJUQ3dN4GSfAF0FsiEkYszHcNgQGbL3yqPY0/auNs3YpBFqn2qaoX1cZnpNEgs
	 CGZzy0qVCEPQo1oNDg4chqymbIjZGabGoTva7YkkGCIm7wSicXUCJtXQ/hndgCVRIH
	 H/7mC9ugGjgJGk2h4UequIJQzLOkdscyDqhtubjM=
X-QQ-mid: zesmtpsz3t1756369894taa63037f
X-QQ-Originating-IP: 74a9wFgC2VtntaDe04tPl510lmwJye9e6Dxfwjn/SmU=
Received: from = ( [14.123.253.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 28 Aug 2025 16:31:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16767505359158184548
EX-QQ-RecipientCnt: 26
Date: Thu, 28 Aug 2025 16:31:31 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/5] net: spacemit: Add K1 Ethernet MAC
Message-ID: <D1B3E8CA05947AC1+aLAT40m4VCtlL2Yk@LT-Guozexi>
References: <20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn>
 <20250826-net-k1-emac-v7-2-5bc158d086ae@iscas.ac.cn>
 <193454B6B44560D1+aK-x9J2EIB5aA9yr@LT-Guozexi>
 <6c221dcf-4310-4e31-b3e8-a8a3b68c3734@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c221dcf-4310-4e31-b3e8-a8a3b68c3734@iscas.ac.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MExkIg7Bfu69z7AfItWMTNu1jYT6WkMpE/y15+NVNxHnru1+wpOx879x
	4m0FKPPDyALE7dSqsVMGepCmiZUY1aELXFky+XWFh2keLBV0aQCLLrWbz4LQdfibB9LOM13
	Qtb1c8D4p9j45/wlKkLbnP+upD/jQyiDTHggXxSKR0Tw7ObdgvJpmURaHKlLLAE7FT8fMwc
	lcg03Po6AyHtOcQqANBnGIYLNJ79N6TK9ohUdNF597FmZM53QsO8zcXEp+nSDfS5gvkR6yf
	u9Awxyp+9RH69nri6GT7JK90tipaJVadwAbPlZaYeHwI+rh/V6swNMNt/GS25XDcuRisKjF
	g6HqfMRZC/Td5WaeeZlFLGupVjJc/gyQGPFAVlOais6lPvFgE/MyUalBXAy0AitQBxfXCX/
	N0c23KrkRaPL6aqBJoVOHlL25TT5q9ezC+qQVJlU/nVxmlssxqua4D5gODocfGt6vQJ+Bxu
	sjySJ+LH3fJw9LEMMc4RwcX5lddyfdJvwSoG8ZtDGgRvf3s1IPYAYlzPw+QWY5kQDeOOE2C
	xSSRrJa1/7RKXIaidVjchXxcAMtVVLXlsTZ+CPIVroZKYMhqzN3BngZ4xBH8lUyslNiKvFY
	2uTswIahFlKoatI5Rm/0BNkPQKbXkGDWJCcnVoIPPBoBIXu2vzHIcn7r22m3/HJmrBSG7Ck
	lpYS7l5zDiPni/kBIj/sLdOjD695SFvrkdT562Sx/+z0jIAHDWeIzHLotcThMbTtKq3JQEy
	U2VmJcIW1YkwPbh4IwkFnLVd6EFYH2AjuRcjpYuoCnzK+Sr5xjV7CRlO/3rGkdKbohi7HVv
	OEpzzMRyIsefEYfcu3b3h6zR3l7RX51IcbpMZ3xicNb4fEmIIsWatB7sOAaOPdNy0BNiO4r
	cpoVXzeKvY/VCkuSWQAnIfHrfx9seLmxL3m2aUtMFE83mmpBVBLVRwmaNZyzVYnmfZdpjnq
	bsxrnYp6ls9jngqejQTlEjOlnB92wjXzBK+Rsfk85uWU0eHR1cSmSXu0B8w8PHzg9QMR6aA
	m+o6EzwKmNoYwVBKv70pi6mFBxx4J4YS/yKs04B2ASC0oVaSAoD4zu5fQ/mPpIeieA0fzhC
	tTjgUYrqQcziXcHV/7BwaV+bGW80NooEBYvtvyzmr3D
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 04:06:58PM +0800, Vivian Wang wrote:
> Hi Troy,
> 
> On 8/28/25 09:33, Troy Mitchell wrote:
> > On Tue, Aug 26, 2025 at 02:23:47PM +0800, Vivian Wang wrote:
> >> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> >> that only superficially resembles some other embedded MACs. SpacemiT
> >> refers to them as "EMAC", so let's just call the driver "k1_emac".
> >>
> >> Supports RGMII and RMII interfaces. Includes support for MAC hardware
> >> statistics counters. PTP support is not implemented.
> >>
> >> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> >> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> >> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> >> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >> ---
> > Hi Vivian,
> > I have tested your patch on MUSE-PI.
> > So here:
> >
> > Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >
> > But I still have a minor style comment on the code.
> Thanks for your Tested-by and review.
> >>  drivers/net/ethernet/Kconfig            |    1 +
> >>  drivers/net/ethernet/Makefile           |    1 +
> >>  drivers/net/ethernet/spacemit/Kconfig   |   29 +
> >>  drivers/net/ethernet/spacemit/Makefile  |    6 +
> >>  drivers/net/ethernet/spacemit/k1_emac.c | 2193 +++++++++++++++++++++++++++++++
> >>  drivers/net/ethernet/spacemit/k1_emac.h |  426 ++++++
> >>  6 files changed, 2656 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..9e558d5893cfbbda0baa7ad21a7209dadda9487e
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> >> @@ -0,0 +1,2193 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * SpacemiT K1 Ethernet driver
> >> + *
> >> + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> >> + * Copyright (C) 2025 Vivian Wang <wangruikang@iscas.ac.cn>
> >> + */
> >> +
> > [...]
> >> +
> >> +static void emac_wr(struct emac_priv *priv, u32 reg, u32 val)
> >> +{
> >> +	writel(val, priv->iobase + reg);
> >> +}
> > basically short and obvious code like this:
> >
> > writel(val, priv->iobase + reg)
> >
> > you replace:
> >
> > emac_wr(priv, reg, val)
> >
> > It's not helpful..You could just use writel/readl directly
> >> +
> >> +static int emac_rd(struct emac_priv *priv, u32 reg)
> >> +{
> >> +	return readl(priv->iobase + reg);
> >> +}
> > ditto.
> 
> I have decided against inlining these wrappers.
> 
> Firstly, the wrappers being mostly trivial is not it being "not
> helpful". In long blocks of register access code, especially, having
> just emac_rd(priv,...) or emac_wr(priv,...) repeated is easier to
> recognize and harder to mess up (e.g. precedence of "priv->iomem + ...").
> 
> Secondly, they serve as documentation that a normal register access for
> this driver is a 32-bit read or write. This is despite the fact that the
> registers all "look like" they each only have the low 16 bits.
Alright, you’ve convinced me.
I did wrap it like this before, but it was opposed—I guess it really depends on
whether the maintainer likes it.

[...]
> >> +static void emac_free_tx_buf(struct emac_priv *priv, int i)
> >> +{
> >> +	struct emac_tx_desc_buffer *tx_buf;
> >> +	struct emac_desc_ring *tx_ring;
> >> +	struct desc_buf *buf;
> >> +	int j;
> >> +
> >> +	tx_ring = &priv->tx_ring;
> >> +	tx_buf = &tx_ring->tx_desc_buf[i];
> >> +
> >> +	for (j = 0; j < 2; j++) {
> >> +		buf = &tx_buf->buf[j];
> >> +		if (buf->dma_addr) {
> >> +			if (buf->map_as_page)
> >> +				dma_unmap_page(&priv->pdev->dev, buf->dma_addr,
> >> +					       buf->dma_len, DMA_TO_DEVICE);
> >> +			else
> >> +				dma_unmap_single(&priv->pdev->dev,
> >> +						 buf->dma_addr, buf->dma_len,
> >> +						 DMA_TO_DEVICE);
> >> +
> >> +			buf->dma_addr = 0;
> >> +			buf->map_as_page = false;
> >> +			buf->buff_addr = NULL;
> >> +		}
> > if (!buf->dma_addr)
> >   continue;
> >
> > Best regards,
> > Troy
> You tricked me! There's one more review comment below :P
Haha, You are so cute, Vivian.
I'm surprised you were able to find it, because I went back to check after
writing the last comment. So I wasn't able to find the final one myself.

                - Troy

(This really is the final one this time.)
> >> +	}
> >> +
> >> +	if (tx_buf->skb) {
> >> +		dev_kfree_skb_any(tx_buf->skb);
> >> +		tx_buf->skb = NULL;
> >> +	}
> >> +}
> >> +
> >> +static void emac_clean_tx_desc_ring(struct emac_priv *priv)
> >> +{
> >> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
> >> +	u32 i;
> >> +
> >> +	/* Free all the TX ring skbs */
> >> +	for (i = 0; i < tx_ring->total_cnt; i++)
> >> +		emac_free_tx_buf(priv, i);
> >> +
> >> +	tx_ring->head = 0;
> >> +	tx_ring->tail = 0;
> >> +}
> >> +
> >> +static void emac_clean_rx_desc_ring(struct emac_priv *priv)
> >> +{
> >> +	struct emac_rx_desc_buffer *rx_buf;
> >> +	struct emac_desc_ring *rx_ring;
> >> +	u32 i;
> >> +
> >> +	rx_ring = &priv->rx_ring;
> >> +
> >> +	/* Free all the RX ring skbs */
> >> +	for (i = 0; i < rx_ring->total_cnt; i++) {
> >> +		rx_buf = &rx_ring->rx_desc_buf[i];
> >> +		if (rx_buf->skb) {
> >> +			dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
> >> +					 rx_buf->dma_len, DMA_FROM_DEVICE);
> >> +
> >> +			dev_kfree_skb(rx_buf->skb);
> >> +			rx_buf->skb = NULL;
> >> +		}
> > if (!rx_buf->skb)
> >   continue;
> 
> I will change both of these to "if (...) continue;" in the next version.
> 
> Thanks,
> Vivian "dramforever" Wang
> 
> 

