Return-Path: <netdev+bounces-178823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB8A790D8
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F463AD0C8
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A823875A;
	Wed,  2 Apr 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph4myG4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934338DE1;
	Wed,  2 Apr 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603065; cv=none; b=dTu/iQDv3dQJYAI0e4wp3M9VQIfgclL5dnY74FSAv6DcG5X1PwDT2Fd+/0Z/PUB+K5VXaV2Ir2nlEzxr5mzpQeKciCtJG03OiomAM3Ye4wNVRE3ZRhWS0BtzC8hkLLQHuey92MRZYsb9nQhmIjlkVsT/cGlnxhnW1T4vZd4H7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603065; c=relaxed/simple;
	bh=mXmvOyKliUAhtFUSnvA5So5JGIV54c37KEje9vRBcqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIqjylyFKj6rvY7W6nrpdaHlyWIoLBezcA3bXG50GvnV4ckcBlMwXg/IvRrjYR0/bJ6ryvBOT7Z1iGheWL2qgB4L3WnEKOQID6mVFUwJOHIWD49dnUCLOFoBxUCUHG/3yFNTCEj/jEM6qy7hcq0MXzwgg6xXnBVQkkZtTeI5G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph4myG4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06080C4CEDD;
	Wed,  2 Apr 2025 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743603064;
	bh=mXmvOyKliUAhtFUSnvA5So5JGIV54c37KEje9vRBcqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ph4myG4A/o6iFdK22xWE0QaJn2WsYIgOOaZS+R3nq+8dnayMB8+NWC5ev62Du7dG4
	 4Npluldnn0nGR3iPiAspTTSL6zpoSB5/Rp5llZln1BORxsCYMZDQjFHhNSWmK086bl
	 D5RZ0/0/aZOCj4beKA7mTrTvD7ORf4+a5Y9jtIre97yVmLmPddm1ucRA/UHfr7VD/+
	 cMvTAz9gHXFZbcM/hr3UTiROZKsj5OrsSuG5plFPQaWdY+qYHDM91m318xgehJPmUv
	 mGLaZKaXmiZr/JzKfwh7IpHvsvgIwujFyVRZnLL3oOT3JuRJOEkxGLqbTW33oRB0Fy
	 KrzmWfwlU/g/A==
Message-ID: <102dfbdc-4626-4a9c-ab8a-c8ce015a1f36@kernel.org>
Date: Wed, 2 Apr 2025 08:11:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
 <20250226-daft-inchworm-of-love-3a98c2@leitao>
 <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
 <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
 <Z+00OTntj9ALlxuj@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Z+00OTntj9ALlxuj@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 8:57 AM, Breno Leitao wrote:
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 1a40c41ff8c30..cd90a8c66d683 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -259,6 +259,29 @@ TRACE_EVENT(tcp_retransmit_synack,
>  		  __entry->saddr_v6, __entry->daddr_v6)
>  );
>  
> +TRACE_EVENT(tcp_sendmsg_locked,
> +	TP_PROTO(struct msghdr *msg, struct sk_buff *skb, int size_goal),

How about passing in the sk reference here; not needed for trace
entries, but makes it directly accessible for bpf programs.

Otherwise, LGTM.

