Return-Path: <netdev+bounces-290316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKvJECHWDmr2CQYAu9opvQ
	(envelope-from <netdev+bounces-290316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:53:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD045A2B96
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D5EE3004D12
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19A37703A;
	Thu, 21 May 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b="bXiOjmMW"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D812283CB5;
	Thu, 21 May 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.75.2.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356273; cv=none; b=b6HeJ3q11h63d4XLOdU6vz3kyt5IiYPihPREj9hcQtGkKt0ZXq69sp/cs8WZxzdthh1GJobM74s0lYUoDXgA5RWcXFFfPxgRef2+7+bAlLZtG0nL3PD0mqF0KYEYZttHhF4jnLlSkOsM4EBCspuAVNZEsjDH/IsyjSpZkPRrztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356273; c=relaxed/simple;
	bh=Wl/rN+uimoOVAIOMUx6li+N/fOPzSh9uL0WigNYNw6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqUKGjeO/ymdv/5l3YM7/LuzRHdVvjTYQJR6u8whfvVwf8Wsnfaeo43+zaQX1LfTJI14mSzBqOnmt41Vz1bKjoHI31FFarNCi/fF1T2ZPPSBhU5I00mfGHQxXcvOWvDBkEmTF/QAIW4c0H4agyH0gbvjRXd3KwLQARe8QE51tnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de; spf=pass smtp.mailfrom=ikt.uni-hannover.de; dkim=pass (2048-bit key) header.d=uni-hannover.de header.i=@uni-hannover.de header.b=bXiOjmMW; arc=none smtp.client-ip=130.75.2.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ikt.uni-hannover.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikt.uni-hannover.de
Received: from [172.23.180.109] (gateway.ikt.uni-hannover.de [130.75.73.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 132AF1BC;
	Thu, 21 May 2026 11:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-hannover.de;
	s=2024all; t=1779355949;
	bh=Wl/rN+uimoOVAIOMUx6li+N/fOPzSh9uL0WigNYNw6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bXiOjmMW9x7e2V8CUqs7T2almVyY8ncb6gdAnjM8vAfbNnnoplKFZQAYo6AKsKwWj
	 TRcYQtcgkZ8fxDsunQ55QNzmfGMG6YejZi8fsAxcOExMgjFquwnPS8V95qy1gswdp4
	 a6soBUF8ZaIlO9uCxzgLYIbdQLG02iB7vrjWb0ZaU93LQhqjhNbrcJ0JWRXNnCv4OI
	 i4p92gv5VNMC34dJNXNrrS07cqkKmGNcDEZhsdnNauGbnunKgV8M4v89Aya8FvvcYS
	 euzkM5/dw/WfnX4Ib72LZ31Z9c3xjDbp6RhzSpSo7aWCSmzAh7UoaITPc5D77nGInt
	 kMM/i6Ch+8qmQ==
Message-ID: <9a7a764d-afb0-43d6-a96e-dc4652db5fff@ikt.uni-hannover.de>
Date: Thu, 21 May 2026 11:32:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCHv2 net-next] tcp: Add TCP ROCCET congestion control
 module.
To: Jakub Kicinski <kuba@kernel.org>, t.fuechsel@gmx.de
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <agMMMUotXaG_Ypqz@volt-roccet-vm>
 <20260516011212.1859280-1-kuba@kernel.org>
Content-Language: de-DE
From: Lukas Prause <lukas.prause@ikt.uni-hannover.de>
In-Reply-To: <20260516011212.1859280-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uni-hannover.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[uni-hannover.de:s=2024all];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290316-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmx.de];
	DKIM_TRACE(0.00)[uni-hannover.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas.prause@ikt.uni-hannover.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uni-hannover.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ikt.uni-hannover.de:mid]
X-Rspamd-Queue-Id: 5DD045A2B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Thanks for the review.

On 5/16/26 03:12, Jakub Kicinski wrote:
> Can the srRTT calculation cause a catastrophic integer underflow?
> If a socket has not yet received a valid RTT sample, curr_rtt
> remains 0. When roccettcp_cong_avoid() executes, it calls
> update_min_rtt(), which computes curr_min_rtt as max(0, 1),
> resulting in 1. Then update_srrtt()calculates curr_rtt -
> curr_min_rtt (0 - 1). Since both are unsigned 32-bit integers, does
> this underflow to 0xFFFFFFFF? Multiplying this by 100yields
> 0xFFFFFF9C, which gets integrated into the curr_srrtt EWMA. Would
> this resulting massive value instantly exceed the threshold and
> falselytrigger a severe bufferbloat response that permanently
> cripples the congestion window?
Yes, this is a problem. We will add a check if curr_rtt < min_rtt

> Are the congestion control state variables curr_rtt and curr_srrtt
> properly initialized? In roccettcp_reset(), memset zeroes the
> statestruct only up to the curr_rtt field, leaving curr_rtt and
> curr_srrtt uninitialized. If a user dynamically switches an active
> socket's congestion control to ROCCET via setsockopt, could the
> icsk_ca_priv area contain leftover memory from the previous
> algorithm? Might these garbage values be fed into the core RTT
> logic, causing unpredictable bufferbloatdetection and spurious
> throughput drops?
We will initially initialize the whole struct to 0 using sizeof instead
of offsetof.

> Is it safe to expose internal TCP congestion control callbacks as
> BPF kfuncs? The module natively hooks into the TCP stack, but it
> annotates its static internal functions with __bpf_kfunc and exports
> them via register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS). Does
> this allow arbitrary BPF struct_ops programs to call these native
> state-modifyingfunctions directly? Could a BPF program invoke these
> functions on a socket using a different congestion control
> algorithm, blindly casting sk->icsk_ca_priv to struct roccettcp and
> corrupting the socket's internal state?
Not sure which functions are meant.
In my understanding, all exposed functions are the ones that
algorithms like CUBIC, BBR, or dctcp also expose...
The same problem (reinterpreting the memory layout of the private sk
data as a roccet struct applies to the bbr struct in tcp_bbr.c. So I am
unsure if we should just not expose the callbacks as kfuncs or leave
them in)

