Return-Path: <netdev+bounces-191973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF910ABE127
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC3D189CBB1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA60262FE4;
	Tue, 20 May 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRe1cn4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DC1C8603
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759896; cv=none; b=OoemY18oCKKyUALXyLN2y+yGERVOQIqopGWrZQ6ErDHALUap1wyGgAUaKVoxaBzDQAW9NS4DS0aUxMbRPsqqNHfAOyJiNyhGl7rfvXgR7Cc0EZQo5OVUwM7nQoPnJ3WZuFs13jIyW4t99XP5FCJ6RfsCMpk/m7NUFbt9x6gPOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759896; c=relaxed/simple;
	bh=RIvFsrSAEKcALbrSP3XZ7AF+zfNTsFTKYKlJj5IdGAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr8XQqSAN9cgruz8KK+MFEc+3Trpx7EGajMlUNBgNvODJjnIAIwZn61R+7oz1RJdwFp6G20QgFJe1kuWDIf6tMLzwAqq6FQeO8+6ZA0a+56MMZd48IWH1jjWxg2HlkPoFo7hmRhpVT0N4slt1XxQNPh2F/Z4WKSjRqw+RYyfJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRe1cn4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40C6C4CEE9;
	Tue, 20 May 2025 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747759896;
	bh=RIvFsrSAEKcALbrSP3XZ7AF+zfNTsFTKYKlJj5IdGAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRe1cn4J35LbDXudeCOCfTd8DZ2SVbk2zF6UjG2efOAE5t3lY0qfyh/H7zXbBjdRv
	 D9ym/D6SFncaOuDAFbhJO+gU7d2n6w0tj9FFyjr7MraBPHLFKozG0ARBQ72hZibFG8
	 eb6rR9QUVNjcXJ4mqMV0YnGpbrC+SZRlVPYAGPqQvAT7i1fiSgUiIQtMjI0LYMG++Q
	 a8bXOTVIdRcsT823UoZidfxKy7Fju2Ehp21lpSS45Gj2pVZkU7Sis6ulUUETu8NLRp
	 ybFLVI6dGOknZ7EW7aRTBOb87eqUX1abe8KQx94b+eUL2ZQQiZ3NkqOLVOmMcxNloD
	 lQgOAuuCRXZiw==
Date: Tue, 20 May 2025 17:51:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 2/2] net: txgbe: Support the FDIR rules assigned
 to VFs
Message-ID: <20250520165132.GD365796@horms.kernel.org>
References: <20250520063900.37370-1-jiawenwu@trustnetic.com>
 <38C9EBBEE8FCE61E+20250520063900.37370-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38C9EBBEE8FCE61E+20250520063900.37370-2-jiawenwu@trustnetic.com>

On Tue, May 20, 2025 at 02:39:00PM +0800, Jiawen Wu wrote:
> When SR-IOV is enabled, the FDIR rule is supported to filter packets to
> VFs. The action queue id is calculated as an absolute id.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 11 +++++++--
>  .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 23 +++++++++++--------
>  .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +-
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index 78999d484f18..23af099e0a90 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -342,12 +342,19 @@ static int txgbe_add_ethtool_fdir_entry(struct txgbe *txgbe,
>  		queue = TXGBE_RDB_FDIR_DROP_QUEUE;
>  	} else {
>  		u32 ring = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> +		u8 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
>  
> -		if (ring >= wx->num_rx_queues)
> +		if (!vf && ring >= wx->num_rx_queues)
> +			return -EINVAL;
> +		else if (vf && (vf > wx->num_vfs ||
> +				ring >= wx->num_rx_queues_per_pool))
>  			return -EINVAL;
>  
>  		/* Map the ring onto the absolute queue index */
> -		queue = wx->rx_ring[ring]->reg_idx;
> +		if (!vf)
> +			queue = wx->rx_ring[ring]->reg_idx;
> +		else
> +			queue = ((vf - 1) * wx->num_rx_queues_per_pool) + ring;
>  	}
>  
>  	/* Don't allow indexes to exist outside of available space */
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> index ef50efbaec0f..d542c8a5a689 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> @@ -307,6 +307,7 @@ void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
>  int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
>  {
>  	u32 fdirm = 0, fdirtcpm = 0, flex = 0;
> +	int i, j;

It would be nice to have more intuitive variable names than i and j,
which seem more appropriate as names for iterators.

>  
>  	/* Program the relevant mask registers. If src/dst_port or src/dst_addr
>  	 * are zero, then assume a full mask for that field.  Also assume that
> @@ -352,15 +353,17 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
>  	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
>  	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
>  
> -	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
> -	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
> +	i = VMDQ_P(0) / 4;
> +	j = VMDQ_P(0) % 4;
> +	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
> +	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
>  	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
> -		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
> +		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
>  
>  	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
>  	case 0x0000:
>  		/* Mask Flex Bytes */
> -		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK;
> +		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK << (j * 8);
>  		break;
>  	case 0xFFFF:
>  		break;
> @@ -368,7 +371,7 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
>  		wx_err(wx, "Error on flexible byte mask\n");
>  		return -EINVAL;
>  	}
> -	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
> +	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
>  
>  	/* store the TCP/UDP port masks, bit reversed from port layout */
>  	fdirtcpm = ntohs(input_mask->formatted.dst_port);
> @@ -516,14 +519,16 @@ static void txgbe_fdir_enable(struct wx *wx, u32 fdirctrl)
>  static void txgbe_init_fdir_signature(struct wx *wx)
>  {
>  	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
> +	int i = VMDQ_P(0) / 4;
> +	int j = VMDQ_P(0) % 4;

Ditto.

>  	u32 flex = 0;
>  
> -	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
> -	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
> +	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
> +	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
>  
>  	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
> -		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
> -	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
> +		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
> +	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
>  
>  	/* Continue setup of fdirctrl register bits:
>  	 *  Move the flexible bytes to use the ethertype - shift 6 words
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index 261a83308568..094d55cdb86c 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -272,7 +272,7 @@ struct txgbe_fdir_filter {
>  	struct hlist_node fdir_node;
>  	union txgbe_atr_input filter;
>  	u16 sw_idx;
> -	u16 action;
> +	u64 action;
>  };
>  
>  /* TX/RX descriptor defines */
> -- 
> 2.48.1
> 
> 

