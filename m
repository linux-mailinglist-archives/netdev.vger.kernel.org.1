Return-Path: <netdev+bounces-300011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 30d8FW8WMmp5ugUAu9opvQ
	(envelope-from <netdev+bounces-300011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE66964F3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=wdQ6v53i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300011-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97A943003BD6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193253112B2;
	Wed, 17 Jun 2026 03:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD9303C9C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:37:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667433; cv=none; b=fjXsjW98SgDoW0/Cobee9HAM60tjViAYU6q0koljYzYKGDJFvO0cfEH2OqjX2Z3C//3u2NkvDr289z1uIa22ldXQlqEwQ4Te7yyyJk2YAEif8HDL4t6YRZESRn6ML77z62ZuCNpqnd4e+hsoAD7rEJK0QtPhCM8QSATIBwJ7URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667433; c=relaxed/simple;
	bh=3CT2z620rf2EyjaSWmGg2tRgTSPfnmVmEtSzd5fK6cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lX7c81pHSNjW4ukpfq+pTIBowWvrhH/2yyWpPPMQVeRiSki67YoOKVU3A6IxVla/PpsEkLX2OquVoBXw+RrOcxejYKH/yOYB0n76kulZxB03OqCGNg49+fKdsI0kj2GQxyzXe6dCd+DysDfiwwYGYTIXnWE3NRSTwAJ4WGo4DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wdQ6v53i; arc=none smtp.client-ip=91.218.175.186
Message-ID: <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781667419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UPW9kkwGh5wpDgrLNe8OYP2oXRcB9R26cFMQbJWnA=;
	b=wdQ6v53i0T/kFiN5+0oK1L8fu4Q2DOzeMJsubj4iZDEAlsoKyCAH/A87B0MWUHdK2aBJX8
	6qxZlFkwAKumXbNTCel4Utnz7i0Gyb76E+czkksNiUm0AlSfXrjReIa+hIQiUyXIWwX8Rw
	9UqBA+NVCMXKxwgoLliAg/o9zHA09WE=
Date: Wed, 17 Jun 2026 11:36:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Paul Chaignon <paul.chaignon@gmail.com>, Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>
References: <20260613183424.1198073-1-jordan@jrife.io>
 <ajAXF8Nvg91xU4f2@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <ajAXF8Nvg91xU4f2@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300011-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,jrife.io];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57CE66964F3


