Return-Path: <netdev+bounces-151483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB09EFADB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102E318819A0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D6216E18;
	Thu, 12 Dec 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNZovEhM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D320ADD9;
	Thu, 12 Dec 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027789; cv=none; b=gkNr71BIEO6n3rQS1axOCauS41CW7F2l8KhrSENS1KuXAV6yRvpOV6LGwH/V6r+OFjl8xx0Q3sBnyxVWqO/5K+A2xDNit0FdPH0zljZ2xR7BXVo8Dh6J9ZkmxccCxFuiG/sITDCJQGvWY5pSSv09iokm5KGWF2q0SXcbFtQGRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027789; c=relaxed/simple;
	bh=0tBw7FNXXDhn1NgrGqLM8/xV/nKYvK9yh4IKaphBUWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGHEExHIfLBF+78JCX55yZ0mtk/n+VL6wGVNQe2zIf8ewpJyC9L913IoTU2/L+hYdtQ8iHrjLdaozwf9n/aneG+nayCZ4+LiFXlHrM/iq0VE7ay4zlnHEEyazgTyLV+dt/J/fqq8JXDm6yatelvu0ebMy3kBzXrYb8fk1jb/6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNZovEhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE45C4CECE;
	Thu, 12 Dec 2024 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734027788;
	bh=0tBw7FNXXDhn1NgrGqLM8/xV/nKYvK9yh4IKaphBUWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pNZovEhMBtBv1codrEhTlVVBz2gNZM0C8/t1bfXEJm7ozwBpDmFqMVNcuyCB3NGsm
	 QOgVuWe8/Gu/V+Cxfh0XSm8HZ+xwwQz3GToI9mOyHwHLWj18qV2Vt8fzGmRzRICDAF
	 KlcvVxAeBFYj0ufDspbH37JgFCbvBjVGHly6Ewfeb7cIA4JeJBhL1xNnrA/nrh5LWe
	 wPanizlTgZixZoGKehgzRRHLWeUaCUI7S8wbouoLboq4pMkMNmrhzLtGZvHCvcEVMF
	 +NJW36umAYO5++8W6gLjeFCE1NS7KSwwP1Cw0l9W17AJDO6/hvLaQqivxEKc4lQ+PF
	 dWEJhaAbdvTPQ==
Message-ID: <902d0bec-abca-4e7c-be43-be2fa1c6ce02@kernel.org>
Date: Thu, 12 Dec 2024 19:23:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next] mptcp: fix invalid addr occupy 'add_addr_accepted'
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_0FE3ED0442E69C9D86C0AEEE338A49F90305@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

Thank you for this patch!

I have a few suggestions below. Do you mind sending the next version(s)
to the MPTCP list only, no need to include the netdev ML and the net
maintainers for the moment I think.

On 11/12/2024 10:03, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch fixes an issue where an invalid address is announce as a
> signal, the 'add_addr_accepted' is incorrectly added several times
> when 'retransmit ADD_ADDR'. So we need to update this variable
> when the connection is removed from conn_list by mptcp_worker. So that
> the available address can be added in time.
> 
> In fact, the 'add_addr_accepted' is only declined when 'RM_ADDR'
> by now, so when subflows are getting closed from the other peer,

Does it mean that in this case, the counter will be decreased twice:
when the RM_ADDR is received, and when the subflow is closed, no?

I guess no because you hooked this in a different path, right?

> the new signal is not accepted as well.
> 
> We noticed there have exist some problems related to this.I think
> this patch effectively resolves them.

Please add new test cases for these problems in the MPTCP selftests: to
better understand what is being fixed, and to avoid regressions later.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 21bc3586c33e..f99dddca859d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2569,6 +2569,10 @@ static void __mptcp_close_subflow(struct sock *sk)
>  			continue;
>  
>  		mptcp_close_ssk(sk, ssk, subflow);
> +
> +		if (READ_ONCE(subflow->remote_id) &&
> +		    --msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
> +			WRITE_ONCE(msk->pm.accept_addr, true);

Mmh, I don't think it can be that simple: potentially, an accepted
ADD_ADDR can trigger multiple subflows (i.e. when the fullmesh flag is
used). In this case, the counter has been incremented once, not once for
each created subflow. So before decrementing the counter, it should then
be needed to check if no other subflows connected to the same remote ID
are still alive.

I think it is better not to decrement this counter in "unusual
situations" -- the situation before this patch -- than wrongly
decrementing it, and ended up with an underflow.

Another thing is that subflows might have not been created upon the
reception of an ADD_ADDR: typically if you take the view of a server,
the subflows have been initiated by the client, and not because the
server got an ADD_ADDR. If I'm not mistaken, the counter would be
decremented here as well. We could restrict this by checking
"subflow->request_join" I suppose. Still, I'm wondering if that's
covering all cases, and if we should not track ADD_ADDR that are received:

  https://github.com/multipath-tcp/mptcp_net-next/issues/496

(which is more complex)

Also, because this counter is specific to the in-kernel PM, I think it
would be cleaner f its manipulation is done in pm_netlink.c.

pw-bot: cr

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


