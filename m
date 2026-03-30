Return-Path: <netdev+bounces-273302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB92FqPKyml3AAYAu9opvQ
	(envelope-from <netdev+bounces-273302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:10:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF736032C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAD23020022
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9B3DE42E;
	Mon, 30 Mar 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPR/aBRW"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D156395D8F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897794; cv=none; b=kprsZjaaUVDyPyxpyToI/gTv1a2eEKRHzWWZ0AsTlt44PUnitvqQfnWICjOwa4duZnV5VewYMb0LokJbYXT8Bh/uNoIM00M6eFK3JCcuuV7QE3fBZ2ULDvVfiqQeb09LxbkNrXdRU4VErJRh78FIGvtEjogH3+0fqFDComvgdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897794; c=relaxed/simple;
	bh=JcBis6pTBzmgsNrafAyetZ0ru9qV/HJ77GoeevbHE3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTihk2AfRPlI+F6RjRQPt7tN7FBzz1qPpfAqujO8ziDz6D7G7PB14wzAAXo9Pg0nZAVdwMViTUVHLLK/T1xu2tUxL5tV8UP1NnhAPoFMzY/9gXcyRPd1d04wP7FERPl4vK8sFpk3XYx4p3FVcJUTQIUUHm6mUSAOtnxIzBf07Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPR/aBRW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9bec08b6-c97b-4e04-8940-d08afa831722@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774897790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAc7YHSQrwJfKCXX2f47zs5maWQYLeQ6iIc2j8sAEX0=;
	b=tPR/aBRWQ8VkUoJzfAOYOUvQmkoyvMwtDry/5SZEN21PjHOm7y6bKd0IAplfRoed63tUu/
	Sb99GaNLgRWU71EMf9gWSKdfP5Rsb3lTobGalag4XHMXBRLAwpyJT9VVg932E7RM5xIFAF
	CNlDqcaku08E0KDQgTF7EtzQZ0p1IMo=
Date: Mon, 30 Mar 2026 15:09:38 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net V2 1/2] net: xilinx: axienet: Correct BD length masks
 to match AXIDMA IP spec
To: Suraj Gupta <suraj.gupta2@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260327073238.134948-1-suraj.gupta2@amd.com>
 <20260327073238.134948-2-suraj.gupta2@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260327073238.134948-2-suraj.gupta2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273302-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,amd.com:email]
X-Rspamd-Queue-Id: 1FBF736032C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 03:32, Suraj Gupta wrote:
> The XAXIDMA_BD_CTRL_LENGTH_MASK and XAXIDMA_BD_STS_ACTUAL_LEN_MASK
> macros were defined as 0x007FFFFF (23 bits), but the AXI DMA IP
> product guide (PG021) specifies the buffer length field as bits 25:0
> (26 bits). Update both masks to match the IP documentation.
> 
> In practice this had no functional impact, since Ethernet frames are
> far smaller than 2^23 bytes and the extra bits were always zero, but
> the masks should still reflect the hardware specification.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..fcd3aaef27fc 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -105,7 +105,7 @@
>  #define XAXIDMA_BD_HAS_DRE_MASK		0xF00 /* Whether has DRE mask */
>  #define XAXIDMA_BD_WORDLEN_MASK		0xFF /* Whether has DRE mask */
>  
> -#define XAXIDMA_BD_CTRL_LENGTH_MASK	0x007FFFFF /* Requested len */
> +#define XAXIDMA_BD_CTRL_LENGTH_MASK	GENMASK(25, 0) /* Requested len */
>  #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
> @@ -130,7 +130,7 @@
>  #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
>  #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
>  
> -#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x007FFFFF /* Actual len */
> +#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	GENMASK(25, 0) /* Actual len */
>  #define XAXIDMA_BD_STS_COMPLETE_MASK	0x80000000 /* Completed */
>  #define XAXIDMA_BD_STS_DEC_ERR_MASK	0x40000000 /* Decode error */
>  #define XAXIDMA_BD_STS_SLV_ERR_MASK	0x20000000 /* Slave error */

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

