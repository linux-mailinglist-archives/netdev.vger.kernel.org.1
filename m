Return-Path: <netdev+bounces-281314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB+gLzY972mD+gAAu9opvQ
	(envelope-from <netdev+bounces-281314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674D47121E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AEFE3003E87
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97527399001;
	Mon, 27 Apr 2026 10:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93C245005;
	Mon, 27 Apr 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286452; cv=none; b=S5FniGO8luVy1a6+4oiSIJb6xP+I9zGe3JU2RT0175mj4r/GUYlziiF/p/JJly/pTZFOF5weP7QeDgea+HxAgGmpOykmP1iKdNmB6Z/AzFo7oaJPQkQ5R62naLT9iFgBw1p3SOWaulHOswfhXNx85onNPsOcAv37p2JLEUjoAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286452; c=relaxed/simple;
	bh=zIyORH2OmHKEZ0f5Rmsn1/v+UpjmsyIbl5Li1L7nKgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndBpZLYpV5VcjI6wg+RcCVdHVFC2X5a1CJcJOyqUPAlR+XgndIo2w98w2WJMvwMs+k4NXWyvODA3/hMFpOV6hyEZONmmvy6LzavlY6JLsy0/h6ZMRE4zKstCUvKs6QBPq2yuRKPbLpI+9zd/TYo8F1TpaFuNhtwdi0i8ZrQywDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB4764C2C37D45;
	Mon, 27 Apr 2026 12:40:17 +0200 (CEST)
Message-ID: <2d8bd703-f368-4405-9266-d0d8824455aa@molgen.mpg.de>
Date: Mon, 27 Apr 2026 12:40:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
To: Li Li <boolli@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Decotigny <decot@google.com>, Anjali Singhai
 <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
References: <20260424031545.3777023-1-boolli@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260424031545.3777023-1-boolli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5674D47121E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281314-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[molgen.mpg.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Dear Li,


Thank you for your patch.

Am 24.04.26 um 05:15 schrieb Li Li via Intel-wired-lan:
> Virtchnl failures can be hard to debug without logs. Logging the details
> of virtchnl transactions can be useful for debugging virtchnl-related
> issues.

Why is the first added one added as error, and the second as info?

Do you have a reproducer to get each of the new log messages?

> Tested: Built and booted on a test machine.

Please paste the new messages.

> Signed-off-by: Li Li <boolli@google.com>
> ---
>   drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> index ebc05355e39d..7eaa77413621 100644
> --- a/drivers/net/ethernet/intel/libie/controlq.c
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_recv_params *params,
>   	status = ctlq_msg->chnl_retval ? -EFAULT : 0;
>   
>   	xn = &xnm->ring[xn_index];
> +
> +	if (ctlq_msg->chnl_retval) {
> +		dev_err_ratelimited(
> +			params->ctlq->dev,
> +			"Non-zero virtchnl ret val (msg op: %u, ret val: %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
> +			ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
> +			msg_cookie, ctlq_msg->data_len, xn->virtchnl_opcode,
> +			xn->index, xn->cookie);
> +	}
> +
>   	if (ctlq_msg->chnl_opcode != xn->virtchnl_opcode ||
>   	    msg_cookie != xn->cookie)
>   		return false;
> @@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
>   		params->recv_mem = xn->recv_mem;
>   		break;
>   	default:
> +		dev_notice_ratelimited(
> +			params->ctlq->dev,
> +			"Transaction failed (op %u, xn state: %d, id: %u, cookie: %u, size: %zu)\n",
> +			params->chnl_opcode, xn->state, xn->index, xn->cookie,
> +			xn->recv_mem.iov_len);
>   		ret = -EBADMSG;
>   		break;
>   	}


Kind regards,

Paul

