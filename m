Return-Path: <netdev+bounces-219103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C18B3FD4B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339271B228CB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7C2E92C5;
	Tue,  2 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRrYwcZN"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D92F6587
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811135; cv=none; b=kNgZqSZ9QXKdDdz9c0htpX3E5mK1R4kLjSGRjhn7MsVL22YYrGuTjbZjWbfCCHevSCFEgirdoTLzl7Ma85KajISkwmQyBYrOozDlk3Jl1f1rq40JnqJAj1DWcLZpnmu42RAC6x9hlqEOhnq9RI9sLIwKajE+tHvn70LaozwKKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811135; c=relaxed/simple;
	bh=aUVsoZfelFCjViOc27Jntfx20mZFASXIaBbcmD/TDPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYxEk75EbTut7PZ0axouoar//Y5uqMk9r+w7TYYN5zJ2J7wJvJtFA6xH8jFy+IxJP6xjYW3oZqSq2SeiRimVoRrnzyt+23xCkS6ur9VwqnZZtWBGq796GYUpRkuHfkvQSN8DoITgPmNrkOskiv0fPJ/paoKWqQBjM0cHNWX8Wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRrYwcZN; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cbee590-1143-4c45-b86f-b4e9cdc0a36e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756811129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEaZqYvixNRgRC3/d54C/oQgrIAXOVmkXhcS/Oi9GCY=;
	b=MRrYwcZN/VvSPb7YVJ7p7LN6fjdZ/yqqLo86yPjp7hdbs3pfMjsdlb9iRePp8FP6CW5AsX
	j4KZP4LkbyQyg09eSRLuF/s1r+w7f9E2u5sYDPt7J74UV1fyeczTI+G3tRMXTkyT3ai1uq
	/7uwr78NbWep8w380F5vNd3GKrICZ38=
Date: Tue, 2 Sep 2025 12:05:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next 1/2] idpf: add direct access to discipline the
 main timer
To: Anton Nadezhdin <anton.nadezhdin@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
References: <20250902105321.5750-1-anton.nadezhdin@intel.com>
 <20250902105321.5750-2-anton.nadezhdin@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250902105321.5750-2-anton.nadezhdin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2025 11:50, Anton Nadezhdin wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> IDPF allows to access the clock through virtchnl messages, or directly,
> through PCI BAR registers. Registers offsets are negotiated with the
> Control Plane during driver initialization process.
> Add support for direct operations to modify the clock.
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---

[...]

>   static void idpf_ptp_reg_init(const struct idpf_adapter *adapter)
>   {
> -	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
> -	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
> +	adapter->ptp->cmd.shtime_enable = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
> +	adapter->ptp->cmd.exec_cmd = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
>   }

[...]

> +/**
> + * idpf_ptp_set_dev_clk_time_direct- Set the time of the clock directly through
> + *				     BAR registers.
> + * @adapter: Driver specific private structure
> + * @dev_clk_time: Value expressed in nanoseconds to set
> + *
> + * Set the time of the device clock to provided value directly through BAR
> + * registers received during PTP capabilities negotiation.
> + */
> +static void idpf_ptp_set_dev_clk_time_direct(struct idpf_adapter *adapter,
> +					     u64 dev_clk_time)
> +{
> +	struct idpf_ptp *ptp = adapter->ptp;
> +	u32 dev_clk_time_l, dev_clk_time_h;
> +
> +	dev_clk_time_l = lower_32_bits(dev_clk_time);
> +	dev_clk_time_h = upper_32_bits(dev_clk_time);
> +
> +	writel(dev_clk_time_l, ptp->dev_clk_regs.dev_clk_ns_l);
> +	writel(dev_clk_time_h, ptp->dev_clk_regs.dev_clk_ns_h);
> +
> +	writel(dev_clk_time_l, ptp->dev_clk_regs.phy_clk_ns_l);
> +	writel(dev_clk_time_h, ptp->dev_clk_regs.phy_clk_ns_h);
> +
> +	idpf_ptp_tmr_cmd(adapter, ptp->cmd.init_time);
> +}
> +
[...]

> +/**
> + * idpf_ptp_adj_dev_clk_time_direct - Adjust the time of the clock directly
> + *				      through BAR registers.
> + * @adapter: Driver specific private structure
> + * @delta: Offset in nanoseconds to adjust the time by
> + *
> + * Adjust the time of the clock directly through BAR registers received during
> + * PTP capabilities negotiation.
> + */
> +static void idpf_ptp_adj_dev_clk_time_direct(struct idpf_adapter *adapter,
> +					     s64 delta)
> +{
> +	struct idpf_ptp *ptp = adapter->ptp;
> +	u32 delta_l = (s32)delta;
> +
> +	writel(0, ptp->dev_clk_regs.shadj_l);
> +	writel(delta_l, ptp->dev_clk_regs.shadj_h);
> +
> +	writel(0, ptp->dev_clk_regs.phy_shadj_l);
> +	writel(delta_l, ptp->dev_clk_regs.phy_shadj_h);
> +
> +	idpf_ptp_tmr_cmd(adapter, ptp->cmd.adj_time);
> +}

[...]

> - * struct idpf_ptp_cmd - PTP command masks
> - * @exec_cmd_mask: mask to trigger command execution
> - * @shtime_enable_mask: mask to enable shadow time
> + * struct idpf_ptp_cmd_mask - PTP command masks
> + * @exec_cmd: mask to trigger command execution
> + * @shtime_enable: mask to enable shadow time
> + * @init_time: initialize the device clock timer
> + * @init_incval: initialize increment value
> + * @adj_time: adjust the device clock timer
> + * @read_time: read the device clock timer
>    */
> -struct idpf_ptp_cmd {
> -	u32 exec_cmd_mask;
> -	u32 shtime_enable_mask;
> +struct idpf_ptp_cmd_mask {
> +	u32 exec_cmd;
> +	u32 shtime_enable;
> +	u32 init_time;
> +	u32 init_incval;
> +	u32 adj_time;
> +	u32 read_time;
>   };
>   
>   /* struct idpf_ptp_dev_clk_regs - PTP device registers
> @@ -183,7 +191,7 @@ struct idpf_ptp {
>   	struct idpf_adapter *adapter;
>   	u64 base_incval;
>   	u64 max_adj;
> -	struct idpf_ptp_cmd cmd;
> +	struct idpf_ptp_cmd_mask cmd;
>   	u64 cached_phc_time;
For the field cmd you changed the struct definition to add more commands
but this diff doesn't init values for new fields. At the same time these
new fields are used in several new functions (idpf_ptp_*_direct). We end
up using 0 while issuing the command.


