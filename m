Return-Path: <netdev+bounces-196524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8434AD51E5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E371BC13E2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B9269808;
	Wed, 11 Jun 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fRSPguXx"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0F268C5D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637798; cv=none; b=HD+DDx7ouQoGwRn1f2dsIwQUv3g3BMcwmV10LAi5zWq7MmK9RcOmjRR64Yn/T9Vg/IiPgqhH6y3AgDLZiVArIM+4iEzMfvoLUX9uaQ6BY4Htc/TipLxtj6cM2ZOExC7jPMCPl6TzGGeEVMH5mDwiuigoC89lVtjjZMfoC6B+MW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637798; c=relaxed/simple;
	bh=YlHXxMugl9yjOiNKeFUjiSUYbzIfe6d6gCIYXllOlIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hsk+e0gIqp7He1uUCTvDsWcvg0SfKPNZm1JiPCJHgTmA0Cgt7Wpc456LpzXFyUS8nRWBamA/CP9Z94F11xyB7GQvLk1f9nt4q0JTDjbp4csuaaxeSVg3NXCngNwj26UCTlYXL6tahAj8sv554EjR0/ylRaOT+eS1tiU5QknGLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fRSPguXx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdcd54ff-ff67-4ad8-8aa7-baa711928242@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749637792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsD0r2ubczrvxe7E6Hz3oR1VDIOnDQXAzS4kwGFiDY0=;
	b=fRSPguXxdP+bxFKXzw8IXPvBDS7PNhulrJ5AKNaVBxE/HU5Sy8+bASY2d9tYSO8RYqBZ9Y
	OpqAXd/4ejqf/HgKyaGjLGSfkBizkMG/JrEgEFI7RHEL4hePKPX68ihcfBIQpWBtJrwZle
	LX45PMC+xyaBy+CAu+fxUDRdbDXZk9s=
Date: Wed, 11 Jun 2025 11:29:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 06/11] net: ti: prueth: Adds HW timestamping
 support for PTP using PRU-ICSS IEP module
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
 rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ssantosh@kernel.org,
 richardcochran@gmail.com, s.hauer@pengutronix.de, m-karicheri2@ti.com,
 glaroque@baylibre.com, afd@ti.com, saikrishnag@marvell.com,
 m-malladi@ti.com, jacob.e.keller@intel.com, diogo.ivo@siemens.com,
 javier.carrasco.cruz@gmail.com, horms@kernel.org, s-anna@ti.com,
 basharath@couthit.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pratheesh@ti.com,
 prajith@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
References: <20250610105721.3063503-1-parvathi@couthit.com>
 <20250610123245.3063659-7-parvathi@couthit.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250610123245.3063659-7-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/06/2025 13:32, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> PRU-ICSS IEP module, which is capable of timestamping RX and
> TX packets at HW level, is used for time synchronization by PTP4L.
> 
> This change includes interaction between firmware and user space
> application (ptp4l) with required packet timestamps. The driver
> initializes the PRU firmware with appropriate mode and configuration
> flags. Firmware updates local registers with the flags set by driver
> and uses for further operation. RX SOF timestamp comes along with
> packet and firmware will rise interrupt with TX SOF timestamp after
> pushing the packet on to the wire.
> 
> IEP driver is available in upstream and we are reusing for hardware
> configuration for ICSSM as well. On top of that we have extended it
> with the changes for AM57xx SoC.
> 
> Extended ethtool for reading HW timestamping capability of the PRU
> interfaces.
> 
> Currently ordinary clock (OC) configuration has been validated with
> Linux ptp4l.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>   drivers/net/ethernet/ti/icssg/icss_iep.c      |  42 ++
>   drivers/net/ethernet/ti/icssm/icssm_ethtool.c |  23 +
>   drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 443 +++++++++++++++++-
>   drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  11 +
>   .../net/ethernet/ti/icssm/icssm_prueth_ptp.h  |  85 ++++
>   5 files changed, 602 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h

[...]

> @@ -732,9 +949,22 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
>   		src_addr += actual_pkt_len;
>   	}
>   
> +	if (pkt_info->timestamp) {
> +		src_addr = (void *)PTR_ALIGN((uintptr_t)src_addr,
> +					   ICSS_BLOCK_SIZE);
> +		dst_addr = &ts;
> +		memcpy(dst_addr, src_addr, sizeof(ts));
> +	}
> +
>   	if (!pkt_info->sv_frame) {
>   		skb_put(skb, actual_pkt_len);
>   
> +		if (icssm_prueth_ptp_rx_ts_is_enabled(emac) &&
> +		    pkt_info->timestamp) {
> +			ssh = skb_hwtstamps(skb);
> +			memset(ssh, 0, sizeof(*ssh));
> +			ssh->hwtstamp = ns_to_ktime(ts);
> +		}
>   		/* send packet up the stack */
>   		skb->protocol = eth_type_trans(skb, ndev);
>   		netif_receive_skb(skb);

Could you please explain why do you need to copy timestamp to a
temporary variable if you won't use it in some cases? I believe these
2 blocks should be placed under the last if condition and simplified a
bit, like

+		if (icssm_prueth_ptp_rx_ts_is_enabled(emac) &&
+		    pkt_info->timestamp) {
+			src_addr = (void*)PTR_ALIGN((uintptr_t)src_addr,
+					   ICSS_BLOCK_SIZE);
+			memcpy(&ts, src_addr, sizeof(ts));
+			ssh = skb_hwtstamps(skb);
+			ssh->hwtstamp = ns_to_ktime(ts);
+		}

This will avoid useless copy when the packet will be dropped anyway, WDYT?