On 6/15/26 11:15 PM, Paul Chaignon wrote:
> On Sat, Jun 13, 2026 at 11:34:04AM -0700, Jordan Rife wrote:
>> We have several use cases where a pod injects traffic into the datapath
>> of another so that the traffic appears to have originated from that
>> pod. One such use case is a synthetic flow generator which injects
>> synthetic traffic into a pod's datapath to enable dynamic probing and
>> debugging. Another is a transparent proxy where connections originating
>> from one pod are redirected towards another which proxies that
>> connection. The new connection is bound to the IP of the original pod
>> using IP_TRANSPARENT and its traffic is injected into that pod's
>> datapath and handled as if it had originated there. This can be used for
>> mTLS, etc.
>>
>> We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
>> flow generator, etc. towards the target pod, ensuring that eBPF programs
>> that are meant to intercept traffic leaving that pod are executed.
>> However, this doesn't work with netkit.
>>
>> With netkit, an ingress redirection from proxy to workload skips eBPF
>> programs that are meant to intercept traffic leaving the pod, since they
>> reside on the netkit peer device. One workaround is to attach the
>> same program to both the netkit peer device and the TCX ingress hook for
>> the netkit pair's primary interface, but
>>
>> a) This seems hacky and we need to be careful not to run the same
>>     program twice for the same skb in cases where we want to pass that
>>     traffic to the host stack.
>> b) We're trying to keep the proxy redirection / traffic injection
>>     systems as modular and separated from Cilium as possible, the system
>>     that manages netkit setup and core eBPF programming.
>>
>> It would be handy if instead we could redirect traffic directly from
>> one netkit peer device to another. This patch proposes an extension
>> to bpf_redirect_peer to allow us to do just that.
>>
>> With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
>> the skb in the egress direction of the target interface's peer device
>> While the main use case is netkit, I suppose you could also use this
>> mode with veth as well if, e.g., there were some eBPF programs attached
>> to that side of the veth pair that needed to intercept traffic.
>>
>>   +---------------------------------------------------------------------+
>>   | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>>   | | pod (10.244.0.10)       |           ------------------------      |
>>   | |                         |          |                        |     |
>>   | |              +--------+ |          |      +---------+       |     |
>>   | | 1. packet -->|        | |          |      |         |       |     |
>>   | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>>   | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>>   | |           |  |        | |          |      |         |       |     |
>>   | |           |  +--------+ |          |      +---------+       |     |
>>   | |           |             |          | 2. bpf_redirect        v     |
>>   | +-----------|-------------+          |___________________   +-------|
>>   |             |                                            |  | eth0  |
>>   |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
>>   |             |________________________                    |          |
>>   | +-------------------------+          |                   |          |
>>   | | proxy (10.244.0.11)     |          |                   |          |
>>   | | IP_TRANSPARENT          |          |                   |          |
>>   | |              +--------+ |          |      +---------+  |          |
>>   | | 3. packet <--|        | |          |      |         |<--          |
>>   | |    enters    | netkit |<===========|======| netkit  |             |
>>   | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>>   | | 4. packet -->|        | |                 |         |             |
>>   | |    leaves    +--------+ |                 +---------+             |
>>   | |    sip=10.244.0.10      |                                         |
>>   | +-------------------------+                                         |
>>   +---------------------------------------------------------------------+
>>
>> Using the proxy use case as an example, in step 5 we would redirect
>> traffic leaving the proxy towards the pod's peer device using
>> bpf_redirect_peer(BPF_F_INGRESS).
>>
>> As a bonus, since the skb doesn't have to go through the backlog queue
>> it can take full advantage of netkit's performance benefits. I set up a
> The motivation makes sense. Cilium could probably use this as well to
> avoid some of the hacks we have around proxy reinjection.
>
>> test where outgoing iperf3 traffic is injected into the datapath of
>> another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
>> bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
>> which skips the host stack and uses BPF redirect helpers to do all the
>> routing.
>>
>>    (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>>     eBPF host routing mode)
>>
>> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>>    1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>>    3. eth0        ==over network==>                         [host b]
>>
>>    [ ID] Interval           Transfer     Bitrate         Retr
>>    [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>>    [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
>>
>> TEST [bpf_redirect_peer(BPF_F_INGRESS)]
>>    1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
>>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
>>    3. eth0        ==over network==>                              [host b]
>>
>>    [ ID] Interval           Transfer     Bitrate         Retr
>>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
>>
>> In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
>> [iperf pod] to [pod b] led to ~18% more throughput compared to
>> bpf_redirect(BPF_F_INGRESS).
>>
>> Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
>>        might be confusing, since technically it's an egress redirection
>>        from the perspective of the peer device's namespace. But, I didn't
>>        want to add a BPF_F_EGRESS flag just for this and convinced myself
>>        it makes sense, because from the perspective of the caller the skb
>>        will be flowing towards the current namespace.
> IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> can't have the same flag API between bpf_redirect() and
> bpf_redirect_peer(), but this is creating inconsistent semantics for
> the terms egress/ingress across the two helpers.


Agree.


For the existing bpf_redirect_peer(ifindex, 0), there are two ways to 
read what 0 means:

1. If we consider the operated object to be the peer of ifindex, then 0 
means the peer does ingress.
2. If we consider the operated object to be ifindex itself, then 0 means 
ifindex does egress
    (which results in its peer doing ingress).

This patch's new mode operates on the peer — on the host side, we want 
to "write" to the dev inside the pod to
make the packet look like it leaves the pod. That fits reading (1), where
the flag describes the peer's direction: 0 is peer ingress, and this new 
mode is peer egress.
So BPF_F_EGRESS would be the clearer name; reusing BPF_F_INGRESS for 
what is really a
peer-egress action is what creates the ambiguity.



