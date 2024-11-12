Return-Path: <netdev+bounces-144248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25809C650A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E6B28393F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F621CF87;
	Tue, 12 Nov 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQCTXzfo"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20B21CF82
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453692; cv=none; b=V4Z1yxqKFWbSoJTSUWN2wwvvRApURi9ezhZNEu1kzrF9hBkFmcED/AZjDE7+XS0bigoUs1yZ0vPcI+R4czjPVpiWEvF3d803vAnpG65tyqr8RPGYFFRe7h+3lLFNw0YJ+cIX1NuSzjVjDK5Wq3pLdCMGmxYfYt9bTQ3yKH60LFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453692; c=relaxed/simple;
	bh=T/ebl/U5ZAKRHJn2gpf/9r0tbBg+eYcJtqGgYb1sByM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcR/1XYdIbEkYi1JrDeiSPk8MFFnAZ74jXSBsmsRkiJMUCcmda2MukqVj1dFwYx6uDUntzMQtXWLn5DS5hxaKGT5efBEPIDBZ4bTHVT0eCn7wMNlD798GQsvOC97IbxDVfg6o0GgrdhlCv40NBhff/Hfe5QWUBm7JWemh+K5ixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQCTXzfo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a6d2a96b-feea-4cf2-b49a-c2c82391599e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731453688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCzpCsVkjLt6UNdvDR5L5KILqw8LXple0VYgWj3YQBw=;
	b=rQCTXzfogUm6+I4Zd8EI7rIAurDCRvAHoy0f9Inf+EmU7P+ulgZn3zlpennFHg7Z7/MJax
	dfqR0k5UWct1leRlrtSicXdAl4skcWYuK1BKxI6TrpSDDG+pm4+1J96fdKmAU2rQmPEDBZ
	FOpA/m+x32j08NBhQxldJLrgXsnWhQg=
Date: Tue, 12 Nov 2024 23:21:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/5] net: phy: microchip_ptp : Add header file
 for Microchip ptp library
To: Andrew Lunn <andrew@lunn.ch>
Cc: Divya Koppera <divya.koppera@microchip.com>, arun.ramadoss@microchip.com,
 UNGLinuxDriver@microchip.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241112133724.16057-1-divya.koppera@microchip.com>
 <20241112133724.16057-2-divya.koppera@microchip.com>
 <37bba7bc-0d6f-4655-abd7-b6c86b12193a@linux.dev>
 <53c8b505-f992-4c2e-b2c0-616152b447c3@lunn.ch>
 <955cb079-b58d-4c32-8925-74f596312b21@linux.dev>
 <7e9e0964-6532-42e6-9005-18715aaac5a6@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <7e9e0964-6532-42e6-9005-18715aaac5a6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 23:11, Andrew Lunn wrote:
> On Tue, Nov 12, 2024 at 10:56:19PM +0000, Vadim Fedorenko wrote:
>> On 12/11/2024 22:26, Andrew Lunn wrote:
>>>> I believe, the current design of mchp_ptp_clock has some issues:
>>>>
>>>> struct mchp_ptp_clock {
>>>>           struct mii_timestamper     mii_ts;             /*     0    48 */
>>>>           struct phy_device *        phydev;             /*    48     8 */
>>>>           struct sk_buff_head        tx_queue;           /*    56    24 */
>>>>           /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>>>>           struct sk_buff_head        rx_queue;           /*    80    24 */
>>>>           struct list_head           rx_ts_list;         /*   104    16 */
>>>>           spinlock_t                 rx_ts_lock          /*   120     4 */
>>>>           int                        hwts_tx_type;       /*   124     4 */
>>>>           /* --- cacheline 2 boundary (128 bytes) --- */
>>>>           enum hwtstamp_rx_filters   rx_filter;          /*   128     4 */
>>>>           int                        layer;              /*   132     4 */
>>>>           int                        version;            /*   136     4 */
>>>>
>>>>           /* XXX 4 bytes hole, try to pack */
>>>>
>>>>           struct ptp_clock *         ptp_clock;          /*   144     8 */
>>>>           struct ptp_clock_info      caps;               /*   152   184 */
>>>>           /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
>>>>           struct mutex               ptp_lock;           /*   336    32 */
>>>>           u16                        port_base_addr;     /*   368     2 */
>>>>           u16                        clk_base_addr;      /*   370     2 */
>>>>           u8                         mmd;                /*   372     1 */
>>>>
>>>>           /* size: 376, cachelines: 6, members: 16 */
>>>>           /* sum members: 369, holes: 1, sum holes: 4 */
>>>>           /* padding: 3 */
>>>>           /* last cacheline: 56 bytes */
>>>> };
>>>>
>>>> tx_queue will be splitted across 2 cache lines and will have spinlock on the
>>>> cache line next to `struct sk_buff * next`. That means 2 cachelines
>>>> will have to fetched to have an access to it - may lead to performance
>>>> issues.
>>>>
>>>> Another issue is that locks in tx_queue and rx_queue, and rx_ts_lock
>>>> share the same cache line which, again, can have performance issues on
>>>> systems which can potentially have several rx/tx queues/irqs.
>>>>
>>>> It would be great to try to reorder the struct a bit.
>>>
>>> Dumb question: How much of this is in the hot patch? If this is only
>>> used for a couple of PTP packets per second, do we care about a couple
>>> of cache misses per second? Or will every single packet the PHY
>>> processes be affected by this?
>>
>> Even with PTP packets timestamped only - imagine someone trying to run
>> PTP server part with some proper amount of clients? And it's valid to
>> configure more than 1 sync packet per second. It may become quite hot.
> 
> I'm just thinking of Donald Knuth:
> 
> “The real problem is that programmers have spent far too much time
> worrying about efficiency in the wrong places and at the wrong times;
> premature optimization is the root of all evil (or at least most of
> it) in programming.”

It's hard to object to this argument :)
I might be influenced to much by the latest findings in bnxt_en
regarding bottlenecks in PTP processing..


