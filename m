Return-Path: <netdev+bounces-171470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B55A4D0C4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 02:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674CF3ADBDA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260F137923;
	Tue,  4 Mar 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iie1xK3Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88170126C1E;
	Tue,  4 Mar 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051545; cv=none; b=J6rgjrckYV7+gsDcZrPgxPTAQctRFyfMQQnn6GO+Ll9DGAE0F22QWBhV5pqIH8EHk12PdN3226iKWLa6pUtMMwCApN0RyV3J1TsQxtIeJIZy1eOhxlHodpoWXLQpjTjwb3ferIJwH+WbRrbcOiMhO4JswmfGH0FdMZEzrxLqI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051545; c=relaxed/simple;
	bh=V+AR8dH+t6wF0pag9HBom6C8kvjl0abK03bDTDbhgus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAgy3CHWnQvfyDFBd+YvANtTCo7Ggv74lo1IZIf+R1dmeKbxCKothgS8AAVbRzK7D2yj7r1h2Dp0j6wTDnRXtXD3mcvtUs5tesI6gQLZhRliMzkKbj1hDDNKN0V9TvdhpwBf1ERi6QRaAo6Em2xbDFrdl+VwRPp9qmClp3HFc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iie1xK3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A250C4CEE4;
	Tue,  4 Mar 2025 01:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741051545;
	bh=V+AR8dH+t6wF0pag9HBom6C8kvjl0abK03bDTDbhgus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iie1xK3ZssJi2y780Ojr9j8a6wVbrQsYpN1DUXNwRXsqH+k5jAeLV42Vryi1kOEG+
	 hB/ncQZa656pbfQXYLnjBjrOw29+2BIpnQ/htvg0p6VqeEe9rK6vtY3uEIyrM1wEJy
	 6ZIHsvV66Qq998PaXNlkAgS1uFstqSki0f7Ni48+uteJr1L/t0FYSFjoxRqR4WFKWm
	 H9OQvIFNNrr9gBvuXEuiEj+I4GKi9fjUoi4OcG0UhURgqD4ipA8ld/AyT6eQtahLxb
	 GUhVTdMp9sO8sjBSOrkWOB6V22aKZNHrimZklojiEkwzlvOh7fUozPVoG/7ilw/c8/
	 49yyaym+R/2TQ==
Date: Mon, 3 Mar 2025 17:25:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Add ICSSG FW Stats
Message-ID: <20250303172543.249a4fc2@kernel.org>
In-Reply-To: <20250227093712.2130561-1-danishanwar@ti.com>
References: <20250227093712.2130561-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:07:12 +0530 MD Danish Anwar wrote:
> +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),

I presume frame preemption is implemented in silicon? If yes -
what makes these "FW statistics"? Does the FW collect them from 
the device or the frames are for FW? 

> +	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
> +	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
> +	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
> +	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP),
> +	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN),
> +	ICSSG_PA_STATS(FW_CUT_THR_PKT),
> +	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT),
> +	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
> +	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
> +	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
>  };
>  
>  #endif /* __NET_TI_ICSSG_STATS_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> index 424a7e945ea8..d30203a0978c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
> @@ -231,4 +231,109 @@
>  /* Start of 32 bits PA_STAT counters */
>  #define PA_STAT_32b_START_OFFSET                           0x0080
>  
> +/* Diagnostic error counter which increments when RTU drops a locally injected
> + * packet due to port disabled or rule violation.
> + */
> +#define FW_RTU_PKT_DROP		0x0088
> +
> +/* Tx Queue Overflow Counters */
> +#define FW_Q0_OVERFLOW		0x0090
> +#define FW_Q1_OVERFLOW		0x0098
> +#define FW_Q2_OVERFLOW		0x00A0
> +#define FW_Q3_OVERFLOW		0x00A8
> +#define FW_Q4_OVERFLOW		0x00B0
> +#define FW_Q5_OVERFLOW		0x00B8
> +#define FW_Q6_OVERFLOW		0x00C0
> +#define FW_Q7_OVERFLOW		0x00C8
> +
> +/* Incremented if a packet is dropped at PRU because of a rule violation */
> +#define FW_DROPPED_PKT		0x00F8

Instead of adding comments here please add a file under
Documentation/networking/device_drivers/ with the explanations.
That's far more likely to be discovered by users, no?
-- 
pw-bot: cr

