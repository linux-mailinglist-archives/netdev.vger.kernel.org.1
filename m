Return-Path: <netdev+bounces-204178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A012AF9603
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CAB3ADFF9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA541917E3;
	Fri,  4 Jul 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G10m6TVa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750C143748
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640707; cv=none; b=VHWWZCG0TIQA6V5qWRwJq7C9exjrKlNRVEXxpXO56jLFzjzHDVrjP+7F0N4J+Mck4BPF5Hc3yZUD8BlvUGmq4ueJuaXTHoRsWynxbnY8DCXfZOCvdQ1Rq6L+KTcSdv5NnQjsaYUupEbJen/b7kERKkuoV/N5S6f54tjHQx11CS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640707; c=relaxed/simple;
	bh=x/SPuDR5dCceYdymmi7HSKx5gSWYnMZYMNh8Fp3FPHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+NB0X8ymjlTbjq3/s9CSlm2+z0+9Urpu0pugo9GXPby9qJ2iUiBtwdiTpNZ/THz6EayOB4oC6FrWTBPmLLiVqODmWhjicfsLeJnegxjXt92WAJttx2qWLGa7LlcNiQXqz0pHy7phk+K3zqsejgkonOQdyM3IEAIlykX8yifVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G10m6TVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13947C4CEE3;
	Fri,  4 Jul 2025 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751640707;
	bh=x/SPuDR5dCceYdymmi7HSKx5gSWYnMZYMNh8Fp3FPHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G10m6TVaSOe5n19bVJaivBNn8I8b5BMUm2+9r9UtGG82YpPiKKQiCtsZChJA30efn
	 2cdpuvcLynYts1WeYRcDQmqB80zlFXgHpnWTTviBy+imm4OdnoRJ37+2G+qweiFD3e
	 X8Zr1Xeo6lDPF9zpSUFaKz6yCiV1PzDyvqhk/3qGPhHdXCqYZj8jx9Vi0DFa3TmnOj
	 0JBVVxBBYRFnqxfdphu7hixIqrSUmmMO5J/Fu5AqaUT4NLsWjQFmn/Pggi7dBFHH8G
	 lOwKD4JLYwyKOzwq6ihN3MiOw505ZNX6Yg6IR3FRw4qNSHaWZ9ZhZzzrROepCafCjc
	 cYkTVz/A6G7+Q==
Date: Fri, 4 Jul 2025 15:51:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: airoha: npu: Add more wlan NPU
 callbacks
Message-ID: <20250704145142.GA41770@horms.kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-2-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-2-803009700b38@kernel.org>

On Wed, Jul 02, 2025 at 12:23:31AM +0200, Lorenzo Bianconi wrote:
> Introduce more NPU wlan callbacks used by wlan driver (MT76) to initialize
> NPU module register for offloading wireless-wired offloading.
> This is a preliminary patch to enable wlan flowtable offload for EN7581
> SoC with MT76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
> index 242f0d15b2f7c262daaf7bb78ee386ccc8a0433d..9fdec469e7b0e7caa5d988dfd78578d860a0e66d 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.h
> +++ b/drivers/net/ethernet/airoha/airoha_npu.h
> @@ -30,6 +30,27 @@ struct airoha_npu {
>  					    u32 entry_size, u32 hash,
>  					    bool ppe2);
>  		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
> +		int (*wlan_set_txrx_reg_addr)(struct airoha_npu *npu,
> +					      int ifindex, u32 dir,
> +					      u32 in_counter_addr,
> +					      u32 out_status_addr,
> +					      u32 out_counter_addr);
> +		int (*wlan_set_pcie_port_type)(struct airoha_npu *npu,
> +					       int ifindex, u32 port_type);
> +		int (*wlan_set_pcie_addr)(struct airoha_npu *npu, int ifindex,
> +					  u32 addr);
> +		int (*wlan_set_desc)(struct airoha_npu *npu, int ifindex,
> +				     u32 desc);
> +		int (*wlan_set_tx_ring_pcie_addr)(struct airoha_npu *npu,
> +						  int ifindex, u32 addr);
> +		int (*wlan_get_rx_desc_base)(struct airoha_npu *npu,
> +					     int ifindex, u32 *data);
> +		int (*wlan_set_tx_buf_space_base)(struct airoha_npu *npu,
> +						  int ifindex, u32 addr);
> +		int (*wlan_set_rx_ring_for_txdone)(struct airoha_npu *npu,
> +						   int ifindex, u32 addr);
> +		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
> +					   bool xmit);

Hi Lorenzo,

It seems that the implementation in this patch of
most (all?) of the callbacks are trivial wrapper around
airoha_npu_wlan_send_msg(). Which provide a named callback to callers.

It seems to me that a different approach would be to provide a
wlan_send_msg() callback (name could be different, of course),
and have callers pass the _wlan_send_msg(). Which for one thing,
seems far less verbose in this driver.

Could you comment on these different approaches?

...

