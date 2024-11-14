Return-Path: <netdev+bounces-144933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475009C8CE2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D571B36FF0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390673BB48;
	Thu, 14 Nov 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s4LTW3Bh"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A142FE33
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593715; cv=none; b=Q+Ds9F9L1UPW4Enid7rS8DkpafeR+aqeKtqPAySfzUmhT3ypPgH8YzKdIiSMDBMP88yk2Kvulsd364bPYiAEk+m2dgF3wFpTr6eV2ck7IIlwryG6kitIMWau+ecxDnfW//Gk1YFKxaYuy7osH190OIXcBvwKRuPo+CxG+LSdoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593715; c=relaxed/simple;
	bh=ja5Pm9uYZP4HeGDnNqYZDc/HKtmhFCsP7FShmCcwMSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rOgR+0GwY4hqsUbhucUSKxNmTX6ylfTa7PPj9/P7MkEAKocLHx2xkMqvqARC2HY9gfoSJrfXkA3ZxDN7XY/l5h50uWyVv3PgurBAouj1RKH0JBTYtthhD0rWLGBr7EMVOaSZFArs12PgWjABIptoAfpoGlDXmifSCUelBdyY6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s4LTW3Bh; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4af7b21e-1340-493b-a3c0-be752ef9d7cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731593710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/88vAmCRZdNnlmj1UPgM2nFthtidD0sUVSQ3mSRpTg=;
	b=s4LTW3BhyD+g2DbbDdiCaHi9kNDK/6Is8jugzKI4GeEwAULusU5AFoW8v/MqUgsK8Ut9iP
	qyGHM4MJUUw4VdWBd+t9FERnPilkhri+X+IEg8klM4nYjy/dA8X91wKrQevoUvBWG4/Rk3
	n5JDIvEZSxyEmVJqbHXGuGA3pDcD7YE=
Date: Thu, 14 Nov 2024 14:15:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/5] net: phy: microchip_ptp : Add header file
 for Microchip ptp library
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241114120455.5413-1-divya.koppera@microchip.com>
 <20241114120455.5413-2-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241114120455.5413-2-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/11/2024 12:04, Divya Koppera wrote:
