Return-Path: <netdev+bounces-75045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC112867E5E
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2062907E5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951712C815;
	Mon, 26 Feb 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCoT1GLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585412C7E6
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968241; cv=none; b=PvHfc7k0Zr8HOGc58zIUr+E02VKfgqt47yNTOLO5jrIa6UAo19lc3SQFxwvxnp/Qq3PK6PcU7DIOYb9Z5ue0rocI7ZE9cMy5ULv5GYg6EstK4gyJ6NowkgmEetry9ILtXg3XPwG57orOyLpBgu+e1RhI9VsNnY8hXcRyn3wIYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968241; c=relaxed/simple;
	bh=Q+g9Mnr4g2BXFm8vbAR/k8t6/yZcCrZP7p1rjLSCFq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCjYTIbl4ynAjTEdrCDi3CcbVEFyg727CyV32LnVonMymcvlQUCZIuVeTNpfIu6QMavHwPEl206BEdKa9fAzFoGDWfR6c3Ox8epocY7dwuZA1YlP0wrg3V5HJXAOuG2OIp/rUbOKt2P7iq0NRfPs807GZ5RpDg9q6EFmpFm3T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCoT1GLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD7C433C7;
	Mon, 26 Feb 2024 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968240;
	bh=Q+g9Mnr4g2BXFm8vbAR/k8t6/yZcCrZP7p1rjLSCFq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MCoT1GLTnNoZ1LYWhy8MqjJR6RL3g/Fn6+rULK2379F5tpfXz0NwUyts57TBhMNZt
	 Z2y3lLdrjXjFLKdkXwUhyiC0VqfWcGngKMJFWW94Ca1HVjyXosLHpKasn+CZpdlYSz
	 FZlfFbFomuSjslccY4R2ft1VlFugroDkWVq2oDC9hq7bV4pu3lNyrlO66tuKZu182I
	 NJWzMz0IZr8q3iF481ap5afqb5tz1lv3b9xsEsegh66q38fKPCViRBQMEirR9z1wo+
	 F65yy6Px6/BW8AmctId7wLO2k2v3kyHdK0+XjWxpERenICIFh9L3Jua+Mjatai4O76
	 wy5CC+q+xLJng==
Message-ID: <5337e08b-a4dd-46d0-bc2e-a30b82aeeb15@kernel.org>
Date: Mon, 26 Feb 2024 19:23:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/10] net: ti: icssg-prueth: Add
 SR1.0-specific configuration bits
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-5-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-5-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Diogo,

On 21/02/2024 17:24, Diogo Ivo wrote:
> Define the firmware configuration structure and commands needed to
> communicate with SR1.0 firmware, as well as SR1.0 buffer information
> where it differs from SR2.0.
> 
> Based on the work of Roger Quadros, Murali Karicheri and
> Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
> Changes in v2:
>  - Removed explicit references to SR2.0
> 
>  drivers/net/ethernet/ti/icssg/icssg_config.h | 56 ++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index 43eb0922172a..cb465b3f5355 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -35,6 +35,23 @@ struct icssg_flow_cfg {
>  	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
>  	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
>  
> +/* SR1.0 defines */
> +#define PRUETH_MAX_RX_FLOWS_SR1		4	/* excluding default flow */
> +#define PRUETH_RX_FLOW_DATA_SR1		3       /* highest priority flow */
> +#define PRUETH_MAX_RX_MGM_DESC		8
> +#define PRUETH_MAX_RX_MGM_FLOWS		2	/* excluding default flow */
> +#define PRUETH_RX_MGM_FLOW_RESPONSE	0
> +#define PRUETH_RX_MGM_FLOW_TIMESTAMP	1

Should we add suffix _SR1 to all SR1 specific macro names?

> +
> +#define PRUETH_NUM_BUF_POOLS_SR1		16
> +#define PRUETH_EMAC_BUF_POOL_START_SR1		8
> +#define PRUETH_EMAC_BUF_POOL_MIN_SIZE_SR1	128
> +#define PRUETH_EMAC_BUF_SIZE_SR1		1536
> +#define PRUETH_EMAC_NUM_BUF_SR1			4
> +#define PRUETH_EMAC_BUF_POOL_SIZE_SR1	(PRUETH_EMAC_NUM_BUF_SR1 * \
> +					 PRUETH_EMAC_BUF_SIZE_SR1)
> +#define MSMC_RAM_SIZE_SR1	(SZ_64K + SZ_32K + SZ_2K) /* 0x1880 x 8 x 2 */
> +
>  struct icssg_rxq_ctx {
>  	__le32 start[3];
>  	__le32 end;
> @@ -104,6 +121,45 @@ enum icssg_port_state_cmd {
>  #define ICSSG_NUM_NORMAL_PDS	64
>  #define ICSSG_NUM_SPECIAL_PDS	16
>  
> +struct icssg_sr1_config {
> +	__le32 status;		/* Firmware status */
> +	__le32 addr_lo;		/* MSMC Buffer pool base address low. */
> +	__le32 addr_hi;		/* MSMC Buffer pool base address high. Must be 0 */
> +	__le32 tx_buf_sz[16];	/* Array of buffer pool sizes */
> +	__le32 num_tx_threads;	/* Number of active egress threads, 1 to 4 */
> +	__le32 tx_rate_lim_en;	/* Bitmask: Egress rate limit en per thread */
> +	__le32 rx_flow_id;	/* RX flow id for first rx ring */
> +	__le32 rx_mgr_flow_id;	/* RX flow id for the first management ring */
> +	__le32 flags;		/* TBD */
> +	__le32 n_burst;		/* for debug */
> +	__le32 rtu_status;	/* RTU status */
> +	__le32 info;		/* reserved */
> +	__le32 reserve;
> +	__le32 rand_seed;	/* Used for the random number generation at fw */
> +} __packed;
> +
> +/* SR1.0 shutdown command to stop processing at firmware.
> + * Command format: 0x8101ss00, where
> + *	- ss: sequence number. Currently not used by driver.
> + */
> +#define ICSSG_SHUTDOWN_CMD		0x81010000
> +
> +/* SR1.0 pstate speed/duplex command to set speed and duplex settings
> + * in firmware.
> + * Command format: 0x8102ssPN, where
> + *	- ss: sequence number. Currently not used by driver.
> + *	- P: port number (for switch mode).
> + *	- N: Speed/Duplex state:
> + *		0x0 - 10Mbps/Half duplex;
> + *		0x8 - 10Mbps/Full duplex;
> + *		0x2 - 100Mbps/Half duplex;
> + *		0xa - 100Mbps/Full duplex;
> + *		0xc - 1Gbps/Full duplex;
> + *		NOTE: The above are the same value as bits [3..1](slice 0)
> + *		      or bits [7..5](slice 1) of RGMII CFG register.
> + */
> +#define ICSSG_PSTATE_SPEED_DUPLEX_CMD	0x81020000
> +

How about bunching all S1.0 related changes at one place in this file?

>  #define ICSSG_NORMAL_PD_SIZE	8
>  #define ICSSG_SPECIAL_PD_SIZE	20
>  

-- 
cheers,
-roger

