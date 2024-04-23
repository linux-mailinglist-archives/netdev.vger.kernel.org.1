Return-Path: <netdev+bounces-90431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6B8AE1AF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21198283DA7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150360DFB;
	Tue, 23 Apr 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfEfuua9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54875FBAA;
	Tue, 23 Apr 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866540; cv=none; b=aeNk4duMuSPX8qI3dBrWE4qQm2ZHJdRuNWWr+Mx/OfvxdqPbOheq2F+sSDjUUg8l0acE+yJnM89sq7+PpBYN4gfbp1iL2zdiW0Q5ua1pwrhEnz1u01l+mq5quLanSjAmJ+QOgQaKaOtLWFztMdyg8SKDZk+COpw92WjYa1W3f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866540; c=relaxed/simple;
	bh=roHevk8etALCBrRz2KDXK9F53loOjFxJP/aOxjGpleo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vp0omaqhkqUNOu1/EZLTNOFyWp+0G+bMFPCmymFC8iNtz4PRSPRWtHakxtDtgP/iSg6j80Rw7eaKwPpWYH/hn16uM5y09BppVm4aNls7hO6MetyIZBlB3xHyXvBkKXRHlKSB3bqQarVYv+4zZ7nh+fsoVMz5/eIU25jytUWYufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfEfuua9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D734CC2BD11;
	Tue, 23 Apr 2024 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713866540;
	bh=roHevk8etALCBrRz2KDXK9F53loOjFxJP/aOxjGpleo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OfEfuua93euOvHR3DhnMSLa5ipxTDgnCLldGfzhSSOs0T1GrUJT/UYal87/tcntY5
	 kIzH2cbPg2/eJ+bxYPHlcooeybIvKBjl2yu/DCaSrxdJ3GwfTd35kUYwFCzSubHT2D
	 A0CoTJDB+AEU/Z6rrygJcz33BKn9TUfzG23IE+RMs1rsS9AZ36KqCkFgSDjIwHzolV
	 /Ofi+o2qK/Z8FUt8GDQVeGzII5UUBibjOiWC1pvNq23dwAOEcXREm3ZyKkGIqreMs/
	 WcY/WV52n1etlfqF57mTzPiG5VtR/Or14+/uEbuL4fR4cpd5x47hvGrNAWVHa8AX1f
	 NsDwRw3N9bV+Q==
Message-ID: <4ce919ea-6110-4a84-8992-a72a9785c48b@kernel.org>
Date: Tue, 23 Apr 2024 12:02:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v8 5/7] mptcp: support rstreason for passive
 reset
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com,
 dsahern@kernel.org, martineau@kernel.org, geliang@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 atenart@kernel.org, horms@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240423072137.65168-1-kerneljasonxing@gmail.com>
 <20240423072137.65168-6-kerneljasonxing@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240423072137.65168-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 23/04/2024 09:21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> It relys on what reset options in the skb are as rfc8684 says. Reusing

(if you have something else to fix, 'checkpatch.pl --codespell' reported
a warning here: s/relys/relies/)

> this logic can save us much energy. This patch replaces most of the prior
> NOT_SPECIFIED reasons.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/mptcp/protocol.h | 28 ++++++++++++++++++++++++++++
>  net/mptcp/subflow.c  | 22 +++++++++++++++++-----
>  2 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fdfa843e2d88..bbcb8c068aae 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -581,6 +581,34 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
>  	WRITE_ONCE(subflow->local_id, -1);
>  }
>  
> +/* Convert reset reasons in MPTCP to enum sk_rst_reason type */
> +static inline enum sk_rst_reason
> +sk_rst_convert_mptcp_reason(u32 reason)
> +{
> +	switch (reason) {
> +	case MPTCP_RST_EUNSPEC:
> +		return SK_RST_REASON_MPTCP_RST_EUNSPEC;
> +	case MPTCP_RST_EMPTCP:
> +		return SK_RST_REASON_MPTCP_RST_EMPTCP;
> +	case MPTCP_RST_ERESOURCE:
> +		return SK_RST_REASON_MPTCP_RST_ERESOURCE;
> +	case MPTCP_RST_EPROHIBIT:
> +		return SK_RST_REASON_MPTCP_RST_EPROHIBIT;
> +	case MPTCP_RST_EWQ2BIG:
> +		return SK_RST_REASON_MPTCP_RST_EWQ2BIG;
> +	case MPTCP_RST_EBADPERF:
> +		return SK_RST_REASON_MPTCP_RST_EBADPERF;
> +	case MPTCP_RST_EMIDDLEBOX:
> +		return SK_RST_REASON_MPTCP_RST_EMIDDLEBOX;
> +	default:
> +		/**

I guess here as well, it should be '/*' instead of '/**'. But I guess
that's fine, this file is probably not scanned. Anyway, if you have to
send a new version, please fix this as well.

(Also, this helper might require '#include <net/rstreason.h>', but our
CI is fine with it, it is also added in the next commit, and probably
already included via include/net/request_sock.h. So I guess that's fine.)


Other than that, it looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


