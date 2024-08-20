Return-Path: <netdev+bounces-120318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA827958EFE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DF28504C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC7152532;
	Tue, 20 Aug 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X3JANH2n"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38618E37E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184175; cv=none; b=vBCBzPsU653mymvj032BuVNYjb3K+ySIKhaskpO/fkIhM0ucvQwthxrNdYT8zW0lqDUottisG/jeXj+NRTHA5TaxwuYioxx7Fej+U22xqWzXHSUBYAI6fB6WPJ7PJPQlXZmmMI9YKF0t592JW1JzAh1zGlqJoNPzS2CSV5tg2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184175; c=relaxed/simple;
	bh=GNtqUA7xiKx52NKreqjOI2Wa3/fykoaR+q4UKI0lZUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3q+yu/oAh1it3J0ncgtkZXDW5rU12omCCMElVnOb1wwjCbRn8j+unSh0QDpIpAOv1w0FImdZvWQ8GBfwuez902ngnvFQbC55Mm2nim0RpPdHwKAv98FNRsRtHJh0WEi7/5He84xnQ9H3j1Qea38USCl+J07owaNHGxHSVDOxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X3JANH2n; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7f66966-f97a-4890-b452-2a8a5e20b953@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724184170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+Xnac8NFnrgWa0w+0I5z9TRviIwR6516HIJjJX2blg=;
	b=X3JANH2niWLsnw+n9r57hQETNGwH4SMKfpkCKDR9GwL/wwRNW1n+SmZTS5AFKhSQFWJkqb
	VozSK/e6POx05Q1RdVGjqjIZK0fcqa7bYCwmlebB0pV8MmBtE81PwTb5NoeOQCB8TS7Hox
	D8LgaGNzJHek9Gr9WqghmJlApUBgQhg=
Date: Tue, 20 Aug 2024 16:02:45 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics
 support
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Katakam, Harini" <harini.katakam@amd.com>
References: <20240820175343.760389-1-sean.anderson@linux.dev>
 <20240820175343.760389-3-sean.anderson@linux.dev>
 <MN0PR12MB5953C46BA150B0382F222534B78D2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB5953C46BA150B0382F222534B78D2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/24 15:04, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, August 20, 2024 11:24 PM
>> To: Andrew Lunn <andrew@lunn.ch>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; netdev@vger.kernel.org
>> Cc: Simek, Michal <michal.simek@amd.com>; linux-kernel@vger.kernel.org;
>> Russell King <linux@armlinux.org.uk>; David S . Miller
>> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Eric Dumazet <edumazet@google.com>; Simon
>> Horman <horms@kernel.org>; linux-arm-kernel@lists.infradead.org; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH net-next v4 2/2] net: xilinx: axienet: Add statistics support
>> 
>> Add support for reading the statistics counters, if they are enabled.
>> The counters may be 64-bit, but we can't detect this statically as
>> there's no ability bit for it and the counters are read-only. Therefore,
>> we assume the counters are 32-bits by default. To ensure we don't miss
> 
> Any reason why we can't have DT property to detect if stats counter
> are configured as 32-bit /64bit? The IP export CONFIG.Statistics_Width
> and device tree generator can read this IP block property and populate 
> stats width property.

Mainly simplicity:

- We need the functions to work with 32-bit counters anyway
- We can always treat 64-bit counters are 32-bit counters
- The reset issue below necessitates keeping track of a "base"
  anyway.

And for my devicetrees (generated with 2022.2) all I get is 

xlnx,stats = <0x1>;

regardless of whether I select 32- or 64-bit counters. So this wouldn't
be something we could reuse from existing devictrees.

>> an overflow, we read all counters at 13-second intervals. This should be
>> often enough to ensure the bytes counters don't wrap at 2.5 Gbit/s.
>> 
>> Another complication is that the counters may be reset when the device
>> is reset (depending on configuration). To ensure the counters persist
>> across link up/down (including suspend/resume), we maintain our own
>> versions along with the last counter value we saw. Because we might wait
> 
> Is that a standard convention to retain/persist counter values across 
> link up/down?

IEEE 802.3 section 30.2.1 says

| All counters defined in this specification are assumed to be
| wrap-around counters. Wrap-around counters are those that
| automatically go from their maximum value (or final value) to zero and
| continue to operate. These unsigned counters do not provide for any
| explicit means to return them to their minimum (zero), i.e., reset.

And get_eth_mac_stats implements these counters for Linux. So I would
say that resetting the counters on link up/down would be non-conformant.

Other drivers also preserve stats across link up/down. For example,
MACB/GEM doesn't reset it stats either. And keeping the stats is also
more friendly for users and monitoring tools.

---

If you happen to have an ear with the RTL designers, I would say that
saturating, clear-on-read counters would be much easier to work with in
software.

--Sean

>> up to 100 ms for the reset to complete, we use a mutex to protect
>> writing hw_stats. We can't sleep in ndo_get_stats64, so we use a seqlock
>> to protect readers.
>> 
>> We don't bother disabling the refresh work when we detect 64-bit
>> counters. This is because the reset issue requires us to read
>> hw_stat_base and reset_in_progress anyway, which would still require the
>> seqcount. And I don't think skipping the task is worth the extra
>> bookkeeping.
>> 
>> We can't use the byte counters for either get_stats64 or
>> get_eth_mac_stats. This is because the byte counters include everything
>> in the frame (destination address to FCS, inclusive). But
>> rtnl_link_stats64 wants bytes excluding the FCS, and
>> ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
>> length/type). It might be possible to calculate the byte values Linux
>> expects based on the frame counters, but I think it is simpler to use
>> the existing software counters.
>> 
>> get_ethtool_stats is implemented for nonstandard statistics. This
>> includes the aforementioned byte counters, VLAN and PFC frame
>> counters, and user-defined (e.g. with custom RTL) counters.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

--Sean

