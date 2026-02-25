Return-Path: <netdev+bounces-261004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO2iAuYQn2nMYwQAu9opvQ
	(envelope-from <netdev+bounces-261004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:10:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517401993D9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EE203147CEE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA43D524E;
	Wed, 25 Feb 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItNjkFQb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF03B8BD0;
	Wed, 25 Feb 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032036; cv=none; b=e+LpCyZ1OWSe/rBMJXDQUGIoOQ5VfY1iMoEzKNeW3/MGscth4Q3xFu7OKKmHbhsc56oH7bJi7ZCIq9wazr8GBM5bLjwLSDORdkJD4+uQt2XMaJxR9UrTgIwUGuRIYXfWlsQuJ5nPUZT87d8qCG0LKPPYWDhBb7xZ5pB8rtSpqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032036; c=relaxed/simple;
	bh=8or/mYqaq7JvRRiDNT5LccUd1wdBLjkN/BAK++WiMTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVX2O+6/XFhWyKoJUPO0ARbW/nuYbtXsX3/4+h3fRclAqPfMXDlbw8BtyH+RjmqZ6L5vfNmCAc/QaKsNXq+MlJZYBE0pmvO9usyelHJpzA6I1cnhS52FHIUfvpVjc9fRWVcjlspkqqE54lV9Fx/V8k4FBeopF4gQLnIKK+zBY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItNjkFQb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772032033; x=1803568033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8or/mYqaq7JvRRiDNT5LccUd1wdBLjkN/BAK++WiMTo=;
  b=ItNjkFQb2oRf+zEy5rndh3nMcq5DWcQz5cLQ4vyW3SG9uLYXCquAwELn
   ggDCoTeZHzFSHsnSOOalnweRS0/qaPZ8flt7owY/Jvh5ZkBVDyJDazq3T
   pHoRzHVuLkFvEzpMA6IQGT/5xwxErRVeHcTsbi7ESbPALDyzkil/8HR0K
   HLLy2S6ctMuAt4By5R8e2Zp18/0hbtngIeYglfRXiRsBay9J/7XQ7AAv6
   TdD/6bnPeR0Y8D7prKoujY7sW4rFwRuK3d4BOEcXnSZFV6Jugzs51qMqL
   6hk7/3/PAHEU7yF0k7c7jKCpLpXDOeSFsAFOavTREsAShL0BODqHz7O65
   g==;
X-CSE-ConnectionGUID: L8/QBwydRHSlYikPYMe5Eg==
X-CSE-MsgGUID: xQI2a/STTYuNGWO72+wFZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73247475"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73247475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:07:13 -0800
X-CSE-ConnectionGUID: Q9X9IRVLS/mC//eGSTX1qQ==
X-CSE-MsgGUID: vT2WZnmiQpe48u/ASWnIcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215481080"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.86]) ([10.125.111.86])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:07:13 -0800
Message-ID: <fe586c59-e476-44ad-bc90-8fff386b0dbd@intel.com>
Date: Wed, 25 Feb 2026 08:07:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260224152809.1799199-1-den@valinux.co.jp>
 <eeae611a-d35f-44f1-a100-50a397ae3eb4@intel.com>
 <u7rapy5hbjkmc7wwxoxmgloz37z57q2ml5sjubmswsimqns4r7@mqget5wihsib>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <u7rapy5hbjkmc7wwxoxmgloz37z57q2ml5sjubmswsimqns4r7@mqget5wihsib>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kudzu.us,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-261004-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 517401993D9
X-Rspamd-Action: no action



On 2/24/26 8:36 PM, Koichiro Den wrote:
> On Tue, Feb 24, 2026 at 09:20:35AM -0700, Dave Jiang wrote:
>>
>>
>> On 2/24/26 8:28 AM, Koichiro Den wrote:
>>> Hi,
>>>
>>> ntb_netdev currently hard-codes a single NTB transport queue pair, which
>>> means the datapath effectively runs as a single-queue netdev regardless
>>> of available CPUs / parallel flows.
>>>
>>> The longer-term motivation here is throughput scale-out: allow
>>> ntb_netdev to grow beyond the single-QP bottleneck and make it possible
>>> to spread TX/RX work across multiple queue pairs as link speeds and core
>>> counts keep increasing.
>>>
>>> Multi-queue also unlocks the standard networking knobs on top of it. In
>>> particular, once the device exposes multiple TX queues, qdisc/tc can
>>> steer flows/traffic classes into different queues (via
>>> skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
>>> familiar way.
>>>
>>> This series is a small plumbing step towards that direction:
>>>
>>>   1) Introduce a per-queue context object (struct ntb_netdev_queue) and
>>>      move queue-pair state out of struct ntb_netdev. Probe creates queue
>>>      pairs in a loop and configures the netdev queue counts to match the
>>>      number that was successfully created.
>>>
>>>   2) Expose ntb_num_queues as a module parameter to request multiple
>>>      queue pairs at probe time. The value is clamped to 1..64 and kept
>>>      read-only for now (no runtime reconfiguration).
>>>
>>>   3) Report the active queue-pair count via ethtool -l (get_channels),
>>>      so users can confirm the device configuration from user space.
>>>
>>> Compatibility:
>>>   - Default remains ntb_num_queues=1, so behaviour is unchanged unless
>>>     the user explicitly requests more queues.
>>>
>>> Kernel base:
>>>   - ntb-next latest:
>>>     commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
>>>                           disable path")
>>>
>>> Usage (example):
>>>   - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
>>>   - ethtool -l <ifname> # Patch 3 takes care of it
>>>
>>> Patch summary:
>>>   1/3 net: ntb_netdev: Introduce per-queue context
>>>   2/3 net: ntb_netdev: Make queue pair count configurable
>>>   3/3 net: ntb_netdev: Expose queue pair count via ethtool -l
>>>
>>> Testing / results:
>>>   Environment / command line:
>>>     - 2x R-Car S4 Spider boards
>>>       "Kernel base" (see above) + this series
>>>     - For TCP load:
>>>       [RC] $ sudo iperf3 -s
>>>       [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
>>>     - For UDP load:
>>>       [RC] $ sudo iperf3 -s
>>>       [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4
>>>
>>>   Before (without this series):
>>>       TCP / UDP : 602 Mbps / 598 Mbps
>>>
>>>   Before (ntb_num_queues=1):
>>>       TCP / UDP : 588 Mbps / 605 Mbps
>>
>> What accounts for the dip in TCP performance?
> 
> I believe this is within normal run-to-run variance. To be sure, I repeated the
> TCP tests multiple times. The aggregated results are:
> 
>   +------+----------+------------------+------------------+
>   |      | Baseline | ntb_num_queues=1 | ntb_num_queues=2 |
>   +------+----------+------------------+------------------+
>   | Mean | 599.5    | 595.2 (-0.7%)    | 600.4 (+0.2%)    |
>   | Min  | 590      | 590   (+0.0%)    | 593   (+0.5%)    |
>   | Max  | 605      | 604   (-0.2%)    | 605   (+0.0%)    |
>   | Med  | 602      | 593              | 601.5            |
>   | SD   | 5.84     | 6.01             | 4.12             |
>   +------+----------+------------------+------------------+
> 
> On my setup (2x R-Car S4 Spider), I do not observe any statistically meaningful
> improvement or degradation. For completeness, here is the raw data:
> 
>               .----------------------------- Baseline (without this series)
>               :           .----------------- ntb_num_queues=1
>               :           :            .---- ntb_num_queues=2
>               :           :            :
>     #1     601 Mbps    604 Mbps     601 Mbps
>     #2     604 Mbps    604 Mbps     603 Mbps
>     #3     592 Mbps    590 Mbps     600 Mbps
>     #4     593 Mbps    593 Mbps     603 Mbps
>     #5     605 Mbps    591 Mbps     605 Mbps
>     #6     590 Mbps    603 Mbps     602 Mbps
>     #7     605 Mbps    590 Mbps     596 Mbps
>     #8     598 Mbps    594 Mbps     593 Mbps
>     #9     603 Mbps    590 Mbps     605 Mbps
>     #10    604 Mbps    593 Mbps     596 Mbps
> 
> To see a tangible performance gain, another patch series I submitted yesterday
> is also relevant:
> 
>   [PATCH 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
>   https://lore.kernel.org/all/20260224133459.1741537-1-den@valinux.co.jp/
> 
> With that series applied as well, and with irq smp_affinity properly adjusted,
> the results become:
> 
>   After (ntb_num_queues=2 + the other series also applied):
>       TCP / UDP : 1.15 Gbps / 1.18 Gbps
> 
> In that sense, that series is also important groundwork from a performance
> perspective. Since that work touches NTB-tree code, I'd appreciate it if you
> could also have a look at that series.
> 
> Side note: R-Car S4 Spider has limited BAR resources. Although BAR2 is
> resizable, ~2 MiB appears to be the practical ceiling for arbitrary mappings in
> this setup, so I haven't tested larger ntb_num_queues=<N> values. On platforms
> with more BAR space, sufficient CPUs for memcpy, or sufficent DMA channels for
> DMA memcpy available to ntb_transport, further scaling with larger <N> values
> should be possible.

Thanks for the data. I'll take a look at the other series.

> 
> Thanks,
> Koichiro
> 
>>
>>>
>>>   After (ntb_num_queues=2):
>>>       TCP / UDP : 602 Mbps / 598 Mbps
>>>
>>>   Notes:
>>>     In my current test environment, enabling multiple queue pairs does
>>>     not improve throughput. The receive-side memcpy in ntb_transport is
>>>     the dominant cost and limits scaling at present.
>>>
>>>     Still, this series lays the groundwork for future scaling, for
>>>     example once a transport backend is introduced that avoids memcpy
>>>     to/from PCI memory space on both ends (see the superseded RFC
>>>     series:
>>>     https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/).
>>>
>>>
>>> Best regards,
>>> Koichiro
>>>
>>> Koichiro Den (3):
>>>   net: ntb_netdev: Introduce per-queue context
>>>   net: ntb_netdev: Make queue pair count configurable
>>>   net: ntb_netdev: Expose queue pair count via ethtool -l
>>>
>>>  drivers/net/ntb_netdev.c | 326 +++++++++++++++++++++++++++------------
>>>  1 file changed, 228 insertions(+), 98 deletions(-)
>>>
>>
>> for the series
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>


