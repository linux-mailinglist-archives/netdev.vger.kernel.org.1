Return-Path: <netdev+bounces-283127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGomOd1P9Gk/AgIAu9opvQ
	(envelope-from <netdev+bounces-283127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B34AAC27
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F32B1301027E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178133612D7;
	Fri,  1 May 2026 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Nt5je8PM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DQfrgHBC"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE226FDBF;
	Fri,  1 May 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777618907; cv=none; b=pxoXgKICLdaCw6pOTqMitb+SH+qr5z/kCnLGsHnJsBNSqx6sy7F97jsuIVUKVGuuO8i982JIFsmRVMrt3eIY1AXU7/Ww/Skvd4QAH1q1g3JWH143P5JqQLHXPWsOJ43XnmwocZqiqxQUqgsNes1/uZ46+8xV8sTTWQHKRzvJICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777618907; c=relaxed/simple;
	bh=mobtKgoIrzuVRGoKZpHynEqRbcV0KIKWQ+NNQDpKrB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcuKeM4dKDoymAxCPm4pQwuDGQ3kTYYNU9ofM40VAX/QlttdG4F3rVVPvc3PLGu0iSs8zn3fw9PenH1OF5Bd8U9cutSVGTMx4rtkpo6dnU0G3qpVsrl9TSMhf/uAg/h5x+RXSoQnl3+a2PZVb/gGOcX4iAi4fxegTW4MYGyn+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Nt5je8PM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DQfrgHBC; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777618903;
	bh=mobtKgoIrzuVRGoKZpHynEqRbcV0KIKWQ+NNQDpKrB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nt5je8PMJXmFymbMQcPawlOoLzRQ6loPGPmbeIjpjPaf1sDCz5FKDucjJK2v92jQI
	 mtAroSUp6tl0WQ31WcruvVJDgGdY3eVQgFkKI/1WxEY3nb06TGWimwUxXKhK5C31sn
	 oDpMarWDxYdq2/i50zwUsrCiTLH/SysyVWgLfstSEaJK6kZ3qgMyKv0mKKlBqDSIqk
	 Kd31PFMpNNBWOqLjn8N6UxGHPPVfx9pz3bLJht9F4+RoO65rNGyhwfCEvtC752COvi
	 vKBq7K9/8w7tpvJjF3Xea2ApAYbTvLKLE2ieoz1TMcfXd1aQzOlmi3ewQ14arckWtM
	 1ulJ/wEww8u+A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 82F5548272; Fri,  1 May 2026 07:01:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777618902;
	bh=mobtKgoIrzuVRGoKZpHynEqRbcV0KIKWQ+NNQDpKrB8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DQfrgHBCOoipSBjq8pFL8v2sHPBQXAGJcnzKaEo2Qb/kpdD9wygNzmLP7dzD2V9ty
	 CjMEG2ZNM5D6ZDBPrI0horNGg/BFzyXWfeTa8GfjtVxl1SZu1dkrNBt7wiKpS/KqgN
	 tQMBGwzFLTWWigjA3v+cuZhoRVdRVXKwcpQSdNYYH3vY3FnJgqoYI3iQEFNeRlk7X8
	 bMHMkpt80y0LF+oLWHxsXF6m2euAKteOfjsKxvuJD7uVWAr8ReQtxrrJ7mKOPzB7Co
	 wZBPvqJKlnSPAqE4zTBd+sEi4au1qrpAYcx9ZV/HDHDhDuE3/Xr5/Fu6YbcNzgKodl
	 TSfjYpipa2N/Q==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 46B9848207;
	Fri,  1 May 2026 07:01:42 +0000 (UTC)
Message-ID: <62fb1f24-b0cb-4310-a155-1f5cce14d83a@birger-koblitz.de>
Date: Fri, 1 May 2026 09:01:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Pecio <michal.pecio@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chih Kai Hsu <hsu.chih.kai@realtek.com>,
 Michal Pecio <michal.pecio@gmail.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
 <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
 <20260429200214.3e8dee67.michal.pecio@gmail.com>
 <4446ad8c-0f5f-4f5a-8166-557ce9cc91b7@birger-koblitz.de>
 <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <fac7da10-a2d3-4c14-9208-8762f38564cd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 608B34AAC27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,realtek.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Andrew,

thanks a lot for the explanation of the USB-IRQ handling, that was very 
valuable for my understanding!
On 30/04/2026 4:19 pm, Andrew Lunn wrote:
>> Also, I only see the issue on slow 5GBit USB-C connections, sometimes with
>> the RTL8157, basically every time with the RTL8159, and so far never on a
>> 20GBit USB-C connection, so the mitigation is probably some kind of
>> interrupt coalescing.
> 
> Do you notice any latency changes with this setting in place? Or CPU load.
> 
> ping can be a good measure for latency.
I do not see any differences in latency. I am using 2 desktop machines 
for testing:
Machine 1: 6-core, 20GBit USB-C, RTL8159, Completely idle desktop
Machine 2: 8-core, AQC107 on PCIe5x, Desktop with dev-tools and Browser

All measurements for CPU-load and timing are done on Machine 1, which 
runs the iperf3-client and ping against Machine 2. There is a direct 
10GBit CAT6 link without any switch in between the RTL8159 and AQC107.

Ping times, WITH mitigation CODE (saying it disables mitigation):
--- 192.168.3.1 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 101342ms
rtt min/avg/max/mdev = 0.161/0.411/1.267/0.231 ms

Ping times, WITHOUT mitigation-CODE (saying it disabled mitigation):
--- 192.168.3.1 ping statistics ---
150 packets transmitted, 150 received, 0% packet loss, time 152451ms
rtt min/avg/max/mdev = 0.165/0.388/1.048/0.236 ms

Results are identical within statistical errors.

However, there is a big difference in CPU-load when running iperf3, 
especially with multiple threads:

WITH the CODE saying it disables IRQ mitigation:
$ iperf3 -c 192.168.3.1
[  5] 0.00-10.00  sec  10.3 GBytes  8.83 Gbits/sec
CPU: iperf3 22.5% ksoftirqd 16.6%

$ iperf3 -c 192.168.3.1 -P4
[SUM]   0.00-10.00  sec  9.36 GBytes  8.04 Gbits/sec
perf3: 19.3% ksoftirqd 96.7%


WITHOUT the CODE saying it disabled IRQ mitigation:
[  5]   0.00-10.00  sec  10.3 GBytes  8.87 Gbits/sec
CPU: perf3 19.7% ksoftirqd 12.5%

$ iperf3 -c 192.168.3.1 -P4
[SUM]   0.00-10.00  sec  10.3 GBytes  8.81 Gbits/sec
CPU: iperf3 22.0% ksoftirqd 46.5%

> 
> If this is interrupt coalescing, it normally means don't interrupt as
> soon as one packet has been received. Delay the interrupt, so there
> are likely to be more packets in the receive queue. The cost of the
> interrupt handling is then spread over a number of packets.
> 
> If this register setting is disabling coalescing, you should see the
> latency go down, but the CPU load go up.
I see the latency staying the same, but the CPU load goes up 
considerably when these register settings are done.

> 
> If you are getting interrupts after the device has been disabled, i
> guess it is because the timer for a delayed interrupt is not cancelled
> by the firmware. If so you might be able to work around this firmware
> bug. Disable the receiver, sleep for 10ms but keep processing
> interrupts, and then continue with the tear down.
> 
My undestanding from the first email by Michal is that the behavior with 
the ESHUTOWN is actually harmless and has been seen in the driver 
already for the RTL8153.

So, my suggestion is I drop this part of the patch-series and remove the 
IRQ-mitigation code that says it disables the IRQ mitigation as 
performance is higher without that code. The issue with ESHUTDOWN in the 
URB handler is a mostly unrelated issue that is probably harmless and 
can be solved separately.

Birger


