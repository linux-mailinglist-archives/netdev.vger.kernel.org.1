Return-Path: <netdev+bounces-216986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E57B36F8B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AF67B474C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4330BB98;
	Tue, 26 Aug 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+wKEpVu"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9D21B918
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224555; cv=none; b=OnxPSLpiU+YoQxPzc31/R50QDbMpZg7mp9jvl3Gdh5+VsflPWewyLuX7khVicD+A+hTUmgRDaXPzWYXRtxyQ7PvyWyvZdxjsIU8prqDHOdAxzUHL+fwDAuNjtLH1skO8HKAqopWqzYS73b1f6nAdvZgvj+aotyaa46jgNKtNIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224555; c=relaxed/simple;
	bh=JsPCrAShvmrujDQQBA9SPlEujcEeHWEZeiiLzvDO7Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsjPI4M7ZfCfP2kFz066Qg5uzZX8rf4Z2291C+QoT9EeIchqNb88IdVHxfeg56mPSVW/C8ASsQyVTMHbQP5G5Dq9eos4tiUi2YEkagtcIdjcISlrHYn/HX9NWsINOn6OArbhNo6dEu2JHRphDYuZoMRnFh28Zk3sxL70sHAUS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+wKEpVu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8df76b5-fd6d-4779-b133-18ab2c987ae1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756224539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE4jLvMS6uO3y2vgaMfshtzsi+abCnBQzBD93FRis7A=;
	b=c+wKEpVucr0QXYUkhDCENcM4dxbVhyHuGs2uKQrpP0yGoYEclDtFg9zdALOROHTGbJ+9qb
	Tc80Tz7qjAX3TwD/JmRqqb9L23cGjx9pBPqX9hPBDSSzunFC+/XidpGrziHPJXX3jMAlxg
	xRDy+PbLhkPi0VVESWCN38WErmGCCzU=
Date: Tue, 26 Aug 2025 17:08:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 07/12] hinic3: Queue pair resource
 initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <f1be4fdf9c760c29eb53763836796e8bc003bb1c.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <f1be4fdf9c760c29eb53763836796e8bc003bb1c.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Add Tx & Rx queue resources and functions for packet transmission
> and reception.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

[...]

>   struct hinic3_nic_db {
> -	u32 db_info;
> -	u32 pi_hi;
> +	__le32 db_info;
> +	__le32 pi_hi;
>   };
>   
>   static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
> @@ -84,15 +84,25 @@ static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
>   {
>   	struct hinic3_nic_db db;
>   
> -	db.db_info = DB_INFO_SET(DB_SRC_TYPE, TYPE) |
> -		     DB_INFO_SET(cflag, CFLAG) |
> -		     DB_INFO_SET(cos, COS) |
> -		     DB_INFO_SET(queue->q_id, QID);
> -	db.pi_hi = DB_PI_HIGH(pi);
> +	db.db_info =
> +		cpu_to_le32(DB_INFO_SET(DB_SRC_TYPE, TYPE) |
> +			    DB_INFO_SET(cflag, CFLAG) |
> +			    DB_INFO_SET(cos, COS) |
> +			    DB_INFO_SET(queue->q_id, QID));
> +	db.pi_hi = cpu_to_le32(DB_PI_HIGH(pi));
>   
>   	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
>   }

[...]

> @@ -66,8 +97,8 @@ static void rq_wqe_buf_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
>   	struct hinic3_rq_wqe *rq_wqe;
>   
>   	rq_wqe = get_q_element(&rq->wq.qpages, wqe_idx, NULL);
> -	rq_wqe->buf_hi_addr = upper_32_bits(dma_addr);
> -	rq_wqe->buf_lo_addr = lower_32_bits(dma_addr);
> +	rq_wqe->buf_hi_addr = cpu_to_le32(upper_32_bits(dma_addr));
> +	rq_wqe->buf_lo_addr = cpu_to_le32(lower_32_bits(dma_addr));
>   }
[...]

> @@ -27,21 +27,21 @@
>   
>   /* RX Completion information that is provided by HW for a specific RX WQE */
>   struct hinic3_rq_cqe {
> -	u32 status;
> -	u32 vlan_len;
> -	u32 offload_type;
> -	u32 rsvd3;
> -	u32 rsvd4;
> -	u32 rsvd5;
> -	u32 rsvd6;
> -	u32 pkt_info;
> +	__le32 status;
> +	__le32 vlan_len;
> +	__le32 offload_type;
> +	__le32 rsvd3;
> +	__le32 rsvd4;
> +	__le32 rsvd5;
> +	__le32 rsvd6;
> +	__le32 pkt_info;
>   };
>   
>   struct hinic3_rq_wqe {
> -	u32 buf_hi_addr;
> -	u32 buf_lo_addr;
> -	u32 cqe_hi_addr;
> -	u32 cqe_lo_addr;
> +	__le32 buf_hi_addr;
> +	__le32 buf_lo_addr;
> +	__le32 cqe_hi_addr;
> +	__le32 cqe_lo_addr;
>   };

This patch has a lot of endianess-improvements changes which are
not stated in the commit message. It's better to move them to a separate
patch to avoid mixing things.

