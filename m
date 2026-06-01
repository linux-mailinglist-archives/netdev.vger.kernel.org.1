Return-Path: <netdev+bounces-293782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULFCNHeSHWqScQkAu9opvQ
	(envelope-from <netdev+bounces-293782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39528620886
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF56930166F0
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1937B40A;
	Mon,  1 Jun 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="azJmNSlp"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D02D7814;
	Mon,  1 Jun 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322616; cv=none; b=t4Z2UswsOnqpV2MwZC/5IkVoW1flzsvuRQJlxd9IltGntzvj3DB2XHd1TqpglgpPsDeaYrjd5dpChYJTXXqVQgnQ0kY7O3I8gFY6YC/TPUzweuHXADdML7H0H5/NZ2IB34L4FY3XekUHqBt5hxrn2m6D30CVTkbjeDPpBNtEhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322616; c=relaxed/simple;
	bh=pFJIqDeaWrMvahiHGdcqSxz6FkvVq/4GbXGe1GjxqeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TqMzmPYTJu2ci4SHAi3iaSEaF+y5Cm1YiYGNiMvSPv22MaJbqcNE9giUn7oVntrUBM3eyaLVxoLOzqZ5j5gGC+sbLtSul07gpJrODjVgTtpdgTZTwvRZa/lNVv/vAIfDAyZIjVOQlCOXO7VOe2hW7JX83HhPiOWNYC97/iBMECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=azJmNSlp; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1780322613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDG4VykIhIHhOK+bN90wmmIsdIE+X8I2BhMgPnpIXxs=;
  b=azJmNSlpRMCtoJ+20IqBeagLBuzlblRFeK16luomc502VSuX7g30ONRX
   Kir2QWp7rWR5Zl4C2kapRNB3z5LtZH5KccxReCUp/u35Z8o1ows1htrv5
   G8cFGuMFANiFAx2nBwPM0H06eMaoSizQI3AlxvwAB+rLGOTM/dUSyVbCh
   kBi2+qCdiKsTbJi1u7ROXutoJTRCVBP9oTsdo/3MazJ/+kLBSh3YHMxE5
   hcPXKvNgcHh3eEjbpQL1+TSKR29xdZhhd9Z3KrNdCofW5iuXZp5EMZHKW
   FB/NHTYUX9XD8CDfENffCNI/n6WUJ5XmIp1x2SemQNudXSrq5vTlb1wA1
   w==;
X-CSE-ConnectionGUID: CipTNT3vR42Yltn3nkrzAQ==
X-CSE-MsgGUID: nEG69EGvQ/m53QDp4My90A==
X-IronPort-AV: E=Sophos;i="6.24,181,1774306800"; 
   d="scan'208";a="48077604"
Received: from postcard.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.142])
  by mailrelay.tu-berlin.de with ESMTP; 01 Jun 2026 16:03:25 +0200
Message-ID: <865f31e5-4e90-4dc0-890f-b5796948b590@tu-berlin.de>
Date: Mon, 1 Jun 2026 16:03:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>, <hawk@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <2affe9f4-56a7-4482-931f-9d98cfdf09fd@tu-berlin.de>
 <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
In-Reply-To: <db5b7f7e-135c-40f0-a740-057bc6623e6c@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 39528620886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 2:00 PM, Simon Schippers wrote:
> On 5/28/26 09:46, Jonas Köppeler wrote:
>> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>
>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>
>>> Accumulate BQL completions and flush them when a configurable time
>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>> queuing delay to the configured interval. Coalescing state persists
>>> across NAPI polls in struct veth_rq so completions can accumulate
>>> beyond a single budget=64 cycle.
>>>
>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>> completion.
>>>
>>>     ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>     ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>
>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
>>
> Thanks for your testing!
>
> However, I have issues reproducing.
> I run bare metal (without virtme) with v6 + your pktgen patch
> and I am on the branch pktgen-and-benchmark, commit
> "results: add veth-bql measurements":
>
> 1. ping fails with 100% packet loss ~20% of the times with --pktgen.
>     When this happens the avg ping of this run is mistakenly set
>     to 0.0 ms, which distorts the results.
>     I fixed it locally by rerunning when this happens.
>
> 2. pktgen runs with > 3 Mpps even with --nrules 10000, see log below.
>     I see that this is because of qdisc drops.
>     I also tried pfifo and sfq but with the same result.
>     I spent quite some time on it but I do not know a fix.
>
> Do you have an idea?
> Thanks!

Hi,
yes there are some changes missing in the test script.
I have pushed it now, sorry. This should fix 1.
Regarding 2.: do not look at the pktgen output, in the
new version you will see something like "goodput",
which is the number you should look for.
Pktgen will report at what speed it enqueued packets in
the qdisc.

Let me know if it worked.
Best,
Jonas

> The raw log:
>
> sudo ./veth_bql_test.sh --pktgen --duration 2 --qdisc fq_codel --no-bpftrace --tx-usecs 100 --nrules 10000
> INFO: Setting up veth pair with GRO
> INFO: Threaded NAPI enabled
> INFO: Installing qdisc: fq_codel
> INFO: Loaded 10000 iptables rules in consumer NS
> INFO: kernel: 7.1.0-rc4-patched-20260307+
> INFO: BQL sysfs found: /sys/class/net/veth_bql0/queues/tx-0/byte_queue_limits
> INFO: ethtool tx-usecs set to 100 on veth_bql1 (rx side)
> INFO: Starting ping to 10.99.0.2 (5/s) to measure latency under load
> INFO: Starting pktgen queue_xmit on veth_bql0 (threads=1 pkt_size=64)
>    [5s] BQL inflight=1 limit=17 watchdog=0
>    [5s] qdisc fq_codel pkts=27417 drops=6591520 requeues=14115 backlog=0 qlen=0 overlimits=0
>    [5s] softnet: processed=27960 time_squeeze=0 multi-CPU(6): cpu0(+5) cpu1(+121) cpu2(+33) cpu3(+116) cpu4(+27641) cpu5(+44)
> INFO: Ping loss: 0% packet loss
> INFO: Ping summary: rtt min/avg/max/mdev = 0.127/1.818/2.703/0.761 ms
> INFO: pktgen results (thread 0):
> Params: count 0  min_pkt_size: 64  max_pkt_size: 64
>       frags: 0  delay: 0  clone_skb: 0  ifname: veth_bql0@0
>       flows: 0 flowlen: 0
>       queue_map_min: 0  queue_map_max: 0
>       dst_min: 10.99.0.2  dst_max:
>       src_min:   src_max:
>       src_mac: 0e:aa:4e:05:95:89 dst_mac: c2:e5:a3:4c:2a:7f
>       udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9999  udp_dst_max: 9999
>       src_mac_count: 0  dst_mac_count: 0
>       xmit_mode: xmit_queue
>       Flags: NO_TIMESTAMP  QUEUE_MAP_CPU  SHARED
> Current:
>       pkts-sofar: 6516031  errors: 102854
>       started: 12246566004us  stopped: 12248535234us idle: 0us
>       seq_num: 6516032  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
>       cur_saddr: 10.99.0.1  cur_daddr: 10.99.0.2
>       cur_udp_dst: 9999  cur_udp_src: 9
>       cur_queue_map: 0
>       flows: 0
> Result: OK: 1969229(c1969229+d0) usec, 6516031 (64byte,0frags)
>    3308924pps 1694Mb/sec (1694169088bps) errors: 102854
> TEST: veth_bql                                                      [ OK ]
> INFO: Results: /home/simon/repos/veth-backpressure-performance-testing/results/selftests/2026-06-01T13-24-51
>