> This ptp header file library will cover ptp macros for future phys in
> Microchip where addresses will be same but base offset and mmd address
> may changes.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v3 -> v4
> - Re-ordered mchp_ptp_clock structure.
> 
> v2 -> v3
> - No changes
> 
> v1 -> v2
> - Fixed sparse warnings and compilation errors/warnings reported by kernel
>    test robot
> ---
>   drivers/net/phy/microchip_ptp.h | 216 ++++++++++++++++++++++++++++++++
>   1 file changed, 216 insertions(+)
>   create mode 100644 drivers/net/phy/microchip_ptp.h
> 
> diff --git a/drivers/net/phy/microchip_ptp.h b/drivers/net/phy/microchip_ptp.h
> new file mode 100644
> index 000000000000..1b6e0d9d7e76
> --- /dev/null
> +++ b/drivers/net/phy/microchip_ptp.h
> @@ -0,0 +1,216 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2024 Microchip Technology
> + */
> +
> +#ifndef _MICROCHIP_PTP_H
> +#define _MICROCHIP_PTP_H
> +
> +#if IS_ENABLED(CONFIG_MICROCHIP_PHYPTP)
> +
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/ptp_clock.h>
> +#include <linux/ptp_classify.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/mii.h>
> +#include <linux/phy.h>
> +
> +#define MCHP_PTP_CMD_CTL(b)			((b) + 0x0)
> +#define MCHP_PTP_CMD_CTL_LTC_STEP_NSEC		BIT(6)
> +#define MCHP_PTP_CMD_CTL_LTC_STEP_SEC		BIT(5)
> +#define MCHP_PTP_CMD_CTL_CLOCK_LOAD		BIT(4)
> +#define MCHP_PTP_CMD_CTL_CLOCK_READ		BIT(3)
> +#define MCHP_PTP_CMD_CTL_EN			BIT(1)
> +#define MCHP_PTP_CMD_CTL_DIS			BIT(0)
> +
> +#define MCHP_PTP_REF_CLK_CFG(b)			((b) + 0x2)
> +#define MCHP_PTP_REF_CLK_SRC_250MHZ		0x0
> +#define MCHP_PTP_REF_CLK_PERIOD_OVERRIDE	BIT(9)
> +#define MCHP_PTP_REF_CLK_PERIOD			4
> +#define MCHP_PTP_REF_CLK_CFG_SET	(MCHP_PTP_REF_CLK_SRC_250MHZ |\
> +					 MCHP_PTP_REF_CLK_PERIOD_OVERRIDE |\
> +					 MCHP_PTP_REF_CLK_PERIOD)
> +
> +#define MCHP_PTP_LTC_SEC_HI(b)			((b) + 0x5)
> +#define MCHP_PTP_LTC_SEC_MID(b)			((b) + 0x6)
> +#define MCHP_PTP_LTC_SEC_LO(b)			((b) + 0x7)
> +#define MCHP_PTP_LTC_NS_HI(b)			((b) + 0x8)
> +#define MCHP_PTP_LTC_NS_LO(b)			((b) + 0x9)
> +#define MCHP_PTP_LTC_RATE_ADJ_HI(b)		((b) + 0xc)
> +#define MCHP_PTP_LTC_RATE_ADJ_HI_DIR		BIT(15)
> +#define MCHP_PTP_LTC_RATE_ADJ_LO(b)		((b) + 0xd)
> +#define MCHP_PTP_LTC_STEP_ADJ_HI(b)		((b) + 0x12)
> +#define MCHP_PTP_LTC_STEP_ADJ_HI_DIR		BIT(15)
> +#define MCHP_PTP_LTC_STEP_ADJ_LO(b)		((b) + 0x13)
> +#define MCHP_PTP_LTC_READ_SEC_HI(b)		((b) + 0x29)
> +#define MCHP_PTP_LTC_READ_SEC_MID(b)		((b) + 0x2a)
> +#define MCHP_PTP_LTC_READ_SEC_LO(b)		((b) + 0x2b)
> +#define MCHP_PTP_LTC_READ_NS_HI(b)		((b) + 0x2c)
> +#define MCHP_PTP_LTC_READ_NS_LO(b)		((b) + 0x2d)
> +#define MCHP_PTP_OP_MODE(b)			((b) + 0x41)
> +#define MCHP_PTP_OP_MODE_DIS			0
> +#define MCHP_PTP_OP_MODE_STANDALONE		1
> +#define MCHP_PTP_LATENCY_CORRECTION_CTL(b)	((b) + 0x44)
> +#define MCHP_PTP_PREDICTOR_EN			BIT(6)
> +#define MCHP_PTP_TX_PRED_DIS			BIT(1)
> +#define MCHP_PTP_RX_PRED_DIS			BIT(0)
> +#define MCHP_PTP_LATENCY_SETTING		(MCHP_PTP_PREDICTOR_EN | \
> +						 MCHP_PTP_TX_PRED_DIS | \
> +						 MCHP_PTP_RX_PRED_DIS)
> +
> +#define MCHP_PTP_INT_EN(b)			((b) + 0x0)
> +#define MCHP_PTP_INT_STS(b)			((b) + 0x01)
> +#define MCHP_PTP_INT_TX_TS_OVRFL_EN		BIT(3)
> +#define MCHP_PTP_INT_TX_TS_EN			BIT(2)
> +#define MCHP_PTP_INT_RX_TS_OVRFL_EN		BIT(1)
> +#define MCHP_PTP_INT_RX_TS_EN			BIT(0)
> +#define MCHP_PTP_INT_ALL_MSK		(MCHP_PTP_INT_TX_TS_OVRFL_EN | \
> +					 MCHP_PTP_INT_TX_TS_EN | \
> +					 MCHP_PTP_INT_RX_TS_OVRFL_EN |\
> +					 MCHP_PTP_INT_RX_TS_EN)
> +
> +#define MCHP_PTP_CAP_INFO(b)			((b) + 0x2e)
> +#define MCHP_PTP_TX_TS_CNT(v)			(((v) & GENMASK(11, 8)) >> 8)
> +#define MCHP_PTP_RX_TS_CNT(v)			((v) & GENMASK(3, 0))
> +
> +#define MCHP_PTP_RX_PARSE_CONFIG(b)		((b) + 0x42)
> +#define MCHP_PTP_RX_PARSE_L2_ADDR_EN(b)		((b) + 0x44)
> +#define MCHP_PTP_RX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x45)
> +
> +#define MCHP_PTP_RX_TIMESTAMP_CONFIG(b)		((b) + 0x4e)
> +#define MCHP_PTP_RX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
> +
> +#define MCHP_PTP_RX_VERSION(b)			((b) + 0x48)
> +#define MCHP_PTP_RX_TIMESTAMP_EN(b)		((b) + 0x4d)
> +
> +#define MCHP_PTP_RX_INGRESS_NS_HI(b)		((b) + 0x54)
> +#define MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID	BIT(15)
> +
> +#define MCHP_PTP_RX_INGRESS_NS_LO(b)		((b) + 0x55)
> +#define MCHP_PTP_RX_INGRESS_SEC_HI(b)		((b) + 0x56)
> +#define MCHP_PTP_RX_INGRESS_SEC_LO(b)		((b) + 0x57)
> +#define MCHP_PTP_RX_MSG_HEADER2(b)		((b) + 0x59)
> +
> +#define MCHP_PTP_TX_PARSE_CONFIG(b)		((b) + 0x82)
> +#define MCHP_PTP_PARSE_CONFIG_LAYER2_EN		BIT(0)
> +#define MCHP_PTP_PARSE_CONFIG_IPV4_EN		BIT(1)
> +#define MCHP_PTP_PARSE_CONFIG_IPV6_EN		BIT(2)
> +
> +#define MCHP_PTP_TX_PARSE_L2_ADDR_EN(b)		((b) + 0x84)
> +#define MCHP_PTP_TX_PARSE_IPV4_ADDR_EN(b)	((b) + 0x85)
> +
> +#define MCHP_PTP_TX_VERSION(b)			((b) + 0x88)
> +#define MCHP_PTP_MAX_VERSION(x)			(((x) & GENMASK(7, 0)) << 8)
> +#define MCHP_PTP_MIN_VERSION(x)			((x) & GENMASK(7, 0))
> +
> +#define MCHP_PTP_TX_TIMESTAMP_EN(b)		((b) + 0x8d)
> +#define MCHP_PTP_TIMESTAMP_EN_SYNC		BIT(0)
> +#define MCHP_PTP_TIMESTAMP_EN_DREQ		BIT(1)
> +#define MCHP_PTP_TIMESTAMP_EN_PDREQ		BIT(2)
> +#define MCHP_PTP_TIMESTAMP_EN_PDRES		BIT(3)
> +#define MCHP_PTP_TIMESTAMP_EN_ALL		(MCHP_PTP_TIMESTAMP_EN_SYNC |\
> +						 MCHP_PTP_TIMESTAMP_EN_DREQ |\
> +						 MCHP_PTP_TIMESTAMP_EN_PDREQ |\
> +						 MCHP_PTP_TIMESTAMP_EN_PDRES)
> +
> +#define MCHP_PTP_TX_TIMESTAMP_CONFIG(b)		((b) + 0x8e)
> +#define MCHP_PTP_TX_TIMESTAMP_CONFIG_PTP_FCS_DIS BIT(0)
> +
> +#define MCHP_PTP_TX_MOD(b)			((b) + 0x8f)
> +#define MCHP_PTP_TX_MOD_PTP_SYNC_TS_INSERT	BIT(12)
> +#define MCHP_PTP_TX_MOD_PTP_FU_TS_INSERT	BIT(11)
> +
> +#define MCHP_PTP_TX_EGRESS_NS_HI(b)		((b) + 0x94)
> +#define MCHP_PTP_TX_EGRESS_NS_HI_TS_VALID	BIT(15)
> +
> +#define MCHP_PTP_TX_EGRESS_NS_LO(b)		((b) + 0x95)
> +#define MCHP_PTP_TX_EGRESS_SEC_HI(b)		((b) + 0x96)
> +#define MCHP_PTP_TX_EGRESS_SEC_LO(b)		((b) + 0x97)
> +#define MCHP_PTP_TX_MSG_HEADER2(b)		((b) + 0x99)
> +
> +#define MCHP_PTP_TSU_GEN_CONFIG(b)		((b) + 0xc0)
> +#define MCHP_PTP_TSU_GEN_CFG_TSU_EN		BIT(0)
> +
> +#define MCHP_PTP_TSU_HARD_RESET(b)		((b) + 0xc1)
> +#define MCHP_PTP_TSU_HARDRESET			BIT(0)
> +
> +/* Represents 1ppm adjustment in 2^32 format with
> + * each nsec contains 4 clock cycles in 250MHz.
> + * The value is calculated as following: (1/1000000)/((2^-32)/4)
> + */
> +#define MCHP_PTP_1PPM_FORMAT			17179
> +#define MCHP_PTP_FIFO_SIZE			8
> +#define MCHP_PTP_MAX_ADJ				31249999
> +
> +#define BASE_CLK(p)		((p)->clk_base_addr)
> +#define BASE_PORT(p)		((p)->port_base_addr)
> +#define PTP_MMD(p)		((p)->mmd)
> +
> +enum ptp_fifo_dir {
> +	PTP_INGRESS_FIFO,
> +	PTP_EGRESS_FIFO
> +};
> +
> +struct mchp_ptp_clock {
> +	struct mii_timestamper mii_ts;
> +	struct phy_device *phydev;
> +	struct ptp_clock *ptp_clock;
> +
> +	struct sk_buff_head tx_queue;
> +	struct sk_buff_head rx_queue;
> +	struct list_head rx_ts_list;
> +
> +	struct ptp_clock_info caps;
> +
> +	/* Lock for Rx ts fifo */
> +	spinlock_t rx_ts_lock;
> +	int hwts_tx_type;
> +
> +	enum hwtstamp_rx_filters rx_filter;
> +	int layer;
> +	int version;
> +	u16 port_base_addr;
> +	u16 clk_base_addr;
> +
> +	/* Lock for phc */
> +	struct mutex ptp_lock;
> +	u8 mmd;
> +};
> 

I'm not quite sure that this layout is better, but as Andrew said if
it's not going to do Mpps processing - we are fine.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

