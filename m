Return-Path: <netdev+bounces-151669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F89F0806
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD96B168921
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B91B3945;
	Fri, 13 Dec 2024 09:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397B1B21BD;
	Fri, 13 Dec 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082638; cv=none; b=bO09kuXcczmFy8p8I5S4+cWAVIZd2RWVzQ0FaZ25upiLwwQN4rLUk3E9+OxdZhN2ss5dXv6DSgWZArSmxNSHqWNAcCeCFISiH13DkynBzo+A1ZSclJU2+nDryob0tk83vHAZmSJDPqAzgtTiHPUCaFNtl4SwBc3Xadep1avFttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082638; c=relaxed/simple;
	bh=Mo9Z67jFIiZICtAQQ1EDqzcjkIR1b4mu13cvc1qGynU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZIeDKYn3DPtIz57E/x1ujj2CinUl/KI654VRCSpxvT1pT4332U+zlSF9X38IemgrdcoJQQ6zy+lFxekPJtBeVrWuakTa6u27kWu2E7KxlGL9AuVD18XJTBQN5TGMcoliq+vRk0Y3kCBG41DrSASFre3JAa/H20jsF49nI2M57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af5e3.dynamic.kabel-deutschland.de [95.90.245.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2C6AE61E646F9;
	Fri, 13 Dec 2024 10:36:42 +0100 (CET)
Message-ID: <bc95ab79-6b4a-41be-b5b7-daaec04f23d0@molgen.mpg.de>
Date: Fri, 13 Dec 2024 10:36:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next PATCH v3 3/3] idpf: add more info
 during virtchnl transaction time out
To: Brian Vazquez <brianvv@google.com>,
 Manoj Vishwanathan <manojvishy@google.com>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>,
 Vivek Kumar <vivekmr@google.com>, Anjali Singhai <anjali.singhai@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>
References: <20241212233333.3743239-1-brianvv@google.com>
 <20241212233333.3743239-4-brianvv@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241212233333.3743239-4-brianvv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Brian, dear Manoj,


Thank you for your patch.

Am 13.12.24 um 00:33 schrieb Brian Vazquez:
> From: Manoj Vishwanathan <manojvishy@google.com>
> 
> Add more information related to the transaction like cookie, vc_op,
> salt when transaction times out and include similar information
> when transaction salt does not match.

If possible, the salt mismatch should also go into the summary/title. Maybe:

idpf: Add more info during virtchnl transaction timeout/salt mismatch

> Info output for transaction timeout:
> -------------------
> (op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
> -------------------

For easier comparison, before it was:

(op 5015, 60000ms)

> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 13274544f7f4..c7d82f142f4e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -517,8 +516,10 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
>   		retval = -ENXIO;
>   		goto only_unlock;
>   	case IDPF_VC_XN_WAITING:
> -		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
> -				       params->vc_op, params->timeout_ms);
> +		dev_notice_ratelimited(&adapter->pdev->dev,
> +				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
> +				       params->vc_op, cookie, xn->vc_op,
> +				       xn->salt, params->timeout_ms);
>   		retval = -ETIME;
>   		break;
>   	case IDPF_VC_XN_COMPLETED_SUCCESS:
> @@ -615,8 +613,9 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
>   	idpf_vc_xn_lock(xn);
>   	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
>   	if (xn->salt != salt) {
> -		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
> -				    xn->salt, salt);
> +		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
> +				    xn->vc_op, xn->salt, xn->state,
> +				    ctlq_msg->cookie.mbx.chnl_opcode, salt);
>   		idpf_vc_xn_unlock(xn);
>   		return -EINVAL;
>   	}

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

