Return-Path: <netdev+bounces-144246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9469C6493
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816D71F250B0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 22:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D027219C9E;
	Tue, 12 Nov 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fb9HEOOw"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AE219E5C
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452191; cv=none; b=YaegtaFokaDZAqXWpGiOB+U0rmzs6sClt+wILH7TxZMn9BapeEOt/nkrYcAMZVAxFBmv6UzUerN3VUwQvTjD/aI1A++BJqE8kIkC20InrKVSevi8y4aQdfj/AtJAwSnhyeGyLXL5+SAYXu5qEh582K0rhE2mcmOidxXJdtFGeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452191; c=relaxed/simple;
	bh=oJzhlBuHn1YLXMMDnaSfLL+TXKbLUA8gx3BOGBSu0XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YePm636Ct4RoSHxkG5j3cEtI6nVqVGYnvITilnzEHNsHVRk6k+CYoK2rksf6nXlMpbwcnZztzLvkTx0QWPoXuwufxKm5a9vzxp1r3dspPVyBaqEXWLQ2vRowk4Sj6tmO+B3CCKrFpRjI+B1VyaDtVhkz38Mlb2vvpsB1E9+8eKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fb9HEOOw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <955cb079-b58d-4c32-8925-74f596312b21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731452184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPMqV+lIh6LLpGZxlE7IJAAQFrS4D1/vz6OV9TCZZIY=;
	b=fb9HEOOwEDmhXyqJIkzybaVGqIUPo3nAWuPMZvVh7Ir2cBAR/eBwHwEivLV89cWFm1YGMt
	UJKdV9GNlvAlKe9lc+uaDSjhfmrh+XDMBnDMOedVCcmpPhbe38IRv/tWW7F7+PTBKYBO9Z
	viC9roTt5h+cpCpXR08TyYC3oqf6UPQ=
Date: Tue, 12 Nov 2024 22:56:19 +0000
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <53c8b505-f992-4c2e-b2c0-616152b447c3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 22:26, Andrew Lunn wrote:
>> I believe, the current design of mchp_ptp_clock has some issues:
>>
>> struct mchp_ptp_clock {
>>          struct mii_timestamper     mii_ts;             /*     0    48 */
>>          struct phy_device *        phydev;             /*    48     8 */
>>          struct sk_buff_head        tx_queue;           /*    56    24 */
>>          /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>>          struct sk_buff_head        rx_queue;           /*    80    24 */
>>          struct list_head           rx_ts_list;         /*   104    16 */
>>          spinlock_t                 rx_ts_lock          /*   120     4 */
>>          int                        hwts_tx_type;       /*   124     4 */
>>          /* --- cacheline 2 boundary (128 bytes) --- */
>>          enum hwtstamp_rx_filters   rx_filter;          /*   128     4 */
>>          int                        layer;              /*   132     4 */
>>          int                        version;            /*   136     4 */
>>
>>          /* XXX 4 bytes hole, try to pack */
>>
>>          struct ptp_clock *         ptp_clock;          /*   144     8 */
>>          struct ptp_clock_info      caps;               /*   152   184 */
>>          /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
>>          struct mutex               ptp_lock;           /*   336    32 */
>>          u16                        port_base_addr;     /*   368     2 */
>>          u16                        clk_base_addr;      /*   370     2 */
>>          u8                         mmd;                /*   372     1 */
>>
>>          /* size: 376, cachelines: 6, members: 16 */
>>          /* sum members: 369, holes: 1, sum holes: 4 */
>>          /* padding: 3 */
>>          /* last cacheline: 56 bytes */
>> };
>>
>> tx_queue will be splitted across 2 cache lines and will have spinlock on the
>> cache line next to `struct sk_buff * next`. That means 2 cachelines
>> will have to fetched to have an access to it - may lead to performance
>> issues.
>>
>> Another issue is that locks in tx_queue and rx_queue, and rx_ts_lock
>> share the same cache line which, again, can have performance issues on
>> systems which can potentially have several rx/tx queues/irqs.
>>
>> It would be great to try to reorder the struct a bit.
> 
> Dumb question: How much of this is in the hot patch? If this is only
> used for a couple of PTP packets per second, do we care about a couple
> of cache misses per second? Or will every single packet the PHY
> processes be affected by this?

Even with PTP packets timestamped only - imagine someone trying to run
PTP server part with some proper amount of clients? And it's valid to
configure more than 1 sync packet per second. It may become quite hot.


