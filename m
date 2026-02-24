Return-Path: <netdev+bounces-260585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GLzNdrPnWn4SAQAu9opvQ
	(envelope-from <netdev+bounces-260585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:20:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99286189B81
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E893041CB4
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2B43A7857;
	Tue, 24 Feb 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmQTtrrP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F93A0E8D;
	Tue, 24 Feb 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950041; cv=none; b=s8VRWJ+okeJYXebwFa027EBWvswLxw5E5jKcRGrzu3NRPx+OV2/QQ3iLvEO/kXT1hsuQEYn2ZmLNi0/jPnshBNWRegvlapHWJsTD4fTt+PGcaDlz2lRLqa3MOL/4mg9zKIjjP6Xa2FlhWV2YYkK9oj07Vn5opGMRK1SrOLUGPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950041; c=relaxed/simple;
	bh=AG74mqohI+94lAChvyO+aHw5g67krqLgDL2MxnhW3/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNdtPlgSIaUlopmXbZsLG8Y2lfziOabVeRrOcWbwh2rgzMLyjZpXyvHtQTNHvfKCALPsce+4RF+CG0dipTzEd9bch+iL25fSb/KmyfcLyHG/PF7iPmQIG18B6Bow5EuAdzEm+btiQ5JySrOfaoPouNzYQsAh/Le2WFr3s6SzKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmQTtrrP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771950039; x=1803486039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AG74mqohI+94lAChvyO+aHw5g67krqLgDL2MxnhW3/o=;
  b=GmQTtrrPT7hD4E1xPjn0vjm0s/SN8TaI5B+03/kIECF46W9RVLQesZd7
   F+aM2WieuAjsfFWxf+2iR/22BuAeKAKfwFiy/9tJCZluuEbH+27cU3UXa
   xv0NWF4lZVMflRW110wF4GNZc7YIGSA3wzXXLtRUw5yh9aC5mxSN9sRNh
   eDsloe/wnO0xeSm2V20leVOD9MPfOcNFRFojy+iJO4Ia09XbuCm9b5IFb
   xY+NZANqCLq2hwXjkYLYWq8s/+gbyIywNpuhARwrzBr1CyLxdj6o0EdTu
   rVwSOlYOjL2ZSBwPZDSpAKlkH8sSwpngNCcM0fc4ssiuyy/lDN7zJCd5t
   Q==;
X-CSE-ConnectionGUID: lS7XMN2LQW+48FtjzpGajg==
X-CSE-MsgGUID: LLXcYdcxRBaakutd3B0fgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84429164"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="84429164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:20:39 -0800
X-CSE-ConnectionGUID: riJevkyhTF208GcOQM7oyw==
X-CSE-MsgGUID: NjU7LNEDSAO7gnzlQAuqXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253702695"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.22]) ([10.125.111.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 08:20:36 -0800
Message-ID: <eeae611a-d35f-44f1-a100-50a397ae3eb4@intel.com>
Date: Tue, 24 Feb 2026 09:20:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260224152809.1799199-1-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224152809.1799199-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[valinux.co.jp,kudzu.us,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-260585-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99286189B81
X-Rspamd-Action: no action



On 2/24/26 8:28 AM, Koichiro Den wrote:
> Hi,
> 
> ntb_netdev currently hard-codes a single NTB transport queue pair, which
> means the datapath effectively runs as a single-queue netdev regardless
> of available CPUs / parallel flows.
> 
> The longer-term motivation here is throughput scale-out: allow
> ntb_netdev to grow beyond the single-QP bottleneck and make it possible
> to spread TX/RX work across multiple queue pairs as link speeds and core
> counts keep increasing.
> 
> Multi-queue also unlocks the standard networking knobs on top of it. In
> particular, once the device exposes multiple TX queues, qdisc/tc can
> steer flows/traffic classes into different queues (via
> skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
> familiar way.
> 
> This series is a small plumbing step towards that direction:
> 
>   1) Introduce a per-queue context object (struct ntb_netdev_queue) and
>      move queue-pair state out of struct ntb_netdev. Probe creates queue
>      pairs in a loop and configures the netdev queue counts to match the
>      number that was successfully created.
> 
>   2) Expose ntb_num_queues as a module parameter to request multiple
>      queue pairs at probe time. The value is clamped to 1..64 and kept
>      read-only for now (no runtime reconfiguration).
> 
>   3) Report the active queue-pair count via ethtool -l (get_channels),
>      so users can confirm the device configuration from user space.
> 
> Compatibility:
>   - Default remains ntb_num_queues=1, so behaviour is unchanged unless
>     the user explicitly requests more queues.
> 
> Kernel base:
>   - ntb-next latest:
>     commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
>                           disable path")
> 
> Usage (example):
>   - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
>   - ethtool -l <ifname> # Patch 3 takes care of it
> 
> Patch summary:
>   1/3 net: ntb_netdev: Introduce per-queue context
>   2/3 net: ntb_netdev: Make queue pair count configurable
>   3/3 net: ntb_netdev: Expose queue pair count via ethtool -l
> 
> Testing / results:
>   Environment / command line:
>     - 2x R-Car S4 Spider boards
>       "Kernel base" (see above) + this series
>     - For TCP load:
>       [RC] $ sudo iperf3 -s
>       [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
>     - For UDP load:
>       [RC] $ sudo iperf3 -s
>       [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4
> 
>   Before (without this series):
>       TCP / UDP : 602 Mbps / 598 Mbps
> 
>   Before (ntb_num_queues=1):
>       TCP / UDP : 588 Mbps / 605 Mbps

What accounts for the dip in TCP performance?

> 
>   After (ntb_num_queues=2):
>       TCP / UDP : 602 Mbps / 598 Mbps
> 
>   Notes:
>     In my current test environment, enabling multiple queue pairs does
>     not improve throughput. The receive-side memcpy in ntb_transport is
>     the dominant cost and limits scaling at present.
> 
>     Still, this series lays the groundwork for future scaling, for
>     example once a transport backend is introduced that avoids memcpy
>     to/from PCI memory space on both ends (see the superseded RFC
>     series:
>     https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/).
> 
> 
> Best regards,
> Koichiro
> 
> Koichiro Den (3):
>   net: ntb_netdev: Introduce per-queue context
>   net: ntb_netdev: Make queue pair count configurable
>   net: ntb_netdev: Expose queue pair count via ethtool -l
> 
>  drivers/net/ntb_netdev.c | 326 +++++++++++++++++++++++++++------------
>  1 file changed, 228 insertions(+), 98 deletions(-)
> 

for the series
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


