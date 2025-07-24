Return-Path: <netdev+bounces-209703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53262B10774
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051F41CE30C9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F863260569;
	Thu, 24 Jul 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KT+7+EMi"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73F25F98E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351813; cv=none; b=IgyQf6I4jbDadfMbzuBG+kgcpUpy0QOgvITEhohE4Ymmghq55z+KH7bb163VVM1DiOQ5J+fGMCJzO8ULI+r2bC7za15xb3xJODWZHId4aKJ6XbkufCrWYjKtsCmJD47Kwt+BHxBPltb1ZoSqh7vVcppkk79FcGxvbfw4fG08jPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351813; c=relaxed/simple;
	bh=zzy2iT6xVqMbADM2CVlsHoH3vD1stfeWWC2/NO4H8KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyDJ557e6d3J3zJrQbFknPkzXQk/PzYvh/4IlSKAJWoY97C99xj5DJl61AYhpnteLxPzXBsqJIki2dtA1PnWsFjYjxsGtsAPhc4MAXkq/Sx+uTGyx4vVsSOv3mvWYjC10z2EZSlTxRa8Sind5o4A2pZT1cCqKtXso87/HStR0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KT+7+EMi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff106cec-7e63-4475-a0e6-452bfcb823b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753351799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9N4kKF1ybQ5CXgh1GBlu4OfVzelg+1wad03LAF0VVI=;
	b=KT+7+EMiLruXAUoUM3EAPX6VEEuwHxr71sLBL9KEsUx/rQCdAEU7Ar1IUZ5DUhU8Byfm4z
	JK+8WatmU+6FhG/+atS/1qr9O/p9vm9keg/LSGw9cFa8enrGbUqsiKmcMJWVVDAEtxFcCj
	HL6W46KKPKBUZAkjlraCt+uufSgtjCQ=
Date: Thu, 24 Jul 2025 11:09:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 3/7] net: airoha: npu: Add wlan_{send,get}_msg
 NPU callbacks
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
 <20250723-airoha-en7581-wlan-offlaod-v5-3-da92e0f8c497@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250723-airoha-en7581-wlan-offlaod-v5-3-da92e0f8c497@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2025 18:19, Lorenzo Bianconi wrote:
> Introduce wlan_send_msg() and wlan_get_msg() NPU wlan callbacks used
> by the wlan driver (MT76) to initialize NPU module registers in order to
> offload wireless-wired traffic.
> This is a preliminary patch to enable wlan flowtable offload for EN7581
> SoC with MT76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/ethernet/airoha/airoha_npu.c | 58 ++++++++++++++++++++++++++++++++
>   drivers/net/ethernet/airoha/airoha_npu.h | 21 ++++++++++++
>   2 files changed, 79 insertions(+)
> 

[...]

> @@ -131,6 +147,12 @@ struct wlan_mbox_data {
>   	u32 func_id;
>   	union {
>   		u32 data;
> +		struct {
> +			u32 dir;
> +			u32 in_counter_addr;
> +			u32 out_status_addr;
> +			u32 out_counter_addr;
> +		} txrx_addr;
>   		u8 stats[WLAN_MAX_STATS_SIZE];
>   	};
>   };
> @@ -424,6 +446,30 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
>   	return err;
>   }
>   
> +static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
> +				   enum airoha_npu_wlan_get_cmd func_id,
> +				   u32 *data, gfp_t gfp)
> +{
> +	struct wlan_mbox_data *wlan_data;
> +	int err;
> +
> +	wlan_data = kzalloc(sizeof(*wlan_data), gfp);
> +	if (!wlan_data)
> +		return -ENOMEM;
> +
> +	wlan_data->ifindex = ifindex;
> +	wlan_data->func_type = NPU_OP_GET;
> +	wlan_data->func_id = func_id;
> +
> +	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data,
> +				  sizeof(*wlan_data));
> +	if (!err)
> +		*data = wlan_data->data;
> +	kfree(wlan_data);
> +
> +	return err;
> +}

Am I reading it correct, that on message_get you allocate 4408 + 8 byte, 
setting it 0, then reallocate the same size in airoha_npu_send_msg() and
copy the data, and then free both buffers, and this is all done just to
get u32 value back?

