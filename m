Return-Path: <netdev+bounces-82547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4288E868
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C11C2F2E9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04451131BBE;
	Wed, 27 Mar 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKpmAb2S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD284D2E
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551796; cv=none; b=m5ZaaHGZ8t7/Mp5r9WjB/0vxavJxxKF8Rh06TmxL/naCW5XT3ovWa83DMZfrooMK1VXfkpL6ZdVlZM6BeysC4E8p5dMwaoHh20trHZBV74JlTtWi7AFmNenisOmpq/FEnXK4XgtV3cnqQTeCBYO21tcuLiTxYtV6/UoL1JoiNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551796; c=relaxed/simple;
	bh=CGIqnkjueQUIrMfaOnXLPuPIQPCHiV113pH5rQd5Vvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYGBwFFkjxVN/h3qOJUMlu9zqkLLQ8TLrZPbUHVX1RuKrXfvgt0WCkdzmXtTPLXJipbWiCrD6Bw+NVsdaDK3S3cUkIAn3uiwSuOS/rWBe3+DTPZspoGLqIpymKw74938ZpAbluwAHjrJMRKbEoD9gHLAK2uwR/cGk/z8RFuYiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKpmAb2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3FAC433C7;
	Wed, 27 Mar 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711551796;
	bh=CGIqnkjueQUIrMfaOnXLPuPIQPCHiV113pH5rQd5Vvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKpmAb2SrE9Jtzyp+KsTgTSfv6P9gxzpxrVuV2oOr+mmS6lzpLF35BMYGWs0eKqSE
	 VYgu7W/67+O9KPB/bOl+pCNTMhQSsYibuDRN2KVl01RGzf88k537p+O8eENH6iPWVc
	 1WwyfznkocRmaaEWpPepxUpcs0B7XHvUnj7R12T+z4L3n7bwxFfv6/aaUcvKfmacmb
	 EUrKN1GJAD0KNlTMNCpDZJy+bXJCPW6hiEQYGe057TpzAcCIAu5Oew7Ml4ecVINGgr
	 yGiPYLKilPY1mov+rwGcGVpF3GtEeqN94VuK00wyJuiZSQUt23130MfAk2A89hwCy5
	 zF5W4mwt7HKTg==
Date: Wed, 27 Mar 2024 15:03:10 +0000
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
	vigneshr@ti.com, arnd@arndb.de, wsa+renesas@sang-engineering.com,
	vladimir.oltean@nxp.com, andrew@lunn.ch, dan.carpenter@linaro.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v5 10/10] net: ti: icssg-prueth: Add ICSSG
 Ethernet driver for AM65x SR1.0 platforms
Message-ID: <20240327150310.GM403975@kernel.org>
References: <20240326110709.26165-1-diogo.ivo@siemens.com>
 <20240326110709.26165-11-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326110709.26165-11-diogo.ivo@siemens.com>

On Tue, Mar 26, 2024 at 11:07:00AM +0000, Diogo Ivo wrote:
> Add the PRUeth driver for the ICSSG subsystem found in AM65x SR1.0 devices.
> The main differences that set SR1.0 and SR2.0 apart are the missing TXPRU
> core in SR1.0, two extra DMA channels for management purposes and different
> firmware that needs to be configured accordingly.
> 
> Based on the work of Roger Quadros, Vignesh Raghavendra and
> Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c

...

> +static void prueth_tx_ts_sr1(struct prueth_emac *emac,
> +			     struct emac_tx_ts_response_sr1 *tsr)
> +{
> +	struct skb_shared_hwtstamps ssh;
> +	u32 hi_ts, lo_ts, cookie;
> +	struct sk_buff *skb;
> +	u64 ns;
> +
> +	hi_ts = le32_to_cpu(tsr->hi_ts);
> +	lo_ts = le32_to_cpu(tsr->lo_ts);
> +
> +	ns = (u64)hi_ts << 32 | lo_ts;
> +
> +	cookie = le32_to_cpu(tsr->cookie);

Hi,

le32_to_cpu() expects a __le32 argument.
But the type of tsr->hi_ts, tsr->lo_ts and tsr->cookie is u32.
This seems to indicate that host byte order values
are being used as little endian values, which does not seem correct.

Flagged by Sparse.

> +	if (cookie >= PRUETH_MAX_TX_TS_REQUESTS) {
> +		netdev_dbg(emac->ndev, "Invalid TX TS cookie 0x%x\n",
> +			   cookie);
> +		return;
> +	}
> +
> +	skb = emac->tx_ts_skb[cookie];
> +	emac->tx_ts_skb[cookie] = NULL;	/* free slot */
> +
> +	memset(&ssh, 0, sizeof(ssh));
> +	ssh.hwtstamp = ns_to_ktime(ns);
> +
> +	skb_tstamp_tx(skb, &ssh);
> +	dev_consume_skb_any(skb);
> +}

...

