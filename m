Return-Path: <netdev+bounces-251317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C4D3B933
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5553017655
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D179239E75;
	Mon, 19 Jan 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AoDT1/2S"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F91A316E
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857481; cv=none; b=V5wAik3iYpfCsneoINMl3v1C6rjvPnlmGZ1PV5/PrJrA/eUWw8DdbNYTvmHwFmFh426esIvsfeNN2LH40ZPpQYWF8z7yKY9krnUbG8zz/t3w61K8XiW/6eDXYe6W/oZemPtAC+Jky3B5jk1JYogtoEd1yDhgLL4VAhHLqgQzrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857481; c=relaxed/simple;
	bh=RxEW2ofYhxLfFT5t/jje+s8oK9IvNXuwJBZkZQV8hAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkR/Npq5FO6vO5K0gzc4ycl386z2EY7uRy+fq8K70RzLcvODuqzQqdISc5nIe2a9+JSgKAHKpdEwnUmQ/cQUj37XUTA1nEvjiVxh8h7XKh6CHjgYu1LR0OMB4VscucL503MylG7CZLrvwvr07nRHjdSgmE6fzDXSul32aQ3CSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AoDT1/2S; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e384d38a-ccfa-4888-b057-4306a297e749@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768857478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STjGeWIjhnQYLXx+MCkynCVjzE5jt5wfFhW0NeroYvY=;
	b=AoDT1/2SbKYJOri95bcQoLqLdgUL138JTKJijzpDXZuSjz3ImFeNJCIIquKICJ2Rak0ogL
	OJ3LqpkbtHwS6RCzJBctvMLNS7tGQHiGIMG4a4yR4RAyPhM8bO/8SeWsKq+Xcu9mNW85W2
	MJBpEKr3nrjFHTt6bvfHI0R796JBYc8=
Date: Mon, 19 Jan 2026 21:17:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] octeontx2-pf: Remove unnecessary bounds check
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, netdev@vger.kernel.org
References: <20260119-oob-v1-1-a4147e75e770@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260119-oob-v1-1-a4147e75e770@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/01/2026 16:39, Simon Horman wrote:
> active_fec is a 2-bit unsigned field, and thus can only have the values
> 0-3. So checking that it is less than 4 is unnecessary.
> 
> Simplify the code by dropping this check.
> 
> As it no longer fits well where it is, move FEC_MAX_INDEX to towards the
> top of the file. And add the prefix OXT2.  I believe this is more
> idiomatic.
> 
> Flagged by Smatch as:
>    ...//otx2_ethtool.c:1024 otx2_get_fecparam() warn: always true condition '(pfvf->linfo.fec < 4) => (0-3 < 4)'
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 8918be3ce45e9ae2e1f2fbc6396df0ab6c85bc22..a0340f3422bf90af524f682fc1fbe211d64c129c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -66,6 +66,8 @@ static const struct otx2_stat otx2_queue_stats[] = {
>   	{ "frames", 1 },
>   };
>   
> +#define OTX2_FEC_MAX_INDEX 4
> +
>   static const unsigned int otx2_n_dev_stats = ARRAY_SIZE(otx2_dev_stats);
>   static const unsigned int otx2_n_drv_stats = ARRAY_SIZE(otx2_drv_stats);
>   static const unsigned int otx2_n_queue_stats = ARRAY_SIZE(otx2_queue_stats);
> @@ -1031,15 +1033,14 @@ static int otx2_get_fecparam(struct net_device *netdev,
>   		ETHTOOL_FEC_BASER,
>   		ETHTOOL_FEC_RS,
>   		ETHTOOL_FEC_BASER | ETHTOOL_FEC_RS};
> -#define FEC_MAX_INDEX 4
> -	if (pfvf->linfo.fec < FEC_MAX_INDEX)
> -		fecparam->active_fec = fec[pfvf->linfo.fec];
> +
> +	fecparam->active_fec = fec[pfvf->linfo.fec];
>   
>   	rsp = otx2_get_fwdata(pfvf);
>   	if (IS_ERR(rsp))
>   		return PTR_ERR(rsp);
>   
> -	if (rsp->fwdata.supported_fec < FEC_MAX_INDEX) {
> +	if (rsp->fwdata.supported_fec < OTX2_FEC_MAX_INDEX) {
>   		if (!rsp->fwdata.supported_fec)
>   			fecparam->fec = ETHTOOL_FEC_NONE;
>   		else

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

