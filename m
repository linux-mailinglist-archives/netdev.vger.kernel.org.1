Return-Path: <netdev+bounces-237432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA017C4B429
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926471893453
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E15934AAEA;
	Tue, 11 Nov 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFDLEKUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D64734AAE0;
	Tue, 11 Nov 2025 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829778; cv=none; b=IsbWmRCeEDgizPZsVKHwOoq+tPkkkbz6jEEDVn6ffaKyfmA3fmNd1w5UDMpc/FdpwCmHflz6WebMTs2GbVZag1F+2DG6fAf2YitAgV2HbLfjGxOCk23D82EMS2Kys+/cfV5aF/Tu0Q4ptx4X0xr3TGfOUQgcZhqa4VxDvPwxSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829778; c=relaxed/simple;
	bh=avMl0/hyasDM6lzNjTwQPpDMsdmwlerEdCd6tKurR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBA5lp/U0mZx4Ga6PZ17XuYtkjK7fWooMXpTgVzfv5NKyWtiCbci+usY/3r0b0viDoXgCX6fSyl7c24R3bIejkeEQDCnhAWGLJI4+HDd/V4VN30GFF1urpSNDiRN+YzctjiMQ8vV0KA5EeYzcP871745aeoBNSkHp8vaCV9bEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFDLEKUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97899C19425;
	Tue, 11 Nov 2025 02:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762829777;
	bh=avMl0/hyasDM6lzNjTwQPpDMsdmwlerEdCd6tKurR6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFDLEKUiSvsNgwzb4IGo7ylNeYHj3RlOrOF7dNdEQFtSc9XbkmrStCRFLAKdV7x6D
	 AVxNc+pyoELYoYKOeTVrBDQLhGK8nBhy4TxB3mel3eR9sqW97oL5PYrr5anou9Xh+4
	 h0CoyRI107PeO9phMOuBMHBjxbwXmIKoEiq4kJGGZQmJFjzYMcjeKIYiEUB2JUxYNe
	 q17TPGLlh27wPFiq/KHDjB37OaVexkfC4axKFFDWddnaxhdf1Ri0IENV5mvVijj1GF
	 yZeYWP8Lbfjsw/dtyOwn5LrXVRkR2BoJ5KppMkW7LMKG/TRSmkFK0zz+bRdL5VlLL8
	 8mPm1YYjd3NOg==
Date: Mon, 10 Nov 2025 18:56:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur
 Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v06 3/5] hinic3: Add NIC configuration ops
Message-ID: <20251110185615.631a6462@kernel.org>
In-Reply-To: <2b5253f63c4f6ba5b7deccf4aa2b15dc32da6589.1762581665.git.zhuyikai1@h-partners.com>
References: <cover.1762581665.git.zhuyikai1@h-partners.com>
	<2b5253f63c4f6ba5b7deccf4aa2b15dc32da6589.1762581665.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 14:41:38 +0800 Fan Gong wrote:
> Add ops to configure NIC feature(lro, vlan, csum...).

This patch really does too many things at once, please split it.
You are allowed to have up to 15 patches in a series, having a list 
of things in a commit message is a strong indication that the patch 
is doing too many things at once.

> +static void hinic3_auto_moderation_work(struct work_struct *work)
> +{
> +	u64 rx_packets, rx_bytes, rx_pkt_diff, rx_rate, avg_pkt_size;
> +	u64 tx_packets, tx_bytes, tx_pkt_diff, tx_rate;
> +	struct hinic3_nic_dev *nic_dev;
> +	struct delayed_work *delay;
> +	struct net_device *netdev;
> +	unsigned long period;
> +	u16 qid;

Please use the DIM infrastructure kernel already has.
If it's not good enough - improve it.

> +static void hinic3_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_io_queue *sq;
> +	bool hw_err = false;
> +	u16 sw_pi, hw_ci;
> +	u8 q_id;
> +
> +	HINIC3_NIC_STATS_INC(nic_dev, netdev_tx_timeout);

kernel already has a counter for this

> +	netdev_err(netdev, "Tx timeout\n");

and prints an error

Please don't duplicate.

> +	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
> +		if (!netif_xmit_stopped(netdev_get_tx_queue(netdev, q_id)))
> +			continue;

Why are you scanning the queues? kernel passes @txqueue to tell you
which queue has stalled.

> +		sq = nic_dev->txqs[q_id].sq;
> +		sw_pi = hinic3_get_sq_local_pi(sq);
> +		hw_ci = hinic3_get_sq_hw_ci(sq);
> +		netdev_dbg(netdev,
> +			   "txq%u: sw_pi: %u, hw_ci: %u, sw_ci: %u, napi->state: 0x%lx.\n",
> +			   q_id, sw_pi, hw_ci, hinic3_get_sq_local_ci(sq),
> +			   nic_dev->q_params.irq_cfg[q_id].napi.state);
> +
> +		if (sw_pi != hw_ci)
> +			hw_err = true;
> +	}
> +
> +	if (hw_err)
> +		set_bit(HINIC3_EVENT_WORK_TX_TIMEOUT, &nic_dev->event_flag);
> +}

> +struct hinic3_nic_stats {
> +	u64                   netdev_tx_timeout;
> +
> +	/* Subdivision statistics show in private tool */
> +	u64                   tx_carrier_off_drop;
> +	u64                   tx_invalid_qid;

I don't see these being used in the series.

> +	struct u64_stats_sync syncp;
> +};
-- 
pw-bot: cr