> Could the 16-bit ACK rate counter wrap around on high-speed links?
> The ack_rate.cnt field is defined as a u16, accumulating the number
> of acknowledged segments over a 100ms interval. On modern fast
> links, more than 83,000 segments can be acknowledged in a single
> 100ms window. Will this silently overflow multiple times per
> interval, recording an artificially low, randomized rate and
> breaking the slow start exit conditions?
That could well happen here. We will change the type to u32.

> Does the interval boundary logic discard acknowledged packets? In
> update_ack_rate(), when the 100ms interval rolls over, the interval
> state rotates and ack_rate.cnt is reset to 0. This happens inside
> an if/else block where the else branch contains the counter
> increment. Because the else branch is bypassed during a rollover,
> are any segments acknowledged by the specific ACK packet that
> triggered the boundary cross permanently discarded, causing a
> persistent undercounting of the throughput?
Yes, should probably reset the counter to acked instead of back to 0.

> Can a timestamp wraparound freeze ACK rate tracking for idle
> connections? The update_ack_rate() function evaluates elapsed time
> via an explicit signed cast of a 32-bit microsecond timestamp delta.
> Since this timestamp wraps around roughly every 71 minutes, if a
> socketremains idle for more than about 35 minutes, the unsigned
> delta exceeds 0x7FFFFFFF. Would the signed cast convert this into
> a large negative number, rendering the interval condition false,
> freezing the interval logic, and causing the counter to accumulate
> indefinitely without rotation?
Yes, but usage of the after() function should resolve this. We will add
this.

> Are ECN marks being ignored and cached, leading to spurious later
> drops? In roccet_in_ack_event(), receiving an ECE flag sets
> ece_received to true. However, in roccettcp_cong_avoid(), this flag
> is only evaluated and cleared if curr_srrtt exceeds roccet_xj. If
> an ECN mark arrives while the RTT is low, is it ignored, leaving
> ece_received stuck at true? Could this stale flag falsely trigger a
> severe congestion window reduction hours later if the RTT naturally
> spikes above the threshold?
We will change this. ECN should always be handled.

> Is there a division by zero vulnerability during module
> initialization? The variables beta and bic_scale are configurable
> module parameters. In roccettcp_register(), bic_scale is used
> directly in a do_div() call, and beta is used in a denominator.
> If the module isloaded with bic_scale set to 0 or beta set to 1024,
> will this instantly cause a division-by-zero kernel panic?
This is CUBIC's code. Should we add a check there?

> Does the implementation match its stated ACK rate bufferbloat
> detection mechanism? The commit message states that the rate is
> sampled over 5 RTT intervals, and slow start exits if the rate stays
> on the same level. However, the code uses a hardcoded 100ms
> interval, and the exit condition only triggers if the new rate drops
> by 10 or more segments. If the rate genuinely stays on the same
> level, the difference is 0. Does this completely fail the check?
The evaluation of the ack rate diff is faulty. In fact, it would
evaluate false if it were true. We will change this.

