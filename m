Return-Path: <netdev+bounces-192661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACBBAC0BBE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18334A378C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6928A71F;
	Thu, 22 May 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2isxQl6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A32135CB;
	Thu, 22 May 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917558; cv=none; b=r5PYoVYEwIioO0z4ilVRovzgfTb+uR4tZKYLgdfyCzZfw5mYyGv4xUj2Amd3fvRW9GBjrFEXGK41Pasuuxa5BscPGRh/6YhhCqelmEoTsm+4CLM+zsdQ50Yl1Wdgfn/xJ/rCgscmFqO4WsOrlWKEEwMz7iZ49Pe70ZhjwpNzax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917558; c=relaxed/simple;
	bh=PhT/kTDZ6gQ7sTz8kUJc4VzJgyedIPTFsuit5uZDo4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI6QE/ffak6Vbj1Atsn8XGYCJtCB33hR6fezlmjsU1m84sCehd6kKvfmJyaotaLfPcDYwFhboMpYG7F2DrYlIL1GCH37l3NIf7/QLJS5HF85voWDbTGVdMX8Ma0HjLVhbmnn66JZO+WOHYiVlOL7wh6adZV6PsPxVTOthrACUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2isxQl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B33DC4CEE4;
	Thu, 22 May 2025 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747917557;
	bh=PhT/kTDZ6gQ7sTz8kUJc4VzJgyedIPTFsuit5uZDo4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2isxQl6r8sUX5xpsDxRunTHmHRVNWyU9cAKqdbZEcCbwd0ps+hz/uT/ck6H/2UaT
	 GS7dDM7D9L0iISXSWRH5+14/spcvMLnJY9zkeaobZb5iqjf1LAEjfK8KURSyX5ftW0
	 5xk8hYRHFi2C1Zkj1KuN+B7rPcNSNAK2OXgTPByNFo1WsOV/STGK3L3r8+J+ELgDCW
	 IBFTB2flFVVQZ71zQ0lLG4UM7kRX+TYTX6pMLe/mXXK/9cgVV+qd2/AFK+ryIKkn8V
	 ifIlwpMpo3+wlNcwnN/j6ZXwFHQjuufmKuMo1S88igw/Y6WNKZqKV17ZshuLAaPMvs
	 vaFQsjag0kQbw==
Date: Thu, 22 May 2025 13:39:13 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: airoha: Add the capability to
 allocate hfwd descriptors in SRAM
Message-ID: <20250522123913.GY365796@horms.kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
 <20250521-airopha-desc-sram-v3-4-a6e9b085b4f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-airopha-desc-sram-v3-4-a6e9b085b4f0@kernel.org>

On Wed, May 21, 2025 at 09:16:39AM +0200, Lorenzo Bianconi wrote:
> In order to improve packet processing and packet forwarding
> performances, EN7581 SoC supports consuming SRAM instead of DRAM for
> hw forwarding descriptors queue.
> For downlink hw accelerated traffic request to consume SRAM memory
> for hw forwarding descriptors queue.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 11 +----------
>  drivers/net/ethernet/airoha/airoha_eth.h |  9 +++++++++
>  drivers/net/ethernet/airoha/airoha_ppe.c |  6 ++++++
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 20e590d76735e72a1a538a42d2a1f49b882deccc..3cd56de716a5269b1530cff6d0ca3414d92ecb69 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -71,15 +71,6 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
>  	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>  }
>  
> -static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
> -{
> -	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> -	 * GDM{2,3,4} can be used as wan port connected to an external
> -	 * phy module.
> -	 */
> -	return port->id == 1;
> -}
> -
>  static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
>  {
>  	struct airoha_eth *eth = port->qdma->eth;
> @@ -1128,7 +1119,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
>  			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
>  			HW_FWD_DESC_NUM_MASK,
>  			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
> -			LMGR_INIT_START);
> +			LMGR_INIT_START | LMGR_SRAM_MODE_MASK);

Hi Lorenzo,

I'm wondering if setting the LMGR_SRAM_MODE_MASK bit (maybe a different
name for the #define would be nice) is dependent on the SRAM region
being described in DT, as per code added above this line to this
function by the previous patch in this series.

>  
>  	return read_poll_timeout(airoha_qdma_rr, status,
>  				 !(status & LMGR_INIT_START), USEC_PER_MSEC,
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index 3e03ae9a5d0d21c0d8d717f2a282ff06ef3b9fbf..b815697302bfdf2a6d115a9bbbbadc05462dbadb 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -597,6 +597,15 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
>  #define airoha_qdma_clear(qdma, offset, val)			\
>  	airoha_rmw((qdma)->regs, (offset), (val), 0)
>  
> +static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
> +{
> +	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> +	 * GDM{2,3,4} can be used as wan port connected to an external
> +	 * phy module.
> +	 */
> +	return port->id == 1;
> +}
> +
>  bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
>  			      struct airoha_gdm_port *port);
>  
> diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> index 2d273937f19cf304ab4b821241fdc3ea93604f0e..12d32c92717a6b4ba74728ec02bb2e166d4d9407 100644
> --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> @@ -251,6 +251,12 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
>  		else
>  			pse_port = 2; /* uplink relies on GDM2 loopback */
>  		val |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port);
> +
> +		/* For downlink traffic consume SRAM memory for hw forwarding
> +		 * descriptors queue.
> +		 */
> +		if (airhoa_is_lan_gdm_port(port))
> +			val |= AIROHA_FOE_IB2_FAST_PATH;
>  	}
>  
>  	if (is_multicast_ether_addr(data->eth.h_dest))
> 
> -- 
> 2.49.0
> 
> 

