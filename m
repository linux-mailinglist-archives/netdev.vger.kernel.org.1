Return-Path: <netdev+bounces-118168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180F950D24
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A0286299
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B51A4F1C;
	Tue, 13 Aug 2024 19:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38E1A08C6;
	Tue, 13 Aug 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577380; cv=none; b=JZ9YVyuixV53apgfoms3+nFGqtV8qa/ATf7BA9MRcQAH0S8uomggVqd3tTEjx8YatEtG1ohHMSHErjT7N5MPVcRwuweMvNVdp3P/igF72YHOdF/h+8fIeBoF7v+Fm9+z/DE7aKJxz5CLf4W1VEiT15tpHOHWWzvOErVgR47ur8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577380; c=relaxed/simple;
	bh=/mgNqRwCR+iIkDZQW+tQbiBJ+K7CqFSOS3dBNk7DZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCO3h2Fn9TkRB8KfzaQbzstttnFE9YD1822OrA6YaL7RS82nexAZe5mUqEof7Nm+RrhHbkpd+WcpJ8SSiizXOcU1xr14WK+JgbgcL9Shuh4kgkfcNx8l44kHAUBVVZigRT0Tb4gM/+pU+3dLg8l9l99GluO7DfEKGOIYSgx+sDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.20.146.172] (guest-ext.mpip-mainz.mpg.de [194.95.63.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BB2F061E5FE05;
	Tue, 13 Aug 2024 21:28:58 +0200 (CEST)
Message-ID: <ab88280b-a775-4833-92a9-42069d5d0350@molgen.mpg.de>
Date: Tue, 13 Aug 2024 21:28:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 4/5] idpf: more info during virtchnl
 transaction time out
To: Manoj Vishwanathan <manojvishy@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, google-lan-reviews@googlegroups.com
References: <20240813182747.1770032-1-manojvishy@google.com>
 <20240813182747.1770032-5-manojvishy@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240813182747.1770032-5-manojvishy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Manoj,


Thank you for your patch.

It’d be great if you made the summary a statement, that means, adding a 
verb (in imperative mood), like:

idpf: Add more info during virtchnl transaction timeout

Am 13.08.24 um 20:27 schrieb Manoj Vishwanathan:
> Add more information related to the transaction like cookie, vc_op, salt
> when transaction times out and include info like state, vc_op, chnl_opcode
> when transaction salt does not match.
> 
> Sample output for transaction timeout:
> -------------------
> Transaction timed-out (op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
> -------------------
> 
> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 30eec674d594..07239afb285e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -517,8 +517,9 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
>   		retval = -ENXIO;
>   		goto only_unlock;
>   	case IDPF_VC_XN_WAITING:
> -		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
> -				       params->vc_op, params->timeout_ms);
> +		dev_notice_ratelimited(&adapter->pdev->dev,
> +				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
> +				       params->vc_op, cookie, xn->vc_op, xn->salt, params->timeout_ms);
>   		retval = -ETIME;
>   		break;
>   	case IDPF_VC_XN_COMPLETED_SUCCESS:
> @@ -615,8 +616,8 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
>   	idpf_vc_xn_lock(xn);
>   	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
>   	if (xn->salt != salt) {
> -		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
> -				    xn->salt, salt);
> +		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
> +				    xn->vc_op, xn->salt, xn->state, ctlq_msg->cookie.mbx.chnl_opcode, salt);
>   		idpf_vc_xn_unlock(xn);
>   		return -EINVAL;
>   	}


Kind regards,

Paul

