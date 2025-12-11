Return-Path: <netdev+bounces-244419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26485CB6D96
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28808301515E
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959631AF0A;
	Thu, 11 Dec 2025 18:01:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42134315F;
	Thu, 11 Dec 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476064; cv=none; b=ufXD0kyO2UCe2+M2ITA+D2Z2haWYxVcU5isVJOXO5FskyU1m+iPble40eg4o+iKp8J0aQ2o6Ebtkjq1ZNzvwOhR8jrGenWL/97OF0k79BjypXpbgg2FpBYDUBx38mjPgzH9eoctw30l/HNeL52pYSvflcvHlA3lqyCXRz1ImYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476064; c=relaxed/simple;
	bh=PS++sMG1fwJ+QPHdpS954kaaH9lvJIQIkKiIWMH85g8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=WYFKIW1W1m/GwdGmysYuX5oEpGWY2P+25yJfc9UzpcDWVDjMFbncUVLD/oBZIZA5gUqhNcB8xWpSDmvdUJRig/MwNx7E5l+3dDYHJKHeG/1jnRvoYMLoOTxwdwk0gX4RA6xUildlhiC3hvtASGA2WXl52FL0xQhoK7sH94Lc8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1vTky6-0004AI-1J;
	Thu, 11 Dec 2025 19:00:46 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1vTky5-000EXZ-2E;
	Thu, 11 Dec 2025 19:00:46 +0100
Message-ID: <2aca9aff-1d96-43fd-8125-290e7600915e@hetzner-cloud.de>
Date: Thu, 11 Dec 2025 19:00:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: sdn@hetzner-cloud.de
References: <672ab222-db78-4cad-821b-19256a7a4078@hetzner-cloud.de>
 <67a5ef2a-83bc-4b35-9eac-5b9297dfeb2d@intel.com>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
Subject: Re: [Intel-wired-lan] [BUG] ice: Temporary packet processing overload
 causes permanent RX drops
In-Reply-To: <67a5ef2a-83bc-4b35-9eac-5b9297dfeb2d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27847/Thu Dec 11 10:25:06 2025)

Am 09.12.25 um 01:05 schrieb Jacob Keller:
> On 12/5/2025 6:01 AM, Marcus Wichelmann wrote:
>> Hi there, I broke some network cards again. This time I noticed continuous RX packet drops with an Intel E810-XXV.
>>>> We have reproduced this with:
>>   Linux 6.8.0-88-generic (Ubuntu 24.04)
>>   Linux 6.14.0-36-generic (Ubuntu 24.04 HWE)
>>   Linux 6.18.0-061800-generic (Ubuntu Mainline PPA)
> 
> I think we recently merged a bunch of work on the Rx path as part of our
> conversion to page pool. It would be interesting to see if those changes
> impact this. Clearly the issue goes back some time since v6.8 at least..
Hi Jacob,

I guess you mean 93f53db9f9dc ("ice: switch to Page Pool")?

I have now repeated all tests with a kernel built from latest net-next
branch and can still reproduce it, even though I needed way higher packet
rates (15 instead of 4 Mpps when using 256 channels). Something about the
packet processing on our test system seems to have gotten way more
efficient with this kernel update.

The symptoms are the same. The following IO_PAGE_FAULTs appear in the
kernel log and after that, there is a permanent packet loss of 1-10%
even at very low packet rates.

  kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
  kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
  kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
  kernel: ice 0000:c7:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002b address=0x4000180000 flags=0x0020]
  kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
  kernel: ice 0000:c7:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002c address=0x4000180000 flags=0x0020]
  [...]
  kernel: ice 0000:c7:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x002c address=0x4000180000 flags=0x0020]
  kernel: amd_iommu_report_page_fault: 10 callbacks suppressed
  [...]

I experimented with a few different channel counts and noticed that
the issue only occurs with a combined channel count >128. So on
systems with less many CPU cores, this bug probably never occurs.

  256: reproduced.
  254: reproduced.
  200: reproduced.
  129: reproduced.
  128: stable.
   64: stable.

Tested using "ethtool -L eth{0,1} combined XXX".

With <=128 channels, only the "... hogged CPU ..." warnings appear
but no IO_PAGE_FAULTs. There is also no permanent packet loss after
stopping the traffic generator.

>> [...]
>>
>> 3. Stop the traffic generator and re-run it with a way lower packet rate, e.g. 10.000 pps. Now it can be seen that
>> a good part of these packets is being dropped, even though the kernel could easily keep up with this small packet rate.
> 
> I assume the rx_dropped counter still incrementing here?

Yes. After the NIC is in this broken state, a few percent of all
packets is being dropped and the rx_dropped counter increases
with each of them.

>> [...]

I also looked into why the packet processing load on this system
is so high and `perf top` shows that it almost completely
originates from native_queued_spin_lock_slowpath.

When digging deeper using `perf lock contention -Y spinlock`:

 contended   total wait     max wait     avg wait         type   caller
   1724043      4.36 m     198.66 us    151.66 us     spinlock   __netif_receive_skb_core.constprop.0+0x832
     35960      2.51 s     112.57 ms     69.51 us     spinlock   __netif_receive_skb_core.constprop.0+0x832
       620    103.79 ms    189.87 us    167.40 us     spinlock   do_sys_poll+0x26f

I'm not yet sure what is causing this.
I don't think it's related to this issue, but maybe that's part of
what brings this bug to daylight, so probably still worth a mention.

I hope you can make some sense of all that.

Thanks,
Marcus

