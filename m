Return-Path: <netdev+bounces-183817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99AA92209
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC193BC102
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AE6253F28;
	Thu, 17 Apr 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmcUD5SB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD97253330;
	Thu, 17 Apr 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905331; cv=none; b=HNvDPTUPMJtFGMAYlg/+B56NLRtETRPSXkNJrGMdWYJ7tcHXtQm/dIBRlZ3qlJw6w16BUAt6HOBYN5BvANPk7ojJPFyE5KMiNmqBZPk/qRhhB361jI9ixmBlXxn946cmVfJ7CI268Ta0TG14kqqTMCsYtWcadXzBsZhJRCxmpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905331; c=relaxed/simple;
	bh=uqXB5hQMy+O6+dxOPD6g6i2N8HH0PKNLF6ysDWlwvpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4M3KLTvuCAFu04PS8LynLopTWceUa8nh8NZZYNQmIYmjPF9d4bcj3o9qTnD8TIfTxA7Gxq7r/KB+qrryU1YrxgFNIeDXsac8e5ECwhkrEdwdwS7RitC4u5XgLwFBROpAapQobHmT7yPU5XKNYnY2wDSvWjJ5FbvKG1VDB6zJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmcUD5SB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701EBC4CEE4;
	Thu, 17 Apr 2025 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744905331;
	bh=uqXB5hQMy+O6+dxOPD6g6i2N8HH0PKNLF6ysDWlwvpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TmcUD5SBfQf9xxRyFSrqbSGda+7OAJcsmsUknQ1+J1RWjBi8Tby7hdXrfprrMwDoU
	 eBA8veAsvXMlCwD7Fpp6A7u57tWYHgyCaFofqvGSV+mlDL2YRwX6Djb4Cd/hnPDYxA
	 JnV4RPM5AqP5I6PT3R0MWE1VZayALRCxL1ROWZscHdo8rfKx1dNkRu9ZVBxGGUu9qK
	 a701VkjZTHa8Dr5LfPtzFQrLGK7nOq0GPN3o1W7Z5Wf8tWzAW+DWPxAMpFH1QrWoEi
	 URCf2+waU4wXRws9MjnsPMSc5ACnUqoZcvzk5j9ov/DV1+xnCkzV5F/0OWin6y9KKG
	 ChcFxJdBNnHqQ==
Message-ID: <8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>
Date: Thu, 17 Apr 2025 08:55:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
 <aADpIftw30HBT8pq@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aADpIftw30HBT8pq@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 5:42 AM, Breno Leitao wrote:
> Hello David,
> 
> On Wed, Apr 16, 2025 at 04:16:26PM -0700, David Ahern wrote:
>> On 4/16/25 1:23 PM, Breno Leitao wrote:
>>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>>> index f9f5b92cf4b61..8c2902504a399 100644
>>> --- a/net/ipv4/udp.c
>>> +++ b/net/ipv4/udp.c
>>> @@ -1345,6 +1345,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>>  		connected = 1;
>>>  	}
>>>  
>>> +	trace_udp_sendmsg_tp(sk, msg);
>>
>> why `_tp` suffix? the usual naming is trace_${func}
> 
> I got the impression that DECLARE_TRACE() raw tracepoints names end up
> in _tp():
> 
> 	include/trace/events/tcp.h
> 	DECLARE_TRACE(tcp_cwnd_reduction_tp,

that is the only networking one:

$ git grep trace_ net drivers/net | grep _tp
net/bpf/test_run.c:	trace_bpf_trigger_tp(nonce);
net/ipv4/tcp_input.c:	trace_tcp_cwnd_reduction_tp(sk,
newly_acked_sacked, newly_lost, flag);

The rest follow do not have the _tp suffix:

$ git grep trace_ net drivers/net | wc -l
    2727

2725 without; 2 with


